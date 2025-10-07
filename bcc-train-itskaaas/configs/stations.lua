-----------------------------------------------------
-- Train Station Config
-----------------------------------------------------
Stations = {
    valentine = {
        shop = {
            name     = 'Estação de Valentine',             -- Name of Station on Menu Header
            prompt   = 'Estação de Valentine',             -- Text Below the Menu Prompt Button
            distance = 2.0,                             -- Distance Between Player and Station to Show Menu Prompt
            jobsEnabled = true,                         -- Allow Access to Specified Jobs Only
            jobs     = {                                -- Allowed Jobs - ex. jobs = {{name = 'police', grade = 1},{name = 'doctor', grade = 3}}
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,                         -- Station uses Open and Closed Hours
                open   = 7,                             -- Station Open Time / 24 Hour Clock
                close  = 21                             -- Station Close Time / 24 Hour Clock
            }
        },
        blip = {
            show   = true,                              -- Show Blip On Map
            showClosed = true,                          -- Show Blip On Map when Closed
            name   = 'Estação de Valentine',               -- Name of Blip on Map
            sprite = 1258184551,                        -- Default: 1258184551
            color  = {
                open   = 'WHITE',                       -- Station Open - Default: White - Blip Colors Shown Below
                closed = 'RED',                         -- Station Closed - Deafault: Red - Blip Colors Shown Below
                job    = 'YELLOW_ORANGE'                -- Station Job Locked - Default: Yellow - Blip Colors Shown Below
            }
        },
        npc = {
            active   = true,                            -- Turns NPC On / Off
            model    = 's_m_m_sdticketseller_01',       -- Model Used for NPC
            coords   = vector3(-172.9, 629.79, 114.03), -- NPC and Station Blip Positions
            heading  = 228.81,                          -- NPC Heading
            distance = 100                              -- Distance Between Player and Station for NPC to Spawn
        },
        train = {
            coords  = vector3(-163.78, 628.17, 113.52), -- Make Sure the Coord Here is Directly on Top of the Track You Want the Train to Spawn On!
            outWest = false,                            -- Set false if This is Not in the Desert/Western Part of the Map
        }
    },
    -----------------------------------------------------

    emerald = {
        shop = {
            name     = 'Estação de Emerald',
            prompt   = 'Estação de Emerald',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Emerald',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(1525.18, 442.51, 90.68),
            heading  = 270.86,
            distance = 100
        },
        train = {
            coords  = vector3(1529.67, 442.54, 90.22),
            outWest = false,
        }
    },
    -----------------------------------------------------

    flatneck = {
        shop = {
            name     = 'Estação de Flatneck',
            prompt   = 'Estação de Flatneck',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Flatneck',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-335.89, -361.2, 88.08),
            heading  = 115.48,
            distance = 100
        },
        train = {
            coords  = vector3(-339.0, -350.0, 87.81),
            outWest = false,
        }
    },
    -----------------------------------------------------

    rhodes = {
        shop = {
            name     = 'Estação de Rhodes',
            prompt   = 'Estação de Rhodes',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Rhodes',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(1225.77, -1296.45, 76.9),
            heading  = 271.52,
            distance = 100
        },
        train = {
            coords  = vector3(1226.74, -1310.03, 76.47),
            outWest = false,
        }
    },
    -----------------------------------------------------

    stdenis = {
        shop = {
            name     = 'Estação de Saint Denis',
            prompt   = 'Estação de Saint Denis',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Saint Denis',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(2747.5, -1398.89, 46.18),
            heading  = 74.02,
            distance = 100
        },
        train = {
            coords  = vector3(2770.08, -1414.51, 45.98),
            outWest = false,
        }
    },
    -----------------------------------------------------

    annesburg = {
        shop = {
            name     = 'Estação Annesburg',
            prompt   = 'Estação Annesburg',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação Annesburg',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(2938.98, 1282.05, 44.65),
            heading  = 89.44,
            distance = 100
        },
        train = {
            coords  = vector3(2957.25, 1281.58, 43.95),
            outWest = false,
        }
    },
    -----------------------------------------------------

    bacchus = {
        shop = {
            name     = 'Estação de Bacchus',
            prompt   = 'Estação de Bacchus',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Bacchus',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(582.49, 1681.07, 187.79),
            heading  = 315.88,
            distance = 100
        },
        train = {
            coords  = vector3(581.14, 1691.8, 187.6),
            outWest = false,
        }
    },
    -----------------------------------------------------

    wallace = {
        shop = {
            name     = 'Estação de Wallace',
            prompt   = 'Estação de Wallace',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Wallace',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-1307.86, 395.86, 95.38),
            heading  = 61.95,
            distance = 100
        },
        train = {
            coords  = vector3(-1307.62, 406.83, 94.98),
            outWest = false,
        }
    },
    -----------------------------------------------------

    riggs = {
        shop = {
            name     = 'Estação de Riggs',
            prompt   = 'Estação de Riggs',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Riggs',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-1096.58, -575.92, 82.41),
            heading  = 8.67,
            distance = 100
        },
        train = {
            coords  = vector3(-1097.07, -583.71, 81.67),
            outWest = false,
        }
    },
    -----------------------------------------------------

    armadillo = {
        shop = {
            name     = 'Estação de Armadillo',
            prompt   = 'Estação de Armadillo',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Armadillo',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-3733.71, -2602.73, -12.92),
            heading  = 75.7,
            distance = 100
        },
        train = {
            coords  = vector3(-3748.85, -2600.8, -13.72),
            outWest = true,
        }
    },
    -----------------------------------------------------

    benedict = {
        shop = {
            name     = 'Estação de Benedict',
            prompt   = 'Estação de Benedict',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Estação de Benedict',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-5230.56, -3470.81, -20.57),
            heading  = 88.7,
            distance = 100
        },
        train = {
            coords  = vector3(-5235.54, -3473.3, -21.25),
            outWest = true,
        }
    }
}