local Bell, super = Class(Wave)
function Bell:init()
    super.init(self)
    self.time = 10
end

function Bell:onStart()
    Game.battle:swapSoul(BallGameSoul())
    local x = MathUtils.random(Game.battle.arena.left, Game.battle.arena.right)
    local y = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
    local bullet = self:spawnBullet("bell", x, y)
    bullet.destroy_on_hit = false
end

function Bell:update()


    super.update(self)
end

return Bell
