---@class vimp : Bullet
local vimp, super = Class(Bullet)
---@param x number 
---@param y number 
---@param delay number
function vimp:init(x, y, delay)
    super.init(self, x, y, nil)
    self.can_graze = false
    self.collider = nil
    self.destroy_on_hit = false
    local t = math.random(80, 120)/100
    self.rotation = math.rad(math.random(0, 360))
    Game.stage.timer:after(delay/30, function ()
        self:setSprite("bullets/vimps/vib")
        self:setScale(0.1)
        Game.stage.timer:approach(2/3*t, 0.1, 2.5, function (x)
            self:setScale(x)
        end, "out-expo")
        Game.stage.timer:after(1, function ()
            Game.stage.timer:approach(1/3*t, 2.5, 2.3, function (x)
                self:setScale(x)
            end, "out-expo")
            if playvimpsound%3 == 1 then Assets.playSound("celestial/vimps/vimp_e") end
            playvimpsound = playvimpsound + 1
            self:setSprite("bullets/vimps/vimp1")
            Game.stage.timer:after(0.1, function ()
                self:setSprite("bullets/vimps/vimp2")
                self.collider = Hitbox(self, self.width/4, self.height/4, self.width*0.6, self.height*0.6)
                Game.stage.timer:after(0.1, function ()
                    self:setSprite("bullets/vimps/vimp3")
                    self.collider = Hitbox(self, self.width/4, self.height/4, self.width*0.6, self.height*0.6)
                    Game.stage.timer:after(0.1, function ()
                        self:setSprite("bullets/vimps/vimp4")
                        self.collider = Hitbox(self, self.width/4, self.height/4, self.width*0.6, self.height*0.6)
                        Game.stage.timer:approach(1/2*t, 2.3, 0, function (x)
                            self:setScale(x)
                        end, "out-circ")
                        Game.stage.timer:after(1/2*t, function ()
                            self:remove()
                        end)
                    end)
                end)
            end)
        end)
    end)
end
function vimp:update()
    super.update(self)
end

return vimp
