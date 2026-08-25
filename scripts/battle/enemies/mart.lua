local Mart, super = Class(EnemyBattler)

function Mart:init()
    super.init(self)
    self.name = "Mart"
    self:setActor("mart")
    self.max_health = 450
    self.health = 450
    self.attack = 8
    self.defense = 0
    self.money = 100
    self.spare_points = 20

    self.waves = {
        "martattack"
    }

    self.dialogue = {
        "I am mart! The waterimp!"
    }

    self.check = "AT 8 DF 0\n* Mart"

    self.text = {
        "* Mart does mart thing.",
        "* Mart marts.",
        "* Smells like waterimp.",
    }

    self.low_health_text = "* Mart is dying"

    self:registerAct("Mart", "")

    self:registerAct("Fuck you Mart", "", {"ralsei"})

end
-- Hurt sprite
function Mart:onHurt(damage, battler)
    self.sprite:setSprite("hurt")
    self.sprite:setScale(1.5)
    return super.onHurt(self, damage, battler)
end
function Mart:onHurtEnd()
    self.sprite:setSprite("idle")
    self.sprite:setScale(1)
    return super.onHurtEnd(self)
end
function Mart:onAct(battler, name)
    if name == "Mart" then
        self:addMercy(100)
        self.dialogue_override = ":D"
        return {
            "* You mart.[wait:5]\n* Mart marts back.",
        }

    elseif name == "Fuck you Mart" then
        for _, enemy in ipairs(Game.battle.enemies) do
            enemy:setTired(true)
        end
        return "* You and Ralsei told Mart\nevil bad stuff. \n* The enemy became [color:blue]TIRED and SAD[color:reset]..."

    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            return "* Ralsei bowed politely.\n* Mart spiritually bowed in\nreturn."
        elseif battler.chara.id == "susie" then
            Game.battle:startActCutscene("mart", "susie_punch")
            return
        else
            return "* "..battler.chara:getName().." straightened \nMart's hat."
        end
    end

    return super.onAct(self, battler, name)
end

return Mart