local CelestialSpawn, super = Class(Event, "celestialspawn")
local interacted = false
local countdown = 40
function CelestialSpawn:init(x, y, shape)
    super.init(self, x, y, shape)
    interacted = false
    self.solid = false
    self:setSprite("objects/celespawn1")
    self:setScale(1)
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
function CelestialSpawn:onInteract(player, dir)
    if not interacted then
        self:setSprite("objects/celespawn2")
        interacted = true
        Assets.playSound("altar/greed")
        countdown = 40
    end
    super.onInteract(self, player, dir)
end

return CelestialSpawn