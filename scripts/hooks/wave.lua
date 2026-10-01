local Wave, super = HookSystem.hookScript(Wave)
function Wave:onStart()
    self:upgradeCheck()
end
function Wave:onEnd(death)
    Game.stage.timer:after(0.1, function ()
        Game.charging = false
    end)
    Game.charge = 60
    Game.chargecd = 0
    super.onEnd(self, death)
end
function Wave:upgradeCheck()
    local ninjabelt = false
    local sharktail = false
    for _, battler in ipairs(Game.battle.party) do
        if battler.chara:checkArmor("ninjabelt") then ninjabelt = true end
    end
    for _, battler in ipairs(Game.battle.party) do
        if battler.chara:checkArmor("sharktail") then sharktail = true end
    end
    if sharktail and ninjabelt then Game.battle:swapSoul(UpgradedSoul())
    elseif ninjabelt then Game.battle:swapSoul(BallGameSoul())
    elseif sharktail then Game.battle:swapSoul(ChargeSoul())
    end
end
return Wave