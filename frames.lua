local frames = {}
frames.maps = {}
frames.world = love.physics.newWorld(0, 10)
frames.activeFrame = nil

local function load()
    local function loadMap(fileName, maps)
        local mapData = require("maps/" .. fileName)
        local objData = mapData.layers[1].objects

        local newFrame = {}
        newFrame.name = fileName
        newFrame.objects = {}
        for i=1, #objData do 
            local newObj = {}
            newObj.body = love.physics.newBody(frames.world, objData[i].x + (objData[i].width / 2), 
                objData[i].y + (objData[i].height / 2), "static")
            newObj.shape = love.physics.newRectangleShape(objData[i].width, objData[i].height)
            newObj.fixture = love.physics.newFixture(newObj.body, newObj.shape)
            table.insert( newFrame.objects, newObj )
        end

        return newFrame
    end

    table.insert( frames.maps, loadMap("test", frames.maps) )
    frames.activeFrame = frames.maps[1]
end
frames.load = load

local function draw()
    local objs = frames.activeFrame.objects 
    love.graphics.setColor(0.2, 0.2, 0.8)
    for i=1, #objs do 
        local obj = objs[i]
        love.graphics.polygon("line", obj.body:getWorldPoints(obj.shape:getPoints()))
    end
end
frames.draw = draw

local function update(dt)

end


return frames