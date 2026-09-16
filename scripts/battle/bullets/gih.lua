---@class gih : Bullet
local gih, super = Class(Bullet)

---@param x number
---@param y number

function gih:init(x, y)
    super.init(self, x, y, "bullets/gih")
    self.can_graze = false
end
function gih:onCollide()
    Game:giveTension(1)
    self:remove()
end

return gih
