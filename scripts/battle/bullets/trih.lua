---@class trih : Bullet
local trih, super = Class(Bullet)
local resize = 3/2
---@param x number
---@param y number

function trih:init(x, y)
    super.init(self, x, y, "bullets/trih/trih1")
    local tick=math.random(1,4)
    self.can_graze = false
    self.collider =  Hitbox(self,3,3,22,22)
    self:setScaleOrigin(1/2,1/2)
    self:setScale(1)
    Game.stage.timer:every(1/math.random(4,6), function ()
        if self.scale_y ~=1 then return false 
        else
            tick = tick+1
            if tick%4==0 then self:setSprite("bullets/trih/trih1")
            elseif tick%4==1 then self:setSprite("bullets/trih/trih2")
            elseif tick%4==2 then self:setSprite("bullets/trih/trih3")
            elseif tick%4==3 then self:setSprite("bullets/trih/trih2")
            end
        end
        
    end)
end
function trih:onCollide()
    Assets.playSound("other/TripmineExplosion")
    for _, battler in ipairs(Game.battle.party) do
        battler:hurt(math.random(60,80), false)
    end
    self.collider =  nil
    self:setSprite("bullets/trih/trihexplode")
    Game.stage.timer:approach(1/12, 1, 1.5, function(x)
        self:setScale(x*resize)
    end, "out-sine")
    Game.stage.timer:after(1/12, function ()
        Game.stage.timer:approach(1/6, 1.5, 0, function(x)
            self:setScale(x*resize)
        end, "out-sine")
    end)
    Game.stage.timer:after(1/4, function ()
        self:remove()
    end)
    
end

return trih
