--[[
    The Adventures of Bat

    -- BackgroundSelectState Class --

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

BackgroundSelectState = Class{__includes = BaseState}

function BackgroundSelectState:init()
    self.background = Background()
    self.currentBackground = 1
end

function BackgroundSelectState:enter(params)

end

function BackgroundSelectState:update(dt)
    self.background:update(dt)

    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
        if self.currentBackground == 1 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.currentBackground = self.currentBackground - 1
        end
    elseif love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
        if self.currentBackground == 3 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.currentBackground = self.currentBackground + 1
        end
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gSounds['confirm']:play()
        gStateMachine:change('start', {
            backgroundFrame = self.currentBackground
        })
    end
end

function BackgroundSelectState:render()
    self.background.backgroundFrame = self.currentBackground
    self.background:render()

    -- instructions
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Choose your background!", 0, VIRTUAL_HEIGHT / 10,
        VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("(Press Enter to continue!)", 0, VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')

    -- left arrow; should render normally if we're higher than 1, else
    -- in a shadowy form to let us know we're as far left as we can go
    if self.currentBackground == 1 then
        -- tint; give it a dark gray with half opacity
        love.graphics.setColor(40, 40, 40, 128)
    end

    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][1], 0,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 2)

    -- reset drawing color to full white for proper rendering
    love.graphics.setColor(255, 255, 255, 255)

    -- right arrow; should render normally if we're less than 4, else
    -- in a shadowy form to let us know we're as far right as we can go
    if self.currentBackground == 3 then
        -- tint; give it a dark gray with half opacity
        love.graphics.setColor(40, 40, 40, 128)
    end

    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][2],
        VIRTUAL_WIDTH - 24, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 2)

    -- reset drawing color to full white for proper rendering
    love.graphics.setColor(255, 255, 255, 255)
end
