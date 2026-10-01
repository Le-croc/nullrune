local em2, super = Class(Wave)

function em2:init()
    super.init(self)
    self.time = 15
end
function em2:onStart()
    Game.battle:swapSoul(BallGameSoul())
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers) do
        local x, y = attacker:getRelativePos(attacker.width / 2, attacker.height / 2)
        local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self:spawnBullet("smallevilmart", x-40, y, angle, 0.7, 3)
    end
    Assets.playSound("mart/idle",  0.6)
end

function em2:update()
    super.update(self)
end

return em2
