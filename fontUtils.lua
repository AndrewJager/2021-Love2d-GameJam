local utils = {}

local function getBestFitHeight(maxHeight, font)
    -- local font = love.graphics.newFont("fonts/Kanit-Bold.ttf", 1)
    local ras = love.font.newRasterizer(font, 1)
    local sizeExceeded = false
    local height = 1
    while not sizeExceeded do 
        local g = ras:getGlyphData("I")
        if g:getHeight() > maxHeight then 
            sizeExceeded = true 

        else
           height = height + 1 
           ras = love.font.newRasterizer("fonts/Kanit-Bold.ttf", height)
        end
    end

    return height
end
utils.getBestFitHeight = getBestFitHeight

local function getFont(fonts, font, size)
    if fonts[size] ~= nil then
        return fonts[size]
    else
        table.insert(fonts, size, love.graphics.newFont("fonts/Kanit-Bold.ttf", size))
        return fonts[size]
    end
end
utils.getFont = getFont

return utils