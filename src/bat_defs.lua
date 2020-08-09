--[[
    The Adventures of Bat

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

-- these are the different type of bats that will rendered in the game
BAT_IDS = {
    'blue-bat', 'red-bat'
}

BAT_DEFS = {
    ['blue-bat'] = {
        animations = {
            ['fly-left'] = {
                frames = {10, 11, 12},
                interval = 0.15,
                texture = 'blue-bat'
            },
            ['fly-right'] = {
                frames = {4, 5, 6},
                interval = 0.15,
                texture = 'blue-bat'
            },
            ['fly-front'] = {
                frames = {7, 8, 9},
                interval = 0.15,
                texture = 'blue-bat'
            },
            ['fly-back'] = {
                frames = {1, 2, 3},
                interval = 0.15,
                texture = 'blue-bat'
            }
        }
    },
    ['red-bat'] = {
          animations = {
            ['fly-left'] = {
                frames = {10, 11, 12},
                interval = 0.15,
                texture = 'red-bat'
            },
            ['fly-right'] = {
                frames = {4, 5, 6},
                interval = 0.15,
                texture = 'red-bat'
            },
            ['fly-front'] = {
                frames = {7, 8, 9},
                interval = 0.15,
                texture = 'red-bat'
            },
            ['fly-back'] = {
                frames = {1, 2, 3},
                interval = 0.15,
                texture = 'red-bat'
            }
        }
    }
}
