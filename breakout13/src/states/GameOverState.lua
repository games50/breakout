--[[
    GD50
    Breakout Remake

    -- GameOverState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The state in which we've lost all of our health and get our score displayed to us. Should
    transition to the EnterHighScore state if we exceeded one of our stored high scores, else back
    to the StartState.
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- see if score is higher than any in the high scores table
        local highScore = false
        
        -- keep track of what high score ours overwrites, if any
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gSounds['high-score']:play()
            gStateMachine:change('enter-high-score', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex
            }) 
        else 
            gStateMachine:change('start', {
                highScores = self.highScores
            }) 
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Final Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter!', 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
end