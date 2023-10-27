editor = {}
editor.id = "" --the id is the same than the mo name

function editor:enter()
    df = require("src/modules/defaulttexture")
    cam = camera.new(nil, nil, 1, 0)--camera instance
    touches = multitouch.new()
    --&variables&--
    --%tables%--
    if mobile then
        buttons.editor.features = {
            --z = 11, 12,; v = 23, 24; b = 17, 18; backspace = 1, 2; n = 19, 20; h = 21, 22; f = 25, 26;
            --m = 27, 28; k = 29, 30; t = 13, 14; s = 15, 16; y = 9, 10; r = 7, 8
            {
                id = "s",
                normal = 15, active = 16,
                x = 0, y = 0, w = 52, h = 50,
                callback = function()
                    love.filesystem.write(editor.id .. "/mapBatch.bin", love.data.compress("string", "zlib", json.encode(meta.map)))
                end
            },
            {
                id = "b",
                normal = 17, active = 18,
                x = 52, y = 0, w = 52, h = 50,
                callback = function()
                    local states = {
                        placing_blocks = function()
                            if textureId > 1 then
                                textureId = textureId - 1
                                return
                            end
                            textureId = #tileset.quads
                        end,
                        placing_objects = function()
                            if objectId > 1 then
                                objectId = objectId - 1
                            end
                        end,
                        changing_layer = function()
                            if layerId > 1 then
                                layerId = layerId - 1
                            end
                        end
                    }
                    if states[state] then
                        states[state]()
                    end
                end
            },
            {
                id = "n",
                normal = 19, active = 20,
                x = 104, y = 0, w = 52, h = 50,
                callback = function()
                    local states = {
                        placing_blocks = function()
                            if textureId < #tileset.quads then 
                                textureId = textureId + 1
                                return
                            end
                            textureId = 1
                        end,
                        placing_objects = function()
                            objectId = objectId + 1
                        end,
                        changing_layer = function()
                            layerId = layerId + 1
                        end
                    }
                    if states[state] then
                        states[state]()
                    end
                end
            },
            {
                id = "r",
                normal = 7, active = 8,
                x = 156, y = 0, w = 52, h = 50,
                callback = function()
                    blockR = blockR + math.pi / 2
                    if blockR == math.pi * 2 then
                        blockR = 0
                    end
                end
            },
            {
                id = "y",
                normal = 9, active = 10,
                x = 208, y = 0, w = 52, h = 50,
                callback = function()
                    if #meta.map.blocks > 0 then
                        table.insert(trash, 1, meta.map.blocks[#meta.map.blocks])
                        table.remove(meta.map.blocks, #meta.map.blocks)
                    end
                end
            },
            {
                id = "z",
                normal = 11, active = 12,
                x = 260, y = 0, w = 52, h = 50,
                callback = function()
                    if #trash > 0 then
                        table.insert(meta.map.blocks, #meta.map.blocks, trash[1])
                        table.remove(trash, 1)
                    end
                end
            },
            {
                id = "v",
                normal = 24, active = 23,
                x = 312, y = 0, w = 52, h = 50,
                callback = function()
                    blockSx = -blockSx
                end
            },
            {
                id = "h",
                normal = 21, active = 22,
                x = 364, y = 0, w = 52, h = 50,
                callback = function()
                    blockSy = -blockSy
                end
            },
            {
                id = "t",
                normal = 13, active = 14,
                x = 416, y = 0, w = 52, h = 50,
                callback = function()
                    state = "changing_layer"
                end
            },
            {
                id = "f",
                normal = 25, active = 26,
                x = 468, y = 0, w = 52, h = 50,
                callback = function()
                    navBar = inverter(navBar)
                end
            },
            {
                id = "alt",
                normal = 5, active = 6,
                x = love.graphics.getWidth() - 254, y = 0, w = 76, h = 50,
                callback = function()
                    if state == "placing_blocks" or state == "deleting_objects" then
                        state = "placing_objects"
                    elseif state == "placing_objects" or state == "deleting blocks" or state == "looking" or state == "changing_layer" then
                        state = "placing_blocks"
                    end
                end
            },
            {
                id = "backspace",
                normal = 1, active = 2,
                x = love.graphics.getWidth() - 179, y = 0, w = 104, h = 50,
                callback = function()
                    if state == "deleting_objects" or state == "placing_blocks" or state == "looking" then
                        state = "deleting blocks"
                    elseif state == "deleting blocks" or state == "placing_objects" then
                        state = "deleting_objects"
                    elseif state == "changing_layer" then
                        state = "deleting_objects"
--                         deleteLayer(layerId)
                    end
                end
            },
            {
                id = "esc",
                normal = 3, active = 4,
                x = love.graphics.getWidth() - 76, y = 0, w = 76, h = 50,
                callback = function()
                    editor.id = nil
                    tileset.sheet:release()
                    for _, quad in ipairs(tileset.quads) do
                        quad:release()
                    end
                    gamestate.switch(states.manager)
                end
            },
            {
                id = "m",
                normal = 27, active = 28,
                x = 0, y = love.graphics.getHeight() - 50, w = 52, h = 50,
                callback = function()
                    state = "looking"
                end
            }
        }
    else
        buttons.editor.features = {
            --z = 11, 12,; v = 23, 24; b = 17, 18; backspace = 1, 2; n = 19, 20; h = 21, 22; f = 25, 26;
            --m = 27, 28; k = 29, 30; t = 13, 14; s = 15, 16; y = 9, 10; r = 7, 8
            {
                id = "s",
                normal = 2,
                x = 0, y = 0, w = 52, h = 50,
                callback = function()
                    love.filesystem.write(editor.id .. "/mapBatch.bin", love.data.compress("string", "zlib", json.encode(meta.map)))
                end
            },
            {
                id = "b",
                normal = 3,
                x = 53, y = 0, w = 52, h = 50,
                callback = function()
                    local states = {
                        placing_blocks = function()
                            if textureId > 1 then
                                textureId = textureId - 1
                                return
                            end
                            textureId = #tileset.quads
                        end,
                        placing_objects = function()
                            if objectId > 1 then
                                objectId = objectId - 1
                            end
                        end,
                        changing_layer = function()
                            if layerId > 1 then
                                layerId = layerId - 1
                            end
                        end
                    }
                    if states[state] then
                        states[state]()
                    end 
                end
            },
            {
                id = "n",
                normal = 4,
                x = 106, y = 0, w = 52, h = 50,
                callback = function()
                    local states = {
                        placing_blocks = function()
                            if textureId < #tileset.quads then 
                                textureId = textureId + 1
                                return
                            end
                            textureId = 1
                        end,
                        placing_objects = function()
                            objectId = objectId + 1
                        end,
                        changing_layer = function()
                            layerId = layerId + 1
                        end
                    }
                    if states[state] then
                        states[state]()
                    end
                end
            },
            {
                id = "r",
                normal = 7,
                x = 159, y = 0, w = 52, h = 50,
                callback = function()
                    blockR = blockR + math.pi / 2
                    if blockR == math.pi * 2 then
                        blockR = 0
                    end
                end
            },
            {
                id = "y",
                normal = 5,
                x = 212, y = 0, w = 52, h = 50,
                callback = function()
                    if #meta.map.blocks > 0 then
                        table.insert(trash, 1, meta.map.blocks[#meta.map.blocks])
                        table.remove(meta.map.blocks, #meta.map.blocks)
                    end
                end
            },
            {
                id = "z",
                normal = 6,
                x = 265, y = 0, w = 52, h = 50,
                callback = function()
                    if #trash > 0 then
                        table.insert(meta.map.blocks, #meta.map.blocks, trash[1])
                        table.remove(trash, 1)
                    end
                end
            },
            {
                id = "v",
                normal = 8,
                x = 318, y = 0, w = 52, h = 50,
                callback = function()
                    blockSx = -blockSx
                end
            },
            {
                id = "h",
                normal = 9,
                x = 369, y = 0, w = 52, h = 50,
                callback = function()
                    blockSy = -blockSy
                end
            },
            {
                id = "t",
                normal = 13, 
                x = 422, y = 0, w = 52, h = 50,
                callback = function()
                    if state == "changing_layer" then
                        state = "placing_blocks"
                    else
                        state = "changing_layer"
                    end
                end
            },
            {
                id = "f",
                normal = 1,
                x = 475, y = 0, w = 52, h = 50,
                callback = function()
                    navBar = inverter(navBar)
                end
            },
            {
                id = "alt",
                normal = 10,
                x = love.graphics.getWidth() - 258, y = 0, w = 76, h = 50,
                callback = function()
                    if state == "placing_blocks" or state == "deleting_objects" then
                        state = "placing_objects"
                    elseif state == "placing_objects" or state == "deleting blocks" or state == "looking" or state == "changing_layer" then
                        state = "placing_blocks"
                    end
                end
            },
            {
                id = "backspace",
                normal = 11, 
                x = love.graphics.getWidth() - 181, y = 0, w = 104, h = 50,
                callback = function()
                    if state == "deleting_objects" or state == "placing_blocks" or state == "looking" then
                        state = "deleting blocks"
                    elseif state == "deleting blocks" or state == "placing_objects" then
                        state = "deleting_objects"
                    elseif state == "changing_layer" then
                        state = "deleting_objects"
--                         deleteLayer(layerId)
                    end
                end
            },
            {
                id = "esc",
                normal = 12, 
                x = love.graphics.getWidth() - 76, y = 0, w = 76, h = 50,
                callback = function()
                    editor.id = nil
                    tileset.sheet:release()
                    for _, quad in ipairs(tileset.quads) do
                        quad:release()
                    end
                    meta.map = {
                        name = "untituled",
                        grid = {
                            size = 32
                        },
                        blocks = {},
                        objects = {}
                    }
                    gamestate.switch(states.manager)
                end
            }
        }
    end
    keybinds = {
        {
            id = "a",
            callback = function()
                editorOffSetX = editorOffSetX - meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 100 * 3)
            end
        },
        {
            id = "w",
            callback = function()
                editorOffSetY = editorOffSetY - meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 100 * 3)
            end
        },
        {
            id = "s",
            callback = function()
                editorOffSetY = editorOffSetY + meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 100 * 3)
            end
        },
        {
            id = "d",
            callback = function()
                editorOffSetX = editorOffSetX + meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 100 * 3)
            end
        }
    }
    trash = {}
    --%numbers&--
    zoom = 1
    editorOffSetX, editorOffSetY = 0, 0
    textureId = 1
    blockR = 0
    blockSx, blockSy = 1, 1
    objectId = 1
    layerId = 1
    navBarx = 0
    x0, y0 = 0, 0 
    x1, y1 = love.graphics.getWidth(), love.graphics.getHeight()
    --%strings%--
    state = "placing_blocks"
    --%booleans%--
    navBar = true
    --&commands&--
    --%tileset%--
    tileset = {}
    tileset.sheet = df.generate("white", meta.map.grid.size, meta.map.grid.size, 2, 2)
    tileset.quads = {love.graphics.newQuad(0, 0, meta.map.grid.size, meta.map.grid.size, tileset.sheet)}
    if love.filesystem.getInfo(editor.id .. "/tileset.json") and love.filesystem.getInfo(editor.id .. "/tileset.png") then
        tileset.sheet, tileset.quads = atlasparser.getQuads(editor.id .. "/tileset")
    end
    mapBatch = love.graphics.newSpriteBatch(tileset.sheet)
    sliders = {}
    sliders.tiles = {min = 10, value = 10, max = math.floor(#tileset.quads / 7)}
end

function editor:draw()
    --&background&--
    local _background
    if meta.settings.gui.theme == "light" then
        love.graphics.setBackgroundColor(.6, .6, .6, 1)
    elseif meta.settings.gui.theme == "curruption" then
        _background = love.graphics.newGradient("vertical", {0, 82 / 255, 185 / 255, 1}, {139 / 255, 0, 139 / 255, 1})
    elseif meta.settings.gui.theme == "carmin" then
        _background = love.graphics.newGradient("vertical", {102 / 255, 19 / 255, 46 / 255, 1}, {60 / 255, 179 / 255, 113 / 255, 1})
    elseif meta.settings.gui.theme == "platnium" then
        _background = love.graphics.newGradient("horizontal", {0, 0, 0, 1}, {.5, .5, .5, 1})
    elseif meta.settings.gui.theme == "fox11" then
        love.graphics.setBackgroundColor(162 / 255, 112 / 255, 87 / 255, 1)
    end
    if _background then
        love.graphics.draw(_background, 0, 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    end
    --&map&--
    mapBatch:clear()
    for l = 1, getLastLayer(), 1 do
        if state == "changing_layer" then
            for _, block in ipairs(meta.map.blocks) do
                if block.layerId == layerId then
                    mapBatch:add(tileset.quads[block.textureId], block.x - editorOffSetX, block.y - editorOffSetY, block.r, block.sx, block.sy, block.ox, block.oy)
                end 
            end
        else
            for _, block in ipairs(meta.map.blocks) do
                if block.layerId == l then
                    mapBatch:add(tileset.quads[block.textureId], block.x - editorOffSetX, block.y - editorOffSetY, block.r, block.sx, block.sy, block.ox, block.oy)
                end 
            end
        end
    end
    cam:attach()
    love.graphics.draw(mapBatch)
    --&show objects&--
    for _, object in ipairs(meta.map.objects) do
        love.graphics.setColor(.25, .25, .25, .5)
        love.graphics.rectangle("fill", object.x - editorOffSetX, object.y - editorOffSetY, meta.map.grid.size, meta.map.grid.size)
        love.graphics.setColor(.5, .5, .5, 1)
        love.graphics.rectangle("line", object.x - editorOffSetX, object.y - editorOffSetY, meta.map.grid.size, meta.map.grid.size)
        love.graphics.print(object.id, object.x - editorOffSetX + meta.map.grid.size / 2, object.y - editorOffSetY + meta.map.grid.size / 2, 0, 1, 1, font:getWidth(object.id) / 2, font:getHeight() / 2)
    end
    --&GUI&--
    --%grid%--
    if meta.settings.gui.grid.show then
        love.graphics.setColor(meta.settings.gui.grid.color[1] / 255, meta.settings.gui.grid.color[2] / 255, meta.settings.gui.grid.color[3] / 255, meta.settings.gui.grid.color[4] / 100)
        for x = meta.map.grid.size * math.floor(x0 / meta.map.grid.size), x1, meta.map.grid.size do
            for y = meta.map.grid.size * math.floor(y0 / meta.map.grid.size), y1, meta.map.grid.size do
                love.graphics.rectangle("line", x, y, meta.map.grid.size, meta.map.grid.size)
            end
        end
    end
    --%show touches%--
    if meta.settings.gui.infos.touch then
        love.graphics.setColor(0, 1, 0, 1)
        for _, touch in ipairs(love.touch.getTouches()) do
            local _tx, _ty = cam:worldCoords(love.touch.getPosition(touch))
            love.graphics.rectangle("line", math.multiply(_tx, meta.map.grid.size), math.multiply(_ty, meta.map.grid.size), meta.map.grid.size, meta.map.grid.size)
            love.graphics.setColor(1, 1, 1, .75)
            love.graphics.draw(tileset.sheet, tileset.quads[textureId], math.multiply(_tx, meta.map.grid.size) + meta.map.grid.size / 2, math.multiply(_ty, meta.map.grid.size) + meta.map.grid.size / 2, blockR, blockSx, blockSy, meta.map.grid.size / 2, meta.map.grid.size / 2)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
    --&preview&--
    local _mx, _my = cam:worldCoords(love.mouse.getPosition())
    if state ~= "placing_objects" or state ~= "deleting_objects" then
        if _mx and _my then
            love.graphics.rectangle("line", math.multiply(_mx, meta.map.grid.size), math.multiply(_my, meta.map.grid.size), meta.map.grid.size, meta.map.grid.size)
            love.graphics.setColor(1, 1, 1, .75)
            love.graphics.draw(tileset.sheet, tileset.quads[textureId], math.multiply(_mx, meta.map.grid.size) + meta.map.grid.size / 2, math.multiply(_my, meta.map.grid.size) + meta.map.grid.size / 2, blockR, blockSx, blockSy, meta.map.grid.size / 2, meta.map.grid.size / 2)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
    cam:detach()
    --%tiles%--
    love.graphics.setColor(.5, .5, .5, 1)
    love.graphics.rectangle("fill", love.graphics.getWidth() - 240 + navBarx, 0, 256, love.graphics.getHeight())
    love.graphics.setColor(.25, .25, .25, 1)
    love.graphics.rectangle("fill", love.graphics.getWidth() - 256 + navBarx, 0, 16, love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1)
    local _tilex, _tiley = love.graphics.getWidth() - 224, 64
    for _, quad in ipairs(tileset.quads) do
        if _tilex + 32 > love.graphics.getWidth() then
            _tilex = love.graphics.getWidth() - 224
            _tiley = _tiley + 32
        end
        love.graphics.draw(tileset.sheet, quad, _tilex + navBarx, _tiley - (sliders.tiles.value - 10) * 32, 0, 32 / meta.map.grid.size, 32 / meta.map.grid.size)
        if quad == tileset.quads[textureId] then
            love.graphics.setColor(0, 1, 0, 1)
        end
        suit.registerHitbox(_, _tilex + navBarx, _tiley - (sliders.tiles.value - 10) * 32, 32, 32)
        if suit.mouseReleasedOn(_) then
            textureId = _
        end
        love.graphics.rectangle("line", _tilex + navBarx, _tiley - (sliders.tiles.value - 10) * 32, 32, 32)
        love.graphics.setColor(1, 1, 1, 1)
        _tilex = _tilex + 32
    end
    --%buttons%--
    for _, button in ipairs(buttons.editor.features) do
        if mobile then
            if suit.isActive(button.id) then
                love.graphics.draw(buttons.editor.sheet.texture, buttons.editor.sheet.quads[button.active], button.x, button.y, 0, 2, 2)
            else
                love.graphics.draw(buttons.editor.sheet.texture, buttons.editor.sheet.quads[button.normal], button.x, button.y, 0, 2, 2)
            end
        else
            if suit.isActive(button.id) then
                love.graphics.setColor(.25, .25, .25, 1)
            end
            love.graphics.draw(buttons.editor.sheet.texture, buttons.editor.sheet.quads[button.normal], button.x, button.y, 0, 2, 2)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
    --%infos%--
    love.graphics.draw(tileset.sheet, tileset.quads[textureId], font:getWidth(lang.editor.mode .. state) + 32, 66, blockR, 32 / meta.map.grid.size * blockSx, 32 / meta.map.grid.size * blockSy, meta.map.grid.size / 2, meta.map.grid.size / 2)
    if meta.settings.gui.theme == "light" then
        love.graphics.setColor(.25, .25, .25, 1)
    elseif meta.settings.gui.theme == "curruption" then
        love.graphics.setColor(1, 1, 0, 1)
    elseif meta.settings.gui.theme == "carmin" then
        love.graphics.setColor(0, 1, 1, 1)
    elseif meta.settings.gui.theme == "platnium" then
        love.graphics.setColor(.5, .5, .5, 1)
    elseif meta.settings.gui.theme == "fox11" then
        love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.rectangle("line", font:getWidth(lang.editor.mode .. state) + 16, 50, 32, 32)
    love.graphics.print(lang.editor.mode .. state, 0, 50)
    love.graphics.print(lang.editor.objectId .. objectId, 0, 62)
    love.graphics.print(lang.editor.layer .. layerId, 0, 74)
    love.graphics.print("X: " .. editorOffSetX .. " Y: " .. editorOffSetY, 0, 86)
    if meta.settings.gui.infos.optionals then
        love.graphics.print(lang.editor.mapName .. editor.id, 0, 98)
        love.graphics.print("FPS: " .. love.timer.getFPS() .. " RAM: " .. math.byteToSize(love.graphics.getStats().texturememory), 0, 110)
        love.graphics.print("Zoom: " .. math.round(zoom, 2), 0, 122)
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function editor:update(elapsed)
    cam:zoomTo(zoom)--camera zoom
    x0, y0 = cam:worldCoords(0, 0)
    x1, y1 = cam:worldCoords(love.graphics.getWidth(), love.graphics.getHeight())
    if #tileset.quads / 7 - 10 > 1 then
        suit.Slider(sliders.tiles, {vertical = true, id = "sliders"}, love.graphics.getWidth() - 256 + navBarx, 64, 16, love.graphics.getHeight() - 96)
    end
    if navBar then
        if navBarx > 0 then
            navBarx = navBarx - 400 * elapsed
        end
    else
        if navBarx < 256 then
            navBarx = navBarx + 400 * elapsed
        end
    end
    --&buttons&--
    for _, button in ipairs(buttons.editor.features) do
        suit.registerHitbox(button.id, button.x, button.y, button.w, button.h)
        if suit.mouseReleasedOn(button.id) then --it is same than isHit
            button.callback()
        end
    end
    --&keys&--
    for _, bind in ipairs(keybinds) do
        if love.keyboard.isDown(bind.id) then
            bind.callback()
        end
    end
    --&touches update&--
    for _, touch in ipairs(love.touch.getTouches()) do
        local _tx, _ty = love.touch.getPosition(touch) --get touch position
        if not suit.anyHovered() and (not navBar or _tx < love.graphics.getWidth() - 256) then
            _tx, _ty = cam:worldCoords(_tx, _ty)
            local centerx, centery = math.multiply(_tx, meta.map.grid.size) + editorOffSetX, math.multiply(_ty, meta.map.grid.size) + editorOffSetY
            if state == "placing_blocks" then
                if not canPlaceBlock(textureId, layerId, centerx + meta.map.grid.size / 2, centery + meta.map.grid.size / 2, blockR, blockSx, blockSy) then
                    createBlock(textureId, layerId, centerx + meta.map.grid.size / 2, centery + meta.map.grid.size / 2, blockR, blockSx, blockSy, meta.map.grid.size / 2, meta.map.grid.size / 2)
                end
            elseif state == "deleting blocks" then
                deleteBlock(layerId, centerx + meta.map.grid.size / 2, centery + meta.map.grid.size / 2)
            elseif state == "placing_objects" then
                if not canPlaceObject(objectId, centerx, centery) then
                    createObject(objectId, centerx, centery)
                end
            elseif state == "deleting_objects" then
                deleteObject(centerx, centery)
            end
        end
    end
    local _mx, _my = love.mouse.getPosition()
    if _mx and _my then
        if not suit.anyHovered() and (not navBar or _mx < love.graphics.getWidth() - 256) then
            _mx, _my = cam:worldCoords(_mx, _my)
            local centerx, centery = math.multiply(_mx, meta.map.grid.size) + editorOffSetX, math.multiply(_my, meta.map.grid.size) + editorOffSetY
            if state == "placing_blocks" then
                if not canPlaceBlock(textureId, layerId, centerx + meta.map.grid.size / 2, centery + meta.map.grid.size / 2, blockR, blockSx, blockSy) then
                    createBlock(textureId, layerId, centerx + meta.map.grid.size / 2, centery + meta.map.grid.size / 2, blockR, blockSx, blockSy, meta.map.grid.size / 2, meta.map.grid.size / 2)
                end
            elseif state == "deleting blocks" then
                deleteBlock(layerId, centerx + meta.map.grid.size / 2, centery + meta.map.grid.size / 2)
            elseif state == "placing_objects" then
                if not canPlaceObject(objectId, centerx, centery) then
                    createObject(objectId, centerx, centery)
                end
            elseif state == "deleting_objects" then
                deleteObject(centerx, centery)
            end
        end
    end
    if state == "looking" then
        zoom = touches:pinch(zoom, .5, 2)
        touches:zoomTo(zoom)
        touches:swipe(
            function(id, x, y, dx, dy, pressure, zoom)
                if x < love.graphics.getWidth() - 240 + navBarx then
                    if dx > 8 then
                        editorOffSetX = editorOffSetX - meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 500 * (dx / zoom))
                    end
                end
            end,
            function(id, x, y, dx, dy, pressure, zoom)
                if x < love.graphics.getWidth() - 240 + navBarx then
                    if dy > 8 then
                        editorOffSetY = editorOffSetY - meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 500 * (dy / zoom))
                    end
                end
            end,
            function(id, x, y, dx, dy, pressure, zoom)
                if x < love.graphics.getWidth() - 240 + navBarx then
                    if dx < -8 then
                        editorOffSetX = editorOffSetX - meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 500 * (dx / zoom))
                    end
                end
            end,
            function(id, x, y, dx, dy, pressure, zoom)
                if x < love.graphics.getWidth() - 240 + navBarx then
                    if dy < -8 then
                        editorOffSetY = editorOffSetY - meta.map.grid.size * math.floor(meta.settings.ui.touch.sensitivity / 500 * (dy / zoom))
                    end
                end
            end,
            nil
        )
    end
end

function editor:touchpressed(id, x, y, dx, dy, pressure)
    touches:touchpressed(id, x, y, dx, dy, pressure)
end

function editor:touchmoved(id, x, y, dx, dy, pressure)
    touches:touchmoved(id, x, y, dx, dy, pressure)
end

function editor:touchreleased(id, x, y, dx, dy, pressure)
    touches:touchreleased(id, x, y, dx, dy, pressure)
end

function editor:wheelmoved(x, y)
    zoom = math.clamp(.5, zoom * y, 2)
end

--&blocks&--
function createBlock(_texture, _layer, _x, _y, _r, _sx, _sy, _ox, _oy)
    table.insert(meta.map.blocks, 
        {
            textureId = _texture,
            layerId = _layer,
            x = _x, y = _y,
            r = _r,
            sx = _sx, sy = _sy,
            ox = _ox, oy = _oy
        }
    )
end

function deleteBlock(_layer, _x, _y)
    for _, block in ipairs(meta.map.blocks) do
        if block.x == _x and block.y == _y and block.layerId == _layer then
            table.insert(trash, 1, block)
            table.remove(meta.map.blocks, _)
            break
        end
    end
end

-- function deleteLayer(_layer)
--     for _, block in ipairs(meta.map.blocks) do 
--         if block.layerId == _layer then
--             table.insert(trash, 1, block)
--             table.remove(meta.map.blocks, _)
--         end
--     end
-- end

function canPlaceBlock(_texture, _layer, _x, _y, _r, _sx, _sy)
    for _, block in ipairs(meta.map.blocks) do
        if block.x == _x and block.y == _y and block.layerId == _layer then
            block.textureId = _texture
            block.r = _r
            block.sx = _sx
            block.sy = _sy
            return true
        end
    end
    return false
end

--&objects&--
function createObject(_id, _x, _y)
    table.insert(meta.map.objects, 
        {
            id = _id,
            x = _x, y = _y
        }
    )
end

function canPlaceObject(_id, _x, _y)
    for _, object in ipairs(meta.map.objects) do
        if object.x == _x and object.y == _y then
            object.id = _id
            return true
        end
    end
    return false
end

function deleteObject(_x, _y)
    for _, object in ipairs(meta.map.objects) do
        if object.x == _x and object.y == _y then
            table.remove(meta.map.objects, _)
            break
        end
    end
end

function getLastLayer()
    local lastLayer = 1
    for b, block in ipairs(meta.map.blocks) do
        lastLayer = math.max(block.layerId, lastLayer)
    end
    return lastLayer
end

return editor