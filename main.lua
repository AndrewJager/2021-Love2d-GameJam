-- Send help

local frames = require "frames"

function love.load()
    love.window.setMode(1100, 750)

    frames.load()
end

function love.update(dt)

end

function love.draw()
    frames.draw()
end