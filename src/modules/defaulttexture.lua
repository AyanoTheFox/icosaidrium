local df = {}

--#_bool is a boolean
local function reverter(_bool)
    if not _bool then return true end
    return false
end

--#_segstart is a string
--#_w, _h, _segsx, _segsy are numbers
function df.generate(_segstart, _w, _h, _segsx, _segsy)
    local segisblack
    if _segstart == "black" then segisblack = true
    elseif _segstart == "white" then segisblack = false
    else error("invalid seg to start") end
    
    local textureImageData = love.image.newImageData(_w, _h)
    local canvas = love.graphics.newCanvas(_w, _h)
    love.graphics.setCanvas(canvas)
    for x = 0, _w, _w / _segsx do
        for y = 0, _h, _h / _segsy do
            if segisblack then
                love.graphics.setColor(0.5, 0.5, 0.5, 1)
            else
                love.graphics.setColor(0.3, 0.3, 0.3, 1)
            end
            love.graphics.rectangle("fill", x, y, _w / _segsx, _h / _segsy)
            segisblack = reverter(segisblack)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas()
    textureImageData:paste(canvas:newImageData(), 0, 0)
    return love.graphics.newImage(textureImageData)
end

return df