local Telefraggerattack, super = Class(Wave)

function Telefraggerattack:init()
    super.init(self)
    self.time = 8
end
function Telefraggerattack:onStart()
    Game.battle:swapSoul(BallGameSoul())
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers) do
        local x, y = attacker:getRelativePos(attacker.width / 2, attacker.height / 2)
        local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self:spawnBullet("smalltelefragger", x-40, y, angle, 1)
    end
end

function Telefraggerattack:update()
    super.update(self)
end

return Telefraggerattack
