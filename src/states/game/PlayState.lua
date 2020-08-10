--[[
    The Adventures of Bat

    -- PlayState Class --

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.background = Background()

    self.distance = 0
end

function PlayState:enter(params)
    self.background.backgroundFrame = params.backgroundFrame

    -- dimensions of the bat is reduced for better game experience
    -- bat is still rendered as the original size as the it's sprites
    self.bat = Bat({
        type = params.batType,
        animations = BAT_DEFS[BAT_IDS[params.batType]].animations,
        isPlay = true,
        direction = 'right',
        x = 10,
        y = math.random(VIRTUAL_HEIGHT / 2),
        width = 28,
        height = 28
    })
    self.bat:changeAnimation('fly-' .. self.bat.direction)
end

function PlayState:update(dt)
    self.background:update(dt)
    self.bat:update(dt)

    self.distance =  self.distance + BAT_SPEED / BACKGROUND_SCROLL_SPEED * dt
end

function PlayState:render()
    self.background:render()

    self.bat:render()

    love.graphics.printf('DISTANCE : ' .. tostring(math.floor(self.distance)),
        5, 5, VIRTUAL_WIDTH, 'left')
end
