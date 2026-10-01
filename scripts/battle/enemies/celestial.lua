local Celestial, super = Class(EnemyBattler)

function Celestial:init()
    super.init(self)
    self.name = "Celestial"
    self:setActor("celestial")
    self.max_health = 100000
    self.health = 100000
    self.attack = 25
    self.defense = 25
    self.money = 100
    self.spare_points = 0
    self.waves = {
        "placeholder"
    }


    self.check = "AT 25 DF 2000\n* THE CELESTIAL."
    self.text = {
        "* TAKE WHAT'S LEFT OF YOUR WILL.",
        "* ALL ROUTES DESTROYED.",
    }

end

function Celestial:getSpareText(battler, success)
    return "[noskip:true]* " .. battler.chara:getName() .. " spared " .. self.name .. "!\n* .[wait:10].[wait:10].[wait:10]\n[voice:none][speed:0.5][color:#E40386]* [sound:celestial/talk/Celestial_Talk_4][shake:1]SHE DOESN'T WANT YOUR MERCY."
end
function Celestial:onAct(battler, name)
    return super.onAct(self, battler, name)
end

return Celestial