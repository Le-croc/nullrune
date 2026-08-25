local Scrapmaw, super = Class(Encounter)

function Scrapmaw:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Crapmaw"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the operator enemy to the encounter
    self:addEnemy("scrapmaw")

end
return Scrapmaw
