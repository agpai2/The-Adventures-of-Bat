--[[
    The Adventures of Bat

    -- PlayState Class --

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

PlayState = Class{__includes = BaseState}

local spawnTimer = math.random() * 1.5 + 1.5

function PlayState:init()
    self.background = Background()

    self.distance = 0
    self.points = 0
    self.timer = 0

    self.coins = {}
    self.obstacles = {}

    -- each of the objects are assigned a specific slot within which it will be
    -- rendered
    self.slots = {0, 32, 64, 96}
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

    -- update timer for object spawning
    self.timer = self.timer + dt

    -- after a set amount of time, both the coin and the obstacle will be rendered
    if self.timer > spawnTimer then
        -- dimensions of the coin is reduced for better game experience
        -- coin is still rendered as the original size as the it's sprites
        table.insert(self.coins, GameObject({
            x = VIRTUAL_WIDTH + 32,
            y = self.slots[math.random(#self.slots)],
            width = 28,
            height = 28,
            animations = OBJECT_DEFS['coin'].animations
        }))

        --[[
        local obstacleRandomizer = math.random(1, 40)
        for i = 1, 5 do
            OBJECT_DEFS['obstacle'].animations['animate'].frames[i] =
                OBJECT_DEFS['obstacle'].animations['animate'].frames[i] * obstacleRandomizer
        end
        ]]

        -- dimensions of the obstacle is reduced for better game experience
        -- obstacle is still rendered as the original size as the it's sprites
        table.insert(self.obstacles, GameObject({
            x = VIRTUAL_WIDTH + 32,
            y = self.slots[math.random(#self.slots)],
            width = 28,
            height = 28,
            animations = OBJECT_DEFS['obstacle'].animations
        }))

        -- reset timer
        self.timer = 0
        spawnTimer = math.random() * 1.5 + 1.5
    end

    for k, coin in pairs(self.coins) do
        coin:changeAnimation('rotate')
        --coin:update(dt)

        if coin:collides(self.bat) then
            coin.remove = true
            self.points = self.points + 1
            gSounds['confirm']:play()
        end

        if coin.remove then
            table.remove(self.coins, k)
        end

        coin:update(dt)
    end

    for k, obstacle in pairs(self.obstacles) do
        obstacle:changeAnimation('animate')
        --obstacle:update(dt)

        if obstacle:collides(self.bat) then
            gStateMachine:change('end', {
                backgroundFrame = self.background.backgroundFrame,
                batType = self.bat.type,
                distance = math.floor(self.distance),
                coins = self.points
            })
        end

        if obstacle.remove then
            table.remove(self.obstacles, k)
        end

        obstacle:update(dt)
    end
end

function PlayState:render()
    self.background:render()

    if #self.coins ~= 0 then
        for k, coin in pairs(self.coins) do
            coin:render()
        end
    end

    self.bat:render()

    if #self.obstacles ~= 0 then
        for k, obstacle in pairs(self.obstacles) do
            obstacle:render()
        end
    end

    love.graphics.printf('DISTANCE : ' .. tostring(math.floor(self.distance)),
        5, 5, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('COINS: ' .. tostring(self.points), 5, 15,
        VIRTUAL_WIDTH, 'left')
end
