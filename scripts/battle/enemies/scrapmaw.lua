local scrapmaw, super = Class(EnemyBattler)

function scrapmaw:init()
    super.init(self)

    -- Enemy name
    self.name = "Scrapmaw"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/operator.lua)
    self:setActor("scrapmaw")

    -- Enemy health
    self.max_health = 750
    self.health = 750
    -- Enemy attack (determines bullet damage)
    self.attack = 20
    -- Enemy defense (usually 0)
    self.defense = 10
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 10

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "aiming"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 20 DF 10\n* Idk how to explain it so\nrewrite this later"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* God i hate writing these",
        "* Scrapmaw yams."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Scrapmaw is fucking dying"

    self:registerAct("Stand still")
end
-- Hurt sprite
function scrapmaw:onHurt(damage, battler)
    return super.onHurt(self, damage, battler)
end
function scrapmaw:onHurtEnd()
    return super.onHurtEnd(self)
end

function scrapmaw:onAct(battler, name)
    if name == "Stand still" then
        -- Give the enemy 50% mercy
        self:addMercy(50)
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* Scrapmaw.[wait:5]\n* Yams",
        }

    elseif name == "Standard" then --X-Action
        -- Give the enemy 25% mercy
        self:addMercy(25)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei scrapped maw.\n* Scrapmaw"
        elseif battler.chara.id == "susie" then
            -- S-Action text
            return "* Susie scrammed\n* paw"
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened \nScrapmaw's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end
return scrapmaw