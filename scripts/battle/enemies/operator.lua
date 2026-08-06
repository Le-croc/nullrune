local Operator, super = Class(EnemyBattler)

function Operator:init()
    super.init(self)

    -- Enemy name
    self.name = "Operator"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/operator.lua)
    self:setActor("operator")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 20
    -- Enemy defense (usually 0)
    self.defense = 4
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "operatorattack"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 20 DF 4\n* Idk how to explain it so\nrewrite this later"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Operator ticks.",
        "* Looks like a traffic light."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Operator took severe damage."

    self:registerAct("Stand still")
end
-- Hurt sprite
function Operator:onHurt(damage, battler)
    self.sprite:setSprite("hurt")
    return super.onHurt(self, damage, battler)
end
function Operator:onHurtEnd()
    self.sprite:setSprite("idle")
    return super.onHurtEnd(self)
end

function Operator:onAct(battler, name)
    if name == "Stand still" then
        -- Give the enemy 50% mercy
        self:addMercy(50)
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You stood still.[wait:5]\n* Operator looks pleased.",
        }

    elseif name == "Standard" then --X-Action
        -- Give the enemy 25% mercy
        self:addMercy(25)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei smiled at Operator.\n* Operator looks to be\nsleeping."
        elseif battler.chara.id == "susie" then
            -- S-Action text
            return "* Susie stared at Operator.\n* Operator sleeps."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened \nOperator's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end
return Operator