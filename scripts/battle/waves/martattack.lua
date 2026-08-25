local Martattack, super = Class(Wave)

function Martattack:init()
    super.init(self)
    martcount = 0
    self.time = 8
end
function Martattack:onStart()
    Game.battle:swapSoul(BallGameSoul())
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers) do
        local x, y = attacker:getRelativePos(attacker.width / 2, attacker.height / 2)
        local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self:spawnBullet("smallmart", x-40, y, angle, 1)
        martcount = martcount+1
    end
    Assets.playSound("mart/idle",  0.6)
end

function Martattack:update()
    super.update(self)
end

return Martattack
