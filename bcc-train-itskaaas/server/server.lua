VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()

local discord = BccUtils.Discord.setup(Config.webhookLink, Config.webhookTitle, Config.WebhookAvatar)

local ActiveTrains = {}

TrainSpawned = false
TrainEntity = nil
BridgeDestroyed = false

local LockpickAttempts = {}

local TrainRobberyAlert = exports['bcc-job-alerts']:RegisterAlert({
    name = 'train_robbery',
    message = "Estão roubando um trem!",
    jobs = {"USM"},
    jobgrade = {
        USM = {0,1,2,3,4,5,6,7,8,9,10,11,12}
    },
    icon = "star",
    color = 'COLOR_RED',
    texturedict = "generic_textures",
    hash = -1282792512,
    radius = 50.0,
    blipTime = 60000,
    blipDelay = 0,
    messageTime = 40000
})

VORPcore.Callback.Register('bcc-train:JobCheck', function(source, cb, station)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local charJob = Character.job
    local jobGrade = Character.jobGrade
    if not charJob then
        cb(false)
        return
    end
    local hasJob = false
    hasJob = CheckPlayerJob(charJob, jobGrade, station)
    if hasJob then
        cb(true)
    else
        cb(false)
    end
end)

function CheckPlayerJob(charJob, jobGrade, station)
    for _, job in pairs(Stations[station].shop.jobs) do
        if (charJob == job.name) and (tonumber(jobGrade) >= tonumber(job.grade)) then
            return true
        end
    end
end

VORPcore.Callback.Register('bcc-train:CheckTrainSpawn', function(source, cb)
    if TrainSpawned then
        cb(false)
    else
        cb(true)
    end
end)

RegisterServerEvent('bcc-train:UpdateTrainSpawnVar', function(spawned, netId, id, coords)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    if spawned then
        TrainSpawned = true
        TrainEntity = NetworkGetEntityFromNetworkId(netId)
        table.insert(ActiveTrains, {netId = netId, id = id})
        exports.vorp_inventory:registerInventory({
            id = 'bcc-train-inventory-' .. id,
            name = _U('trainInv'),
            limit = 100,
            acceptWeapons = true,
            shared = true,
            ignoreItemStackLimit = true,
            whitelistItems = false,
            UsePermissions = false,
            UseBlackList = false,
            whitelistWeapons = false
        })
        discord:sendMessage(
            _U('trainSpawnedwebMain') ..
            _U('charNameWeb') ..
            Character.firstname ..
            " " ..
            Character.lastname ..
            _U('charIdentWeb') ..
            Character.identifier ..
            _U('charIdWeb') ..
            Character.charIdentifier)
    else
        TrainSpawned = false
        TrainEntity = nil
        for i, train in ipairs(ActiveTrains) do
            if train.id == id then
                table.remove(ActiveTrains, i)
                break
            end
        end
        discord:sendMessage(
            _U('trainNotSpawnedWeb') ..
            _U('charNameWeb') ..
            Character.firstname .. " " ..
            Character.lastname ..
            _U('charIdentWeb') ..
            Character.identifier ..
            _U('charIdWeb') ..
            Character.charIdentifier)
    end
end)

RegisterServerEvent('bcc-train:OpenInventory', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local charJob = Character.job
    local jobGrade = Character.jobGrade
    local hasConductorJob = false
    if charJob == 'conductor' and tonumber(jobGrade) >= 0 then
        hasConductorJob = true
    end

    local playerCoords = GetEntityCoords(GetPlayerPed(_source))
    local closestTrain = nil
    local closestDist = 999
    for _, train in ipairs(ActiveTrains) do
        local entity = NetworkGetEntityFromNetworkId(train.netId)
        if DoesEntityExist(entity) then
            local dist = #(playerCoords - GetEntityCoords(entity))
            if dist < closestDist then
                closestDist = dist
                closestTrain = train
            end
        end
    end
    if closestTrain and closestDist <= 5 then
        if hasConductorJob then
            exports.vorp_inventory:openInventory(_source, 'bcc-train-inventory-' .. closestTrain.id)
        else
            local itemCount = exports.vorp_inventory:getItemCount(_source, nil, 'lockpick')
            if itemCount >= 1 then
                LockpickAttempts[_source] = (LockpickAttempts[_source] or 0) + 1
                if LockpickAttempts[_source] == 3 then
                    exports.vorp_inventory:subItem(_source, 'lockpick', 1)
                    VORPcore.NotifyRightTip(_source, _U('lockpickBroke'), 4000)
                    LockpickAttempts[_source] = 0
                end
                VORPcore.NotifyRightTip(_source, 'Tentando abrir o baú do trem!', 4000)
                TriggerClientEvent('bcc-train:StartLockpick', _source, closestTrain.id)
            else
                VORPcore.NotifyRightTip(_source, _U('noItem'), 4000)
            end
        end
    end
end)

RegisterServerEvent('bcc-train:OpenInventoryAfterLockpick', function(trainId)
    local _source = source
    exports.vorp_inventory:openInventory(_source, 'bcc-train-inventory-' .. trainId)
    TrainRobberyAlert:SendAlert(_source)
end)

VORPcore.Callback.Register('bcc-train:GetMyTrains', function(source, cb)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local myTrains = MySQL.query.await('SELECT * FROM train WHERE `charidentifier` = ?', { Character.charIdentifier })
    if myTrains then
        cb(myTrains)
    else
        cb(nil)
    end
end)

RegisterServerEvent('bcc-train:BuyTrain', function(trainCfg)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    if Character.money >= trainCfg.price then
        MySQL.query.await('INSERT INTO train (`charidentifier`, `trainModel`, `fuel`, `condition`) VALUES (?, ?, ?, ?)',
        { Character.charIdentifier, trainCfg.model, trainCfg.fuel.maxAmount, trainCfg.condition.maxAmount })

        Character.removeCurrency(0, trainCfg.price)
        VORPcore.NotifyRightTip(_source, _U('trainBought'), 4000)
        discord:sendMessage(
            _U('charNameWeb') ..
            Character.firstname ..
            " " ..
            Character.lastname ..
            _U('charIdentWeb') ..
            Character.identifier ..
            _U('charIdWeb') ..
            Character.charIdentifier ..
            _U('boughtTrainWeb') ..
            trainCfg.model ..
            _U('charPriceWeb') ..
            trainCfg.price)
    else
        VORPcore.NotifyRightTip(_source, _U('notEnoughMoney'), 4000)
    end
end)

VORPcore.Callback.Register('bcc-train:SellTrain', function(source, cb, data)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local trainModel = data.trainModel
    MySQL.query.await('DELETE FROM train WHERE charidentifier = ? AND trainid = ?', {Character.charIdentifier, data.trainid})

    for _, trainCfg in pairs(Trains) do
        if trainCfg.model == trainModel then
            local sellPrice = math.floor(Config.sellPrice * trainCfg.price)
            Character.addCurrency(0, sellPrice)
            VORPcore.NotifyRightTip(_source, _U('soldTrain') .. sellPrice, 4000)
            discord:sendMessage(
                _U('charNameWeb') ..
                Character.firstname ..
                " " ..
                Character.lastname ..
                _U('charIdentWeb') ..
                Character.identifier ..
                _U('charIdWeb') ..
                Character.charIdentifier ..
                _U('soldTrainWeb') ..
                trainCfg.model ..
                _U('charPriceWeb') ..
                sellPrice)
            break
        end
    end
    cb(true)
end)

VORPcore.Callback.Register('bcc-train:DecTrainFuel', function(source, cb, trainid, trainFuel, trainCfg)
    local newFuel = trainFuel - trainCfg.fuel.decreaseAmount
    MySQL.query.await('UPDATE train SET `fuel` = ? WHERE `trainid` = ?', { newFuel, trainid })
    cb(newFuel)
end)

VORPcore.Callback.Register('bcc-train:DecTrainCond', function(source, cb, trainid, trainCondition, trainCfg)
    local newCondition = trainCondition - trainCfg.condition.decreaseAmount
    MySQL.query.await('UPDATE train SET `condition` = ? WHERE `trainid` = ?', { newCondition, trainid })
    cb(newCondition)
end)

VORPcore.Callback.Register('bcc-train:FuelTrain', function(source, cb, trainId, trainFuel, trainCfg)
    local _source = source
    local maxFuel = trainCfg.fuel.maxAmount
    if trainFuel >= maxFuel then
        VORPcore.NotifyRightTip(_source, _U('noFuelNeeded'), 4000)
        cb(nil)
        return
    end
    local itemCount = exports.vorp_inventory:getItemCount(_source, nil, Config.fuel.item)
    if itemCount >= trainCfg.fuel.itemAmount then
        exports.vorp_inventory:subItem(_source, Config.fuel.item, trainCfg.fuel.itemAmount)
        MySQL.query.await('UPDATE train SET `fuel` = ? WHERE `trainid` = ?', { maxFuel, trainId })
        VORPcore.NotifyRightTip(_source, _U('fuelAdded'), 4000)
        cb(maxFuel)
    else
        VORPcore.NotifyRightTip(_source, _U('noItem'), 4000)
        cb(nil)
    end
end)

VORPcore.Callback.Register('bcc-train:RepairTrain', function(source, cb, trainId, trainCondition, trainCfg)
    local _source = source
    local maxCondition = trainCfg.condition.maxAmount
    if trainCondition >= maxCondition then
        VORPcore.NotifyRightTip(_source, _U('noRepairsNeeded'), 4000)
        cb(nil)
        return
    end
    local itemCount = exports.vorp_inventory:getItemCount(_source, nil, Config.condition.item)
    if itemCount >= trainCfg.condition.itemAmount then
        exports.vorp_inventory:subItem(_source, Config.condition.item, trainCfg.condition.itemAmount)
        MySQL.query.await('UPDATE train SET `condition` = ? WHERE `trainid` = ?', { maxCondition, trainId })
        VORPcore.NotifyRightTip(_source, _U('trainRepaired'), 4000)
        cb(maxCondition)
    else
        VORPcore.NotifyRightTip(_source, _U('noItem'), 4000)
        cb(nil)
    end
end)

RegisterServerEvent('bcc-train:BridgeFallHandler', function(freshJoin)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    if not freshJoin then
        local itemCount = exports.vorp_inventory:getItemCount(_source, nil, Config.bacchusBridge.item)
        if itemCount >= Config.bacchusBridge.itemAmount then
            if not BridgeDestroyed then
                exports.vorp_inventory:subItem(_source, Config.bacchusBridge.item, Config.bacchusBridge.itemAmount)
                BridgeDestroyed = true
                VORPcore.NotifyRightTip(_source, _U('runFromExplosion') .. Config.bacchusBridge.timer .. _U('seconds'), 4000)
                Wait(Config.bacchusBridge.timer * 1000)
                discord:sendMessage(
                    _U('charNameWeb') ..
                    Character.firstname ..
                    " " ..
                    Character.lastname ..
                    _U('charIdentWeb') ..
                    Character.identifier ..
                    _U('charIdWeb') ..
                    Character.charIdentifier ..
                    _U('bacchusDestroyedWebhook')
                )
                BccUtils.Discord.sendMessage(Config.webhookLink, Config.webhookTitle, Config.webhookAvatar, _U('bacchusDestroyedWebhook'), '')
                TriggerClientEvent('bcc-train:BridgeFall', -1) --triggers for all clients
            end
        else
            VORPcore.NotifyRightTip(_source, _U('noItem'), 4000)
        end
    else
        if BridgeDestroyed then
            TriggerClientEvent('bcc-train:BridgeFall', _source) --triggers for new client
        end
    end
end)

RegisterServerEvent('bcc-train:DeliveryPay', function(destination)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    Character.addCurrency(0, destination.pay)
    discord:sendMessage(
        _U('charNameWeb') ..
        Character.firstname ..
        " " ..
        Character.lastname ..
        _U('charIdentWeb') ..
        Character.identifier ..
        _U('charIdWeb') ..
        Character.charIdentifier ..
        _U('paidDeliveryWeb') ..
        destination.pay)
end)

local CooldownData = {}
RegisterServerEvent('bcc-train:SetPlayerCooldown', function(mission)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    CooldownData[mission .. tostring(Character.charIdentifier)] = os.time()
end)

VORPcore.Callback.Register('bcc-train:CheckPlayerCooldown', function(source, cb, mission)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local cooldown = Config.cooldown[mission]
    local onList = false
    local missionId = mission .. tostring(Character.charIdentifier)
    for id, time in pairs(CooldownData) do
        if id == missionId then
            onList = true
            if os.difftime(os.time(), time) >= cooldown * 60 then
                cb(false) -- Not on Cooldown
                break
            else
                cb(true)
                break
            end
        end
    end
    if not onList then
        cb(false)
    end
end)



-- Check if properly downloaded
function file_exists(name)
  local f = LoadResourceFile(GetCurrentResourceName(), name)
  return f ~= nil
end

if not file_exists('./ui/index.html') then
  print('^1 INCORRECT DOWNLOAD!  ^0')
  print(
    '^4 Please Download: ^2(bcc-train.zip) ^4from ^3<https://github.com/BryceCanyonCounty/bcc-train/releases/latest>^0')
end

BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-train')