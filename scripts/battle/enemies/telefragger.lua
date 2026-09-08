local Telefragger, super = Class(EnemyBattler)

function Telefragger:init()
    super.init(self)
    self.name = "Telefragger"
    self:setActor("telefragger")
    self.max_health = 450
    self.health = 450
    self.attack = 16
    self.defense = 0
    self.money = 100
    self.spare_points = 20

    self.waves = {
        "telefraggerattack"
    }


    self.check = "AT 16 DF 0\n* Telefragger"

    self.text = {
        "* Telefragger messes around.",
        "* Telefragger.",
    }

    self.low_health_text = "* The stick figure's legs are broken."

    self:registerAct("move", "")

    self:registerAct("Fuck you Telefragger", "", {"susie"})

end
-- Hurt sprite
function Telefragger:onHurt(damage, battler)
    self.sprite:setSprite("hurt")
    return super.onHurt(self, damage, battler)
end
function Telefragger:onHurtEnd()
    self.sprite:setSprite("idle")
    return super.onHurtEnd(self)
end
function Telefragger:onAct(battler, name)
    if name == "move" then
        self:addMercy(100)
        return {
            "* You move out of Telefragger's way.[wait:5]\n* Telefragger is sad.",
        }

    elseif name == "Fuck you Telefragger" then
        for _, enemy in ipairs(Game.battle.enemies) do
            enemy:setTired(true)
        end
        return "* You and Susie pick on Telefragger.t\n* The enemy became [color:blue]TIRED and SAD[color:reset]..."

    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            return "* Ralsei bowed politely.\n* Telefragger spiritually bowed in\nreturn."
        elseif battler.chara.id == "susie" then
            return "* Susie sits around.\n* Telefragger sits around."
        else
            return "* "..battler.chara:getName().." straightened \nTelefragger's hat."
        end
    end

    return super.onAct(self, battler, name)
end

return Telefragger