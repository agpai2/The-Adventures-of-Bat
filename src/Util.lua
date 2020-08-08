--[[
    GD50
    The Adventures of Bat
]]

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

function GenerateBatQuads(atlas)
    local x = 7
    local y = 15

    local counter = 1
    local quads = {}

    for i = 1, 12 do
        quads[counter] = love.graphics.newQuad(x, y, 32, 32, atlas:getDimensions())

        x = x + 48
        if i % 3 == 0 then
            x = 7
            y = y + 64
        end
        counter = counter + 1
    end

    return quads
end

function GenerateObstacles(atlas)
    local x = 33
    local y = 33

    local counter = 1
    local quads = {}

    -- the manipulations done below are to obtains only animated tiles from
    -- graphics/obstacles.png
    for i = 1, 200 do
        quads[counter] = love.graphics.newQuad(x, y, 32, 32, atlas:getDimensions())

        x = x + 33
        if i % 5 == 0 then
            x = i > 100 and 230 or 33
            y = y + 32
        end

        if i == 100 then
            x = 230
            y = 33
        end

        counter = counter + 1
    end

    return quads
end
