local Part, super = Class(Object)

function Part:init(path, x, y)
    super.init(self, x, y)
    self.inherit_color = true
    self.sprite = Sprite(path)
    self.sprite.inherit_color = true
    self.sprite:setRotationOrigin(0.5, 0.5)
    self:addChild(self.sprite)
    self.initted = false
    Game.stage.timer:every(1/30, function ()
    if Game.battle ~= nil and Game.battle:getEnemyBattler("kolona") ~= nil then
        if Game.battle:getState() == "DEFENDINGBEGIN" then
            -- vars for the attack
            GKS = "IDLE"
            if not self.initted then
                self.atick = 0
                maxticks = math.random(5, 8)
                self.tick = 0
                self.nrfrm = 0
                self.frm = 0
                self.kolonastate = "IDLE"
                self.initted = true
            end
        elseif Game.battle:getState()  == "DEFENDING" then
            --handles state changes
            if self.nrfrm == 75 then
                self.kolonastate = "COUNTING"
            end
            if self.tick > maxticks+1 then self.kolonastate = "ATTACKING" end
            if self.kolonastate == "IDLE" then
                Assets.stopAndPlaySound("kolona/Warning")
                self.kolonastate = "SHOWNR"
            end
            --states
            if self.kolonastate == "SHOWNR" then
                self.nrfrm = self.nrfrm + 1
                if self.id  == "face" and self.nrfrm == 5 then 
                    if maxticks  == 5 then self.sprite:set("enemies/kolona/face/five") 
                    elseif maxticks  == 6 then self.sprite:set("enemies/kolona/face/six") 
                    elseif maxticks == 7 then self.sprite:set("enemies/kolona/face/seven") 
                    elseif maxticks == 8 then self.sprite:set("enemies/kolona/face/eight") end
                end
            elseif self.kolonastate == "COUNTING" then
                --pillar animation
                if self.id == "pillar" then
                    -- play ticking sound
                    if self.tick == 1 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick1")
                    elseif self.tick == 2 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick2")
                    elseif self.tick == 3 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick3")
                    elseif self.tick == 4 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick4")
                    elseif self.tick == 5 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick5")
                    elseif self.tick == 6 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick6")
                    elseif self.tick == 7 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick7")
                    elseif self.tick == 8 and self.frm%30 == 0 and self.tick <= maxticks then Assets.stopAndPlaySound("kolona/ticks/tick8")
                    end
                    -- ticking animation
                    if self.tick >= 1 and self.tick <= maxticks then
                        Game.battle.timer:after(1, function()
                            if self.frm%30 == 2 then self.sprite.rotation = self.sprite.rotation + math.rad(2)
                            elseif self.frm%30 == 3 then self.sprite.rotation = self.sprite.rotation + math.rad(3)
                            elseif self.frm%30 == 4 then self.sprite.rotation = self.sprite.rotation + math.rad(4)
                            elseif self.frm%30 == 5 then self.sprite.rotation = self.sprite.rotation + math.rad(6.5)
                            elseif self.frm%30 == 6 then self.sprite.rotation = self.sprite.rotation + math.rad(4)
                            elseif self.frm%30 == 7 then self.sprite.rotation = self.sprite.rotation + math.rad(3)
                            elseif self.frm%30 == 9 then self.sprite.rotation = self.sprite.rotation + math.rad(1)
                            elseif self.frm%30 == 11 then self.sprite.rotation = self.sprite.rotation + math.rad(-1)
                            end
                        end
                        )
                    end
                    -- counts ticks
                    if self.frm%30 == 0 then 
                        self.tick = self.tick + 1 
                        end
                    self.frm = self.frm + 1
                end
                -- wreath animation
                if self.id == "wreath" then
                    -- ticking animation
                    if self.tick >= 2 and self.tick <= maxticks then self.sprite.rotation = self.sprite.rotation + math.rad(-0.15) end
                    if self.tick >= 1 and self.tick <= maxticks then
                        Game.battle.timer:after(1, function()
                            if self.frm%30 == 2 then self.sprite.rotation = self.sprite.rotation + math.rad(-5)
                            elseif self.frm%30 == 3 then self.sprite.rotation = self.sprite.rotation + math.rad(-7.5)
                            elseif self.frm%30 == 4 then self.sprite.rotation = self.sprite.rotation + math.rad(-7.5)
                            elseif self.frm%30 == 5 then self.sprite.rotation = self.sprite.rotation + math.rad(-10)
                            elseif self.frm%30 == 6 then self.sprite.rotation = self.sprite.rotation + math.rad(-7.5)
                            elseif self.frm%30 == 7 then self.sprite.rotation = self.sprite.rotation + math.rad(-7.5)
                            end
                        end
                        )
                    end
                    if self.frm%30 == 0 then 
                        self.tick = self.tick + 1 
                        end
                    self.frm = self.frm + 1
                end
                -- face animation
                if self.id  == "face" then
                    if self.tick == 1 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/one")
                    elseif self.tick == 2 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/two")
                    elseif self.tick == 3 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/three")
                    elseif self.tick == 4 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/four")
                    elseif self.tick == 5 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/five")
                    elseif self.tick == 6 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/six")
                    elseif self.tick == 7 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/seven")
                    elseif self.tick == 8 and self.frm%30 == 0 and self.tick <= maxticks then self.sprite:set("enemies/kolona/face/eight")
                    end
                    if self.frm%30 == 0 then 
                        self.tick = self.tick + 1 
                        end
                    self.frm = self.frm + 1
                end
                if self.id  == "flame" then
                    if self.frm%30 == 0 then 
                        self.tick = self.tick + 1 
                        end
                    self.frm = self.frm + 1
                end
            elseif self.kolonastate == "ATTACKING" then
                -- wreath animation
                if self.id == "wreath" then
                    self.atick = self.atick + 1

                    if self.atick <= 5 then self.sprite.rotation = self.sprite.rotation + math.rad(-5) end
                    if playertookdamage then
                        if self.atick <= 60 then self.sprite.rotation = self.sprite.rotation + math.rad(-10)
                        elseif self.atick == 61 then self.sprite.rotation = math.rad(-15)
                        elseif self.atick == 62 then self.sprite.rotation = math.rad(-5)
                        elseif self.atick == 63 then self.sprite.rotation = 0
                        end
                    else
                        if self.atick <= 40 then self.sprite.rotation = self.sprite.rotation + math.rad(-10)
                        elseif self.atick == 41 then self.sprite.rotation = math.rad(-15)
                        elseif self.atick == 42 then self.sprite.rotation = math.rad(-5)
                        elseif self.atick == 43 then self.sprite.rotation = 0
                        end
                    end
                    
                    if self.atick == 2 then 
                        GKS = "ATTACKING"
                        Assets.stopAndPlaySound("kolona/Attack")
                    end
                    if playertookdamage then
                        if self.atick == 16 then 
                            self.color = {1, 0.6, 0.6}
                            Assets.stopAndPlaySound("kolona/Kill")
                        elseif self.atick == 17 then self.color = {1, 0.2, 0.2}
                        elseif self.atick == 60 then self.color = {1, 0.6, 0.6}
                        elseif self.atick == 62 then self.color = {1, 1, 1}
                        elseif self.atick == 80 then Game.battle:endWaves()
                        end
                    end
                    if self.atick == 60 and not playertookdamage then Game.battle:endWaves() end
                end
                -- pillar animation
                if self.id == "pillar" then
                    self.atick = self.atick + 1

                    if self.atick == 1 or self.atick == 2 then self.sprite.rotation = self.sprite.rotation + math.rad(5)
                    elseif self.atick == 3 or self.tick == 4 then self.sprite.rotation = self.sprite.rotation + math.rad(15)
                    end
                    if playertookdamage then
                        if self.atick < 60 then self.sprite.rotation = self.sprite.rotation + math.rad(30)
                        elseif self.atick == 60 then self.sprite.rotation = math.rad(15)
                        elseif self.atick == 61 then self.sprite.rotation = math.rad(5)
                        elseif self.atick == 62 then self.sprite.rotation = 0
                        end 
                    else
                        if self.atick < 40 then self.sprite.rotation = self.sprite.rotation + math.rad(30)
                        elseif self.atick == 40 then self.sprite.rotation = math.rad(15)
                        elseif self.atick == 41 then self.sprite.rotation = math.rad(5)
                        elseif self.atick == 42 then self.sprite.rotation = 0
                        end 
                    end
                end
                -- face animation
                if self.id == "face" then
                    self.atick = self.atick + 1

                    if self.atick == 1 then self.sprite:set(none)
                    elseif self.atick == 2 then self.sprite:set("enemies/kolona/face/kolonaface_1")
                    elseif self.atick == 4 then self.sprite:set("enemies/kolona/face/kolonaface_2")
                    elseif self.atick == 5 then self.sprite:set("enemies/kolona/face/kolonaface_3")
                    end 
                end
            end
        elseif Game.battle:getState() == "DEFENDINGEND" then
            self.initted = false
        end
    else return false
    end
end)
end



function Part:setSprite(path)
    local sprite = Sprite(path)
    sprite.inherit_color = true
    sprite:setRotationOrigin(self.sprite:getRotationOrigin())
    sprite.rotation = self.sprite.rotation
    self.sprite:remove()
    self.sprite = sprite
    self:addChild(sprite)
end


return Part