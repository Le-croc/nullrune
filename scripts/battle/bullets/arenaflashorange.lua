---@class Arenaflashorange : Bullet
local Arenaflashorange, super = Class(Bullet)
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet


function Arenaflashorange:onCollide(soul)
    if false then
       return super.onCollide(self, soul)
    end
end
function Arenaflashorange:init(x, y)
    super.init(self, x, y, "bullets/arenaflashorange")
    optick = 0
    self.collider = Hitbox(self, 0, 0, self.width, self.height)
end
--removes the bullet after a short bit
function Arenaflashorange:update()
    optick = optick + 1
    if optick == 7 then
        self:remove()
    end
    super.update(self)
end

return Arenaflashorange
