--[[
    The Adventures of Bat

    -- EndState Class --

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

EndState = Class{__includes = BaseState}

function EndState:init()
    self.background = Background()
end

function EndState:enter(params)
    self.background.backgroundFrame = params.backgroundFrame

    self.bat = Bat({
        type = params.batType,
        animations = BAT_DEFS[BAT_IDS[params.batType]].animations,
        isPlay = false,
        direction = 'front',
        x = VIRTUAL_WIDTH / 2 - 16,
        y = VIRTUAL_HEIGHT / 2 - 35,
        width = 32,
        height = 32
    })
    self.bat:changeAnimation('fly-' .. self.bat.direction)

    self.menu = {
        [1] = {
            description = 'DISTANCE: ' .. params.distance,
            yOffset = 0
        },
        [2] = {
            description = 'COINS: ' .. params.coins,
            yOffset = 10
        },
        [3] = {
            description = 'TOTAL SCORE: ' .. params.distance + params.coins,
            yOffset = 20
        },
        [4] = {
            description = 'PRESS ENTER TO CONTINUE',
            yOffset = 50
        }
    }

end

function EndState:update(dt)
    self.background:update(dt)
    self.bat:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()
        gStateMachine:change('start')
    end
end

function EndState:render()
    self.background:render()
    self.bat:render()

    -- simple UI code
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('GAME OVER', 0, 10, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])

    for i = 1, 4 do
      if i == 4 then
          love.graphics.setColor(103, 255, 255, 255)
      end

      love.graphics.printf(self.menu[i].description, 0,
          VIRTUAL_HEIGHT / 2 + self.menu[i].yOffset, VIRTUAL_WIDTH, 'center')
          
      -- reset the color
      love.graphics.setColor(255, 255, 255, 255)
    end
end
