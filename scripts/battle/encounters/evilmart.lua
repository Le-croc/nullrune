local Evilmart, super = Class(Encounter)

function Evilmart:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Ooooo ACTUAL evil mart"
    -- Battle music ("battle" is rude buster)
    self.music = "vapor_buster"
    -- Enables the purple grid battle background
    self.background = true

    self:addEnemy("evilmart")

end
function Evilmart:createBackground()
    if self.background then
        if math.random(1,10) == 1 then
            return Game.battle:addChild(Sprite("evilmartbackground"))
        else
            Game.battle:addChild(BattleBackground())
        end
    end
end
return Evilmart
