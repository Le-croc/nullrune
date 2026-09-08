local Celestial, super = Class(Encounter)

function Celestial:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Celestial appears."

    -- Battle music ("battle" is rude buster)
    --self.music = "It_Doesn't_End_Here"
    self.music = ""
    self.reduced_tension = true
    self.background = true

    self:addEnemy("celestial")


end

return Celestial
