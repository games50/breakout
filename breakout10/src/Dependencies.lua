-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'lib/push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- a few global constants, centralized
require 'src/constants'

-- the ball that travels around, breaking bricks and triggering lives lost
require 'src/Ball'

-- the entities in our game map that give us points when we collide with them
require 'src/Brick'

-- a class used to generate our brick layouts (levels)
require 'src/LevelMaker'

-- the rectangular entity the player controls, which deflects the ball
require 'src/Paddle'

-- a basic StateMachine class which will allow us to transition to and from
-- game states smoothly and avoid monolithic code in one file
require 'src/StateMachine'

-- utility functions, mainly for splitting our sprite sheet into various Quads
-- of differing sizes for paddles, balls, bricks, etc.
require 'src/Util'

-- each of the individual states our game can be in at once; each state has
-- its own update and render methods that can be called by our state machine
-- each frame, to avoid bulky code in main.lua
require 'src/states/BaseState'
require 'src/states/EnterHighScoreState'
require 'src/states/GameOverState'
require 'src/states/HighScoreState'
require 'src/states/PlayState'
require 'src/states/ServeState'
require 'src/states/StartState'
require 'src/states/VictoryState'