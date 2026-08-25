local Flame, super = Class("KolonaPart")

function Flame:init(x, y)
    super.init(self, "enemies/kolona/flame/flame", x, y)
    self.anim_timer = 0
    Game.stage.timer:every(0.1, function ()
        if not self then return false end
        self.sprite:setFrame(self.anim_timer%4)
        self.anim_timer = self.anim_timer+1  
    end)
end

function Flame:update()
    super.update(self)
end

return Flame