local kolonaattack, super = Class(Wave)

function kolonaattack:init()
    super.init(self)
    
    self.time = 999
end

function kolonaattack:onStart()
    Game.battle:swapSoul(BallGameSoul())
end
function kolonaattack:update()
    if GKS == "ATTACKING" then
        GKS = "IDLE"
        local enemy = Game.battle:getEnemyBattler("kolona")
        local x, y = enemy:getRelativePos(enemy.width / 2, enemy.height / 2)
        local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self:spawnBullet("kolonabullet", x, y, angle, 12)
        for i = 1,5 do
            self:spawnBullet("kolonabullet", x, y, angle + math.rad(i)*5, 12)
            self:spawnBullet("kolonabullet", x, y, angle - math.rad(i)*5, 12)
        end
        
    end
    super.update(self)
end

return kolonaattack
