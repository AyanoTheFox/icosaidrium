manager = {}

function manager:enter()
    --&vars&--
    --&tables&--
    buttons.manager.main = { --main buttons.manager
        {
            text = lang.manager.map,
            id = "map",
            x = 28, y = 32, w = halfScreenW - 56, h = 24,
            callback = function()
                mode = "map"
            end
        },
        {
            text = lang.manager.settings,
            x = 28, y = 64, w = halfScreenW - 56, h = 24,
            id = "settings",
            callback = function()
                mode = "settings"
            end
        },
        {
            text = lang.manager.language,
            id = "language",
            x = 28, y = 96, w = halfScreenW - 56, h = 24,
            callback = function()
                mode = "language"
            end
        },
        {
            text = lang.manager.themes,
            id = "themes",
            x = 28, y = 128, w = halfScreenW - 56, h = 24,
            callback = function()
                mode = "themes"
            end
        },
        {
            text = lang.manager.help,
            id = "help",
            x = 28, y = 160, w = halfScreenW - 56, h = 24,
            callback = function()
                love.system.openURL("https://oft-orangefoxteam.github.io/icosaidriumDocs/")
            end
        },
        {
            text = lang.manager.credits,
            id = "credits",
            x = 28, y = 192, w = halfScreenW - 56, h = 24,
            callback = function()
                love.graphics.setBackgroundColor(0, 0, 0, 1)
                gamestate.switch(states.credits)
            end
        }
    }
    buttons.manager.map = {
        {
            text = lang.manager_map.newOrLoadMap,
            id = "newOrLoadMap",
            x = halfScreenW + 18, y = 52, w = halfScreenW - 36, h = 24,
            callback = function()
                window = "newOrLoad"
            end
        },
        {
            text = lang.manager_map.renameMap,
            id = "renameMap",
            x = halfScreenW + 18, y = 116, w = halfScreenW - 36, h = 24,
            callback = function()
                window = "rename"
            end
        },
        {
            text = lang.manager_map.deleteMap,
            id = "delete",
            x = halfScreenW + 18, y = 148, w = halfScreenW - 36, h = 24,
            callback = function()
                window = "delete"
            end
        }
    }
    buttons.manager.settings = {
        {
            text = lang.manager_settings.show .. toOnAndOff(meta.settings.gui.infos.touch),
            id = "showTouch",
            x = halfScreenW + 252, y = 186, w = 128, h = 24,
            callback = function()
                meta.settings.gui.infos.touch = inverter(meta.settings.gui.infos.touch)
                buttons.manager.settings[1].text = lang.manager_settings.show .. toOnAndOff(meta.settings.gui.infos.touch)
            end
        },
        {
            text = lang.manager_settings.show .. toOnAndOff(meta.settings.gui.grid.show),
            id = "showGrid",
            x = halfScreenW + 18, y = 56, w = 128, h = 24,
            callback = function()
                meta.settings.gui.grid.show = inverter(meta.settings.gui.grid.show)
                buttons.manager.settings[2].text = lang.manager_settings.show .. toOnAndOff(meta.settings.gui.grid.show)
            end
        },
        {
            text = lang.manager_settings.optionalInfos .. toOnAndOff(meta.settings.gui.infos.optionals),
            id = "optionalInfos",
            x = halfScreenW + 18, y = 256, w = 256, h = 24,
            callback = function()
                meta.settings.gui.infos.optionals = inverter(meta.settings.gui.infos.optionals)
                buttons.manager.settings[3].text = lang.manager_settings.optionalInfos .. toOnAndOff(meta.settings.gui.infos.optionals)
            end
        }
    }
    buttons.manager.language = {
        {
            text = "deutch",
            id = "deutch",
            x = halfScreenW + 20, y = 32, w = halfScreenW - 36, h = 24,
            callback = function()
                meta.settings.gui.language = "deutch"
            end
        },
        {
            text = "espanol",
            id = "espanol",
            x = halfScreenW + 20, y = 64, w = halfScreenW - 36, h = 24,
            callback = function()
                meta.settings.gui.language = "espanol"
            end
        },
        {
            text = "englsh (EUA)",
            id = "englsh",
            x = halfScreenW + 20, y = 96, w = halfScreenW - 36, h = 24,
            callback = function()
                meta.settings.gui.language = "englsh"
            end
        },
        {
            text = "francais",
            id = "francais",
            x = halfScreenW + 20, y = 128, w = halfScreenW - 36, h = 24,
            callback = function() 
                meta.settings.gui.language = "francais"
            end
        },
        {
            text = "portugues (BR)";
            id = "portugues";
            x = halfScreenW + 20, y = 160, w = halfScreenW - 36, h = 24,
            callback = function() 
                meta.settings.gui.language = "portugues"
            end
        }
    }
    buttons.manager.themes = {
        {
            text = "light",
            id = "light",
            x = halfScreenW + 20, y = 32, w = halfScreenW - 36, h = 24,
            callback = function() 
                meta.settings.gui.theme = "light" 
            end
        };
        {
            text = "dark",
            id = "dark",
            x = halfScreenW + 20, y = 64, w = halfScreenW - 36, h = 24,
            callback = function() 
                meta.settings.gui.theme = "dark"
            end
        };
        {
            text = "carmin",
            id = "carmin",
            x = halfScreenW + 20, y = 96, w = halfScreenW - 36, h = 24,
            callback = function()
                meta.settings.gui.theme = "carmin"
            end
        };
        {
            text = "curruption",
            id = "curruption",
            x = halfScreenW + 20, y = 128, w = halfScreenW - 36, h = 24,
            callback = function()
                meta.settings.gui.theme = "curruption"
            end
        };
        {
            text = "platinium",
            id = "platinium",
            x = halfScreenW + 20, y = 160, w = halfScreenW - 36, h = 24,
            callback = function() 
                meta.settings.gui.theme = "platinium"
            end
        };
        {
            text = "fox11",
            id = "fox11",
            x = halfScreenW + 20, y = 192, w = halfScreenW - 36, h = 24,
            callback = function() 
                meta.settings.gui.theme = "fox11"
            end
        }
    }
    windowButton = {}
    windowButton.newOrLoad = function()
        if inputs.map.name.text ~= "" then
            love.graphics.setBackgroundColor(0, 0, 0, 1)
            editor.id = inputs.map.name.text
            --&sheets&--
            if mobile then
                buttons.editor.sheet.texture, buttons.editor.sheet.quads = atlasparser.getQuads("assets/sheets/Themes/" .. meta.settings.gui.theme)
            end
            if not love.filesystem.getInfo(inputs.map.name.text) then --create the map file binary with the map infos
                meta.map.grid.size = tonumber(inputs.grid.size.text)
                love.filesystem.createDirectory(inputs.map.name.text)
            end
            if not love.filesystem.getInfo(inputs.map.name.text .. "/mapbatch.bin") then
                love.filesystem.write(inputs.map.name.text .. "/mapbatch.bin", love.data.compress("string", "zlib", json.encode(meta.map)))
            end
            meta.map = json.decode(love.data.decompress("string", "zlib", love.filesystem.read(inputs.map.name.text .. "/mapbatch.bin")))
            gamestate.switch(states.editor)
        end
    end
    windowButton.rename = function()
        if love.filesystem.getInfo(inputs.map.name.text) and inputs.map.newName.text ~= "" then
            os.rename(love.filesystem.getSaveDirectory() .. "/" .. inputs.map.name.text, love.filesystem.getSaveDirectory() .. "/" .. inputs.map.newName.text)
            window = "none"
        end
    end
    windowButton.delete = function()
        if love.filesystem.getInfo(inputs.map.name.text) then
            local function recursivelyDelete(item)
                if love.filesystem.getInfo(item , "directory") then
                    for _, child in ipairs(love.filesystem.getDirectoryItems(item)) do
                        recursivelyDelete(item .. '/' .. child)
                        love.filesystem.remove(item .. '/' .. child)
                    end
                elseif love.filesystem.getInfo(item) then
                    love.filesystem.remove(item)
                end
                love.filesystem.remove(item)
            end
            recursivelyDelete(inputs.map.name.text)
            window = "none"
        end
    end
    inputs = {}
    inputs.grid = {}
    inputs.grid.r = {text = tostring(meta.settings.gui.grid.color[1])}
    inputs.grid.g = {text = tostring(meta.settings.gui.grid.color[2])}
    inputs.grid.b = {text = tostring(meta.settings.gui.grid.color[3])}
    inputs.grid.a = {text = tostring(meta.settings.gui.grid.color[4])}
    inputs.grid.size = {text = tostring(meta.settings.gui.grid.size)}
    inputs.map = {}
    inputs.map.name = {text = meta.map.name}
    inputs.map.newName = {text = "new name"}
    inputs.touch = {}
    inputs.touch.sensitivity = {text = tostring(meta.settings.ui.touch.sensitivity)}
    --&strings&--
    mode = "none"
    window = "none"
end

function manager:draw()
    --&manager screen&--
    love.graphics.setBackgroundColor(0, 0, 200 / 255, 1) --backrgound color
    love.graphics.setLineWidth(8)
    love.graphics.rectangle("line", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.line(halfScreenW - 4, 0, halfScreenW - 4, love.graphics.getHeight() - 112)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("line", 12, 12, love.graphics.getWidth() - 24, love.graphics.getHeight() - 24)
    love.graphics.line(12, love.graphics.getHeight() - 112, love.graphics.getWidth() - 12, love.graphics.getHeight() - 112)
    love.graphics.line(12, love.graphics.getHeight() - 64, love.graphics.getWidth() - 12, love.graphics.getHeight() - 64)
    --%text%--
    love.graphics.setColor(1, 1, 0, 1) --yellow
    love.graphics.print(lang.manager.tip, halfScreenW, love.graphics.getHeight() - 88, 0, 1, 1, font:getWidth(lang.manager.tip) / 2, font:getHeight() / 2)
    love.graphics.print("Icosaidrium", halfScreenW, love.graphics.getHeight() - 38, 0, 1, 1, font:getWidth("Icosaidrium") / 2, font:getHeight() / 2)
    --&gui&--
    love.graphics.setColor(1, 0, 0, 1)
    for _, button in ipairs(buttons.manager.main) do
        if mode == button.id then
            love.graphics.rectangle("fill", 28, _ * 32, halfScreenW - 56, 24, math.pi)
        end
    end
    love.graphics.setColor(1, 1, 0, 1)
    if mode == "none" then
        love.graphics.print("* " .. lang.manager.nilOption, halfScreenW + 20, 32)
    elseif mode == "settings" then
        love.graphics.print("--" .. lang.manager_settings.grid .. "--", halfScreenW + 20, 32)
        love.graphics.print("> R:", halfScreenW + 20, 96)
        love.graphics.print("> G:", halfScreenW + 256, 96)
        love.graphics.print("> B:", halfScreenW + 20, 128)
        love.graphics.print("> A:", halfScreenW + 256, 128)
        love.graphics.print("%", halfScreenW + 330, 128)
        love.graphics.print("--" .. lang.manager_settings.touch .. "--", halfScreenW + 20, 160)
        love.graphics.print("> " .. lang.manager_settings.sensitivity, halfScreenW + 20, 192)
        love.graphics.print("%", halfScreenW + 194, 192)
        love.graphics.print("--GUI--", halfScreenW + 20, 228)
    elseif mode == "map" then
        love.graphics.print("--" .. lang.manager_map.safeZone .. "--", halfScreenW + 20, 32)
        love.graphics.print("--" .. lang.manager_map.dangerZone .. "--", halfScreenW + 20, 90)
    else
        for _, button in ipairs(buttons.manager[mode]) do
            if meta.settings.gui.theme == button.id or meta.settings.gui.language == button.id then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", button.x, button.y, button.w, button.h, math.pi)
            end
        end
    end
    if window ~= "none" then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", halfScreenW - 240, halfScreenH - 112, 512, 256)
        love.graphics.setColor(.5, .5, .5, 1)
        love.graphics.rectangle("fill", halfScreenW - 256, halfScreenH - 128, 512, 256)
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.rectangle("line", halfScreenW - 239, halfScreenH - 112, 480, 224)
        love.graphics.print(window, halfScreenW, halfScreenH - 112, 0, 1, 1, font:getWidth(window) / 2, font:getHeight() / 2)
        love.graphics.print(lang.editor.mapName, halfScreenW - 223, halfScreenH - 92)
        if window == "newOrLoad" then
            love.graphics.print(lang.manager_map.gridSize .. ":", halfScreenW - 223, halfScreenH - 60)
        elseif window == "rename" then
            love.graphics.print(lang.manager_map.renameMap .. ":", halfScreenW - 223, halfScreenH - 60)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function manager:update(elapsed)
--     lang = lip.load("src/translation/" .. meta.settings.gui.language .. ".ini")
    --&gui&--
    for _, button in ipairs(buttons.manager.main) do --main buttons.manager
--         button.text = lang.manager[button.id] --it get the text from the translation path
        if suit.Button("> " .. button.text, {id = button.id, align = "left"}, button.x, button.y, button.w, button.h).hit then
            if window == "none" then
                button.callback() --call the button function
            end
        end
    end
    if mode ~= "none" then
        if window == "none" then
            for _, button in ipairs(buttons.manager[mode]) do
--              button.text = lang.manager_settings[button.id] or lang.manager_map[button.id] or button.text --update the translation
                if suit.Button("> " .. button.text, {id = button.id, align = "left"}, button.x, button.y, button.w, button.h).hit then
                    button.callback()
                end
            end
        else
            if suit.Button("X", {id = "windowExit"}, halfScreenW + 192, halfScreenH - 100, 32, 32).hit then
                window = "none"
            elseif suit.Button("Save", {id = "saveMap"}, halfScreenW + 162, halfScreenH + 92).hit then
                windowButton[window]()
            end
            suit.Input(inputs.map.name, {id = "mapName"}, halfScreenW - 223 + font:getWidth(lang.editor.mapName), halfScreenH - 98, 200, 24)
            if window == "newOrLoad" then
                suit.Input(inputs.grid.size, {id = "gridSize"}, halfScreenW - 200 + font:getWidth(lang.manager_map.gridSize), halfScreenH - 66, 200, 24)
            elseif window == "rename" then
                suit.Input(inputs.map.newName, {id = "newName"}, halfScreenW - 112 + font:getHeight(lang.manager_map.renameMap), halfScreenH - 66, 200, 24)
            end
        end
        if mode == "settings" then
            suit.Input(inputs.grid.r, {id = "gridR"}, halfScreenW + 60, 90, 64, 24)
            suit.Input(inputs.grid.g, {id = "gridG"}, halfScreenW + 296, 90, 64, 24)
            suit.Input(inputs.grid.b, {id = "gridB"}, halfScreenW + 60, 122, 64, 24)
            suit.Input(inputs.grid.a, {id = "gridA"}, halfScreenW + 296, 122, 64, 24)
            suit.Input(inputs.touch.sensitivity, {id = "sensitivity"}, halfScreenW + 160, 186, 64, 24)
        end
    end
    --&save&--
    --%tratament%--
    --$if are empety&--
    inputs.grid.r.text = inputNumberValidator(inputs.grid.r, 255)
    inputs.grid.g.text = inputNumberValidator(inputs.grid.g, 255)
    inputs.grid.b.text = inputNumberValidator(inputs.grid.b, 255)
    inputs.grid.a.text = inputNumberValidator(inputs.grid.a, 100)
    inputs.grid.size.text = inputNumberValidator(inputs.grid.size, 999)
    inputs.touch.sensitivity.text = inputNumberValidator(inputs.touch.sensitivity, 100)
    --%file%--
    meta.settings.gui.grid.color[1] = tonumber(inputs.grid.r.text)
    meta.settings.gui.grid.color[2] = tonumber(inputs.grid.g.text)
    meta.settings.gui.grid.color[3] = tonumber(inputs.grid.b.text)
    meta.settings.gui.grid.color[4] = tonumber(inputs.grid.a.text)
    meta.settings.ui.touch.sensitivity = tonumber(inputs.touch.sensitivity.text)
    love.filesystem.write(".settings/settings.bin", love.data.compress("string", "zlib", json.encode(meta)))
end

function inputNumberValidator(_input, _high)
    if _input.text == "" then 
        _input.text = "0" 
        _input.cursor = nil --reset the cursor position
    end
    local _newStr = tostring(tonumber(string.match(_input.text, "%d+")))
    if tonumber(_newStr) > _high then
        return string.sub(_newStr, 1, -2)
    else
        return _newStr
    end
end

return manager