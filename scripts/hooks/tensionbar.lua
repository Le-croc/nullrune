local TensionBar, super = HookSystem.hookScript(TensionBar)
function TensionBar:init(x, y, dont_animate)
    if Game.isCelestial then
        if Game.world and (not x) then
            local x2 = Game.world.camera:getRect()
            x = x2 - 25
        end

        super.init(self, x or -25, y or 40)

        self.layer = BATTLE_LAYERS["above_arena"] - 1

        if Game:getConfig("oldTensionBar") then
            self.tp_bar_fill = Assets.getTexture("ui/battle/tp_bar_fill_old")
            self.tp_bar_outline = Assets.getTexture("ui/battle/tp_bar_outline_old")
            self.tp_bar_fill_2 = Assets.getTexture("ui/battle/tp_bar_fill_old")
            self.tp_bar_outline_2 = Assets.getTexture("ui/battle/tp_bar_outline_old")
            self.tp_bar_fill_3 = Assets.getTexture("ui/battle/tp_bar_fill_old")
            self.tp_bar_outline_3 = Assets.getTexture("ui/battle/tp_bar_outline_old")
            self.tp_bar_fill_4 = Assets.getTexture("ui/battle/tp_bar_fill_old")
            self.tp_bar_outline_4 = Assets.getTexture("ui/battle/tp_bar_outline_old")
        else
            self.tp_bar_fill = Assets.getTexture("ui/battle/tp_bar_fill")
            self.tp_bar_outline = Assets.getTexture("ui/battle/tp_bar_outline")
            self.tp_bar_fill_2 = Assets.getTexture("ui/battle/tp_bar_fill")
            self.tp_bar_outline_2 = Assets.getTexture("ui/battle/tp_bar_outline")
            self.tp_bar_fill_3 = Assets.getTexture("ui/battle/tp_bar_fill")
            self.tp_bar_outline_3 = Assets.getTexture("ui/battle/tp_bar_outline")
            self.tp_bar_fill_4 = Assets.getTexture("ui/battle/tp_bar_fill")
            self.tp_bar_outline_4 = Assets.getTexture("ui/battle/tp_bar_outline")
        end

        self.width = self.tp_bar_outline:getWidth()
        self.height = self.tp_bar_outline:getHeight()

        self.apparent = 0
        self.current = 0

        self.change = 0
        self.changetimer = 15
        self.font = Assets.getFont("main")
        self.tp_text = Assets.getTexture("ui/battle/tp_text")

        self.parallax_y = 0

        -- still dont understand nil logic
        if dont_animate then
            self.animating_in = false
        else
            self.animating_in = true
        end

        self.animation_timer = 0

        self.tension_preview_timer = 0

        self.tension_preview = 0
        self.shown = false

        self.timer = self:addChild(Timer())
    else super.init(self, x, y, dont_animate)
    end
end
function TensionBar:getPercentageFor(variable)
    if Game.isCelestial then
        return variable/Game:getMaxTension()*4
    else
        return variable/Game:getMaxTension()
    end
end
function TensionBar:drawFill()
    local tension_fill = self:getFillColor()
    local tension_max = self:getFillMaxColor()
    local tension_decrease = self:getFillDecreaseColor()
    -- 0 TO 100
    if self.apparent <=500 then
        if (self.apparent < self.current) then
            Draw.setColor(tension_decrease)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, 25, 196)

            Draw.setColor(tension_fill)
            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent > self.current) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, 25, 196)

            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end

            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.current) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent == self.current) then
            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end

            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, 25, 196)
        end

        if (self.tension_preview > 0) then
            local alpha = (math.abs((math.sin((self.tension_preview_timer / 8)) * 0.5)) + 0.2)
            local color_to_set = { 1, 1, 1, alpha }

            local theight = 196 - (self:getPercentageFor250(self.current) * 196)
            local theight2 = theight + (self:getPercentageFor(self.tension_preview) * 196)
            -- Note: causes a visual bug.
            if (theight2 > ((0 + 196) - 1)) then
                theight2 = ((0 + 196) - 1)
                color_to_set = { COLORS.dkgray[1], COLORS.dkgray[2], COLORS.dkgray[3], 0.7 }
            end

            local y = theight2 + 1
            local h = theight - theight2 + 1

            -- No idea how Deltarune draws this, cause this code was added in Kristal:
            local r, g, b, _ = love.graphics.getColor()
            Draw.setColor(r, g, b, 0.7)
            Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, 25, h)
            -- And back to the translated code:
            Draw.setColor(color_to_set)
            Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, 25, h)

            Draw.setColor(1, 1, 1, 1)
        end


        if ((self.apparent > 20) and (self.apparent < 250)) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, 25, 3)
        end
    end
    ---100 TO 200
    if self.apparent > 250 then
        local tension_fill={125/255, 24/255, 65/255, 1}
        local tension_max={255/255, 255/255, 255/255,  1}
        if (self.apparent < self.current) then
            Draw.setColor(tension_decrease)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-250) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_2, 0, y, 0, y, 25, 196)

            Draw.setColor(tension_fill)
            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent-250) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_2, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent > self.current) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent-250) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_2, 0, y, 0, y, 25, 196)
            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end
            print(tension_fill)
            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-250) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_2, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent == self.current) then
            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end

            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-250) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_2, 0, y, 0, y, 25, 196)
        end

        if (self.tension_preview > 0) then
            local alpha = (math.abs((math.sin((self.tension_preview_timer / 8)) * 0.5)) + 0.2)
            local color_to_set = { 1, 1, 1, alpha }

            local theight = 196 - (self:getPercentageFor250(self.current-250) * 196)
            local theight2 = theight + (self:getPercentageFor(self.tension_preview) * 196)
            -- Note: causes a visual bug.
            if (theight2 > ((0 + 196) - 1)) then
                theight2 = ((0 + 196) - 1)
                color_to_set = { COLORS.dkgray[1], COLORS.dkgray[2], COLORS.dkgray[3], 0.7 }
            end

            local y = theight2 + 1
            local h = theight - theight2 + 1

            -- No idea how Deltarune draws this, cause this code was added in Kristal:
            local r, g, b, _ = love.graphics.getColor()
            Draw.setColor(r, g, b, 0.7)
            Draw.drawPart(self.tp_bar_fill_2, 0, y, 0, y, 25, h)
            -- And back to the translated code:
            Draw.setColor(color_to_set)
            Draw.drawPart(self.tp_bar_fill_2, 0, y, 0, y, 25, h)

            Draw.setColor(1, 1, 1, 1)
        end


        if ((self.apparent-250 > 20) and (self.apparent-250 < 250)) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_2, 0, y, 0, y, 25, 3)
        end
    end
    -- 200 TO 300
    if self.apparent > 500 then
        local tension_fill={255/255, 30/255, 121/255, 1}
        local tension_max={255/255, 255/255, 255/255,  1}
        if (self.apparent < self.current) then
            Draw.setColor(tension_decrease)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-500) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_3, 0, y, 0, y, 25, 196)

            Draw.setColor(tension_fill)
            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent-500) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_3, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent > self.current) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent-500) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_3, 0, y, 0, y, 25, 196)
            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end
            print(tension_fill)
            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-500) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_3, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent == self.current) then
            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end

            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-500) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_3, 0, y, 0, y, 25, 196)
        end

        if (self.tension_preview > 0) then
            local alpha = (math.abs((math.sin((self.tension_preview_timer / 8)) * 0.5)) + 0.2)
            local color_to_set = { 1, 1, 1, alpha }

            local theight = 196 - (self:getPercentageFor250(self.current-500) * 196)
            local theight2 = theight + (self:getPercentageFor(self.tension_preview) * 196)
            -- Note: causes a visual bug.
            if (theight2 > ((0 + 196) - 1)) then
                theight2 = ((0 + 196) - 1)
                color_to_set = { COLORS.dkgray[1], COLORS.dkgray[2], COLORS.dkgray[3], 0.7 }
            end

            local y = theight2 + 1
            local h = theight - theight2 + 1

            -- No idea how Deltarune draws this, cause this code was added in Kristal:
            local r, g, b, _ = love.graphics.getColor()
            Draw.setColor(r, g, b, 0.7)
            Draw.drawPart(self.tp_bar_fill_3, 0, y, 0, y, 25, h)
            -- And back to the translated code:
            Draw.setColor(color_to_set)
            Draw.drawPart(self.tp_bar_fill_3, 0, y, 0, y, 25, h)

            Draw.setColor(1, 1, 1, 1)
        end


        if ((self.apparent-500 > 20) and (self.apparent-500 < 250)) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_3, 0, y, 0, y, 25, 3)
        end
    end
    -- 300 TO MAX
    if self.apparent > 750 then
        local tension_fill={255/255, 125/255, 121/255, 1}
        local tension_max={255/255, 255/255, 255/255,  1}
        if (self.apparent < self.current) then
            Draw.setColor(tension_decrease)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-750) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_4, 0, y, 0, y, 25, 196)

            Draw.setColor(tension_fill)
            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent-750) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_4, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent > self.current) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.apparent-750) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_4, 0, y, 0, y, 25, 196)
            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end
            print(tension_fill)
            local y2 = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-750) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_4, 0, y2, 0, y2, 25, 196)
        elseif (self.apparent == self.current) then
            Draw.setColor(tension_fill)
            if (self.maxed) then
                Draw.setColor(tension_max)
            end

            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-750) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 0, 196)
            Draw.drawPart(self.tp_bar_fill_4, 0, y, 0, y, 25, 196)
        end

        if (self.tension_preview > 0) then
            local alpha = (math.abs((math.sin((self.tension_preview_timer / 8)) * 0.5)) + 0.2)
            local color_to_set = { 1, 1, 1, alpha }

            local theight = 196 - (self:getPercentageFor250(self.current-750) * 196)
            local theight2 = theight + (self:getPercentageFor(self.tension_preview) * 196)
            -- Note: causes a visual bug.
            if (theight2 > ((0 + 196) - 1)) then
                theight2 = ((0 + 196) - 1)
                color_to_set = { COLORS.dkgray[1], COLORS.dkgray[2], COLORS.dkgray[3], 0.7 }
            end

            local y = theight2 + 1
            local h = theight - theight2 + 1

            -- No idea how Deltarune draws this, cause this code was added in Kristal:
            local r, g, b, _ = love.graphics.getColor()
            Draw.setColor(r, g, b, 0.7)
            Draw.drawPart(self.tp_bar_fill_4, 0, y, 0, y, 25, h)
            -- And back to the translated code:
            Draw.setColor(color_to_set)
            Draw.drawPart(self.tp_bar_fill_4, 0, y, 0, y, 25, h)

            Draw.setColor(1, 1, 1, 1)
        end


        if ((self.apparent-750 > 20) and (self.apparent-750 < 250)) then
            Draw.setColor(1, 1, 1, 1)
            local y = MathUtils.clamp(196 - (self:getPercentageFor250(self.current-750) * 196) + 1, 0, 196)
            Draw.drawPart(self.tp_bar_fill_4, 0, y, 0, y, 25, 3)
        end
    end
end
function TensionBar:drawText()
    if Game.isCelestial then
        Draw.setColor(1, 1, 1, 1)
        Draw.draw(self.tp_text, -30, 30)

        -- TODO: Game.chapter usage!
        local fixed_display = Game.chapter >= 5

        local tamt = 0

        if fixed_display then
            tamt = math.floor((self:getPercentageFor250(self.apparent) * 100) + 0.00001)
        else
            tamt = math.floor(self:getPercentageFor250(self.apparent) * 100)
        end

        if tamt < 0 then
            tamt = 0
        end

        self.maxed = false
        love.graphics.setFont(self.font)
        if (tamt < 400) then
            if fixed_display then
                if self.apparent<250 then
                    love.graphics.print(tostring(tamt), -30, 70)
                else
                    love.graphics.print(tostring(tamt), -39, 70)
                end
            else
                love.graphics.print(tostring(math.floor(self:getPercentageFor250(self.apparent) * 100)), -30, 70)
            end
            love.graphics.print("%", -25, 95)
        end

        if (tamt >= 400) then
            self.maxed = true

            self:drawMaxText()
        end
    else
        super.drawText(self)
    end
end
return TensionBar