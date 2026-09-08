local Placeholder, super = Class(Wave)

function Placeholder:init()
    super.init(self)
    self.time = 8
end
function Placeholder:onStart()
    Game.battle:swapSoul(BallGameSoul())
    self.timer:approach(1, 142, SCREEN_WIDTH, function (wid)
        if wid <= SCREEN_HEIGHT then
            self:setArenaSize(wid, wid+13)
        else
            self:setArenaPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
            self:setArenaSize(wid, Game.battle.arena.height)
        end
    end, "in-cubic")
end

function Placeholder:update()
    super.update(self)
end

return Placeholder
