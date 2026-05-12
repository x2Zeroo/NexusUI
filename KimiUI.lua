--[[
    KimiUI Library - PREMIUM EDITION v2.0
    The Most Beautiful Roblox UI Library with Modern Neon/Deep Dark Theme
    Inspired by Modern Flagship UI Design
    Enhanced by Kimi Team
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// Utility Functions (PREMIUM MODS)
local Utility = {}

function Utility:Tween(instance, properties, duration, easingStyle, easingDirection, callback)
    easingStyle = easingStyle or Enum.EasingStyle.Quart
    easingDirection = easingDirection or Enum.EasingDirection.Out
    duration = duration or 0.45 -- Slightly slower for smoothness
    local tween = TweenService:Create(instance, TweenInfo.new(duration, easingStyle, easingDirection), properties)
    tween:Play()
    if callback then tween.Completed:Connect(callback) end
    return tween
end

function Utility:Create(className, properties, children)
    local instance = Instance.new(className)
    for property, value in pairs(properties or {}) do
        if property ~= "Parent" then instance[property] = value end
    end
    if children then
        for _, child in pairs(children) do child.Parent = instance end
    end
    instance.Parent = properties and properties.Parent
    return instance
end

function Utility:RoundNumber(number, decimals)
    decimals = decimals or 0
    local multiplier = 10 ^ decimals
    return math.floor(number * multiplier + 0.5) / multiplier
end

function Utility:Clamp(value, min, max)
    return math.clamp(value, min, max)
end

function Utility:CreateCorner(parent, radius)
    return Utility:Create("UICorner", { CornerRadius = UDim.new(0, radius or 10), Parent = parent })
end

-- Premium Stroke (Thinner, cleaner)
function Utility:CreateStroke(parent, color, thickness, transparency)
    return Utility:Create("UIStroke", {
        Color = color or Color3.fromRGB(80, 80, 100),
        Thickness = thickness or 1.1,
        Transparency = transparency or 0.75,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

function Utility:CreatePadding(parent, padding)
    padding = padding or 14 -- Increased padding
    return Utility:Create("UIPadding", {
        PaddingLeft = UDim.new(0, padding),
        PaddingRight = UDim.new(0, padding),
        PaddingTop = UDim.new(0, padding),
        PaddingBottom = UDim.new(0, padding),
        Parent = parent
    })
end

function Utility:CreateListLayout(parent, padding, sortOrder)
    return Utility:Create("UIListLayout", {
        Padding = UDim.new(0, padding or 10),
        SortOrder = sortOrder or Enum.SortOrder.LayoutOrder,
        Parent = parent
    })
end

function Utility:SetDrag(frame, dragArea)
    dragArea = dragArea or frame
    local dragging = false
    local dragStart = nil
    local startPos = nil
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- SOPHISTICATED SHADOW (Premium layer)
function Utility:CreateShadow(parent, transparency, size, offset)
    size = size or 35
    offset = offset or 6
    return Utility:Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, offset),
        Size = UDim2.new(1, size * 2, 1, size * 2),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = transparency or 0.55, -- Slightly darker shadow
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        Parent = parent
    })
end

-- Advanced Ripple with better fade
function Utility:CreateRipple(button, color)
    button.ClipsDescendants = true
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local ripple = Utility:Create("Frame", {
                Name = "Ripple",
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = color or Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.75,
                Position = UDim2.new(0, input.Position.X - button.AbsolutePosition.X, 0, input.Position.Y - button.AbsolutePosition.Y),
                Size = UDim2.new(0, 0, 0, 0),
                ZIndex = button.ZIndex + 1,
                Parent = button
            })
            Utility:CreateCorner(ripple, 200)
            local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 3
            Utility:Tween(ripple, { Size = UDim2.new(0, maxSize, 0, maxSize), BackgroundTransparency = 1 }, 0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function() ripple:Destroy() end)
        end
    end)
end

-- Advanced Glow effect creator
function Utility:CreateGlow(parent, color, transparency, size, offset)
    local glow = Utility:Create("ImageLabel", {
        Name = "Glow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, offset or 0),
        Size = UDim2.new(1, size or 20, 1, size or 20),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://6015093766", -- Bright glow asset
        ImageColor3 = color,
        ImageTransparency = transparency or 0.6,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        Parent = parent
    })
    return glow
end

--// Themes - PREMIUM NEON SERIES
local Themes = {
    Default = { -- New PREMIUM DEEP PURPLE NEON
        Primary = Color3.fromRGB(13, 13, 19),   -- Deep Dark
        Secondary = Color3.fromRGB(19, 19, 28), -- Acrylic Container
        Accent = Color3.fromRGB(167, 139, 250), -- Bright Neon Purple
        AccentLight = Color3.fromRGB(196, 181, 253),
        AccentDark = Color3.fromRGB(124, 58, 237),
        Background = Color3.fromRGB(8, 8, 12),
        Foreground = Color3.fromRGB(31, 31, 46), -- Hover container
        Text = Color3.fromRGB(249, 250, 251),
        TextDark = Color3.fromRGB(160, 170, 190),
        TextDarker = Color3.fromRGB(110, 120, 140),
        Border = Color3.fromRGB(45, 45, 65),
        BorderLight = Color3.fromRGB(75, 75, 100),
        Success = Color3.fromRGB(52, 211, 153), -- Neon Green
        Warning = Color3.fromRGB(251, 191, 36), -- Neon Yellow
        Error = Color3.fromRGB(248, 113, 113),   -- Neon Red
        Info = Color3.fromRGB(96, 165, 250),    -- Neon Blue
        TagPrimary = Color3.fromRGB(139, 92, 246),
        TagSuccess = Color3.fromRGB(34, 197, 94),
        TagWarning = Color3.fromRGB(234, 179, 8),
        TagError = Color3.fromRGB(239, 68, 68),
        TagInfo = Color3.fromRGB(59, 130, 246)
    },
    ["Dark Neon"] = {
        Primary = Color3.fromRGB(10, 10, 14),
        Secondary = Color3.fromRGB(18, 18, 24),
        Accent = Color3.fromRGB(50, 255, 200), -- Aqua Neon
        AccentLight = Color3.fromRGB(150, 255, 230),
        AccentDark = Color3.fromRGB(0, 200, 150),
        Background = Color3.fromRGB(7, 7, 10),
        Foreground = Color3.fromRGB(26, 26, 36),
        Text = Color3.fromRGB(240, 240, 245),
        TextDark = Color3.fromRGB(150, 160, 175),
        TextDarker = Color3.fromRGB(100, 110, 125),
        Border = Color3.fromRGB(40, 40, 55),
        BorderLight = Color3.fromRGB(70, 70, 90),
        Success = Color3.fromRGB(50, 255, 100),
        Warning = Color3.fromRGB(255, 200, 50),
        Error = Color3.fromRGB(255, 70, 70),
        Info = Color3.fromRGB(70, 150, 255)
    },
    -- ... other existing themes can be kept but we only add premium for example
}

--// Main Library
local KimiUI = {}
KimiUI.__index = KimiUI

KimiUI.Version = "2.0.0 Premium"
KimiUI.Themes = Themes

function KimiUI:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or config.Title or "KimiUI Premium"
    local themeName = config.Theme or "Default"
    local size = config.Size or UDim2.new(0, 600, 0, 450) -- Standard premium size
    local minSize = config.MinSize or Vector2.new(520, 390)
    local canResize = config.CanResize ~= false
    local canDrag = config.CanDrag ~= false
    local showCloseButton = config.ShowCloseButton ~= false
    local showMinimizeButton = config.ShowMinimizeButton ~= false

    local theme = Themes[themeName] or Themes.Default

    local screenGui = Utility:Create("ScreenGui", {
        Name = windowName .. "_KimiUIPrem",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    -- Sync protection (standard)
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = CoreGui
    elseif gethui then
        screenGui.Parent = gethui()
    else
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local mainFrame = Utility:Create("Frame", {
        Name = "Main",
        BackgroundColor3 = theme.Background,
        BorderSizePixel = 0,
        Position = config.Position or UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2),
        Size = size,
        ClipsDescendants = false, -- Need for shadow/glow
        Parent = screenGui
    })
    Utility:CreateCorner(mainFrame, 14)
    local winShadow = Utility:CreateShadow(mainFrame, 0.5, 40, 10)
    local winGlow = Utility:CreateGlow(mainFrame, theme.Accent, 0.8, 30, 0)
    Utility:CreateStroke(mainFrame, theme.Border, 1.3, 0.7)

    if canDrag then Utility:SetDrag(mainFrame) end

    if canResize then
        local resizeHandle = Utility:Create("Frame", {
            Name = "ResizeHandle",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -22, 1, -22),
            Size = UDim2.new(0, 22, 0, 22),
            ZIndex = 10,
            Parent = mainFrame
        })
        local resizeIcon = Utility:Create("ImageLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 6, 0, 6),
            Size = UDim2.new(0, 12, 0, 12),
            Image = "rbxassetid://6761432098",
            ImageColor3 = theme.TextDarker,
            ImageTransparency = 0.5,
            ZIndex = 10,
            Parent = resizeHandle
        })
        local resizing = false
        local resizeStart = nil
        local startSize = nil
        resizeHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true
                resizeStart = input.Position
                startSize = mainFrame.Size
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - resizeStart
                local newWidth = math.max(minSize.X, startSize.X.Offset + delta.X)
                local newHeight = math.max(minSize.Y, startSize.Y.Offset + delta.Y)
                mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end
        end)
    end

    --// Premium Title Bar (Modern Height)
    local titleBar = Utility:Create("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 48), -- Slightly taller
        Parent = mainFrame
    })
    Utility:CreateCorner(titleBar, 14)
    
    -- Fix corner bottom
    local cornerFix = Utility:Create("Frame", {
        Name = "CornerFix",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -14),
        Size = UDim2.new(1, 0, 0, 14),
        ZIndex = titleBar.ZIndex,
        Parent = titleBar
    })

    -- Premium Accent Gradient Line
    Utility:Create("Frame", {
        Name = "AccentLine",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -2),
        Size = UDim2.new(1, 0, 0, 2),
        Parent = titleBar
    }, {
        Utility:Create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, theme.AccentDark),
                ColorSequenceKeypoint.new(0.5, theme.Accent),
                ColorSequenceKeypoint.new(1, theme.AccentDark)
            })
        })
    })

    local windowIcon = Utility:Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 12),
        Size = UDim2.new(0, 24, 0, 24),
        Image = config.Icon or "rbxassetid://10734947230",
        ImageColor3 = theme.Accent,
        Parent = titleBar
    })
    local iconGlow = Utility:CreateGlow(windowIcon, theme.Accent, 0.7, 10)

    local windowTitle = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 52, 0, 0),
        Size = UDim2.new(1, -150, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = theme.Text,
        TextSize = 16, -- Cleaner size
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })

    local buttonsFrame = Utility:Create("Frame", {
        Name = "Buttons",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -95, 0, 0),
        Size = UDim2.new(0, 95, 1, 0),
        ZIndex = titleBar.ZIndex + 1,
        Parent = titleBar
    })

    if showMinimizeButton then
        local minimizeBtn = Utility:Create("TextButton", {
            Name = "Minimize",
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 45, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = "−", -- UI element for minimize
            TextColor3 = theme.TextDark,
            TextSize = 18,
            Parent = buttonsFrame
        })
        minimizeBtn.MouseEnter:Connect(function() Utility:Tween(minimizeBtn, {TextColor3 = theme.Text}, 0.2) end)
        minimizeBtn.MouseLeave:Connect(function() Utility:Tween(minimizeBtn, {TextColor3 = theme.TextDark}, 0.2) end)
        local minimized = false
        minimizeBtn.MouseButton1Click:Connect(function()
            minimized = not minimized
            if minimized then
                Utility:Tween(winGlow, {ImageTransparency = 1}, 0.2)
                Utility:Tween(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 48)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                mainFrame.ClipsDescendants = true
            else
                mainFrame.ClipsDescendants = false
                Utility:Tween(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, size.Y.Offset)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                Utility:Tween(winGlow, {ImageTransparency = 0.8}, 0.6)
            end
        end)
    end

    if showCloseButton then
        local closeBtn = Utility:Create("TextButton", {
            Name = "Close",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 45, 0, 0),
            Size = UDim2.new(0, 45, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = "×", -- UI element for close
            TextColor3 = theme.TextDark,
            TextSize = 22,
            Parent = buttonsFrame
        })
        closeBtn.MouseEnter:Connect(function() Utility:Tween(closeBtn, {TextColor3 = theme.Error}, 0.2) end)
        closeBtn.MouseLeave:Connect(function() Utility:Tween(closeBtn, {TextColor3 = theme.TextDark}, 0.2) end)
        closeBtn.MouseButton1Click:Connect(function()
            -- Elegant shrink animation
            mainFrame.ClipsDescendants = true
            Utility:Tween(winGlow, {ImageTransparency = 1}, 0.1)
            Utility:Tween(winShadow, {ImageTransparency = 1}, 0.1)
            Utility:Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(mainFrame.Position.X.Scale, mainFrame.Position.X.Offset + mainFrame.AbsoluteSize.X/2, mainFrame.Position.Y.Scale, mainFrame.Position.Y.Offset + mainFrame.AbsoluteSize.Y/2)}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In, function() screenGui:Destroy() end)
        end)
    end

    local contentArea = Utility:Create("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 48),
        Size = UDim2.new(1, 0, 1, -48),
        ZIndex = 1,
        Parent = mainFrame
    })
    Utility:CreateCorner(contentArea, 14) -- Round content area as well

    -- Premium Tab Bar Design
    local tabContainer = Utility:Create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 175, 1, 0), -- Slightly wider
        Parent = contentArea
    })
    Utility:CreateCorner(tabContainer, 14)
    
    -- tabs corner fix
    Utility:Create("Frame", {
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 14, 1, 0),
        Parent = tabContainer
    })
    Utility:Create("Frame", {
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -14),
        Size = UDim2.new(1, 0, 0, 14),
        Parent = tabContainer
    })

    local tabSeparator = Utility:Create("Frame", {
        Name = "Separator",
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -1, 0, 15),
        Size = UDim2.new(0, 1, 1, -30),
        Parent = tabContainer
    })

    local tabScroll = Utility:Create("ScrollingFrame", {
        Name = "TabScroll",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 10), -- padding top
        Size = UDim2.new(1, 0, 1, -20),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 1, -- Invisible but scrollable
        ScrollBarImageTransparency = 1,
        Parent = tabContainer
    })

    local tabListLayout = Utility:CreateListLayout(tabScroll, 6) -- Spacing
    Utility:CreatePadding(tabScroll, 10)

    --// Tab Scroll Canvas Auto Update
    tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabScroll.CanvasSize = UDim2.new(0, 0, 0, tabListLayout.AbsoluteContentSize.Y + 20)
    end)

    -- tab content area corner fix
    local tabContentArea = Utility:Create("Frame", {
        Name = "TabContentArea",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 175, 0, 0),
        Size = UDim2.new(1, -175, 1, 0),
        Parent = contentArea
    })

    local tabContents = Utility:Create("Folder", {
        Name = "TabContents",
        Parent = tabContentArea
    })

    local Window = setmetatable({}, KimiUI)
    Window.Theme = theme
    Window.ThemeName = themeName
    Window.ScreenGui = screenGui
    Window.MainFrame = mainFrame
    Window.WinGlow = winGlow
    Window.TabContainer = tabScroll
    Window.TabContentArea = tabContentArea
    Window.TabContents = tabContents
    Window.Tabs = {}
    Window.ActiveTab = nil
    Window.Elements = {}
    Window.Flags = {}
    Window.Config = config
    KimiUI.CurrentWindow = Window

    return Window
end

function KimiUI:SetTheme(themeName)
    local theme = Themes[themeName]
    if not theme then return end
    self.Theme = theme
    self.ThemeName = themeName
    -- Implement theme update for elements if necessary
    -- Current implementation assumes recreate window for theme change
    -- Window:Notify({Title = "Theme Info", Content = "Restart UI for full theme change.", Type = "Info"})
end

--// Add Tab (Premium Style)
function KimiUI:AddTab(config)
    config = config or {}
    local tabName = config.Name or "Tab"
    local tabIcon = config.Icon or nil
    local tabColor = config.Color or self.Theme.Accent

    local tabButton = Utility:Create("TextButton", {
        Name = tabName .. "TabButton",
        BackgroundColor3 = self.Theme.Secondary,
        BackgroundTransparency = 1, -- Start transparent
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42), -- Slightly taller
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = "",
        Parent = self.TabContainer
    })
    Utility:CreateCorner(tabButton, 10)

    -- Premium Indicator Style (Pill shape)
    local tabIndicator = Utility:Create("Frame", {
        Name = "Indicator",
        BackgroundColor3 = tabColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, -0), -- Pilled shape center
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 0, 0, 20), -- Height 20
        Parent = tabButton
    })
    Utility:CreateCorner(tabIndicator, 10)
    local indicGlow = Utility:CreateGlow(tabIndicator, tabColor, 0.8, 10)
    indicGlow.Enabled = false

    if tabIcon then
        local icon = Utility:Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 14, 0.5, -10), -- Adjusted position
            Size = UDim2.new(0, 20, 0, 20),
            Image = tabIcon,
            ImageColor3 = self.Theme.TextDark,
            Parent = tabButton
        })
    end

    local tabText = Utility:Create("TextLabel", {
        Name = "Text",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, tabIcon and 44 or 18, 0, 0),
        Size = UDim2.new(1, -(tabIcon and 50 or 24), 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = tabName,
        TextColor3 = self.Theme.TextDark,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = tabButton
    })

    local tabContent = Utility:Create("ScrollingFrame", {
        Name = tabName .. "Content",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2, -- Premium scrollbar
        ScrollBarImageColor3 = tabColor,
        ScrollBarImageTransparency = 0.6,
        Visible = false,
        Parent = self.TabContents
    })

    local contentLayout = Utility:CreateListLayout(tabContent, 12) -- Element spacing
    Utility:CreatePadding(tabContent, 16) -- Content padding

    --// Content Scroll Canvas Auto Update
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 32)
    end)

    local Tab = {
        Name = tabName,
        Button = tabButton,
        Content = tabContent,
        Indicator = tabIndicator,
        IndicGlow = indicGlow,
        TabText = tabText,
        Icon = tabButton:FindFirstChild("Icon"),
        Sections = {},
        Window = self,
        Color = tabColor
    }
    table.insert(self.Tabs, Tab)

    tabButton.MouseEnter:Connect(function()
        if self.ActiveTab ~= Tab then
            Utility:Tween(tabButton, {BackgroundTransparency = 0.7, BackgroundColor3 = self.Theme.Foreground}, 0.2)
            if Tab.Icon then Utility:Tween(Tab.Icon, {ImageColor3 = self.Theme.Text}, 0.2) end
            Utility:Tween(tabText, {TextColor3 = self.Theme.Text}, 0.2)
        end
    end)

    tabButton.MouseLeave:Connect(function()
        if self.ActiveTab ~= Tab then
            Utility:Tween(tabButton, {BackgroundTransparency = 1}, 0.2)
            if Tab.Icon then Utility:Tween(Tab.Icon, {ImageColor3 = self.Theme.TextDark}, 0.2) end
            Utility:Tween(tabText, {TextColor3 = self.Theme.TextDark}, 0.2)
        end
    end)

    tabButton.MouseButton1Click:Connect(function() self:SelectTab(Tab) end)

    if #self.Tabs == 1 then self:SelectTab(Tab) end

    --// Tab Functions (Section & Elements)
    function Tab:AddSection(config)
        config = config or {}
        local sectionName = config.Name or "Section"
        local sectionDesc = config.Description or ""

        -- Premium Section Design (Acrylic Card)
        local sectionFrame = Utility:Create("Frame", {
            Name = sectionName .. "Section",
            BackgroundColor3 = self.Window.Theme.Secondary,
            BackgroundTransparency = 0.2, -- Acrylic effect base
            BorderSizePixel = 0,
            Size = UDim2.new(1, -0, 0, 44),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = self.Content
        })
        Utility:CreateCorner(sectionFrame, 12)
        Utility:CreateStroke(sectionFrame, self.Window.Theme.Border, 1, 0.8)
        -- Utility:CreateShadow(sectionFrame, 0.7, 10, 2) -- Minor inner shadow for depth

        local sectionTitle = Utility:Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 16, 0, 14),
            Size = UDim2.new(1, -32, 0, 22),
            Font = Enum.Font.GothamBold,
            Text = sectionName,
            TextColor3 = self.Window.Theme.Text,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = sectionFrame
        })
        -- Title glow
        local titleGlow = Utility:CreateGlow(sectionTitle, self.Color, 0.8, 8, 0)

        local contentOffset = 38
        if sectionDesc ~= "" then
            local sectionDescLabel = Utility:Create("TextLabel", {
                Name = "Description",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 16, 0, 36),
                Size = UDim2.new(1, -32, 0, 16),
                Font = Enum.Font.Gotham,
                Text = sectionDesc,
                TextColor3 = self.Window.Theme.TextDark,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = sectionFrame
            })
            contentOffset = 58
        end

        local sectionContent = Utility:Create("Frame", {
            Name = "Content",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, contentOffset),
            Size = UDim2.new(1, 0, 1, -contentOffset),
            Parent = sectionFrame
        })

        local sectionLayout = Utility:CreateListLayout(sectionContent, 10) -- Spacing between elements
        Utility:CreatePadding(sectionContent, 12) -- Inner padding

        --// Section Height Auto Update
        sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            local contentHeight = sectionLayout.AbsoluteContentSize.Y + 24
            sectionFrame.Size = UDim2.new(1, -0, 0, contentOffset + contentHeight)
            sectionContent.Size = UDim2.new(1, 0, 0, contentHeight)
        end)

        local Section = {
            Name = sectionName,
            Frame = sectionFrame,
            Content = sectionContent,
            Tab = self,
            Elements = {}
        }
        
        -- Proxy functions to Window to create elements inside sectionContent
        function Section:AddButton(config) return self.Tab.Window:CreateButton(config, self.Content, self.Tab.Color) end
        function Section:AddToggle(config) return self.Tab.Window:CreateToggle(config, self.Content, self.Tab.Color) end
        function Section:AddSlider(config) return self.Tab.Window:CreateSlider(config, self.Content, self.Tab.Color) end
        function Section:AddInput(config) return self.Tab.Window:CreateInput(config, self.Content, self.Tab.Color) end
        function Section:AddDropdown(config) return self.Tab.Window:CreateDropdown(config, self.Content, self.Tab.Color) end
        function Section:AddParagraph(config) return self.Tab.Window:CreateParagraph(config, self.Content) end
        function Section:AddKeybind(config) return self.Tab.Window:CreateKeybind(config, self.Content, self.Tab.Color) end
        function Section:AddColorpicker(config) return self.Tab.Window:CreateColorpicker(config, self.Content, self.Tab.Color) end
        -- ... add other element proxy functions here
        
        return Section
    end

    return Tab
end

function KimiUI:SelectTab(tab)
    if self.ActiveTab == tab then return end
    
    if self.ActiveTab then
        Utility:Tween(self.ActiveTab.Button, {BackgroundTransparency = 1}, 0.2)
        Utility:Tween(self.ActiveTab.Indicator, {Size = UDim2.new(0, 0, 0, 20)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        self.ActiveTab.IndicGlow.Enabled = false
        self.ActiveTab.Content.Visible = false
        if self.ActiveTab.Icon then Utility:Tween(self.ActiveTab.Icon, {ImageColor3 = self.Theme.TextDark}, 0.2) end
        Utility:Tween(self.ActiveTab.TabText, {TextColor3 = self.Theme.TextDark}, 0.2)
    end
    self.ActiveTab = tab
    Utility:Tween(tab.Button, {BackgroundTransparency = 0.7, BackgroundColor3 = self.Theme.Foreground}, 0.2)
    -- Indicator animation (pill expansion)
    Utility:Tween(tab.Indicator, {Size = UDim2.new(0, 4, 0, 20)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    tab.IndicGlow.Enabled = true
    tab.Content.Visible = true
    if tab.Icon then Utility:Tween(tab.Icon, {ImageColor3 = tab.Color}, 0.2) end
    Utility:Tween(tab.TabText, {TextColor3 = self.Theme.Text}, 0.2)
end

--// ==============================================================================
--// PREMIUM ELEMENTS CREATION (Inside Window class to access theme)
--// ==============================================================================

--// Button Element (Modern Styles with Glow)
function KimiUI:CreateButton(config, parent, tabColor)
    config = config or {}
    local buttonText = config.Name or config.Text or "Button"
    local callback = config.Callback or function() end
    local buttonStyle = config.Style or "Primary" -- Primary (Glow), Secondary, Outline, Ghost, Danger (Glow Red)
    local icon = config.Icon or nil

    local bgColor, textColor, strokeColor, glowColor
    if buttonStyle == "Primary" then
        bgColor = tabColor or self.Theme.Accent; textColor = Color3.fromRGB(10, 10, 15); glowColor = bgColor
    elseif buttonStyle == "Secondary" then
        bgColor = self.Theme.Foreground; textColor = self.Theme.Text
    elseif buttonStyle == "Outline" then
        bgColor = Color3.fromRGB(0,0,0); textColor = tabColor or self.Theme.Accent; strokeColor = textColor; glowColor = textColor
    elseif buttonStyle == "Ghost" then
        bgColor = self.Theme.Secondary; textColor = self.Theme.TextDark
    elseif buttonStyle == "Danger" then
        bgColor = self.Theme.Error; textColor = Color3.fromRGB(255, 255, 255); glowColor = bgColor
    else
        bgColor = tabColor or self.Theme.Accent; textColor = Color3.fromRGB(255, 255, 255)
    end

    local buttonFrame = Utility:Create("TextButton", {
        Name = buttonText .. "Button",
        BackgroundColor3 = bgColor,
        BackgroundTransparency = (buttonStyle == "Ghost" and 1 or (buttonStyle == "Outline" and 1 or 0)),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38), -- Taller buttons
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = buttonText,
        TextColor3 = textColor,
        TextSize = 14,
        Parent = parent
    })
    Utility:CreateCorner(buttonFrame, 10)
    Utility:CreateRipple(buttonFrame, buttonStyle == "Primary" and Color3.fromRGB(255,255,255) or nil)

    -- Scale hover animation (Micro-interaction)
    Utility:Create("UIScale", {
        Name = "HoverScale",
        Scale = 1,
        Parent = buttonFrame
    })

    if buttonStyle == "Outline" and strokeColor then
        Utility:CreateStroke(buttonFrame, strokeColor, 1.3, 0.6)
    end

    local btnGlow = nil
    if glowColor then
        btnGlow = Utility:CreateGlow(buttonFrame, glowColor, 0.8, 15, 0)
        btnGlow.Enabled = false
    end

    if icon then
        local btnIcon = Utility:Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0.5, -9),
            Size = UDim2.new(0, 18, 0, 18),
            Image = icon,
            ImageColor3 = textColor,
            Parent = buttonFrame
        })
        buttonFrame.Text = "   " .. buttonText -- Spacing for icon
        buttonFrame.TextXAlignment = Enum.TextXAlignment.Left
    end

    buttonFrame.MouseEnter:Connect(function()
        Utility:Tween(buttonFrame.HoverScale, {Scale = 1.03}, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        if btnGlow then btnGlow.Enabled = true end
        
        if buttonStyle == "Secondary" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.BorderLight}, 0.2)
        elseif buttonStyle == "Ghost" then
            Utility:Tween(buttonFrame, {BackgroundTransparency = 0.8, BackgroundColor3 = self.Theme.Foreground}, 0.2)
            buttonFrame.TextColor3 = self.Theme.Text
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, {BackgroundTransparency = 0}, 0.2)
            buttonFrame.TextColor3 = Color3.fromRGB(10,10,15)
        end
    end)

    buttonFrame.MouseLeave:Connect(function()
        Utility:Tween(buttonFrame.HoverScale, {Scale = 1}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        if btnGlow then btnGlow.Enabled = false end
        
        if buttonStyle == "Secondary" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
        elseif buttonStyle == "Ghost" then
            Utility:Tween(buttonFrame, {BackgroundTransparency = 1}, 0.2)
            buttonFrame.TextColor3 = self.Theme.TextDark
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, {BackgroundTransparency = 1}, 0.2)
            buttonFrame.TextColor3 = strokeColor
        end
    end)

    buttonFrame.MouseButton1Click:Connect(function() 
        Utility:Tween(buttonFrame.HoverScale, {Scale = 0.95}, 0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function()
            Utility:Tween(buttonFrame.HoverScale, {Scale = 1.03}, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        end)
        callback() 
    end)

    return { Frame = buttonFrame, Style = buttonStyle, Type = "Button" }
end

--// Toggle Element (Modern Slide Toggle with Glow)
function KimiUI:CreateToggle(config, parent, tabColor)
    config = config or {}
    local toggleName = config.Name or "Toggle"
    local default = config.Default or false
    local callback = config.Callback or function() end
    local flag = config.Flag or nil
    local icon = config.Icon or nil

    local accentColor = tabColor or self.Theme.Accent

    if flag then self.Flags[flag] = default end

    local toggleFrame = Utility:Create("Frame", {
        Name = toggleName .. "Toggle",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 48), -- Taller for spacing
        Parent = parent
    })
    Utility:CreateCorner(toggleFrame, 10)
    Utility:CreateStroke(toggleFrame, self.Theme.Border, 1, 0.8)

    toggleFrame.MouseEnter:Connect(function() Utility:Tween(toggleFrame, {BackgroundColor3 = self.Theme.Border}, 0.2) end)
    toggleFrame.MouseLeave:Connect(function() Utility:Tween(toggleFrame, {BackgroundColor3 = self.Theme.Foreground}, 0.2) end)

    local labelOffset = 14
    if icon then
        local toggleIcon = Utility:Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 14, 0.5, -10),
            Size = UDim2.new(0, 20, 0, 20),
            Image = icon,
            ImageColor3 = self.Theme.TextDark,
            Parent = toggleFrame
        })
        labelOffset = 42
    end

    local toggleLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, labelOffset, 0, 0),
        Size = UDim2.new(1, - labelOffset - 70, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = toggleName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleFrame
    })

    -- Premium Track Design
    local toggleTrack = Utility:Create("TextButton", {
        Name = "Track",
        BackgroundColor3 = default and accentColor or self.Theme.BorderLight,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -64, 0.5, -13),
        Size = UDim2.new(0, 50, 0, 26), -- Premium track size
        AutoButtonColor = false,
        Text = "",
        Parent = toggleFrame
    })
    Utility:CreateCorner(toggleTrack, 13) -- Pill shape
    Utility:CreateStroke(toggleTrack, default and accentColor or self.Theme.BorderLight, 1, 0.5)

    -- Glow for Track
    local trackGlow = Utility:CreateGlow(toggleTrack, accentColor, 0.7, 15, 0)
    trackGlow.Enabled = default

    -- Premium Thumb Design (White with Shadow)
    local toggleThumb = Utility:Create("Frame", {
        Name = "Thumb",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = default and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11),
        Size = UDim2.new(0, 22, 0, 22),
        Parent = toggleTrack
    })
    Utility:CreateCorner(toggleThumb, 11)
    Utility:CreateShadow(toggleThumb, 0.3, 8, 1) -- Thumb shadow for depth

    local toggled = default

    local function updateToggle(value)
        toggled = value
        if flag then self.Flags[flag] = toggled end
        
        local targetPos = toggled and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
        local targetColor = toggled and accentColor or self.Theme.BorderLight
        
        trackGlow.Enabled = toggled
        Utility:Tween(toggleTrack, {BackgroundColor3 = targetColor}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        Utility:Tween(toggleTrack:FindFirstChildOfClass("UIStroke"), {Color = targetColor}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        Utility:Tween(toggleThumb, {Position = targetPos}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        
        callback(toggled)
    end

    toggleTrack.MouseButton1Click:Connect(function()
        updateToggle(not toggled)
    end)
    
    -- Label click also toggles
    Utility:Create("TextButton", {
        Name = "LabelClick",
        BackgroundTransparency = 1,
        Size = toggleLabel.Size,
        Position = toggleLabel.Position,
        Text = "",
        Parent = toggleFrame
    }).MouseButton1Click:Connect(function()
        updateToggle(not toggled)
    end)

    local Toggle = {
        Frame = toggleFrame,
        Value = toggled,
        Set = function(self, value) updateToggle(value) end,
        Type = "Toggle"
    }
    table.insert(self.Elements, Toggle)
    return Toggle
end

--// Slider Element (Premium Modern Style)
function KimiUI:CreateSlider(config, parent, tabColor)
    config = config or {}
    local sliderName = config.Name or "Slider"
    local min = config.Min or config.Minimum or 0
    local max = config.Max or config.Maximum or 100
    local default = config.Default or min
    local increment = config.Increment or config.Step or 1
    local suffix = config.Suffix or config.Postfix or ""
    local callback = config.Callback or function() end
    local flag = config.Flag or nil

    local accentColor = tabColor or self.Theme.Accent

    default = math.clamp(default, min, max)
    if flag then self.Flags[flag] = default end

    local sliderFrame = Utility:Create("Frame", {
        Name = sliderName .. "Slider",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 72), -- Taller for design
        Parent = parent
    })
    Utility:CreateCorner(sliderFrame, 10)
    Utility:CreateStroke(sliderFrame, self.Theme.Border, 1, 0.8)

    local sliderLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 10),
        Size = UDim2.new(1, -110, 0, 22),
        Font = Enum.Font.GothamSemibold,
        Text = sliderName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sliderFrame
    })

    -- Value box premium design
    local valueFrame = Utility:Create("Frame", {
        Name = "ValueFrame",
        BackgroundColor3 = self.Theme.Secondary,
        Position = UDim2.new(1, -90, 0, 10),
        Size = UDim2.new(0, 74, 0, 26),
        Parent = sliderFrame
    })
    Utility:CreateCorner(valueFrame, 6)
    Utility:CreateStroke(valueFrame, self.Theme.Border, 1, 0.7)

    local valueLabel = Utility:Create("TextLabel", {
        Name = "Value",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = tostring(default) .. suffix,
        TextColor3 = accentColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = valueFrame
    })

    -- Premium Slider Track Design
    local sliderBackground = Utility:Create("Frame", {
        Name = "Track",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 16, 0, 48), -- Lower position
        Size = UDim2.new(1, -32, 0, 8), -- Slightly thicker track
        Parent = sliderFrame
    })
    Utility:CreateCorner(sliderBackground, 4)
    Utility:CreateStroke(sliderBackground, self.Theme.BorderLight, 1, 0.8)

    local sliderFill = Utility:Create("Frame", {
        Name = "Fill",
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        Parent = sliderBackground
    })
    Utility:CreateCorner(sliderFill, 4)
    local fillGlow = Utility:CreateGlow(sliderFill, accentColor, 0.7, 12, 0)

    -- Sophisticated Thumb Design (White with border and shadow)
    local sliderThumb = Utility:Create("Frame", {
        Name = "Thumb",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10), -- Center
        Size = UDim2.new(0, 20, 0, 20),
        ZIndex = 2,
        Parent = sliderBackground
    })
    Utility:CreateCorner(sliderThumb, 10)
    Utility:CreateStroke(sliderThumb, accentColor, 2, 0.5) -- Accent border on thumb
    Utility:CreateShadow(sliderThumb, 0.35, 10, 2) -- Shadow for depth

    sliderFrame.MouseEnter:Connect(function() Utility:Tween(sliderFrame, {BackgroundColor3 = self.Theme.Border}, 0.2) end)
    sliderFrame.MouseLeave:Connect(function() Utility:Tween(sliderFrame, {BackgroundColor3 = self.Theme.Foreground}, 0.2) end)

    local dragging = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * pos
        value = math.floor(value / increment + 0.5) * increment
        value = Utility:RoundNumber(value, #tostring(increment) - 2) -- Handle decimal increments
        value = math.clamp(value, min, max)
        
        local fillSize = (value - min) / (max - min)
        sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
        sliderThumb.Position = UDim2.new(fillSize, -10, 0.5, -10)
        valueLabel.Text = tostring(value) .. suffix
        
        if flag then self.Flags[flag] = value end
        callback(value)
    end

    sliderBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
            Utility:Tween(sliderThumb, {Size = UDim2.new(0, 24, 0, 24), Position = sliderThumb.Position - UDim2.new(0, 2, 0, 2)}, 0.15) -- Scale thumb up
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
            -- Sophisticated Scale thumb down animation
            local currentFillSize = sliderFill.Size.X.Scale
            Utility:Tween(sliderThumb, {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(currentFillSize, -10, 0.5, -10)}, 0.2)
        end
    end)

    local Slider = {
        Frame = sliderFrame,
        Value = default,
        Set = function(_, value)
            value = math.clamp(value, min, max)
            value = math.floor(value / increment + 0.5) * increment
            local fillSize = (value - min) / (max - min)
            sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
            sliderThumb.Position = UDim2.new(fillSize, -10, 0.5, -10)
            valueLabel.Text = tostring(value) .. suffix
            if flag then KimiUI.CurrentWindow.Flags[flag] = value end
            callback(value)
        end,
        Type = "Slider"
    }
    table.insert(self.Elements, Slider)
    return Slider
end

--// Notification System (Premium Modern)
function KimiUI:Notify(config)
    config = config or {}
    local notifyTitle = config.Title or "Notification"
    local notifyContent = config.Content or config.Message or config.Text or "..."
    local notifyType = config.Type or "Info" -- Info, Success, Warning, Error
    local duration = config.Duration or 6

    -- Container for notifications if not exist
    if not KimiUI.NotificationGui then
        KimiUI.NotificationGui = Utility:Create("ScreenGui", {
            Name = "KimiUINotifications",
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            Parent = syn and syn.protect_gui and CoreGui or LocalPlayer:WaitForChild("PlayerGui")
        })
        if syn and syn.protect_gui then syn.protect_gui(KimiUI.NotificationGui) end
    end

    local typeColors = {
        Info = self.Theme.Info,
        Success = self.Theme.Success,
        Warning = self.Theme.Warning,
        Error = self.Theme.Error
    }
    local typeIcons = {
        Info = "rbxassetid://10734946868", -- Blue info
        Success = "rbxassetid://10734946395", -- Green check
        Warning = "rbxassetid://10734947962", -- Yellow warn
        Error = "rbxassetid://10734947573" -- Red x
    }
    local typeColor = typeColors[notifyType] or self.Theme.Info

    local notificationFrame = Utility:Create("Frame", {
        Name = "Notification",
        BackgroundColor3 = self.Theme.Secondary,
        BackgroundTransparency = 0.1, -- Acrylic base
        BorderSizePixel = 0,
        Position = UDim2.new(1, 20, 1, -20), -- Start offscreen bottom right
        AnchorPoint = Vector2.new(0, 1),
        Size = UDim2.new(0, 340, 0, 0), -- Canvas size auto update y
        ClipsDescendants = false,
        Parent = KimiUI.NotificationGui
    })
    Utility:CreateCorner(notificationFrame, 12)
    Utility:CreateShadow(notificationFrame, 0.45, 25, 8) -- Major window shadow
    Utility:CreateStroke(notificationFrame, self.Theme.Border, 1.2, 0.7)
    
    -- Glow based on type
    local notifyGlow = Utility:CreateGlow(notificationFrame, typeColor, 0.8, 25, 0)

    -- Left accent bar pilled
    local colorBar = Utility:Create("Frame", {
        Name = "ColorBar",
        BackgroundColor3 = typeColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 4, 0, 40), -- Pill shape center
        Parent = notificationFrame
    })
    Utility:CreateCorner(colorBar, 4)

    local icon = Utility:Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 20, 0, 18),
        Size = UDim2.new(0, 26, 0, 26),
        Image = typeIcons[notifyType] or typeIcons.Info,
        ImageColor3 = typeColor,
        Parent = notificationFrame
    })
    local iconGlow = Utility:CreateGlow(icon, typeColor, 0.7, 10, 0)

    local titleLabel = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 56, 0, 18),
        Size = UDim2.new(1, -90, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = notifyTitle,
        TextColor3 = self.Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notificationFrame
    })

    local contentLabel = Utility:Create("TextLabel", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 56, 0, 44),
        Size = UDim2.new(1, -66, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = notifyContent,
        TextColor3 = self.Theme.TextDark,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = notificationFrame
    })

    -- Premium close button design
    local closeBtn = Utility:Create("TextButton", {
        Name = "Close",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -30, 0, 10),
        Size = UDim2.new(0, 20, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = self.Theme.TextDarker,
        TextSize = 18,
        Parent = notificationFrame
    })
    closeBtn.MouseEnter:Connect(function() Utility:Tween(closeBtn, {TextColor3 = theme.Error}, 0.2) end)
    closeBtn.MouseLeave:Connect(function() Utility:Tween(closeBtn, {TextColor3 = theme.TextDarker}, 0.2) end)

    -- Premium time bar design (Bottom gradient)
    local timeBar = Utility:Create("Frame", {
        Name = "TimeBar",
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 1, -4), -- Bottom
        Size = UDim2.new(1, -20, 0, 2),
        Parent = notificationFrame
    }, {
        Utility:Create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, self.Theme.Secondary),
                ColorSequenceKeypoint.new(0.5, typeColor),
                ColorSequenceKeypoint.new(1, self.Theme.Secondary)
            })
        }),
        Utility:CreateCorner(nil, 2)
    })

    -- Auto Height Update
    local currentHeight = 0
    contentLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        task.wait() -- Allow text wrapping to calculate
        local newHeight = contentLabel.AbsoluteSize.Y + 65 -- base padding
        currentHeight = math.max(newHeight, 80) -- Min height
        notificationFrame.Size = UDim2.new(0, 340, 0, currentHeight)
    end)
    -- Initial update
    task.spawn(function()
        task.wait(0.1)
        local newHeight = contentLabel.AbsoluteSize.Y + 65
        currentHeight = math.max(newHeight, 80)
        notificationFrame.Size = UDim2.new(0, 340, 0, currentHeight)
    end)

    local function closeNotify()
        Utility:Tween(notificationFrame, {Position = UDim2.new(1, 20, notificationFrame.Position.Y.Scale, notificationFrame.Position.Y.Offset), BackgroundTransparency = 1}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In, function()
            notificationFrame:Destroy()
            -- Rearrange remaining notifications (advanced feature can be added here)
        end)
    end

    closeBtn.MouseButton1Click:Connect(closeNotify)

    -- elegant open animation from right
    task.spawn(function()
        task.wait(0.1)
        Utility:Tween(notificationFrame, {Position = UDim2.new(1, -355, 1, -20)}, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        
        -- Time bar animation shrink
        Utility:Tween(timeBar, {Size = UDim2.new(0, 0, 0, 2), Position = UDim2.new(0.5, 0, 1, -4)}, duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        
        task.wait(duration)
        if notificationFrame and notificationFrame.Parent then closeNotify() end
    end)
end

--// dialog, input, dropdown... can be added here following same premium aesthetic.
--// Paragraph Element (Premium Modern Style)
function KimiUI:CreateParagraph(config, parent)
    config = config or {}
    local title = config.Title or config.Name or ""
    local content = config.Content or config.Text or ""
    local align = config.Align or Enum.TextXAlignment.Left

    local paragraphFrame = Utility:Create("Frame", {
        Name = (title ~= "" and title or "Paragraph") .. "Paragraph",
        BackgroundColor3 = self.Theme.Secondary,
        BackgroundTransparency = 0.4, -- Slightly acrylic
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0), -- Auto Y
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = parent
    })
    Utility:CreateCorner(paragraphFrame, 10)
    Utility:CreateStroke(paragraphFrame, self.Theme.Border, 1, 0.8)

    local contentY = 14 -- Spacing top
    if title ~= "" then
        local titleLabel = Utility:Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 16, 0, 12),
            Size = UDim2.new(1, -32, 0, 22),
            Font = Enum.Font.GothamBold,
            Text = title,
            TextColor3 = self.Theme.Text, -- Primary title color
            TextSize = 14,
            TextXAlignment = align,
            Parent = paragraphFrame
        })
        contentY = 38 -- Lower content position
    end

    local contentLabel = Utility:Create("TextLabel", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, contentY),
        Size = UDim2.new(1, -32, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = content,
        TextColor3 = self.Theme.TextDark,
        TextSize = 13,
        TextXAlignment = align,
        TextWrapped = true,
        Parent = paragraphFrame
    })
    
    -- Bottom Padding auto updated by AutomaticSize Y
    Utility:Create("UIPadding", {
        PaddingBottom = UDim.new(0, 14),
        PaddingLeft = UDim.new(0, 16),
        PaddingRight = UDim.new(0, 16),
        PaddingTop = UDim.new(0, 14),
        Parent = paragraphFrame
    })
    
    -- reset manual position if use UIPadding
    if paragraphFrame:FindFirstChild("UIPadding") then
        if paragraphFrame:FindFirstChild("Title") then paragraphFrame.Title.Position = UDim2.new(0,0,0,0) end
        paragraphFrame.Content.Position = UDim2.new(0,0,0, title ~= "" and 28 or 0)
    end

    local Paragraph = {
        Frame = paragraphFrame,
        Title = title,
        Content = content,
        Set = function(_, text) contentLabel.Text = text end,
        Type = "Paragraph"
    }
    table.insert(self.Elements, Paragraph)
    return Paragraph
end

-- dropdown, dialog, keybind follow...
--// Keybind Element (Premium with Modern Click)
function KimiUI:CreateKeybind(config, parent, tabColor)
    config = config or {}
    local keybindName = config.Name or "Keybind"
    local defaultKey = config.Default or config.Key or Enum.KeyCode.Unknown
    local callback = config.Callback or function() end
    local flag = config.Flag or nil
    
    local accentColor = tabColor or self.Theme.Accent

    if typeof(defaultKey) == "string" then defaultKey = Enum.KeyCode[defaultKey] or Enum.KeyCode.Unknown end
    if flag then self.Flags[flag] = defaultKey end

    local keybindFrame = Utility:Create("Frame", {
        Name = keybindName .. "Keybind",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 48), -- Standard Premium Y
        Parent = parent
    })
    Utility:CreateCorner(keybindFrame, 10)
    Utility:CreateStroke(keybindFrame, self.Theme.Border, 1, 0.8)

    keybindFrame.MouseEnter:Connect(function() Utility:Tween(keybindFrame, {BackgroundColor3 = self.Theme.Border}, 0.2) end)
    keybindFrame.MouseLeave:Connect(function() Utility:Tween(keybindFrame, {BackgroundColor3 = self.Theme.Foreground}, 0.2) end)

    local keybindLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 0),
        Size = UDim2.new(1, -140, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = keybindName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = keybindFrame
    })

    -- Premium Box Design for Key
    local keyBoxFrame = Utility:Create("Frame", {
        Name = "KeyBox",
        BackgroundColor3 = self.Theme.Secondary,
        Position = UDim2.new(1, -100, 0.5, -14),
        Size = UDim2.new(0, 84, 0, 28),
        Parent = keybindFrame
    })
    Utility:CreateCorner(keyBoxFrame, 6)
    Utility:CreateStroke(keyBoxFrame, self.Theme.Border, 1, 0.7)
    
    local keyBoxGlow = Utility:CreateGlow(keyBoxFrame, accentColor, 0.7, 12, 0)
    keyBoxGlow.Enabled = false

    local keybindButton = Utility:Create("TextButton", {
        Name = "KeyButton",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        AutoButtonColor = false,
        Font = Enum.Font.GothamBold,
        Text = defaultKey ~= Enum.KeyCode.Unknown and defaultKey.Name or "NONE",
        TextColor3 = accentColor,
        TextSize = 13,
        Parent = keyBoxFrame
    })

    local listening = false
    local currentKey = defaultKey

    local function updateKey(key)
        currentKey = key
        keybindButton.Text = (currentKey ~= Enum.KeyCode.Unknown and currentKey.Name or "NONE")
        if flag then self.Flags[flag] = currentKey end
    end

    keybindButton.MouseButton1Click:Connect(function()
        listening = true
        keybindButton.Text = "..."
        keyBoxGlow.Enabled = true
        Utility:Tween(keyBoxFrame, {BackgroundColor3 = accentColor}, 0.2)
        keybindButton.TextColor3 = Color3.fromRGB(10,10,15) -- Invert color
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                listening = false
                keyBoxGlow.Enabled = false
                updateKey(input.KeyCode)
                Utility:Tween(keyBoxFrame, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
                keybindButton.TextColor3 = accentColor
            end
        elseif not gameProcessed and currentKey ~= Enum.KeyCode.Unknown then
            if input.KeyCode == currentKey then
                -- Elegant scale on press
                Utility:Tween(keybindFrame, {Size = UDim2.new(1, -5, 0, 46), Position = keybindFrame.Position + UDim2.new(0, 2.5, 0, 1)}, 0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function()
                    Utility:Tween(keybindFrame, {Size = UDim2.new(1, 0, 0, 48), Position = keybindFrame.Position - UDim2.new(0, 2.5, 0, 1)}, 0.15)
                end)
                callback()
            end
        end
    end)

    local Keybind = {
        Frame = keybindFrame,
        Key = currentKey,
        Set = function(_, key) updateKey(key) end,
        Type = "Keybind"
    }
    table.insert(self.Elements, Keybind)
    return Keybind
end

--// Dialog, Input, Colorpicker follow same aesthetic logic... 
--// To keep code concise for example, only key elements re-styled.
--// Standard dialog/notify/popup can use default logic but re-skinned.

--// Minimize Toggle
function KimiUI:ToggleMinimize()
    local mainFrame = self.MainFrame
    local winGlow = self.WinGlow
    if mainFrame.Size.Y.Offset <= 60 then -- Adjusted minimize height
        mainFrame.ClipsDescendants = false
        Utility:Tween(mainFrame, {Size = self.Config.Size or UDim2.new(0, 600, 0, 450)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        Utility:Tween(winGlow, {ImageTransparency = 0.8}, 0.6)
    else
        Utility:Tween(winGlow, {ImageTransparency = 1}, 0.2)
        Utility:Tween(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 48)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        mainFrame.ClipsDescendants = true
    end
end

-- Load/Save Config functions remain standard logic...
--// Save Config
function KimiUI:SaveConfig(filename)
    if not filename then return end
    if not isfolder("KimiUI") then makefolder("KimiUI") end
    local configData = {}
    for flag, value in pairs(self.Flags) do
        if typeof(value) == "EnumItem" then configData[flag] = {Type = "Enum", Value = tostring(value)}
        else configData[flag] = value end
    end
    writefile("KimiUI/" .. filename .. ".json", HttpService:JSONEncode(configData))
end

return KimiUI