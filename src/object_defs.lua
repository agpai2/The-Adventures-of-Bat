--[[
    The Adventures of Bat

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

-- these are the objects that will be rendered in the game
OBJECT_IDS = {
    'coin', 'obstacle'
}

OBJECT_DEFS = {
    ['coin'] = {
        animations = {
            ['rotate'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.15,
                texture = 'coins'
            }
        }
    },
    ['obstacle'] = {
        animations = {
            ['animate'] = {
                frames = {1, 2, 3, 4, 5},
                interval = 0.15,
                texture = 'obstacles'
            }
        }
    }
}
