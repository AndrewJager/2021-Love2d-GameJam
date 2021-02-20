local frames = {}
frames.maps = {}
frames.world = love.physics.newWorld(0, 10)
frames.activeFrame = nil

local font = love.graphics.newFont("fonts/Kanit-Bold.ttf", 70)


local function load()
    local function loadMap(fileName)
        function split(source, delimiters)
            local elements = {}
            local pattern = '([^'..delimiters..']+)'
            string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
            return elements
        end
        function trim(s)
            return (s:gsub("^%s*(.-)%s*$", "%1"))
        end
    
        local file = io.open(fileName, "r")
        local content = file:read("*all")
        local chars = split(content, ",")
        local blocks = {}
        for i = 2, #chars do -- Ignore first entry
            if trim(chars[i]) ~= "" then
                local tokens = split(chars[i], ":")
                local block = {}
                block.x = tokens[1]
                block.y = tokens[2]
                block.text = tokens[3]
                table.insert(blocks, block)
            end
        end
        map = {}
        map.blocks = blocks
        table.insert(frames.maps, map)
    end

    loadMap("maps/test.csv")
end
frames.load = load

local function draw()
    love.graphics.setFont(font)
    for i=1, #frames.maps[1].blocks do
        love.graphics.print(frames.maps[1].blocks[i].text, (frames.maps[1].blocks[i].x * 50) - (font:getHeight() / 2), 
            (frames.maps[1].blocks[i].y * 50) - (font:getHeight() / 2))
    end
end
frames.draw = draw

local function update(dt)

end


return frames