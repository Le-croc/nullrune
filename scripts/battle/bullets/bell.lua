---@class Bell : Bullet
local Bell, super = Class(Bullet)
local ring = 0 -- nr of rings in a wave
local sbx = 0 -- bullet size
local sby = 0
local ly = 0 -- bullet middle location
local lx = 0
local rungmax = 20 -- how much to have the rung sprite for in frames
local oncooldown = 0
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet

function Bell:init(x, y)
    --init
    self.rung = 0  -- timer for ring sprite
    local tick = 0
    self.tookdamage = false
    local enemy = Game.battle:getEnemyBattler("bell")
    enemy.sprite:setRotationOrigin(0.5, 0)
    ring = 0
    oncooldown = 0
    super.init(self, x+64, y+64, "bullets/bell")
    ly = y+19
    lx = x+21
    self.sprite:setScale(0)
    self.sprite:setRotationOrigin(0.5, 0.5)
    self.sprite.rotation = math.rad(45)
    self.collider = nil
    -- once every tick
    Game.stage.timer:every(1/30, function()
        -- bell appear anim
        tick = tick+1
        if tick == 1 then self.sprite:setScale(1/8)
        elseif tick == 2 then self.sprite:setScale(1/7)
        self.sprite.rotation = math.rad(30)
        Assets.playSound("bell/appear")
        elseif tick == 3 then self.sprite:setScale(1/5)
        self.sprite.rotation = math.rad(15)
        elseif tick == 4 then self.sprite:setScale(1/3)
        self.sprite.rotation = 0
        self.collider = Hitbox(self, self.width/12, self.height/12, self.width/6, self.height/6)
        sbx = self.width/3
        sby = self.height/3
        end
        -- ring anim for the bell enemy
        if self.rung == rungmax then
            if ring ~= 3 then
                enemy:setSprite("ring")
            else 
                enemy:setSprite("angry")
            end
        end
        if self.rung ~= 0 then
            self.rung=self.rung-1
        else if ring ~= 3 and ring ~= 4 then enemy:setSprite("idle") end
        end
        -- bell swing thank you ifelse gods i swear i'll fix this when im less lazy
        if self.rung == 19 then enemy.sprite.rotation = math.rad(-15)
        elseif self.rung == 18 then enemy.sprite.rotation = math.rad(-30)
        elseif self.rung == 17 then enemy.sprite.rotation = math.rad(-45)
        elseif self.rung == 16 then enemy.sprite.rotation = math.rad(-30)
        elseif self.rung == 15 then enemy.sprite.rotation = math.rad(-15)
        elseif self.rung == 14 then enemy.sprite.rotation = math.rad(0)
        elseif self.rung == 13 then enemy.sprite.rotation = math.rad(7)
        elseif self.rung == 12 then enemy.sprite.rotation = math.rad(14)
        elseif self.rung == 11 then enemy.sprite.rotation = math.rad(21)
        elseif self.rung == 10 then enemy.sprite.rotation = math.rad(14)
        elseif self.rung == 9 then enemy.sprite.rotation = math.rad(7)
        elseif self.rung == 8 then enemy.sprite.rotation = math.rad(0)
        elseif self.rung == 7 then enemy.sprite.rotation = math.rad(-3)
        elseif self.rung == 6 then enemy.sprite.rotation = math.rad(-6)
        elseif self.rung == 5 then enemy.sprite.rotation = math.rad(-9)
        elseif self.rung == 4 then enemy.sprite.rotation = math.rad(-6)
        elseif self.rung == 3 then enemy.sprite.rotation = math.rad(-3)
        elseif self.rung == 2 then enemy.sprite.rotation = math.rad(0)
        end
        --cooldown on ring and change sprite
        if oncooldown ~= 0 then oncooldown = oncooldown-1 self:setSprite("enemies/bell/ring") self.sprite:setScale(1/3)
        else if ring>0 then self:setSprite("enemies/bell/idle") self.sprite:setScale(1/3) end end
        -- go to normal sprite on waveend
        if Game.battle:getState() ~= "DEFENDING" then 
            enemy:setSprite("idle") 
            return false
        end
    end)
end
-- makes soul move away from bell
function Bell:doRing(soul)
    if ly-sby/2 > soul.y then Game.stage.timer:every(1/30, function() soul:move(0, -20) end, 3)
    elseif soul.y > ly+sby/2 then Game.stage.timer:every(1/30, function() soul:move(0, 20) end, 3) end
    if lx-sbx/2 > soul.x then Game.stage.timer:every(1/30, function() soul:move(-20, 0) end, 3)
    elseif soul.x > lx+sbx/2 then Game.stage.timer:every(1/30, function() soul:move(20, 0) end, 3) end
end


function Bell:onDamage(soul)
    -- handles bell's attack
    if oncooldown == 0 then
        if ring < 4 then
        ring = ring+1
        Bell:doRing(soul)
        end
        if ring == 1 then
            Assets.playSound("bell/ring")
            self.rung =  20
        elseif ring == 2 then
            Assets.playSound("bell/ring2")
            self.rung =  20
        elseif ring == 3 then
            Assets.playSound("bell/ring3")
            self.rung =  20
        elseif ring == 4 and not self.tookdamage then
            self.tookdamage = true
            local enemy = Game.battle:getEnemyBattler("bell")
            Assets.playSound("bell/death")
            self.can_graze = false
            Game.stage.timer:after(1, function() super.onDamage(self, soul) end)
            Game.stage.timer:after(2, function() Game.battle:endWaves() enemy:setSprite("idle") end)
            Game.stage.timer:every(1/30, function() soul.x  = lx soul.y = ly end)
        end
        oncooldown = 6
    end
end

function Bell:update()
    super.update(self)
end

return Bell
