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
            b = Brick(
                -- x-coordinate
                (x-1)                   -- decrement x by 1 because tables are 1-indexed, coords are 0
                * 32                    -- multiply by 32, the brick width
                + 8                     -- the screen should have 8 pixels of padding; we can fit 13 cols + 16 pixels total
                + (13 - numCols) * 16,  -- left-side padding for when there are fewer than 13 columns
                
                -- y-coordinate
                y * 16                  -- just use y * 16, since we need top padding anyway
            ) 

            table.insert(bricks, b)
        end
    end 

    return bricks
end