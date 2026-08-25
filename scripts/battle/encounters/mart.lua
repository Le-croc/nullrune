local Mart, super = Class(Encounter)

function Mart:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Ooooo evil mart"

    -- Battle music ("battle" is rude buster)
    self.music = "Mart"
    -- Enables the purple grid battle background
    self.background = true

    self:addEnemy("mart")
    self:addEnemy("mart")
    self:addEnemy("mart")

end

return Mart
