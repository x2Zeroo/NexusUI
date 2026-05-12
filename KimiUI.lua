--[[
    KimiUI Library - RBX UI Style Upgrade
    =====================================
    This file contains ALL the modified and new functions to transform
    KimiUI into the RBX UI Library style shown in the reference image.
    
    HOW TO USE:
    1. Replace the entire Themes table in your KimiUI.lua
    2. Replace each corresponding function with the upgraded version below
    3. Add the new functions (CreateProgressBar, CreateBadge, CreateHorizontalTabs, CreateVerticalTabs) to the library
    
    The upgrade follows the exact visual style from the image:
    - Dark backgrounds with purple/violet accent
    - Pill-shaped toggles with descriptions
    - Dropdowns with icons per option
    - Inputs with type-specific icons
    - Horizontal pill tabs + Vertical icon tabs
    - Notifications with close buttons
    - Progress bars and hexagonal badges
--]]

-- ============================================================================
-- 1. REPLACE THE ENTIRE THEMES TABLE (Line ~192)
-- ============================================================================

local Themes = {
    Default = {
        Primary = Color3.fromRGB(22, 22, 28),
        Secondary = Color3.fromRGB(30, 30, 38),
        Accent = Color3.fromRGB(140, 100, 255),
        AccentLight = Color3.fromRGB(165, 125, 255),
        AccentDark = Color3.fromRGB(110, 75, 220),
        Background = Color3.fromRGB(18, 18, 24),
        Foreground = Color3.fromRGB(35, 35, 45),
        Surface = Color3.fromRGB(28, 28, 38),
        Text = Color3.fromRGB(230, 230, 240),
        TextDark = Color3.fromRGB(130, 130, 150),
        TextMuted = Color3.fromRGB(100, 100, 120),
        Border = Color3.fromRGB(50, 50, 65),
        BorderLight = Color3.fromRGB(65, 65, 85),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Error = Color3.fromRGB(255, 90, 90),
        Info = Color3.fromRGB(80, 160, 255)
    },
    Dark = {
        Primary = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(28, 28, 35),
        Accent = Color3.fromRGB(140, 100, 255),
        AccentLight = Color3.fromRGB(165, 125, 255),
        AccentDark = Color3.fromRGB(110, 75, 220),
        Background = Color3.fromRGB(15, 15, 20),
        Foreground = Color3.fromRGB(35, 35, 42),
        Surface = Color3.fromRGB(25, 25, 32),
        Text = Color3.fromRGB(220, 220, 225),
        TextDark = Color3.fromRGB(140, 140, 150),
        TextMuted = Color3.fromRGB(110, 110, 125),
        Border = Color3.fromRGB(48, 48, 60),
        BorderLight = Color3.fromRGB(60, 60, 75),
        Success = Color3.fromRGB(70, 180, 100),
        Warning = Color3.fromRGB(230, 160, 50),
        Error = Color3.fromRGB(230, 80, 80),
        Info = Color3.fromRGB(70, 140, 230)
    },
    Midnight = {
        Primary = Color3.fromRGB(25, 28, 45),
        Secondary = Color3.fromRGB(32, 36, 55),
        Accent = Color3.fromRGB(140, 100, 255),
        AccentLight = Color3.fromRGB(165, 125, 255),
        AccentDark = Color3.fromRGB(110, 75, 220),
        Background = Color3.fromRGB(20, 23, 38),
        Foreground = Color3.fromRGB(38, 42, 62),
        Surface = Color3.fromRGB(30, 34, 52),
        Text = Color3.fromRGB(225, 228, 240),
        TextDark = Color3.fromRGB(150, 155, 175),
        TextMuted = Color3.fromRGB(120, 125, 150),
        Border = Color3.fromRGB(55, 60, 85),
        BorderLight = Color3.fromRGB(70, 75, 105),
        Success = Color3.fromRGB(80, 200, 130),
        Warning = Color3.fromRGB(255, 190, 70),
        Error = Color3.fromRGB(255, 100, 100),
        Info = Color3.fromRGB(90, 150, 255)
    },
    Ocean = {
        Primary = Color3.fromRGB(20, 35, 50),
        Secondary = Color3.fromRGB(28, 48, 68),
        Accent = Color3.fromRGB(60, 160, 220),
        AccentLight = Color3.fromRGB(80, 180, 240),
        AccentDark = Color3.fromRGB(45, 135, 195),
        Background = Color3.fromRGB(15, 28, 42),
        Foreground = Color3.fromRGB(32, 52, 72),
        Surface = Color3.fromRGB(25, 42, 62),
        Text = Color3.fromRGB(220, 235, 245),
        TextDark = Color3.fromRGB(140, 160, 180),
        TextMuted = Color3.fromRGB(110, 130, 155),
        Border = Color3.fromRGB(45, 65, 90),
        BorderLight = Color3.fromRGB(58, 82, 110),
        Success = Color3.fromRGB(60, 180, 140),
        Warning = Color3.fromRGB(240, 170, 60),
        Error = Color3.fromRGB(230, 90, 90),
        Info = Color3.fromRGB(70, 160, 230)
    },
    Forest = {
        Primary = Color3.fromRGB(25, 40, 30),
        Secondary = Color3.fromRGB(32, 52, 38),
        Accent = Color3.fromRGB(80, 180, 120),
        AccentLight = Color3.fromRGB(100, 200, 140),
        AccentDark = Color3.fromRGB(60, 155, 100),
        Background = Color3.fromRGB(18, 32, 24),
        Foreground = Color3.fromRGB(35, 55, 40),
        Surface = Color3.fromRGB(28, 48, 35),
        Text = Color3.fromRGB(225, 240, 230),
        TextDark = Color3.fromRGB(150, 170, 155),
        TextMuted = Color3.fromRGB(120, 140, 125),
        Border = Color3.fromRGB(50, 70, 55),
        BorderLight = Color3.fromRGB(65, 88, 68),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(220, 180, 60),
        Error = Color3.fromRGB(230, 100, 90),
        Info = Color3.fromRGB(80, 170, 200)
    },
    Sunset = {
        Primary = Color3.fromRGB(45, 30, 35),
        Secondary = Color3.fromRGB(58, 38, 45),
        Accent = Color3.fromRGB(255, 130, 100),
        AccentLight = Color3.fromRGB(255, 150, 120),
        AccentDark = Color3.fromRGB(235, 105, 75),
        Background = Color3.fromRGB(35, 22, 28),
        Foreground = Color3.fromRGB(55, 38, 48),
        Surface = Color3.fromRGB(48, 32, 40),
        Text = Color3.fromRGB(245, 230, 230),
        TextDark = Color3.fromRGB(180, 155, 155),
        TextMuted = Color3.fromRGB(150, 125, 130),
        Border = Color3.fromRGB(75, 55, 62),
        BorderLight = Color3.fromRGB(92, 68, 78),
        Success = Color3.fromRGB(100, 200, 120),
        Warning = Color3.fromRGB(255, 190, 70),
        Error = Color3.fromRGB(255, 100, 90),
        Info = Color3.fromRGB(255, 140, 120)
    },
    Sakura = {
        Primary = Color3.fromRGB(42, 28, 38),
        Secondary = Color3.fromRGB(52, 35, 48),
        Accent = Color3.fromRGB(255, 140, 180),
        AccentLight = Color3.fromRGB(255, 160, 200),
        AccentDark = Color3.fromRGB(235, 115, 160),
        Background = Color3.fromRGB(35, 22, 32),
        Foreground = Color3.fromRGB(55, 38, 52),
        Surface = Color3.fromRGB(48, 32, 48),
        Text = Color3.fromRGB(245, 228, 235),
        TextDark = Color3.fromRGB(180, 155, 170),
        TextMuted = Color3.fromRGB(150, 130, 148),
        Border = Color3.fromRGB(72, 52, 68),
        BorderLight = Color3.fromRGB(88, 65, 82),
        Success = Color3.fromRGB(100, 200, 130),
        Warning = Color3.fromRGB(255, 200, 80),
        Error = Color3.fromRGB(255, 110, 100),
        Info = Color3.fromRGB(255, 150, 180)
    },
    Cyber = {
        Primary = Color3.fromRGB(15, 15, 30),
        Secondary = Color3.fromRGB(22, 22, 42),
        Accent = Color3.fromRGB(0, 255, 200),
        AccentLight = Color3.fromRGB(50, 255, 220),
        AccentDark = Color3.fromRGB(0, 230, 175),
        Background = Color3.fromRGB(10, 10, 22),
        Foreground = Color3.fromRGB(28, 28, 48),
        Surface = Color3.fromRGB(20, 20, 40),
        Text = Color3.fromRGB(220, 255, 245),
        TextDark = Color3.fromRGB(140, 170, 165),
        TextMuted = Color3.fromRGB(110, 145, 140),
        Border = Color3.fromRGB(40, 45, 75),
        BorderLight = Color3.fromRGB(55, 60, 95),
        Success = Color3.fromRGB(0, 230, 150),
        Warning = Color3.fromRGB(255, 200, 50),
        Error = Color3.fromRGB(255, 60, 100),
        Info = Color3.fromRGB(0, 200, 255)
    },
    Royal = {
        Primary = Color3.fromRGB(35, 25, 50),
        Secondary = Color3.fromRGB(45, 32, 65),
        Accent = Color3.fromRGB(160, 100, 255),
        AccentLight = Color3.fromRGB(180, 120, 255),
        AccentDark = Color3.fromRGB(140, 80, 235),
        Background = Color3.fromRGB(28, 18, 42),
        Foreground = Color3.fromRGB(48, 35, 68),
        Surface = Color3.fromRGB(42, 30, 62),
        Text = Color3.fromRGB(235, 225, 245),
        TextDark = Color3.fromRGB(165, 145, 185),
        TextMuted = Color3.fromRGB(140, 118, 165),
        Border = Color3.fromRGB(62, 48, 85),
        BorderLight = Color3.fromRGB(78, 60, 108),
        Success = Color3.fromRGB(120, 200, 100),
        Warning = Color3.fromRGB(240, 180, 60),
        Error = Color3.fromRGB(230, 90, 110),
        Info = Color3.fromRGB(150, 120, 255)
    },
    Monochrome = {
        Primary = Color3.fromRGB(30, 30, 30),
        Secondary = Color3.fromRGB(42, 42, 42),
        Accent = Color3.fromRGB(200, 200, 200),
        AccentLight = Color3.fromRGB(220, 220, 220),
        AccentDark = Color3.fromRGB(170, 170, 170),
        Background = Color3.fromRGB(22, 22, 22),
        Foreground = Color3.fromRGB(48, 48, 48),
        Surface = Color3.fromRGB(38, 38, 38),
        Text = Color3.fromRGB(235, 235, 235),
        TextDark = Color3.fromRGB(160, 160, 160),
        TextMuted = Color3.fromRGB(130, 130, 130),
        Border = Color3.fromRGB(60, 60, 60),
        BorderLight = Color3.fromRGB(78, 78, 78),
        Success = Color3.fromRGB(180, 220, 180),
        Warning = Color3.fromRGB(220, 200, 140),
        Error = Color3.fromRGB(220, 140, 140),
        Info = Color3.fromRGB(180, 200, 220)
    }
}

-- ============================================================================
-- 2. REPLACE CreateButton FUNCTION (Line ~972)
--    Adds "Secondary" button style support
-- ============================================================================

function KimiUI:CreateButton(config, parent)
    config = config or {}
    local buttonText = config.Name or config.Text or "Button"
    local callback = config.Callback or function() end
    local buttonStyle = config.Style or "Default" -- Default, Secondary, Outline, Ghost
    local buttonSize = config.Size or UDim2.new(1, 0, 0, 36)
    local icon = config.Icon or nil
    
    local bgColor, textColor, bgTransparency
    if buttonStyle == "Default" then
        bgColor = self.Theme.Accent
        textColor = Color3.fromRGB(255, 255, 255)
        bgTransparency = 0
    elseif buttonStyle == "Secondary" then
        bgColor = self.Theme.Surface
        textColor = self.Theme.Text
        bgTransparency = 0
    elseif buttonStyle == "Outline" then
        bgColor = self.Theme.Secondary
        textColor = self.Theme.Text
        bgTransparency = 0
    else -- Ghost
        bgColor = self.Theme.Secondary
        textColor = self.Theme.TextDark
        bgTransparency = 1
    end
    
    local buttonFrame = Utility:Create("TextButton", {
        Name = buttonText .. "Button",
        BackgroundColor3 = bgColor,
        BackgroundTransparency = bgTransparency,
        BorderSizePixel = 0,
        Size = buttonSize,
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = icon and "" or buttonText,
        TextColor3 = textColor,
        TextSize = 14,
        Parent = parent
    })
    Utility:CreateCorner(buttonFrame, 8)
    
    if buttonStyle == "Outline" then
        Utility:CreateStroke(buttonFrame, self.Theme.Accent, 1.5, 0.4)
    else
        Utility:CreateStroke(buttonFrame, self.Theme.Border, 1, 0.6)
    end
    
    -- Icon
    if icon then
        local iconLabel = Utility:Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, -10, 0.5, -10),
            Size = UDim2.new(0, 20, 0, 20),
            Image = icon,
            ImageColor3 = textColor,
            Parent = buttonFrame
        })
    end
    
    Utility:CreateRipple(buttonFrame)
    
    -- Hover Effects
    buttonFrame.MouseEnter:Connect(function()
        if buttonStyle == "Default" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.AccentLight}, 0.2)
        elseif buttonStyle == "Secondary" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Accent}, 0.2)
            buttonFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            Utility:Tween(buttonFrame, {BackgroundTransparency = 0.85}, 0.2)
        end
    end)
    
    buttonFrame.MouseLeave:Connect(function()
        if buttonStyle == "Default" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Accent}, 0.2)
        elseif buttonStyle == "Secondary" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Surface}, 0.2)
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
            buttonFrame.TextColor3 = textColor
        else
            Utility:Tween(buttonFrame, {BackgroundTransparency = 1}, 0.2)
        end
    end)
    
    buttonFrame.MouseButton1Click:Connect(function()
        callback()
    end)
    
    local Button = {
        Frame = buttonFrame,
        Callback = callback,
        Type = "Button",
        UpdateTheme = function(_, theme)
            if buttonStyle == "Default" then
                buttonFrame.BackgroundColor3 = theme.Accent
            elseif buttonStyle == "Secondary" then
                buttonFrame.BackgroundColor3 = theme.Surface
            elseif buttonStyle == "Outline" then
                buttonFrame.BackgroundColor3 = theme.Secondary
            end
        end
    }
    
    table.insert(self.Elements, Button)
    return Button
end

-- ============================================================================
-- 3. REPLACE CreateToggle FUNCTION (Line ~1039)
--    Adds description support, improved visual style
-- ============================================================================

function KimiUI:CreateToggle(config, parent)
    config = config or {}
    local toggleName = config.Name or "Toggle"
    local description = config.Description or config.Desc or ""
    local default = config.Default or false
    local callback = config.Callback or function() end
    local flag = config.Flag or nil
    local toggleIcon = config.Icon or nil
    
    if flag then
        self.Flags[flag] = default
    end
    
    local frameHeight = description ~= "" and 64 or 48
    
    local toggleFrame = Utility:Create("Frame", {
        Name = toggleName .. "Toggle",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, frameHeight),
        Parent = parent
    })
    Utility:CreateCorner(toggleFrame, 10)
    Utility:CreateStroke(toggleFrame, self.Theme.Border, 1, 0.5)
    
    -- Icon
    local iconOffset = 12
    if toggleIcon then
        local iconLabel = Utility:Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 12),
            Size = UDim2.new(0, 22, 0, 22),
            Image = toggleIcon,
            ImageColor3 = self.Theme.TextDark,
            Parent = toggleFrame
        })
        iconOffset = 42
    end
    
    local toggleLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, iconOffset, 0, description ~= "" and 8 or 0),
        Size = UDim2.new(1, -110, 0, description ~= "" and 20 or frameHeight),
        Font = Enum.Font.GothamSemibold,
        Text = toggleName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleFrame
    })
    
    -- Description
    if description ~= "" then
        local descLabel = Utility:Create("TextLabel", {
            Name = "Description",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, iconOffset, 0, 30),
            Size = UDim2.new(1, -110, 0, 28),
            Font = Enum.Font.Gotham,
            Text = description,
            TextColor3 = self.Theme.TextMuted,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Parent = toggleFrame
        })
    end
    
    local toggleButton = Utility:Create("TextButton", {
        Name = "ToggleButton",
        BackgroundColor3 = default and self.Theme.Accent or self.Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -56, 0.5, -14),
        Size = UDim2.new(0, 48, 0, 28),
        AutoButtonColor = false,
        Text = "",
        Parent = toggleFrame
    })
    Utility:CreateCorner(toggleButton, 14)
    
    local toggleCircle = Utility:Create("Frame", {
        Name = "Circle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = default and UDim2.new(1, -24, 0, 3) or UDim2.new(0, 3, 0, 3),
        Size = UDim2.new(0, 22, 0, 22),
        Parent = toggleButton
    })
    Utility:CreateCorner(toggleCircle, 11)
    
    -- Subtle shadow on circle
    Utility:Create("ImageLabel", {
        Name = "CircleShadow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 2),
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = toggleCircle.ZIndex - 1,
        Image = "",
        ImageTransparency = 1,
        Parent = toggleCircle
    })
    
    local toggled = default
    
    toggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        if flag then
            self.Flags[flag] = toggled
        end
        
        Utility:Tween(toggleButton, {
            BackgroundColor3 = toggled and self.Theme.Accent or self.Theme.Border
        }, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        Utility:Tween(toggleCircle, {
            Position = toggled and UDim2.new(1, -25, 0, 3) or UDim2.new(0, 3, 0, 3)
        }, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        
        callback(toggled)
    end)
    
    local Toggle = {
        Frame = toggleFrame,
        Value = toggled,
        Type = "Toggle",
        Set = function(_, value)
            toggled = value
            if flag then
                KimiUI.CurrentWindow.Flags[flag] = toggled
            end
            Utility:Tween(toggleButton, {
                BackgroundColor3 = toggled and KimiUI.CurrentWindow.Theme.Accent or KimiUI.CurrentWindow.Theme.Border
            }, 0.25)
            Utility:Tween(toggleCircle, {
                Position = toggled and UDim2.new(1, -25, 0, 3) or UDim2.new(0, 3, 0, 3)
            }, 0.25)
            callback(toggled)
        end,
        UpdateTheme = function(_, theme)
            toggleFrame.BackgroundColor3 = theme.Foreground
            toggleButton.BackgroundColor3 = toggled and theme.Accent or theme.Border
            Utility:CreateStroke(toggleFrame, theme.Border, 1, 0.5)
        end
    }
    
    table.insert(self.Elements, Toggle)
    return Toggle
end

-- ============================================================================
-- 4. REPLACE CreateSlider FUNCTION (Line ~1152)
--    Improved thumb styling
-- ============================================================================

function KimiUI:CreateSlider(config, parent)
    config = config or {}
    local sliderName = config.Name or "Slider"
    local min = config.Min or config.Minimum or 0
    local max = config.Max or config.Maximum or 100
    local default = config.Default or min
    local increment = config.Increment or config.Step or 1
    local suffix = config.Suffix or config.Postfix or ""
    local callback = config.Callback or function() end
    local flag = config.Flag or nil
    
    default = math.clamp(default, min, max)
    if flag then
        self.Flags[flag] = default
    end
    
    local sliderFrame = Utility:Create("Frame", {
        Name = sliderName .. "Slider",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 58),
        Parent = parent
    })
    Utility:CreateCorner(sliderFrame, 10)
    Utility:CreateStroke(sliderFrame, self.Theme.Border, 1, 0.5)
    
    local sliderLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -80, 0, 20),
        Font = Enum.Font.GothamSemibold,
        Text = sliderName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sliderFrame
    })
    
    local valueLabel = Utility:Create("TextLabel", {
        Name = "Value",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -72, 0, 8),
        Size = UDim2.new(0, 60, 0, 20),
        Font = Enum.Font.GothamSemibold,
        Text = tostring(default) .. suffix,
        TextColor3 = self.Theme.TextDark,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = sliderFrame
    })
    
    local sliderBackground = Utility:Create("Frame", {
        Name = "Background",
        BackgroundColor3 = self.Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 36),
        Size = UDim2.new(1, -24, 0, 6),
        Parent = sliderFrame
    })
    Utility:CreateCorner(sliderBackground, 3)
    
    local sliderFill = Utility:Create("Frame", {
        Name = "Fill",
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        Parent = sliderBackground
    })
    Utility:CreateCorner(sliderFill, 3)
    
    -- Fill glow effect
    Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, self.Theme.Accent),
            ColorSequenceKeypoint.new(1, self.Theme.AccentLight)
        }),
        Parent = sliderFill
    })
    
    local sliderThumb = Utility:Create("Frame", {
        Name = "Thumb",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new((default - min) / (max - min), -9, 0.5, -9),
        Size = UDim2.new(0, 18, 0, 18),
        ZIndex = 3,
        Parent = sliderBackground
    })
    Utility:CreateCorner(sliderThumb, 9)
    
    -- Thumb shadow
    Utility:Create("ImageLabel", {
        Name = "ThumbShadow",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 2),
        Size = UDim2.new(1, 6, 1, 6),
        ZIndex = sliderThumb.ZIndex - 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.7,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        Parent = sliderThumb
    })
    
    local dragging = false
    
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * pos
        value = math.floor(value / increment + 0.5) * increment
        value = Utility:RoundNumber(value, #tostring(increment) - 2)
        value = math.clamp(value, min, max)
        
        local fillSize = (value - min) / (max - min)
        sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
        sliderThumb.Position = UDim2.new(fillSize, -9, 0.5, -9)
        valueLabel.Text = tostring(value) .. suffix
        
        if flag then
            self.Flags[flag] = value
        end
        
        callback(value)
    end
    
    sliderBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)
    
    sliderThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    local Slider = {
        Frame = sliderFrame,
        Value = default,
        Type = "Slider",
        Set = function(_, value)
            value = math.clamp(value, min, max)
            value = math.floor(value / increment + 0.5) * increment
            local fillSize = (value - min) / (max - min)
            sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
            sliderThumb.Position = UDim2.new(fillSize, -9, 0.5, -9)
            valueLabel.Text = tostring(value) .. suffix
            if flag then
                KimiUI.CurrentWindow.Flags[flag] = value
            end
            callback(value)
        end,
        UpdateTheme = function(_, theme)
            sliderFrame.BackgroundColor3 = theme.Foreground
            sliderBackground.BackgroundColor3 = theme.Border
            sliderFill.BackgroundColor3 = theme.Accent
            Utility:CreateStroke(sliderFrame, theme.Border, 1, 0.5)
        end
    }
    
    table.insert(self.Elements, Slider)
    return Slider
end

-- ============================================================================
-- 5. REPLACE CreateInput FUNCTION (Line ~1303)
--    Adds type-specific icons (Text, Number, Search, Password)
-- ============================================================================

function KimiUI:CreateInput(config, parent)
    config = config or {}
    local inputName = config.Name or "Input"
    local placeholder = config.Placeholder or "Enter text..."
    local default = config.Default or ""
    local callback = config.Callback or function() end
    local inputType = config.Type or "Default" -- Default, Number, Search, Password
    local flag = config.Flag or nil
    
    if flag then
        self.Flags[flag] = default
    end
    
    -- Type icons matching the image
    local typeIcons = {
        Default = "rbxassetid://7733955511",   -- Person icon
        Number = "rbxassetid://7733950678",    -- Hash/number icon  
        Search = "rbxassetid://7733954760",    -- Search icon
        Password = "rbxassetid://7733951820"   -- Lock icon
    }
    local inputIcon = typeIcons[inputType] or typeIcons.Default
    
    local inputFrame = Utility:Create("Frame", {
        Name = inputName .. "Input",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 72),
        Parent = parent
    })
    Utility:CreateCorner(inputFrame, 10)
    Utility:CreateStroke(inputFrame, self.Theme.Border, 1, 0.5)
    
    local inputLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -24, 0, 20),
        Font = Enum.Font.GothamSemibold,
        Text = inputName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = inputFrame
    })
    
    -- Input container with icon
    local inputContainer = Utility:Create("Frame", {
        Name = "Container",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 34),
        Size = UDim2.new(1, -24, 0, 30),
        Parent = inputFrame
    })
    Utility:CreateCorner(inputContainer, 8)
    
    -- Icon
    local iconLabel = Utility:Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0.5, -9),
        Size = UDim2.new(0, 18, 0, 18),
        Image = inputIcon,
        ImageColor3 = self.Theme.TextDark,
        ImageTransparency = 0.4,
        Parent = inputContainer
    })
    
    local inputBox = Utility:Create("TextBox", {
        Name = "InputBox",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 32, 0, 0),
        Size = UDim2.new(1, -42, 1, 0),
        Font = Enum.Font.Gotham,
        Text = default,
        TextColor3 = self.Theme.Text,
        PlaceholderText = placeholder,
        PlaceholderColor3 = self.Theme.TextMuted,
        TextSize = 13,
        ClearTextOnFocus = false,
        Parent = inputContainer
    })
    
    -- Show/hide password button for Password type
    if inputType == "Password" then
        inputBox.Text = string.rep("•", #default)
        
        local showBtn = Utility:Create("TextButton", {
            Name = "ShowHide",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -28, 0.5, -10),
            Size = UDim2.new(0, 20, 0, 20),
            Font = Enum.Font.Gotham,
            Text = "👁",
            TextColor3 = self.Theme.TextDark,
            TextSize = 12,
            Parent = inputContainer
        })
        
        local showing = false
        local actualText = default
        
        showBtn.MouseButton1Click:Connect(function()
            showing = not showing
            inputBox.Text = showing and actualText or string.rep("•", #actualText)
            showBtn.TextColor3 = showing and self.Theme.Accent or self.Theme.TextDark
        end)
        
        inputBox:GetPropertyChangedSignal("Text"):Connect(function()
            if not showing then
                actualText = inputBox.Text
                local cursorPos = inputBox.CursorPosition
                inputBox.Text = string.rep("•", #actualText)
                inputBox.CursorPosition = cursorPos
            else
                actualText = inputBox.Text
            end
        end)
        
        inputBox.FocusLost:Connect(function(enterPressed)
            if flag then
                self.Flags[flag] = actualText
            end
            callback(actualText, enterPressed)
        end)
    else
        inputBox.FocusLost:Connect(function(enterPressed)
            if flag then
                self.Flags[flag] = inputBox.Text
            end
            callback(inputBox.Text, enterPressed)
        end)
    end
    
    inputContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            inputBox:CaptureFocus()
        end
    end)
    
    inputBox.Focused:Connect(function()
        Utility:Tween(inputContainer, {BackgroundColor3 = self.Theme.Primary}, 0.2)
        Utility:Tween(iconLabel, {ImageColor3 = self.Theme.Accent, ImageTransparency = 0}, 0.2)
    end)
    
    inputBox.FocusLost:Connect(function()
        Utility:Tween(inputContainer, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
        Utility:Tween(iconLabel, {ImageColor3 = self.Theme.TextDark, ImageTransparency = 0.4}, 0.2)
    end)
    
    local Input = {
        Frame = inputFrame,
        InputBox = inputBox,
        Value = default,
        Type = "Input",
        Set = function(_, value)
            inputBox.Text = value
            if flag then
                KimiUI.CurrentWindow.Flags[flag] = value
            end
        end,
        UpdateTheme = function(_, theme)
            inputFrame.BackgroundColor3 = theme.Foreground
            inputContainer.BackgroundColor3 = theme.Secondary
            Utility:CreateStroke(inputFrame, theme.Border, 1, 0.5)
        end
    }
    
    table.insert(self.Elements, Input)
    return Input
end

-- ============================================================================
-- 6. REPLACE CreateDropdown FUNCTION (Line ~1395)
--    Adds option icons, improved styling with check indicators
-- ============================================================================

function KimiUI:CreateDropdown(config, parent)
    config = config or {}
    local dropdownName = config.Name or "Dropdown"
    local options = config.Options or config.Values or {}
    local optionIcons = config.OptionIcons or {} -- Map of option -> icon asset id
    local default = config.Default or config.Value or (options[1] or "")
    local callback = config.Callback or function() end
    local multiSelect = config.MultiSelect or false
    local flag = config.Flag or nil
    
    if flag then
        self.Flags[flag] = multiSelect and {default} or default
    end
    
    local dropdownFrame = Utility:Create("Frame", {
        Name = dropdownName .. "Dropdown",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 68),
        ClipsDescendants = true,
        Parent = parent
    })
    Utility:CreateCorner(dropdownFrame, 10)
    Utility:CreateStroke(dropdownFrame, self.Theme.Border, 1, 0.5)
    
    local dropdownLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -24, 0, 20),
        Font = Enum.Font.GothamSemibold,
        Text = dropdownName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdownFrame
    })
    
    local dropdownButton = Utility:Create("TextButton", {
        Name = "DropdownButton",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 34),
        Size = UDim2.new(1, -24, 0, 30),
        AutoButtonColor = false,
        Font = Enum.Font.Gotham,
        Text = multiSelect and (default ~= "" and default or "Select an Option") or (default ~= "" and tostring(default) or "Select an Option"),
        TextColor3 = self.Theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdownFrame
    })
    Utility:CreateCorner(dropdownButton, 8)
    Utility:CreatePadding(dropdownButton, 10)
    
    local arrowIcon = Utility:Create("ImageLabel", {
        Name = "Arrow",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -28, 0, 5),
        Size = UDim2.new(0, 20, 0, 20),
        Image = "rbxassetid://7072706663",
        ImageColor3 = self.Theme.TextDark,
        Parent = dropdownButton
    })
    
    local optionsFrame = Utility:Create("Frame", {
        Name = "Options",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 68),
        Size = UDim2.new(1, -24, 0, 0),
        ClipsDescendants = true,
        Visible = false,
        Parent = dropdownFrame
    })
    Utility:CreateCorner(optionsFrame, 8)
    
    local optionsLayout = Utility:CreateListLayout(optionsFrame, 2)
    Utility:CreatePadding(optionsFrame, 6)
    
    local selectedValues = multiSelect and {default} or default
    local isOpen = false
    
    local function toggleDropdown()
        isOpen = not isOpen
        if isOpen then
            optionsFrame.Visible = true
            local totalHeight = math.min(#options * 32 + 12, 180)
            Utility:Tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 74 + totalHeight)}, 0.3)
            Utility:Tween(optionsFrame, {Size = UDim2.new(1, -24, 0, totalHeight)}, 0.3)
            Utility:Tween(arrowIcon, {Rotation = 180}, 0.3)
        else
            Utility:Tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 68)}, 0.3)
            Utility:Tween(optionsFrame, {Size = UDim2.new(1, -24, 0, 0)}, 0.3)
            Utility:Tween(arrowIcon, {Rotation = 0}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function()
                optionsFrame.Visible = false
            end)
        end
    end
    
    dropdownButton.MouseButton1Click:Connect(toggleDropdown)
    
    --// Create Options
    for _, option in pairs(options) do
        local optIcon = optionIcons[option]
        local optPadding = optIcon and 36 or 10
        
        local optionButton = Utility:Create("TextButton", {
            Name = tostring(option) .. "Option",
            BackgroundColor3 = self.Theme.Secondary,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -12, 0, 30),
            AutoButtonColor = false,
            Font = Enum.Font.Gotham,
            Text = tostring(option),
            TextColor3 = self.Theme.TextDark,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = optionsFrame
        })
        Utility:CreateCorner(optionButton, 6)
        
        -- Option icon
        if optIcon then
            local optIconImg = Utility:Create("ImageLabel", {
                Name = "OptionIcon",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 8, 0.5, -8),
                Size = UDim2.new(0, 16, 0, 16),
                Image = optIcon,
                ImageColor3 = self.Theme.TextDark,
                Parent = optionButton
            })
            optionButton.Text = "      " .. tostring(option)
        end
        
        -- Selection indicator (circle)
        local indicator = Utility:Create("Frame", {
            Name = "Indicator",
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -10, 0.5, 0),
            Size = UDim2.new(0, 14, 0, 14),
            Parent = optionButton
        })
        Utility:CreateCorner(indicator, 7)
        Utility:CreateStroke(indicator, self.Theme.Border, 1.5, 0.6)
        
        optionButton.MouseEnter:Connect(function()
            Utility:Tween(optionButton, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
            Utility:Tween(optionButton, {TextColor3 = self.Theme.Text}, 0.2)
        end)
        
        optionButton.MouseLeave:Connect(function()
            local isSelected = multiSelect and table.find(selectedValues, option) or selectedValues == option
            Utility:Tween(optionButton, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
            Utility:Tween(optionButton, {TextColor3 = isSelected and self.Theme.Accent or self.Theme.TextDark}, 0.2)
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            if multiSelect then
                if table.find(selectedValues, option) then
                    table.remove(selectedValues, table.find(selectedValues, option))
                else
                    table.insert(selectedValues, option)
                end
                dropdownButton.Text = #selectedValues > 0 and table.concat(selectedValues, ", ") or "Select..."
            else
                selectedValues = option
                dropdownButton.Text = tostring(option)
                -- Update all option visuals
                for _, child in pairs(optionsFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        local isSel = child.Name == (tostring(option) .. "Option")
                        child.TextColor3 = isSel and self.Theme.Accent or self.Theme.TextDark
                        local ind = child:FindFirstChild("Indicator")
                        if ind then
                            ind.BackgroundColor3 = self.Theme.Accent
                            ind.BackgroundTransparency = isSel and 0 or 1
                        end
                    end
                end
                toggleDropdown()
            end
            
            if flag then
                self.Flags[flag] = selectedValues
            end
            
            callback(selectedValues)
        end)
        
        -- Set initial selection visual
        if not multiSelect and option == default then
            optionButton.TextColor3 = self.Theme.Accent
            indicator.BackgroundColor3 = self.Theme.Accent
            indicator.BackgroundTransparency = 0
        end
    end
    
    local Dropdown = {
        Frame = dropdownFrame,
        Value = selectedValues,
        Options = options,
        Type = "Dropdown",
        Set = function(_, value)
            selectedValues = value
            if multiSelect then
                dropdownButton.Text = #selectedValues > 0 and table.concat(selectedValues, ", ") or "Select..."
            else
                dropdownButton.Text = tostring(value)
            end
            if flag then
                KimiUI.CurrentWindow.Flags[flag] = selectedValues
            end
            callback(selectedValues)
        end,
        Refresh = function(_, newOptions)
            for _, child in pairs(optionsFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            Dropdown.Options = newOptions
        end,
        UpdateTheme = function(_, theme)
            dropdownFrame.BackgroundColor3 = theme.Foreground
            dropdownButton.BackgroundColor3 = theme.Secondary
            optionsFrame.BackgroundColor3 = theme.Secondary
            Utility:CreateStroke(dropdownFrame, theme.Border, 1, 0.5)
        end
    }
    
    table.insert(self.Elements, Dropdown)
    return Dropdown
end

-- ============================================================================
-- 7. REPLACE Notify FUNCTION (Line ~2371)
--    Adds close button (X), improved styling with accent top border
-- ============================================================================

function KimiUI:Notify(config)
    config = config or {}
    local notifyTitle = config.Title or "Notification"
    local notifyContent = config.Content or config.Message or config.Text or ""
    local notifyType = config.Type or "Info" -- Info, Success, Warning, Error
    local duration = config.Duration or 5
    
    local notifyGui = Utility:Create("ScreenGui", {
        Name = "KimiUINotifications",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = self.ScreenGui.Parent
    })
    
    local notificationFrame = Utility:Create("Frame", {
        Name = "Notification",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(1, 20, 1, -100),
        Size = UDim2.new(0, 320, 0, 86),
        Parent = notifyGui
    })
    Utility:CreateCorner(notificationFrame, 10)
    Utility:CreateShadow(notificationFrame, 0.35)
    Utility:CreateStroke(notificationFrame, self.Theme.Border, 1, 0.5)
    
    --// Top Accent Bar
    local typeColors = {
        Info = self.Theme.Info,
        Success = self.Theme.Success,
        Warning = self.Theme.Warning,
        Error = self.Theme.Error
    }
    
    local typeColor = typeColors[notifyType] or self.Theme.Info
    
    local topBar = Utility:Create("Frame", {
        Name = "TopBar",
        BackgroundColor3 = typeColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 3),
        Parent = notificationFrame
    })
    Utility:CreateCorner(topBar, 10)
    
    local barCornerFix = Utility:Create("Frame", {
        BackgroundColor3 = typeColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 0.5, 0),
        Parent = topBar
    })
    
    --// Icon
    local typeIcons = {
        Info = "rbxassetid://7733970536",
        Success = "rbxassetid://7733973319",
        Warning = "rbxassetid://7733956188",
        Error = "rbxassetid://7733951820"
    }
    
    local icon = Utility:Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 14, 0, 46),
        Size = UDim2.new(0, 26, 0, 26),
        Image = typeIcons[notifyType] or typeIcons.Info,
        ImageColor3 = typeColor,
        Parent = notificationFrame
    })
    
    --// Title
    local titleLabel = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 48, 0, 14),
        Size = UDim2.new(1, -80, 0, 22),
        Font = Enum.Font.GothamBold,
        Text = notifyTitle,
        TextColor3 = self.Theme.Text,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notificationFrame
    })
    
    --// Content
    local contentLabel = Utility:Create("TextLabel", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 48, 0, 38),
        Size = UDim2.new(1, -60, 0, 40),
        Font = Enum.Font.Gotham,
        Text = notifyContent,
        TextColor3 = self.Theme.TextDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = notificationFrame
    })
    
    --// Close Button (X)
    local closeBtn = Utility:Create("TextButton", {
        Name = "Close",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -32, 0, 8),
        Size = UDim2.new(0, 24, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = self.Theme.TextDark,
        TextSize = 20,
        Parent = notificationFrame
    })
    
    closeBtn.MouseEnter:Connect(function()
        Utility:Tween(closeBtn, {TextColor3 = self.Theme.Error}, 0.2)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        Utility:Tween(closeBtn, {TextColor3 = self.Theme.TextDark}, 0.2)
    end)
    
    local function dismiss()
        Utility:Tween(notificationFrame, {Position = UDim2.new(1, 20, 1, notificationFrame.Position.Y.Offset)}, 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In, function()
            if notifyGui and notifyGui.Parent then
                notifyGui:Destroy()
            end
        end)
    end
    
    closeBtn.MouseButton1Click:Connect(dismiss)
    
    --// Show Animation (slide from right)
    notificationFrame.Position = UDim2.new(1, 20, 1, -100)
    Utility:Tween(notificationFrame, {Position = UDim2.new(1, -340, 1, -100)}, 0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    --// Auto Close
    task.delay(duration, function()
        if notificationFrame and notificationFrame.Parent then
            dismiss()
        end
    end)
end

-- ============================================================================
-- 8. REPLACE CreateWindow FUNCTION - Title Bar section (Line ~452)
--    Improved title bar with accent line
-- ============================================================================

-- Replace ONLY the title bar section in CreateWindow (lines 452-470):

    --// Title Bar
    local titleBar = Utility:Create("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        Parent = mainFrame
    })
    
    --// Title Bar Bottom Accent Line
    Utility:Create("Frame", {
        Name = "AccentLine",
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 2),
        Parent = titleBar
    })
    
    -- Gradient overlay on title bar
    local titleGradient = Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, theme.Primary),
            ColorSequenceKeypoint.new(1, theme.Secondary)
        }),
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 0.3)
        }),
        Parent = titleBar
    })

-- ============================================================================
-- 9. REPLACE SelectTab FUNCTION (Line ~927)
--    Improved tab selection with pill-style active indicator
-- ============================================================================

function KimiUI:SelectTab(tab)
    if self.ActiveTab == tab then return end
    
    -- Deselect current tab
    if self.ActiveTab then
        Utility:Tween(self.ActiveTab.Button, {
            BackgroundColor3 = self.Theme.Secondary
        }, 0.25)
        Utility:Tween(self.ActiveTab.Indicator, {
            Size = UDim2.new(0, 3, 0, 0),
            Position = UDim2.new(0, 0, 0.5, 0)
        }, 0.25)
        self.ActiveTab.Content.Visible = false
        
        local icon = self.ActiveTab.Button:FindFirstChild("Icon")
        if icon then
            Utility:Tween(icon, {ImageColor3 = self.Theme.TextDark}, 0.25)
        end
        local text = self.ActiveTab.Button:FindFirstChild("Text")
        if text then
            Utility:Tween(text, {TextColor3 = self.Theme.TextDark}, 0.25)
        end
    end
    
    -- Select new tab
    self.ActiveTab = tab
    Utility:Tween(tab.Button, {
        BackgroundColor3 = self.Theme.Foreground
    }, 0.25)
    Utility:Tween(tab.Indicator, {
        Size = UDim2.new(0, 3, 1, -12),
        Position = UDim2.new(0, 0, 0, 6)
    }, 0.25)
    tab.Content.Visible = true
    
    local icon = tab.Button:FindFirstChild("Icon")
    if icon then
        Utility:Tween(icon, {ImageColor3 = tab.Color}, 0.25)
    end
    local text = tab.Button:FindFirstChild("Text")
    if text then
        Utility:Tween(text, {TextColor3 = self.Theme.Text}, 0.25)
    end
end

-- ============================================================================
-- 10. NEW FUNCTION: CreateHorizontalTabs
--     Creates pill-style horizontal tabs like in the image (Overview | Inventory | Stats)
-- ============================================================================

function KimiUI:CreateHorizontalTabs(config, parent)
    config = config or {}
    local tabs = config.Tabs or config.Options or {"Tab 1", "Tab 2", "Tab 3"}
    local tabIcons = config.Icons or {}
    local defaultTab = config.Default or 1
    local callback = config.Callback or function() end
    
    local container = Utility:Create("Frame", {
        Name = "HorizontalTabs",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 42),
        Parent = parent
    })
    
    local tabButtons = {}
    local activeIndex = defaultTab
    
    local totalTabs = #tabs
    local spacing = 6
    local tabWidth = (1 - (spacing * (totalTabs - 1)) / container.AbsoluteSize.X) / totalTabs
    
    for i, tabName in pairs(tabs) do
        local tabBtn = Utility:Create("TextButton", {
            Name = tabName .. "Tab",
            BackgroundColor3 = i == defaultTab and self.Theme.Accent or self.Theme.Foreground,
            BorderSizePixel = 0,
            Position = UDim2.new((i - 1) * (1 / totalTabs), (i - 1) * spacing, 0, 2),
            Size = UDim2.new(1 / totalTabs, -spacing, 1, -4),
            AutoButtonColor = false,
            Font = Enum.Font.GothamSemibold,
            Text = tabIcons[i] and "" or tabName,
            TextColor3 = i == defaultTab and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark,
            TextSize = 13,
            Parent = container
        })
        Utility:CreateCorner(tabBtn, 8)
        
        -- Icon
        if tabIcons[i] then
            local tIcon = Utility:Create("ImageLabel", {
                Name = "TabIcon",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 8, 0.5, -8),
                Size = UDim2.new(0, 16, 0, 16),
                Image = tabIcons[i],
                ImageColor3 = i == defaultTab and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark,
                Parent = tabBtn
            })
            local tText = Utility:Create("TextLabel", {
                Name = "TabText",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 28, 0, 0),
                Size = UDim2.new(1, -32, 1, 0),
                Font = Enum.Font.GothamSemibold,
                Text = tabName,
                TextColor3 = i == defaultTab and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark,
                TextSize = 13,
                Parent = tabBtn
            })
        end
        
        tabButtons[i] = tabBtn
        
        tabBtn.MouseButton1Click:Connect(function()
            if activeIndex == i then return end
            activeIndex = i
            
            -- Update all tabs
            for j, btn in pairs(tabButtons) do
                local isActive = j == i
                Utility:Tween(btn, {BackgroundColor3 = isActive and self.Theme.Accent or self.Theme.Foreground}, 0.25)
                btn.TextColor3 = isActive and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark
                local tIcon = btn:FindFirstChild("TabIcon")
                if tIcon then
                    Utility:Tween(tIcon, {ImageColor3 = isActive and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark}, 0.25)
                end
                local tText = btn:FindFirstChild("TabText")
                if tText then
                    tText.TextColor3 = isActive and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark
                end
            end
            
            callback(i, tabName)
        end)
        
        tabBtn.MouseEnter:Connect(function()
            if activeIndex ~= i then
                Utility:Tween(tabBtn, {BackgroundColor3 = self.Theme.Surface}, 0.2)
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if activeIndex ~= i then
                Utility:Tween(tabBtn, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
            end
        end)
    end
    
    local HorizontalTabs = {
        Frame = container,
        ActiveIndex = activeIndex,
        Type = "HorizontalTabs",
        Select = function(_, index)
            if tabButtons[index] then
                tabButtons[index].MouseButton1Click:Fire()
            end
        end,
        UpdateTheme = function(_, theme)
            for j, btn in pairs(tabButtons) do
                local isActive = j == activeIndex
                btn.BackgroundColor3 = isActive and theme.Accent or theme.Foreground
            end
        end
    }
    
    table.insert(self.Elements, HorizontalTabs)
    return HorizontalTabs
end

-- ============================================================================
-- 11. NEW FUNCTION: CreateVerticalTabs
--     Creates vertical tab section like in the image (General, Appearance, Controls...)
-- ============================================================================

function KimiUI:CreateVerticalTabs(config, parent)
    config = config or {}
    local tabs = config.Tabs or {}
    local defaultTab = config.Default or 1
    local tabWidth = config.TabWidth or 140
    
    --[[
        Tabs format: {
            {Name = "General", Icon = "rbxassetid://..."},
            {Name = "Appearance", Icon = "rbxassetid://..."},
            {Name = "Controls", Icon = "rbxassetid://..."},
        }
    --]]
    
    local container = Utility:Create("Frame", {
        Name = "VerticalTabs",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 280),
        Parent = parent
    })
    
    -- Tab list (left side)
    local tabList = Utility:Create("Frame", {
        Name = "TabList",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, tabWidth, 1, 0),
        Parent = container
    })
    
    local tabListLayout = Utility:CreateListLayout(tabList, 3)
    
    -- Content area (right side)
    local contentArea = Utility:Create("Frame", {
        Name = "ContentArea",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, tabWidth + 10, 0, 0),
        Size = UDim2.new(1, -(tabWidth + 10), 1, 0),
        Parent = container
    })
    
    local tabButtons = {}
    local contentFrames = {}
    local activeIndex = defaultTab
    
    for i, tabData in pairs(tabs) do
        local tabName = typeof(tabData) == "string" and tabData or tabData.Name
        local tabIcon = typeof(tabData) == "table" and tabData.Icon or nil
        
        -- Tab button
        local tabBtn = Utility:Create("TextButton", {
            Name = tabName .. "VTab",
            BackgroundColor3 = i == defaultTab and self.Theme.Accent or self.Theme.Foreground,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 36),
            AutoButtonColor = false,
            Font = Enum.Font.GothamSemibold,
            Text = tabIcon and "" or tabName,
            TextColor3 = i == defaultTab and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabList
        })
        Utility:CreateCorner(tabBtn, 8)
        
        if tabIcon then
            local vIcon = Utility:Create("ImageLabel", {
                Name = "VTabIcon",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0.5, -9),
                Size = UDim2.new(0, 18, 0, 18),
                Image = tabIcon,
                ImageColor3 = i == defaultTab and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark,
                Parent = tabBtn
            })
            local vText = Utility:Create("TextLabel", {
                Name = "VTabText",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 34, 0, 0),
                Size = UDim2.new(1, -40, 1, 0),
                Font = Enum.Font.GothamSemibold,
                Text = tabName,
                TextColor3 = i == defaultTab and Color3.fromRGB(255, 255, 255) or self.Theme.TextDark,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = tabBtn
            })
        else
            Utility:CreatePadding(tabBtn, 12)
        end
        
        tabButtons[i] = tabBtn
        
        -- Content frame
        local contentFrame = Utility:Create("ScrollingFrame", {
            Name = tabName .. "Content",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = self.Theme.Accent,
            ScrollBarImageTransparency = 0.6,
            Visible = i == defaultTab,
            Parent = contentArea
        })
        
        local cLayout = Utility:CreateListLayout(contentFrame, 8)
        Utility:CreatePadding(contentFrame, 8)
        contentFrames[i] = contentFrame
        
        tabBtn.MouseButton1Click:Connect(function()
            if activeIndex == i then return end
            
            -- Hide current content
            contentFrames[activeIndex].Visible = false
            
            -- Update previous tab button
            local prevBtn = tabButtons[activeIndex]
            Utility:Tween(prevBtn, {BackgroundColor3 = self.Theme.Foreground}, 0.25)
            prevBtn.TextColor3 = self.Theme.TextDark
            local prevIcon = prevBtn:FindFirstChild("VTabIcon")
            if prevIcon then Utility:Tween(prevIcon, {ImageColor3 = self.Theme.TextDark}, 0.25) end
            local prevText = prevBtn:FindFirstChild("VTabText")
            if prevText then prevText.TextColor3 = self.Theme.TextDark end
            
            -- Activate new tab
            activeIndex = i
            contentFrames[i].Visible = true
            
            Utility:Tween(tabBtn, {BackgroundColor3 = self.Theme.Accent}, 0.25)
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            local newIcon = tabBtn:FindFirstChild("VTabIcon")
            if newIcon then Utility:Tween(newIcon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.25) end
            local newText = tabBtn:FindFirstChild("VTabText")
            if newText then newText.TextColor3 = Color3.fromRGB(255, 255, 255) end
        end)
    end
    
    -- Auto-size container
    local totalHeight = math.max(#tabs * 39, 200)
    container.Size = UDim2.new(1, 0, 0, totalHeight)
    
    local VerticalTabs = {
        Frame = container,
        ContentFrames = contentFrames,
        ActiveIndex = activeIndex,
        Type = "VerticalTabs",
        Select = function(_, index)
            if tabButtons[index] then
                tabButtons[index].MouseButton1Click:Fire()
            end
        end,
        AddElement = function(_, index, elementType, elementConfig)
            if contentFrames[index] then
                elementConfig = elementConfig or {}
                if elementType == "Button" then
                    return KimiUI.CurrentWindow:CreateButton(elementConfig, contentFrames[index])
                elseif elementType == "Toggle" then
                    return KimiUI.CurrentWindow:CreateToggle(elementConfig, contentFrames[index])
                elseif elementType == "Slider" then
                    return KimiUI.CurrentWindow:CreateSlider(elementConfig, contentFrames[index])
                elseif elementType == "Input" then
                    return KimiUI.CurrentWindow:CreateInput(elementConfig, contentFrames[index])
                elseif elementType == "Dropdown" then
                    return KimiUI.CurrentWindow:CreateDropdown(elementConfig, contentFrames[index])
                elseif elementType == "Paragraph" then
                    return KimiUI.CurrentWindow:CreateParagraph(elementConfig, contentFrames[index])
                end
            end
        end,
        UpdateTheme = function(_, theme)
            for j, btn in pairs(tabButtons) do
                local isActive = j == activeIndex
                btn.BackgroundColor3 = isActive and theme.Accent or theme.Foreground
            end
        end
    }
    
    table.insert(self.Elements, VerticalTabs)
    return VerticalTabs
end

-- ============================================================================
-- 12. NEW FUNCTION: CreateProgressBar
--     Creates a progress bar with percentage (like in the image: Level 42, 57%)
-- ============================================================================

function KimiUI:CreateProgressBar(config, parent)
    config = config or {}
    local barName = config.Name or config.Label or "Progress"
    local description = config.Description or config.Subtitle or ""
    local max = config.Max or config.Maximum or 100
    local current = config.Current or config.Value or 0
    local showPercent = config.ShowPercent ~= false
    local barColor = config.Color or config.BarColor or self.Theme.Accent
    local barHeight = config.BarHeight or 10
    
    local percent = math.clamp(current / max, 0, 1)
    local percentText = math.floor(percent * 100) .. "%"
    
    local barFrame = Utility:Create("Frame", {
        Name = barName .. "Progress",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, description ~= "" and 68 or 52),
        Parent = parent
    })
    Utility:CreateCorner(barFrame, 10)
    Utility:CreateStroke(barFrame, self.Theme.Border, 1, 0.5)
    
    -- Label row
    local labelRow = Utility:Create("Frame", {
        Name = "LabelRow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -24, 0, 20),
        Parent = barFrame
    })
    
    local nameLabel = Utility:Create("TextLabel", {
        Name = "Name",
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = barName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = labelRow
    })
    
    local valueLabel = Utility:Create("TextLabel", {
        Name = "ValueText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = description ~= "" and description or (showPercent and percentText or current .. " / " .. max),
        TextColor3 = self.Theme.TextDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = labelRow
    })
    
    -- Progress track
    local progressY = description ~= "" and 56 or 36
    
    local track = Utility:Create("Frame", {
        Name = "Track",
        BackgroundColor3 = self.Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, progressY - barHeight / 2),
        Size = UDim2.new(1, -24, 0, barHeight),
        Parent = barFrame
    })
    Utility:CreateCorner(track, barHeight / 2)
    
    -- Progress fill
    local fill = Utility:Create("Frame", {
        Name = "Fill",
        BackgroundColor3 = barColor,
        BorderSizePixel = 0,
        Size = UDim2.new(percent, 0, 1, 0),
        Parent = track
    })
    Utility:CreateCorner(fill, barHeight / 2)
    
    -- Fill gradient
    Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, barColor),
            ColorSequenceKeypoint.new(1, self.Theme.AccentLight)
        }),
        Parent = fill
    })
    
    -- Percent label inside bar (if wide enough)
    if showPercent and percent > 0.15 then
        local percentLabel = Utility:Create("TextLabel", {
            Name = "PercentLabel",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = percentText,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 10,
            Parent = fill
        })
    end
    
    local ProgressBar = {
        Frame = barFrame,
        Current = current,
        Max = max,
        Type = "ProgressBar",
        Set = function(_, value)
            current = math.clamp(value, 0, max)
            local newPercent = current / max
            Utility:Tween(fill, {Size = UDim2.new(newPercent, 0, 1, 0)}, 0.3)
            local newPercentText = math.floor(newPercent * 100) .. "%"
            valueLabel.Text = description ~= "" and description or (showPercent and newPercentText or current .. " / " .. max)
        end,
        UpdateTheme = function(_, theme)
            barFrame.BackgroundColor3 = theme.Foreground
            track.BackgroundColor3 = theme.Border
            Utility:CreateStroke(barFrame, theme.Border, 1, 0.5)
        end
    }
    
    table.insert(self.Elements, ProgressBar)
    return ProgressBar
end

-- ============================================================================
-- 13. NEW FUNCTION: CreateBadge
--     Creates hexagonal colored badges with icons (like in the image)
-- ============================================================================

function KimiUI:CreateBadge(config, parent)
    config = config or {}
    local badgeText = config.Text or config.Value or ""
    local badgeIcon = config.Icon or config.Image or "rbxassetid://7733973319"
    local badgeColor = config.Color or config.BadgeColor or self.Theme.Accent
    local badgeStyle = config.Style or "Hexagon" -- Hexagon, Circle, Square
    local badgeSize = config.Size or 48
    
    local badgeFrame = Utility:Create("Frame", {
        Name = "Badge",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, badgeSize, 0, badgeSize),
        Parent = parent
    })
    
    -- Hexagon background using a frame with corner radius
    local bgFrame = Utility:Create("Frame", {
        Name = "Background",
        BackgroundColor3 = badgeColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = badgeFrame
    })
    
    if badgeStyle == "Hexagon" then
        Utility:CreateCorner(bgFrame, 12)
        -- Hexagon feel with slightly rounded corners
        local hexStroke = Utility:CreateStroke(bgFrame, badgeColor, 2, 0)
        hexStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    elseif badgeStyle == "Circle" then
        Utility:CreateCorner(bgFrame, badgeSize / 2)
    else
        Utility:CreateCorner(bgFrame, 8)
    end
    
    -- Darker overlay for depth
    local overlay = Utility:Create("Frame", {
        Name = "Overlay",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 0.5, 0),
        Parent = bgFrame
    })
    if badgeStyle == "Hexagon" then
        Utility:CreateCorner(overlay, 12)
    elseif badgeStyle == "Circle" then
        Utility:CreateCorner(overlay, badgeSize / 2)
    else
        Utility:CreateCorner(overlay, 8)
    end
    
    -- Icon
    local iconLabel = Utility:Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, -2),
        Size = UDim2.new(0, badgeSize * 0.45, 0, badgeSize * 0.45),
        Image = badgeIcon,
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        Parent = badgeFrame
    })
    
    -- Text overlay (if provided)
    if badgeText ~= "" then
        local textLabel = Utility:Create("TextLabel", {
            Name = "BadgeText",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = badgeText,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = badgeSize * 0.35,
            Parent = badgeFrame
        })
    end
    
    local Badge = {
        Frame = badgeFrame,
        Type = "Badge",
        SetColor = function(_, color)
            bgFrame.BackgroundColor3 = color
        end,
        SetText = function(_, text)
            local textLabel = badgeFrame:FindFirstChild("BadgeText")
            if textLabel then
                textLabel.Text = text
            end
        end,
        UpdateTheme = function() end
    }
    
    table.insert(self.Elements, Badge)
    return Badge
end

-- ============================================================================
-- EXAMPLE USAGE - How to use all the new features
-- ============================================================================

--[[

-- Load the upgraded library
local KimiUI = loadstring(game:HttpGet("YOUR_URL_HERE"))()

-- Create window with the new purple theme
local Window = KimiUI:CreateWindow({
    Name = "RBX UI Demo",
    Theme = "Default",  -- Now uses the new purple theme
    Size = UDim2.new(0, 700, 0, 500)
})

local MainTab = Window:AddTab({Name = "Main", Icon = "rbxassetid://7733965386"})
local Section = MainTab:AddSection({Name = "Elements"})

-- 1. TOGGLE BUTTON (with description like in image)
Section:AddToggle({
    Name = "Toggle ON",
    Description = "This is an active toggle button.",
    Default = true,
    Icon = "rbxassetid://7733955511", -- bell icon
    Callback = function(v) print(v) end
})

Section:AddToggle({
    Name = "Toggle OFF",
    Description = "This is an inactive toggle button.",
    Default = false,
    Callback = function(v) print(v) end
})

-- 2. DROPDOWN (with option icons like in image)
Section:AddDropdown({
    Name = "Select an Option",
    Options = {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"},
    OptionIcons = {
        ["Option 1"] = "rbxassetid://7733973319", -- star
        ["Option 2"] = "rbxassetid://7733970536", -- circle
        ["Option 3"] = "rbxassetid://7733953495", -- diamond
        ["Option 4"] = "rbxassetid://7733673987", -- triangle
        ["Option 5"] = "rbxassetid://7733951820", -- square
    },
    Default = "Option 1",
    Callback = function(v) print(v) end
})

-- 3. SLIDER (Volume/Brightness style)
Section:AddSlider({
    Name = "Volume",
    Min = 0,
    Max = 100,
    Default = 75,
    Suffix = "%",
    Callback = function(v) print(v) end
})

-- 4. INPUT SECTION (with type icons)
Section:AddInput({
    Name = "Text Input",
    Type = "Default",  -- Shows person icon
    Placeholder = "Enter your username...",
    Callback = function(t) print(t) end
})

Section:AddInput({
    Name = "Number Input",
    Type = "Number",   -- Shows hash icon
    Placeholder = "Enter a number...",
    Callback = function(t) print(t) end
})

Section:AddInput({
    Name = "Search Input",
    Type = "Search",   -- Shows search icon
    Placeholder = "Search something...",
    Callback = function(t) print(t) end
})

Section:AddInput({
    Name = "Password Input",
    Type = "Password", -- Shows lock icon + eye toggle
    Placeholder = "Enter your password...",
    Callback = function(t) print(t) end
})

-- 5. HORIZONTAL TABS (pill style)
Window:CreateHorizontalTabs({
    Tabs = {"Overview", "Inventory", "Stats", "Settings"},
    Icons = {
        [1] = "rbxassetid://7733965386",
        [2] = "rbxassetid://7733673987",
        [3] = "rbxassetid://7734053495",
        [4] = "rbxassetid://7733953495",
    },
    Default = 1,
    Callback = function(index, name) print("Selected:", name) end
}, Section.Content)

-- 6. VERTICAL TABS (Tab Section style)
local vTabs = Window:CreateVerticalTabs({
    Tabs = {
        {Name = "General", Icon = "rbxassetid://7734053495"},
        {Name = "Appearance", Icon = "rbxassetid://7733955511"},
        {Name = "Controls", Icon = "rbxassetid://7733950678"},
        {Name = "Audio", Icon = "rbxassetid://7733954760"},
        {Name = "Notifications", Icon = "rbxassetid://7733975398"},
        {Name = "Privacy", Icon = "rbxassetid://7733951820"},
    },
    Default = 1,
    TabWidth = 130
}, Section.Content)

-- Add elements to vertical tab content
vTabs:AddElement(1, "Toggle", {Name = "Auto Save", Default = true})
vTabs:AddElement(1, "Toggle", {Name = "Show Hints", Default = false})
vTabs:AddElement(1, "Toggle", {Name = "Enable Analytics", Default = true})

-- 7. NOTIFICATION (with close button)
Window:Notify({
    Title = "Success!",
    Content = "Your settings have been saved.",
    Type = "Success",
    Duration = 5
})

Window:Notify({
    Title = "Warning!",
    Content = "Your connection is unstable.",
    Type = "Warning",
    Duration = 5
})

Window:Notify({
    Title = "Error!",
    Content = "Failed to load data.",
    Type = "Error",
    Duration = 5
})

Window:Notify({
    Title = "Info",
    Content = "This is an information message.",
    Type = "Info",
    Duration = 5
})

-- 8. BUTTONS (all styles)
Section:AddButton({Name = "Primary Button", Style = "Default", Callback = function() end})
Section:AddButton({Name = "Secondary Button", Style = "Secondary", Callback = function() end})
Section:AddButton({Name = "Outline Button", Style = "Outline", Callback = function() end})
Section:AddButton({Name = "Ghost Button", Style = "Ghost", Callback = function() end})
Section:AddButton({Name = "", Style = "Default", Icon = "rbxassetid://7733973319", Size = UDim2.new(0, 36, 0, 36), Callback = function() end})

-- 9. PROGRESS BAR
Window:CreateProgressBar({
    Name = "Level 42",
    Description = "2,850 / 5,000 XP",
    Current = 2850,
    Max = 5000,
    ShowPercent = true,
    BarHeight = 14
}, Section.Content)

-- 10. BADGES (hexagonal)
local badgesRow = Instance.new("Frame")
badgesRow.BackgroundTransparency = 1
badgesRow.Size = UDim2.new(1, 0, 0, 52)
badgesRow.Parent = Section.Content

local badgeLayout = Instance.new("UIListLayout")
badgeLayout.FillDirection = Enum.FillDirection.Horizontal
badgeLayout.Padding = UDim.new(0, 10)
badgeLayout.Parent = badgesRow

Window:CreateBadge({Text = "", Icon = "rbxassetid://7733973319", Color = Color3.fromRGB(140, 100, 255), Size = 44}, badgesRow)
Window:CreateBadge({Text = "10", Color = Color3.fromRGB(80, 160, 255), Size = 44}, badgesRow)
Window:CreateBadge({Text = "", Icon = "rbxassetid://7733956188", Color = Color3.fromRGB(255, 180, 60), Size = 44}, badgesRow)
Window:CreateBadge({Text = "", Icon = "rbxassetid://7733951820", Color = Color3.fromRGB(255, 90, 90), Size = 44}, badgesRow)

--]]

print("[KimiUI Upgrade] All RBX UI style enhancements loaded successfully!")
