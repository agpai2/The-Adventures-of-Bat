--[[
    The Adventures of Bat

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

GameObject = Class{}

function GameObject:init(def)
    self.x = def.x
    self.y = def.y

    self.width = def.width
    self.height = def.height

    self.animations = self:createAnimations(def.animations)

    self.remove = false
end

function GameObject:createAnimations(animations)
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

function GameObject:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function GameObject:collides(target)
    -- AABB collision
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function GameObject:update(dt)
    if self.x > -self.width then
        self.x = self.x - BACKGROUND_SCROLL_SPEED * dt
    else
        self.remove = true
    end

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function GameObject:render()
    local animation = self.currentAnimation
    love.graphics.draw(gTextures[animation.texture],
        gFrames[animation.texture][animation:getCurrentFrame()], self.x, self.y)

    -- used for debugging
    -- hit/hurt box of the object
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end
