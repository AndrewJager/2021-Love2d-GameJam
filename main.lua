-- Send help

local frames = require "frames"

function love.load()
    love.window.setMode(1100, 750)

    frames.load()
end

function love.update(dt)

end

function love.draw()
    love.graphics.print("Hello World!", 10, 10, math.rad(45))

    frames.draw()
end