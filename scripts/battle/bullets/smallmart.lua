---@class SmallMart : Bullet
local SmallMart, super = Class(Bullet)
local tick = 0
local martfusetick=0
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
---@param dir number # The dir (in radians) of the bullet
---@param speed number # The speed the bullet will move at in the specified direction
-- init
function SmallMart:init(x, y, dir, speed)
    tick = 0
    martfusetick = 0
    self.notedirection = dir
    self.fused = false
    super.init(self, x, y, "bullets/mart")
    self.collider = Hitbox(self, 10, 10, self.width/2, self.height/2)
    self.physics.direction = dir
    self.physics.speed = speed + 3
    self.storespeed = speed
    self.destroy_on_hit = false
    self:setScale(1.5)
    self.keepmart = false
    --makes mart follow SOUL and fuse
    Game.stage.timer:every(1/30, function()
        if Game.battle:getState()  == "DEFENDING" then
            tick = tick+1
            self.physics.direction = MathUtils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
            if tick/martcount > 20 then self.physics.speed = self.storespeed end
            --fusion
            if martcount > 1 then
                if tick >= 90*martcount and tick < 91*martcount then
                    martfusetick = martfusetick + 1
                    if martfusetick < martcount then
                        self:remove()
                    else
                        self:setScale(1.5+martcount/3)
                    end
                end
                if tick>91*martcount then 
                    self.physics.speed = self.storespeed + martcount/3 
                    self.fused = true
                end
            end
        else
            return false
        end
    end)
end
-- mart damage sound
---@param soul Soul
function SmallMart:onDamage(soul)
    local damage = self:getDamage()
    if self.fused then
        damage = damage*martcount
    end
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

return SmallMart
