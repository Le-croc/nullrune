---@class SmallEvilMart : Bullet
local SmallEvilMart, super = Class(Bullet)
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
---@param dir number # The dir (in radians) of the bullet
---@param speed number # The speed the bullet will move at in the specified direction
---@param scale number
-- init
function SmallEvilMart:init(x, y, dir, speed, scale)
    self.notedirection = dir
    super.init(self, x, y, "bullets/evilmart/MartLaserEyes")
    self:setScale(scale)
    self.collider = Hitbox(self, self.width/4, self.height/4, self.width/2, self.height/2)
    self.physics.direction = dir
    if scale==1 then
    self.physics.speed = speed + 3
    else
    self.physics.speed=speed
    end
    self.storespeed = speed
    self.destroy_on_hit = false
    
    --makes mart follow SOUL and fuse
    Game.stage.timer:every(1/30, function()
        if Game.battle:getState()  == "DEFENDING" then
            self.physics.direction = MathUtils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)     
        else
            return false
        end
    end)
end
-- mart damage sound
function SmallEvilMart:onDamage(soul)
    local damage = self:getDamage()
    if damage > 0 then
        local target = self:getTarget()
        local battlers = Game.battle:hurt(damage, false, target, self:shouldSwoon(damage, target, soul))
        local inv_frames = self:getInvulnFrames()
        if target ~= "ALL" then
            inv_frames = Game:applyInvulnBonuses(inv_frames)
        end
        Game:setInvulnFrames(inv_frames)
        soul:onDamage(self, damage)
        return battlers
    end
    Assets.playSound("mart/kill")
end

return SmallEvilMart
