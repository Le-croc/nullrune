local ChargeSoul, super = Class(Soul)

-- variables
local charging = false
local charge = 60 -- frames
local charge_max = 60
local chargecd_max = 75 -- cooldown if whole charge is depleted
local chargecd = 0  
function ChargeSoul:init(x, y)
    -- init (js making sure yk)
    super.init(self, x, y)
    self.color = {1, 1, 1}
    self.sprite:setSprite("player/chargesprites/soul_charge")
    charging =  false
    chargecd = 0
    charge = charge_max
    -- charge
    Game.stage.timer:every(1/15, function ()
        if charging then
            local after_image = AfterImage(Sprite("player/heart"), 0.4, 0.04)
            self:addChild(after_image)
            after_image.x = self.x-8
            after_image.y = self.y-8
        end
    end)
    Game.stage.timer:every(1/30, function ()
        if Input.down("cancel") and charge ~= 0 and chargecd==0 and self:isMoving() then
            charging = true
            self.speed = 15
            charge = charge-1
        else
            charging = false
            self.speed = 4
        end

        --handles recharge, charge cooldown
        if charge == 0 and chargecd == 0 then chargecd = chargecd_max end
        if chargecd ~= 0 then chargecd = chargecd-1 end
        if charging == false and charge~=charge_max then charge = charge+1 end
        if chargecd == 1 then 
            local charge_done = AfterImage(Sprite("player/chargesprites/soul_charge"), 0.5, 0.04)
            Assets.playSound("boost", 1.5)
            self:addChild(charge_done)
            Game.stage.timer:everyInstant(1/30, function ()
                charge_done.x = self.x-12
                charge_done.y = self.y-12
            end, 15)
            charge_done:setScale(1.5)
        end

        --handles sprites
        if charge == 0 then self.sprite:setSprite("player/heart")
        elseif 0 < charge and charge <= 1/7*charge_max then 
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/chargeind_7")
            else
            self.sprite:setSprite("player/chargesprites/chargeind_7_b")
            end
        elseif 1/7*charge_max < charge and charge <= 2/7*charge_max then 
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/chargeind_6")
            else
            self.sprite:setSprite("player/chargesprites/chargeind_6_b")
            end
        elseif 2/7*charge_max < charge and charge <= 3/7*charge_max then 
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/chargeind_5")
            else
            self.sprite:setSprite("player/chargesprites/chargeind_5_b")
            end 
        elseif 3/7*charge_max < charge and charge <= 4/7*charge_max then 
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/chargeind_4")
            else
            self.sprite:setSprite("player/chargesprites/chargeind_4_b")
            end
        elseif 4/7*charge_max < charge and charge <= 5/7*charge_max then
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/chargeind_3")
            else
            self.sprite:setSprite("player/chargesprites/chargeind_3_b")
            end
        elseif 5/7*charge_max < charge and charge <= 6/7*charge_max then
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/chargeind_2")
            else
            self.sprite:setSprite("player/chargesprites/chargeind_2_b")
            end
        elseif 6/7*charge_max < charge and charge < charge_max then
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/chargeind_1")
            else
            self.sprite:setSprite("player/chargesprites/chargeind_1_b")
            end
        elseif charge == charge_max then
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/soul_charge")
            else
            self.sprite:setSprite("player/chargesprites/soul_charge_b")
            end
        end
        
        -- handles timer
        if not self then return false end
        if not Game.battle then return false end
        if Game.battle:getState() == "DEFENDINGEND" then
            return false
        end
    end)
end



return ChargeSoul