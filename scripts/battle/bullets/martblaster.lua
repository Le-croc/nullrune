---@class martspiral : Bullet
local martspiral, super = Class(Bullet)
---@param x number 
---@param y number
---@param rotation number
function martspiral:init(x, y, rotation)
    super.init(self, x, y, "bullets/evilmart/Martlonger")
    self.can_graze = true
    self.rotation=rotation
    self.destroy_on_hit = false
    Game.stage.timer:every(1/30, function () 
        self.rotation=self.rotation-math.rad(3)
    end)
end


return martspiral
