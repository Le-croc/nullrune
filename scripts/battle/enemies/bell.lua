local Bell, super = Class(EnemyBattler)

function Bell:init()
    super.init(self)
    self.name = "Bell"
    self:setActor("bell")
    self.max_health = 450
    self.health = 450
    self.attack = 99
    self.defense = 5
    self.money = 100
    self.spare_points = 20

    self.waves = {
        "bell"
    }


    self.check = "AT 99 DF 5\n* Bell"

    self.text = {
        "* Bell rings.",
        "* Bell wants to be rung",
        "* balls",
    }

    self.low_health_text = "* Bell is almost destroyed."

    self:registerAct("Do not ring", "")

    self:registerAct("Do not ring together", "", {"ralsei"})

end
-- Hurt sprite
function Bell:onHurt(damage, battler)
    self.sprite:setSprite("hurt")
    return super.onHurt(self, damage, battler)
end
function Bell:onHurtEnd()
    self.sprite:setSprite("idle")
    return super.onHurtEnd(self)
end
function Bell:onAct(battler, name)
    if name == "Do not ring" then
        self:addMercy(25)
        return {
            "* You don't ring the bell.[wait:5]\n* Ok cool",
        }

    elseif name == "Do not ring together" then
        for _, enemy in ipairs(Game.battle.enemies) do
            self:addMercy(100)
        end
        return "* You don't ring Bell\nat all. \n* bro we need to get a writer\nfor these at some point"

    elseif name == "Standard" then
        self:addMercy(25)
        if battler.chara.id == "ralsei" then
            return "* Ralsei bepis.\n* bepis bepis\nwords."
        elseif battler.chara.id == "susie" then
            return "* Susie bepis.\n* bepis bepis\nwords."
        else
            return "* "..battler.chara:getName().." bepis. \n* bepis bepis\nwords."
        end
    end

    return super.onAct(self, battler, name)
end

return Bell