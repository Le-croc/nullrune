local Mart, super = Class(Encounter)

function Mart:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Ooooo evil mart"

    -- Battle music ("battle" is rude buster)
    self.music = "Mart"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("mart")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Mart
