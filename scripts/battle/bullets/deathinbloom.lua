---@class deathinbloom : Bullet
local deathinbloom, super = Class(Bullet)

---@param x number 
---@param y number

function deathinbloom:init(x, y)
    super.init(self, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, "bullets/deathinbloom/")
    self:setScale(1)
    self:setRotationOrigin(0.5, 0.5)
    self.can_graze = false
    self.destroy_on_hit = false
    self.rotation = math.rad(math.random(0, 360))
    self.collider = nil
    Assets.playSound("celestial/dib/Death_in_Bloom_Firing")
    local tick = 0
    Game.stage.timer:every(1/10, function ()
        if self then
            if tick%5 == 0 then self:setSprite("bullets/deathinbloom/DIB1")
            elseif tick%5 == 1 then self:setSprite("bullets/deathinbloom/DIB2")
            elseif tick%5 == 2 then self:setSprite("bullets/deathinbloom/DIB3")
            elseif tick%5 == 3 then self:setSprite("bullets/deathinbloom/DIB4")
            elseif tick%5 == 4 then self:setSprite("bullets/deathinbloom/DIB5")
            end
            tick = tick+1
        else
            return false
        end
    end)
    Game.stage.timer:every(1/30, function ()
        if self and Game.battle.soul then
            local angle = MathUtils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)+math.pi
            if (math.abs(math.deg(self.rotation))+180)%360-(math.abs(math.deg(angle))+180)%360 <= 90 and (math.abs(math.deg(self.rotation))+180)%360-(math.abs(math.deg(angle))+180)%360 >= 0 then self.rotation=self.rotation-math.rad(1)
            elseif (math.abs(math.deg(self.rotation))+180)%360-(math.abs(math.deg(angle))+180)%360 >= -90 and (math.abs(math.deg(self.rotation))+180)%360-(math.abs(math.deg(angle))+180)%360 <= 0 then self.rotation=self.rotation+math.rad(1)
        end
        else return false
        end
    end)
end

function deathinbloom:update()
    super.update(self)
end

return deathinbloom
