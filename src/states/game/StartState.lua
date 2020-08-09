--[[
    The Adventures of Bat

    -- StartState Class --

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.currentSelection = 1

    -- the items that will be shown in the menu in startstate
    self.menu = {
        [1] = {
            option = 'Play',
            state = 'play',
            yOffset = 30
        },
        [2] = {
            option = 'Select Bat',
            state = 'bat-select',
            yOffset = 40
        },
        [3] = {
            option = 'Select Background',
            state = 'background-select',
            yOffset = 50
        }
    }

    self.background = Background()

    self.bat = Bat({
        type = 1,
        animations = BAT_DEFS[BAT_IDS[1]].animations,
        isPlay = false,
        direction = 'front',
        x = VIRTUAL_WIDTH / 2 - 16,
        y = VIRTUAL_HEIGHT / 2 - 12,
        width = 32,
        height = 32
    })
    self.bat:changeAnimation('fly-' .. self.bat.direction)
end

function StartState:enter(params)

end

function StartState:update(dt)
    self.background:update(dt)
    self.bat:update(dt)

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        if self.currentSelection == 1 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.currentSelection = self.currentSelection - 1
        end
    elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        if self.currentSelection == 3 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.currentSelection = self.currentSelection + 1
        end
    end

    -- transition to a specified state when enter/return are pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()
        gStateMachine:change(self.menu[self.currentSelection].state, {
            backgroundFrame = self.background.backgroundFrame,
            batType = self.bat.type
        })
    end
end

function StartState:render()
    self.background:render()
    self.bat:render()

    -- simple UI code
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('The Adventures of Bat', 0, VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])

    for i = 1, 3 do
      if self.currentSelection == i then
          -- render the option selected in blue
          love.graphics.setColor(103, 255, 255, 255)
      end

      love.graphics.printf(self.menu[i].option, 0,
          VIRTUAL_HEIGHT / 2 + self.menu[i].yOffset, VIRTUAL_WIDTH, 'center')
      -- reset the color
      love.graphics.setColor(255, 255, 255, 255)
    end
end
