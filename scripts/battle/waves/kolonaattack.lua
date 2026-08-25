local kolonaattack, super = Class(Wave)

function kolonaattack:init()
    super.init(self)
    self.time = 999
end

function kolonaattack:onStart()
    Game.battle:swapSoul(BallGameSoul())
    --used for the red wreath spin
    playertookdamage = false
end
function kolonaattack:update()
    -- bullets
    if GKS == "ATTACKING" then
        GKS = "IDLE"
        local enemy = Game.battle:getEnemyBattler("kolona")
        local x, y = enemy:getRelativePos(enemy.width / 2, enemy.height / 2)
        local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self:spawnBullet("kolonabullet", x, y, angle, 24)
        for i = 1,5 do
            self:spawnBullet("kolonabullet", x, y, angle + math.rad(i)*5, 24)
            self:spawnBullet("kolonabullet", x, y, angle - math.rad(i)*5, 24)
        end
        
    end
    super.update(self)
end

return kolonaattack
