local UpgradedSoul, super = Class(Soul)

-- variables
local dashing = false
local dashcd = 0
local dash_len = 5 -- frames
local dash_var = dash_len -- used for toggling off dashing bool
local maxdashcd = 30 -- frames cd
local charging = false
local charge = 60 -- frames
local charge_max = 60
local chargecd_max = 75 -- cooldown if whole charge is depleted
local chargecd = 0
function UpgradedSoul:init(x, y)
    -- dash cooldown is off, dashing is off
    super.init(self, x, y)
    self.color = {1, 1, 1}
    dashcd = 0
    dashing = false
    charging =  false
    chargecd = 0
    charge = charge_max
    self.sprite:setSprite("player/chargesprites/soul_charge")
        --dash and charge
    Game.stage.timer:every(1/15, function ()
        if charging then
            local after_image = AfterImage(Sprite("player/heart"), 0.4, 0.04)
            self:addChild(after_image)
            after_image.x = self.x-8
            after_image.y = self.y-8
        end
    end)
    Game.stage.timer:every(1/30, function ()
        -- charge
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
        if charge == 0 and dashcd~=0 then self.sprite:setSprite("player/heart")
        elseif charge==0 and dashcd==0 then self.sprite:setSprite("player/soul_dash")
        elseif 0 < charge and charge <= 1/7*charge_max then
            if dashcd ~= 0 then
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_7")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_7_b")
                end
            else
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_7_d")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_7_b_d")
                end
            end
        elseif 1/7*charge_max < charge and charge <= 2/7*charge_max then 
            if dashcd ~= 0 then
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_6")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_6_b")
                end
            else
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_6_d")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_6_b_d")
                end
            end
        elseif 2/7*charge_max < charge and charge <= 3/7*charge_max then 
            if dashcd ~= 0 then
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_5")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_5_b")
                end
            else
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_5_d")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_5_b_d")
                end
            end
        elseif 3/7*charge_max < charge and charge <= 4/7*charge_max then 
            if dashcd ~= 0 then
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_4")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_4_b")
                end
            else
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_4_d")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_4_b_d")
                end
            end
        elseif 4/7*charge_max < charge and charge <= 5/7*charge_max then
            if dashcd ~= 0 then
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_3")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_3_b")
                end
            else
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_3_d")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_3_b_d")
                end
            end
        elseif 5/7*charge_max < charge and charge <= 6/7*charge_max then
            if dashcd ~= 0 then
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_2")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_2_b")
                end
            else
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_2_d")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_2_b_d")
                end
            end
        elseif 6/7*charge_max < charge and charge < charge_max then
            if dashcd ~= 0 then
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_1")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_1_b")
                end
            else
                if chargecd==0 then
                self.sprite:setSprite("player/chargesprites/chargeind_1_d")
                else
                self.sprite:setSprite("player/chargesprites/chargeind_1_b_d")
                end
            end
        elseif charge == charge_max then
            if chargecd==0 then
            self.sprite:setSprite("player/chargesprites/soul_charge")
            else
            self.sprite:setSprite("player/chargesprites/soul_charge_b")
            end
        end

        if not self then return false end
        if not Game.battle then return false end
        -- stop timer once wave ends
        if Game.battle:getState() == "DEFENDINGEND" then
            return false
        end
        -- after dash_len (5) frames, DASHING bool gets toggled off 
        if dashing then
            dash_var = dash_var-1
            if dash_var == 0 then
                dashing = false
            end
        else
            dash_var = dash_len -- dash_var gets reset
        end


        -- dashcd is reduced by 1 each frame until it is 0 (can dash again)
        if dashcd ~= 0 then
            dashcd = dashcd - 1
        elseif dashcd < 0 then
            dashcd = 0  --failsafe
        end

        -- dash movement (always if and never is)
        if dashing then
            if Game.battle.arena then 
                local Arena = Game.battle.arena
                self.dash_bottom = Arena:getBottom()-12
                self.dash_top = Arena:getTop()+12
                self.dash_right= Arena:getRight()-12
                self.dash_left = Arena:getLeft()+12
            end
            if self.dash_dir == 12 then
                for i=1,3 do if self.y >= self.dash_top then self.y = self.y-5 end end
            elseif self.dash_dir == 1.5 then
                for i=1,3 do
                if self.y >= self.dash_top then self.y = self.y-4 end
                if self.x <= self.dash_right then self.x = self.x+4 end
                end
            elseif self.dash_dir == 3 then
                for i=1,3 do if self.x <= self.dash_right then self.x = self.x+5 end end
            elseif self.dash_dir == 4.5 then
                for i=1,3 do
                if self.y <= self.dash_bottom then self.y = self.y+4 end
                if self.x <= self.dash_right then self.x = self.x+4 end
                end
            elseif self.dash_dir == 6 then
                for i=1, 3 do if self.y <= self.dash_bottom then self.y = self.y+5 end end
            elseif self.dash_dir == 7.5 then
                for i=1, 3 do
                if self.y <= self.dash_bottom then self.y = self.y+4 end
                if self.x >= self.dash_left then self.x = self.x-4 end
                end
            elseif self.dash_dir == 9 then
                for i=1, 3 do if self.x >= self.dash_left then self.x = self.x-5 end end
            elseif self.dash_dir == 10.5 then
                for i=1, 3 do
                if self.x >= self.dash_left then self.x = self.x-4 end
                if self.y >= self.dash_top then self.y = self.y-4 end
                end
            end

            --afterimages
            local after_image = AfterImage(Sprite("player/heart"), 0.4, 0.04)
            self:addChild(after_image)
            after_image.x = self.x-8
            after_image.y = self.y-8

        end

    end)
end
-- dash iframes
function UpgradedSoul:onCollide(bullet)
    if dashing and (bullet:isBullet("arenaattackblue_op") or bullet:isBullet("arenaattackblue_vbo")) then -- attacks that dont allow dash iframes (blue)
        super.onCollide(self, bullet)
    elseif not dashing then
        super.onCollide(self, bullet)
    end
end
--dash


-- checks direction of dash (yes it uses the clock, yes this code is bad, yes it works)
function UpgradedSoul:checkdir()
    local dash_dir = 0
    if Input.down("left") and ((not Input.down("up") and not Input.down("down")) or (Input.down("up") and Input.down("down"))) then dash_dir = 9 end
    if Input.down("right") and ((not Input.down("up") and not Input.down("down")) or (Input.down("up") and Input.down("down"))) then dash_dir = 3 end
    if Input.down("up") and ((not Input.down("left") and not Input.down("right")) or (Input.down("left") and Input.down("right"))) then dash_dir = 12 end
    if Input.down("down") and ((not Input.down("left") and not Input.down("right")) or (Input.down("left") and Input.down("right"))) then dash_dir = 6 end
    if Input.down("left") and Input.down("up") then dash_dir = 10.5 end
    if Input.down("left") and Input.down("down") then dash_dir = 7.5 end
    if Input.down("right") and Input.down("up") then dash_dir = 1.5 end
    if Input.down("right") and Input.down("down") then dash_dir = 4.5 end
    return dash_dir
end

function UpgradedSoul:doMovement()
    -- trigger for ability
    if Input.down("confirm") and dashcd == 0 and self:isMoving() then
        dashcd = maxdashcd
        dashing = true
        self.dash_dir = UpgradedSoul:checkdir()
        -- first afterimage
        local after_image = AfterImage(Sprite("player/heart"), 0.4, 0.04)
        self:addChild(after_image)
        after_image.x = self.x-8
        after_image.y = self.y-8
        Assets.playSound("scytheburst")

    end
    -- movement stops while ability is active
    if not dashing then
        super.doMovement(self)
    end
end

return UpgradedSoul