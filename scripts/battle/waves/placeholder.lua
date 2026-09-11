local Placeholder, super = Class(Wave)

function Placeholder:init()
    super.init(self)
    self.time = 20
end
function Placeholder:onStart()
    Game.battle:swapSoul(BallGameSoul())
    self.timer:approach(1, 142, SCREEN_WIDTH, function (wid)
        if wid <= SCREEN_HEIGHT then
            self:setArenaSize(wid, wid+14)
        else
            self:setArenaPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
            self:setArenaSize(wid, Game.battle.arena.height)
        end
    end, "in-cubic")
    self.timer:every(1.2, function ()
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 1, 0.8)
    end, 3)
    self.timer:after(4.8, function ()
        Assets.playSound("celestial/1113/1113_F")
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 3, 1.5)
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 3, 1.5)
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 3, 1.5)
    end)
end

function Placeholder:update()
    super.update(self)
end

return Placeholder
