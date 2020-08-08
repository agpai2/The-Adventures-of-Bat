--[[
    The Adventures of Bat

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

Background = Class{}

function Background:init(frame)
    self.backgroundScroll = 0
    -- the point at which the background loops back
    self.loopingPoint = 256

    self.backgroundFrame = frame or math.random(1, 3)
end

function Background:update(dt)
    self.backgroundScroll = (self.backgroundScroll +
        BACKGROUND_SCROLL_SPEED * dt) % self.loopingPoint
end

function Background:render()
    love.graphics.draw(gTextures['background'],
        gFrames['background'][self.backgroundFrame], -self.backgroundScroll, 0)
end
