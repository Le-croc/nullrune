local Mart, super = Class(EnemyBattler)

function Mart:init()
    super.init(self)
    self.name = "Evil Red Mart"
    self:setActor("evilmart")
    self.max_health = 450
    self.health = 450
    self.attack = 30
    self.defense = 40
    self.money = 100
    self.spare_points = 20
    self.sprite:setScaleOrigin(1/2,1/2)
    self.waves = {
        "em1",
        "em2",
        "em3"
    }

    self.dialogue = {
        "I am EVIL mart! The EVIL imp!"
    }

    self.check = "AT 86236612 DF 376210983\n* [color:red]EVIL[color:reset] mart"

    self.text = {
        "* i laced yo shi",
        "* ",
        "* s",
        "* do emojis work here🤑\nok i guess no",
        "* Hi! I'm [color:red]GOD[color:reset].[wait:10]\n* I have temporarily possesed\nthis dialogue.\n* Connection terminated. I'm sorry to interrupt you, Elizabeth. If you still even remember that name. But I'm afraid you've been misinformed.You are not here to receive a gift. Nor, have you been called here by the individual you assume. Although, you have indeed been called. You have all been called here."
    }

    self.low_health_text = "* THE RED GOD IS WEEPING."

    self:registerAct("Mart", "")

    self:registerAct("Softlock yourself lol", "")
    self:registerAct("c", "")
    self:registerAct("bullshit", "")
    self:registerAct("X-Fuck you Mart", "", {"ralsei","noelle","susie"})

end
-- Hurt sprite
function Mart:hurt(amount, battler, on_defeat, color, show_status, attacked)
    amount=1
    if amount == 0 or (amount < 0 and Game:getConfig("damageUnderflowFix")) then
        if show_status ~= false then
            self:statusMessage("msg", "miss", color or (battler and { battler.chara:getDamageColor() }))
        end

        self:onDodge(battler, attacked)
        return
    end

    self.health = self.health - amount
    if show_status ~= false then
        self:statusMessage("damage", amount, color or (battler and { battler.chara:getDamageColor() }))
    end

    if amount > 0 then
        self.hurt_timer = 1
        self:onHurt(amount, battler)
    end

    self:checkHealth(on_defeat, amount, battler)
end

function Mart:onAct(battler, name)
    if name == "Mart" then
        self:addMercy(0.1)
        self.dialogue_override = "no"
        return {
            "* You mart.[wait:5]\n* I dont give a SHIT about viltrum",
        }

    elseif name == "X-Fuck you Mart" then
        self:addMercy(0.0001)
        local chance = math.random(1, 10)
        if chance == 5 then
        Game.stage.timer:every(1/30, function ()
            if math.random()<=1/2 then
            Game.kris_shield=true
            else
            Game.kris_shield=false
            end
        end)
        end
        return "* [face:starwalker]* fuck you"
        
    elseif name == "bullshit" then
        Game.stage.timer:every(1/30, function ()
        self.sprite:setScale(math.random(0.1,3),  math.random(0.1,3))
        end)
        return "ok"
    elseif name == "c" then
        local c=math.random(1,4)
        local chance = math.random(1, 10)
        Game.stage.timer:every(1/30, function ()
            Game.battle.party[c]:checkHealth(true)
            if chance<=3 then
            Game.tension=math.random(0, 100)
            end
            if chance~=10 then
            Game.battle.party[c].chara:setHealth(math.random(-2000000, 2000000))
            else
            Game.battle.party[c].chara:setHealth(math.random(-math.huge,math.huge))
            end
        end)
        return "shitttttt"
    elseif name == "Standard" then
        self:addMercy(0.1)
        return "* "..battler.chara:getName().." prays to the imp for mercy\n* ... but their name wasn't [color:yellow]yellow[color:reset]."
    end

    return super.onAct(self, battler, name)
end

return Mart