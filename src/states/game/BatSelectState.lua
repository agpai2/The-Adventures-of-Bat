--[[
    The Adventures of Bat

    -- BatSelectState Class --

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

BatSelectState = Class{__includes = BaseState}

function BatSelectState:init()
    self.bats = {}

    local xOffset = -48
    local yOffset = 35
    for i = 1, 4 do
        table.insert(self.bats, Bat {
            animations = BAT_DEFS[BAT_IDS[i <=2 and 1 or 2]].animations,
            isPlay = false,
            direction = i % 2 == 0 and 'back' or 'front',
            x = VIRTUAL_WIDTH / 2 + xOffset,
            y = VIRTUAL_HEIGHT / 2 - yOffset,
            width = 32,
            height = 32
        })
        xOffset = 48
        if i == 2 then
            xOffset = -48
            yOffset = -10
        end
    end

    for i = 1, 4 do
        self.bats[i]:changeAnimation('fly-' .. self.bats[i].direction)
    end

    self.currentSelection = 1
    self.menu = {
        [1] = {
            name = 'Blumaine',
            xOffset = 70,
            yOffset = 20
        },
        [2] = {
            name = 'Redneck',
            xOffset = 70,
            yOffset = -20
        }
    }
end

function BatSelectState:enter(params)
    if params ~= nil then
        self.backgroundFrame = params.backgroundFrame ~= nil and
            params.backgroundFrame or math.random(1, 3)
    end
end

function BatSelectState:update(dt)
    for i = 1, 4 do
        self.bats[i]:update(dt)
    end

    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') or
        love.keyboard.wasPressed('w') or love.keyboard.wasPressed('s') then
            self.currentSelection = self.currentSelection == 1 and 2 or 1
            gSounds['select']:play()
    end


    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gSounds['confirm']:play()
        gStateMachine:change('start', {
            backgroundFrame = self.backgroundFrame,
            batType = self.currentSelection
        })
    end

end

function BatSelectState:render()
    for i = 1, 4 do
        self.bats[i]:render()
    end

    love.graphics.setFont(gFonts['small'])

    for i = 1, 2 do
      if self.currentSelection == i then
          -- render the option selected in blue
          love.graphics.setColor(103, 255, 255, 255)
      end

      love.graphics.printf(self.menu[i].name, 0,
          VIRTUAL_HEIGHT / 2 - self.menu[i].yOffset, self.menu[i].xOffset, 'center')
          
      -- reset the color
      love.graphics.setColor(255, 255, 255, 255)
    end
end
