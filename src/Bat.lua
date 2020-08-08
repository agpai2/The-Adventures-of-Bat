--[[
    The Adventures of Bat

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

Bat = Class{}

function Bat:init(def)

    self.type = def.type
    self.animations = self:createAnimations(def.animations)

    self.direction = def.direction

    self.isPlay = def.isPlay

    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
end

function Bat:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Bat:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Bat:update(dt)
    if self.isPlay then
        if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
            self.y = math.max(0, self.y - BAT_SPEED * dt)
        elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then
            self.x = math.max(0, self.x - BAT_SPEED * dt)
            self:changeAnimation('fly-left')
        elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
            self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + BAT_SPEED * dt)
        elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
            self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + BAT_SPEED * dt)
            self:changeAnimation('fly-right')
        end
    end

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Bat:render()
    local animation = self.currentAnimation
    love.graphics.draw(gTextures[animation.texture], gFrames[animation.texture][animation:getCurrentFrame()],
        math.floor(self.x), math.floor(self.y))

    -- used for debugging
    -- hit/hurt box of the bat
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end
