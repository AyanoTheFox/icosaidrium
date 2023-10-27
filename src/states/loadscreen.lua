loadscreen = {}

function loadscreen:enter()
    --&assets&--
    --%images%--
    icosaidrium = love.graphics.newImage("assets/images/icosaidrium.png")
    --%sheets%--
    buttons = {}
    buttons.editor = {}
    buttons.editor.sheet = {}
    buttons.editor.sheet.texture, buttons.editor.sheet.quads = atlasparser.getQuads("assets/sheets/Themes/pc")--
    buttons.manager = {}
    --&vars&--
    --&numbers&--
    alph = 1
    --&functions&--
    --%timer%--
    timer = timer.new() --the loadscreen duracing 2.5 seconds
    timer:after(2.5, function()
        --%assets release%--
        icosaidrium:release()
        gamestate.switch(states.manager)
    end) --when the times out
    timer:tween(2.5, _G, {alph = 0}, "in-linear") --between with the time
    --&filesystem&--
    if not love.filesystem.getInfo(".settings/settings.bin") then
        love.filesystem.createDirectory(".settings")
        love.filesystem.write(".settings/settings.bin", love.data.compress("string", "zlib",  love.filesystem.read("src/archives/settings.json")))
    end
    meta = json.decode(love.data.decompress("string", "zlib", love.filesystem.read(".settings/settings.bin"))) --get the settings
    --&translation&--
    lang = lip.load("src/translation/" .. meta.settings.gui.language .. ".ini")  
    --&buttons&
    suit.theme.color.normal = { bg = { 1, 1, 1, 0 }, fg = { 1, 1, 0, 1 } } --it remove the background
    suit.theme.color.hovered = { bg = { 1, 1, 1, 0 }, fg = { 1, 1, 0, 1 } }
    suit.theme.color.active = { bg = { 1, 1, 1, 0 }, fg = { 1, 1, 0, 1 } }
end

function loadscreen:draw()
    love.graphics.setColor(1, 1, 1, alph)
    love.graphics.draw(icosaidrium, halfScreenW, halfScreenH, 0, 4, 4, icosaidrium:getWidth() / 2, icosaidrium:getHeight() / 2)
    love.graphics.setColor(1, 1, 1, 1)
end

function loadscreen:update(elapsed)
    timer:update(elapsed)
end

return loadscreen