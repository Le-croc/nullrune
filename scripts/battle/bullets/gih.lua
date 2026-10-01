---@class gih : Bullet
local gih, super = Class(Bullet)

---@param x number
---@param y number

function gih:init(x, y)
    super.init(self, x, y, "bullets/gih")
    self.can_graze = false
    self:setScaleOrigin(1/2,1/2)
end
function gih:onCollide()
    local tick = 0
    Game:giveTension(1)
    Assets.playSound("other/GiftCollect")
    self.collider =  nil
    self:setSprite("bullets/gihcollect")
    self:setScale(3/4, 2.5)
    Game.stage.timer:every(1/30, function()
        tick = tick+1
        if tick == 5 then self:remove()
        elseif tick == 4 then self:setScale(1.3, 0.5)
        elseif tick == 3 then self:setScale(2.5, 3/4)
        elseif tick == 2 then self:setScale(1.7, 3/4)
        elseif tick == 1 then self:setScale(3/4, 1.7)
        end
        end, 5)
end

return gih
