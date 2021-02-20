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
                block.body = love.physics.newBody(frames.world, block.x * 50 - 25, block.y * 50 )
                block.shape = love.physics.newRectangleShape(50, 50)
                block.fixture = love.physics.newFixture(block.body, block.shape)
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
        love.graphics.setColor(0.2, 0.2, 0.8, 0.1)
        love.graphics.polygon("fill", frames.maps[1].blocks[i].body:getWorldPoints(frames.maps[1].blocks[i].shape:getPoints()))
        love.graphics.setColor(0.8, 0.8, 0.8)
        love.graphics.print(frames.maps[1].blocks[i].text, (frames.maps[1].blocks[i].x * 50) - (font:getHeight() / 2), 
            (frames.maps[1].blocks[i].y * 50) - (font:getHeight() / 2))
    end
end
frames.draw = draw

local function update(dt)
    frames.world.update(dt)
end


return frames