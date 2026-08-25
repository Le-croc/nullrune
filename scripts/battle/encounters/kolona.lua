local kolona, super = Class(Encounter)

function kolona:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Kolona appears."

    -- Battle music ("battle" is rude buster)
    self.music = "Line_of_Fire"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the operator enemy to the encounter
    self:addEnemy("kolona")

end
return kolona
