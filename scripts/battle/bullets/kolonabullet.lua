---@class KolonaBullet : Bullet
local KolonaBullet, super = Class(Bullet)

---@param x number 
---@param y number 
---@param dir number 
---@param speed number 
function KolonaBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/firebullet")
    self.physics.direction = dir
    self.physics.speed = speed
end

function KolonaBullet:update()
    super.update(self)
end

return KolonaBullet
