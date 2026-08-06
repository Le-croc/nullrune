local VBO, super = Class(EnemyBattler)

function VBO:init()
    super.init(self)

    -- Enemy name
    self.name = "Voidbound Operator"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/operator.lua)
    self:setActor("VBO")

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
        "VBOattack"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 20 DF 10\n* Idk how to explain it so\nrewrite this later"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Voidbound Operator ticks.",
        "* Looks like a voidbound traffic light."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Voidbound Operator took severe damage."

    self:registerAct("Stand still")
end
-- Hurt sprite
function VBO:onHurt(damage, battler)
    self.sprite:setSprite("hurt")
    return super.onHurt(self, damage, battler)
end
function VBO:onHurtEnd()
    self.sprite:setSprite("idle")
    return super.onHurtEnd(self)
end

function VBO:onAct(battler, name)
    if name == "Stand still" then
        -- Give the enemy 50% mercy
        self:addMercy(50)
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You stood VERY still.[wait:5]\n* Voidbound Operator looks pleased.",
        }

    elseif name == "Standard" then --X-Action
        -- Give the enemy 25% mercy
        self:addMercy(25)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei smiled at Voidbound Operator.\n* Voidbound Operator looks to be\nsleeping."
        elseif battler.chara.id == "susie" then
            -- S-Action text
            return "* Susie stared at Voidbound Operator.\n* Voidbound Operator sleeps."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened \nVoidbound Operator's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end
return VBO