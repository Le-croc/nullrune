---@class Bell : Bullet
local Bell, super = Class(Bullet)
local ring = 0
local bulletx = 0
local bullety = 0
local bx = 0
local by = 0
local tookdamage = false
local rungmax = 20 -- how much to have the rung sprite for in frames
local oncooldown = 0
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet

function Bell:init(x, y)
    --init
    self.rung = 0
    local tick = 0
    tookdamage = false
    local enemy = Game.battle:getEnemyBattler("bell")
    enemy.sprite:setRotationOrigin(0.5, 0)
    ring = 0
    oncooldown = 0
    super.init(self, x, y, "bullets/bell")
    bulletx = x
    bullety = y
    self.sprite:setScale(0)
    self.sprite:setRotationOrigin(0.5, 0.5)
    self.sprite.rotation = math.rad(45)
    self.collider = nil
    -- once every tick
    Game.stage.timer:every(1/30, function()
        -- bell anim
        tick = tick+1
        if tick == 1 then self.sprite:setScale(1/6)
        elseif tick == 2 then self.sprite:setScale(1/4)
        self.sprite.rotation = math.rad(30)
        Assets.playSound("bell/appear")
        elseif tick == 3 then self.sprite:setScale(1/3)
        self.sprite.rotation = math.rad(15)
        elseif tick == 4 then self.sprite:setScale(1/2)
        self.sprite.rotation = 0
        self.collider = Hitbox(self, self.width/8, self.height/8, self.width/4, self.height/4)
        bx = self.width/2
        by = self.height/2
        end
        -- ring anim
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
        --cooldown on ring
        if oncooldown ~= 0 then oncooldown = oncooldown-1 end
        -- go to normal sprite on waveend
        if Game.battle:getState() ~= "DEFENDING" then 
            enemy:setSprite("idle") 
            return false
        end
    end)
end
-- makes soul move away from bell
function Bell:doRing(soul)
    if bullety-soul.y > by then Game.stage.timer:every(1/30, function() soul:move(0, -20) end, 3)
    elseif soul.y-bullety > by then Game.stage.timer:every(1/30, function() soul:move(0, 20) end, 3) end
    if bulletx-soul.x > bx then Game.stage.timer:every(1/30, function() soul:move(-20, 0) end, 3)
    elseif soul.x-bulletx > bx then Game.stage.timer:every(1/30, function() soul:move(20, 0) end, 3) end
end

function Bell:onDamage(soul)
    if oncooldown == 0 then 
        if ring < 4 then
        ring = ring+1
        end
        if ring == 1 then
            Assets.playSound("bell/ring")
            Bell:doRing(soul)
            self.rung =  20
        elseif ring == 2 then
            Assets.playSound("bell/ring2")
            Bell:doRing(soul)
            self.rung =  20
        elseif ring == 3 then
            Assets.playSound("bell/ring3")
            Bell:doRing(soul)
            Assets.playSound("bell/overtuned")
            self.rung =  20
        elseif ring == 4 and not tookdamage then
            tookdamage = true
            local enemy = Game.battle:getEnemyBattler("bell")
            Assets.playSound("bell/death")
            Game.stage.timer:after(1, function() super.onDamage(self, soul) end)
            Game.stage.timer:after(2, function() Game.battle:endWaves() enemy:setSprite("idle") end)
            Game.stage.timer:every(1/30, function() soul.x  = self.x-bx soul.y = self.y-by end)
        end
        oncooldown = 30
    end
end

function Bell:update()
    super.update(self)
end

return Bell
