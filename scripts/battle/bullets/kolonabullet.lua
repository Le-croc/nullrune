---@class KolonaBullet : Bullet
local KolonaBullet, super = Class(Bullet)
---@param x number 
---@param y number 
---@param dir number 
---@param speed number 
function KolonaBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/firebullet_1")
    self.physics.direction = dir
    self.physics.speed = speed
end
function KolonaBullet:onDamage(soul)
    playertookdamage = true
    return super.onDamage(self, soul)
end
function KolonaBullet:update()
    super.update(self)
end

return KolonaBullet
