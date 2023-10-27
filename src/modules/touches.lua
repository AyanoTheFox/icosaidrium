--&private&--
local touches = {}
touches.__index = touches

local function math_dist(_x1, _x2, _y1, _y2)
    return ((_x2 - _x1) ^ 2 + (_y1 - _y2) ^ 2) ^ .5
end

local function math_clamp(_low, _n, _high)
    return math.min(math.max(_low, _n), _high)
end

--&public&--
--%low level%--
function touches.new()
    return setmetatable({
        touches = {},
        lastDist = 0,
        zoom = 1,
        count = 0
    }, touches)
end

function touches:getTimesToucheds()
    return self.count
end

function touches:resetCount()
    self.count = 0
end

function touches:zoom(_mul)
    self.zoom = self.zoom * _mul
end

function touches:zoomTo(_zoom)
    self.zoom = _zoom
end

function touches:getZoom(_zoom)
    return self.zoom
end

function touches:getTouch(_id)
    for _, touch in ipairs(self.touches) do
        if touch.id == _id then return _, touch end
    end
end

function touches:actives()
    return self.touches
end

function touches:update(_id)
    local lastX, lastY, dx, dy = self.touches[_id].x, self.touches[_id].y
    for _, move in ipairs(self.touches[_id].moved) do
        dx = dx + (move.x - lastX)
        dy = dy + (move.y - lastY)
        lastX, lastY = move.x, move.y
        self.touches[_id].moved[_] = nil
    end
    self.touches[_id].x = lastX
    self.touches[_id].y = lastY
    return dx, dy
end

--%high level%--
function touches:pinch(_zoom, _low, _high)
    if #self.touches == 2 then
        local _dist = math_dist(self.touches[1].x, self.touches[2].x, self.touches[1].y, self.touches[2].y)
        _zoom = math_clamp(_low, _zoom * (_dist / self.lastDist), _high)
        self.lastDist = _dist
    end
    return _zoom
end

function touches:swipe(_callback1, _callback2, _callback3, _callback4, _callback5)
    if #self.touches == 1 then
        local _, touch = self:getTouch(self.touches[1].id)
        if touch.dx > 0 and math.abs(touch.dx) > math.abs(touch.dy) then
            if _callback1 ~= nil then return _callback1(touch.id, touch.x, touch.y, touch.dx, touch.dy, touch.pressure, self.zoom) end
        elseif touch.dy > 0 and math.abs(touch.dx) < math.abs(touch.dy) then
            if _callback2 ~= nil then return _callback2(touch.id, touch.x, touch.y, touch.dx, touch.dy, touch.pressure, self.zoom) end
        elseif touch.dx < 0 and math.abs(touch.dx) > math.abs(touch.dy) then
            if _callback3 ~= nil then return _callback3(touch.id, touch.x, touch.y, touch.dx, touch.dy, touch.pressure, self.zoom) end
        elseif touch.dy < 0 and math.abs(touch.dx) < math.abs(touch.dy) then
            if _callback4 ~= nil then return _callback4(touch.id, touch.x, touch.y, touch.dx, touch.dy, touch.pressure, self.zoom) end
        else 
            if _callback5 ~= nil then return _callback5(touch.id, touch.x, touch.y, touch.dx, touch.dy, touch.pressure, self.zoom) end
        end
    end
end

function touches:tap(_elapsed, _times, _timer)
    local c = self.count
    self.count = 0
    for _ = 0, _timer or .5, _elapsed do
        if self.count == _times or 2 then
            self.count = c
            return true
        end
    end
    self.count = c
    return false
end

function touches:touchpressed(id, x, y, dx, dy, pressure)
    table.insert(self.touches, {
        id = id,
        x = x, y = y,
        dx = dx, dy = dy,
        pressure = pressure,
        moved = {}
    })
    self.count = self.count + 1
    if #self.touches == 2 then
        self.lastDist = math_dist(self.touches[1].x, self.touches[2].x, self.touches[1].y, self.touches[2].y)
    end
end

function touches:touchmoved(id, x, y, dx, dy, pressure)
    local _, touch = self:getTouch(id)
    if touch then
       touch.x, touch.y = x, y
       touch.dx, touch.dy = dx, dy
       touch.pressure = pressure
       table.insert(touch.moved, {x = x, y = y})
    end
end

function touches:touchreleased(id, x, y, dx, dy, pressure)
    local _, touch = self:getTouch(id)
    if touch then
        touch.x, touch.y = x, y
        touch.dx, touch.dy = dx, dy
        touch.pressure = pressure
        table.insert(touch.moved, {x = x, y = y})
    end
    if #self.touches == 2 then
        self.lastDist = math_dist(self.touches[1].x, self.touches[2].x, self.touches[1].y, self.touches[2].y)
    end
    table.remove(self.touches, self:getTouch(id))
end

return touches