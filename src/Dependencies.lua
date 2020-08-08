--[[
    The Adventures of Bat

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu
]]

--
-- libraries
--

Class = require 'lib/class'
push = require 'lib/push'

Timer = require 'lib/knife.timer'

-- constants or objects required for game creation
require 'src/constants'

-- classes required for the game's back-end design
require 'src/StateMachine'
require 'src/Util'

-- game objects or attributes

-- states of the game

gStateMachine = StateMachine {

}

gTextures = {
    ['background'] = love.graphics.newImage('graphics/background-1.png'),
    ['blue-bat'] = love.graphics.newImage('graphics/blue-bat.png'),
    ['red-bat'] = love.graphics.newImage('graphics/red-bat.png'),
    ['cursor'] = love.graphics.newImage('graphics/cursor.png'),
    ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
    ['coins'] = love.graphics.newImage('graphics/coins.png'),
    ['obstacles'] = love.graphics.newImage('graphics/obstacles.png')
}

gFrames = {
    ['background'] = GenerateQuads(gTextures['background'], 512, 128),
    ['blue-bat'] = GenerateBatQuads(gTextures['blue-bat']),
    ['red-bat'] = GenerateBatQuads(gTextures['red-bat']),
    ['arrows'] = GenerateQuads(gTextures['arrows'], 24, 24),
    ['coins'] = GenerateQuads(gTextures['coins'], 32, 32),
    ['obstacles'] = GenerateObstacles(gTextures['obstacles'])
}

gSounds = {
    ['music-1'] = love.audio.newSource('sounds/music.mp3'),
    ['music-2'] = love.audio.newSource('sounds/music2.mp3'),
    ['select'] = love.audio.newSource('sounds/select.wav'),
    ['no-select'] = love.audio.newSource('sounds/no-select.wav'),
    ['confirm'] = love.audio.newSource('sounds/confirm.wav')
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/gamefont.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/gamefont.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/gamefont.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/gamefont.ttf', 64)
}
