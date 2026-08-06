---@class Arenaflashblue : Bullet
local Arenaflashblue, super = Class(Bullet)
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
--code for BLUE-type attack
--function Arenaflash:onCollide(soul)
--    if soul.moving_x ~= 0 or soul.moving_y ~= 0 then
--        return super.onCollide(self, soul)
--    end
--end

function Arenaflashblue:onCollide(soul)
    if false then
       return super.onCollide(self, soul)
    end
end
function Arenaflashblue:init(x, y)
    super.init(self, x, y, "bullets/arenaflashblue")
    optick = 0
    self.collider = Hitbox(self, 0, 0, self.width, self.height)
end
--removes the bullet after a short bit
function Arenaflashblue:update()
    optick = optick + 1
    if optick == 7 then
        self:remove()
    end
    super.update(self)
end


return Arenaflashblue
