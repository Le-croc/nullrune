local Mart, super = Class(EnemyBattler)

function Mart:init()
    super.init(self)

    -- Enemy name
    self.name = "Mart"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("mart")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "I am mart! The waterimp!"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 0\n* Mart"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Mart does mart thing.",
        "* Mart marts.",
        "* Smells like waterimp.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Mart but evil"

    self:registerAct("Mart")

    self:registerAct("Fuck you Mart", "", {"ralsei"})
end

function Mart:onAct(battler, name)
    if name == "Mart" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = ":D"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You mart.[wait:5]\n* Mart marts back.",
        }

    elseif name == "Fuck you Mart" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
        end
        return "* You and Ralsei told Mart\nevil bad stuff. \n* The enemy became [color:blue]TIRED and SAD[color:reset]..."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei bowed politely.\n* Mart spiritually bowed in\nreturn."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("mart", "susie_punch")
            return
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened \nMart's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Mart