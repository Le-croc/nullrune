---@class Smalltelefragger : Bullet
local Smalltelefragger, super = Class(Bullet)
local tick = 0
---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
---@param dir number # The dir (in radians) of the bullet
---@param speed number # The speed the bullet will move at in the specified direction
---@param soul Soul
-- init
function Smalltelefragger:init(x, y, dir, speed)
    tick = 0
    self.notedirection = dir
    self.fused = false
    super.init(self, x, y, "bullets/telefragger/step1")
    self.collider = Hitbox(self, 10, 10, self.width/2, self.height/2)
    self.physics.direction = dir
    self.physics.speed = speed + 3
    self.destroy_on_hit = false
    self.sprite:setSprite("bullets/telefragger/step1")
    self:setScaleOrigin(1/2, 1/2)
    self:setScale(0.5)
    --makes telefragger follow soul and walk
    Game.stage.timer:every(1/30, function()
        if Game.battle:getState()  == "DEFENDING" then
            tick = tick+1
            if tick%15 == 0 then
                if math.floor(tick/15)%2 == 0 then
                    if self.x > Game.battle.soul.x then
                        self.sprite:setSprite("bullets/telefragger/step1")
                    else
                        self.sprite:setSprite("bullets/telefragger/mstep1")
                    end
                else
                    if self.x > Game.battle.soul.x then
                        self.sprite:setSprite("bullets/telefragger/step2")
                    else
                        self.sprite:setSprite("bullets/telefragger/mstep2")
                    end
                end
                if math.floor(tick/15)%4 == 0 then Assets.playSound("telefragger/step1", 1/2)
                elseif math.floor(tick/15)%4 == 1 then Assets.playSound("telefragger/step2", 1/2)
                elseif math.floor(tick/15)%4 == 2 then Assets.playSound("telefragger/step3", 1/2)
                elseif math.floor(tick/15)%4 == 3 then Assets.playSound("telefragger/step4", 1/2)
                end
            end
            if tick == 30 then
                self.physics.speed = self.physics.speed-2.5
            end
            if tick%60 == 0 then
                self:teleport()
            elseif tick%60 == 35 then
                Assets.playSound("telefragger/teleport")
            end
            self.physics.direction = MathUtils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
        else
            return false
        end
    end)
end

function Smalltelefragger:teleport()
    -- checks direction
    local tpdistance = 50
    local tp_dir = nil
    if Input.down("left") and ((not Input.down("up") and not Input.down("down")) or (Input.down("up") and Input.down("down"))) then tp_dir = 9 end
    if Input.down("right") and ((not Input.down("up") and not Input.down("down")) or (Input.down("up") and Input.down("down"))) then tp_dir = 3 end
    if Input.down("up") and ((not Input.down("left") and not Input.down("right")) or (Input.down("left") and Input.down("right"))) then tp_dir = 12 end
    if Input.down("down") and ((not Input.down("left") and not Input.down("right")) or (Input.down("left") and Input.down("right"))) then tp_dir = 6 end
    if Input.down("left") and Input.down("up") then tp_dir = 10.5 end
    if Input.down("left") and Input.down("down") then tp_dir = 7.5 end
    if Input.down("right") and Input.down("up") then tp_dir = 1.5 end
    if Input.down("right") and Input.down("down") then tp_dir = 4.5 end
    local direction = tp_dir
    --teleports telefragger
    local soul = Game.battle.soul
    if direction == 12 then self.y = soul.y - tpdistance self.x = soul.x
    elseif direction == 1.5 then self.x = soul.x + tpdistance self.y = soul.y - tpdistance
    elseif direction == 3 then self.x = soul.x + tpdistance self.y = soul.y
    elseif direction == 4.5 then self.x = soul.x + tpdistance self.y = soul.y + tpdistance
    elseif direction == 6 then self.y = soul.y + tpdistance self.x = soul.x
    elseif direction == 7.5 then self.x = soul.x - tpdistance self.y = soul.y + tpdistance
    elseif direction == 9 then self.x = soul.x - tpdistance self.y = soul.y
    elseif direction == 10.5 then self.x = soul.x - tpdistance self.y = soul.y - tpdistance
    else self.x = soul.x + tpdistance self.y = soul.y
    end
end

return Smalltelefragger
