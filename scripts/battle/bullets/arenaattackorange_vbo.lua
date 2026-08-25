---@class Arenaattackorange_vbo : Bullet
local Arenaattackorange_vbo, super = Class(Bullet)
local hit = false
local timehit = 0
local killbulletcounter = 0
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
-- code for ORANGE-type attack, uses "fail" sprite and plays fail sfx upon taking damage, success sound effect upon dodging
function Arenaattackorange_vbo:onCollide(soul)
    if hit then
        return super.onCollide(self, soul)
    end
end
function Arenaattackorange_vbo:init(x, y)
    soul = Game.battle.soul
    hit = false
    timehit = 0
    killbulletcounter = 0
    super.init(self, x, y, "bullets/arenaattackorange")
    local enemy = Game.battle:getEnemyBattler("VBO")
    enemy.sprite:setSprite("attacking_f")
    Assets.playSound("VBO/VBO_Attacking")
    self.collider = Hitbox(self, 0, 0, self.width, self.height)
    self.destroy_on_hit = false
    -- ORANGE type attack code
    Game.stage.timer:every(1/30, function()
        if killbulletcounter == 7 then
            self:remove()
            enemy.sprite:setSprite("attacking_f")
            return false
        end
        timehit = timehit+1  
        killbulletcounter = killbulletcounter+1
        if soul.moving_x == 0 and soul.moving_y == 0 then
            enemy.sprite:setSprite("fail")
            if timehit < 8 then
                Assets.playSound("VBO/VBO_Fail")
                enemy.sprite:setSprite("fail")
                timehit = 9
            end     
            hit = true
        else
            if timehit == 8 then
                Assets.playSound("VBO/VBO_Success")
            end     
        end
    end)
end
--removes the bullet after a short bit
function Arenaattackorange_vbo:update()
    if killbulletcounter == 7 then
        self:remove()
        local enemy = Game.battle:getEnemyBattler("VBO")
        enemy.sprite:setSprite("attacking_f")
    end
    super.update(self)
end




return Arenaattackorange_vbo
