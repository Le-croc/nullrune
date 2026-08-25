local GreedPurg_Base, super = Class(Event, "greedpurg_base")
local interacted = false
local countdown = 40
function GreedPurg_Base:init(x, y, shape)
    super.init(self, x, y, shape)
    interacted = false
    self.solid = false
    self:setSprite("objects/greedempty")
    self:setScale(1.5)
    -- starts the encounter
    Game.stage.timer:every(1/30, function ()
        if not self then return false end
        if interacted then
            if countdown  == 0 then
                Game:encounter("mart_pa")
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
function GreedPurg_Base:onInteract(player, dir)
    if not interacted then
        interacted = true
        Assets.playSound("altar/greed")
        countdown = 40
    end
    super.onInteract(self, player, dir)
end



return GreedPurg_Base