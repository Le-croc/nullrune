local Pylon, super = Class(Event, "pylon")
local interacted = false
local countdown = 40
function Pylon:init(x, y, shape)
    super.init(self, x, y, shape)
    interacted = false
    self.solid = false
    self.siner = math.random(1, 10)
    self:setSprite("objects/pylon")
    self:setScale(2)
    -- float
    Game.stage.timer:every(1/30, function ()
        self.siner = self.siner + 1/30
        self.y = self.y + math.sin(self.siner*2)/8
        if not self then return false end
    end)
    -- starts the encounter
    Game.stage.timer:every(1/30, function ()
        if not self then return false end
        if interacted then
            if countdown  == 0 then
                Game:encounter("celestial")
                return false
            elseif countdown == 10 then
                Assets.playSound("tensionhorn")
            elseif countdown == 2 then
                Assets.playSound("tensionhorn", 1, 1.1)
            end
            countdown = countdown-1
        end   
    end)
end
-- plays sound upon interacted
function Pylon:onInteract(player, dir)
    if not interacted then
        interacted = true
        Assets.playSound("altar/greed")
        countdown = 40
    end
    super.onInteract(self, player, dir)
end

return Pylon