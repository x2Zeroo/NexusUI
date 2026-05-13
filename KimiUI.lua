--[[
    KimiUI Library — Premium Edition v3.0
    ██╗  ██╗██╗███╗   ███╗██╗    ██╗   ██╗██╗
    ██║ ██╔╝██║████╗ ████║██║    ██║   ██║██║
    █████╔╝ ██║██╔████╔██║██║    ██║   ██║██║
    ██╔═██╗ ██║██║╚██╔╝██║██║    ██║   ██║██║
    ██║  ██╗██║██║ ╚═╝ ██║██║    ╚██████╔╝██║
    ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝     ╚═════╝ ╚═╝
    Ultra-Modern Premium Roblox UI Library
    — Glass Morphism • Gradient Accents • Smooth Animations —
]]

local Players       = game:GetService("Players")
local TweenService  = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService    = game:GetService("RunService")
local HttpService   = game:GetService("HttpService")
local TextService   = game:GetService("TextService")
local CoreGui       = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════════════════════════════════
--  UTILITY ENGINE
-- ═══════════════════════════════════════════════════
local Utility = {}

function Utility:Tween(instance, properties, duration, easingStyle, easingDirection, callback)
    easingStyle      = easingStyle      or Enum.EasingStyle.Quart
    easingDirection  = easingDirection  or Enum.EasingDirection.Out
    duration         = duration         or 0.35
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
    return Utility:Create("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = parent })
end

function Utility:CreateStroke(parent, color, thickness, transparency)
    return Utility:Create("UIStroke", {
        Color = color or Color3.fromRGB(60, 60, 70),
        Thickness = thickness or 1,
        Transparency = transparency or 0.8,
        Parent = parent
    })
end

function Utility:CreatePadding(parent, padding)
    padding = padding or 12
    return Utility:Create("UIPadding", {
        PaddingLeft   = UDim.new(0, padding),
        PaddingRight  = UDim.new(0, padding),
        PaddingTop    = UDim.new(0, padding),
        PaddingBottom = UDim.new(0, padding),
        Parent        = parent
    })
end

function Utility:CreateListLayout(parent, padding, sortOrder)
    return Utility:Create("UIListLayout", {
        Padding   = UDim.new(0, padding or 8),
        SortOrder = sortOrder or Enum.SortOrder.LayoutOrder,
        Parent    = parent
    })
end

function Utility:CreateGradient(parent, colorA, colorB, rotation, transpA, transpB)
    local cs = ColorSequence.new({
        ColorSequenceKeypoint.new(0, colorA),
        ColorSequenceKeypoint.new(1, colorB)
    })
    local ts = NumberSequence.new({
        NumberSequenceKeypoint.new(0, transpA or 0),
        NumberSequenceKeypoint.new(1, transpB or 0)
    })
    return Utility:Create("UIGradient", {
        Color        = cs,
        Transparency = ts,
        Rotation     = rotation or 0,
        Parent       = parent
    })
end

function Utility:Brighten(color, amt)
    return Color3.new(
        math.clamp(color.R + amt, 0, 1),
        math.clamp(color.G + amt, 0, 1),
        math.clamp(color.B + amt, 0, 1)
    )
end

function Utility:Darken(color, amt)
    return Color3.new(
        math.clamp(color.R - amt, 0, 1),
        math.clamp(color.G - amt, 0, 1),
        math.clamp(color.B - amt, 0, 1)
    )
end

function Utility:SetDrag(frame, dragArea)
    dragArea = dragArea or frame
    local dragging, dragStart, startPos = false, nil, nil
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos  = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Utility:CreateShadow(parent, transparency, size)
    size = size or 24
    return Utility:Create("ImageLabel", {
        Name             = "Shadow",
        AnchorPoint      = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position         = UDim2.new(0.5, 0, 0.5, 8),
        Size             = UDim2.new(1, size * 2, 1, size * 2),
        ZIndex           = parent.ZIndex - 1,
        Image            = "rbxassetid://5554236805",
        ImageColor3      = Color3.fromRGB(0, 0, 0),
        ImageTransparency= transparency or 0.4,
        ScaleType        = Enum.ScaleType.Slice,
        SliceCenter      = Rect.new(23, 23, 277, 277),
        Parent           = parent
    })
end

function Utility:CreateRipple(button, color)
    button.ClipsDescendants = true
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local ripple = Utility:Create("Frame", {
                Name             = "Ripple",
                AnchorPoint      = Vector2.new(0.5, 0.5),
                BackgroundColor3 = color or Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.82,
                Position         = UDim2.new(0, input.Position.X - button.AbsolutePosition.X,
                                             0, input.Position.Y - button.AbsolutePosition.Y),
                Size             = UDim2.new(0, 0, 0, 0),
                ZIndex           = button.ZIndex + 1,
                Parent           = button
            })
            Utility:CreateCorner(ripple, 100)
            local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.5
            Utility:Tween(ripple,
                { Size = UDim2.new(0, maxSize, 0, maxSize), BackgroundTransparency = 1 },
                0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.Out,
                function() ripple:Destroy() end
            )
        end
    end)
end

-- ═══════════════════════════════════════════════════
--  THEME DEFINITIONS
-- ═══════════════════════════════════════════════════
local Themes = {
    Default = {
        Primary       = Color3.fromRGB(13, 13, 18),
        Secondary     = Color3.fromRGB(24, 24, 30),
        Accent        = Color3.fromRGB(139, 92, 246),
        AccentLight   = Color3.fromRGB(167, 139, 250),
        AccentDark    = Color3.fromRGB(109, 40, 217),
        Background    = Color3.fromRGB(10, 10, 14),
        Foreground    = Color3.fromRGB(32, 32, 40),
        Text          = Color3.fromRGB(245, 246, 250),
        TextDark      = Color3.fromRGB(160, 165, 180),
        TextDarker    = Color3.fromRGB(100, 108, 130),
        Border        = Color3.fromRGB(40, 40, 52),
        BorderLight   = Color3.fromRGB(64, 64, 80),
        Success       = Color3.fromRGB(34, 211, 104),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 68, 68),
        Info          = Color3.fromRGB(59, 160, 246),
        TagPrimary    = Color3.fromRGB(139, 92, 246),
        TagSuccess    = Color3.fromRGB(34, 211, 104),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 68, 68),
        TagInfo       = Color3.fromRGB(59, 160, 246),
    },
    Dark = {
        Primary       = Color3.fromRGB(8, 8, 12),
        Secondary     = Color3.fromRGB(18, 18, 24),
        Accent        = Color3.fromRGB(139, 92, 246),
        AccentLight   = Color3.fromRGB(167, 139, 250),
        AccentDark    = Color3.fromRGB(109, 40, 217),
        Background    = Color3.fromRGB(6, 6, 10),
        Foreground    = Color3.fromRGB(26, 26, 34),
        Text          = Color3.fromRGB(229, 231, 240),
        TextDark      = Color3.fromRGB(148, 163, 184),
        TextDarker    = Color3.fromRGB(96, 112, 140),
        Border        = Color3.fromRGB(28, 28, 40),
        BorderLight   = Color3.fromRGB(50, 50, 70),
        Success       = Color3.fromRGB(34, 211, 104),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 68, 68),
        Info          = Color3.fromRGB(59, 160, 246),
        TagPrimary    = Color3.fromRGB(139, 92, 246),
        TagSuccess    = Color3.fromRGB(34, 211, 104),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 68, 68),
        TagInfo       = Color3.fromRGB(59, 160, 246),
    },
    Midnight = {
        Primary       = Color3.fromRGB(18, 18, 30),
        Secondary     = Color3.fromRGB(28, 28, 46),
        Accent        = Color3.fromRGB(129, 140, 248),
        AccentLight   = Color3.fromRGB(165, 180, 252),
        AccentDark    = Color3.fromRGB(79, 90, 220),
        Background    = Color3.fromRGB(13, 13, 24),
        Foreground    = Color3.fromRGB(38, 38, 58),
        Text          = Color3.fromRGB(226, 232, 240),
        TextDark      = Color3.fromRGB(148, 163, 184),
        TextDarker    = Color3.fromRGB(96, 112, 140),
        Border        = Color3.fromRGB(48, 48, 72),
        BorderLight   = Color3.fromRGB(68, 68, 96),
        Success       = Color3.fromRGB(52, 211, 153),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96, 165, 250),
        TagPrimary    = Color3.fromRGB(129, 140, 248),
        TagSuccess    = Color3.fromRGB(52, 211, 153),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 113, 113),
        TagInfo       = Color3.fromRGB(96, 165, 250),
    },
    Ocean = {
        Primary       = Color3.fromRGB(12, 20, 40),
        Secondary     = Color3.fromRGB(20, 32, 60),
        Accent        = Color3.fromRGB(56, 189, 248),
        AccentLight   = Color3.fromRGB(125, 211, 252),
        AccentDark    = Color3.fromRGB(14, 145, 213),
        Background    = Color3.fromRGB(8, 14, 30),
        Foreground    = Color3.fromRGB(30, 44, 72),
        Text          = Color3.fromRGB(224, 242, 254),
        TextDark      = Color3.fromRGB(148, 175, 200),
        TextDarker    = Color3.fromRGB(96, 120, 148),
        Border        = Color3.fromRGB(48, 64, 88),
        BorderLight   = Color3.fromRGB(68, 88, 112),
        Success       = Color3.fromRGB(34, 211, 104),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 68, 68),
        Info          = Color3.fromRGB(59, 160, 246),
        TagPrimary    = Color3.fromRGB(56, 189, 248),
        TagSuccess    = Color3.fromRGB(34, 211, 104),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 68, 68),
        TagInfo       = Color3.fromRGB(59, 160, 246),
    },
    Forest = {
        Primary       = Color3.fromRGB(16, 26, 16),
        Secondary     = Color3.fromRGB(26, 40, 26),
        Accent        = Color3.fromRGB(74, 222, 128),
        AccentLight   = Color3.fromRGB(134, 239, 172),
        AccentDark    = Color3.fromRGB(22, 163, 74),
        Background    = Color3.fromRGB(12, 20, 12),
        Foreground    = Color3.fromRGB(32, 52, 32),
        Text          = Color3.fromRGB(220, 252, 231),
        TextDark      = Color3.fromRGB(148, 180, 155),
        TextDarker    = Color3.fromRGB(96, 130, 100),
        Border        = Color3.fromRGB(36, 56, 36),
        BorderLight   = Color3.fromRGB(56, 80, 56),
        Success       = Color3.fromRGB(74, 222, 128),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 68, 68),
        Info          = Color3.fromRGB(59, 160, 246),
        TagPrimary    = Color3.fromRGB(74, 222, 128),
        TagSuccess    = Color3.fromRGB(34, 197, 94),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 68, 68),
        TagInfo       = Color3.fromRGB(59, 160, 246),
    },
    Sunset = {
        Primary       = Color3.fromRGB(36, 20, 20),
        Secondary     = Color3.fromRGB(52, 30, 30),
        Accent        = Color3.fromRGB(251, 146, 60),
        AccentLight   = Color3.fromRGB(253, 186, 116),
        AccentDark    = Color3.fromRGB(220, 85, 10),
        Background    = Color3.fromRGB(28, 16, 16),
        Foreground    = Color3.fromRGB(52, 36, 36),
        Text          = Color3.fromRGB(255, 237, 213),
        TextDark      = Color3.fromRGB(200, 170, 148),
        TextDarker    = Color3.fromRGB(155, 125, 105),
        Border        = Color3.fromRGB(72, 48, 48),
        BorderLight   = Color3.fromRGB(96, 64, 64),
        Success       = Color3.fromRGB(74, 222, 128),
        Warning       = Color3.fromRGB(253, 224, 71),
        Error         = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96, 165, 250),
        TagPrimary    = Color3.fromRGB(251, 146, 60),
        TagSuccess    = Color3.fromRGB(74, 222, 128),
        TagWarning    = Color3.fromRGB(253, 224, 71),
        TagError      = Color3.fromRGB(248, 113, 113),
        TagInfo       = Color3.fromRGB(96, 165, 250),
    },
    Sakura = {
        Primary       = Color3.fromRGB(32, 18, 26),
        Secondary     = Color3.fromRGB(46, 28, 40),
        Accent        = Color3.fromRGB(244, 114, 182),
        AccentLight   = Color3.fromRGB(251, 182, 217),
        AccentDark    = Color3.fromRGB(200, 50, 130),
        Background    = Color3.fromRGB(24, 14, 20),
        Foreground    = Color3.fromRGB(50, 34, 46),
        Text          = Color3.fromRGB(253, 242, 248),
        TextDark      = Color3.fromRGB(200, 165, 184),
        TextDarker    = Color3.fromRGB(155, 122, 140),
        Border        = Color3.fromRGB(62, 40, 56),
        BorderLight   = Color3.fromRGB(88, 60, 80),
        Success       = Color3.fromRGB(52, 211, 153),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96, 165, 250),
        TagPrimary    = Color3.fromRGB(244, 114, 182),
        TagSuccess    = Color3.fromRGB(52, 211, 153),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 113, 113),
        TagInfo       = Color3.fromRGB(96, 165, 250),
    },
    Cyber = {
        Primary       = Color3.fromRGB(8, 8, 16),
        Secondary     = Color3.fromRGB(16, 16, 28),
        Accent        = Color3.fromRGB(6, 182, 212),
        AccentLight   = Color3.fromRGB(103, 232, 249),
        AccentDark    = Color3.fromRGB(8, 120, 160),
        Background    = Color3.fromRGB(6, 6, 13),
        Foreground    = Color3.fromRGB(22, 22, 40),
        Text          = Color3.fromRGB(207, 250, 254),
        TextDark      = Color3.fromRGB(140, 200, 220),
        TextDarker    = Color3.fromRGB(88, 145, 165),
        Border        = Color3.fromRGB(28, 40, 60),
        BorderLight   = Color3.fromRGB(48, 65, 90),
        Success       = Color3.fromRGB(34, 211, 104),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 68, 68),
        Info          = Color3.fromRGB(59, 160, 246),
        TagPrimary    = Color3.fromRGB(6, 182, 212),
        TagSuccess    = Color3.fromRGB(34, 211, 104),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 68, 68),
        TagInfo       = Color3.fromRGB(59, 160, 246),
    },
    Royal = {
        Primary       = Color3.fromRGB(24, 16, 38),
        Secondary     = Color3.fromRGB(38, 26, 58),
        Accent        = Color3.fromRGB(168, 85, 247),
        AccentLight   = Color3.fromRGB(200, 145, 255),
        AccentDark    = Color3.fromRGB(120, 40, 200),
        Background    = Color3.fromRGB(18, 12, 30),
        Foreground    = Color3.fromRGB(46, 32, 68),
        Text          = Color3.fromRGB(243, 232, 255),
        TextDark      = Color3.fromRGB(180, 155, 205),
        TextDarker    = Color3.fromRGB(130, 108, 160),
        Border        = Color3.fromRGB(58, 40, 85),
        BorderLight   = Color3.fromRGB(82, 58, 115),
        Success       = Color3.fromRGB(52, 211, 153),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96, 165, 250),
        TagPrimary    = Color3.fromRGB(168, 85, 247),
        TagSuccess    = Color3.fromRGB(52, 211, 153),
        TagWarning    = Color3.fromRGB(251, 191, 36),
        TagError      = Color3.fromRGB(248, 113, 113),
        TagInfo       = Color3.fromRGB(96, 165, 250),
    },
    Monochrome = {
        Primary       = Color3.fromRGB(16, 16, 18),
        Secondary     = Color3.fromRGB(26, 26, 30),
        Accent        = Color3.fromRGB(210, 210, 218),
        AccentLight   = Color3.fromRGB(230, 230, 236),
        AccentDark    = Color3.fromRGB(155, 155, 165),
        Background    = Color3.fromRGB(10, 10, 12),
        Foreground    = Color3.fromRGB(38, 38, 44),
        Text          = Color3.fromRGB(244, 244, 246),
        TextDark      = Color3.fromRGB(158, 158, 170),
        TextDarker    = Color3.fromRGB(108, 108, 120),
        Border        = Color3.fromRGB(44, 44, 52),
        BorderLight   = Color3.fromRGB(64, 64, 75),
        Success       = Color3.fromRGB(161, 161, 170),
        Warning       = Color3.fromRGB(200, 200, 210),
        Error         = Color3.fromRGB(220, 140, 140),
        Info          = Color3.fromRGB(175, 175, 200),
        TagPrimary    = Color3.fromRGB(210, 210, 218),
        TagSuccess    = Color3.fromRGB(161, 161, 170),
        TagWarning    = Color3.fromRGB(200, 200, 210),
        TagError      = Color3.fromRGB(220, 140, 140),
        TagInfo       = Color3.fromRGB(175, 175, 200),
    },
}

-- ═══════════════════════════════════════════════════
--  MAIN LIBRARY
-- ═══════════════════════════════════════════════════
local KimiUI = {}
KimiUI.__index = KimiUI

KimiUI.Version = "3.0.0"
KimiUI.Themes  = Themes

-- ─── CreateWindow ─────────────────────────────────
function KimiUI:CreateWindow(config)
    config = config or {}
    local windowName        = config.Name or config.Title or "KimiUI"
    local themeName         = config.Theme or "Default"
    local size              = config.Size or UDim2.new(0, 720, 0, 520)
    local minSize           = config.MinSize or Vector2.new(560, 400)
    local canResize         = config.CanResize ~= false
    local canDrag           = config.CanDrag  ~= false
    local showCloseButton   = config.ShowCloseButton    ~= false
    local showMinimizeButton= config.ShowMinimizeButton ~= false

    local theme = Themes[themeName] or Themes.Default

    -- ScreenGui
    local screenGui = Utility:Create("ScreenGui", {
        Name          = windowName .. "_KimiUI",
        ResetOnSpawn  = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = CoreGui
    elseif gethui then
        screenGui.Parent = gethui()
    else
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    -- ── Main Frame ──────────────────────────────────
    local targetPos = config.Position or UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2)
    local mainFrame = Utility:Create("Frame", {
        Name                 = "Main",
        BackgroundColor3     = theme.Background,
        BorderSizePixel      = 0,
        Position             = targetPos,
        Size                 = UDim2.new(0, size.X.Offset * 0.94, 0, size.Y.Offset * 0.92),
        ClipsDescendants     = true,
        Parent               = screenGui,
    })
    Utility:CreateCorner(mainFrame, 14)
    Utility:CreateShadow(mainFrame, 0.38, 28)

    -- Outer glow border
    Utility:CreateStroke(mainFrame, theme.Accent, 1.5, 0.82)

    -- Subtle background gradient (top slightly lighter)
    Utility:CreateGradient(mainFrame, Utility:Brighten(theme.Background, 0.03), theme.Background, 90)

    if canDrag then Utility:SetDrag(mainFrame) end

    -- Entrance animation
    task.defer(function()
        Utility:Tween(mainFrame, {
            Size     = size,
            Position = targetPos,
        }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end)

    -- ── Resize Handle ──────────────────────────────
    if canResize then
        local resizeHandle = Utility:Create("Frame", {
            Name                = "ResizeHandle",
            BackgroundTransparency = 1,
            Position            = UDim2.new(1, -20, 1, -20),
            Size                = UDim2.new(0, 20, 0, 20),
            ZIndex              = 10,
            Parent              = mainFrame,
        })
        Utility:Create("ImageLabel", {
            BackgroundTransparency = 1,
            Position               = UDim2.new(0, 4, 0, 4),
            Size                   = UDim2.new(0, 12, 0, 12),
            Image                  = "rbxassetid://6761432098",
            ImageColor3            = theme.Accent,
            ImageTransparency      = 0.5,
            ZIndex                 = 10,
            Parent                 = resizeHandle,
        })
        local resizing, resizeStart, startSize = false, nil, nil
        resizeHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true; resizeStart = input.Position; startSize = mainFrame.Size
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - resizeStart
                mainFrame.Size = UDim2.new(0,
                    math.max(minSize.X, startSize.X.Offset + delta.X), 0,
                    math.max(minSize.Y, startSize.Y.Offset + delta.Y))
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end
        end)
    end

    -- ── Title Bar ──────────────────────────────────
    local titleBar = Utility:Create("Frame", {
        Name             = "TitleBar",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 48),
        Parent           = mainFrame,
    })
    -- Titlebar gradient (top = brighter, subtle)
    Utility:CreateGradient(
        titleBar,
        Utility:Brighten(theme.Primary, 0.055),
        theme.Primary,
        90
    )

    -- Accent glow (soft, wider)
    local accentGlow = Utility:Create("Frame", {
        Name             = "AccentGlow",
        BackgroundColor3 = theme.Accent,
        BackgroundTransparency = 0.72,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 0, 1, -5),
        Size             = UDim2.new(1, 0, 0, 5),
        Parent           = titleBar,
    })
    -- Accent line (sharp, on top of glow)
    local accentLine = Utility:Create("Frame", {
        Name             = "AccentLine",
        BackgroundColor3 = theme.Accent,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 0, 1, -2),
        Size             = UDim2.new(1, 0, 0, 2),
        Parent           = titleBar,
    })
    Utility:CreateGradient(accentLine, theme.AccentLight, theme.AccentDark, 0)

    -- Window icon with circular tinted background
    local iconBg = Utility:Create("Frame", {
        Name                 = "IconBg",
        BackgroundColor3     = theme.Accent,
        BackgroundTransparency = 0.82,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0, 12, 0.5, -14),
        Size                 = UDim2.new(0, 28, 0, 28),
        Parent               = titleBar,
    })
    Utility:CreateCorner(iconBg, 8)

    Utility:Create("ImageLabel", {
        Name                 = "Icon",
        BackgroundTransparency = 1,
        AnchorPoint          = Vector2.new(0.5, 0.5),
        Position             = UDim2.new(0.5, 0, 0.5, 0),
        Size                 = UDim2.new(0, 18, 0, 18),
        Image                = config.Icon or "rbxassetid://7733965386",
        ImageColor3          = theme.AccentLight,
        Parent               = iconBg,
    })

    local windowTitle = Utility:Create("TextLabel", {
        Name                 = "Title",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 48, 0, 0),
        Size                 = UDim2.new(1, -150, 1, 0),
        Font                 = Enum.Font.GothamBlack,
        Text                 = windowName,
        TextColor3           = theme.Text,
        TextSize             = 15,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = titleBar,
    })

    -- Version badge
    local versionBadge = Utility:Create("Frame", {
        Name                 = "VersionBadge",
        BackgroundColor3     = theme.Accent,
        BackgroundTransparency = 0.78,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0, 48 + TextService:GetTextSize(windowName, 15, Enum.Font.GothamBlack, Vector2.new(999,999)).X + 8, 0.5, -9),
        Size                 = UDim2.new(0, 48, 0, 18),
        Parent               = titleBar,
    })
    Utility:CreateCorner(versionBadge, 5)
    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Size                   = UDim2.new(1, 0, 1, 0),
        Font                   = Enum.Font.GothamBold,
        Text                   = "v3.0",
        TextColor3             = theme.AccentLight,
        TextSize               = 10,
        Parent                 = versionBadge,
    })

    -- Window control buttons
    local buttonsFrame = Utility:Create("Frame", {
        Name                 = "Buttons",
        BackgroundTransparency = 1,
        Position             = UDim2.new(1, -96, 0, 0),
        Size                 = UDim2.new(0, 96, 1, 0),
        Parent               = titleBar,
    })

    local function makeTitleBtn(name, symbol, xPos, w, hoverColor)
        local btn = Utility:Create("TextButton", {
            Name                 = name,
            BackgroundTransparency = 1,
            Position             = UDim2.new(0, xPos, 0, 0),
            Size                 = UDim2.new(0, w, 1, 0),
            AutoButtonColor      = false,
            Font                 = Enum.Font.GothamBold,
            Text                 = symbol,
            TextColor3           = theme.TextDark,
            TextSize             = 20,
            Parent               = buttonsFrame,
        })
        -- Hover background pill
        local hoverBg = Utility:Create("Frame", {
            Name                 = "HoverBg",
            AnchorPoint          = Vector2.new(0.5, 0.5),
            BackgroundColor3     = hoverColor or theme.Foreground,
            BackgroundTransparency = 1,
            BorderSizePixel      = 0,
            Position             = UDim2.new(0.5, 0, 0.5, 0),
            Size                 = UDim2.new(0, w - 10, 0, 28),
            ZIndex               = btn.ZIndex - 1,
            Parent               = btn,
        })
        Utility:CreateCorner(hoverBg, 7)
        btn.MouseEnter:Connect(function()
            Utility:Tween(hoverBg, { BackgroundTransparency = 0.75 }, 0.18)
            Utility:Tween(btn, { TextColor3 = hoverColor or theme.Text }, 0.18)
        end)
        btn.MouseLeave:Connect(function()
            Utility:Tween(hoverBg, { BackgroundTransparency = 1 }, 0.18)
            Utility:Tween(btn, { TextColor3 = theme.TextDark }, 0.18)
        end)
        return btn
    end

    if showMinimizeButton then
        local minimizeBtn = makeTitleBtn("Minimize", "−", 0, 48, theme.BorderLight)
        local minimized = false
        minimizeBtn.MouseButton1Click:Connect(function()
            minimized = not minimized
            if minimized then
                Utility:Tween(mainFrame, { Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 48) }, 0.38, Enum.EasingStyle.Quart)
            else
                Utility:Tween(mainFrame, { Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, size.Y.Offset) }, 0.38, Enum.EasingStyle.Quart)
            end
        end)
    end

    if showCloseButton then
        local closeBtn = makeTitleBtn("Close", "×", 48, 48, theme.Error)
        closeBtn.MouseButton1Click:Connect(function()
            Utility:Tween(mainFrame, { Size = UDim2.new(0, 0, 0, 0) }, 0.32, Enum.EasingStyle.Back, Enum.EasingDirection.In, function()
                screenGui:Destroy()
            end)
        end)
    end

    -- ── Content Area ───────────────────────────────
    local contentArea = Utility:Create("Frame", {
        Name                 = "Content",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 0, 0, 48),
        Size                 = UDim2.new(1, 0, 1, -48),
        Parent               = mainFrame,
    })

    -- ── Tab Sidebar ────────────────────────────────
    local tabContainer = Utility:Create("Frame", {
        Name             = "TabContainer",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel  = 0,
        Size             = UDim2.new(0, 172, 1, 0),
        Parent           = contentArea,
    })
    -- Sidebar gradient
    Utility:CreateGradient(tabContainer, Utility:Brighten(theme.Primary, 0.025), theme.Primary, 90)

    -- Sidebar right border
    Utility:Create("Frame", {
        Name             = "Border",
        BackgroundColor3 = theme.Border,
        BorderSizePixel  = 0,
        Position         = UDim2.new(1, -1, 0, 0),
        Size             = UDim2.new(0, 1, 1, 0),
        Parent           = tabContainer,
    })
    -- Subtle accent glow on the border
    Utility:Create("Frame", {
        Name                 = "BorderGlow",
        BackgroundColor3     = theme.Accent,
        BackgroundTransparency = 0.88,
        BorderSizePixel      = 0,
        Position             = UDim2.new(1, -2, 0, 0),
        Size                 = UDim2.new(0, 2, 1, 0),
        Parent               = tabContainer,
    })

    local tabScroll = Utility:Create("ScrollingFrame", {
        Name                   = "TabScroll",
        BackgroundTransparency = 1,
        BorderSizePixel        = 0,
        Size                   = UDim2.new(1, 0, 1, 0),
        CanvasSize             = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness     = 3,
        ScrollBarImageColor3   = theme.Accent,
        ScrollBarImageTransparency = 0.55,
        Parent                 = tabContainer,
    })
    local tabListLayout = Utility:CreateListLayout(tabScroll, 5)
    Utility:CreatePadding(tabScroll, 10)
    tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabScroll.CanvasSize = UDim2.new(0, 0, 0, tabListLayout.AbsoluteContentSize.Y + 20)
    end)

    local tabContentArea = Utility:Create("Frame", {
        Name                   = "TabContentArea",
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 172, 0, 0),
        Size                   = UDim2.new(1, -172, 1, 0),
        Parent                 = contentArea,
    })
    local tabContents = Utility:Create("Folder", {
        Name   = "TabContents",
        Parent = tabContentArea,
    })

    -- ── Window Object ──────────────────────────────
    local Window = setmetatable({}, KimiUI)
    Window.Theme          = theme
    Window.ThemeName      = themeName
    Window.ScreenGui      = screenGui
    Window.MainFrame      = mainFrame
    Window.TabContainer   = tabScroll
    Window.TabContentArea = tabContentArea
    Window.TabContents    = tabContents
    Window.Tabs           = {}
    Window.ActiveTab      = nil
    Window.Elements       = {}
    Window.Flags          = {}
    Window.Connections    = {}
    Window.Config         = config
    KimiUI.CurrentWindow  = Window

    return Window
end

-- ─── SetTheme ─────────────────────────────────────
function KimiUI:SetTheme(themeName)
    local theme = Themes[themeName]
    if not theme then return end
    self.Theme     = theme
    self.ThemeName = themeName
    for _, element in pairs(self.Elements) do
        if element.UpdateTheme then element:UpdateTheme(theme) end
    end
end

function KimiUI:CreateCustomTheme(name, colors)
    Themes[name] = colors
end

-- ─── AddTab ───────────────────────────────────────
function KimiUI:AddTab(config)
    config = config or {}
    local tabName  = config.Name  or "Tab"
    local tabIcon  = config.Icon  or nil
    local tabColor = config.Color or self.Theme.Accent

    -- Tab button
    local tabButton = Utility:Create("TextButton", {
        Name             = tabName .. "Tab",
        BackgroundColor3 = self.Theme.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, -20, 0, 40),
        AutoButtonColor  = false,
        Font             = Enum.Font.GothamSemibold,
        Text             = "",
        Parent           = self.TabContainer,
    })
    Utility:CreateCorner(tabButton, 10)

    -- Active tab gradient overlay (hidden by default)
    local activeGradient = Utility:Create("Frame", {
        Name                 = "ActiveGradient",
        BackgroundColor3     = tabColor,
        BackgroundTransparency = 1,
        BorderSizePixel      = 0,
        Size                 = UDim2.new(1, 0, 1, 0),
        Parent               = tabButton,
    })
    Utility:CreateCorner(activeGradient, 10)
    Utility:CreateGradient(activeGradient, tabColor, Utility:Darken(tabColor, 0.08), 0, 0.88, 0.95)

    -- Left glow indicator
    local tabIndicator = Utility:Create("Frame", {
        Name             = "Indicator",
        BackgroundColor3 = tabColor,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 0, 0.5, 0),
        Size             = UDim2.new(0, 4, 0, 0),
        Parent           = tabButton,
    })
    Utility:CreateCorner(tabIndicator, 2)

    -- Indicator glow
    local indicatorGlow = Utility:Create("Frame", {
        Name                 = "IndicatorGlow",
        BackgroundColor3     = tabColor,
        BackgroundTransparency = 0.65,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0, 0, 0.5, 0),
        Size                 = UDim2.new(0, 10, 0, 0),
        Parent               = tabButton,
    })
    Utility:CreateCorner(indicatorGlow, 5)

    if tabIcon then
        local iconContainer = Utility:Create("Frame", {
            Name                 = "IconContainer",
            BackgroundTransparency = 1,
            Position             = UDim2.new(0, 10, 0.5, -10),
            Size                 = UDim2.new(0, 20, 0, 20),
            Parent               = tabButton,
        })
        Utility:Create("ImageLabel", {
            Name                 = "Icon",
            BackgroundTransparency = 1,
            AnchorPoint          = Vector2.new(0.5, 0.5),
            Position             = UDim2.new(0.5, 0, 0.5, 0),
            Size                 = UDim2.new(0, 18, 0, 18),
            Image                = tabIcon,
            ImageColor3          = self.Theme.TextDark,
            Parent               = iconContainer,
        })
    end

    local tabText = Utility:Create("TextLabel", {
        Name                 = "Text",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, tabIcon and 36 or 14, 0, 0),
        Size                 = UDim2.new(1, -52, 1, 0),
        Font                 = Enum.Font.GothamSemibold,
        Text                 = tabName,
        TextColor3           = self.Theme.TextDark,
        TextSize             = 13,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = tabButton,
    })

    -- Tab content scroll
    local tabContent = Utility:Create("ScrollingFrame", {
        Name                   = tabName .. "Content",
        BackgroundTransparency = 1,
        BorderSizePixel        = 0,
        Size                   = UDim2.new(1, 0, 1, 0),
        CanvasSize             = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness     = 4,
        ScrollBarImageColor3   = self.Theme.Accent,
        ScrollBarImageTransparency = 0.5,
        Visible                = false,
        Parent                 = self.TabContents,
    })
    local contentLayout = Utility:CreateListLayout(tabContent, 12)
    Utility:CreatePadding(tabContent, 14)
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 28)
    end)

    local Tab = {
        Name      = tabName,
        Button    = tabButton,
        Content   = tabContent,
        Indicator = tabIndicator,
        Sections  = {},
        Window    = self,
        Color     = tabColor,
    }
    table.insert(self.Tabs, Tab)

    -- Hover
    tabButton.MouseEnter:Connect(function()
        if self.ActiveTab ~= Tab then
            Utility:Tween(tabButton, { BackgroundColor3 = self.Theme.Foreground, BackgroundTransparency = 0.1 }, 0.2)
            local icon = tabButton:FindFirstChild("Icon", true)
            if icon then Utility:Tween(icon, { ImageColor3 = self.Theme.Text }, 0.2) end
            Utility:Tween(tabText, { TextColor3 = self.Theme.Text }, 0.2)
        end
    end)
    tabButton.MouseLeave:Connect(function()
        if self.ActiveTab ~= Tab then
            Utility:Tween(tabButton, { BackgroundColor3 = self.Theme.Secondary, BackgroundTransparency = 0.4 }, 0.2)
            local icon = tabButton:FindFirstChild("Icon", true)
            if icon then Utility:Tween(icon, { ImageColor3 = self.Theme.TextDark }, 0.2) end
            Utility:Tween(tabText, { TextColor3 = self.Theme.TextDark }, 0.2)
        end
    end)
    tabButton.MouseButton1Click:Connect(function() self:SelectTab(Tab) end)

    if #self.Tabs == 1 then self:SelectTab(Tab) end

    -- ── AddSection ──────────────────────────────────
    function Tab:AddSection(cfg)
        cfg = cfg or {}
        local sectionName = cfg.Name or "Section"
        local sectionDesc = cfg.Description or ""

        local sectionFrame = Utility:Create("Frame", {
            Name             = sectionName .. "Section",
            BackgroundColor3 = self.Window.Theme.Secondary,
            BorderSizePixel  = 0,
            Size             = UDim2.new(1, -6, 0, 40),
            AutomaticSize    = Enum.AutomaticSize.Y,
            Parent           = self.Content,
        })
        Utility:CreateCorner(sectionFrame, 12)
        -- Glass-like section gradient
        Utility:CreateGradient(
            sectionFrame,
            Utility:Brighten(self.Window.Theme.Secondary, 0.03),
            self.Window.Theme.Secondary,
            90
        )
        -- Subtle outer stroke
        Utility:CreateStroke(sectionFrame, self.Window.Theme.BorderLight, 1, 0.85)

        -- Left accent bar (gradient)
        local accentBar = Utility:Create("Frame", {
            Name             = "AccentBar",
            BackgroundColor3 = self.Window.Theme.Accent,
            BorderSizePixel  = 0,
            Position         = UDim2.new(0, 0, 0, 10),
            Size             = UDim2.new(0, 3, 1, -20),
            Parent           = sectionFrame,
        })
        Utility:CreateCorner(accentBar, 2)
        Utility:CreateGradient(accentBar, self.Window.Theme.AccentLight, self.Window.Theme.AccentDark, 90)

        -- Section header
        local sectionTitle = Utility:Create("TextLabel", {
            Name                 = "Title",
            BackgroundTransparency = 1,
            Position             = UDim2.new(0, 16, 0, 12),
            Size                 = UDim2.new(1, -32, 0, 20),
            Font                 = Enum.Font.GothamBlack,
            Text                 = sectionName,
            TextColor3           = self.Window.Theme.Text,
            TextSize             = 13,
            TextXAlignment       = Enum.TextXAlignment.Left,
            Parent               = sectionFrame,
        })

        local contentOffset = 34
        if sectionDesc ~= "" then
            Utility:Create("TextLabel", {
                Name                 = "Description",
                BackgroundTransparency = 1,
                Position             = UDim2.new(0, 16, 0, 32),
                Size                 = UDim2.new(1, -32, 0, 16),
                Font                 = Enum.Font.Gotham,
                Text                 = sectionDesc,
                TextColor3           = self.Window.Theme.TextDarker,
                TextSize             = 11,
                TextXAlignment       = Enum.TextXAlignment.Left,
                Parent               = sectionFrame,
            })
            contentOffset = 50
        end

        -- Thin separator under header
        Utility:Create("Frame", {
            Name             = "Separator",
            BackgroundColor3 = self.Window.Theme.Border,
            BorderSizePixel  = 0,
            Position         = UDim2.new(0, 14, 0, contentOffset - 2),
            Size             = UDim2.new(1, -28, 0, 1),
            Parent           = sectionFrame,
        })

        local sectionContent = Utility:Create("Frame", {
            Name                 = "Content",
            BackgroundTransparency = 1,
            Position             = UDim2.new(0, 0, 0, contentOffset + 4),
            Size                 = UDim2.new(1, 0, 1, -contentOffset - 4),
            Parent               = sectionFrame,
        })
        local sectionLayout = Utility:CreateListLayout(sectionContent, 8)
        Utility:CreatePadding(sectionContent, 10)
        sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            local h = sectionLayout.AbsoluteContentSize.Y + 20
            sectionFrame.Size = UDim2.new(1, -6, 0, contentOffset + 4 + h)
            sectionContent.Size = UDim2.new(1, 0, 0, h)
        end)

        local Section = {
            Name    = sectionName,
            Frame   = sectionFrame,
            Content = sectionContent,
            Tab     = self,
            Elements= {},
        }
        table.insert(self.Sections, Section)
        table.insert(self.Window.Elements, Section)

        function Section:AddButton(c)     return self.Tab.Window:CreateButton(c, self.Content)      end
        function Section:AddToggle(c)     return self.Tab.Window:CreateToggle(c, self.Content)      end
        function Section:AddSlider(c)     return self.Tab.Window:CreateSlider(c, self.Content)      end
        function Section:AddInput(c)      return self.Tab.Window:CreateInput(c, self.Content)       end
        function Section:AddDropdown(c)   return self.Tab.Window:CreateDropdown(c, self.Content)    end
        function Section:AddParagraph(c)  return self.Tab.Window:CreateParagraph(c, self.Content)   end
        function Section:AddKeybind(c)    return self.Tab.Window:CreateKeybind(c, self.Content)     end
        function Section:AddColorpicker(c)return self.Tab.Window:CreateColorpicker(c, self.Content) end
        function Section:AddCode(c)       return self.Tab.Window:CreateCode(c, self.Content)        end
        function Section:AddAdvanced(c)   return self.Tab.Window:CreateAdvanced(c, self.Content)    end
        function Section:AddDivider(c)    return self.Tab.Window:CreateDivider(c, self.Content)     end
        return Section
    end

    function Tab:AddButton(c)     return self.Window:CreateButton(c, self.Content)      end
    function Tab:AddToggle(c)     return self.Window:CreateToggle(c, self.Content)      end
    function Tab:AddSlider(c)     return self.Window:CreateSlider(c, self.Content)      end
    function Tab:AddInput(c)      return self.Window:CreateInput(c, self.Content)       end
    function Tab:AddDropdown(c)   return self.Window:CreateDropdown(c, self.Content)    end
    function Tab:AddParagraph(c)  return self.Window:CreateParagraph(c, self.Content)   end
    function Tab:AddKeybind(c)    return self.Window:CreateKeybind(c, self.Content)     end
    function Tab:AddColorpicker(c)return self.Window:CreateColorpicker(c, self.Content) end
    function Tab:AddCode(c)       return self.Window:CreateCode(c, self.Content)        end
    function Tab:AddAdvanced(c)   return self.Window:CreateAdvanced(c, self.Content)    end
    function Tab:AddDivider(c)    return self.Window:CreateDivider(c, self.Content)     end
    function Tab:AddSection(c)    return Tab.AddSection(self, c)                        end -- alias
    return Tab
end

-- ─── SelectTab ────────────────────────────────────
function KimiUI:SelectTab(tab)
    if self.ActiveTab == tab then return end
    if self.ActiveTab then
        local prev = self.ActiveTab
        Utility:Tween(prev.Button, { BackgroundColor3 = self.Theme.Secondary, BackgroundTransparency = 0.4 }, 0.25)
        Utility:Tween(prev.Indicator, { Size = UDim2.new(0, 4, 0, 0), Position = UDim2.new(0, 0, 0.5, 0) }, 0.25)
        local prevGlow = prev.Button:FindFirstChild("IndicatorGlow")
        if prevGlow then Utility:Tween(prevGlow, { Size = UDim2.new(0, 10, 0, 0) }, 0.25) end
        local prevActiveGrad = prev.Button:FindFirstChild("ActiveGradient")
        if prevActiveGrad then Utility:Tween(prevActiveGrad, { BackgroundTransparency = 1 }, 0.25) end
        prev.Content.Visible = false
        local prevIcon = prev.Button:FindFirstChild("Icon", true)
        if prevIcon then Utility:Tween(prevIcon, { ImageColor3 = self.Theme.TextDark }, 0.25) end
        local prevText = prev.Button:FindFirstChild("Text")
        if prevText then Utility:Tween(prevText, { TextColor3 = self.Theme.TextDark }, 0.25) end
    end

    self.ActiveTab = tab
    Utility:Tween(tab.Button, { BackgroundColor3 = self.Theme.Foreground, BackgroundTransparency = 0 }, 0.25)
    Utility:Tween(tab.Indicator, { Size = UDim2.new(0, 4, 1, -16), Position = UDim2.new(0, 0, 0, 8) }, 0.25, Enum.EasingStyle.Back)
    local activeGlow = tab.Button:FindFirstChild("IndicatorGlow")
    if activeGlow then Utility:Tween(activeGlow, { Size = UDim2.new(0, 14, 1, -16), Position = UDim2.new(0, 0, 0, 8) }, 0.25) end
    local activeGrad = tab.Button:FindFirstChild("ActiveGradient")
    if activeGrad then Utility:Tween(activeGrad, { BackgroundTransparency = 0.88 }, 0.25) end
    tab.Content.Visible = true
    local tabIcon = tab.Button:FindFirstChild("Icon", true)
    if tabIcon then Utility:Tween(tabIcon, { ImageColor3 = tab.Color }, 0.25) end
    local tabText = tab.Button:FindFirstChild("Text")
    if tabText then Utility:Tween(tabText, { TextColor3 = self.Theme.Text }, 0.25) end
end

-- ═══════════════════════════════════════════════════
--  ELEMENTS
-- ═══════════════════════════════════════════════════

-- ─── Button ───────────────────────────────────────
function KimiUI:CreateButton(config, parent)
    config = config or {}
    local buttonText  = config.Name or config.Text or "Button"
    local callback    = config.Callback or function() end
    local buttonStyle = config.Style or "Primary"
    local buttonSize  = config.Size or UDim2.new(1, 0, 0, 40)
    local icon        = config.Icon or nil

    local bgColor, textColor
    if buttonStyle == "Primary" then
        bgColor = self.Theme.Accent; textColor = Color3.fromRGB(255, 255, 255)
    elseif buttonStyle == "Secondary" then
        bgColor = self.Theme.Foreground; textColor = self.Theme.Text
    elseif buttonStyle == "Outline" then
        bgColor = self.Theme.Secondary; textColor = self.Theme.Text
    elseif buttonStyle == "Ghost" then
        bgColor = self.Theme.Secondary; textColor = self.Theme.TextDark
    elseif buttonStyle == "Danger" then
        bgColor = self.Theme.Error; textColor = Color3.fromRGB(255, 255, 255)
    else
        bgColor = self.Theme.Accent; textColor = Color3.fromRGB(255, 255, 255)
    end

    local buttonFrame = Utility:Create("TextButton", {
        Name                 = buttonText .. "Button",
        BackgroundColor3     = bgColor,
        BackgroundTransparency = buttonStyle == "Ghost" and 0.88 or 0,
        BorderSizePixel      = 0,
        Size                 = buttonSize,
        AutoButtonColor      = false,
        Font                 = Enum.Font.GothamBold,
        Text                 = buttonText,
        TextColor3           = textColor,
        TextSize             = 14,
        Parent               = parent,
    })
    Utility:CreateCorner(buttonFrame, 10)

    -- Gradient on filled buttons
    if buttonStyle == "Primary" then
        Utility:CreateGradient(buttonFrame, self.Theme.AccentLight, self.Theme.AccentDark, 90)
        -- Subtle top-edge highlight
        Utility:Create("Frame", {
            BackgroundColor3     = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.88,
            BorderSizePixel      = 0,
            Size                 = UDim2.new(1, 0, 0, 1),
            ZIndex               = buttonFrame.ZIndex + 1,
            Parent               = buttonFrame,
        })
    elseif buttonStyle == "Danger" then
        Utility:CreateGradient(buttonFrame, Utility:Brighten(self.Theme.Error, 0.08), self.Theme.Error, 90)
        Utility:Create("Frame", {
            BackgroundColor3     = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.88,
            BorderSizePixel      = 0,
            Size                 = UDim2.new(1, 0, 0, 1),
            ZIndex               = buttonFrame.ZIndex + 1,
            Parent               = buttonFrame,
        })
    elseif buttonStyle == "Outline" then
        Utility:CreateStroke(buttonFrame, self.Theme.Accent, 1.5, 0.55)
    end

    if icon then
        Utility:Create("ImageLabel", {
            Name                 = "Icon",
            BackgroundTransparency = 1,
            Position             = UDim2.new(0, 12, 0.5, -9),
            Size                 = UDim2.new(0, 18, 0, 18),
            Image                = icon,
            ImageColor3          = textColor,
            Parent               = buttonFrame,
        })
        buttonFrame.Text = "   " .. buttonText
        buttonFrame.TextXAlignment = Enum.TextXAlignment.Left
    end

    Utility:CreateRipple(buttonFrame)

    -- Hover
    buttonFrame.MouseEnter:Connect(function()
        if buttonStyle == "Primary" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = self.Theme.AccentLight }, 0.2)
        elseif buttonStyle == "Danger" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = Utility:Brighten(self.Theme.Error, 0.08) }, 0.2)
        elseif buttonStyle == "Secondary" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = self.Theme.BorderLight }, 0.2)
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = self.Theme.Accent }, 0.2)
            local stroke = buttonFrame:FindFirstChildOfClass("UIStroke")
            if stroke then stroke.Transparency = 1 end
            Utility:Tween(buttonFrame, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.0)
        elseif buttonStyle == "Ghost" then
            Utility:Tween(buttonFrame, { BackgroundTransparency = 0.72 }, 0.2)
            Utility:Tween(buttonFrame, { TextColor3 = self.Theme.Text }, 0.0)
        end
    end)
    buttonFrame.MouseLeave:Connect(function()
        if buttonStyle == "Primary" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = self.Theme.Accent }, 0.2)
        elseif buttonStyle == "Danger" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = self.Theme.Error }, 0.2)
        elseif buttonStyle == "Secondary" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = self.Theme.Foreground }, 0.2)
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, { BackgroundColor3 = self.Theme.Secondary }, 0.2)
            local stroke = buttonFrame:FindFirstChildOfClass("UIStroke")
            if stroke then stroke.Transparency = 0.55 end
            Utility:Tween(buttonFrame, { TextColor3 = self.Theme.Text }, 0.0)
        elseif buttonStyle == "Ghost" then
            Utility:Tween(buttonFrame, { BackgroundTransparency = 0.88 }, 0.2)
            Utility:Tween(buttonFrame, { TextColor3 = self.Theme.TextDark }, 0.0)
        end
    end)
    buttonFrame.MouseButton1Click:Connect(function() callback() end)

    local Button = { Frame = buttonFrame, Callback = callback, Type = "Button" }
    table.insert(self.Elements, Button)
    return Button
end

-- ─── Toggle ───────────────────────────────────────
function KimiUI:CreateToggle(config, parent)
    config = config or {}
    local toggleName = config.Name or "Toggle"
    local default    = config.Default or false
    local callback   = config.Callback or function() end
    local flag       = config.Flag or nil
    local icon       = config.Icon or nil

    if flag then self.Flags[flag] = default end

    local toggleFrame = Utility:Create("Frame", {
        Name             = toggleName .. "Toggle",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 44),
        Parent           = parent,
    })
    Utility:CreateCorner(toggleFrame, 10)
    Utility:CreateStroke(toggleFrame, self.Theme.Border, 1, 0.88)

    local labelOffset = 14
    if icon then
        local ic = Utility:Create("ImageLabel", {
            BackgroundTransparency = 1,
            Position               = UDim2.new(0, 14, 0.5, -9),
            Size                   = UDim2.new(0, 18, 0, 18),
            Image                  = icon,
            ImageColor3            = self.Theme.TextDark,
            Parent                 = toggleFrame,
        })
        labelOffset = 38
    end

    Utility:Create("TextLabel", {
        Name                 = "Label",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, labelOffset, 0, 0),
        Size                 = UDim2.new(1, -110, 1, 0),
        Font                 = Enum.Font.GothamSemibold,
        Text                 = toggleName,
        TextColor3           = self.Theme.Text,
        TextSize             = 14,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = toggleFrame,
    })

    local toggleTrack = Utility:Create("TextButton", {
        Name             = "Track",
        BackgroundColor3 = default and self.Theme.Accent or self.Theme.Border,
        BorderSizePixel  = 0,
        Position         = UDim2.new(1, -58, 0.5, -13),
        Size             = UDim2.new(0, 50, 0, 26),
        AutoButtonColor  = false,
        Text             = "",
        Parent           = toggleFrame,
    })
    Utility:CreateCorner(toggleTrack, 13)

    -- Gradient on track when enabled
    local trackGradient = Utility:CreateGradient(toggleTrack, self.Theme.AccentLight, self.Theme.AccentDark, 0)
    trackGradient.Transparency = default
        and NumberSequence.new(0)
        or  NumberSequence.new(1)

    local toggleThumb = Utility:Create("Frame", {
        Name             = "Thumb",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel  = 0,
        Position         = default and UDim2.new(1, -23, 0.5, -11) or UDim2.new(0, 3, 0.5, -11),
        Size             = UDim2.new(0, 22, 0, 22),
        Parent           = toggleTrack,
    })
    Utility:CreateCorner(toggleThumb, 11)
    Utility:CreateShadow(toggleThumb, 0.28, 6)

    local toggled = default

    toggleTrack.MouseButton1Click:Connect(function()
        toggled = not toggled
        if flag then self.Flags[flag] = toggled end

        Utility:Tween(toggleTrack, { BackgroundColor3 = toggled and self.Theme.Accent or self.Theme.Border }, 0.3, Enum.EasingStyle.Quart)
        Utility:Tween(toggleThumb, { Position = toggled and UDim2.new(1, -23, 0.5, -11) or UDim2.new(0, 3, 0.5, -11) }, 0.3, Enum.EasingStyle.Quart)

        -- Animate gradient
        trackGradient.Transparency = toggled
            and NumberSequence.new(0)
            or  NumberSequence.new(1)

        callback(toggled)
    end)

    local Toggle = {
        Frame = toggleFrame,
        Value = toggled,
        Set = function(_, value)
            toggled = value
            if flag then KimiUI.CurrentWindow.Flags[flag] = toggled end
            local theme = KimiUI.CurrentWindow.Theme
            Utility:Tween(toggleTrack, { BackgroundColor3 = toggled and theme.Accent or theme.Border }, 0.3)
            Utility:Tween(toggleThumb, { Position = toggled and UDim2.new(1, -23, 0.5, -11) or UDim2.new(0, 3, 0.5, -11) }, 0.3)
            trackGradient.Transparency = toggled and NumberSequence.new(0) or NumberSequence.new(1)
            callback(toggled)
        end,
        Type = "Toggle",
    }
    table.insert(self.Elements, Toggle)
    return Toggle
end

-- ─── Slider ───────────────────────────────────────
function KimiUI:CreateSlider(config, parent)
    config = config or {}
    local sliderName = config.Name or "Slider"
    local min        = config.Min or config.Minimum or 0
    local max        = config.Max or config.Maximum or 100
    local default    = config.Default or min
    local increment  = config.Increment or config.Step or 1
    local suffix     = config.Suffix or config.Postfix or ""
    local callback   = config.Callback or function() end
    local flag       = config.Flag or nil

    default = math.clamp(default, min, max)
    if flag then self.Flags[flag] = default end

    local sliderFrame = Utility:Create("Frame", {
        Name             = sliderName .. "Slider",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 64),
        Parent           = parent,
    })
    Utility:CreateCorner(sliderFrame, 10)
    Utility:CreateStroke(sliderFrame, self.Theme.Border, 1, 0.88)

    Utility:Create("TextLabel", {
        Name                 = "Label",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 14, 0, 9),
        Size                 = UDim2.new(1, -100, 0, 20),
        Font                 = Enum.Font.GothamSemibold,
        Text                 = sliderName,
        TextColor3           = self.Theme.Text,
        TextSize             = 14,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = sliderFrame,
    })

    local valueLabel = Utility:Create("TextLabel", {
        Name                 = "Value",
        BackgroundTransparency = 1,
        Position             = UDim2.new(1, -88, 0, 9),
        Size                 = UDim2.new(0, 78, 0, 20),
        Font                 = Enum.Font.GothamBlack,
        Text                 = tostring(default) .. suffix,
        TextColor3           = self.Theme.AccentLight,
        TextSize             = 13,
        TextXAlignment       = Enum.TextXAlignment.Right,
        Parent               = sliderFrame,
    })

    -- Track background
    local trackBg = Utility:Create("Frame", {
        Name             = "TrackBg",
        BackgroundColor3 = self.Theme.Border,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 14, 0, 40),
        Size             = UDim2.new(1, -28, 0, 8),
        Parent           = sliderFrame,
    })
    Utility:CreateCorner(trackBg, 4)

    local sliderFill = Utility:Create("Frame", {
        Name             = "Fill",
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel  = 0,
        Size             = UDim2.new((default - min) / (max - min), 0, 1, 0),
        Parent           = trackBg,
    })
    Utility:CreateCorner(sliderFill, 4)
    -- Gradient fill (dark → light, left to right)
    Utility:CreateGradient(sliderFill, self.Theme.AccentDark, self.Theme.AccentLight, 0)

    local sliderThumb = Utility:Create("Frame", {
        Name             = "Thumb",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0.5, 0.5),
        Position         = UDim2.new((default - min) / (max - min), 0, 0.5, 0),
        Size             = UDim2.new(0, 20, 0, 20),
        ZIndex           = 2,
        Parent           = trackBg,
    })
    Utility:CreateCorner(sliderThumb, 10)
    Utility:CreateShadow(sliderThumb, 0.22, 5)
    -- Accent-colored inner dot
    local thumbDot = Utility:Create("Frame", {
        AnchorPoint          = Vector2.new(0.5, 0.5),
        BackgroundColor3     = self.Theme.Accent,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0.5, 0, 0.5, 0),
        Size                 = UDim2.new(0, 8, 0, 8),
        ZIndex               = 3,
        Parent               = sliderThumb,
    })
    Utility:CreateCorner(thumbDot, 4)

    local dragging = false
    local function updateSlider(input)
        local pos   = math.clamp((input.Position.X - trackBg.AbsolutePosition.X) / trackBg.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * pos
        value = math.floor(value / increment + 0.5) * increment
        value = Utility:RoundNumber(value, #tostring(increment) - 2)
        value = math.clamp(value, min, max)
        local fillPct = (value - min) / (max - min)
        sliderFill.Size      = UDim2.new(fillPct, 0, 1, 0)
        sliderThumb.Position = UDim2.new(fillPct, 0, 0.5, 0)
        valueLabel.Text      = tostring(value) .. suffix
        if flag then self.Flags[flag] = value end
        callback(value)
    end

    trackBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
            Utility:Tween(sliderThumb, { Size = UDim2.new(0, 24, 0, 24) }, 0.15, Enum.EasingStyle.Back)
        end
    end)
    sliderThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Utility:Tween(sliderThumb, { Size = UDim2.new(0, 24, 0, 24) }, 0.15, Enum.EasingStyle.Back)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                Utility:Tween(sliderThumb, { Size = UDim2.new(0, 20, 0, 20) }, 0.15, Enum.EasingStyle.Back)
            end
            dragging = false
        end
    end)

    local Slider = {
        Frame = sliderFrame,
        Value = default,
        Set = function(_, value)
            value = math.clamp(math.floor(value / increment + 0.5) * increment, min, max)
            local fillPct = (value - min) / (max - min)
            sliderFill.Size      = UDim2.new(fillPct, 0, 1, 0)
            sliderThumb.Position = UDim2.new(fillPct, 0, 0.5, 0)
            valueLabel.Text      = tostring(value) .. suffix
            if flag then KimiUI.CurrentWindow.Flags[flag] = value end
            callback(value)
        end,
        Type = "Slider",
    }
    table.insert(self.Elements, Slider)
    return Slider
end

-- ─── Input ────────────────────────────────────────
function KimiUI:CreateInput(config, parent)
    config = config or {}
    local inputName  = config.Name or "Input"
    local placeholder= config.Placeholder or "Enter text..."
    local default    = config.Default or ""
    local callback   = config.Callback or function() end
    local inputType  = config.Type or "Default"
    local flag       = config.Flag or nil
    local icon       = config.Icon or nil

    if flag then self.Flags[flag] = default end

    local inputFrame = Utility:Create("Frame", {
        Name             = inputName .. "Input",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 72),
        Parent           = parent,
    })
    Utility:CreateCorner(inputFrame, 10)
    Utility:CreateStroke(inputFrame, self.Theme.Border, 1, 0.88)

    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 14, 0, 8),
        Size                   = UDim2.new(1, -28, 0, 20),
        Font                   = Enum.Font.GothamSemibold,
        Text                   = inputName,
        TextColor3             = self.Theme.Text,
        TextSize               = 14,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = inputFrame,
    })

    local boxOffset = 14
    local boxWidth  = -28
    if icon then
        Utility:Create("ImageLabel", {
            BackgroundTransparency = 1,
            Position               = UDim2.new(0, 14, 0, 36),
            Size                   = UDim2.new(0, 16, 0, 16),
            Image                  = icon,
            ImageColor3            = self.Theme.TextDark,
            Parent                 = inputFrame,
        })
        boxOffset = 38; boxWidth = -52
    end

    local inputBox = Utility:Create("TextBox", {
        Name                 = "InputBox",
        BackgroundColor3     = self.Theme.Primary,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0, boxOffset, 0, 34),
        Size                 = UDim2.new(1, boxWidth, 0, 30),
        Font                 = Enum.Font.Gotham,
        Text                 = default,
        TextColor3           = self.Theme.Text,
        PlaceholderText      = placeholder,
        PlaceholderColor3    = self.Theme.TextDarker,
        TextSize             = 13,
        ClearTextOnFocus     = false,
        Parent               = inputFrame,
    })
    Utility:CreateCorner(inputBox, 7)
    Utility:CreatePadding(inputBox, 10)

    local focusStroke = Utility:CreateStroke(inputBox, self.Theme.Accent, 2, 1)

    inputBox.Focused:Connect(function()
        Utility:Tween(focusStroke, { Transparency = 0.25 }, 0.2)
        Utility:Tween(inputBox, { BackgroundColor3 = self.Theme.Background }, 0.2)
    end)
    inputBox.FocusLost:Connect(function(enterPressed)
        Utility:Tween(focusStroke, { Transparency = 1 }, 0.2)
        Utility:Tween(inputBox, { BackgroundColor3 = self.Theme.Primary }, 0.2)
        local text = inputBox.Text
        if flag then self.Flags[flag] = text end
        callback(text, enterPressed)
    end)

    local Input = {
        Frame    = inputFrame,
        InputBox = inputBox,
        Value    = default,
        Set = function(_, value)
            inputBox.Text = value
            if flag then KimiUI.CurrentWindow.Flags[flag] = value end
        end,
        Type = "Input",
    }
    table.insert(self.Elements, Input)
    return Input
end

-- ─── Dropdown ─────────────────────────────────────
function KimiUI:CreateDropdown(config, parent)
    config = config or {}
    local dropdownName = config.Name or "Dropdown"
    local options      = config.Options or config.Values or {}
    local default      = config.Default or config.Value or (options[1] or "")
    local callback     = config.Callback or function() end
    local multiSelect  = config.MultiSelect or false
    local flag         = config.Flag or nil

    if flag then self.Flags[flag] = multiSelect and {default} or default end

    local dropdownFrame = Utility:Create("Frame", {
        Name             = dropdownName .. "Dropdown",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 72),
        ClipsDescendants = true,
        Parent           = parent,
    })
    Utility:CreateCorner(dropdownFrame, 10)
    Utility:CreateStroke(dropdownFrame, self.Theme.Border, 1, 0.88)

    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 14, 0, 8),
        Size                   = UDim2.new(1, -28, 0, 20),
        Font                   = Enum.Font.GothamSemibold,
        Text                   = dropdownName,
        TextColor3             = self.Theme.Text,
        TextSize               = 14,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = dropdownFrame,
    })

    local dropdownButton = Utility:Create("TextButton", {
        Name                 = "DropdownButton",
        BackgroundColor3     = self.Theme.Primary,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0, 14, 0, 34),
        Size                 = UDim2.new(1, -28, 0, 30),
        AutoButtonColor      = false,
        Font                 = Enum.Font.Gotham,
        Text                 = (default ~= "" and tostring(default)) or "Select...",
        TextColor3           = self.Theme.Text,
        TextSize             = 13,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = dropdownFrame,
    })
    Utility:CreateCorner(dropdownButton, 7)
    Utility:CreatePadding(dropdownButton, 10)

    local arrowIcon = Utility:Create("ImageLabel", {
        Name                 = "Arrow",
        BackgroundTransparency = 1,
        Position             = UDim2.new(1, -28, 0, 5),
        Size                 = UDim2.new(0, 18, 0, 18),
        Image                = "rbxassetid://7072706663",
        ImageColor3          = self.Theme.Accent,
        Parent               = dropdownButton,
    })

    local optionsFrame = Utility:Create("Frame", {
        Name             = "Options",
        BackgroundColor3 = self.Theme.Primary,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 14, 0, 70),
        Size             = UDim2.new(1, -28, 0, 0),
        ClipsDescendants = true,
        Visible          = false,
        Parent           = dropdownFrame,
    })
    Utility:CreateCorner(optionsFrame, 8)
    Utility:CreateStroke(optionsFrame, self.Theme.Border, 1, 0.75)

    local optionsLayout = Utility:CreateListLayout(optionsFrame, 3)
    Utility:CreatePadding(optionsFrame, 6)

    local selectedValues = multiSelect and {default} or default
    local isOpen = false

    local function toggleDropdown()
        isOpen = not isOpen
        if isOpen then
            optionsFrame.Visible = true
            local totalHeight = math.min(#options * 33 + 12, 180)
            Utility:Tween(dropdownFrame, { Size = UDim2.new(1, 0, 0, 78 + totalHeight) }, 0.3, Enum.EasingStyle.Quart)
            Utility:Tween(optionsFrame, { Size = UDim2.new(1, -28, 0, totalHeight) }, 0.3, Enum.EasingStyle.Quart)
            Utility:Tween(arrowIcon, { Rotation = 180 }, 0.3, Enum.EasingStyle.Quart)
        else
            Utility:Tween(dropdownFrame, { Size = UDim2.new(1, 0, 0, 72) }, 0.3, Enum.EasingStyle.Quart)
            Utility:Tween(optionsFrame, { Size = UDim2.new(1, -28, 0, 0) }, 0.3, Enum.EasingStyle.Quart)
            Utility:Tween(arrowIcon, { Rotation = 0 }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function()
                optionsFrame.Visible = false
            end)
        end
    end
    dropdownButton.MouseButton1Click:Connect(toggleDropdown)

    for _, option in pairs(options) do
        local optionButton = Utility:Create("TextButton", {
            Name             = tostring(option) .. "Option",
            BackgroundColor3 = self.Theme.Primary,
            BorderSizePixel  = 0,
            Size             = UDim2.new(1, -12, 0, 30),
            AutoButtonColor  = false,
            Font             = Enum.Font.Gotham,
            Text             = tostring(option),
            TextColor3       = self.Theme.TextDark,
            TextSize         = 13,
            Parent           = optionsFrame,
        })
        Utility:CreateCorner(optionButton, 6)

        local checkmark = Utility:Create("ImageLabel", {
            Name                 = "Checkmark",
            BackgroundTransparency = 1,
            Position             = UDim2.new(1, -26, 0, 7),
            Size                 = UDim2.new(0, 16, 0, 16),
            Image                = "rbxassetid://7733973319",
            ImageColor3          = self.Theme.Accent,
            ImageTransparency    = 1,
            Parent               = optionButton,
        })

        optionButton.MouseEnter:Connect(function()
            Utility:Tween(optionButton, { BackgroundColor3 = self.Theme.Foreground, TextColor3 = self.Theme.Text }, 0.18)
        end)
        optionButton.MouseLeave:Connect(function()
            Utility:Tween(optionButton, { BackgroundColor3 = self.Theme.Primary, TextColor3 = self.Theme.TextDark }, 0.18)
        end)
        optionButton.MouseButton1Click:Connect(function()
            if multiSelect then
                local idx = table.find(selectedValues, option)
                if idx then
                    table.remove(selectedValues, idx)
                    Utility:Tween(checkmark, { ImageTransparency = 1 }, 0.15)
                else
                    table.insert(selectedValues, option)
                    Utility:Tween(checkmark, { ImageTransparency = 0 }, 0.15)
                end
                dropdownButton.Text = #selectedValues > 0 and table.concat(selectedValues, ", ") or "Select..."
            else
                selectedValues = option
                dropdownButton.Text = tostring(option)
                for _, child in pairs(optionsFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        local cm = child:FindFirstChild("Checkmark")
                        if cm then Utility:Tween(cm, { ImageTransparency = 1 }, 0.15) end
                    end
                end
                Utility:Tween(checkmark, { ImageTransparency = 0 }, 0.15)
                toggleDropdown()
            end
            if flag then self.Flags[flag] = selectedValues end
            callback(selectedValues)
        end)
    end

    local Dropdown = {
        Frame = dropdownFrame, Value = selectedValues, Options = options,
        Set = function(_, value)
            selectedValues = value
            dropdownButton.Text = multiSelect
                and (#selectedValues > 0 and table.concat(selectedValues, ", ") or "Select...")
                or  tostring(value)
            if flag then KimiUI.CurrentWindow.Flags[flag] = selectedValues end
            callback(selectedValues)
        end,
        Refresh = function(_, newOptions)
            for _, child in pairs(optionsFrame:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
        end,
        Type = "Dropdown",
    }
    table.insert(self.Elements, Dropdown)
    return Dropdown
end

-- ─── Paragraph ────────────────────────────────────
function KimiUI:CreateParagraph(config, parent)
    config = config or {}
    local title   = config.Title or config.Name or ""
    local content = config.Content or config.Text or ""
    local align   = config.Align or Enum.TextXAlignment.Left

    local paragraphFrame = Utility:Create("Frame", {
        Name             = (title ~= "" and title or "Paragraph") .. "Paragraph",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        Parent           = parent,
    })
    Utility:CreateCorner(paragraphFrame, 10)
    Utility:CreateStroke(paragraphFrame, self.Theme.Border, 1, 0.88)

    local contentY = 12
    if title ~= "" then
        Utility:Create("TextLabel", {
            Name                 = "Title",
            BackgroundTransparency = 1,
            Position             = UDim2.new(0, 14, 0, 12),
            Size                 = UDim2.new(1, -28, 0, 20),
            Font                 = Enum.Font.GothamBlack,
            Text                 = title,
            TextColor3           = self.Theme.AccentLight,
            TextSize             = 14,
            TextXAlignment       = align,
            Parent               = paragraphFrame,
        })
        contentY = 34
    end
    local contentLabel = Utility:Create("TextLabel", {
        Name                 = "Content",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 14, 0, contentY),
        Size                 = UDim2.new(1, -28, 0, 0),
        AutomaticSize        = Enum.AutomaticSize.Y,
        Font                 = Enum.Font.Gotham,
        Text                 = content,
        TextColor3           = self.Theme.TextDark,
        TextSize             = 13,
        TextXAlignment       = align,
        TextWrapped          = true,
        Parent               = paragraphFrame,
    })
    local textHeight = TextService:GetTextSize(content, 13, Enum.Font.Gotham, Vector2.new(paragraphFrame.AbsoluteSize.X - 28, 999)).Y
    paragraphFrame.Size = UDim2.new(1, 0, 0, contentY + textHeight + 16)

    local Paragraph = {
        Frame = paragraphFrame,
        Set = function(_, text)
            contentLabel.Text = text
            local h = TextService:GetTextSize(text, 13, Enum.Font.Gotham, Vector2.new(paragraphFrame.AbsoluteSize.X - 28, 999)).Y
            paragraphFrame.Size = UDim2.new(1, 0, 0, contentY + h + 16)
        end,
        Type = "Paragraph",
    }
    table.insert(self.Elements, Paragraph)
    return Paragraph
end

-- ─── Keybind ──────────────────────────────────────
function KimiUI:CreateKeybind(config, parent)
    config = config or {}
    local keybindName = config.Name or "Keybind"
    local defaultKey  = config.Default or config.Key or Enum.KeyCode.Unknown
    local callback    = config.Callback or function() end
    local onHold      = config.Hold or false
    local flag        = config.Flag or nil

    if typeof(defaultKey) == "string" then
        defaultKey = Enum.KeyCode[defaultKey] or Enum.KeyCode.Unknown
    end
    if flag then self.Flags[flag] = defaultKey end

    local keybindFrame = Utility:Create("Frame", {
        Name             = keybindName .. "Keybind",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 44),
        Parent           = parent,
    })
    Utility:CreateCorner(keybindFrame, 10)
    Utility:CreateStroke(keybindFrame, self.Theme.Border, 1, 0.88)

    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 14, 0, 0),
        Size                   = UDim2.new(1, -140, 1, 0),
        Font                   = Enum.Font.GothamSemibold,
        Text                   = keybindName,
        TextColor3             = self.Theme.Text,
        TextSize               = 14,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = keybindFrame,
    })

    local keybindButton = Utility:Create("TextButton", {
        Name                 = "KeyButton",
        BackgroundColor3     = self.Theme.Primary,
        BorderSizePixel      = 0,
        Position             = UDim2.new(1, -112, 0.5, -14),
        Size                 = UDim2.new(0, 80, 0, 28),
        AutoButtonColor      = false,
        Font                 = Enum.Font.GothamBold,
        Text                 = defaultKey ~= Enum.KeyCode.Unknown and defaultKey.Name or "None",
        TextColor3           = self.Theme.TextDark,
        TextSize             = 12,
        Parent               = keybindFrame,
    })
    Utility:CreateCorner(keybindButton, 7)
    Utility:CreateStroke(keybindButton, self.Theme.Border, 1, 0.7)

    local clearBtn = Utility:Create("TextButton", {
        Name                 = "Clear",
        BackgroundTransparency = 1,
        Position             = UDim2.new(1, -28, 0.5, -11),
        Size                 = UDim2.new(0, 22, 0, 22),
        Font                 = Enum.Font.GothamBold,
        Text                 = "×",
        TextColor3           = self.Theme.Error,
        TextSize             = 18,
        Parent               = keybindFrame,
    })
    clearBtn.MouseEnter:Connect(function() Utility:Tween(clearBtn, { TextColor3 = Utility:Brighten(self.Theme.Error, 0.1) }, 0.15) end)
    clearBtn.MouseLeave:Connect(function() Utility:Tween(clearBtn, { TextColor3 = self.Theme.Error }, 0.15) end)

    local listening = false
    local currentKey = defaultKey

    keybindButton.MouseButton1Click:Connect(function()
        listening = true
        keybindButton.Text = "..."
        Utility:Tween(keybindButton, { BackgroundColor3 = self.Theme.Accent }, 0.2)
        keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    clearBtn.MouseButton1Click:Connect(function()
        currentKey = Enum.KeyCode.Unknown
        keybindButton.Text = "None"
        if flag then self.Flags[flag] = currentKey end
    end)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Delete or input.KeyCode == Enum.KeyCode.Backspace then
                    currentKey = Enum.KeyCode.Unknown; keybindButton.Text = "None"
                else
                    currentKey = input.KeyCode; keybindButton.Text = input.KeyCode.Name
                end
                listening = false
                Utility:Tween(keybindButton, { BackgroundColor3 = self.Theme.Primary }, 0.2)
                keybindButton.TextColor3 = self.Theme.TextDark
                if flag then self.Flags[flag] = currentKey end
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                currentKey = "MouseButton1"; keybindButton.Text = "MB1"
                listening = false
                Utility:Tween(keybindButton, { BackgroundColor3 = self.Theme.Primary }, 0.2)
                keybindButton.TextColor3 = self.Theme.TextDark
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                currentKey = "MouseButton2"; keybindButton.Text = "MB2"
                listening = false
                Utility:Tween(keybindButton, { BackgroundColor3 = self.Theme.Primary }, 0.2)
                keybindButton.TextColor3 = self.Theme.TextDark
            end
        elseif not gameProcessed then
            local keyMatch = false
            if typeof(currentKey) == "EnumItem" and input.KeyCode == currentKey then keyMatch = true
            elseif currentKey == "MouseButton1" and input.UserInputType == Enum.UserInputType.MouseButton1 then keyMatch = true
            elseif currentKey == "MouseButton2" and input.UserInputType == Enum.UserInputType.MouseButton2 then keyMatch = true
            end
            if keyMatch then
                if onHold then callback(true) else callback() end
            end
        end
    end)
    if onHold then
        UserInputService.InputEnded:Connect(function(input)
            local keyMatch = false
            if typeof(currentKey) == "EnumItem" and input.KeyCode == currentKey then keyMatch = true
            elseif currentKey == "MouseButton1" and input.UserInputType == Enum.UserInputType.MouseButton1 then keyMatch = true
            elseif currentKey == "MouseButton2" and input.UserInputType == Enum.UserInputType.MouseButton2 then keyMatch = true
            end
            if keyMatch then callback(false) end
        end)
    end

    local Keybind = {
        Frame = keybindFrame, Key = currentKey,
        Set = function(_, key)
            if typeof(key) == "string" then key = Enum.KeyCode[key] or key end
            currentKey = key
            keybindButton.Text = typeof(key) == "EnumItem" and key.Name or tostring(key)
            if flag then KimiUI.CurrentWindow.Flags[flag] = currentKey end
        end,
        Type = "Keybind",
    }
    table.insert(self.Elements, Keybind)
    return Keybind
end

-- ─── Colorpicker ──────────────────────────────────
function KimiUI:CreateColorpicker(config, parent)
    config = config or {}
    local colorpickerName = config.Name or "Colorpicker"
    local defaultColor    = config.Default or config.Color or Color3.fromRGB(139, 92, 246)
    local callback        = config.Callback or function() end
    local flag            = config.Flag or nil

    if flag then self.Flags[flag] = defaultColor end
    local h, s, v = Color3.toHSV(defaultColor)

    local colorpickerFrame = Utility:Create("Frame", {
        Name             = colorpickerName .. "Colorpicker",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 44),
        ClipsDescendants = true,
        Parent           = parent,
    })
    Utility:CreateCorner(colorpickerFrame, 10)
    Utility:CreateStroke(colorpickerFrame, self.Theme.Border, 1, 0.88)

    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 14, 0, 0),
        Size                   = UDim2.new(1, -80, 1, 0),
        Font                   = Enum.Font.GothamSemibold,
        Text                   = colorpickerName,
        TextColor3             = self.Theme.Text,
        TextSize               = 14,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = colorpickerFrame,
    })

    local colorPreview = Utility:Create("TextButton", {
        Name                 = "ColorPreview",
        BackgroundColor3     = defaultColor,
        BorderSizePixel      = 0,
        Position             = UDim2.new(1, -54, 0.5, -14),
        Size                 = UDim2.new(0, 46, 0, 28),
        AutoButtonColor      = false,
        Text                 = "",
        Parent               = colorpickerFrame,
    })
    Utility:CreateCorner(colorPreview, 8)
    Utility:CreateStroke(colorPreview, self.Theme.Border, 2, 0.4)

    local pickerFrame = Utility:Create("Frame", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 14, 0, 52),
        Size                   = UDim2.new(1, -28, 0, 195),
        Parent                 = colorpickerFrame,
    })

    local svFrame = Utility:Create("Frame", {
        BackgroundColor3 = Color3.fromHSV(h, 1, 1),
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, -34, 0, 130),
        Parent           = pickerFrame,
    })
    Utility:CreateCorner(svFrame, 8)
    Utility:Create("UIGradient", {
        Color        = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255)) }),
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }),
        Parent       = svFrame,
    })
    Utility:Create("UIGradient", {
        Color        = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)) }),
        Rotation     = 180,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }),
        Parent       = svFrame,
    })

    local svCursor = Utility:Create("Frame", {
        AnchorPoint      = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel  = 0,
        Position         = UDim2.new(s, 0, 1 - v, 0),
        Size             = UDim2.new(0, 14, 0, 14),
        Parent           = svFrame,
    })
    Utility:CreateCorner(svCursor, 7)
    Utility:CreateStroke(svCursor, Color3.fromRGB(0, 0, 0), 2)

    local hueFrame = Utility:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel  = 0,
        Position         = UDim2.new(1, -26, 0, 0),
        Size             = UDim2.new(0, 22, 0, 130),
        Parent           = pickerFrame,
    })
    Utility:CreateCorner(hueFrame, 8)
    Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,     Color3.fromRGB(255, 0,   0)),
            ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0,   255, 0)),
            ColorSequenceKeypoint.new(0.5,   Color3.fromRGB(0,   255, 255)),
            ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0,   0,   255)),
            ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0,   255)),
            ColorSequenceKeypoint.new(1,     Color3.fromRGB(255, 0,   0)),
        }),
        Rotation = 90,
        Parent   = hueFrame,
    })

    local hueCursor = Utility:Create("Frame", {
        AnchorPoint      = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel  = 0,
        Position         = UDim2.new(0.5, 0, 1 - h, 0),
        Size             = UDim2.new(1, 4, 0, 8),
        Parent           = hueFrame,
    })
    Utility:CreateCorner(hueCursor, 4)
    Utility:CreateStroke(hueCursor, Color3.fromRGB(0, 0, 0), 1.5)

    -- RGB/HEX inputs
    local inputsFrame = Utility:Create("Frame", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 0, 0, 138),
        Size                   = UDim2.new(1, -34, 0, 30),
        Parent                 = pickerFrame,
    })
    local r, g, b = math.floor(defaultColor.R * 255), math.floor(defaultColor.G * 255), math.floor(defaultColor.B * 255)
    local rgbBox = Utility:Create("TextBox", {
        BackgroundColor3 = self.Theme.Primary,
        BorderSizePixel  = 0,
        Size             = UDim2.new(0.48, 0, 1, 0),
        Font             = Enum.Font.GothamBold,
        Text             = string.format("%d, %d, %d", r, g, b),
        TextColor3       = self.Theme.Text,
        TextSize         = 11,
        Parent           = inputsFrame,
    })
    Utility:CreateCorner(rgbBox, 5)
    local hexBox = Utility:Create("TextBox", {
        BackgroundColor3 = self.Theme.Primary,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0.52, 0, 0, 0),
        Size             = UDim2.new(0.48, 0, 1, 0),
        Font             = Enum.Font.GothamBold,
        Text             = string.format("#%02X%02X%02X", r, g, b),
        TextColor3       = self.Theme.AccentLight,
        TextSize         = 11,
        Parent           = inputsFrame,
    })
    Utility:CreateCorner(hexBox, 5)

    local isOpen = false
    local svDragging, hueDragging = false, false

    local function updateColor()
        local newColor = Color3.fromHSV(h, s, v)
        colorPreview.BackgroundColor3 = newColor
        svFrame.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        local nr, ng, nb = math.floor(newColor.R * 255), math.floor(newColor.G * 255), math.floor(newColor.B * 255)
        rgbBox.Text = string.format("%d, %d, %d", nr, ng, nb)
        hexBox.Text = string.format("#%02X%02X%02X", nr, ng, nb)
        if flag then self.Flags[flag] = newColor end
        callback(newColor)
    end

    colorPreview.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Utility:Tween(colorpickerFrame, { Size = UDim2.new(1, 0, 0, isOpen and 256 or 44) }, 0.3, Enum.EasingStyle.Quart)
    end)

    svFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            svDragging = true
            s = math.clamp((input.Position.X - svFrame.AbsolutePosition.X) / svFrame.AbsoluteSize.X, 0, 1)
            v = 1 - math.clamp((input.Position.Y - svFrame.AbsolutePosition.Y) / svFrame.AbsoluteSize.Y, 0, 1)
            svCursor.Position = UDim2.new(s, 0, 1 - v, 0); updateColor()
        end
    end)
    hueFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            hueDragging = true
            h = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
            hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0); updateColor()
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if svDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            s = math.clamp((input.Position.X - svFrame.AbsolutePosition.X) / svFrame.AbsoluteSize.X, 0, 1)
            v = 1 - math.clamp((input.Position.Y - svFrame.AbsolutePosition.Y) / svFrame.AbsoluteSize.Y, 0, 1)
            svCursor.Position = UDim2.new(s, 0, 1 - v, 0); updateColor()
        elseif hueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            h = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
            hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0); updateColor()
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            svDragging = false; hueDragging = false
        end
    end)

    local Colorpicker = {
        Frame = colorpickerFrame, Color = defaultColor,
        Set = function(_, color)
            h, s, v = Color3.toHSV(color)
            svCursor.Position  = UDim2.new(s, 0, 1 - v, 0)
            hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0)
            updateColor()
        end,
        Type = "Colorpicker",
    }
    table.insert(self.Elements, Colorpicker)
    return Colorpicker
end

-- ─── Code Display ─────────────────────────────────
function KimiUI:CreateCode(config, parent)
    config = config or {}
    local codeText        = config.Code or config.Text or ""
    local language        = config.Language or "lua"
    local showLineNumbers = config.LineNumbers ~= false

    local codeFrame = Utility:Create("Frame", {
        Name             = "CodeDisplay",
        BackgroundColor3 = self.Theme.Primary,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        Parent           = parent,
    })
    Utility:CreateCorner(codeFrame, 12)
    Utility:CreateStroke(codeFrame, self.Theme.BorderLight, 1, 0.7)

    local codeHeader = Utility:Create("Frame", {
        Name             = "Header",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 36),
        Parent           = codeFrame,
    })
    Utility:CreateCorner(codeHeader, 12)
    -- Fix bottom corners
    Utility:Create("Frame", {
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 0, 0.5, 0),
        Size             = UDim2.new(1, 0, 0.5, 0),
        Parent           = codeHeader,
    })

    -- Language dots (like a terminal title bar)
    local dot = function(xOffset, color)
        local d = Utility:Create("Frame", {
            BackgroundColor3 = color,
            BorderSizePixel  = 0,
            Position         = UDim2.new(0, xOffset, 0.5, -5),
            Size             = UDim2.new(0, 10, 0, 10),
            Parent           = codeHeader,
        })
        Utility:CreateCorner(d, 5)
    end
    dot(12, Color3.fromRGB(255, 95, 87))
    dot(28, Color3.fromRGB(255, 189, 46))
    dot(44, Color3.fromRGB(40, 205, 65))

    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 68, 0, 0),
        Size                   = UDim2.new(0, 100, 1, 0),
        Font                   = Enum.Font.GothamBold,
        Text                   = language:upper(),
        TextColor3             = self.Theme.AccentLight,
        TextSize               = 12,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = codeHeader,
    })

    local copyBtn = Utility:Create("TextButton", {
        Name                 = "Copy",
        BackgroundColor3     = self.Theme.Accent,
        BackgroundTransparency = 0.75,
        BorderSizePixel      = 0,
        Position             = UDim2.new(1, -76, 0.5, -13),
        Size                 = UDim2.new(0, 68, 0, 26),
        AutoButtonColor      = false,
        Font                 = Enum.Font.GothamBold,
        Text                 = "⎘ Copy",
        TextColor3           = self.Theme.AccentLight,
        TextSize             = 11,
        Parent               = codeHeader,
    })
    Utility:CreateCorner(copyBtn, 6)
    copyBtn.MouseEnter:Connect(function() Utility:Tween(copyBtn, { BackgroundTransparency = 0.5 }, 0.15) end)
    copyBtn.MouseLeave:Connect(function() Utility:Tween(copyBtn, { BackgroundTransparency = 0.75 }, 0.15) end)
    copyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(codeText)
            copyBtn.Text = "✓ Copied!"
            task.wait(1.5)
            copyBtn.Text = "⎘ Copy"
        end
    end)

    local lineHeight    = 18
    local lineNumWidth  = showLineNumbers and 40 or 0
    if showLineNumbers then
        local lineNumsFrame = Utility:Create("Frame", {
            BackgroundTransparency = 1,
            Position               = UDim2.new(0, 0, 0, 40),
            Size                   = UDim2.new(0, 40, 1, -44),
            Parent                 = codeFrame,
        })
        local lines = string.split(codeText, "\n")
        for i = 1, #lines do
            Utility:Create("TextLabel", {
                BackgroundTransparency = 1,
                Position               = UDim2.new(0, 0, 0, (i - 1) * lineHeight),
                Size                   = UDim2.new(1, -6, 0, lineHeight),
                Font                   = Enum.Font.Code,
                Text                   = tostring(i),
                TextColor3             = self.Theme.TextDarker,
                TextSize               = 12,
                TextXAlignment         = Enum.TextXAlignment.Right,
                Parent                 = lineNumsFrame,
            })
        end
        codeFrame.Size = UDim2.new(1, 0, 0, 48 + (#lines * lineHeight) + 10)
        -- Line divider
        Utility:Create("Frame", {
            BackgroundColor3 = self.Theme.Border,
            BorderSizePixel  = 0,
            Position         = UDim2.new(0, 40, 0, 40),
            Size             = UDim2.new(0, 1, 1, -44),
            Parent           = codeFrame,
        })
    end

    Utility:Create("TextLabel", {
        Name                 = "Code",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, lineNumWidth + 12, 0, 40),
        Size                 = UDim2.new(1, -lineNumWidth - 16, 1, -44),
        Font                 = Enum.Font.Code,
        Text                 = codeText,
        TextColor3           = self.Theme.Text,
        TextSize             = 13,
        TextXAlignment       = Enum.TextXAlignment.Left,
        TextYAlignment       = Enum.TextYAlignment.Top,
        TextWrapped          = true,
        Parent               = codeFrame,
    })

    local Code = { Frame = codeFrame, Code = codeText, Type = "Code" }
    table.insert(self.Elements, Code)
    return Code
end

-- ─── Advanced (Collapsible) ────────────────────────
function KimiUI:CreateAdvanced(config, parent)
    config = config or {}
    local advancedName = config.Name or "Advanced"
    local advancedDesc = config.Description or ""
    local defaultOpen  = config.DefaultOpen or false

    local advancedFrame = Utility:Create("Frame", {
        Name             = advancedName .. "Advanced",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 48),
        ClipsDescendants = true,
        Parent           = parent,
    })
    Utility:CreateCorner(advancedFrame, 10)
    Utility:CreateStroke(advancedFrame, self.Theme.Border, 1, 0.85)

    local headerButton = Utility:Create("TextButton", {
        Name                 = "Header",
        BackgroundTransparency = 1,
        Size                 = UDim2.new(1, 0, 0, 48),
        AutoButtonColor      = false,
        Text                 = "",
        Parent               = advancedFrame,
    })

    Utility:Create("TextLabel", {
        Name                 = "Title",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 14, 0, defaultOpen and 8 or 14),
        Size                 = UDim2.new(1, -52, 0, 20),
        Font                 = Enum.Font.GothamBlack,
        Text                 = advancedName,
        TextColor3           = self.Theme.Text,
        TextSize             = 13,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = headerButton,
    })

    if advancedDesc ~= "" then
        Utility:Create("TextLabel", {
            Name                 = "Description",
            BackgroundTransparency = 1,
            Position             = UDim2.new(0, 14, 0, 26),
            Size                 = UDim2.new(1, -52, 0, 16),
            Font                 = Enum.Font.Gotham,
            Text                 = advancedDesc,
            TextColor3           = self.Theme.TextDarker,
            TextSize             = 11,
            TextXAlignment       = Enum.TextXAlignment.Left,
            Parent               = headerButton,
        })
    end

    local arrowIcon = Utility:Create("ImageLabel", {
        Name                 = "Arrow",
        BackgroundTransparency = 1,
        Position             = UDim2.new(1, -38, 0, 12),
        Size                 = UDim2.new(0, 24, 0, 24),
        Image                = "rbxassetid://7072706663",
        ImageColor3          = self.Theme.Accent,
        Rotation             = defaultOpen and 180 or 0,
        Parent               = headerButton,
    })

    local contentFrame = Utility:Create("Frame", {
        Name                 = "Content",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 0, 0, 52),
        Size                 = UDim2.new(1, 0, 0, 0),
        Parent               = advancedFrame,
    })
    local contentLayout = Utility:CreateListLayout(contentFrame, 8)
    Utility:CreatePadding(contentFrame, 10)

    local isOpen = defaultOpen
    headerButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Utility:Tween(arrowIcon, { Rotation = isOpen and 180 or 0 }, 0.3, Enum.EasingStyle.Quart)
        if isOpen then
            local h = contentLayout.AbsoluteContentSize.Y + 20
            Utility:Tween(advancedFrame, { Size = UDim2.new(1, 0, 0, 56 + h) }, 0.3, Enum.EasingStyle.Quart)
            Utility:Tween(contentFrame, { Size = UDim2.new(1, 0, 0, h) }, 0.3, Enum.EasingStyle.Quart)
        else
            Utility:Tween(advancedFrame, { Size = UDim2.new(1, 0, 0, 48) }, 0.3, Enum.EasingStyle.Quart)
            Utility:Tween(contentFrame, { Size = UDim2.new(1, 0, 0, 0) }, 0.3, Enum.EasingStyle.Quart)
        end
    end)
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if isOpen then
            local h = contentLayout.AbsoluteContentSize.Y + 20
            advancedFrame.Size = UDim2.new(1, 0, 0, 56 + h)
            contentFrame.Size  = UDim2.new(1, 0, 0, h)
        end
    end)
    if defaultOpen then
        task.wait()
        local h = contentLayout.AbsoluteContentSize.Y + 20
        advancedFrame.Size = UDim2.new(1, 0, 0, 56 + h)
        contentFrame.Size  = UDim2.new(1, 0, 0, h)
    end

    local Advanced = {
        Frame    = advancedFrame,
        Content  = contentFrame,
        IsOpen   = isOpen,
        AddButton     = function(_, c) return KimiUI.CurrentWindow:CreateButton(c, contentFrame) end,
        AddToggle     = function(_, c) return KimiUI.CurrentWindow:CreateToggle(c, contentFrame) end,
        AddSlider     = function(_, c) return KimiUI.CurrentWindow:CreateSlider(c, contentFrame) end,
        AddInput      = function(_, c) return KimiUI.CurrentWindow:CreateInput(c, contentFrame) end,
        AddDropdown   = function(_, c) return KimiUI.CurrentWindow:CreateDropdown(c, contentFrame) end,
        AddParagraph  = function(_, c) return KimiUI.CurrentWindow:CreateParagraph(c, contentFrame) end,
        AddKeybind    = function(_, c) return KimiUI.CurrentWindow:CreateKeybind(c, contentFrame) end,
        AddColorpicker= function(_, c) return KimiUI.CurrentWindow:CreateColorpicker(c, contentFrame) end,
        AddCode       = function(_, c) return KimiUI.CurrentWindow:CreateCode(c, contentFrame) end,
        Type = "Advanced",
    }
    table.insert(self.Elements, Advanced)
    return Advanced
end

-- ─── Divider ──────────────────────────────────────
function KimiUI:CreateDivider(config, parent)
    config = config or {}
    local label = config.Label or ""

    local divFrame = Utility:Create("Frame", {
        Name                 = "Divider",
        BackgroundTransparency = 1,
        Size                 = UDim2.new(1, 0, 0, 20),
        Parent               = parent,
    })

    if label ~= "" then
        local labelWidth = TextService:GetTextSize(label, 11, Enum.Font.GothamBold, Vector2.new(999, 999)).X + 16
        Utility:Create("Frame", {
            BackgroundColor3 = self.Theme.Border,
            BorderSizePixel  = 0,
            Position         = UDim2.new(0, 0, 0.5, 0),
            Size             = UDim2.new(0.5, -labelWidth/2 - 8, 0, 1),
            Parent           = divFrame,
        })
        Utility:Create("TextLabel", {
            BackgroundTransparency = 1,
            AnchorPoint            = Vector2.new(0.5, 0.5),
            Position               = UDim2.new(0.5, 0, 0.5, 0),
            Size                   = UDim2.new(0, labelWidth, 1, 0),
            Font                   = Enum.Font.GothamBold,
            Text                   = label,
            TextColor3             = self.Theme.TextDarker,
            TextSize               = 11,
            Parent                 = divFrame,
        })
        Utility:Create("Frame", {
            BackgroundColor3 = self.Theme.Border,
            BorderSizePixel  = 0,
            AnchorPoint      = Vector2.new(1, 0),
            Position         = UDim2.new(1, 0, 0.5, 0),
            Size             = UDim2.new(0.5, -labelWidth/2 - 8, 0, 1),
            Parent           = divFrame,
        })
    else
        local line = Utility:Create("Frame", {
            BackgroundColor3 = self.Theme.Border,
            BorderSizePixel  = 0,
            Position         = UDim2.new(0, 0, 0.5, 0),
            Size             = UDim2.new(1, 0, 0, 1),
            Parent           = divFrame,
        })
        Utility:CreateGradient(line, Color3.fromRGB(0,0,0), self.Theme.Accent, 0, 1, 0.6)
    end

    return { Frame = divFrame, Type = "Divider" }
end

-- ═══════════════════════════════════════════════════
--  NOTIFICATION SYSTEM  (Premium Style)
-- ═══════════════════════════════════════════════════
function KimiUI:Notify(config)
    config = config or {}
    local notifyTitle   = config.Title or "Notification"
    local notifyContent = config.Content or config.Message or config.Text or ""
    local notifyType    = config.Type or "Info"
    local duration      = config.Duration or 5

    local notifyGui = Utility:Create("ScreenGui", {
        Name         = "KimiUINotification",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent       = self.ScreenGui.Parent,
    })

    local typeColors = {
        Info    = self.Theme.Info,
        Success = self.Theme.Success,
        Warning = self.Theme.Warning,
        Error   = self.Theme.Error,
    }
    local typeIcons = {
        Info    = "rbxassetid://7733970536",
        Success = "rbxassetid://7733973319",
        Warning = "rbxassetid://7733956188",
        Error   = "rbxassetid://7733951820",
    }
    local typeColor = typeColors[notifyType] or self.Theme.Info

    local notifFrame = Utility:Create("Frame", {
        Name             = "Notification",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel  = 0,
        Position         = UDim2.new(1, 20, 1, -120),
        Size             = UDim2.new(0, 340, 0, 92),
        Parent           = notifyGui,
    })
    Utility:CreateCorner(notifFrame, 12)
    Utility:CreateShadow(notifFrame, 0.3, 18)
    Utility:CreateStroke(notifFrame, typeColor, 1, 0.8)

    -- Subtle background gradient
    Utility:CreateGradient(notifFrame, Utility:Brighten(self.Theme.Secondary, 0.03), self.Theme.Secondary, 90)

    -- Left color accent bar (wider, gradient)
    local colorBar = Utility:Create("Frame", {
        Name             = "ColorBar",
        BackgroundColor3 = typeColor,
        BorderSizePixel  = 0,
        Size             = UDim2.new(0, 5, 1, 0),
        Parent           = notifFrame,
    })
    Utility:CreateCorner(colorBar, 12)
    Utility:Create("Frame", {
        BackgroundColor3 = typeColor,
        BorderSizePixel  = 0,
        Position         = UDim2.new(1, -5, 0, 0),
        Size             = UDim2.new(0, 5, 1, 0),
        Parent           = colorBar,
    })
    Utility:CreateGradient(colorBar, Utility:Brighten(typeColor, 0.12), typeColor, 90)

    -- Glow behind bar
    Utility:Create("Frame", {
        BackgroundColor3     = typeColor,
        BackgroundTransparency = 0.72,
        BorderSizePixel      = 0,
        Size                 = UDim2.new(0, 14, 1, 0),
        Parent               = notifFrame,
    })

    -- Icon with circular bg
    local iconBg = Utility:Create("Frame", {
        BackgroundColor3     = typeColor,
        BackgroundTransparency = 0.8,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0, 22, 0, 18),
        Size                 = UDim2.new(0, 30, 0, 30),
        Parent               = notifFrame,
    })
    Utility:CreateCorner(iconBg, 8)
    Utility:Create("ImageLabel", {
        BackgroundTransparency = 1,
        AnchorPoint            = Vector2.new(0.5, 0.5),
        Position               = UDim2.new(0.5, 0, 0.5, 0),
        Size                   = UDim2.new(0, 20, 0, 20),
        Image                  = typeIcons[notifyType] or typeIcons.Info,
        ImageColor3            = typeColor,
        Parent                 = iconBg,
    })

    -- Title
    Utility:Create("TextLabel", {
        Name                 = "Title",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 62, 0, 14),
        Size                 = UDim2.new(1, -96, 0, 22),
        Font                 = Enum.Font.GothamBlack,
        Text                 = notifyTitle,
        TextColor3           = self.Theme.Text,
        TextSize             = 14,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = notifFrame,
    })

    -- Content
    Utility:Create("TextLabel", {
        Name                 = "Content",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 62, 0, 38),
        Size                 = UDim2.new(1, -76, 0, 38),
        Font                 = Enum.Font.Gotham,
        Text                 = notifyContent,
        TextColor3           = self.Theme.TextDark,
        TextSize             = 12,
        TextXAlignment       = Enum.TextXAlignment.Left,
        TextWrapped          = true,
        Parent               = notifFrame,
    })

    -- Close button
    local closeBtn = Utility:Create("TextButton", {
        Name                 = "Close",
        BackgroundTransparency = 1,
        Position             = UDim2.new(1, -30, 0, 8),
        Size                 = UDim2.new(0, 22, 0, 22),
        Font                 = Enum.Font.GothamBold,
        Text                 = "×",
        TextColor3           = self.Theme.TextDark,
        TextSize             = 20,
        Parent               = notifFrame,
    })
    closeBtn.MouseEnter:Connect(function() Utility:Tween(closeBtn, { TextColor3 = self.Theme.Error }, 0.15) end)
    closeBtn.MouseLeave:Connect(function() Utility:Tween(closeBtn, { TextColor3 = self.Theme.TextDark }, 0.15) end)

    -- Progress bar countdown
    local progressTrack = Utility:Create("Frame", {
        Name             = "ProgressTrack",
        BackgroundColor3 = self.Theme.Border,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 0, 1, -4),
        Size             = UDim2.new(1, 0, 0, 4),
        Parent           = notifFrame,
    })
    Utility:CreateCorner(progressTrack, 2)
    local progressBar = Utility:Create("Frame", {
        Name             = "ProgressBar",
        BackgroundColor3 = typeColor,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 1, 0),
        Parent           = progressTrack,
    })
    Utility:CreateCorner(progressBar, 2)
    Utility:CreateGradient(progressBar, Utility:Brighten(typeColor, 0.1), typeColor, 0)

    -- Slide IN
    Utility:Tween(notifFrame, { Position = UDim2.new(1, -360, 1, -120) }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    -- Start progress drain
    task.delay(0.45, function()
        Utility:Tween(progressBar, { Size = UDim2.new(0, 0, 1, 0) }, duration - 0.45, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
    end)

    local function dismiss()
        if notifFrame and notifFrame.Parent then
            Utility:Tween(notifFrame, { Position = UDim2.new(1, 20, 1, -120) }, 0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In, function()
                if notifyGui and notifyGui.Parent then notifyGui:Destroy() end
            end)
        end
    end

    closeBtn.MouseButton1Click:Connect(dismiss)
    task.delay(duration, dismiss)
end

-- ═══════════════════════════════════════════════════
--  DIALOG SYSTEM  (Premium Style)
-- ═══════════════════════════════════════════════════
function KimiUI:Dialog(config)
    config = config or {}
    local dialogTitle   = config.Title or "Dialog"
    local dialogContent = config.Content or config.Text or ""
    local dialogType    = config.Type or "Confirm"
    local confirmText   = config.ConfirmText or "Confirm"
    local cancelText    = config.CancelText  or "Cancel"
    local placeholder   = config.Placeholder or ""
    local onConfirm     = config.OnConfirm or function() end
    local onCancel      = config.OnCancel  or function() end

    local dialogGui = Utility:Create("ScreenGui", {
        Name         = "KimiUIDialog",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent       = self.ScreenGui.Parent,
    })

    local backdrop = Utility:Create("Frame", {
        Name                 = "Backdrop",
        BackgroundColor3     = Color3.fromRGB(0, 0, 0),
        BorderSizePixel      = 0,
        Size                 = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent               = dialogGui,
    })
    Utility:Tween(backdrop, { BackgroundTransparency = 0.55 }, 0.3)

    local contentHeight = TextService:GetTextSize(dialogContent, 14, Enum.Font.Gotham, Vector2.new(320, 999)).Y
    local promptOffset  = dialogType == "Prompt" and 50 or 0
    local dialogHeight  = math.max(200, 96 + contentHeight + promptOffset + 72)

    local dialogFrame = Utility:Create("Frame", {
        Name             = "Dialog",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0.5, -190, 0.5, -(dialogHeight / 2)),
        Size             = UDim2.new(0, 0, 0, 0),
        Parent           = dialogGui,
    })
    Utility:CreateCorner(dialogFrame, 14)
    Utility:CreateShadow(dialogFrame, 0.22, 24)
    Utility:CreateStroke(dialogFrame, self.Theme.Accent, 1.5, 0.75)
    Utility:CreateGradient(dialogFrame, Utility:Brighten(self.Theme.Secondary, 0.04), self.Theme.Secondary, 90)

    -- Icon
    local iconBg = Utility:Create("Frame", {
        BackgroundColor3     = self.Theme.Accent,
        BackgroundTransparency = 0.82,
        BorderSizePixel      = 0,
        Position             = UDim2.new(0, 20, 0, 20),
        Size                 = UDim2.new(0, 32, 0, 32),
        Parent               = dialogFrame,
    })
    Utility:CreateCorner(iconBg, 9)
    Utility:Create("ImageLabel", {
        BackgroundTransparency = 1,
        AnchorPoint            = Vector2.new(0.5, 0.5),
        Position               = UDim2.new(0.5, 0, 0.5, 0),
        Size                   = UDim2.new(0, 22, 0, 22),
        Image                  = "rbxassetid://7733970536",
        ImageColor3            = self.Theme.AccentLight,
        Parent                 = iconBg,
    })

    Utility:Create("TextLabel", {
        Name                 = "Title",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 62, 0, 22),
        Size                 = UDim2.new(1, -82, 0, 28),
        Font                 = Enum.Font.GothamBlack,
        Text                 = dialogTitle,
        TextColor3           = self.Theme.Text,
        TextSize             = 18,
        TextXAlignment       = Enum.TextXAlignment.Left,
        Parent               = dialogFrame,
    })

    Utility:Create("Frame", {
        BackgroundColor3 = self.Theme.Border,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 20, 0, 58),
        Size             = UDim2.new(1, -40, 0, 1),
        Parent           = dialogFrame,
    })

    Utility:Create("TextLabel", {
        Name                 = "Content",
        BackgroundTransparency = 1,
        Position             = UDim2.new(0, 20, 0, 66),
        Size                 = UDim2.new(1, -40, 0, 0),
        AutomaticSize        = Enum.AutomaticSize.Y,
        Font                 = Enum.Font.Gotham,
        Text                 = dialogContent,
        TextColor3           = self.Theme.TextDark,
        TextSize             = 14,
        TextXAlignment       = Enum.TextXAlignment.Left,
        TextWrapped          = true,
        Parent               = dialogFrame,
    })

    local promptInput = nil
    if dialogType == "Prompt" then
        promptInput = Utility:Create("TextBox", {
            Name                 = "PromptInput",
            BackgroundColor3     = self.Theme.Primary,
            BorderSizePixel      = 0,
            Position             = UDim2.new(0, 20, 0, 72 + contentHeight),
            Size                 = UDim2.new(1, -40, 0, 38),
            Font                 = Enum.Font.Gotham,
            PlaceholderText      = placeholder,
            PlaceholderColor3    = self.Theme.TextDarker,
            Text                 = "",
            TextColor3           = self.Theme.Text,
            TextSize             = 14,
            Parent               = dialogFrame,
        })
        Utility:CreateCorner(promptInput, 8)
        Utility:CreatePadding(promptInput, 12)
        Utility:CreateStroke(promptInput, self.Theme.Border, 1, 0.65)
    end

    local buttonsY = dialogHeight - 60

    local function closeDialog()
        Utility:Tween(backdrop, { BackgroundTransparency = 1 }, 0.2)
        Utility:Tween(dialogFrame, { Size = UDim2.new(0, 0, 0, 0) }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, function()
            dialogGui:Destroy()
        end)
    end

    if dialogType == "Confirm" or dialogType == "Prompt" then
        local cancelBtn = Utility:Create("TextButton", {
            Name                 = "Cancel",
            BackgroundColor3     = self.Theme.Foreground,
            BorderSizePixel      = 0,
            Position             = UDim2.new(0, 20, 0, buttonsY),
            Size                 = UDim2.new(0.5, -30, 0, 40),
            AutoButtonColor      = false,
            Font                 = Enum.Font.GothamBold,
            Text                 = cancelText,
            TextColor3           = self.Theme.Text,
            TextSize             = 14,
            Parent               = dialogFrame,
        })
        Utility:CreateCorner(cancelBtn, 10)
        cancelBtn.MouseEnter:Connect(function() Utility:Tween(cancelBtn, { BackgroundColor3 = self.Theme.Primary }, 0.2) end)
        cancelBtn.MouseLeave:Connect(function() Utility:Tween(cancelBtn, { BackgroundColor3 = self.Theme.Foreground }, 0.2) end)
        cancelBtn.MouseButton1Click:Connect(function()
            closeDialog(); onCancel()
        end)
    end

    local confirmBtn = Utility:Create("TextButton", {
        Name                 = "Confirm",
        BackgroundColor3     = self.Theme.Accent,
        BorderSizePixel      = 0,
        Position             = dialogType == "Alert"
            and UDim2.new(0.25, 0, 0, buttonsY)
            or  UDim2.new(0.5, 10, 0, buttonsY),
        Size                 = dialogType == "Alert"
            and UDim2.new(0.5, 0, 0, 40)
            or  UDim2.new(0.5, -30, 0, 40),
        AutoButtonColor      = false,
        Font                 = Enum.Font.GothamBlack,
        Text                 = confirmText,
        TextColor3           = Color3.fromRGB(255, 255, 255),
        TextSize             = 14,
        Parent               = dialogFrame,
    })
    Utility:CreateCorner(confirmBtn, 10)
    Utility:CreateGradient(confirmBtn, self.Theme.AccentLight, self.Theme.AccentDark, 90)
    Utility:CreateRipple(confirmBtn)
    confirmBtn.MouseEnter:Connect(function() Utility:Tween(confirmBtn, { BackgroundColor3 = self.Theme.AccentLight }, 0.2) end)
    confirmBtn.MouseLeave:Connect(function() Utility:Tween(confirmBtn, { BackgroundColor3 = self.Theme.Accent }, 0.2) end)
    confirmBtn.MouseButton1Click:Connect(function()
        closeDialog()
        if dialogType == "Prompt" and promptInput then onConfirm(promptInput.Text) else onConfirm() end
    end)

    -- Entrance animation
    Utility:Tween(dialogFrame, { Size = UDim2.new(0, 380, 0, dialogHeight) }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    return dialogGui
end

-- ═══════════════════════════════════════════════════
--  POPUP SYSTEM
-- ═══════════════════════════════════════════════════
function KimiUI:Popup(config)
    config = config or {}
    local popupTitle   = config.Title or "Popup"
    local popupContent = config.Content or ""
    local buttons      = config.Buttons or {}
    local position     = config.Position or UDim2.new(0.5, -160, 0.5, -80)

    local popupGui = Utility:Create("ScreenGui", {
        Name         = "KimiUIPopup",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent       = self.ScreenGui.Parent,
    })
    Utility:Create("Frame", {
        BackgroundColor3     = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.6,
        Size                 = UDim2.new(1, 0, 1, 0),
        Parent               = popupGui,
    })

    local popupFrame = Utility:Create("Frame", {
        Name             = "Popup",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel  = 0,
        Position         = position,
        Size             = UDim2.new(0, 0, 0, 0),
        Parent           = popupGui,
    })
    Utility:CreateCorner(popupFrame, 14)
    Utility:CreateShadow(popupFrame, 0.28, 18)
    Utility:CreateStroke(popupFrame, self.Theme.Border, 1, 0.6)

    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 18, 0, 16),
        Size                   = UDim2.new(1, -36, 0, 24),
        Font                   = Enum.Font.GothamBlack,
        Text                   = popupTitle,
        TextColor3             = self.Theme.Text,
        TextSize               = 16,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = popupFrame,
    })
    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 18, 0, 46),
        Size                   = UDim2.new(1, -36, 0, 0),
        AutomaticSize          = Enum.AutomaticSize.Y,
        Font                   = Enum.Font.Gotham,
        Text                   = popupContent,
        TextColor3             = self.Theme.TextDark,
        TextSize               = 13,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextWrapped            = true,
        Parent                 = popupFrame,
    })

    local btnsFrame = Utility:Create("Frame", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 18, 1, -50),
        Size                   = UDim2.new(1, -36, 0, 40),
        Parent                 = popupFrame,
    })
    Utility:Create("UIListLayout", {
        FillDirection         = Enum.FillDirection.Horizontal,
        Padding               = UDim.new(0, 8),
        HorizontalAlignment   = Enum.HorizontalAlignment.Right,
        Parent                = btnsFrame,
    })

    for i, btnCfg in pairs(buttons) do
        local isPrimary = btnCfg.Style == "Primary"
        local btn = Utility:Create("TextButton", {
            BackgroundColor3 = isPrimary and self.Theme.Accent or self.Theme.Foreground,
            BorderSizePixel  = 0,
            Size             = UDim2.new(0, 90, 1, 0),
            AutoButtonColor  = false,
            Font             = Enum.Font.GothamBold,
            Text             = btnCfg.Text or "Button",
            TextColor3       = isPrimary and Color3.fromRGB(255,255,255) or self.Theme.Text,
            TextSize         = 13,
            Parent           = btnsFrame,
        })
        Utility:CreateCorner(btn, 9)
        if isPrimary then
            Utility:CreateGradient(btn, self.Theme.AccentLight, self.Theme.AccentDark, 90)
            btn.MouseEnter:Connect(function() Utility:Tween(btn, { BackgroundColor3 = self.Theme.AccentLight }, 0.2) end)
            btn.MouseLeave:Connect(function() Utility:Tween(btn, { BackgroundColor3 = self.Theme.Accent }, 0.2) end)
        else
            btn.MouseEnter:Connect(function() Utility:Tween(btn, { BackgroundColor3 = self.Theme.Primary }, 0.2) end)
            btn.MouseLeave:Connect(function() Utility:Tween(btn, { BackgroundColor3 = self.Theme.Foreground }, 0.2) end)
        end
        btn.MouseButton1Click:Connect(function()
            popupGui:Destroy()
            if btnCfg.Callback then btnCfg.Callback() end
        end)
    end

    Utility:Tween(popupFrame, { Size = UDim2.new(0, 320, 0, 170) }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    return popupGui
end

-- ═══════════════════════════════════════════════════
--  TAG SYSTEM  (Premium)
-- ═══════════════════════════════════════════════════
function KimiUI:CreateTag(config, parent)
    config = config or {}
    local tagText    = config.Text or "Tag"
    local tagColor   = config.Color or self.Theme.Accent
    local tagStyle   = config.Style or "Filled"
    local tagVariant = config.Variant or "Primary"

    if tagVariant and not config.Color then
        local vc = {
            Primary = self.Theme.TagPrimary,
            Success = self.Theme.TagSuccess,
            Warning = self.Theme.TagWarning,
            Error   = self.Theme.TagError,
            Info    = self.Theme.TagInfo,
        }
        tagColor = vc[tagVariant] or self.Theme.Accent
    end

    local textWidth = TextService:GetTextSize(tagText, 11, Enum.Font.GothamBold, Vector2.new(999, 26)).X
    local tagFrame = Utility:Create("Frame", {
        Name                 = tagText .. "Tag",
        BackgroundColor3     = tagStyle == "Filled" and tagColor or self.Theme.Secondary,
        BackgroundTransparency = tagStyle == "Ghost" and 0.85 or 0,
        BorderSizePixel      = 0,
        Size                 = UDim2.new(0, textWidth + 22, 0, 26),
        Parent               = parent,
    })
    Utility:CreateCorner(tagFrame, 6)

    if tagStyle == "Filled" then
        Utility:CreateGradient(tagFrame, Utility:Brighten(tagColor, 0.1), tagColor, 90)
    elseif tagStyle == "Outline" then
        Utility:CreateStroke(tagFrame, tagColor, 1.5, 0.45)
    end

    Utility:Create("TextLabel", {
        BackgroundTransparency = 1,
        Position               = UDim2.new(0, 11, 0, 0),
        Size                   = UDim2.new(0, textWidth, 1, 0),
        Font                   = Enum.Font.GothamBold,
        Text                   = tagText,
        TextColor3             = tagStyle == "Filled" and Color3.fromRGB(255, 255, 255) or tagColor,
        TextSize               = 11,
        Parent                 = tagFrame,
    })

    local Tag = {
        Frame = tagFrame, Text = tagText,
        Set = function(_, text)
            local newWidth = TextService:GetTextSize(text, 11, Enum.Font.GothamBold, Vector2.new(999, 26)).X
            tagFrame.Size = UDim2.new(0, newWidth + 22, 0, 26)
        end,
        Type = "Tag",
    }
    return Tag
end

-- ═══════════════════════════════════════════════════
--  WINDOW UTILITIES
-- ═══════════════════════════════════════════════════
function KimiUI:ToggleMinimize()
    local mf = self.MainFrame
    if mf.Size.Y.Offset <= 54 then
        Utility:Tween(mf, { Size = self.Config.Size or UDim2.new(0, 720, 0, 520) }, 0.38, Enum.EasingStyle.Quart)
    else
        Utility:Tween(mf, { Size = UDim2.new(0, mf.Size.X.Offset, 0, 48) }, 0.38, Enum.EasingStyle.Quart)
    end
end

function KimiUI:Destroy()
    if self.ScreenGui then self.ScreenGui:Destroy() end
    KimiUI.CurrentWindow = nil
end

function KimiUI:GetFlag(flag)
    return self.Flags[flag]
end

function KimiUI:SetFlag(flag, value)
    self.Flags[flag] = value
    for _, element in pairs(self.Elements) do
        if element.Flag == flag and element.Set then element:Set(value) end
    end
end

function KimiUI:SaveConfig(filename)
    if not filename or not isfolder then return end
    if not isfolder("KimiUI") then makefolder("KimiUI") end
    if not isfolder("KimiUI/Configs") then makefolder("KimiUI/Configs") end
    local data = {}
    for flag, value in pairs(self.Flags) do
        if typeof(value) == "Color3" then
            data[flag] = { Type = "Color3", R = value.R, G = value.G, B = value.B }
        elseif typeof(value) == "EnumItem" then
            data[flag] = { Type = "Enum", Value = tostring(value) }
        else
            data[flag] = value
        end
    end
    writefile("KimiUI/Configs/" .. filename .. ".json", HttpService:JSONEncode(data))
end

function KimiUI:LoadConfig(filename)
    if not filename or not isfile then return end
    local path = "KimiUI/Configs/" .. filename .. ".json"
    if not isfile(path) then return end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok then return end
    for flag, value in pairs(data) do
        if typeof(value) == "table" then
            if value.Type == "Color3" then self:SetFlag(flag, Color3.new(value.R, value.G, value.B)) end
        else
            self:SetFlag(flag, value)
        end
    end
end

return KimiUI
