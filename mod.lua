function Mod:init()
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)
    love.window.setTitle("Nullrune")
    love.window.setIcon(Assets.getTextureData("window_icon"))
    print("Loaded " .. self.info.name .. "!")
end
