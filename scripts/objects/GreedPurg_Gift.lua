local GreedPurg_Gift, super = Class(Event, "greedpurg_gift")

function GreedPurg_Gift:init(x, y, shape)
    super.init(self, x+21, y-4, shape)
    self.solid = false
    self.siner = math.random(1, 10)
    self:setSprite("objects/goldgih")
    self:setScale(1.5)
    Game.stage.timer:every(1/30, function ()
        self.siner = self.siner + 1/30
        self.y = self.y + math.sin(self.siner*2)/16
        if not self then return false end
    end)
end

function GreedPurg_Gift:onInteract(player, dir)
    super.onInteract(self, player, dir)
end


return GreedPurg_Gift