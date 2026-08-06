local Operator, super = Class(Encounter)

function Operator:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Operator swoops in."

    -- Battle music ("battle" is rude buster)
    self.music = "Self_Destruct"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the operator enemy to the encounter
    self:addEnemy("operator")

end
return Operator
