--[[
    The Adventures of Bat

    Author: Aniruddha Pai
    aniruddh.g.pai@gmail.com
    agpai2@illinois.edu

    Credit for art:

    blue-bat and red- bat - https://opengameart.org/content/bat-rework
    Original link - https://opengameart.org/node/77508
    Created by bagzie.

    obstacles - http://opengameart.org/users/mindfields51
    coins - Clint Bellanger for Liberated Pixel Art

    UI arrows - https://opengameart.org/users/buch

    Credit for music:

]]

require 'src/Dependencies'

function love.load()
    love.window.setTitle('The Adventures of Bat')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    gStateMachine:change('start')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gSounds['music-1']:setLooping(true)
    gSounds['music-1']:play()

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end
