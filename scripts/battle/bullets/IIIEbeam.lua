---@class IIIEbeam : Bullet
local IIIEbeam, super = Class(Bullet)

---@param x number 
---@param y number
---@param dir number 
---@param speed number 
function IIIEbeam:init(x, y, t, time)

    super.init(self, x, y, "bullets/1113/1113indicator")
    self.destroy_on_hit = false
    self.rotation = math.rad(math.random(0, 360))
    self.collider = nil
    if t == 1 then
        if math.random() < 0.5 then
            Assets.playSound("celestial/1113/1113_1")
        else 
            Assets.playSound("celestial/1113/1113_2")
        end 
    end
    Game.stage.timer:approach(time*0.6, 0.1, 1, function (x)
        self:setScale(x, 2)
    end, "out-back")
    Game.stage.timer:after(time*0.6, function ()
        self:setSprite("bullets/1113/1113beam")
        self.collider = Hitbox(self, 3, 0, self.width*0.8, self.height)
        Game.stage.timer:approach(time*0.4, 1, 1.25, function (x)
            self:setScale(x, 2)
            self.collider = Hitbox(self, 3, 0, self.width*0.8, self.height)
        end, "out-expo")
        Game.stage.timer:after(time*0.4, function ()
            Game.stage.timer:approach(time*0.6, 1.25, 0, function (x)
                self:setScale(x, 2)
                self.collider = Hitbox(self, 3, 0, self.width*0.8, self.height)
            end, "inSine")
            Game.stage.timer:after(time*0.6, function ()
                self:remove()
            end)
        end)
        
    end)
    
end

function IIIEbeam:update()
    

    super.update(self)
end

return IIIEbeam
