local spell, super = Class(Spell, "altar")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Altar"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Protection"
    -- Menu description
    self.description = "Subspace protection that\nnegates one hit."

    -- TP cost
    self.cost = 30

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {}
end

function spell:onCast(user, target)
    Assets.playSound("altar/greed", 1, math.random(12,15)/10)
    if target.actor.name=="Kris" then
        Game.kris_shield=true
    elseif target.actor.name=="Noelle" then
        Game.noelle_shield=true
    elseif target.actor.name=="Susie" then
        Game.susie_shield=true
    elseif target.actor.name=="Ralsei" then
        Game.ralsei_shield=true
    end
end

return spell
