local ActionBox, super = HookSystem.hookScript(ActionBox)
function ActionBox:init(x, y, index, battler)
    super.init(self, x, y,index,battler)

    self.battler = battler
    if battler.chara:getNameSprite() then
        Game.stage.timer:every(1/15, function ()
            self.box:removeChild(self.name_sprite)
            self.name_sprite = Sprite(battler.chara:getNameSprite(), 51, 14)
            self.box:addChild(self.name_sprite)
        end)
    end
    Game.stage.timer:every(1/15, function()
            if self.battler.actor.name=="Kris" then
                if Game.kris_shield then
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/shield/khp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                else
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/hp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                end
            elseif self.battler.actor.name=="Susie" then
                if Game.susie_shield then
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/shield/shp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                else
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/hp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                end
            elseif self.battler.actor.name=="Noelle" then
                if Game.noelle_shield then
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/shield/nhp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                else
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/hp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                end
            elseif self.battler.actor.name=="Ralsei" then
                if Game.ralsei_shield then
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/shield/rhp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                else
                    self.box:removeChild(self.hp_sprite)
                    self.hp_sprite = Sprite("ui/hp", 109, 22)
                    self.box:addChild(self.hp_sprite)
                end
            else 
                self.box:removeChild(self.hp_sprite)
                self.hp_sprite = Sprite("ui/hp", 109, 22)
                self.box:addChild(self.hp_sprite)
            end
    end)
    

end

return ActionBox