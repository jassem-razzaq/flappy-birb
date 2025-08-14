--[[
    BIRB GAME
]]

-- LIBRARIES
push = require 'lib.push'
Class = require 'lib.class'

require 'src.Birb'


-- physical screen dimensions
WINDOW_WIDTH = 360
WINDOW_HEIGHT = 540

-- virtual resolution dimensions
VIRTUAL_WIDTH = 720
VIRTUAL_HEIGHT = 1080

-- images we load into memory from files to later draw onto the screen
local background = love.graphics.newImage('assets/sprites/sky.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/sprites/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 100
local GROUND_SCROLL_SPEED = 200

local BACKGROUND_LOOP_PT = 720
local GROUND_LOOP_PT = 1440

local birb = Birb()


function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- app window title
    love.window.setTitle('BIRB GAME')

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOP_PT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    birb:update(dt)
    
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    
    -- draw the background starting at top left (0, 0)
    love.graphics.draw(background, -backgroundScroll, 0)

    -- draw the ground on top of the background, toward the bottom of the screen
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 110)
    birb:render()
    push:finish()
end