local VBO, super = Class(Encounter)

function VBO:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Voidbound Operator swoops in."

    -- Battle music ("battle" is rude buster)
    self.music = "Aerodynamics"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the operator enemy to the encounter
    self:addEnemy("VBO")

end
return VBO
