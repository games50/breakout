--[[
    GD50
    Breakout Remake

    -- LevelMaker Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Creates randomized levels for our Breakout game. Returns a table of
    bricks that the game can render, based on the current level we're at
    in the game.
]]

LevelMaker = Class{} 

--[[
    Creates a table of Bricks to be returned to the main game, with different
    possible ways of randomizing rows and columns of bricks. Calculates the
    brick colors and tiers to choose based on the level passed in.
]]
function LevelMaker.createMap(level)
    local bricks = {}

    -- randomly choose the number of rows
    local numRows = math.random(1, 5)

    -- randomly choose the number of columns
    local numCols = math.random(7, 13)

    -- lay out bricks such that they touch each other and fill the space
    for y = 1, numRows do
        for x = 1, numCols do
            b = Brick(x * 32 - 24 + (13 - numCols) * 16, y * 16) 

            table.insert(bricks, b)
        end
    end 

    return bricks
end