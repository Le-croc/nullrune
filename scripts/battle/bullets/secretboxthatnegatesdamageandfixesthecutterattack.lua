---@class secretboxthatnegatesdamageandfixesthecutterattack : Bullet
local secretboxthatnegatesdamageandfixesthecutterattack, super = Class(Bullet)

---@param x number 
---@param y number
---@param rotation number

function secretboxthatnegatesdamageandfixesthecutterattack:init(x, y, rotation)
    super.init(self, x, y, nil)
    self.can_graze = false
    touchingmagicbox = false
    self.rotation = math.rad(rotation)
    self.destroy_on_hit = false
    self.collider = Hitbox(self, -6, -6, 12, 12)
    Game.stage.timer:approach(1.7, math.rad(rotation), math.rad(rotation+360), function (r)
        self.rotation = r
    end, "outCirc")
    Game.stage.timer:after(1.7, function () 
        Game.stage.timer:after(0.8, function ()
            self.collider = nil
            self:remove()
        end)
    end)
    Game.stage.timer:every(1/30, function () 
        if touchingmagicbox then
            touchingmagicbox = false
        end
    end)
end

function secretboxthatnegatesdamageandfixesthecutterattack:onCollide(soul)
    touchingmagicbox = true
end

return secretboxthatnegatesdamageandfixesthecutterattack
