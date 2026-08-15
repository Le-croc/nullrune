local kolona, super = Class(EnemyBattler)

function kolona:init()
    super.init(self)
    -- Enemy name
    self.name = "Kolona"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/kolona.lua)
    self:setActor("kolona")
    -- Enemy health
    self.max_health = 500
    self.health = 500
    self.sprite:setSprite("")
    -- Enemy attack (determines bullet damage)
    self.attack = 20
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100
    
    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 10

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "kolonaattack"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 20 DF 0\n* Idk how to explain it so\nrewrite this later"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Kolona's flame is burning bright.",
        "* Kolona spins."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Kolona's flame is dimming..."

    self:registerAct("Flame")
end
-- Hurt sprite
function kolona:onHurt(damage, battler)
    self:setAnimation("kolonadamage")
    return super.onHurt(self, damage, battler)
end

function kolona:onDefeatRun()
    self.sprite:setSprite("kolonadefeat")
    return super.onDefeatRun(self)
end
function kolona:onHurtEnd()
    self:setAnimation("kolonadamageend")
    return super.onHurtEnd(self)
end
function kolona:onAct(battler, name)
    if name == "Flame" then
        -- Give the enemy 50% mercy
        self:addMercy(50)
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You stoke Kolona's flame...[wait:5]\n* Kolona looks happy.",
        }

    elseif name == "Standard" then --X-Action
        -- Give the enemy 25% mercy
        self:addMercy(25)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei used fire magic.\n* Kolona's flame burns\n brighter."
        elseif battler.chara.id == "susie" then
            -- S-Action text
            return "* Susie did something.\n* Kolona is happy."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened \nKolona's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end
return kolona