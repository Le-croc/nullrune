---@class Arenaattackblue_op : Bullet
local Arenaattackblue_op, super = Class(Bullet)

---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
-- code for BLUE-type attack, uses "fail" sprite and plays fail sfx upon taking damage, success sound effect upon dodging
function Arenaattackblue_op:onCollide(soul)
    
end
function Arenaattackblue_op:init(x, y)
    local timehit = 0
    local soul = Game.battle.soul
    super.init(self, x, y, "bullets/arenaattackblue")
    self.collider = Hitbox(self, 0, 0, self.width, self.height)
    self.destroy_on_hit = false

    Game.stage.timer:every(1/30, function ()
        timehit = timehit+1  
        if soul.moving_x ~= 0 or soul.moving_y ~= 0 then
            local enemy = Game.battle:getEnemyBattler("operator")
            enemy.sprite:setSprite("fail")
            if timehit < 15 then
                Assets.playSound("operator/Operator_Fail")
                timehit = 16
            end     
            return super.onCollide(self, soul)
        else
            if timehit == 15 then
                Assets.playSound("operator/Operator_Success")
                local enemy = Game.battle:getEnemyBattler("operator")
                enemy.sprite:setSprite("idle")
                self:remove()
                return false
            end     
        end  
    end)
end



return Arenaattackblue_op
