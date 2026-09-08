local Telefragger, super = Class(Encounter)

function Telefragger:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Telefragger teleported in."

    -- Battle music ("battle" is rude buster)
    self.music = "Seems_you_got_Telefragged"
    self.background = true

    self:addEnemy("telefragger")


end

return Telefragger
