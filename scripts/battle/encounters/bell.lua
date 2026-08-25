local Bell, super = Class(Encounter)

function Bell:init()
    super.init(self)

    self.text = "* Bell appears."

    self.music = "Kenophobia"
    self.background = true

    self:addEnemy("bell")


end

return Bell
