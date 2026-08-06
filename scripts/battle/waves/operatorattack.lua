local operatorattack, super = Class(Wave)
function operatorattack:init()
    super.init(self)
    self.time = 5
end

function operatorattack:onStart()
    Game.battle:swapSoul(DashSoul())
    local x = SCREEN_WIDTH/2
    local y = SCREEN_HEIGHT/2-68
    local enemy = Game.battle:getEnemyBattler("operator")
    enemy.sprite:setSprite("attacking")
    Assets.playSound("Operator_Ticking")
    local tick = 0
    self.timer:every(0.2, function()
        tick = tick+1
        if tick == 4 or tick == 9 or tick == 14 then
            self:spawnBullet("arenaflashblue", x, y)
        elseif tick == 19  then
            self:spawnBullet("arenaattackblue_op", x, y)
        else
        end
    end)
end
function operatorattack:onEnd()
    local enemy = Game.battle:getEnemyBattler("operator")
    enemy.sprite:setSprite("idle")
end

return operatorattack
