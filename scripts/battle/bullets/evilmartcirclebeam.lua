---@class evilmartcirclebeam : Bullet
local evilmartcirclebeam, super = Class(Bullet)

---@param x number 
---@param y number

function evilmartcirclebeam:init(x, y)
    super.init(self, x, y, "bullets/evilmart/MartBeamIndicator")
    self.can_graze = false
    self.destroy_on_hit = false
    self.collider = nil
    local scale=math.random(10,17)/10
    self:setScale(scale,1)
    local time=math.random(8,10)/10
    if math.random(0,1) == 0 then
        Game.stage.timer:approach(time, x, x+math.random(640, 960), function (x)
            self.x=160+x%320
        end, "out-sine")
    else
        Game.stage.timer:approach(time, x, x-math.random(640, 960), function (x)
            self.x=160+x%320
        end, "out-sine")
    end
    Game.stage.timer:after(1.2, function ()
        self:setSprite("bullets/evilmart/Martlonger")
        self.y=self.y-200
        self.collider = Hitbox(self, 3, 0, self.width*0.8, self.height)
        Game.stage.timer:approach(0.4, 1, 1.25, function (x)
            self:setScale(x*scale, 2)
        end, "out-expo")
        Game.stage.timer:after(0.4, function ()
            Game.stage.timer:approach(0.6, 1.25, 0, function (x)
                self:setScale(x*scale, 2)
            end, "inSine")
            Game.stage.timer:after(0.6, function ()
                self:remove()
            end)
        end)
        
    end)
end

function evilmartcirclebeam:update()
    super.update(self)
end

return evilmartcirclebeam
