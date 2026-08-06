---@class Arenaattackblue_vbo : Bullet
local Arenaattackblue_vbo, super = Class(Bullet)

---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
-- code for BLUE-type attack, uses "fail" sprite and plays fail sfx upon taking damage, success sound effect upon dodging
function Arenaattackblue_vbo:onCollide(soul)
    timehit = timehit+1  
    killbulletcounter = killbulletcounter+1
    if soul.moving_x ~= 0 or soul.moving_y ~= 0 then
        local enemy = Game.battle:getEnemyBattler("VBO")
        enemy.sprite:setSprite("fail")
        if timehit < 8 then
            Assets.playSound("VBO_Fail")
            local enemy = Game.battle:getEnemyBattler("VBO")
            enemy.sprite:setSprite("fail")
            timehit = 9
        end     
        return super.onCollide(self, soul)
    else
        if timehit == 8 then
            Assets.playSound("VBO_Success")
        end     
    end
end
function Arenaattackblue_vbo:init(x, y)
    timehit = 0
    killbulletcounter = 0
    super.init(self, x, y, "bullets/arenaattackblue")
    local enemy = Game.battle:getEnemyBattler("VBO")
    enemy.sprite:setSprite("attacking_f")
    Assets.playSound("VBO_Attacking")
    self.collider = Hitbox(self, 0, 0, self.width, self.height)
    self.destroy_on_hit = false
end
--removes the bullet after a short bit
function Arenaattackblue_vbo:update()
    if killbulletcounter == 7 then
        self:remove()
        local enemy = Game.battle:getEnemyBattler("VBO")
        enemy.sprite:setSprite("attacking_f")
    end
    super.update(self)
end




return Arenaattackblue_vbo
