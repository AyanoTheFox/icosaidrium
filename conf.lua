function love.conf(t)
--screen
    t.window.fullscreen = true
    --window screen
    t.window.title = "Icosaidrium"
    t.window.icon = "assets/images/icosaidrium.png"
    t.author = "BloodWolf"
--directory
    t.externalstorage = true
    t.identity = "icosaidrium"
--modules
    t.modules.audio = false
    t.modules.sound = false
    t.modules.thread = false
    t.modules.physics = false
end