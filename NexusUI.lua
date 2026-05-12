--[[
    NexusUI — Roblox Script Hub UI Library
    Style: Modern dark glass, smooth animations, full component set
    Components: Window · Tab · Section · Toggle · Button · Slider
                Dropdown · Input · ColorPicker · Keybind · Label
                Paragraph · Divider · Notification · Dialog · Progress
    
    Usage:
        local NexusUI = loadstring(game:HttpGet("..."))()
        local Window  = NexusUI:CreateWindow({ Title="My Hub", Theme="Dark" })
        local Tab     = Window:Tab({ Title="Main", Icon="⚡" })
        Tab:Toggle({ Title="Speed", Value=false, Callback=function(v) end })
]]

-- ──────────────────────────────────────────────────────────────────────────────
-- SERVICES
-- ──────────────────────────────────────────────────────────────────────────────
local TweenService   = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService     = game:GetService("RunService")
local Players        = game:GetService("Players")
local CoreGui        = game:GetService("CoreGui")
local HttpService    = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()

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
        AccentSoft     = Color3.fromHex("#5865f215"),
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
        AccentSoft     = Color3.fromHex("#00b4d815"),
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
        AccentSoft     = Color3.fromHex("#e879a015"),
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
        AccentSoft     = Color3.fromHex("#f59e0b15"),
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
        AccentSoft     = Color3.fromHex("#5865f210"),
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
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ──────────────────────────────────────────────────────────────────────────────
-- NOTIFICATION SYSTEM (standalone, top-right corner)
-- ──────────────────────────────────────────────────────────────────────────────
local NotifHolder
local function EnsureNotifHolder()
    if NotifHolder and NotifHolder.Parent then return end
    local sg = Make("ScreenGui", {
        Name = "NexusUI_Notifs",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = (pcall(function() return CoreGui end) and CoreGui) or LocalPlayer.PlayerGui
    })
    NotifHolder = Make("Frame", {
        Name = "Holder",
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(1, -315, 0, 0),
        BackgroundTransparency = 1,
        Parent = sg
    })
    AddListLayout(NotifHolder, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right, 8)
    AddPadding(NotifHolder, 16, 16, 0, 0)
end

local function Notify(cfg)
    EnsureNotifHolder()
    local theme = Themes[cfg.Theme or "Dark"]
    local typeColors = {
        success = theme.Success,
        warning = theme.Warning,
        error   = theme.Error,
        info    = theme.Accent,
    }
    local accent = typeColors[cfg.Type or "info"] or theme.Accent

    local card = Make("Frame", {
        Name = "Notif",
        Size = UDim2.new(1, 0, 0, 72),
        BackgroundColor3 = theme.Panel,
        BackgroundTransparency = 0,
        ClipsDescendants = true,
        Parent = NotifHolder
    })
    AddCorner(card, 10)
    AddStroke(card, theme.Border, 1)

    -- accent bar left
    Make("Frame", {
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Parent = card
    })
    AddCorner(card:FindFirstChild("Frame"), 3)

    -- progress bar bottom
    local progress = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        ZIndex = 5,
        Parent = card
    })

    -- title
    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 14, 0, 10),
        Text = cfg.Title or "Notification",
        TextColor3 = theme.TextPrimary,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Parent = card
    })

    -- content
    if cfg.Content then
        Make("TextLabel", {
            Size = UDim2.new(1, -20, 0, 30),
            Position = UDim2.new(0, 14, 0, 32),
            Text = cfg.Content,
            TextColor3 = theme.TextSecondary,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            BackgroundTransparency = 1,
            Parent = card
        })
    end

    -- slide-in animation
    card.Position = UDim2.new(1, 20, 0, 0)
    Tween(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    local duration = cfg.Duration or 4
    -- progress shrink
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
NexusUI.Version  = "1.0.0"
NexusUI.Flags    = {}   -- global config flags
NexusUI._windows = {}

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
    local C = Themes[cfg.Theme] or Themes.Dark   -- color table shorthand

    -- ── GUI root ──
    local sg = Make("ScreenGui", {
        Name = "NexusUI_" .. (cfg.Title or "Hub"),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = (pcall(function() return CoreGui end) and CoreGui) or LocalPlayer.PlayerGui
    })

    -- ── Shadow ──
    local shadow = Make("Frame", {
        Name = "Shadow",
        Size = UDim2.new(0, (cfg.Width or 660) + 30, 0, (cfg.Height or 460) + 30),
        Position = UDim2.new(0.5, -((cfg.Width or 660) + 30)/2, 0.5, -((cfg.Height or 460) + 30)/2),
        BackgroundColor3 = C.Shadow,
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        ZIndex = 0,
        Parent = sg
    })
    AddCorner(shadow, 18)

    -- ── Main window frame ──
    local W = cfg.Width or 660
    local H = cfg.Height or 460
    local win = Make("Frame", {
        Name = "Window",
        Size = UDim2.new(0, W, 0, H),
        Position = UDim2.new(0.5, -W/2, 0.5, -H/2),
        BackgroundColor3 = C.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = sg
    })
    AddCorner(win, 14)
    AddStroke(win, C.Border, 1)

    -- ── Topbar ──
    local topbar = Make("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = C.Topbar,
        BorderSizePixel = 0,
        ZIndex = 4,
        Parent = win
    })
    -- topbar bottom border
    Make("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = C.Border,
        BorderSizePixel = 0,
        Parent = topbar
    })

    -- Title & Author
    local titleLabel = Make("TextLabel", {
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        Text = cfg.Title or "NexusUI",
        TextColor3 = C.TextPrimary,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        ZIndex = 4,
        Parent = topbar
    })
    if cfg.Author then
        titleLabel.Size = UDim2.new(0, 300, 0, 22)
        titleLabel.Position = UDim2.new(0, 16, 0, 5)
        Make("TextLabel", {
            Size = UDim2.new(0, 300, 0, 16),
            Position = UDim2.new(0, 16, 0, 28),
            Text = cfg.Author,
            TextColor3 = C.TextMuted,
            Font = Enum.Font.Gotham,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex = 4,
            Parent = topbar
        })
    end

    -- Window control buttons (close / minimize)
    local function WinBtn(xOffset, bgColor, symbol)
        local btn = Make("Frame", {
            Name = "Btn",
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(1, xOffset, 0.5, -7),
            BackgroundColor3 = bgColor,
            BorderSizePixel = 0,
            ZIndex = 5,
            Parent = topbar
        })
        AddCorner(btn, 7)
        Make("TextLabel", {
            Size = UDim2.new(1,0,1,0),
            Text = symbol,
            TextColor3 = Color3.new(0,0,0),
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            BackgroundTransparency = 1,
            ZIndex = 6,
            Parent = btn
        })
        return btn
    end

    local closeBtn = WinBtn(-28, Color3.fromHex("#ed4245"), "✕")
    local minBtn   = WinBtn(-50, Color3.fromHex("#faa61a"), "—")

    -- drag
    MakeDraggable(topbar, win)
    -- shadow follows
    local function SyncShadow()
        shadow.Position = UDim2.new(
            win.Position.X.Scale,
            win.Position.X.Offset - 15,
            win.Position.Y.Scale,
            win.Position.Y.Offset - 15
        )
    end
    RunService.RenderStepped:Connect(SyncShadow)

    -- ── Sidebar ──
    local sidebarW = cfg.SideBarWidth or 190
    local sidebar = Make("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, sidebarW, 1, -50),
        Position = UDim2.new(0, 0, 0, 50),
        BackgroundColor3 = C.Sidebar,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = win
    })
    -- sidebar right border
    Make("Frame", {
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = C.Border,
        BorderSizePixel = 0,
        Parent = sidebar
    })

    -- Tab list scroll frame
    local tabList = Make("ScrollingFrame", {
        Name = "TabList",
        Size = UDim2.new(1, 0, 1, -60),
        Position = UDim2.new(0, 0, 0, 8),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = C.Scrollbar,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = sidebar
    })
    AddListLayout(tabList, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 2)
    AddPadding(tabList, 4, 4, 8, 8)

    -- Version label at bottom of sidebar
    Make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 24),
        Position = UDim2.new(0, 0, 1, -28),
        Text = "NexusUI v" .. NexusUI.Version,
        TextColor3 = C.TextMuted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Parent = sidebar
    })

    -- ── Content area ──
    local content = Make("ScrollingFrame", {
        Name = "Content",
        Size = UDim2.new(1, -sidebarW, 1, -50),
        Position = UDim2.new(0, sidebarW, 0, 50),
        BackgroundColor3 = C.Background,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = C.Scrollbar,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = win
    })

    -- ── Window object ──
    local Window = {
        _gui     = sg,
        _win     = win,
        _content = content,
        _sidebar = sidebar,
        _tabs    = {},
        _active  = nil,
        Theme    = C,
        ThemeName= cfg.Theme or "Dark",
    }

    local function SelectTab(tab)
        if Window._active == tab then return end
        if Window._active then
            -- deactivate old
            local old = Window._active
            Tween(old._btn, { BackgroundColor3 = Color3.fromRGB(0,0,0), BackgroundTransparency = 1 }, 0.15)
            old._btnLabel.TextColor3 = C.TextSecondary
            old._btnIcon.TextColor3  = C.TextMuted
            old._frame.Visible = false
        end
        Window._active = tab
        Tween(tab._btn, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0 }, 0.15)
        tab._btnLabel.TextColor3 = C.TextPrimary
        tab._btnIcon.TextColor3  = C.Accent
        tab._frame.Visible = true
        -- slide-in
        tab._frame.Position = UDim2.new(0.05, 0, 0, 0)
        tab._frame.BackgroundTransparency = 1
        Tween(tab._frame, { Position = UDim2.new(0,0,0,0), BackgroundTransparency = 1 }, 0.2, Enum.EasingStyle.Quart)
    end

    -- ── Tab builder ──
    function Window:Tab(tcfg)
        tcfg = tcfg or {}
        local T = {}

        -- sidebar button
        local btn = Make("Frame", {
            Name = "TabBtn_" .. (tcfg.Title or "Tab"),
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Color3.fromRGB(0,0,0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = tabList
        })
        AddCorner(btn, 8)

        -- left accent bar (hidden when inactive)
        local accentBar = Make("Frame", {
            Size = UDim2.new(0, 2, 0.6, 0),
            Position = UDim2.new(0, 0, 0.2, 0),
            BackgroundColor3 = C.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = btn
        })
        AddCorner(accentBar, 2)

        local btnIcon = Make("TextLabel", {
            Size = UDim2.new(0, 20, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            Text = tcfg.Icon or "•",
            TextColor3 = C.TextMuted,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            BackgroundTransparency = 1,
            Parent = btn
        })
        local btnLabel = Make("TextLabel", {
            Size = UDim2.new(1, -38, 1, 0),
            Position = UDim2.new(0, 36, 0, 0),
            Text = tcfg.Title or "Tab",
            TextColor3 = C.TextSecondary,
            Font = Enum.Font.GothamSemibold,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent = btn
        })

        -- clickable overlay
        local btnClick = Make("TextButton", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 2,
            Parent = btn
        })

        -- content frame (tab page)
        local frame = Make("Frame", {
            Name = "TabPage_" .. (tcfg.Title or "Tab"),
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Visible = false,
            Parent = content
        })
        AddListLayout(frame, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 6)
        AddPadding(frame, 10, 10, 10, 10)

        T._btn      = btn
        T._btnLabel = btnLabel
        T._btnIcon  = btnIcon
        T._frame    = frame

        btnClick.MouseButton1Click:Connect(function()
            SelectTab(T)
            Tween(accentBar, { BackgroundTransparency = 0 }, 0.15)
        end)
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

        -- auto-select first tab
        if #Window._tabs == 0 then
            SelectTab(T)
            accentBar.BackgroundTransparency = 0
        end
        table.insert(Window._tabs, T)

        -- ── ELEMENT HELPERS shared inside a tab ──
        local function BaseCard(parent, h)
            local card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, h or 44),
                BackgroundColor3 = C.Panel,
                BorderSizePixel = 0,
                Parent = parent
            })
            AddCorner(card, 8)
            AddStroke(card, C.Border, 1, 0)
            return card
        end

        local function ElemLabel(parent, title, desc, xOff)
            Make("TextLabel", {
                Size = UDim2.new(0.6, 0, 0, 18),
                Position = UDim2.new(0, xOff or 12, 0, 8),
                Text = title or "",
                TextColor3 = C.TextPrimary,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent = parent
            })
            if desc then
                Make("TextLabel", {
                    Size = UDim2.new(0.75, 0, 0, 14),
                    Position = UDim2.new(0, xOff or 12, 0, 26),
                    Text = desc,
                    TextColor3 = C.TextSecondary,
                    Font = Enum.Font.Gotham,
                    TextSize = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Parent = parent
                })
            end
        end

        -- ─── SECTION ───────────────────────────────────────────────────────────
        function T:Section(scfg)
            scfg = scfg or {}
            local sec = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent = frame
            })
            AddListLayout(sec, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 4)

            -- header row
            local hdr = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 26),
                BackgroundTransparency = 1,
                Parent = sec
            })
            Make("TextLabel", {
                Size = UDim2.new(0, 200, 1, 0),
                Position = UDim2.new(0, 2, 0, 0),
                Text = (scfg.Title or "Section"):upper(),
                TextColor3 = C.TextMuted,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent = hdr
            })
            Make("Frame", {
                Size = UDim2.new(1, -200, 0, 1),
                Position = UDim2.new(0, 204, 0.5, 0),
                BackgroundColor3 = C.Border,
                BorderSizePixel = 0,
                Parent = hdr
            })

            local S = { _frame = sec }

            -- Forward all element methods from Tab to Section
            for k, v in pairs(T) do
                if type(v) == "function" and k ~= "Section" and k ~= "Divider" then
                    S[k] = function(_, cfg2)
                        -- redirect parent to section's frame
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

        -- ─── DIVIDER ───────────────────────────────────────────────────────────
        function T:Divider(text)
            local div = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Parent = frame
            })
            if text then
                Make("TextLabel", {
                    Size = UDim2.new(0, 120, 1, 0),
                    Position = UDim2.new(0.5, -60, 0, 0),
                    Text = text,
                    TextColor3 = C.TextMuted,
                    Font = Enum.Font.Gotham,
                    TextSize = 10,
                    BackgroundTransparency = 1,
                    Parent = div
                })
            end
            Make("Frame", { Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,0.5,0), BackgroundColor3=C.Border, BorderSizePixel=0, Parent=div })
        end

        -- ─── LABEL ─────────────────────────────────────────────────────────────
        function T:Label(lcfg)
            lcfg = lcfg or {}
            local lbl = Make("TextLabel", {
                Size = UDim2.new(1, 0, 0, 28),
                Text = lcfg.Title or "",
                TextColor3 = lcfg.Color or C.TextSecondary,
                Font = lcfg.Bold and Enum.Font.GothamBold or Enum.Font.Gotham,
                TextSize = lcfg.TextSize or 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent = frame
            })
            AddPadding(lbl, 0, 0, 12, 0)
            local L = {}
            function L:SetText(t) lbl.Text = t end
            function L:SetColor(c) lbl.TextColor3 = c end
            return L
        end

        -- ─── PARAGRAPH ─────────────────────────────────────────────────────────
        function T:Paragraph(pcfg)
            pcfg = pcfg or {}
            local card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = C.Panel,
                BorderSizePixel = 0,
                Parent = frame
            })
            AddCorner(card, 8)
            AddStroke(card, C.Border, 1)
            AddPadding(card, 10, 10, 12, 12)
            AddListLayout(card, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, 4)

            if pcfg.Title then
                Make("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 18),
                    Text = pcfg.Title,
                    TextColor3 = C.TextPrimary,
                    Font = Enum.Font.GothamBold,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Parent = card
                })
            end
            local bodyLbl = Make("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Text = pcfg.Content or "",
                TextColor3 = C.TextSecondary,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                BackgroundTransparency = 1,
                Parent = card
            })
            local P = {}
            function P:SetContent(t) bodyLbl.Text = t end
            return P
        end

        -- ─── BUTTON ────────────────────────────────────────────────────────────
        function T:Button(bcfg)
            bcfg = bcfg or {}
            local h = 42
            local card = BaseCard(frame, h)

            -- icon if given
            local xOff = bcfg.Icon and 38 or 12
            if bcfg.Icon then
                Make("TextLabel", {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(0, 10, 0.5, -12),
                    Text = bcfg.Icon,
                    TextColor3 = C.Accent,
                    Font = Enum.Font.GothamBold,
                    TextSize = 16,
                    BackgroundTransparency = 1,
                    ZIndex = 2,
                    Parent = card
                })
            end

            Make("TextLabel", {
                Size = UDim2.new(0.7, 0, 1, 0),
                Position = UDim2.new(0, xOff, 0, 0),
                Text = bcfg.Title or "Button",
                TextColor3 = C.TextPrimary,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent = card
            })

            -- right-side btn
            local rbtn = Make("TextButton", {
                Size = UDim2.new(0, 80, 0, 28),
                Position = UDim2.new(1, -90, 0.5, -14),
                BackgroundColor3 = C.Accent,
                Text = bcfg.ButtonText or "Execute",
                TextColor3 = Color3.new(1,1,1),
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                BorderSizePixel = 0,
                ZIndex = 2,
                Parent = card
            })
            AddCorner(rbtn, 7)

            rbtn.MouseEnter:Connect(function()
                Tween(rbtn, { BackgroundColor3 = C.AccentHover }, 0.12)
            end)
            rbtn.MouseLeave:Connect(function()
                Tween(rbtn, { BackgroundColor3 = C.Accent }, 0.12)
            end)
            rbtn.MouseButton1Down:Connect(function()
                SpringTween(rbtn, { Size = UDim2.new(0, 74, 0, 25) }, 0.15)
            end)
            rbtn.MouseButton1Up:Connect(function()
                SpringTween(rbtn, { Size = UDim2.new(0, 80, 0, 28) }, 0.15)
            end)
            rbtn.MouseButton1Click:Connect(function()
                if bcfg.Callback then pcall(bcfg.Callback) end
            end)

            local B = {}
            function B:SetTitle(t)
                card:FindFirstChildOfClass("TextLabel").Text = t
            end
            function B:Lock()   rbtn.Active = false; Tween(rbtn, { BackgroundTransparency = 0.5 }, 0.1) end
            function B:Unlock() rbtn.Active = true;  Tween(rbtn, { BackgroundTransparency = 0 }, 0.1) end
            return B
        end

        -- ─── TOGGLE ────────────────────────────────────────────────────────────
        function T:Toggle(tcfg2)
            tcfg2 = tcfg2 or {}
            local h = tcfg2.Description and 52 or 42
            local card = BaseCard(frame, h)
            ElemLabel(card, tcfg2.Title, tcfg2.Description)

            local enabled = tcfg2.Value or false

            -- track
            local track = Make("Frame", {
                Size = UDim2.new(0, 40, 0, 22),
                Position = UDim2.new(1, -52, 0.5, -11),
                BackgroundColor3 = enabled and C.ToggleOn or C.ToggleOff,
                BorderSizePixel = 0,
                ZIndex = 2,
                Parent = card
            })
            AddCorner(track, 11)

            -- knob
            local knob = Make("Frame", {
                Size = UDim2.new(0, 16, 0, 16),
                Position = enabled
                    and UDim2.new(0, 21, 0.5, -8)
                    or  UDim2.new(0, 3, 0.5, -8),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel = 0,
                ZIndex = 3,
                Parent = track
            })
            AddCorner(knob, 8)

            local click = Make("TextButton", {
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 4,
                Parent = card
            })

            local function SetToggle(val, fireCallback)
                enabled = val
                Tween(track, { BackgroundColor3 = val and C.ToggleOn or C.ToggleOff }, 0.2)
                Tween(knob, { Position = val
                    and UDim2.new(0, 21, 0.5, -8)
                    or  UDim2.new(0, 3, 0.5, -8) }, 0.2)
                if tcfg2.Flag then NexusUI.Flags[tcfg2.Flag] = val end
                if fireCallback and tcfg2.Callback then
                    pcall(tcfg2.Callback, val)
                end
            end

            click.MouseButton1Click:Connect(function()
                SetToggle(not enabled, true)
            end)
            card.MouseEnter:Connect(function()
                Tween(card, { BackgroundColor3 = C.SurfaceHover }, 0.1)
            end)
            card.MouseLeave:Connect(function()
                Tween(card, { BackgroundColor3 = C.Panel }, 0.1)
            end)

            if tcfg2.Flag then NexusUI.Flags[tcfg2.Flag] = enabled end

            local Tog = {}
            function Tog:Set(v) SetToggle(v, true) end
            function Tog:Get() return enabled end
            return Tog
        end

        -- ─── SLIDER ────────────────────────────────────────────────────────────
        function T:Slider(scfg2)
            scfg2 = scfg2 or {}
            local min   = scfg2.Min     or 0
            local max   = scfg2.Max     or 100
            local val   = scfg2.Value   or min
            local step  = scfg2.Step    or 1
            local fmt   = scfg2.Format  or "%g"
            local h = scfg2.Description and 60 or 52
            local card = BaseCard(frame, h)
            ElemLabel(card, scfg2.Title, scfg2.Description)

            local valLabel = Make("TextLabel", {
                Size = UDim2.new(0, 60, 0, 20),
                Position = UDim2.new(1, -68, 0, 6),
                Text = string.format(fmt, val),
                TextColor3 = C.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex = 2,
                Parent = card
            })

            local trackH = 4
            local trackY = h - 16
            local track = Make("Frame", {
                Size = UDim2.new(1, -24, 0, trackH),
                Position = UDim2.new(0, 12, 0, trackY),
                BackgroundColor3 = C.TrackBg,
                BorderSizePixel = 0,
                ZIndex = 2,
                Parent = card
            })
            AddCorner(track, 3)

            local fill = Make("Frame", {
                Size = UDim2.new((val - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = C.Accent,
                BorderSizePixel = 0,
                ZIndex = 3,
                Parent = track
            })
            AddCorner(fill, 3)

            local handle = Make("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new((val - min) / (max - min), -7, 0.5, -7),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel = 0,
                ZIndex = 5,
                Parent = track
            })
            AddCorner(handle, 7)
            AddStroke(handle, C.Accent, 2)

            local dragging2 = false
            local clickArea = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 24),
                Position = UDim2.new(0, 0, 0, trackY - 8),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 6,
                Parent = card
            })

            local function UpdateSlider(mx)
                local abs = track.AbsolutePosition.X
                local sz  = track.AbsoluteSize.X
                local pct = math.clamp((mx - abs) / sz, 0, 1)
                local raw = min + pct * (max - min)
                local stepped = math.round(raw / step) * step
                stepped = math.clamp(stepped, min, max)
                val = stepped
                local newPct = (val - min) / (max - min)
                Tween(fill, { Size = UDim2.new(newPct, 0, 1, 0) }, 0.05)
                Tween(handle, { Position = UDim2.new(newPct, -7, 0.5, -7) }, 0.05)
                valLabel.Text = string.format(fmt, val)
                if scfg2.Flag then NexusUI.Flags[scfg2.Flag] = val end
                if scfg2.Callback then pcall(scfg2.Callback, val) end
            end

            clickArea.MouseButton1Down:Connect(function()
                dragging2 = true
                UpdateSlider(Mouse.X)
                Tween(handle, { Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new((val-min)/(max-min), -8, 0.5, -8) }, 0.1)
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging2 = false
                    Tween(handle, { Size = UDim2.new(0, 14, 0, 14) }, 0.1)
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
                Tween(fill, { Size = UDim2.new(p, 0, 1, 0) }, 0.15)
                Tween(handle, { Position = UDim2.new(p, -7, 0.5, -7) }, 0.15)
                valLabel.Text = string.format(fmt, val)
            end
            function Sl:Get() return val end
            return Sl
        end

        -- ─── DROPDOWN ──────────────────────────────────────────────────────────
        function T:Dropdown(dcfg)
            dcfg = dcfg or {}
            local options = dcfg.Options or {}
            local selected = dcfg.Value
            local isOpen   = false
            local h = dcfg.Description and 52 or 42

            local wrapper = Make("Frame", {
                Size = UDim2.new(1, 0, 0, h),
                BackgroundTransparency = 1,
                ClipsDescendants = false,
                ZIndex = 10,
                Parent = frame
            })

            local card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, h),
                BackgroundColor3 = C.Panel,
                BorderSizePixel = 0,
                ZIndex = 10,
                Parent = wrapper
            })
            AddCorner(card, 8)
            AddStroke(card, C.Border, 1)

            ElemLabel(card, dcfg.Title, dcfg.Description)

            -- selected text
            local selLabel = Make("TextLabel", {
                Size = UDim2.new(0.5, 0, 0, 20),
                Position = UDim2.new(0.5, -16, 0.5, -10),
                Text = selected or "Select...",
                TextColor3 = selected and C.TextPrimary or C.TextMuted,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex = 11,
                Parent = card
            })

            -- arrow
            local arrow = Make("TextLabel", {
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -26, 0, 0),
                Text = "▾",
                TextColor3 = C.TextMuted,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                BackgroundTransparency = 1,
                ZIndex = 11,
                Parent = card
            })

            -- dropdown popup
            local popup = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = C.Surface,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                ZIndex = 20,
                Visible = false,
                Parent = wrapper
            })
            AddCorner(popup, 8)
            AddStroke(popup, C.Border, 1)
            AddPadding(popup, 4, 4, 4, 4)
            AddListLayout(popup, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 2)

            local optFrames = {}
            for _, opt in ipairs(options) do
                local ob = Make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    BackgroundTransparency = 1,
                    Text = opt,
                    TextColor3 = C.TextSecondary,
                    Font = Enum.Font.GothamSemibold,
                    TextSize = 12,
                    ZIndex = 21,
                    Parent = popup
                })
                AddCorner(ob, 6)
                ob.MouseEnter:Connect(function()
                    Tween(ob, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0 }, 0.1)
                    Tween(ob, { TextColor3 = C.TextPrimary }, 0.1)
                end)
                ob.MouseLeave:Connect(function()
                    Tween(ob, { BackgroundTransparency = 1 }, 0.1)
                    Tween(ob, { TextColor3 = C.TextSecondary }, 0.1)
                end)
                ob.MouseButton1Click:Connect(function()
                    selected = opt
                    selLabel.Text = opt
                    selLabel.TextColor3 = C.TextPrimary
                    isOpen = false
                    Tween(popup, { Size = UDim2.new(1, 0, 0, 0) }, 0.18)
                    Tween(arrow, { Rotation = 0 }, 0.18)
                    task.delay(0.2, function() popup.Visible = false end)
                    if dcfg.Flag then NexusUI.Flags[dcfg.Flag] = opt end
                    if dcfg.Callback then pcall(dcfg.Callback, opt) end
                end)
                table.insert(optFrames, ob)
            end

            local totalH = #options * 34 + 8
            local clickArea2 = Make("TextButton", {
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 12,
                Parent = card
            })
            clickArea2.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    popup.Visible = true
                    popup.Size = UDim2.new(1, 0, 0, 0)
                    Tween(popup, { Size = UDim2.new(1, 0, 0, totalH) }, 0.2, Enum.EasingStyle.Back)
                    Tween(arrow, { Rotation = 180 }, 0.18)
                else
                    Tween(popup, { Size = UDim2.new(1, 0, 0, 0) }, 0.18)
                    Tween(arrow, { Rotation = 0 }, 0.18)
                    task.delay(0.2, function() popup.Visible = false end)
                end
            end)

            local D = {}
            function D:Set(v)
                selected = v
                selLabel.Text = v
                selLabel.TextColor3 = C.TextPrimary
            end
            function D:Get() return selected end
            function D:Refresh(opts)
                for _, f in ipairs(optFrames) do f:Destroy() end
                optFrames = {}
                options = opts
            end
            return D
        end

        -- ─── INPUT ─────────────────────────────────────────────────────────────
        function T:Input(icfg)
            icfg = icfg or {}
            local h = icfg.Description and 60 or 52
            local card = BaseCard(frame, h)
            ElemLabel(card, icfg.Title, icfg.Description)

            local box = Make("TextBox", {
                Size = UDim2.new(0, 160, 0, 28),
                Position = UDim2.new(1, -168, 0.5, -14),
                BackgroundColor3 = C.TrackBg,
                Text = icfg.Value or "",
                PlaceholderText = icfg.Placeholder or "Enter...",
                TextColor3 = C.TextPrimary,
                PlaceholderColor3 = C.TextMuted,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                BorderSizePixel = 0,
                ClearTextOnFocus = icfg.ClearOnFocus or false,
                ZIndex = 2,
                Parent = card
            })
            AddCorner(box, 7)
            AddStroke(box, C.Border, 1)
            AddPadding(box, 0, 0, 8, 8)

            box.Focused:Connect(function()
                Tween(box, { BackgroundColor3 = C.SurfaceHover }, 0.12)
                AddStroke(box, C.Accent, 1):Destroy()
                -- replace stroke
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
            function I:Get() return box.Text end
            return I
        end

        -- ─── KEYBIND ───────────────────────────────────────────────────────────
        function T:Keybind(kcfg)
            kcfg = kcfg or {}
            local currentKey = kcfg.Value or Enum.KeyCode.Unknown
            local listening  = false
            local h = 42
            local card = BaseCard(frame, h)
            ElemLabel(card, kcfg.Title, kcfg.Description)

            local keyBtn = Make("TextButton", {
                Size = UDim2.new(0, 80, 0, 26),
                Position = UDim2.new(1, -90, 0.5, -13),
                BackgroundColor3 = C.TrackBg,
                Text = currentKey == Enum.KeyCode.Unknown and "None" or currentKey.Name,
                TextColor3 = C.TextPrimary,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                BorderSizePixel = 0,
                ZIndex = 2,
                Parent = card
            })
            AddCorner(keyBtn, 7)
            AddStroke(keyBtn, C.Border, 1)

            keyBtn.MouseButton1Click:Connect(function()
                listening = true
                keyBtn.Text = "..."
                keyBtn.TextColor3 = C.Accent
                Tween(keyBtn, { BackgroundColor3 = C.AccentSoft }, 0.12)
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if listening then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        keyBtn.Text = currentKey.Name
                        keyBtn.TextColor3 = C.TextPrimary
                        Tween(keyBtn, { BackgroundColor3 = C.TrackBg }, 0.12)
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
            function K:Get() return currentKey end
            return K
        end

        -- ─── COLOR PICKER ──────────────────────────────────────────────────────
        function T:ColorPicker(cpcfg)
            cpcfg = cpcfg or {}
            local currentColor = cpcfg.Value or Color3.fromHex("#5865f2")
            local isOpen = false
            local h, s, v2 = currentColor:ToHSV()

            local wrapper = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 42),
                BackgroundTransparency = 1,
                ClipsDescendants = false,
                ZIndex = 10,
                Parent = frame
            })

            local card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 42),
                BackgroundColor3 = C.Panel,
                BorderSizePixel = 0,
                ZIndex = 10,
                Parent = wrapper
            })
            AddCorner(card, 8)
            AddStroke(card, C.Border, 1)
            ElemLabel(card, cpcfg.Title, cpcfg.Description)

            -- color swatch
            local swatch = Make("Frame", {
                Size = UDim2.new(0, 52, 0, 26),
                Position = UDim2.new(1, -62, 0.5, -13),
                BackgroundColor3 = currentColor,
                BorderSizePixel = 0,
                ZIndex = 11,
                Parent = card
            })
            AddCorner(swatch, 7)
            AddStroke(swatch, C.Border, 1)

            -- picker popup
            local popup = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = C.Surface,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                ZIndex = 20,
                Visible = false,
                Parent = wrapper
            })
            AddCorner(popup, 10)
            AddStroke(popup, C.Border, 1)
            AddPadding(popup, 10, 10, 10, 10)

            local popH = 160

            -- SV square (simulated with gradient)
            local svFrame = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 100),
                BackgroundColor3 = Color3.new(1, 0, 0),
                BorderSizePixel = 0,
                ZIndex = 21,
                Parent = popup
            })
            AddCorner(svFrame, 6)

            -- white-to-transparent horizontal
            local wGrad = Make("Frame", {
                Size = UDim2.new(1,0,1,0),
                BackgroundColor3 = Color3.new(1,1,1),
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                ZIndex = 22,
                Parent = svFrame
            })
            AddCorner(wGrad, 6)
            Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
                    ColorSequenceKeypoint.new(1, Color3.new(1,1,1)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                }),
                Parent = wGrad
            })

            -- black-to-transparent vertical
            local bGrad = Make("Frame", {
                Size = UDim2.new(1,0,1,0),
                BackgroundColor3 = Color3.new(0,0,0),
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                ZIndex = 23,
                Parent = svFrame
            })
            AddCorner(bGrad, 6)
            Make("UIGradient", {
                Color = ColorSequence.new(Color3.new(0,0,0)),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0),
                }),
                Rotation = -90,
                Parent = bGrad
            })

            -- sv cursor
            local svCursor = Make("Frame", {
                Size = UDim2.new(0, 10, 0, 10),
                Position = UDim2.new(s, -5, 1 - v2, -5),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel = 0,
                ZIndex = 25,
                Parent = svFrame
            })
            AddCorner(svCursor, 5)
            AddStroke(svCursor, Color3.new(0,0,0), 1.5)

            -- hue bar
            local hueBar = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 14),
                Position = UDim2.new(0, 0, 1, 8),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel = 0,
                ZIndex = 21,
                Parent = svFrame
            })
            AddCorner(hueBar, 6)
            -- rainbow gradient
            local hueGrad = Make("UIGradient", {
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
                Size = UDim2.new(0, 8, 1, 4),
                Position = UDim2.new(h, -4, 0, -2),
                BackgroundColor3 = Color3.new(1,1,1),
                BorderSizePixel = 0,
                ZIndex = 25,
                Parent = hueBar
            })
            AddCorner(hueCursor, 4)
            AddStroke(hueCursor, Color3.new(0,0,0), 1.5)

            -- hex input
            local hexBox = Make("TextBox", {
                Size = UDim2.new(1, 0, 0, 26),
                Position = UDim2.new(0, 0, 1, 26),
                BackgroundColor3 = C.TrackBg,
                Text = ColorToHex(currentColor),
                TextColor3 = C.TextPrimary,
                Font = Enum.Font.Code,
                TextSize = 12,
                BorderSizePixel = 0,
                ZIndex = 21,
                Parent = svFrame
            })
            AddCorner(hexBox, 7)
            AddStroke(hexBox, C.Border, 1)
            AddPadding(hexBox, 0, 0, 8, 8)

            local function UpdateColor()
                currentColor = HsvToColor3(h, s, v2)
                swatch.BackgroundColor3 = currentColor
                svFrame.BackgroundColor3 = HsvToColor3(h, 1, 1)
                svCursor.Position = UDim2.new(s, -5, 1 - v2, -5)
                hueCursor.Position = UDim2.new(h, -4, 0, -2)
                hexBox.Text = ColorToHex(currentColor)
                if cpcfg.Flag then NexusUI.Flags[cpcfg.Flag] = currentColor end
                if cpcfg.Callback then pcall(cpcfg.Callback, currentColor) end
            end

            -- sv drag
            local svDrag = false
            local svClick = Make("TextButton", {
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 30,
                Parent = svFrame
            })
            svClick.MouseButton1Down:Connect(function()
                svDrag = true
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then svDrag = false end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if svDrag and i.UserInputType == Enum.UserInputType.MouseMovement then
                    local abs = svFrame.AbsolutePosition
                    local sz  = svFrame.AbsoluteSize
                    s  = math.clamp((i.Position.X - abs.X) / sz.X, 0, 1)
                    v2 = 1 - math.clamp((i.Position.Y - abs.Y) / sz.Y, 0, 1)
                    UpdateColor()
                end
            end)

            -- hue drag
            local hueDrag = false
            local hueClick = Make("TextButton", {
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 30,
                Parent = hueBar
            })
            hueClick.MouseButton1Down:Connect(function() hueDrag = true end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then hueDrag = false end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if hueDrag and i.UserInputType == Enum.UserInputType.MouseMovement then
                    local abs = hueBar.AbsolutePosition
                    local sz  = hueBar.AbsoluteSize
                    h = math.clamp((i.Position.X - abs.X) / sz.X, 0, 1)
                    UpdateColor()
                end
            end)

            hexBox.FocusLost:Connect(function()
                local hex = hexBox.Text:gsub("#","")
                if #hex == 6 then
                    local ok, col = pcall(Color3.fromHex, "#"..hex)
                    if ok then
                        currentColor = col
                        h, s, v2 = col:ToHSV()
                        UpdateColor()
                    end
                end
            end)

            -- toggle open
            local swatchClick = Make("TextButton", {
                Size = UDim2.new(0, 62, 0, 36),
                Position = UDim2.new(1, -70, 0.5, -18),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 12,
                Parent = card
            })
            swatchClick.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    popup.Visible = true
                    popup.Size = UDim2.new(1,0,0,0)
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

        -- ─── PROGRESS ──────────────────────────────────────────────────────────
        function T:Progress(pgcfg)
            pgcfg = pgcfg or {}
            local val = pgcfg.Value or 0
            local h = pgcfg.Description and 52 or 44
            local card = BaseCard(frame, h)
            ElemLabel(card, pgcfg.Title, pgcfg.Description)

            local pctLabel = Make("TextLabel", {
                Size = UDim2.new(0, 45, 0, 20),
                Position = UDim2.new(1, -52, 0.5, -22),
                Text = math.round(val) .. "%",
                TextColor3 = C.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex = 2,
                Parent = card
            })

            local track = Make("Frame", {
                Size = UDim2.new(1, -24, 0, 6),
                Position = UDim2.new(0, 12, 1, -14),
                BackgroundColor3 = C.TrackBg,
                BorderSizePixel = 0,
                ZIndex = 2,
                Parent = card
            })
            AddCorner(track, 4)

            local fill = Make("Frame", {
                Size = UDim2.new(val/100, 0, 1, 0),
                BackgroundColor3 = C.Accent,
                BorderSizePixel = 0,
                ZIndex = 3,
                Parent = track
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
    end

    -- ── Section in window (sidebar grouping) ──
    function Window:Section(scfg)
        scfg = scfg or {}
        Make("TextLabel", {
            Size = UDim2.new(1, 0, 0, 22),
            Text = ("  " .. (scfg.Title or "")):upper(),
            TextColor3 = C.TextMuted,
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent = tabList
        })
    end

    function Window:Divider()
        Make("Frame", {
            Size = UDim2.new(0.85, 0, 0, 1),
            BackgroundColor3 = C.Border,
            BorderSizePixel = 0,
            Parent = tabList
        })
    end

    -- ── Notification shortcut ──
    function Window:Notify(cfg2)
        cfg2.Theme = self.ThemeName
        return Notify(cfg2)
    end

    -- ── Dialog ──
    function Window:Dialog(dcfg)
        dcfg = dcfg or {}
        local overlay = Make("Frame", {
            Size = UDim2.new(1,0,1,0),
            BackgroundColor3 = Color3.new(0,0,0),
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            ZIndex = 50,
            Parent = win
        })

        local dW = dcfg.Width or 320
        local dialog = Make("Frame", {
            Size = UDim2.new(0, dW, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0.5, -dW/2, 0.5, -80),
            BackgroundColor3 = C.Surface,
            BorderSizePixel = 0,
            ZIndex = 51,
            Parent = overlay
        })
        AddCorner(dialog, 12)
        AddStroke(dialog, C.Border, 1)
        AddPadding(dialog, 16, 16, 16, 16)
        AddListLayout(dialog, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, 8)

        Make("TextLabel", {
            Size = UDim2.new(1, 0, 0, 22),
            Text = dcfg.Title or "Dialog",
            TextColor3 = C.TextPrimary,
            Font = Enum.Font.GothamBold,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex = 52,
            Parent = dialog
        })

        if dcfg.Content then
            Make("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Text = dcfg.Content,
                TextColor3 = C.TextSecondary,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                BackgroundTransparency = 1,
                ZIndex = 52,
                Parent = dialog
            })
        end

        -- buttons row
        local btnRow = Make("Frame", {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            ZIndex = 52,
            Parent = dialog
        })
        local btnLayout = Make("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8),
            Parent = btnRow
        })

        for _, b in ipairs(dcfg.Buttons or {}) do
            local isPrimary = b.Variant == "Primary"
            local db = Make("TextButton", {
                Size = UDim2.new(0, 90, 0, 32),
                BackgroundColor3 = isPrimary and C.Accent or C.TrackBg,
                Text = b.Title or "OK",
                TextColor3 = isPrimary and Color3.new(1,1,1) or C.TextSecondary,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                BorderSizePixel = 0,
                ZIndex = 53,
                Parent = btnRow
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

        -- entrance animation
        dialog.Position = UDim2.new(0.5, -dW/2, 0.5, -60)
        dialog.BackgroundTransparency = 1
        SpringTween(dialog, { Position = UDim2.new(0.5, -dW/2, 0.5, -80), BackgroundTransparency = 0 })
    end

    -- ── Visibility ──
    function Window:Toggle()
        win.Visible = not win.Visible
        shadow.Visible = win.Visible
    end

    function Window:Open()
        win.Visible  = true
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
        -- basic re-theme (win bg only — full re-theme would require re-render)
        local nc = Themes[name]
        if not nc then return end
        C = nc
        self.Theme = nc
        self.ThemeName = name
        Tween(win, { BackgroundColor3 = nc.Background }, 0.3)
        Tween(topbar, { BackgroundColor3 = nc.Topbar }, 0.3)
        Tween(sidebar, { BackgroundColor3 = nc.Sidebar }, 0.3)
    end

    -- ── Close / Minimize buttons ──
    closeBtn:FindFirstChildOfClass("TextButton") or Make("TextButton", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", ZIndex=6, Parent=closeBtn
    })
    local closeBtnClik = Make("TextButton", {
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", ZIndex=6, Parent=closeBtn
    })
    closeBtnClik.MouseButton1Click:Connect(function() Window:Close() end)

    local minBtnClick = Make("TextButton", {
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", ZIndex=6, Parent=minBtn
    })
    minBtnClick.MouseButton1Click:Connect(function()
        content.Visible = not content.Visible
        sidebar.Visible = not sidebar.Visible
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
