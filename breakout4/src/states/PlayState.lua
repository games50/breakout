--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()

    -- initialize ball with skin #1; different skins = different sprites
    self.ball = Ball(1)

    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    -- give ball position in the center
    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    -- use the "static" createMap function to generate a bricks table
    self.bricks = LevelMaker.createMap()
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    -- update positions based on velocity
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        -- raise ball above paddle in case it goes below it, then reverse dy
        self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy

        --
        -- tweak angle of bounce based on where it hits the paddle
        --

        -- if we hit the paddle on its left side...
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            -- if the self.paddle is moving left...
            if self.paddle.dx < 0 then
                self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
            end
        else
            -- if the self.paddle is moving right...
            if self.paddle.dx > 0 then
                self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
            end
        end

        gSounds['paddle-hit']:play()
    end

    -- detect collision across all bricks with the ball
    for k, brick in pairs(self.bricks) do

        -- only check collision if we're in play
        if brick.inPlay and self.ball:collides(brick) then

            -- trigger the brick's hit function, which removes it from play
            brick:hit()

            -- hit from the left
            if self.ball.dx > 0 then
                -- left edge
                if self.ball.x + 2 < brick.x then
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x - 8
                -- top edge
                elseif self.ball.y + 1 < brick.y then
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y - 8
                -- bottom edge
                else
                    -- bottom edge
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y + 16
                end
            else
                -- right edge
                if self.ball.x + 6 > brick.x + brick.width then
                    -- reset self.ball position
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x + 32
                elseif self.ball.y + 1 < brick.y then
                    -- top edge
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y - 8
                else
                    -- bottom edge
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y + 16
                end
            end

            -- slightly scale the y velocity to speed up the game
            self.ball.dy = self.ball.dy * 1.02

            -- only allow colliding with one brick, for corners
            break
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    self.paddle:render()
    self.ball:render()

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(largeFont)
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end