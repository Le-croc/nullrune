local Game, super = HookSystem.hookScript(Game)
function Game:giveShield()
    self.kris_shield=true
    self.susie_shield=true
    self.noelle_shield=true
    self.ralsei_shield=true
end
return Game