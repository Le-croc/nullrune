local PartyBattler, super = HookSystem.hookScript(PartyBattler)
function PartyBattler:hurt(amount,exact,color,options)
    if Game.kris_shield or Game.noelle_shield or Game.susie_shield or Game.ralsei_shield then
        if self.actor.name=="Kris" then
            if Game.kris_shield then
                Assets.playSound("other/Shield_Break")
                Game.kris_shield=false
            else super.hurt(self,amount,exact,color,options)
            end
        elseif self.actor.name=="Noelle" then
            if Game.noelle_shield then
                Assets.playSound("other/Shield_Break")
                Game.noelle_shield=false
            else super.hurt(self,amount,exact,color,options)
            end
        elseif self.actor.name=="Susie" then
            if Game.susie_shield then
                Assets.playSound("other/Shield_Break")
                Game.susie_shield=false
            else super.hurt(self,amount,exact,color,options)
            end
        elseif self.actor.name=="Ralsei" then  
            if Game.ralsei_shield then
                Assets.playSound("other/Shield_Break")
                Game.ralsei_shield=false
            else super.hurt(self,amount,exact,color,options)
            end
        end
    else
        super.hurt(self,amount,exact,color,options)
    end
end

return PartyBattler