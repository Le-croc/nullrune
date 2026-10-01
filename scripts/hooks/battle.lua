local Battle, super = HookSystem.hookScript(Battle)
---@field charge_bar               ChargeBar
function Battle:init()
    self.charge_bar=nil
    super.init(self)
end

function Battle:showUI()
    if self.battle_ui then
        self.battle_ui:transitionIn()
    end
    if self.tension_bar then
        self.tension_bar:show()
    end
    if self.charge_bar then
        self.charge_bar:show()
    end
end

function Battle:onVictory()
    if self.charge_bar then
        self.charge_bar:hide()
    end
    super.onVictory(self)
end

function Battle:createUI()
    self.background = self.encounter:createBackground()
    self.battle_ui = self:createBattleUI()
    self.tension_bar = self:createTensionBar()
    for _, battler in ipairs(Game.battle.party) do
        if battler.chara:checkArmor("sharktail") then self.charge_bar = self:createChargeBar()end
    end
end

function Battle:createChargeBar()
    return self:addChild(ChargeBar(-14, 40, true))
end
return Battle