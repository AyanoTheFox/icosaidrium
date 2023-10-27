function love.load()
    --^libs^--
    --#graphicals libs#--
    gamestate = require("libs/gamestate")
    camera = require("libs/camera")
    --#dataBank libs#--
    json = require("libs/json")
    lip = require("libs/lip")
    --#others#--
    suit = require("libs/suit")
    timer = require("libs/timer")
    require("libs/addons")
    --&modules--
    multitouch = require("src/modules/touches")
    --^tables^--
    --#gamestate states#--
    states = {}
    states.loadscreen = require("src/states/loadscreen")
    states.editor = require("src/states/editor")
    states.manager = require("src/states/manager")
    states.credits = require("src/states/credits")
    --^vars^--
    font = love.graphics.setNewFont("assets/fonts/phoenixBIOS.ttf", 12) --defaultFont
    mobile = false --check if the user is a mobile user
    halfScreenW = love.graphics.getWidth() / 2
    halfScreenH = love.graphics.getHeight() / 2
    --^cmds^--
    love.graphics.setDefaultFilter("nearest", "nearest") --defaultfilter
    gamestate.registerEvents({"update", "textinput", "textedited", "keypressed", "touchpressed", "touchmoved", "touchreleased", "mousepressed", "mousemoved", "wheelmoved"}) --events to register
    gamestate.switch(states.loadscreen)
    if love.system.getOS() == 'iOS' or love.system.getOS() == 'Android' then mobile = true end
end

function love.draw()
    gamestate.current():draw()
    suit.draw()
end

function love.textedited(t, s, l)
    suit.textedited(t, s, l)
end

function love.keypressed(k)
    suit.keypressed(k)
end

function love.textinput(t)
    suit.textinput(t)
end

--&help functions&--
function inverter(_var)
    if type(_var) == "number" then
        return -_var
    end
    if type(_var) == "boolean" then
        if _var then
            return false 
        end
    end
    return true
end

function toOnAndOff(_bool)
    if _bool then return "on" end
    return "off"
end

function math.multiply(_n, _size) return math.floor(_n / _size) * _size end

function math.round(_n, _idp, _method)
    local _f = 10 ^ (_idp or 0)
    if _method == 'floor' or _method == 'ceil' then
        return math[_method](_n * _f) / _f
    else
        return tonumber(('%.' .. (_idp or 0) .. 'f'):format(_n))
    end
end

function math.byteToSize(_byte)
    local _kb = _byte / 1024
    local _mb = _kb / 1024
    local _gb = _mb / 1024
    local _tb = _gb / 1024
    if _byte > 1024 and _kb < 1024 then 
        return math.round(_kb, 2) .. "kb"
    elseif _kb > 1024 and _mb < 1024 then
        return math.round(_mb, 2) .. "mb"
    elseif _mb > 1024 and _gb < 1024 then
        return math.round(_gb, 2) .. "gb"
    elseif _gb > 1024 then
        return math.round(_tb, 2) .. "tb"
    end
end