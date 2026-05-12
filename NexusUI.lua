--[[
    NexusUI v2.0 — Roblox Script Hub UI Library
    Style: Modern dark glass, smooth animations, full component set
    Components: Window · Tab · Section · Toggle · Button · Slider
                Dropdown · Input · ColorPicker · Keybind · Label
                Paragraph · Divider · Notification · Dialog · Progress

    Usage:
        local NexusUI = loadstring(game:HttpGet("..."))()
        local Window  = NexusUI:CreateWindow({ Title="My Hub", Theme="Dark" })
        local Tab     = Window:Tab({ Title="Main", Icon="Zap" })
        Tab:Toggle({ Title="Speed", Value=false, Callback=function(v) end })
]]

-- ──────────────────────────────────────────────────────────────────────────────
-- SERVICES
-- ──────────────────────────────────────────────────────────────────────────────
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()

-- ──────────────────────────────────────────────────────────────────────────────
-- ICON REGISTRY
-- Real ImageLabel icons — replace IDs with your preferred Roblox icon pack
-- Icon= accepts: registry key ("Zap"), rbxassetid:// URL, or emoji fallback
-- ──────────────────────────────────────────────────────────────────────────────
local IconRegistry = {
    -- Navigation / General
    Home        = "rbxassetid://10723414975",
    Search      = "rbxassetid://10723416345",
    Settings    = "rbxassetid://10723417189",
    Cog         = "rbxassetid://10723410965",
    Bars        = "rbxassetid://10723408215",
    Bell        = "rbxassetid://10723408669",
    Info        = "rbxassetid://10723414785",
    Alert       = "rbxassetid://10723407669",
    -- Actions
    Check       = "rbxassetid://10723409929",
    X           = "rbxassetid://10723426321",
    Plus        = "rbxassetid://10723415989",
    Minus       = "rbxassetid://10723415767",
    Refresh     = "rbxassetid://10723416115",
    Pin         = "rbxassetid://10723415645",
    Teleport    = "rbxassetid://10723418137",
    -- Chevrons (dropdown)
    ChevronDown = "rbxassetid://10723410695",
    ChevronUp   = "rbxassetid://10723410401",
    -- Game / Script
    Zap         = "rbxassetid://10723407389",
    Flame       = "rbxassetid://10723413049",
    Sword       = "rbxassetid://10723421292",
    Shield      = "rbxassetid://10723416591",
    Target      = "rbxassetid://10723411449",
    Crosshair   = "rbxassetid://10723411449",
    Gamepad     = "rbxassetid://10723413389",
    Trophy      = "rbxassetid://10723418319",
    Star        = "rbxassetid://10723417643",
    -- Visual
    Eye         = "rbxassetid://10723412273",
    EyeOff      = "rbxassetid://10723412045",
    Palette     = "rbxassetid://10723415789",
    -- People / World
    User        = "rbxassetid://10723418969",
    Globe       = "rbxassetid://10723414119",
    Map         = "rbxassetid://10723415453",
    Lock        = "rbxassetid://10723415119",
    Heart       = "rbxassetid://10723414295",
    -- Input
    Keyboard    = "rbxassetid://10723414969",
}

-- ──────────────────────────────────────────────────────────────────────────────
-- THEMES
-- ──────────────────────────────────────────────────────────────────────────────
local Themes = {
    Dark = {
        Background     = Color3.fromHex("#0d0e10"),
        Surface        = Color3.fromHex("#131416"),
        SurfaceHover   = Color3.fromHex("#1a1b1e"),
        Panel          = Color3.fromHex("#18191c"),
        Border         = Color3.fromHex("#2a2b2f"),
        BorderLight    = Color3.fromHex("#353639"),
        Accent         = Color3.fromHex("#5865f2"),
        AccentHover    = Color3.fromHex("#4752c4"),
        AccentSoft     = Color3.fromHex("#5865f2"),
        Success        = Color3.fromHex("#3ba55d"),
        Warning        = Color3.fromHex("#faa61a"),
        Error          = Color3.fromHex("#ed4245"),
        TextPrimary    = Color3.fromHex("#f0f0f2"),
        TextSecondary  = Color3.fromHex("#9a9ba0"),
        TextMuted      = Color3.fromHex("#545558"),
        TrackBg        = Color3.fromHex("#222326"),
        Handle         = Color3.fromHex("#5865f2"),
        ToggleOn       = Color3.fromHex("#5865f2"),
        ToggleOff      = Color3.fromHex("#2e2f33"),
        Topbar         = Color3.fromHex("#0d0e10"),
        Sidebar        = Color3.fromHex("#101113"),
        Shadow         = Color3.fromHex("#000000"),
        Scrollbar      = Color3.fromHex("#2e2f33"),
        Tag            = Color3.fromHex("#1e1f22"),
    },
    Midnight = {
        Background     = Color3.fromHex("#080b14"),
        Surface        = Color3.fromHex("#0d1117"),
        SurfaceHover   = Color3.fromHex("#131922"),
        Panel          = Color3.fromHex("#111620"),
        Border         = Color3.fromHex("#1e2433"),
        BorderLight    = Color3.fromHex("#27304a"),
        Accent         = Color3.fromHex("#00b4d8"),
        AccentHover    = Color3.fromHex("#0096c7"),
        AccentSoft     = Color3.fromHex("#00b4d8"),
        Success        = Color3.fromHex("#00c896"),
        Warning        = Color3.fromHex("#f4a261"),
        Error          = Color3.fromHex("#e63946"),
        TextPrimary    = Color3.fromHex("#e8edf5"),
        TextSecondary  = Color3.fromHex("#7a8599"),
        TextMuted      = Color3.fromHex("#3a4257"),
        TrackBg        = Color3.fromHex("#141a28"),
        Handle         = Color3.fromHex("#00b4d8"),
        ToggleOn       = Color3.fromHex("#00b4d8"),
        ToggleOff      = Color3.fromHex("#1c2236"),
        Topbar         = Color3.fromHex("#080b14"),
        Sidebar        = Color3.fromHex("#09101a"),
        Shadow         = Color3.fromHex("#000000"),
        Scrollbar      = Color3.fromHex("#1c2236"),
        Tag            = Color3.fromHex("#0e1524"),
    },
    Rose = {
        Background     = Color3.fromHex("#0f0810"),
        Surface        = Color3.fromHex("#150d17"),
        SurfaceHover   = Color3.fromHex("#1c1320"),
        Panel          = Color3.fromHex("#18101a"),
        Border         = Color3.fromHex("#2d1f30"),
        BorderLight    = Color3.fromHex("#3d2a40"),
        Accent         = Color3.fromHex("#e879a0"),
        AccentHover    = Color3.fromHex("#d5638c"),
        AccentSoft     = Color3.fromHex("#e879a0"),
        Success        = Color3.fromHex("#6ee7b7"),
        Warning        = Color3.fromHex("#fbbf24"),
        Error          = Color3.fromHex("#f87171"),
        TextPrimary    = Color3.fromHex("#f5e6f0"),
        TextSecondary  = Color3.fromHex("#9a7ea0"),
        TextMuted      = Color3.fromHex("#4a3550"),
        TrackBg        = Color3.fromHex("#1f1222"),
        Handle         = Color3.fromHex("#e879a0"),
        ToggleOn       = Color3.fromHex("#e879a0"),
        ToggleOff      = Color3.fromHex("#2a1a2e"),
        Topbar         = Color3.fromHex("#0f0810"),
        Sidebar        = Color3.fromHex("#100910"),
        Shadow         = Color3.fromHex("#000000"),
        Scrollbar      = Color3.fromHex("#2a1a2e"),
        Tag            = Color3.fromHex("#1a1020"),
    },
    Amber = {
        Background     = Color3.fromHex("#0e0c08"),
        Surface        = Color3.fromHex("#14110a"),
        SurfaceHover   = Color3.fromHex("#1c1810"),
        Panel          = Color3.fromHex("#18150d"),
        Border         = Color3.fromHex("#2e2614"),
        BorderLight    = Color3.fromHex("#3d3418"),
        Accent         = Color3.fromHex("#f59e0b"),
        AccentHover    = Color3.fromHex("#d97706"),
        AccentSoft     = Color3.fromHex("#f59e0b"),
        Success        = Color3.fromHex("#34d399"),
        Warning        = Color3.fromHex("#f59e0b"),
        Error          = Color3.fromHex("#f87171"),
        TextPrimary    = Color3.fromHex("#f5f0e0"),
        TextSecondary  = Color3.fromHex("#9a8f70"),
        TextMuted      = Color3.fromHex("#4a4030"),
        TrackBg        = Color3.fromHex("#1c1810"),
        Handle         = Color3.fromHex("#f59e0b"),
        ToggleOn       = Color3.fromHex("#f59e0b"),
        ToggleOff      = Color3.fromHex("#2a2214"),
        Topbar         = Color3.fromHex("#0e0c08"),
        Sidebar        = Color3.fromHex("#0f0d08"),
        Shadow         = Color3.fromHex("#000000"),
        Scrollbar      = Color3.fromHex("#2a2214"),
        Tag            = Color3.fromHex("#1a1608"),
    },
    Light = {
        Background     = Color3.fromHex("#f8f9fa"),
        Surface        = Color3.fromHex("#ffffff"),
        SurfaceHover   = Color3.fromHex("#f1f3f5"),
        Panel          = Color3.fromHex("#f4f5f7"),
        Border         = Color3.fromHex("#e2e4e9"),
        BorderLight    = Color3.fromHex("#d8dae0"),
        Accent         = Color3.fromHex("#5865f2"),
        AccentHover    = Color3.fromHex("#4752c4"),
        AccentSoft     = Color3.fromHex("#5865f2"),
        Success        = Color3.fromHex("#2d9e5f"),
        Warning        = Color3.fromHex("#e08c00"),
        Error          = Color3.fromHex("#c92a2a"),
        TextPrimary    = Color3.fromHex("#1a1b1e"),
        TextSecondary  = Color3.fromHex("#555860"),
        TextMuted      = Color3.fromHex("#999da8"),
        TrackBg        = Color3.fromHex("#e8e9ed"),
        Handle         = Color3.fromHex("#5865f2"),
        ToggleOn       = Color3.fromHex("#5865f2"),
        ToggleOff      = Color3.fromHex("#d0d2d9"),
        Topbar         = Color3.fromHex("#ffffff"),
        Sidebar        = Color3.fromHex("#f4f5f7"),
        Shadow         = Color3.fromHex("#c0c2ca"),
        Scrollbar      = Color3.fromHex("#d0d2d9"),
        Tag            = Color3.fromHex("#eaebef"),
    },
}

-- ──────────────────────────────────────────────────────────────────────────────
-- UTILS
-- ──────────────────────────────────────────────────────────────────────────────
local function Tween(obj, props, t, style, dir)
    local info = TweenInfo.new(t or 0.18, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out)
    local tw = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

local function SpringTween(obj, props, t)
    return Tween(obj, props, t or 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

local function Make(class, props, children)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then obj[k] = v end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = obj
    end
    if props and props.Parent then obj.Parent = props.Parent end
    return obj
end

local function AddCorner(parent, radius)
    return Make("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = parent })
end

local function AddStroke(parent, color, thickness, trans)
    return Make("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = trans or 0,
        Parent = parent
    })
end

local function AddPadding(parent, t, b, l, r)
    return Make("UIPadding", {
        PaddingTop    = UDim.new(0, t or 8),
        PaddingBottom = UDim.new(0, b or 8),
        PaddingLeft   = UDim.new(0, l or 10),
        PaddingRight  = UDim.new(0, r or 10),
        Parent        = parent
    })
end

local function AddListLayout(parent, dir, align, padding)
    return Make("UIListLayout", {
        FillDirection = dir or Enum.FillDirection.Vertical,
        HorizontalAlignment = align or Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, padding or 0),
        Parent  = parent
    })
end

local function Lerp(a, b, t) return a + (b - a) * t end

local function ColorToHex(c)
    return string.format("#%02X%02X%02X",
        math.clamp(math.round(c.R * 255), 0, 255),
        math.clamp(math.round(c.G * 255), 0, 255),
        math.clamp(math.round(c.B * 255), 0, 255))
end

local function HsvToColor3(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t2 = v * (1 - (1 - f) * s)
    i = i % 6
    if i == 0 then r,g,b = v,t2,p
    elseif i == 1 then r,g,b = q,v,p
    elseif i == 2 then r,g,b = p,v,t2
    elseif i == 3 then r,g,b = p,q,v
    elseif i == 4 then r,g,b = t2,p,v
    elseif i == 5 then r,g,b = v,p,q end
    return Color3.new(r, g, b)
end

-- dragging helper
local function MakeDraggable(handle, target)
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = input.Position
            startPos  = target.Position
        end
    end)
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ── Icon helper ───────────────────────────────────────────────────────────────
-- Returns an ImageLabel (real icon) or TextLabel (emoji/text fallback).
-- key: registry name ("Zap"), rbxassetid:// URL, or plain text/emoji
local function MakeIcon(parent, key, size, color, zindex)
    size   = size   or 18
    color  = color  or Color3.new(1,1,1)
    zindex = zindex or 2

    local assetId = ""
    if key and key ~= "" then
        if type(key) == "string" and key:sub(1,13) == "rbxassetid://" then
            assetId = key
        elseif IconRegistry[key] then
            assetId = IconRegistry[key]
        end
    end

    if assetId ~= "" then
        return Make("ImageLabel", {
            Size               = UDim2.new(0, size, 0, size),
            Image              = assetId,
            ImageColor3        = color,
            BackgroundTransparency = 1,
            ZIndex             = zindex,
            Parent             = parent
        })
    else
        -- emoji / text fallback
        return Make("TextLabel", {
            Size               = UDim2.new(0, size + 6, 0, size + 6),
            Text               = (key or ""),
            TextColor3         = color,
            Font               = Enum.Font.GothamBold,
            TextSize           = size - 1,
            BackgroundTransparency = 1,
            ZIndex             = zindex,
            Parent             = parent
        })
    end
end

-- ──────────────────────────────────────────────────────────────────────────────
-- NOTIFICATION SYSTEM
-- ──────────────────────────────────────────────────────────────────────────────
local NotifHolder
local function EnsureNotifHolder()
    if NotifHolder and NotifHolder.Parent then return end
    local sg = Make("ScreenGui", {
        Name             = "NexusUI_Notifs",
        ResetOnSpawn     = false,
        ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
        Parent           = (pcall(function() return CoreGui end) and CoreGui) or LocalPlayer.PlayerGui
    })
    NotifHolder = Make("Frame", {
        Name                 = "Holder",
        Size                 = UDim2.new(0, 308, 1, 0),
        Position             = UDim2.new(1, -323, 0, 0),
        BackgroundTransparency = 1,
        Parent               = sg
    })
    AddListLayout(NotifHolder, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right, 8)
    AddPadding(NotifHolder, 14, 14, 0, 0)
end

local function Notify(cfg)
    EnsureNotifHolder()
    local theme = Themes[cfg.Theme or "Dark"]
    local typeData = {
        success = { color = theme.Success,  icon = "Check" },
        warning = { color = theme.Warning,  icon = "Alert" },
        error   = { color = theme.Error,    icon = "X"     },
        info    = { color = theme.Accent,   icon = "Info"  },
    }
    local td     = typeData[cfg.Type or "info"] or typeData["info"]
    local accent = td.color

    local card = Make("Frame", {
        Name               = "Notif",
        Size               = UDim2.new(1, 0, 0, 70),
        BackgroundColor3   = theme.Panel,
        BackgroundTransparency = 0,
        ClipsDescendants   = true,
        Parent             = NotifHolder
    })
    AddCorner(card, 10)
    AddStroke(card, theme.Border, 1)

    -- left accent bar
    local bar = Make("Frame", {
        Size             = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = accent,
        BorderSizePixel  = 0,
        ZIndex           = 2,
        Parent           = card
    })
    AddCorner(bar, 3)

    -- type icon
    local iconLabel = MakeIcon(card, td.icon, 16, accent, 3)
    iconLabel.Position = UDim2.new(0, 14, 0, 13)

    -- progress bar
    local progress = Make("Frame", {
        Size             = UDim2.new(1, 0, 0, 2),
        Position         = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = accent,
        BorderSizePixel  = 0,
        ZIndex           = 5,
        Parent           = card
    })

    -- title
    Make("TextLabel", {
        Size               = UDim2.new(1, -42, 0, 20),
        Position           = UDim2.new(0, 38, 0, 10),
        Text               = cfg.Title or "Notification",
        TextColor3         = theme.TextPrimary,
        Font               = Enum.Font.GothamBold,
        TextSize           = 13,
        TextXAlignment     = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Parent             = card
    })

    -- content
    if cfg.Content then
        Make("TextLabel", {
            Size               = UDim2.new(1, -42, 0, 30),
            Position           = UDim2.new(0, 38, 0, 31),
            Text               = cfg.Content,
            TextColor3         = theme.TextSecondary,
            Font               = Enum.Font.Gotham,
            TextSize           = 11,
            TextXAlignment     = Enum.TextXAlignment.Left,
            TextWrapped        = true,
            BackgroundTransparency = 1,
            Parent             = card
        })
    end

    -- slide-in
    card.Position = UDim2.new(1, 20, 0, 0)
    Tween(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    local duration = cfg.Duration or 4
    Tween(progress, { Size = UDim2.new(0, 0, 0, 2) }, duration, Enum.EasingStyle.Linear)
    task.delay(duration, function()
        Tween(card, { Position = UDim2.new(1, 20, 0, 0), BackgroundTransparency = 1 }, 0.25)
        task.delay(0.3, function() card:Destroy() end)
    end)

    return card
end

-- ──────────────────────────────────────────────────────────────────────────────
-- LIBRARY TABLE
-- ──────────────────────────────────────────────────────────────────────────────
local NexusUI = {}
NexusUI.__index = NexusUI
NexusUI.Version   = "2.0.0"
NexusUI.Flags     = {}
NexusUI._windows  = {}
NexusUI.Icons     = IconRegistry

function NexusUI:GetThemes() return Themes end
function NexusUI:AddTheme(name, t) Themes[name] = t end
function NexusUI:Notify(cfg)
    cfg.Theme = cfg.Theme or "Dark"
    return Notify(cfg)
end

-- ──────────────────────────────────────────────────────────────────────────────
-- CREATE WINDOW
-- ──────────────────────────────────────────────────────────────────────────────
function NexusUI:CreateWindow(cfg)
    cfg = cfg or {}
    local C = Themes[cfg.Theme] or Themes.Dark

    -- ── GUI root ──
    local sg = Make("ScreenGui", {
        Name             = "NexusUI_" .. (cfg.Title or "Hub"),
        ResetOnSpawn     = false,
        ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
        Parent           = (pcall(function() return CoreGui end) and CoreGui) or LocalPlayer.PlayerGui
    })

    -- ── Shadow ──
    local W = cfg.Width or 660
    local H = cfg.Height or 460
    local shadow = Make("Frame", {
        Name                 = "Shadow",
        Size                 = UDim2.new(0, W + 32, 0, H + 32),
        Position             = UDim2.new(0.5, -(W + 32)/2, 0.5, -(H + 32)/2),
        BackgroundColor3     = C.Shadow,
        BackgroundTransparency = 0.55,
        BorderSizePixel      = 0,
        ZIndex               = 0,
        Parent               = sg
    })
    AddCorner(shadow, 18)

    -- ── Main window ──
    local win = Make("Frame", {
        Name             = "Window",
        Size             = UDim2.new(0, W, 0, H),
        Position         = UDim2.new(0.5, -W/2, 0.5, -H/2),
        BackgroundColor3 = C.Background,
        BorderSizePixel  = 0,
        ClipsDescendants = true,
        Parent           = sg
    })
    AddCorner(win, 14)
    AddStroke(win, C.Border, 1)

    -- ── Topbar ──
    local topbar = Make("Frame", {
        Name             = "Topbar",
        Size             = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = C.Topbar,
        BorderSizePixel  = 0,
        ZIndex           = 4,
        Parent           = win
    })
    Make("Frame", {  -- bottom border
        Size             = UDim2.new(1, 0, 0, 1),
        Position         = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = C.Border,
        BorderSizePixel  = 0,
        Parent           = topbar
    })

    -- Title
    local titleLabel = Make("TextLabel", {
        Size               = UDim2.new(0, 300, 1, 0),
        Position           = UDim2.new(0, 16, 0, 0),
        Text               = cfg.Title or "NexusUI",
        TextColor3         = C.TextPrimary,
        Font               = Enum.Font.GothamBold,
        TextSize           = 15,
        TextXAlignment     = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        ZIndex             = 4,
        Parent             = topbar
    })
    if cfg.Author then
        titleLabel.Size     = UDim2.new(0, 300, 0, 22)
        titleLabel.Position = UDim2.new(0, 16, 0, 5)
        Make("TextLabel", {
            Size               = UDim2.new(0, 300, 0, 16),
            Position           = UDim2.new(0, 16, 0, 28),
            Text               = cfg.Author,
            TextColor3         = C.TextMuted,
            Font               = Enum.Font.Gotham,
            TextSize           = 11,
            TextXAlignment     = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex             = 4,
            Parent             = topbar
        })
    end

    -- ── Window buttons (close / minimize) ──
    local function WinBtn(xOff, bgColor, iconKey)
        local btn = Make("Frame", {
            Size             = UDim2.new(0, 14, 0, 14),
            Position         = UDim2.new(1, xOff, 0.5, -7),
            BackgroundColor3 = bgColor,
            BorderSizePixel  = 0,
            ZIndex           = 5,
            Parent           = topbar
        })
        AddCorner(btn, 7)
        -- icon inside the circle
        local ico = MakeIcon(btn, iconKey, 8, Color3.fromRGB(30, 30, 30), 6)
        ico.AnchorPoint = Vector2.new(0.5, 0.5)
        ico.Position    = UDim2.new(0.5, 0, 0.5, 0)
        return btn
    end
    local closeBtn = WinBtn(-28, Color3.fromHex("#ed4245"), "X")
    local minBtn   = WinBtn(-50, Color3.fromHex("#faa61a"), "Minus")

    MakeDraggable(topbar, win)
    local function SyncShadow()
        shadow.Position = UDim2.new(
            win.Position.X.Scale, win.Position.X.Offset - 16,
            win.Position.Y.Scale, win.Position.Y.Offset - 16
        )
    end
    RunService.RenderStepped:Connect(SyncShadow)

    -- ── Sidebar ──
    local sidebarW = cfg.SideBarWidth or 190
    local sidebar = Make("Frame", {
        Name             = "Sidebar",
        Size             = UDim2.new(0, sidebarW, 1, -50),
        Position         = UDim2.new(0, 0, 0, 50),
        BackgroundColor3 = C.Sidebar,
        BorderSizePixel  = 0,
        ClipsDescendants = true,
        Parent           = win
    })
    Make("Frame", {  -- right border
        Size             = UDim2.new(0, 1, 1, 0),
        Position         = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = C.Border,
        BorderSizePixel  = 0,
        Parent           = sidebar
    })

    local tabList = Make("ScrollingFrame", {
        Name                   = "TabList",
        Size                   = UDim2.new(1, 0, 1, -52),
        Position               = UDim2.new(0, 0, 0, 8),
        BackgroundTransparency = 1,
        BorderSizePixel        = 0,
        ScrollBarThickness     = 2,
        ScrollBarImageColor3   = C.Scrollbar,
        CanvasSize             = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize    = Enum.AutomaticSize.Y,
        Parent                 = sidebar
    })
    AddListLayout(tabList, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 2)
    AddPadding(tabList, 4, 4, 8, 8)

    Make("TextLabel", {  -- version at bottom
        Size               = UDim2.new(1, 0, 0, 24),
        Position           = UDim2.new(0, 0, 1, -28),
        Text               = "NexusUI v" .. NexusUI.Version,
        TextColor3         = C.TextMuted,
        Font               = Enum.Font.Gotham,
        TextSize           = 10,
        BackgroundTransparency = 1,
        ZIndex             = 2,
        Parent             = sidebar
    })

    -- ── Content area ──
    local content = Make("ScrollingFrame", {
        Name                   = "Content",
        Size                   = UDim2.new(1, -sidebarW, 1, -50),
        Position               = UDim2.new(0, sidebarW, 0, 50),
        BackgroundColor3       = C.Background,
        BorderSizePixel        = 0,
        ScrollBarThickness     = 3,
        ScrollBarImageColor3   = C.Scrollbar,
        CanvasSize             = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize    = Enum.AutomaticSize.Y,
        Parent                 = win
    })

    -- ── Window object ──
    local Window = {
        _gui      = sg,
        _win      = win,
        _content  = content,
        _sidebar  = sidebar,
        _tabs     = {},
        _active   = nil,
        Theme     = C,
        ThemeName = cfg.Theme or "Dark",
    }

    local function SelectTab(tab)
        if Window._active == tab then return end
        if Window._active then
            local old = Window._active
            Tween(old._btn,      { BackgroundColor3 = Color3.fromRGB(0,0,0), BackgroundTransparency = 1 }, 0.15)
            Tween(old._accentBar,{ BackgroundTransparency = 1 }, 0.15)
            old._btnLabel.TextColor3 = C.TextSecondary
            if old._btnIcon:IsA("ImageLabel") then
                Tween(old._btnIcon, { ImageColor3 = C.TextMuted }, 0.15)
            else
                old._btnIcon.TextColor3 = C.TextMuted
            end
            old._frame.Visible = false
        end
        Window._active = tab
        Tween(tab._btn, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0.87 }, 0.15)
        Tween(tab._accentBar, { BackgroundTransparency = 0 }, 0.15)
        tab._btnLabel.TextColor3 = C.TextPrimary
        if tab._btnIcon:IsA("ImageLabel") then
            Tween(tab._btnIcon, { ImageColor3 = C.Accent }, 0.15)
        else
            tab._btnIcon.TextColor3 = C.Accent
        end
        tab._frame.Visible = true
        tab._frame.Position = UDim2.new(0.04, 0, 0, 0)
        Tween(tab._frame, { Position = UDim2.new(0, 0, 0, 0) }, 0.2, Enum.EasingStyle.Quart)
    end

    -- ── Tab builder ──
    function Window:Tab(tcfg)
        tcfg = tcfg or {}
        local T = {}

        -- sidebar button
        local btn = Make("Frame", {
            Name                 = "TabBtn_" .. (tcfg.Title or "Tab"),
            Size                 = UDim2.new(1, 0, 0, 40),
            BackgroundColor3     = Color3.fromRGB(0,0,0),
            BackgroundTransparency = 1,
            BorderSizePixel      = 0,
            Parent               = tabList
        })
        AddCorner(btn, 9)

        -- left accent bar
        local accentBar = Make("Frame", {
            Size             = UDim2.new(0, 3, 0.55, 0),
            Position         = UDim2.new(0, 0, 0.225, 0),
            BackgroundColor3 = C.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel  = 0,
            Parent           = btn
        })
        AddCorner(accentBar, 2)

        -- icon (ImageLabel or TextLabel fallback)
        local iconKey = tcfg.Icon or ""
        local btnIcon = MakeIcon(btn, iconKey, 18, C.TextMuted, 2)
        btnIcon.AnchorPoint = Vector2.new(0, 0.5)
        btnIcon.Position    = UDim2.new(0, 13, 0.5, 0)

        -- label
        local btnLabel = Make("TextLabel", {
            Size               = UDim2.new(1, -42, 1, 0),
            Position           = UDim2.new(0, 38, 0, 0),
            Text               = tcfg.Title or "Tab",
            TextColor3         = C.TextSecondary,
            Font               = Enum.Font.GothamSemibold,
            TextSize           = 13,
            TextXAlignment     = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent             = btn
        })

        local btnClick = Make("TextButton", {
            Size                 = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Text                 = "",
            ZIndex               = 3,
            Parent               = btn
        })

        -- content frame
        local frame = Make("Frame", {
            Name             = "TabPage_" .. (tcfg.Title or "Tab"),
            Size             = UDim2.new(1, 0, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Visible          = false,
            Parent           = content
        })
        AddListLayout(frame, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 6)
        AddPadding(frame, 10, 10, 10, 10)

        T._btn       = btn
        T._accentBar = accentBar
        T._btnLabel  = btnLabel
        T._btnIcon   = btnIcon
        T._frame     = frame

        btnClick.MouseButton1Click:Connect(function() SelectTab(T) end)
        btnClick.MouseEnter:Connect(function()
            if Window._active ~= T then
                Tween(btn, { BackgroundColor3 = C.SurfaceHover, BackgroundTransparency = 0 }, 0.12)
            end
        end)
        btnClick.MouseLeave:Connect(function()
            if Window._active ~= T then
                Tween(btn, { BackgroundTransparency = 1 }, 0.12)
            end
        end)

        if #Window._tabs == 0 then SelectTab(T) end
        table.insert(Window._tabs, T)

        -- ── ELEMENT HELPERS ──────────────────────────────────────────────────
        local function BaseCard(parent, h)
            local card = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, h or 46),
                BackgroundColor3 = C.Panel,
                BorderSizePixel  = 0,
                Parent           = parent
            })
            AddCorner(card, 9)
            AddStroke(card, C.Border, 1, 0)
            return card
        end

        -- Title + optional description (left side of card)
        local function ElemLabel(parent, title, desc, xOff)
            local x = xOff or 12
            Make("TextLabel", {
                Size               = UDim2.new(0.58, 0, 0, 19),
                Position           = UDim2.new(0, x, 0, desc and 8 or 0),
                AnchorPoint        = desc and Vector2.new(0,0) or Vector2.new(0, 0.5),
                Position           = desc
                    and UDim2.new(0, x, 0, 9)
                    or  UDim2.new(0, x, 0.5, 0),
                Text               = title or "",
                TextColor3         = C.TextPrimary,
                Font               = Enum.Font.GothamSemibold,
                TextSize           = 13,
                TextXAlignment     = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent             = parent
            })
            if desc then
                Make("TextLabel", {
                    Size               = UDim2.new(0.72, 0, 0, 14),
                    Position           = UDim2.new(0, x, 0, 29),
                    Text               = desc,
                    TextColor3         = C.TextSecondary,
                    Font               = Enum.Font.Gotham,
                    TextSize           = 11,
                    TextXAlignment     = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Parent             = parent
                })
            end
        end

        -- ─── SECTION ─────────────────────────────────────────────────────────
        function T:Section(scfg)
            scfg = scfg or {}
            local sec = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 0),
                AutomaticSize    = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent           = frame
            })
            AddListLayout(sec, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 4)

            local hdr = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                Parent           = sec
            })
            Make("TextLabel", {
                Size               = UDim2.new(0, 180, 1, 0),
                Position           = UDim2.new(0, 2, 0, 0),
                Text               = (scfg.Title or "Section"):upper(),
                TextColor3         = C.TextMuted,
                Font               = Enum.Font.GothamBold,
                TextSize           = 10,
                TextXAlignment     = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent             = hdr
            })
            Make("Frame", {
                Size             = UDim2.new(1, -185, 0, 1),
                Position         = UDim2.new(0, 188, 0.5, 0),
                BackgroundColor3 = C.Border,
                BorderSizePixel  = 0,
                Parent           = hdr
            })

            local S = { _frame = sec }
            for k, v in pairs(T) do
                if type(v) == "function" and k ~= "Section" and k ~= "Divider" then
                    S[k] = function(_, cfg2)
                        local orig = frame
                        frame = sec
                        local result = v(T, cfg2)
                        frame = orig
                        return result
                    end
                end
            end
            return S
        end

        -- ─── DIVIDER ─────────────────────────────────────────────────────────
        function T:Divider(text)
            local div = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Parent           = frame
            })
            if text then
                Make("TextLabel", {
                    Size               = UDim2.new(0, 130, 1, 0),
                    Position           = UDim2.new(0.5, -65, 0, 0),
                    Text               = text,
                    TextColor3         = C.TextMuted,
                    Font               = Enum.Font.Gotham,
                    TextSize           = 10,
                    BackgroundTransparency = 1,
                    Parent             = div
                })
            end
            Make("Frame", { Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,0.5,0), BackgroundColor3=C.Border, BorderSizePixel=0, Parent=div })
        end

        -- ─── LABEL ───────────────────────────────────────────────────────────
        function T:Label(lcfg)
            lcfg = lcfg or {}
            local lbl = Make("TextLabel", {
                Size               = UDim2.new(1, 0, 0, 28),
                Text               = lcfg.Title or "",
                TextColor3         = lcfg.Color or C.TextSecondary,
                Font               = lcfg.Bold and Enum.Font.GothamBold or Enum.Font.Gotham,
                TextSize           = lcfg.TextSize or 12,
                TextXAlignment     = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent             = frame
            })
            AddPadding(lbl, 0, 0, 12, 0)
            local L = {}
            function L:SetText(t)  lbl.Text      = t end
            function L:SetColor(c) lbl.TextColor3 = c end
            return L
        end

        -- ─── PARAGRAPH ───────────────────────────────────────────────────────
        function T:Paragraph(pcfg)
            pcfg = pcfg or {}
            local card = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 0),
                AutomaticSize    = Enum.AutomaticSize.Y,
                BackgroundColor3 = C.Panel,
                BorderSizePixel  = 0,
                Parent           = frame
            })
            AddCorner(card, 9)
            AddStroke(card, C.Border, 1)
            AddPadding(card, 11, 11, 13, 13)
            AddListLayout(card, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, 5)

            if pcfg.Title then
                Make("TextLabel", {
                    Size               = UDim2.new(1, 0, 0, 19),
                    Text               = pcfg.Title,
                    TextColor3         = C.TextPrimary,
                    Font               = Enum.Font.GothamBold,
                    TextSize           = 13,
                    TextXAlignment     = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Parent             = card
                })
            end
            local bodyLbl = Make("TextLabel", {
                Size               = UDim2.new(1, 0, 0, 0),
                AutomaticSize      = Enum.AutomaticSize.Y,
                Text               = pcfg.Content or "",
                TextColor3         = C.TextSecondary,
                Font               = Enum.Font.Gotham,
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Left,
                TextWrapped        = true,
                BackgroundTransparency = 1,
                Parent             = card
            })
            local P = {}
            function P:SetContent(t) bodyLbl.Text = t end
            return P
        end

        -- ─── BUTTON ──────────────────────────────────────────────────────────
        function T:Button(bcfg)
            bcfg = bcfg or {}
            local card = BaseCard(frame, 46)

            -- icon (ImageLabel / emoji fallback)
            local xOff = 12
            if bcfg.Icon then
                xOff = 40
                local ico = MakeIcon(card, bcfg.Icon, 18, C.Accent, 2)
                ico.AnchorPoint = Vector2.new(0, 0.5)
                ico.Position    = UDim2.new(0, 11, 0.5, 0)
            end

            Make("TextLabel", {
                Size               = UDim2.new(0.68, -xOff, 1, 0),
                Position           = UDim2.new(0, xOff, 0, 0),
                Text               = bcfg.Title or "Button",
                TextColor3         = C.TextPrimary,
                Font               = Enum.Font.GothamSemibold,
                TextSize           = 13,
                TextXAlignment     = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent             = card
            })

            -- right execute button
            local rbtn = Make("TextButton", {
                Size             = UDim2.new(0, 84, 0, 29),
                Position         = UDim2.new(1, -94, 0.5, -14),
                BackgroundColor3 = C.Accent,
                Text             = bcfg.ButtonText or "Execute",
                TextColor3       = Color3.new(1,1,1),
                Font             = Enum.Font.GothamBold,
                TextSize         = 12,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card
            })
            AddCorner(rbtn, 8)

            rbtn.MouseEnter:Connect(function()
                Tween(rbtn, { BackgroundColor3 = C.AccentHover }, 0.12)
            end)
            rbtn.MouseLeave:Connect(function()
                Tween(rbtn, { BackgroundColor3 = C.Accent }, 0.12)
            end)
            rbtn.MouseButton1Down:Connect(function()
                SpringTween(rbtn, { Size = UDim2.new(0, 78, 0, 26) }, 0.15)
            end)
            rbtn.MouseButton1Up:Connect(function()
                SpringTween(rbtn, { Size = UDim2.new(0, 84, 0, 29) }, 0.15)
            end)
            rbtn.MouseButton1Click:Connect(function()
                if bcfg.Callback then pcall(bcfg.Callback) end
            end)

            -- full card hover
            local clickOverlay = Make("TextButton", {
                Size                 = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text                 = "",
                Parent               = card
            })
            clickOverlay.MouseEnter:Connect(function()
                Tween(card, { BackgroundColor3 = C.SurfaceHover }, 0.1)
            end)
            clickOverlay.MouseLeave:Connect(function()
                Tween(card, { BackgroundColor3 = C.Panel }, 0.1)
            end)

            local B = {}
            function B:Lock()   rbtn.Active = false; Tween(rbtn, { BackgroundTransparency = 0.5 }, 0.1) end
            function B:Unlock() rbtn.Active = true;  Tween(rbtn, { BackgroundTransparency = 0   }, 0.1) end
            return B
        end

        -- ─── TOGGLE ──────────────────────────────────────────────────────────
        function T:Toggle(tcfg2)
            tcfg2 = tcfg2 or {}
            local h = tcfg2.Description and 54 or 46
            local card = BaseCard(frame, h)
            ElemLabel(card, tcfg2.Title, tcfg2.Description)

            local enabled = tcfg2.Value or false

            -- track
            local track = Make("Frame", {
                Size             = UDim2.new(0, 42, 0, 24),
                Position         = UDim2.new(1, -54, 0.5, -12),
                BackgroundColor3 = enabled and C.ToggleOn or C.ToggleOff,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card
            })
            AddCorner(track, 12)

            -- knob
            local knob = Make("Frame", {
                Size             = UDim2.new(0, 18, 0, 18),
                Position         = enabled
                    and UDim2.new(0, 21, 0.5, -9)
                    or  UDim2.new(0, 3,  0.5, -9),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = track
            })
            AddCorner(knob, 9)

            local click = Make("TextButton", {
                Size                 = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 4,
                Parent               = card
            })

            local function SetToggle(val, fireCallback)
                enabled = val
                Tween(track, { BackgroundColor3 = val and C.ToggleOn or C.ToggleOff }, 0.2)
                Tween(knob,  { Position = val
                    and UDim2.new(0, 21, 0.5, -9)
                    or  UDim2.new(0, 3,  0.5, -9) }, 0.22, Enum.EasingStyle.Back)
                if tcfg2.Flag then NexusUI.Flags[tcfg2.Flag] = val end
                if fireCallback and tcfg2.Callback then pcall(tcfg2.Callback, val) end
            end

            click.MouseButton1Click:Connect(function() SetToggle(not enabled, true) end)
            card.MouseEnter:Connect(function() Tween(card, { BackgroundColor3 = C.SurfaceHover }, 0.1) end)
            card.MouseLeave:Connect(function() Tween(card, { BackgroundColor3 = C.Panel }, 0.1) end)

            if tcfg2.Flag then NexusUI.Flags[tcfg2.Flag] = enabled end

            local Tog = {}
            function Tog:Set(v) SetToggle(v, true) end
            function Tog:Get() return enabled end
            return Tog
        end

        -- ─── SLIDER ──────────────────────────────────────────────────────────
        function T:Slider(scfg2)
            scfg2 = scfg2 or {}
            local min  = scfg2.Min   or 0
            local max  = scfg2.Max   or 100
            local val  = scfg2.Value or min
            local step = scfg2.Step  or 1
            local fmt  = scfg2.Format or "%g"
            local h    = scfg2.Description and 62 or 54
            local card = BaseCard(frame, h)
            ElemLabel(card, scfg2.Title, scfg2.Description)

            -- value label (accent, top-right)
            local valLabel = Make("TextLabel", {
                Size               = UDim2.new(0, 72, 0, 20),
                Position           = UDim2.new(1, -80, 0, 7),
                Text               = string.format(fmt, val),
                TextColor3         = C.Accent,
                Font               = Enum.Font.GothamBold,
                TextSize           = 13,
                TextXAlignment     = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex             = 2,
                Parent             = card
            })

            local trackH = 5
            local trackY = h - 18
            local track = Make("Frame", {
                Size             = UDim2.new(1, -24, 0, trackH),
                Position         = UDim2.new(0, 12, 0, trackY),
                BackgroundColor3 = C.TrackBg,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card
            })
            AddCorner(track, 3)

            local fill = Make("Frame", {
                Size             = UDim2.new((val - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = C.Accent,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = track
            })
            AddCorner(fill, 3)

            local handle = Make("Frame", {
                Size             = UDim2.new(0, 15, 0, 15),
                Position         = UDim2.new((val - min) / (max - min), -7, 0.5, -7),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel  = 0,
                ZIndex           = 5,
                Parent           = track
            })
            AddCorner(handle, 8)
            AddStroke(handle, C.Accent, 2)

            local dragging2 = false
            local clickArea = Make("TextButton", {
                Size                 = UDim2.new(1, 0, 0, 26),
                Position             = UDim2.new(0, 0, 0, trackY - 10),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 6,
                Parent               = card
            })

            local function UpdateSlider(mx)
                local abs     = track.AbsolutePosition.X
                local sz      = track.AbsoluteSize.X
                local pct     = math.clamp((mx - abs) / sz, 0, 1)
                local raw     = min + pct * (max - min)
                local stepped = math.clamp(math.round(raw / step) * step, min, max)
                val = stepped
                local newPct = (val - min) / (max - min)
                Tween(fill,   { Size = UDim2.new(newPct, 0, 1, 0) }, 0.04)
                Tween(handle, { Position = UDim2.new(newPct, -7, 0.5, -7) }, 0.04)
                valLabel.Text = string.format(fmt, val)
                if scfg2.Flag then NexusUI.Flags[scfg2.Flag] = val end
                if scfg2.Callback then pcall(scfg2.Callback, val) end
            end

            clickArea.MouseButton1Down:Connect(function()
                dragging2 = true
                UpdateSlider(Mouse.X)
                SpringTween(handle, { Size = UDim2.new(0, 18, 0, 18) }, 0.2)
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging2 = false
                    Tween(handle, { Size = UDim2.new(0, 15, 0, 15) }, 0.15)
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if dragging2 and i.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateSlider(i.Position.X)
                end
            end)

            if scfg2.Flag then NexusUI.Flags[scfg2.Flag] = val end

            local Sl = {}
            function Sl:Set(v)
                val = math.clamp(v, min, max)
                local p = (val - min) / (max - min)
                Tween(fill,   { Size = UDim2.new(p, 0, 1, 0) }, 0.15)
                Tween(handle, { Position = UDim2.new(p, -7, 0.5, -7) }, 0.15)
                valLabel.Text = string.format(fmt, val)
            end
            function Sl:Get() return val end
            return Sl
        end

        -- ─── DROPDOWN ────────────────────────────────────────────────────────
        -- Redesign: selected value shown as a styled chip on the right.
        -- Popup items highlight the active selection with accent + checkmark.
        function T:Dropdown(dcfg)
            dcfg = dcfg or {}
            local options  = dcfg.Options or {}
            local selected = dcfg.Value
            local isOpen   = false
            local h        = dcfg.Description and 54 or 46

            -- wrapper (clips=false so popup overflows)
            local wrapper = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, h),
                BackgroundTransparency = 1,
                ClipsDescendants     = false,
                ZIndex               = 10,
                Parent               = frame
            })

            -- card
            local card = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, h),
                BackgroundColor3 = C.Panel,
                BorderSizePixel  = 0,
                ZIndex           = 10,
                Parent           = wrapper
            })
            AddCorner(card, 9)
            AddStroke(card, C.Border, 1)
            ElemLabel(card, dcfg.Title, dcfg.Description)

            -- ── Selected-value chip (right side) ──────────────────────────
            local chipW = 120
            local chip = Make("Frame", {
                Size             = UDim2.new(0, chipW, 0, 28),
                Position         = UDim2.new(1, -(chipW + 12), 0.5, -14),
                BackgroundColor3 = C.TrackBg,
                BorderSizePixel  = 0,
                ZIndex           = 11,
                Parent           = card
            })
            AddCorner(chip, 7)
            AddStroke(chip, C.Border, 1)

            -- chip text (selected value)
            local selLabel = Make("TextLabel", {
                Size               = UDim2.new(1, -28, 1, 0),
                Position           = UDim2.new(0, 10, 0, 0),
                Text               = selected or "Select...",
                TextColor3         = selected and C.TextPrimary or C.TextMuted,
                Font               = Enum.Font.GothamSemibold,
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                ZIndex             = 12,
                Parent             = chip
            })

            -- chevron icon inside chip
            local chevron = MakeIcon(chip, "ChevronDown", 14, C.TextMuted, 12)
            chevron.AnchorPoint = Vector2.new(1, 0.5)
            chevron.Position    = UDim2.new(1, -7, 0.5, 0)

            -- ── Dropdown popup ────────────────────────────────────────────
            local itemH     = 34
            local popupPad  = 6
            local totalH    = #options * itemH + popupPad * 2

            local popup = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 0),
                Position         = UDim2.new(0, 0, 1, 6),
                BackgroundColor3 = C.Surface,
                BorderSizePixel  = 0,
                ClipsDescendants = true,
                ZIndex           = 20,
                Visible          = false,
                Parent           = wrapper
            })
            AddCorner(popup, 9)
            AddStroke(popup, C.Border, 1)
            AddPadding(popup, popupPad, popupPad, 5, 5)
            AddListLayout(popup, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 2)

            -- track all option buttons to update checkmark when selection changes
            local optButtons = {}

            local function RefreshOptionStates()
                for _, ob in ipairs(optButtons) do
                    local isSelected = (ob._opt == selected)
                    Tween(ob._frame, {
                        BackgroundColor3     = isSelected and C.AccentSoft or Color3.fromRGB(0,0,0),
                        BackgroundTransparency = isSelected and 0.88 or 1
                    }, 0.12)
                    ob._label.TextColor3 = isSelected and C.Accent or C.TextSecondary
                    ob._label.Font       = isSelected and Enum.Font.GothamBold or Enum.Font.GothamSemibold
                    -- checkmark: show only if selected
                    ob._check.Visible    = isSelected
                end
            end

            for _, opt in ipairs(options) do
                local ob = Make("Frame", {
                    Size                 = UDim2.new(1, 0, 0, itemH),
                    BackgroundColor3     = Color3.fromRGB(0,0,0),
                    BackgroundTransparency = 1,
                    BorderSizePixel      = 0,
                    ZIndex               = 21,
                    Parent               = popup
                })
                AddCorner(ob, 7)

                -- option label
                local lbl = Make("TextLabel", {
                    Size               = UDim2.new(1, -40, 1, 0),
                    Position           = UDim2.new(0, 12, 0, 0),
                    Text               = opt,
                    TextColor3         = C.TextSecondary,
                    Font               = Enum.Font.GothamSemibold,
                    TextSize           = 13,
                    TextXAlignment     = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    ZIndex             = 22,
                    Parent             = ob
                })

                -- checkmark icon (hidden when not selected)
                local chk = MakeIcon(ob, "Check", 14, C.Accent, 22)
                chk.AnchorPoint = Vector2.new(1, 0.5)
                chk.Position    = UDim2.new(1, -10, 0.5, 0)
                chk.Visible     = false

                local clickBtn = Make("TextButton", {
                    Size                 = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 23,
                    Parent               = ob
                })

                table.insert(optButtons, { _frame = ob, _label = lbl, _check = chk, _opt = opt })

                clickBtn.MouseEnter:Connect(function()
                    if opt ~= selected then
                        Tween(ob, { BackgroundColor3 = C.SurfaceHover, BackgroundTransparency = 0 }, 0.1)
                        lbl.TextColor3 = C.TextPrimary
                    end
                end)
                clickBtn.MouseLeave:Connect(function()
                    if opt ~= selected then
                        Tween(ob, { BackgroundTransparency = 1 }, 0.1)
                        lbl.TextColor3 = C.TextSecondary
                    end
                end)
                clickBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    -- update chip
                    selLabel.Text      = opt
                    selLabel.TextColor3 = C.TextPrimary
                    -- chip accent flash
                    Tween(chip, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0.88 }, 0.12)
                    task.delay(0.25, function()
                        Tween(chip, { BackgroundColor3 = C.TrackBg, BackgroundTransparency = 0 }, 0.18)
                    end)
                    -- update checkmarks
                    RefreshOptionStates()
                    -- close
                    isOpen = false
                    Tween(popup, { Size = UDim2.new(1, 0, 0, 0) }, 0.18, Enum.EasingStyle.Quart)
                    if chevron:IsA("ImageLabel") then
                        Tween(chevron, { ImageColor3 = C.TextMuted }, 0.18)
                    end
                    task.delay(0.2, function() popup.Visible = false end)
                    if dcfg.Flag then NexusUI.Flags[dcfg.Flag] = opt end
                    if dcfg.Callback then pcall(dcfg.Callback, opt) end
                end)
            end

            -- initial state
            RefreshOptionStates()

            -- open/close toggle
            local chipClick = Make("TextButton", {
                Size                 = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 13,
                Parent               = card
            })
            chipClick.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    popup.Visible = true
                    popup.Size    = UDim2.new(1, 0, 0, 0)
                    Tween(popup, { Size = UDim2.new(1, 0, 0, totalH) }, 0.22, Enum.EasingStyle.Back)
                    Tween(chip, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0.85 }, 0.12)
                    if chevron:IsA("ImageLabel") then
                        Tween(chevron, { ImageColor3 = C.Accent }, 0.15)
                    end
                else
                    Tween(popup, { Size = UDim2.new(1, 0, 0, 0) }, 0.18)
                    Tween(chip, { BackgroundColor3 = C.TrackBg, BackgroundTransparency = 0 }, 0.15)
                    if chevron:IsA("ImageLabel") then
                        Tween(chevron, { ImageColor3 = C.TextMuted }, 0.15)
                    end
                    task.delay(0.2, function() popup.Visible = false end)
                end
            end)
            -- hover on card
            chipClick.MouseEnter:Connect(function()
                Tween(card, { BackgroundColor3 = C.SurfaceHover }, 0.1)
            end)
            chipClick.MouseLeave:Connect(function()
                Tween(card, { BackgroundColor3 = C.Panel }, 0.1)
            end)

            local D = {}
            function D:Set(v)
                selected = v
                selLabel.Text       = v
                selLabel.TextColor3 = C.TextPrimary
                RefreshOptionStates()
            end
            function D:Get() return selected end
            function D:Refresh(opts)
                for _, b in ipairs(optButtons) do b._frame:Destroy() end
                optButtons = {}
                options    = opts
                totalH     = #opts * itemH + popupPad * 2
            end
            return D
        end

        -- ─── INPUT ───────────────────────────────────────────────────────────
        function T:Input(icfg)
            icfg = icfg or {}
            local h    = icfg.Description and 62 or 54
            local card = BaseCard(frame, h)
            ElemLabel(card, icfg.Title, icfg.Description)

            local box = Make("TextBox", {
                Size               = UDim2.new(0, 158, 0, 30),
                Position           = UDim2.new(1, -168, 0.5, -15),
                BackgroundColor3   = C.TrackBg,
                Text               = icfg.Value or "",
                PlaceholderText    = icfg.Placeholder or "Enter...",
                TextColor3         = C.TextPrimary,
                PlaceholderColor3  = C.TextMuted,
                Font               = Enum.Font.Gotham,
                TextSize           = 12,
                BorderSizePixel    = 0,
                ClearTextOnFocus   = icfg.ClearOnFocus or false,
                ZIndex             = 2,
                Parent             = card
            })
            AddCorner(box, 8)
            AddStroke(box, C.Border, 1)
            AddPadding(box, 0, 0, 9, 9)

            box.Focused:Connect(function()
                Tween(box, { BackgroundColor3 = C.SurfaceHover }, 0.12)
                for _, c in ipairs(box:GetChildren()) do
                    if c:IsA("UIStroke") then c:Destroy() end
                end
                AddStroke(box, C.Accent, 1.5)
            end)
            box.FocusLost:Connect(function(enter)
                Tween(box, { BackgroundColor3 = C.TrackBg }, 0.12)
                for _, c in ipairs(box:GetChildren()) do
                    if c:IsA("UIStroke") then c:Destroy() end
                end
                AddStroke(box, C.Border, 1)
                if icfg.Flag then NexusUI.Flags[icfg.Flag] = box.Text end
                if icfg.Callback then pcall(icfg.Callback, box.Text, enter) end
            end)

            local I = {}
            function I:Set(t) box.Text = t end
            function I:Get()  return box.Text end
            return I
        end

        -- ─── KEYBIND ─────────────────────────────────────────────────────────
        function T:Keybind(kcfg)
            kcfg = kcfg or {}
            local currentKey = kcfg.Value or Enum.KeyCode.Unknown
            local listening  = false
            local card = BaseCard(frame, 46)
            ElemLabel(card, kcfg.Title, kcfg.Description)

            -- keyboard icon on left of key button
            local kbdIcon = MakeIcon(card, "Keyboard", 16, C.TextMuted, 2)
            kbdIcon.AnchorPoint = Vector2.new(1, 0.5)
            kbdIcon.Position    = UDim2.new(1, -100, 0.5, 0)

            local keyBtn = Make("TextButton", {
                Size             = UDim2.new(0, 78, 0, 28),
                Position         = UDim2.new(1, -88, 0.5, -14),
                BackgroundColor3 = C.TrackBg,
                Text             = currentKey == Enum.KeyCode.Unknown and "None" or currentKey.Name,
                TextColor3       = C.TextPrimary,
                Font             = Enum.Font.GothamBold,
                TextSize         = 12,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card
            })
            AddCorner(keyBtn, 8)
            AddStroke(keyBtn, C.Border, 1)

            keyBtn.MouseButton1Click:Connect(function()
                listening = true
                keyBtn.Text      = "..."
                keyBtn.TextColor3 = C.Accent
                Tween(keyBtn, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0.88 }, 0.12)
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if listening then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey        = input.KeyCode
                        keyBtn.Text       = currentKey.Name
                        keyBtn.TextColor3 = C.TextPrimary
                        Tween(keyBtn, { BackgroundColor3 = C.TrackBg, BackgroundTransparency = 0 }, 0.12)
                        listening = false
                        if kcfg.Flag then NexusUI.Flags[kcfg.Flag] = currentKey end
                        if kcfg.Callback then pcall(kcfg.Callback, currentKey) end
                    end
                elseif currentKey ~= Enum.KeyCode.Unknown and input.KeyCode == currentKey then
                    if kcfg.OnPress then pcall(kcfg.OnPress) end
                end
            end)

            local K = {}
            function K:Set(kc) currentKey = kc; keyBtn.Text = kc.Name end
            function K:Get()   return currentKey end
            return K
        end

        -- ─── COLOR PICKER ────────────────────────────────────────────────────
        function T:ColorPicker(cpcfg)
            cpcfg = cpcfg or {}
            local currentColor = cpcfg.Value or Color3.fromHex("#5865f2")
            local isOpen = false
            local h, s, v2 = currentColor:ToHSV()

            local wrapper = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 46),
                BackgroundTransparency = 1,
                ClipsDescendants     = false,
                ZIndex               = 10,
                Parent               = frame
            })

            local card = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 46),
                BackgroundColor3 = C.Panel,
                BorderSizePixel  = 0,
                ZIndex           = 10,
                Parent           = wrapper
            })
            AddCorner(card, 9)
            AddStroke(card, C.Border, 1)
            ElemLabel(card, cpcfg.Title, cpcfg.Description)

            -- palette icon
            local palIco = MakeIcon(card, "Palette", 16, C.TextMuted, 11)
            palIco.AnchorPoint = Vector2.new(1, 0.5)
            palIco.Position    = UDim2.new(1, -72, 0.5, 0)

            -- swatch
            local swatch = Make("Frame", {
                Size             = UDim2.new(0, 48, 0, 26),
                Position         = UDim2.new(1, -60, 0.5, -13),
                BackgroundColor3 = currentColor,
                BorderSizePixel  = 0,
                ZIndex           = 11,
                Parent           = card
            })
            AddCorner(swatch, 7)
            AddStroke(swatch, C.Border, 1)

            -- hex label
            local hexLabel = Make("TextLabel", {
                Size               = UDim2.new(0, 48, 0, 14),
                Position           = UDim2.new(1, -60, 1, -15),
                Text               = ColorToHex(currentColor),
                TextColor3         = C.TextMuted,
                Font               = Enum.Font.Gotham,
                TextSize           = 9,
                BackgroundTransparency = 1,
                ZIndex             = 12,
                Parent             = card
            })

            -- picker popup
            local popup = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 0),
                Position         = UDim2.new(0, 0, 1, 6),
                BackgroundColor3 = C.Surface,
                BorderSizePixel  = 0,
                ClipsDescendants = true,
                ZIndex           = 20,
                Visible          = false,
                Parent           = wrapper
            })
            AddCorner(popup, 10)
            AddStroke(popup, C.Border, 1)
            AddPadding(popup, 10, 10, 10, 10)

            local popH = 160

            local svFrame = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 100),
                BackgroundColor3 = Color3.new(1, 0, 0),
                BorderSizePixel  = 0,
                ZIndex           = 21,
                Parent           = popup
            })
            AddCorner(svFrame, 6)

            local wGrad = Make("Frame", {
                Size             = UDim2.new(1,0,1,0),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel  = 0,
                ZIndex           = 22,
                Parent           = svFrame
            })
            AddCorner(wGrad, 6)
            Make("UIGradient", {
                Color        = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
                    ColorSequenceKeypoint.new(1, Color3.new(1,1,1)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                }),
                Parent = wGrad
            })

            local bGrad = Make("Frame", {
                Size             = UDim2.new(1,0,1,0),
                BackgroundColor3 = Color3.new(0,0,0),
                BorderSizePixel  = 0,
                ZIndex           = 23,
                Parent           = svFrame
            })
            AddCorner(bGrad, 6)
            Make("UIGradient", {
                Color        = ColorSequence.new(Color3.new(0,0,0)),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0),
                }),
                Rotation = -90,
                Parent   = bGrad
            })

            local svCursor = Make("Frame", {
                Size             = UDim2.new(0, 10, 0, 10),
                Position         = UDim2.new(s, -5, 1 - v2, -5),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel  = 0,
                ZIndex           = 25,
                Parent           = svFrame
            })
            AddCorner(svCursor, 5)
            AddStroke(svCursor, Color3.new(0,0,0), 1.5)

            local hueBar = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 14),
                Position         = UDim2.new(0, 0, 1, 10),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel  = 0,
                ZIndex           = 21,
                Parent           = svFrame
            })
            AddCorner(hueBar, 6)
            Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0,    Color3.fromHex("#ff0000")),
                    ColorSequenceKeypoint.new(0.166, Color3.fromHex("#ffff00")),
                    ColorSequenceKeypoint.new(0.333, Color3.fromHex("#00ff00")),
                    ColorSequenceKeypoint.new(0.5,   Color3.fromHex("#00ffff")),
                    ColorSequenceKeypoint.new(0.666, Color3.fromHex("#0000ff")),
                    ColorSequenceKeypoint.new(0.833, Color3.fromHex("#ff00ff")),
                    ColorSequenceKeypoint.new(1,     Color3.fromHex("#ff0000")),
                }),
                Parent = hueBar
            })

            local hueCursor = Make("Frame", {
                Size             = UDim2.new(0, 4, 1, 4),
                Position         = UDim2.new(h, -2, 0, -2),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel  = 0,
                ZIndex           = 22,
                Parent           = hueBar
            })
            AddCorner(hueCursor, 3)
            AddStroke(hueCursor, Color3.new(0,0,0), 1)

            local function UpdateColor()
                local col = HsvToColor3(h, s, v2)
                currentColor = col
                swatch.BackgroundColor3 = col
                svFrame.BackgroundColor3 = HsvToColor3(h, 1, 1)
                svCursor.Position  = UDim2.new(s, -5, 1 - v2, -5)
                hueCursor.Position = UDim2.new(h, -2, 0, -2)
                hexLabel.Text = ColorToHex(col)
                if cpcfg.Flag then NexusUI.Flags[cpcfg.Flag] = col end
                if cpcfg.Callback then pcall(cpcfg.Callback, col) end
            end

            local draggingSV = false
            local draggingH  = false

            local svClick = Make("TextButton", {
                Size                 = UDim2.new(1,0,0,100),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 26,
                Parent               = svFrame
            })
            svClick.MouseButton1Down:Connect(function()
                draggingSV = true
                local rx = math.clamp((Mouse.X - svFrame.AbsolutePosition.X) / svFrame.AbsoluteSize.X, 0, 1)
                local ry = math.clamp((Mouse.Y - svFrame.AbsolutePosition.Y) / svFrame.AbsoluteSize.Y, 0, 1)
                s = rx; v2 = 1 - ry
                UpdateColor()
            end)

            local hClick = Make("TextButton", {
                Size                 = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 26,
                Parent               = hueBar
            })
            hClick.MouseButton1Down:Connect(function()
                draggingH = true
                h = math.clamp((Mouse.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
                UpdateColor()
            end)

            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSV = false
                    draggingH  = false
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement then
                    if draggingSV then
                        local rx = math.clamp((Mouse.X - svFrame.AbsolutePosition.X) / svFrame.AbsoluteSize.X, 0, 1)
                        local ry = math.clamp((Mouse.Y - svFrame.AbsolutePosition.Y) / svFrame.AbsoluteSize.Y, 0, 1)
                        s = rx; v2 = 1 - ry
                        UpdateColor()
                    elseif draggingH then
                        h = math.clamp((Mouse.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
                        UpdateColor()
                    end
                end
            end)

            local swatchClick = Make("TextButton", {
                Size                 = UDim2.new(0, 60, 0, 38),
                Position             = UDim2.new(1, -68, 0.5, -19),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 12,
                Parent               = card
            })
            swatchClick.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    popup.Visible = true
                    popup.Size    = UDim2.new(1,0,0,0)
                    Tween(popup, { Size = UDim2.new(1, 0, 0, popH) }, 0.22, Enum.EasingStyle.Back)
                else
                    Tween(popup, { Size = UDim2.new(1,0,0,0) }, 0.18)
                    task.delay(0.2, function() popup.Visible = false end)
                end
            end)

            local CP = {}
            function CP:Set(c)
                currentColor = c
                h, s, v2 = c:ToHSV()
                UpdateColor()
            end
            function CP:Get() return currentColor end
            return CP
        end

        -- ─── PROGRESS ────────────────────────────────────────────────────────
        function T:Progress(pgcfg)
            pgcfg = pgcfg or {}
            local val  = pgcfg.Value or 0
            local h    = pgcfg.Description and 54 or 46
            local card = BaseCard(frame, h)
            ElemLabel(card, pgcfg.Title, pgcfg.Description)

            local pctLabel = Make("TextLabel", {
                Size               = UDim2.new(0, 48, 0, 22),
                Position           = UDim2.new(1, -56, 0, pgcfg.Description and 7 or 0),
                AnchorPoint        = pgcfg.Description and Vector2.new(0,0) or Vector2.new(0, 0.5),
                Position           = pgcfg.Description
                    and UDim2.new(1, -58, 0, 7)
                    or  UDim2.new(1, -58, 0.5, -11),
                Text               = math.round(val) .. "%",
                TextColor3         = C.Accent,
                Font               = Enum.Font.GothamBold,
                TextSize           = 13,
                TextXAlignment     = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex             = 2,
                Parent             = card
            })

            local track = Make("Frame", {
                Size             = UDim2.new(1, -24, 0, 6),
                Position         = UDim2.new(0, 12, 1, -16),
                BackgroundColor3 = C.TrackBg,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card
            })
            AddCorner(track, 4)

            local fill = Make("Frame", {
                Size             = UDim2.new(val/100, 0, 1, 0),
                BackgroundColor3 = C.Accent,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = track
            })
            AddCorner(fill, 4)

            local PG = {}
            function PG:Set(p)
                p = math.clamp(p, 0, 100)
                val = p
                Tween(fill, { Size = UDim2.new(p/100, 0, 1, 0) }, 0.3, Enum.EasingStyle.Quart)
                pctLabel.Text = math.round(p) .. "%"
            end
            function PG:Get() return val end
            return PG
        end

        return T
    end -- end Window:Tab

    -- ── Sidebar section header ──
    function Window:Section(scfg)
        scfg = scfg or {}
        Make("TextLabel", {
            Size               = UDim2.new(1, 0, 0, 24),
            Text               = ("  " .. (scfg.Title or "")):upper(),
            TextColor3         = C.TextMuted,
            Font               = Enum.Font.GothamBold,
            TextSize           = 9,
            TextXAlignment     = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent             = tabList
        })
    end

    function Window:Divider()
        Make("Frame", {
            Size             = UDim2.new(0.85, 0, 0, 1),
            BackgroundColor3 = C.Border,
            BorderSizePixel  = 0,
            Parent           = tabList
        })
    end

    function Window:Notify(cfg2)
        cfg2.Theme = self.ThemeName
        return Notify(cfg2)
    end

    -- ── Dialog ──
    function Window:Dialog(dcfg)
        dcfg = dcfg or {}
        local overlay = Make("Frame", {
            Size                 = UDim2.new(1,0,1,0),
            BackgroundColor3     = Color3.new(0,0,0),
            BackgroundTransparency = 0.5,
            BorderSizePixel      = 0,
            ZIndex               = 50,
            Parent               = win
        })

        local dW = dcfg.Width or 320
        local dialog = Make("Frame", {
            Size             = UDim2.new(0, dW, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            Position         = UDim2.new(0.5, -dW/2, 0.5, -80),
            BackgroundColor3 = C.Surface,
            BorderSizePixel  = 0,
            ZIndex           = 51,
            Parent           = overlay
        })
        AddCorner(dialog, 12)
        AddStroke(dialog, C.Border, 1)
        AddPadding(dialog, 18, 18, 18, 18)
        AddListLayout(dialog, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, 10)

        Make("TextLabel", {
            Size               = UDim2.new(1, 0, 0, 22),
            Text               = dcfg.Title or "Dialog",
            TextColor3         = C.TextPrimary,
            Font               = Enum.Font.GothamBold,
            TextSize           = 15,
            TextXAlignment     = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex             = 52,
            Parent             = dialog
        })

        if dcfg.Content then
            Make("TextLabel", {
                Size               = UDim2.new(1, 0, 0, 0),
                AutomaticSize      = Enum.AutomaticSize.Y,
                Text               = dcfg.Content,
                TextColor3         = C.TextSecondary,
                Font               = Enum.Font.Gotham,
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Left,
                TextWrapped        = true,
                BackgroundTransparency = 1,
                ZIndex             = 52,
                Parent             = dialog
            })
        end

        local btnRow = Make("Frame", {
            Size                 = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            ZIndex               = 52,
            Parent               = dialog
        })
        Make("UIListLayout", {
            FillDirection        = Enum.FillDirection.Horizontal,
            HorizontalAlignment  = Enum.HorizontalAlignment.Right,
            SortOrder            = Enum.SortOrder.LayoutOrder,
            Padding              = UDim.new(0, 8),
            Parent               = btnRow
        })

        for _, b in ipairs(dcfg.Buttons or {}) do
            local isPrimary = b.Variant == "Primary"
            local db = Make("TextButton", {
                Size             = UDim2.new(0, 92, 0, 33),
                BackgroundColor3 = isPrimary and C.Accent or C.TrackBg,
                Text             = b.Title or "OK",
                TextColor3       = isPrimary and Color3.new(1,1,1) or C.TextSecondary,
                Font             = Enum.Font.GothamBold,
                TextSize         = 12,
                BorderSizePixel  = 0,
                ZIndex           = 53,
                Parent           = btnRow
            })
            AddCorner(db, 8)
            if not isPrimary then AddStroke(db, C.Border, 1) end
            db.MouseButton1Click:Connect(function()
                overlay:Destroy()
                if b.Callback then pcall(b.Callback) end
            end)
            db.MouseEnter:Connect(function()
                Tween(db, { BackgroundColor3 = isPrimary and C.AccentHover or C.SurfaceHover }, 0.12)
            end)
            db.MouseLeave:Connect(function()
                Tween(db, { BackgroundColor3 = isPrimary and C.Accent or C.TrackBg }, 0.12)
            end)
        end

        dialog.Position              = UDim2.new(0.5, -dW/2, 0.5, -60)
        dialog.BackgroundTransparency = 1
        SpringTween(dialog, { Position = UDim2.new(0.5, -dW/2, 0.5, -80), BackgroundTransparency = 0 })
    end

    -- ── Visibility ──
    function Window:Toggle()
        win.Visible    = not win.Visible
        shadow.Visible = win.Visible
    end

    function Window:Open()
        win.Visible    = true
        shadow.Visible = true
        win.Size = UDim2.new(0, W * 0.95, 0, H * 0.95)
        win.BackgroundTransparency = 1
        SpringTween(win, { Size = UDim2.new(0, W, 0, H), BackgroundTransparency = 0 })
    end

    function Window:Close()
        Tween(win, { Size = UDim2.new(0, W * 0.95, 0, H * 0.95), BackgroundTransparency = 1 }, 0.2)
        task.delay(0.25, function()
            win.Visible    = false
            shadow.Visible = false
        end)
    end

    function Window:Destroy()
        self:Close()
        task.delay(0.3, function() sg:Destroy() end)
    end

    function Window:SetTheme(name)
        local nc = Themes[name]
        if not nc then return end
        C = nc
        self.Theme     = nc
        self.ThemeName = name
        Tween(win,     { BackgroundColor3 = nc.Background }, 0.3)
        Tween(topbar,  { BackgroundColor3 = nc.Topbar     }, 0.3)
        Tween(sidebar, { BackgroundColor3 = nc.Sidebar    }, 0.3)
    end

    -- ── Close / Minimize click handlers ──
    local closeBtnClick = Make("TextButton", {
        Size                 = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        Text                 = "",
        ZIndex               = 6,
        Parent               = closeBtn
    })
    closeBtnClick.MouseButton1Click:Connect(function() Window:Close() end)

    local minBtnClick = Make("TextButton", {
        Size                 = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        Text                 = "",
        ZIndex               = 6,
        Parent               = minBtn
    })
    minBtnClick.MouseButton1Click:Connect(function()
        content.Visible  = not content.Visible
        sidebar.Visible  = not sidebar.Visible
        local newH = content.Visible and H or 50
        Tween(win, { Size = UDim2.new(0, W, 0, newH) }, 0.25, Enum.EasingStyle.Back)
    end)

    -- ── Toggle key ──
    if cfg.ToggleKey then
        UserInputService.InputBegan:Connect(function(input, gpe)
            if not gpe and input.KeyCode == cfg.ToggleKey then
                Window:Toggle()
            end
        end)
    end

    -- entrance
    win.Size = UDim2.new(0, W * 0.92, 0, H * 0.92)
    win.BackgroundTransparency = 0.3
    SpringTween(win, { Size = UDim2.new(0, W, 0, H), BackgroundTransparency = 0 })

    table.insert(NexusUI._windows, Window)
    return Window
end

-- ──────────────────────────────────────────────────────────────────────────────
-- GLOBAL NOTIFY shortcut
-- ──────────────────────────────────────────────────────────────────────────────
function NexusUI:Notify(cfg)
    return Notify(cfg)
end

return NexusUI
