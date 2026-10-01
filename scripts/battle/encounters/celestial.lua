local Celestial, super = Class(Encounter)

function Celestial:init()
    super.init(self)
    Game:setMaxTension(400)
    Game.isCelestial=true
    
    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Celestial appears."

    -- Battle music ("battle" is rude buster)
    --self.music = "It_Doesn't_End_Here"
    self.music = none
    self.background = true

    self:addEnemy("celestial")


end
function Celestial:onBattleEnd()
    Game:setMaxTension(100)
    Game.isCelestial = false
end
return Celestial
