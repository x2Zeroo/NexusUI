--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║              RBX UI Library  —  Modern • Clean • Powerful                   ║
║              v1.0.0   |   Full Component Set                                 ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  COMPONENTS                                                                  ║
║  ─ Loadstring executor      ─ Themes (7 built-in)                           ║
║  ─ Window  (draggable)      ─ Key System                                     ║
║  ─ Tab  /  Tab Section      ─ Dialog  /  Popup  /  Notification             ║
║  ─ Tag  /  Section          ─ Button  /  Toggle  /  Slider                  ║
║  ─ Input  /  Dropdown       ─ Paragraph  /  Keybind  /  Colorpicker         ║
║  ─ Code  /  Divider         ─ Space  /  Image  /  Group                     ║
║  ─ HStack & VStack          ─ Configs  /  Icons                             ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  USAGE                                                                       ║
║    local UI = loadstring(game:HttpGet("URL"))()                              ║
║    local Win = UI:CreateWindow({ Title="My Hub", Theme="Dark" })            ║
║    local Tab = Win:Tab({ Title="Main", Icon="⚡" })                         ║
║    Tab:Toggle({ Title="Speed", Value=false, Callback=function(v) end })     ║
╚══════════════════════════════════════════════════════════════════════════════╝
]]

-- ─────────────────────────────────────────────────────────────────────────────
-- SERVICES
-- ─────────────────────────────────────────────────────────────────────────────
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local CoreGui           = game:GetService("CoreGui")
local HttpService       = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- ─────────────────────────────────────────────────────────────────────────────
-- THEMES
-- ─────────────────────────────────────────────────────────────────────────────
local Themes = {

    -- ── Dark (default) ──────────────────────────────────────────────────────
    Dark = {
        Background   = Color3.fromHex("#0d0e10"),
        Surface      = Color3.fromHex("#131416"),
        SurfaceHover = Color3.fromHex("#1a1b1e"),
        Panel        = Color3.fromHex("#18191c"),
        Border       = Color3.fromHex("#2a2b2f"),
        BorderLight  = Color3.fromHex("#353639"),
        Accent       = Color3.fromHex("#7c3aed"),
        AccentHover  = Color3.fromHex("#6d28d9"),
        AccentSoft   = Color3.fromHex("#7c3aed"),
        Success      = Color3.fromHex("#3ba55d"),
        Warning      = Color3.fromHex("#faa61a"),
        Error        = Color3.fromHex("#ed4245"),
        Info         = Color3.fromHex("#5865f2"),
        TextPrimary  = Color3.fromHex("#f0f0f2"),
        TextSecondary= Color3.fromHex("#9a9ba0"),
        TextMuted    = Color3.fromHex("#545558"),
        TrackBg      = Color3.fromHex("#222326"),
        Handle       = Color3.fromHex("#7c3aed"),
        ToggleOn     = Color3.fromHex("#7c3aed"),
        ToggleOff    = Color3.fromHex("#2e2f33"),
        Topbar       = Color3.fromHex("#0d0e10"),
        Sidebar      = Color3.fromHex("#101113"),
        Shadow       = Color3.fromHex("#000000"),
        Scrollbar    = Color3.fromHex("#2e2f33"),
        Tag          = Color3.fromHex("#1e1f22"),
    },

    -- ── Dim ─────────────────────────────────────────────────────────────────
    Dim = {
        Background   = Color3.fromHex("#1a1b23"),
        Surface      = Color3.fromHex("#222432"),
        SurfaceHover = Color3.fromHex("#2a2d40"),
        Panel        = Color3.fromHex("#272938"),
        Border       = Color3.fromHex("#343648"),
        BorderLight  = Color3.fromHex("#404258"),
        Accent       = Color3.fromHex("#7c3aed"),
        AccentHover  = Color3.fromHex("#6d28d9"),
        AccentSoft   = Color3.fromHex("#7c3aed"),
        Success      = Color3.fromHex("#3ba55d"),
        Warning      = Color3.fromHex("#faa61a"),
        Error        = Color3.fromHex("#ed4245"),
        Info         = Color3.fromHex("#5865f2"),
        TextPrimary  = Color3.fromHex("#e8eaf6"),
        TextSecondary= Color3.fromHex("#8b8fa8"),
        TextMuted    = Color3.fromHex("#555870"),
        TrackBg      = Color3.fromHex("#1e2030"),
        Handle       = Color3.fromHex("#7c3aed"),
        ToggleOn     = Color3.fromHex("#7c3aed"),
        ToggleOff    = Color3.fromHex("#2e3048"),
        Topbar       = Color3.fromHex("#1a1b23"),
        Sidebar      = Color3.fromHex("#1c1d28"),
        Shadow       = Color3.fromHex("#000000"),
        Scrollbar    = Color3.fromHex("#2e3048"),
        Tag          = Color3.fromHex("#22243a"),
    },

    -- ── Light ────────────────────────────────────────────────────────────────
    Light = {
        Background   = Color3.fromHex("#f8f9fa"),
        Surface      = Color3.fromHex("#ffffff"),
        SurfaceHover = Color3.fromHex("#f1f3f5"),
        Panel        = Color3.fromHex("#f4f5f7"),
        Border       = Color3.fromHex("#e2e4e9"),
        BorderLight  = Color3.fromHex("#d8dae0"),
        Accent       = Color3.fromHex("#7c3aed"),
        AccentHover  = Color3.fromHex("#6d28d9"),
        AccentSoft   = Color3.fromHex("#7c3aed"),
        Success      = Color3.fromHex("#2d9e5f"),
        Warning      = Color3.fromHex("#e08c00"),
        Error        = Color3.fromHex("#c92a2a"),
        Info         = Color3.fromHex("#3b5bdb"),
        TextPrimary  = Color3.fromHex("#1a1b1e"),
        TextSecondary= Color3.fromHex("#555860"),
        TextMuted    = Color3.fromHex("#999da8"),
        TrackBg      = Color3.fromHex("#e8e9ed"),
        Handle       = Color3.fromHex("#7c3aed"),
        ToggleOn     = Color3.fromHex("#7c3aed"),
        ToggleOff    = Color3.fromHex("#d0d2d9"),
        Topbar       = Color3.fromHex("#ffffff"),
        Sidebar      = Color3.fromHex("#f0f1f5"),
        Shadow       = Color3.fromHex("#c0c2ca"),
        Scrollbar    = Color3.fromHex("#d0d2d9"),
        Tag          = Color3.fromHex("#eaebef"),
    },

    -- ── Purple ───────────────────────────────────────────────────────────────
    Purple = {
        Background   = Color3.fromHex("#0f0c18"),
        Surface      = Color3.fromHex("#16101f"),
        SurfaceHover = Color3.fromHex("#1c1428"),
        Panel        = Color3.fromHex("#1a1228"),
        Border       = Color3.fromHex("#2e2040"),
        BorderLight  = Color3.fromHex("#3d2a50"),
        Accent       = Color3.fromHex("#8b5cf6"),
        AccentHover  = Color3.fromHex("#7c3aed"),
        AccentSoft   = Color3.fromHex("#8b5cf6"),
        Success      = Color3.fromHex("#6ee7b7"),
        Warning      = Color3.fromHex("#fbbf24"),
        Error        = Color3.fromHex("#f87171"),
        Info         = Color3.fromHex("#60a5fa"),
        TextPrimary  = Color3.fromHex("#ede9fe"),
        TextSecondary= Color3.fromHex("#9d84b7"),
        TextMuted    = Color3.fromHex("#5a4070"),
        TrackBg      = Color3.fromHex("#1e1530"),
        Handle       = Color3.fromHex("#8b5cf6"),
        ToggleOn     = Color3.fromHex("#8b5cf6"),
        ToggleOff    = Color3.fromHex("#2a1c3e"),
        Topbar       = Color3.fromHex("#0f0c18"),
        Sidebar      = Color3.fromHex("#120e1c"),
        Shadow       = Color3.fromHex("#000000"),
        Scrollbar    = Color3.fromHex("#2a1c3e"),
        Tag          = Color3.fromHex("#1a1228"),
    },

    -- ── Ocean ────────────────────────────────────────────────────────────────
    Ocean = {
        Background   = Color3.fromHex("#080d14"),
        Surface      = Color3.fromHex("#0d1520"),
        SurfaceHover = Color3.fromHex("#131922"),
        Panel        = Color3.fromHex("#111c2a"),
        Border       = Color3.fromHex("#1a2a3e"),
        BorderLight  = Color3.fromHex("#27394e"),
        Accent       = Color3.fromHex("#00b4d8"),
        AccentHover  = Color3.fromHex("#0096c7"),
        AccentSoft   = Color3.fromHex("#00b4d8"),
        Success      = Color3.fromHex("#00c896"),
        Warning      = Color3.fromHex("#f4a261"),
        Error        = Color3.fromHex("#e63946"),
        Info         = Color3.fromHex("#48cae4"),
        TextPrimary  = Color3.fromHex("#e8edf5"),
        TextSecondary= Color3.fromHex("#6a8ca0"),
        TextMuted    = Color3.fromHex("#304050"),
        TrackBg      = Color3.fromHex("#101e2e"),
        Handle       = Color3.fromHex("#00b4d8"),
        ToggleOn     = Color3.fromHex("#00b4d8"),
        ToggleOff    = Color3.fromHex("#142030"),
        Topbar       = Color3.fromHex("#080d14"),
        Sidebar      = Color3.fromHex("#090e18"),
        Shadow       = Color3.fromHex("#000000"),
        Scrollbar    = Color3.fromHex("#1c2236"),
        Tag          = Color3.fromHex("#0e1828"),
    },

    -- ── Forest ───────────────────────────────────────────────────────────────
    Forest = {
        Background   = Color3.fromHex("#080e0a"),
        Surface      = Color3.fromHex("#0d160f"),
        SurfaceHover = Color3.fromHex("#131f15"),
        Panel        = Color3.fromHex("#111e13"),
        Border       = Color3.fromHex("#1a2e1c"),
        BorderLight  = Color3.fromHex("#273d29"),
        Accent       = Color3.fromHex("#4ade80"),
        AccentHover  = Color3.fromHex("#22c55e"),
        AccentSoft   = Color3.fromHex("#4ade80"),
        Success      = Color3.fromHex("#4ade80"),
        Warning      = Color3.fromHex("#facc15"),
        Error        = Color3.fromHex("#f87171"),
        Info         = Color3.fromHex("#60a5fa"),
        TextPrimary  = Color3.fromHex("#e8f5ea"),
        TextSecondary= Color3.fromHex("#6a9a70"),
        TextMuted    = Color3.fromHex("#304033"),
        TrackBg      = Color3.fromHex("#101e13"),
        Handle       = Color3.fromHex("#4ade80"),
        ToggleOn     = Color3.fromHex("#4ade80"),
        ToggleOff    = Color3.fromHex("#142018"),
        Topbar       = Color3.fromHex("#080e0a"),
        Sidebar      = Color3.fromHex("#090e0b"),
        Shadow       = Color3.fromHex("#000000"),
        Scrollbar    = Color3.fromHex("#1c2e1e"),
        Tag          = Color3.fromHex("#0e1810"),
    },

    -- ── Sunset ───────────────────────────────────────────────────────────────
    Sunset = {
        Background   = Color3.fromHex("#0e0808"),
        Surface      = Color3.fromHex("#160f0c"),
        SurfaceHover = Color3.fromHex("#1c1410"),
        Panel        = Color3.fromHex("#1e1410"),
        Border       = Color3.fromHex("#301e18"),
        BorderLight  = Color3.fromHex("#3d2820"),
        Accent       = Color3.fromHex("#f97316"),
        AccentHover  = Color3.fromHex("#ea6b0e"),
        AccentSoft   = Color3.fromHex("#f97316"),
        Success      = Color3.fromHex("#4ade80"),
        Warning      = Color3.fromHex("#fbbf24"),
        Error        = Color3.fromHex("#ef4444"),
        Info         = Color3.fromHex("#fb923c"),
        TextPrimary  = Color3.fromHex("#fff1eb"),
        TextSecondary= Color3.fromHex("#a07060"),
        TextMuted    = Color3.fromHex("#503828"),
        TrackBg      = Color3.fromHex("#1e1410"),
        Handle       = Color3.fromHex("#f97316"),
        ToggleOn     = Color3.fromHex("#f97316"),
        ToggleOff    = Color3.fromHex("#301810"),
        Topbar       = Color3.fromHex("#0e0808"),
        Sidebar      = Color3.fromHex("#0f0908"),
        Shadow       = Color3.fromHex("#000000"),
        Scrollbar    = Color3.fromHex("#301810"),
        Tag          = Color3.fromHex("#1a1008"),
    },
}

-- ─────────────────────────────────────────────────────────────────────────────
-- ICONS TABLE  (usable as Icon = RBX.Icons.home)
-- ─────────────────────────────────────────────────────────────────────────────
local Icons = {
    home     = "⌂",  user     = "👤", settings = "⚙",  store    = "🛒",
    chart    = "📊", mission  = "🎯", help     = "❓", eye      = "👁",
    lock     = "🔒", bell     = "🔔", star     = "★",  heart    = "♥",
    shield   = "🛡", sword    = "⚔",  zap      = "⚡", globe    = "🌐",
    camera   = "📷", music    = "♫",  code     = "</>",folder   = "📁",
    file     = "📄", trash    = "🗑",  edit     = "✏",  plus     = "+",
    minus    = "-",  check    = "✓",  close    = "×",  arrow    = "→",
    search   = "🔍", key      = "🔑", fire     = "🔥", crown    = "👑",
    trophy   = "🏆", info     = "ℹ",  warning  = "⚠",  error    = "✕",
}

-- ─────────────────────────────────────────────────────────────────────────────
-- UTILITIES
-- ─────────────────────────────────────────────────────────────────────────────
local function Tween(obj, props, t, style, dir)
    local info = TweenInfo.new(
        t     or 0.18,
        style or Enum.EasingStyle.Quart,
        dir   or Enum.EasingDirection.Out
    )
    local tw = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

local function Spring(obj, props, t)
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

local function Corner(parent, r)
    return Make("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = parent })
end

local function Stroke(parent, color, thickness, trans)
    return Make("UIStroke", {
        Color       = color,
        Thickness   = thickness or 1,
        Transparency= trans or 0,
        Parent      = parent,
    })
end

local function Padding(parent, t, b, l, r)
    return Make("UIPadding", {
        PaddingTop    = UDim.new(0, t or 8),
        PaddingBottom = UDim.new(0, b or 8),
        PaddingLeft   = UDim.new(0, l or 10),
        PaddingRight  = UDim.new(0, r or 10),
        Parent        = parent,
    })
end

local function ListLayout(parent, dir, align, pad)
    return Make("UIListLayout", {
        FillDirection       = dir   or Enum.FillDirection.Vertical,
        HorizontalAlignment = align or Enum.HorizontalAlignment.Left,
        SortOrder           = Enum.SortOrder.LayoutOrder,
        Padding             = UDim.new(0, pad or 0),
        Parent              = parent,
    })
end

local function Draggable(handle, target)
    local dragging, ds, sp = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; ds = i.Position; sp = target.Position
        end
    end)
    handle.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - ds
            target.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)
end

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
    if     i == 0 then r, g, b = v, t2, p
    elseif i == 1 then r, g, b = q, v,  p
    elseif i == 2 then r, g, b = p, v,  t2
    elseif i == 3 then r, g, b = p, q,  v
    elseif i == 4 then r, g, b = t2, p, v
    elseif i == 5 then r, g, b = v,  p, q
    end
    return Color3.new(r, g, b)
end

local function GuiParent()
    local ok, cg = pcall(function() return CoreGui end)
    return ok and cg or LocalPlayer:WaitForChild("PlayerGui")
end

-- ─────────────────────────────────────────────────────────────────────────────
-- NOTIFICATION SYSTEM  (standalone, top-right)
-- ─────────────────────────────────────────────────────────────────────────────
local NotifHolder
local function EnsureNotifHolder()
    if NotifHolder and NotifHolder.Parent then return end
    local sg = Make("ScreenGui", {
        Name           = "RBX_Notifs",
        ResetOnSpawn   = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent         = GuiParent(),
    })
    NotifHolder = Make("Frame", {
        Name                 = "Holder",
        Size                 = UDim2.new(0, 300, 1, 0),
        Position             = UDim2.new(1, -316, 0, 0),
        BackgroundTransparency = 1,
        Parent               = sg,
    })
    ListLayout(NotifHolder, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right, 8)
    Padding(NotifHolder, 16, 16, 0, 0)
end

local function Notify(cfg)
    EnsureNotifHolder()
    local C = Themes[cfg.Theme or "Dark"]
    local typeCol = { success = C.Success, warning = C.Warning, error = C.Error, info = C.Info }
    local accent  = typeCol[cfg.Type or "info"] or C.Accent
    local typeIcon= { success = "✓", warning = "⚠", error = "✕", info = "ℹ" }

    -- card
    local card = Make("Frame", {
        Size                 = UDim2.new(1, 0, 0, 68),
        BackgroundColor3     = C.Panel,
        BorderSizePixel      = 0,
        ClipsDescendants     = true,
        Parent               = NotifHolder,
    })
    Corner(card, 10)
    Stroke(card, C.Border, 1)

    -- left accent strip
    local strip = Make("Frame", {
        Size             = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = accent,
        BorderSizePixel  = 0,
        Parent           = card,
    })
    Corner(strip, 3)

    -- type icon circle
    local iconCircle = Make("Frame", {
        Size             = UDim2.new(0, 28, 0, 28),
        Position         = UDim2.new(0, 14, 0.5, -14),
        BackgroundColor3 = accent,
        BorderSizePixel  = 0,
        Parent           = card,
    })
    Corner(iconCircle, 14)
    Make("TextLabel", {
        Size                 = UDim2.new(1, 0, 1, 0),
        Text                 = typeIcon[cfg.Type or "info"] or "ℹ",
        TextColor3           = Color3.new(1, 1, 1),
        Font                 = Enum.Font.GothamBold,
        TextSize             = 13,
        BackgroundTransparency = 1,
        Parent               = iconCircle,
    })

    -- title
    Make("TextLabel", {
        Size                 = UDim2.new(1, -90, 0, 20),
        Position             = UDim2.new(0, 52, 0, 10),
        Text                 = cfg.Title or "Notification",
        TextColor3           = C.TextPrimary,
        Font                 = Enum.Font.GothamBold,
        TextSize             = 13,
        TextXAlignment       = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Parent               = card,
    })

    -- content
    if cfg.Content then
        Make("TextLabel", {
            Size                 = UDim2.new(1, -90, 0, 28),
            Position             = UDim2.new(0, 52, 0, 30),
            Text                 = cfg.Content,
            TextColor3           = C.TextSecondary,
            Font                 = Enum.Font.Gotham,
            TextSize             = 11,
            TextXAlignment       = Enum.TextXAlignment.Left,
            TextWrapped          = true,
            BackgroundTransparency = 1,
            Parent               = card,
        })
    end

    -- close button
    local closeBtn = Make("TextButton", {
        Size                 = UDim2.new(0, 24, 0, 24),
        Position             = UDim2.new(1, -30, 0, 6),
        BackgroundTransparency = 1,
        Text                 = "×",
        TextColor3           = C.TextMuted,
        Font                 = Enum.Font.GothamBold,
        TextSize             = 16,
        Parent               = card,
    })

    -- progress bar
    local progress = Make("Frame", {
        Size             = UDim2.new(1, 0, 0, 2),
        Position         = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = accent,
        BorderSizePixel  = 0,
        ZIndex           = 5,
        Parent           = card,
    })

    -- animate in
    card.Position = UDim2.new(1, 20, 0, 0)
    Spring(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.3)

    local duration = cfg.Duration or 4
    Tween(progress, { Size = UDim2.new(0, 0, 0, 2) }, duration, Enum.EasingStyle.Linear)

    local function dismiss()
        Tween(card, { Position = UDim2.new(1, 20, 0, 0), BackgroundTransparency = 1 }, 0.22)
        task.delay(0.28, function() card:Destroy() end)
    end

    closeBtn.MouseButton1Click:Connect(dismiss)
    task.delay(duration, dismiss)

    return card
end

-- ─────────────────────────────────────────────────────────────────────────────
-- LIBRARY TABLE
-- ─────────────────────────────────────────────────────────────────────────────
local RBX       = {}
RBX.__index     = RBX
RBX.Version     = "1.0.0"
RBX.Flags       = {}    -- global flag store (keybinds, toggles, etc.)
RBX._windows    = {}
RBX.Icons       = Icons
RBX.Themes      = Themes

function RBX:GetFlags() return self.Flags end
function RBX:GetFlag(k) return self.Flags[k] end
function RBX:SetFlag(k, v) self.Flags[k] = v end
function RBX:AddTheme(name, t) Themes[name] = t end

-- Global notify shortcut
function RBX:Notify(cfg)
    cfg.Theme = cfg.Theme or "Dark"
    return Notify(cfg)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- LOADSTRING EXECUTOR
-- ─────────────────────────────────────────────────────────────────────────────
function RBX:ExecuteLoadstring(str)
    -- Safely execute a loadstring; returns ok, result/error
    local fn, err = loadstring(str)
    if not fn then
        return false, "Parse error: " .. tostring(err)
    end
    local ok, res = pcall(fn)
    if not ok then
        return false, "Runtime error: " .. tostring(res)
    end
    return true, res
end

-- ─────────────────────────────────────────────────────────────────────────────
-- KEY SYSTEM
-- ─────────────────────────────────────────────────────────────────────────────
function RBX:CreateKeySystem(cfg)
    --[[
        cfg = {
            Keys         = { "KEY1", "KEY2" },      -- valid keys table
            Title        = "Key System",
            Subtitle     = "Enter your key below",
            VerifyLabel  = "Verify Key",
            OnSuccess    = function() end,
            OnFail       = function() end,
            Theme        = "Dark",
        }
    ]]
    cfg = cfg or {}
    local C = Themes[cfg.Theme or "Dark"]

    local sg = Make("ScreenGui", {
        Name           = "RBX_KeySystem",
        ResetOnSpawn   = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent         = GuiParent(),
    })

    -- Blur background
    local overlay = Make("Frame", {
        Size                 = UDim2.new(1, 0, 1, 0),
        BackgroundColor3     = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.45,
        BorderSizePixel      = 0,
        ZIndex               = 0,
        Parent               = sg,
    })

    local W, H = 360, 220
    local win = Make("Frame", {
        Size             = UDim2.new(0, W, 0, H),
        Position         = UDim2.new(0.5, -W/2, 0.5, -H/2),
        BackgroundColor3 = C.Surface,
        BorderSizePixel  = 0,
        ZIndex           = 2,
        Parent           = sg,
    })
    Corner(win, 14)
    Stroke(win, C.Border, 1)

    -- Top accent bar
    local topBar = Make("Frame", {
        Size             = UDim2.new(1, 0, 0, 4),
        BackgroundColor3 = C.Accent,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = win,
    })
    Make("UICorner", { CornerRadius = UDim.new(0, 14), Parent = topBar })

    -- Logo icon
    Make("TextLabel", {
        Size                 = UDim2.new(0, 44, 0, 44),
        Position             = UDim2.new(0.5, -22, 0, 20),
        Text                 = "🔑",
        Font                 = Enum.Font.GothamBold,
        TextSize             = 26,
        BackgroundTransparency = 1,
        ZIndex               = 3,
        Parent               = win,
    })

    Make("TextLabel", {
        Size                 = UDim2.new(1, -40, 0, 22),
        Position             = UDim2.new(0, 20, 0, 70),
        Text                 = cfg.Title or "Key System",
        TextColor3           = C.TextPrimary,
        Font                 = Enum.Font.GothamBold,
        TextSize             = 16,
        TextXAlignment       = Enum.TextXAlignment.Center,
        BackgroundTransparency = 1,
        ZIndex               = 3,
        Parent               = win,
    })

    Make("TextLabel", {
        Size                 = UDim2.new(1, -40, 0, 16),
        Position             = UDim2.new(0, 20, 0, 94),
        Text                 = cfg.Subtitle or "Enter your key below to continue",
        TextColor3           = C.TextSecondary,
        Font                 = Enum.Font.Gotham,
        TextSize             = 12,
        TextXAlignment       = Enum.TextXAlignment.Center,
        BackgroundTransparency = 1,
        ZIndex               = 3,
        Parent               = win,
    })

    -- Key input box
    local inputFrame = Make("Frame", {
        Size             = UDim2.new(1, -40, 0, 36),
        Position         = UDim2.new(0, 20, 0, 120),
        BackgroundColor3 = C.TrackBg,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = win,
    })
    Corner(inputFrame, 9)
    Stroke(inputFrame, C.Border, 1)

    Make("TextLabel", {
        Size                 = UDim2.new(0, 20, 1, 0),
        Position             = UDim2.new(0, 8, 0, 0),
        Text                 = "🔑",
        Font                 = Enum.Font.GothamBold,
        TextSize             = 13,
        BackgroundTransparency = 1,
        ZIndex               = 4,
        Parent               = inputFrame,
    })

    local keyBox = Make("TextBox", {
        Size                 = UDim2.new(1, -36, 1, 0),
        Position             = UDim2.new(0, 32, 0, 0),
        BackgroundTransparency = 1,
        PlaceholderText      = "Enter your key...",
        Text                 = "",
        TextColor3           = C.TextPrimary,
        PlaceholderColor3    = C.TextMuted,
        Font                 = Enum.Font.Gotham,
        TextSize             = 13,
        ClearTextOnFocus     = false,
        ZIndex               = 4,
        Parent               = inputFrame,
    })

    -- Verify button
    local verifyBtn = Make("TextButton", {
        Size             = UDim2.new(1, -40, 0, 38),
        Position         = UDim2.new(0, 20, 0, 164),
        BackgroundColor3 = C.Accent,
        Text             = cfg.VerifyLabel or "Verify Key",
        TextColor3       = Color3.new(1, 1, 1),
        Font             = Enum.Font.GothamBold,
        TextSize         = 14,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = win,
    })
    Corner(verifyBtn, 9)

    verifyBtn.MouseEnter:Connect(function()
        Tween(verifyBtn, { BackgroundColor3 = C.AccentHover }, 0.12)
    end)
    verifyBtn.MouseLeave:Connect(function()
        Tween(verifyBtn, { BackgroundColor3 = C.Accent }, 0.12)
    end)

    local statusLabel = Make("TextLabel", {
        Size                 = UDim2.new(1, -40, 0, 14),
        Position             = UDim2.new(0, 20, 1, -18),
        Text                 = "",
        TextColor3           = C.Error,
        Font                 = Enum.Font.Gotham,
        TextSize             = 11,
        TextXAlignment       = Enum.TextXAlignment.Center,
        BackgroundTransparency = 1,
        ZIndex               = 3,
        Parent               = win,
    })

    verifyBtn.MouseButton1Click:Connect(function()
        local entered = keyBox.Text
        local valid   = false
        for _, k in ipairs(cfg.Keys or {}) do
            if k == entered then valid = true break end
        end
        if valid then
            statusLabel.TextColor3 = C.Success
            statusLabel.Text       = "✓ Key accepted!"
            Tween(verifyBtn, { BackgroundColor3 = C.Success }, 0.2)
            task.delay(1, function()
                sg:Destroy()
                if cfg.OnSuccess then pcall(cfg.OnSuccess) end
            end)
        else
            statusLabel.TextColor3 = C.Error
            statusLabel.Text       = "✕ Invalid key. Please try again."
            Spring(win, { Position = UDim2.new(0.5, -W/2 + 8, 0.5, -H/2) }, 0.05)
            task.delay(0.05, function()
                Spring(win, { Position = UDim2.new(0.5, -W/2, 0.5, -H/2) }, 0.3)
            end)
            if cfg.OnFail then pcall(cfg.OnFail, entered) end
        end
    end)

    -- Entrance animation
    win.Position = UDim2.new(0.5, -W/2, 0.5, -H/2 - 30)
    win.BackgroundTransparency = 0.3
    Spring(win, { Position = UDim2.new(0.5, -W/2, 0.5, -H/2), BackgroundTransparency = 0 }, 0.4)

    return { _gui = sg, Destroy = function() sg:Destroy() end }
end

-- ─────────────────────────────────────────────────────────────────────────────
-- CREATE WINDOW
-- ─────────────────────────────────────────────────────────────────────────────
function RBX:CreateWindow(cfg)
    cfg = cfg or {}
    local C         = Themes[cfg.Theme or "Dark"]
    local W         = cfg.Width       or 680
    local H         = cfg.Height      or 480
    local SBW       = cfg.SideBarWidth or 190

    -- ── ScreenGui ───────────────────────────────────────────────────────────
    local sg = Make("ScreenGui", {
        Name           = "RBX_" .. (cfg.Title or "Hub"),
        ResetOnSpawn   = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent         = GuiParent(),
    })

    -- ── Drop shadow ─────────────────────────────────────────────────────────
    local shadow = Make("Frame", {
        Name                 = "Shadow",
        Size                 = UDim2.new(0, W + 32, 0, H + 32),
        Position             = UDim2.new(0.5, -(W + 32)/2, 0.5, -(H + 32)/2),
        BackgroundColor3     = C.Shadow,
        BackgroundTransparency = 0.55,
        BorderSizePixel      = 0,
        ZIndex               = 0,
        Parent               = sg,
    })
    Corner(shadow, 18)

    -- ── Main frame ──────────────────────────────────────────────────────────
    local win = Make("Frame", {
        Name             = "Window",
        Size             = UDim2.new(0, W, 0, H),
        Position         = UDim2.new(0.5, -W/2, 0.5, -H/2),
        BackgroundColor3 = C.Background,
        BorderSizePixel  = 0,
        ClipsDescendants = true,
        Parent           = sg,
    })
    Corner(win, 12)
    Stroke(win, C.Border, 1)

    -- ── Topbar ──────────────────────────────────────────────────────────────
    local topbar = Make("Frame", {
        Name             = "Topbar",
        Size             = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = C.Topbar,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = win,
    })
    Make("Frame", {
        Size             = UDim2.new(1, 0, 0, 1),
        Position         = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = C.Border,
        BorderSizePixel  = 0,
        Parent           = topbar,
    })

    -- Logo icon
    local logoIcon = Make("TextLabel", {
        Size                 = UDim2.new(0, 28, 0, 28),
        Position             = UDim2.new(0, 12, 0.5, -14),
        Text                 = "◆",
        TextColor3           = C.Accent,
        Font                 = Enum.Font.GothamBold,
        TextSize             = 18,
        BackgroundTransparency = 1,
        ZIndex               = 4,
        Parent               = topbar,
    })

    -- Title
    local titleLabel = Make("TextLabel", {
        Size                 = UDim2.new(0, 200, 1, 0),
        Position             = UDim2.new(0, 46, 0, 0),
        Text                 = cfg.Title or "RBX UI Library",
        TextColor3           = C.TextPrimary,
        Font                 = Enum.Font.GothamBold,
        TextSize             = 14,
        TextXAlignment       = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        ZIndex               = 4,
        Parent               = topbar,
    })

    -- Author / subtitle
    if cfg.Author then
        Make("TextLabel", {
            Size                 = UDim2.new(0, 200, 1, 0),
            Position             = UDim2.new(0, 46, 0, 0),
            Text                 = cfg.Author,
            TextColor3           = C.TextMuted,
            Font                 = Enum.Font.Gotham,
            TextSize             = 10,
            TextXAlignment       = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex               = 4,
            Parent               = topbar,
        })
        -- shift title up
        titleLabel.Position = UDim2.new(0, 46, 0, -8)
        titleLabel.Size     = UDim2.new(0, 200, 0, 20)
    end

    -- Window control buttons
    local btnNames  = { "─", "□", "×" }
    local btnColors = { C.TextMuted, C.TextMuted, C.Error }
    local ctrlFrame = Make("Frame", {
        Size                 = UDim2.new(0, 90, 0, 28),
        Position             = UDim2.new(1, -100, 0.5, -14),
        BackgroundTransparency = 1,
        ZIndex               = 4,
        Parent               = topbar,
    })
    ListLayout(ctrlFrame, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Right, 4)

    local minimized = false
    for i, label in ipairs(btnNames) do
        local btn = Make("TextButton", {
            Size             = UDim2.new(0, 24, 0, 24),
            BackgroundColor3 = C.TrackBg,
            Text             = label,
            TextColor3       = btnColors[i],
            Font             = Enum.Font.GothamBold,
            TextSize         = 12,
            BorderSizePixel  = 0,
            ZIndex           = 5,
            Parent           = ctrlFrame,
        })
        Corner(btn, 6)

        btn.MouseEnter:Connect(function()
            Tween(btn, { BackgroundColor3 = i == 3 and C.Error or C.SurfaceHover }, 0.1)
            if i == 3 then Tween(btn, { TextColor3 = Color3.new(1,1,1) }, 0.1) end
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, { BackgroundColor3 = C.TrackBg }, 0.1)
            if i == 3 then Tween(btn, { TextColor3 = C.Error }, 0.1) end
        end)
        btn.MouseButton1Click:Connect(function()
            if i == 3 then
                -- Close
                Tween(win, { Size = UDim2.new(0, W * 0.95, 0, H * 0.95), BackgroundTransparency = 1 }, 0.2)
                task.delay(0.25, function() sg:Destroy() end)
            elseif i == 2 then
                -- Minimize
                minimized = not minimized
                local newH = minimized and 48 or H
                Tween(win, { Size = UDim2.new(0, W, 0, newH) }, 0.25, Enum.EasingStyle.Back)
            end
        end)
    end

    Draggable(topbar, win)

    -- ── Sidebar ─────────────────────────────────────────────────────────────
    local sidebar = Make("Frame", {
        Name             = "Sidebar",
        Size             = UDim2.new(0, SBW, 1, -48),
        Position         = UDim2.new(0, 0, 0, 48),
        BackgroundColor3 = C.Sidebar,
        BorderSizePixel  = 0,
        ZIndex           = 2,
        Parent           = win,
    })
    Make("Frame", {
        Size             = UDim2.new(0, 1, 1, 0),
        Position         = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = C.Border,
        BorderSizePixel  = 0,
        Parent           = sidebar,
    })

    -- Sidebar scrollable tab list
    local tabList = Make("ScrollingFrame", {
        Name                   = "TabList",
        Size                   = UDim2.new(1, 0, 1, -36),
        BackgroundTransparency = 1,
        BorderSizePixel        = 0,
        ScrollBarThickness     = 2,
        ScrollBarImageColor3   = C.Scrollbar,
        CanvasSize             = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize    = Enum.AutomaticSize.Y,
        Parent                 = sidebar,
    })
    ListLayout(tabList, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 2)
    Padding(tabList, 6, 6, 8, 8)

    -- Version label
    Make("TextLabel", {
        Size                 = UDim2.new(1, 0, 0, 28),
        Position             = UDim2.new(0, 0, 1, -30),
        Text                 = "RBX v" .. RBX.Version,
        TextColor3           = C.TextMuted,
        Font                 = Enum.Font.Gotham,
        TextSize             = 9,
        BackgroundTransparency = 1,
        ZIndex               = 2,
        Parent               = sidebar,
    })

    -- ── Content area ────────────────────────────────────────────────────────
    local content = Make("ScrollingFrame", {
        Name                   = "Content",
        Size                   = UDim2.new(1, -SBW, 1, -48),
        Position               = UDim2.new(0, SBW, 0, 48),
        BackgroundColor3       = C.Background,
        BorderSizePixel        = 0,
        ScrollBarThickness     = 3,
        ScrollBarImageColor3   = C.Scrollbar,
        CanvasSize             = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize    = Enum.AutomaticSize.Y,
        Parent                 = win,
    })

    -- ── Window object ────────────────────────────────────────────────────────
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

    -- Tab selection logic
    local function SelectTab(tab)
        if Window._active == tab then return end
        if Window._active then
            local old = Window._active
            Tween(old._btn, { BackgroundColor3 = Color3.fromRGB(0,0,0), BackgroundTransparency = 1 }, 0.15)
            old._label.TextColor3 = C.TextSecondary
            old._icon.TextColor3  = C.TextMuted
            old._bar.BackgroundTransparency = 1
            old._page.Visible = false
        end
        Window._active = tab
        Tween(tab._btn, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0.88 }, 0.15)
        tab._label.TextColor3 = C.TextPrimary
        tab._icon.TextColor3  = C.Accent
        Tween(tab._bar, { BackgroundTransparency = 0 }, 0.15)
        tab._page.Visible = true
        tab._page.Position = UDim2.new(0.04, 0, 0, 0)
        Tween(tab._page, { Position = UDim2.new(0, 0, 0, 0) }, 0.2, Enum.EasingStyle.Quart)
    end

    -- ─── TAB BUILDER ──────────────────────────────────────────────────────────
    function Window:Tab(tcfg)
        tcfg = tcfg or {}
        local T = {}

        -- Sidebar button
        local btn = Make("Frame", {
            Name                 = "Btn_" .. (tcfg.Title or "Tab"),
            Size                 = UDim2.new(1, 0, 0, 36),
            BackgroundColor3     = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel      = 0,
            Parent               = tabList,
        })
        Corner(btn, 8)

        -- Left accent bar
        local bar = Make("Frame", {
            Size                 = UDim2.new(0, 2, 0.6, 0),
            Position             = UDim2.new(0, 0, 0.2, 0),
            BackgroundColor3     = C.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel      = 0,
            Parent               = btn,
        })
        Corner(bar, 2)

        local icon = Make("TextLabel", {
            Size                 = UDim2.new(0, 20, 1, 0),
            Position             = UDim2.new(0, 12, 0, 0),
            Text                 = tcfg.Icon or "•",
            TextColor3           = C.TextMuted,
            Font                 = Enum.Font.GothamBold,
            TextSize             = 14,
            BackgroundTransparency = 1,
            Parent               = btn,
        })

        local label = Make("TextLabel", {
            Size                 = UDim2.new(1, -38, 1, 0),
            Position             = UDim2.new(0, 36, 0, 0),
            Text                 = tcfg.Title or "Tab",
            TextColor3           = C.TextSecondary,
            Font                 = Enum.Font.GothamSemibold,
            TextSize             = 13,
            TextXAlignment       = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent               = btn,
        })

        local click = Make("TextButton", {
            Size                 = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text                 = "",
            ZIndex               = 2,
            Parent               = btn,
        })

        -- Tab page
        local page = Make("Frame", {
            Name                 = "Page_" .. (tcfg.Title or "Tab"),
            Size                 = UDim2.new(1, 0, 0, 0),
            AutomaticSize        = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Visible              = false,
            Parent               = content,
        })
        ListLayout(page, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 6)
        Padding(page, 12, 12, 12, 12)

        T._btn   = btn
        T._label = label
        T._icon  = icon
        T._bar   = bar
        T._page  = page

        click.MouseButton1Click:Connect(function() SelectTab(T) end)
        click.MouseEnter:Connect(function()
            if Window._active ~= T then
                Tween(btn, { BackgroundColor3 = C.SurfaceHover, BackgroundTransparency = 0 }, 0.12)
            end
        end)
        click.MouseLeave:Connect(function()
            if Window._active ~= T then
                Tween(btn, { BackgroundTransparency = 1 }, 0.12)
            end
        end)

        if #Window._tabs == 0 then SelectTab(T) end
        table.insert(Window._tabs, T)

        -- ─── BASE CARD HELPERS ─────────────────────────────────────────────
        local function Card(h, parentFrame)
            local c = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, h or 44),
                BackgroundColor3 = C.Panel,
                BorderSizePixel  = 0,
                Parent           = parentFrame or page,
            })
            Corner(c, 8)
            Stroke(c, C.Border, 1)
            return c
        end

        local function ElemTitle(parent, title, desc, xOff)
            xOff = xOff or 12
            Make("TextLabel", {
                Size                 = UDim2.new(0.65, 0, 0, 18),
                Position             = UDim2.new(0, xOff, 0, desc and 8 or 0.5),
                AnchorPoint          = desc and Vector2.new(0, 0) or Vector2.new(0, 0.5),
                Text                 = title or "",
                TextColor3           = C.TextPrimary,
                Font                 = Enum.Font.GothamSemibold,
                TextSize             = 13,
                TextXAlignment       = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent               = parent,
            })
            if desc then
                Make("TextLabel", {
                    Size                 = UDim2.new(0.75, 0, 0, 14),
                    Position             = UDim2.new(0, xOff, 0, 26),
                    Text                 = desc,
                    TextColor3           = C.TextSecondary,
                    Font                 = Enum.Font.Gotham,
                    TextSize             = 10,
                    TextXAlignment       = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Parent               = parent,
                })
            end
        end

        -- ═══════════════════════════════════════════════════════════════════
        --  ELEMENTS
        -- ═══════════════════════════════════════════════════════════════════

        -- ─── SECTION ───────────────────────────────────────────────────────
        function T:Section(scfg)
            scfg = scfg or {}
            local sec = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent               = page,
            })
            ListLayout(sec, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 4)

            -- Header
            local hdr = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1,
                Parent               = sec,
            })
            Make("TextLabel", {
                Size                 = UDim2.new(0, 180, 1, 0),
                Position             = UDim2.new(0, 2, 0, 0),
                Text                 = (scfg.Title or "Section"):upper(),
                TextColor3           = C.TextMuted,
                Font                 = Enum.Font.GothamBold,
                TextSize             = 9,
                TextXAlignment       = Enum.TextXAlignment.Left,
                LetterSpacing        = 1,
                BackgroundTransparency = 1,
                Parent               = hdr,
            })
            Make("Frame", {
                Size             = UDim2.new(1, -185, 0, 1),
                Position         = UDim2.new(0, 188, 0.5, 0),
                BackgroundColor3 = C.Border,
                BorderSizePixel  = 0,
                Parent           = hdr,
            })

            local S = { _frame = sec }
            -- Forward tab element methods to section
            for k, v in pairs(T) do
                if type(v) == "function" and k ~= "Section" then
                    S[k] = function(_, cfg2)
                        local orig = page
                        page = sec
                        local r = v(T, cfg2)
                        page = orig
                        return r
                    end
                end
            end
            return S
        end

        -- ─── LABEL ─────────────────────────────────────────────────────────
        function T:Label(lcfg)
            lcfg = lcfg or {}
            local lbl = Make("TextLabel", {
                Size                 = UDim2.new(1, 0, 0, 26),
                Text                 = lcfg.Title or "",
                TextColor3           = lcfg.Color or C.TextSecondary,
                Font                 = lcfg.Bold and Enum.Font.GothamBold or Enum.Font.Gotham,
                TextSize             = lcfg.TextSize or 12,
                TextXAlignment       = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent               = page,
            })
            Padding(lbl, 0, 0, 14, 0)
            local L = {}
            function L:Set(t) lbl.Text = t end
            return L
        end

        -- ─── PARAGRAPH ─────────────────────────────────────────────────────
        function T:Paragraph(pcfg)
            pcfg = pcfg or {}
            local card = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundColor3     = C.Panel,
                BorderSizePixel      = 0,
                Parent               = page,
            })
            Corner(card, 8)
            Stroke(card, C.Border, 1)
            Padding(card, 10, 10, 12, 12)
            ListLayout(card, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, 4)

            if pcfg.Title then
                Make("TextLabel", {
                    Size                 = UDim2.new(1, 0, 0, 18),
                    Text                 = pcfg.Title,
                    TextColor3           = C.TextPrimary,
                    Font                 = Enum.Font.GothamBold,
                    TextSize             = 13,
                    TextXAlignment       = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Parent               = card,
                })
            end

            local body = Make("TextLabel", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                Text                 = pcfg.Content or "",
                TextColor3           = C.TextSecondary,
                Font                 = Enum.Font.Gotham,
                TextSize             = 12,
                TextXAlignment       = Enum.TextXAlignment.Left,
                TextWrapped          = true,
                BackgroundTransparency = 1,
                Parent               = card,
            })
            local P = {}
            function P:Set(t) body.Text = t end
            return P
        end

        -- ─── DIVIDER ───────────────────────────────────────────────────────
        function T:Divider(text)
            local div = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Parent               = page,
            })
            Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 1),
                Position         = UDim2.new(0, 0, 0.5, 0),
                BackgroundColor3 = C.Border,
                BorderSizePixel  = 0,
                Parent           = div,
            })
            if text then
                local lbl = Make("TextLabel", {
                    Size                 = UDim2.new(0, 0, 1, 0),
                    AutomaticSize        = Enum.AutomaticSize.X,
                    Position             = UDim2.new(0.5, 0, 0, 0),
                    AnchorPoint          = Vector2.new(0.5, 0),
                    Text                 = "  " .. text .. "  ",
                    TextColor3           = C.TextMuted,
                    Font                 = Enum.Font.Gotham,
                    TextSize             = 10,
                    BackgroundColor3     = C.Background,
                    BorderSizePixel      = 0,
                    ZIndex               = 2,
                    Parent               = div,
                })
            end
        end

        -- ─── SPACE ─────────────────────────────────────────────────────────
        function T:Space(size)
            Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, size or 12),
                BackgroundTransparency = 1,
                Parent               = page,
            })
        end

        -- ─── BUTTON ────────────────────────────────────────────────────────
        function T:Button(bcfg)
            bcfg = bcfg or {}
            local h = bcfg.Description and 52 or 42
            local card = Card(h)

            if bcfg.Icon then
                Make("TextLabel", {
                    Size                 = UDim2.new(0, 24, 0, 24),
                    Position             = UDim2.new(0, 10, 0.5, -12),
                    Text                 = bcfg.Icon,
                    TextColor3           = C.Accent,
                    Font                 = Enum.Font.GothamBold,
                    TextSize             = 15,
                    BackgroundTransparency = 1,
                    ZIndex               = 2,
                    Parent               = card,
                })
            end

            local xOff = bcfg.Icon and 40 or 12
            ElemTitle(card, bcfg.Title, bcfg.Description, xOff)

            local rbtn = Make("TextButton", {
                Size             = UDim2.new(0, 84, 0, 28),
                Position         = UDim2.new(1, -96, 0.5, -14),
                BackgroundColor3 = C.Accent,
                Text             = bcfg.ButtonText or "Execute",
                TextColor3       = Color3.new(1, 1, 1),
                Font             = Enum.Font.GothamBold,
                TextSize         = 12,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card,
            })
            Corner(rbtn, 7)

            rbtn.MouseEnter:Connect(function()
                Tween(rbtn, { BackgroundColor3 = C.AccentHover }, 0.12)
            end)
            rbtn.MouseLeave:Connect(function()
                Tween(rbtn, { BackgroundColor3 = C.Accent }, 0.12)
            end)
            rbtn.MouseButton1Down:Connect(function()
                Spring(rbtn, { Size = UDim2.new(0, 78, 0, 25) }, 0.12)
            end)
            rbtn.MouseButton1Up:Connect(function()
                Spring(rbtn, { Size = UDim2.new(0, 84, 0, 28) }, 0.15)
            end)
            rbtn.MouseButton1Click:Connect(function()
                if bcfg.Callback then pcall(bcfg.Callback) end
            end)

            local B = {}
            function B:SetText(t) rbtn.Text = t end
            function B:Lock()   rbtn.Active = false; Tween(rbtn, { BackgroundTransparency = 0.5 }, 0.1) end
            function B:Unlock() rbtn.Active = true;  Tween(rbtn, { BackgroundTransparency = 0 }, 0.1) end
            return B
        end

        -- ─── TOGGLE ────────────────────────────────────────────────────────
        function T:Toggle(tcfg2)
            tcfg2 = tcfg2 or {}
            local h       = tcfg2.Description and 52 or 42
            local card    = Card(h)
            local enabled = tcfg2.Value or false

            if tcfg2.Icon then
                Make("TextLabel", {
                    Size                 = UDim2.new(0, 20, 1, 0),
                    Position             = UDim2.new(0, 10, 0, 0),
                    Text                 = tcfg2.Icon,
                    TextColor3           = C.TextMuted,
                    Font                 = Enum.Font.GothamBold,
                    TextSize             = 14,
                    BackgroundTransparency = 1,
                    ZIndex               = 2,
                    Parent               = card,
                })
            end
            local xOff = tcfg2.Icon and 36 or 12
            ElemTitle(card, tcfg2.Title, tcfg2.Description, xOff)

            -- Track
            local track = Make("Frame", {
                Size             = UDim2.new(0, 42, 0, 22),
                Position         = UDim2.new(1, -54, 0.5, -11),
                BackgroundColor3 = enabled and C.ToggleOn or C.ToggleOff,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card,
            })
            Corner(track, 11)

            -- Knob
            local knob = Make("Frame", {
                Size             = UDim2.new(0, 16, 0, 16),
                Position         = UDim2.new(0, enabled and 23 or 3, 0.5, -8),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = track,
            })
            Corner(knob, 8)

            local click = Make("TextButton", {
                Size                 = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 4,
                Parent               = card,
            })

            local function setToggle(state)
                enabled = state
                Tween(track, { BackgroundColor3 = enabled and C.ToggleOn or C.ToggleOff }, 0.2)
                Tween(knob, { Position = UDim2.new(0, enabled and 23 or 3, 0.5, -8) }, 0.2, Enum.EasingStyle.Back)
                if tcfg2.Flag then RBX.Flags[tcfg2.Flag] = enabled end
                if tcfg2.Callback then pcall(tcfg2.Callback, enabled) end
            end

            click.MouseButton1Click:Connect(function() setToggle(not enabled) end)

            local Tog = {}
            function Tog:Set(v) setToggle(v) end
            function Tog:Get() return enabled end
            return Tog
        end

        -- ─── SLIDER ────────────────────────────────────────────────────────
        function T:Slider(scfg)
            scfg = scfg or {}
            local h    = scfg.Description and 60 or 52
            local card = Card(h)
            ElemTitle(card, scfg.Title, scfg.Description)

            local min   = scfg.Min   or 0
            local max   = scfg.Max   or 100
            local step  = scfg.Step  or 1
            local value = math.clamp(scfg.Value or min, min, max)
            local fmt   = scfg.Format or "%g"

            -- Value label
            local valLabel = Make("TextLabel", {
                Size                 = UDim2.new(0, 52, 0, 18),
                Position             = UDim2.new(1, -60, 0, scfg.Description and 8 or 0.5),
                AnchorPoint          = scfg.Description and Vector2.new(0,0) or Vector2.new(0, 0.5),
                Text                 = string.format(fmt, value),
                TextColor3           = C.Accent,
                Font                 = Enum.Font.GothamBold,
                TextSize             = 12,
                TextXAlignment       = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex               = 2,
                Parent               = card,
            })

            -- Track
            local trackFrame = Make("Frame", {
                Size             = UDim2.new(1, -24, 0, 6),
                Position         = UDim2.new(0, 12, 1, -16),
                BackgroundColor3 = C.TrackBg,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card,
            })
            Corner(trackFrame, 4)

            local pct = (value - min) / (max - min)
            local fill = Make("Frame", {
                Size             = UDim2.new(pct, 0, 1, 0),
                BackgroundColor3 = C.Accent,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = trackFrame,
            })
            Corner(fill, 4)

            local handle = Make("Frame", {
                Size             = UDim2.new(0, 14, 0, 14),
                Position         = UDim2.new(pct, -7, 0.5, -7),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel  = 0,
                ZIndex           = 4,
                Parent           = trackFrame,
            })
            Corner(handle, 7)
            Stroke(handle, C.Accent, 2)

            local function setValue(v)
                v = math.clamp(math.round(v / step) * step, min, max)
                value = v
                local p = (v - min) / (max - min)
                Tween(fill,   { Size     = UDim2.new(p, 0, 1, 0) }, 0.08)
                Tween(handle, { Position = UDim2.new(p, -7, 0.5, -7) }, 0.08)
                valLabel.Text = string.format(fmt, v)
                if scfg.Flag then RBX.Flags[scfg.Flag] = v end
                if scfg.Callback then pcall(scfg.Callback, v) end
            end

            -- Draggable logic
            local dragging = false
            local trackBtn = Make("TextButton", {
                Size                 = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 5,
                Parent               = trackFrame,
            })
            trackBtn.MouseButton1Down:Connect(function()
                dragging = true
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                    local abs = trackFrame.AbsolutePosition
                    local sz  = trackFrame.AbsoluteSize
                    local p   = math.clamp((i.Position.X - abs.X) / sz.X, 0, 1)
                    setValue(min + (max - min) * p)
                end
            end)
            trackBtn.MouseButton1Click:Connect(function(x, y)
                local abs = trackFrame.AbsolutePosition
                local sz  = trackFrame.AbsoluteSize
                local p   = math.clamp((UserInputService:GetMouseLocation().X - abs.X) / sz.X, 0, 1)
                setValue(min + (max - min) * p)
            end)

            local SL = {}
            function SL:Set(v) setValue(v) end
            function SL:Get() return value end
            return SL
        end

        -- ─── DROPDOWN ──────────────────────────────────────────────────────
        function T:Dropdown(dcfg)
            dcfg     = dcfg or {}
            local options = dcfg.Options or {}
            local selected= dcfg.Value
            local isOpen  = false

            -- Wrapper (needed for popup overflow)
            local wrapper = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 42),
                BackgroundTransparency = 1,
                ClipsDescendants     = false,
                ZIndex               = 10,
                Parent               = page,
            })

            local card = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 42),
                BackgroundColor3 = C.Panel,
                BorderSizePixel  = 0,
                ZIndex           = 10,
                Parent           = wrapper,
            })
            Corner(card, 8)
            Stroke(card, C.Border, 1)
            ElemTitle(card, dcfg.Title, dcfg.Description)

            local selLabel = Make("TextLabel", {
                Size                 = UDim2.new(0, 140, 0, 18),
                Position             = UDim2.new(1, -166, 0.5, -9),
                Text                 = selected or "Select...",
                TextColor3           = selected and C.TextPrimary or C.TextMuted,
                Font                 = Enum.Font.GothamSemibold,
                TextSize             = 12,
                TextXAlignment       = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex               = 11,
                Parent               = card,
            })

            local arrow = Make("TextLabel", {
                Size                 = UDim2.new(0, 18, 1, 0),
                Position             = UDim2.new(1, -24, 0, 0),
                Text                 = "▾",
                TextColor3           = C.TextMuted,
                Font                 = Enum.Font.GothamBold,
                TextSize             = 13,
                BackgroundTransparency = 1,
                ZIndex               = 11,
                Parent               = card,
            })

            local totalH = #options * 34 + 8

            local popup = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 0),
                Position         = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = C.Surface,
                BorderSizePixel  = 0,
                ClipsDescendants = true,
                ZIndex           = 20,
                Visible          = false,
                Parent           = wrapper,
            })
            Corner(popup, 8)
            Stroke(popup, C.Border, 1)
            Padding(popup, 4, 4, 4, 4)
            ListLayout(popup, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 2)

            for _, opt in ipairs(options) do
                local ob = Make("TextButton", {
                    Size                 = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3     = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = opt == selected and 0.86 or 1,
                    Text                 = opt,
                    TextColor3           = opt == selected and C.Accent or C.TextSecondary,
                    Font                 = Enum.Font.GothamSemibold,
                    TextSize             = 12,
                    ZIndex               = 21,
                    Parent               = popup,
                })
                if opt == selected then ob.BackgroundColor3 = C.AccentSoft end
                Corner(ob, 6)

                ob.MouseEnter:Connect(function()
                    Tween(ob, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0.86 }, 0.1)
                    Tween(ob, { TextColor3 = C.Accent }, 0.1)
                end)
                ob.MouseLeave:Connect(function()
                    if opt ~= selected then
                        Tween(ob, { BackgroundTransparency = 1 }, 0.1)
                        Tween(ob, { TextColor3 = C.TextSecondary }, 0.1)
                    end
                end)
                ob.MouseButton1Click:Connect(function()
                    selected = opt
                    selLabel.Text       = opt
                    selLabel.TextColor3 = C.TextPrimary
                    isOpen = false
                    Tween(popup, { Size = UDim2.new(1, 0, 0, 0) }, 0.18)
                    Tween(arrow, { Rotation = 0 }, 0.18)
                    task.delay(0.2, function() popup.Visible = false end)
                    if dcfg.Flag then RBX.Flags[dcfg.Flag] = opt end
                    if dcfg.Callback then pcall(dcfg.Callback, opt) end
                end)
            end

            local clickArea = Make("TextButton", {
                Size                 = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 12,
                Parent               = card,
            })
            clickArea.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    popup.Visible = true
                    popup.Size    = UDim2.new(1, 0, 0, 0)
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
                selected = v; selLabel.Text = v; selLabel.TextColor3 = C.TextPrimary
            end
            function D:Get() return selected end
            return D
        end

        -- ─── INPUT ─────────────────────────────────────────────────────────
        function T:Input(icfg)
            icfg = icfg or {}
            local h    = icfg.Description and 60 or 52
            local card = Card(h)
            ElemTitle(card, icfg.Title, icfg.Description)

            local box = Make("TextBox", {
                Size                 = UDim2.new(0, 164, 0, 28),
                Position             = UDim2.new(1, -174, 0.5, -14),
                BackgroundColor3     = C.TrackBg,
                Text                 = icfg.Value or "",
                PlaceholderText      = icfg.Placeholder or "Enter...",
                TextColor3           = C.TextPrimary,
                PlaceholderColor3    = C.TextMuted,
                Font                 = Enum.Font.Gotham,
                TextSize             = 12,
                BorderSizePixel      = 0,
                ClearTextOnFocus     = icfg.ClearOnFocus or false,
                ZIndex               = 2,
                Parent               = card,
            })
            Corner(box, 7)
            Stroke(box, C.Border, 1)
            Padding(box, 0, 0, 8, 8)

            box.Focused:Connect(function()
                Tween(box, { BackgroundColor3 = C.SurfaceHover }, 0.12)
                for _, c in ipairs(box:GetChildren()) do
                    if c:IsA("UIStroke") then c:Destroy() end
                end
                Stroke(box, C.Accent, 1.5)
            end)
            box.FocusLost:Connect(function(enter)
                Tween(box, { BackgroundColor3 = C.TrackBg }, 0.12)
                for _, c in ipairs(box:GetChildren()) do
                    if c:IsA("UIStroke") then c:Destroy() end
                end
                Stroke(box, C.Border, 1)
                if icfg.Flag then RBX.Flags[icfg.Flag] = box.Text end
                if icfg.Callback then pcall(icfg.Callback, box.Text, enter) end
            end)

            local I = {}
            function I:Set(t) box.Text = t end
            function I:Get() return box.Text end
            return I
        end

        -- ─── KEYBIND ───────────────────────────────────────────────────────
        function T:Keybind(kcfg)
            kcfg = kcfg or {}
            local currentKey = kcfg.Value or Enum.KeyCode.Unknown
            local listening  = false
            local card       = Card(42)
            ElemTitle(card, kcfg.Title, kcfg.Description)

            local keyBtn = Make("TextButton", {
                Size             = UDim2.new(0, 84, 0, 26),
                Position         = UDim2.new(1, -96, 0.5, -13),
                BackgroundColor3 = C.TrackBg,
                Text             = currentKey == Enum.KeyCode.Unknown and "None" or currentKey.Name,
                TextColor3       = C.TextPrimary,
                Font             = Enum.Font.GothamBold,
                TextSize         = 11,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card,
            })
            Corner(keyBtn, 7)
            Stroke(keyBtn, C.Border, 1)

            keyBtn.MouseButton1Click:Connect(function()
                listening         = true
                keyBtn.Text       = "..."
                keyBtn.TextColor3 = C.Accent
                Tween(keyBtn, { BackgroundColor3 = C.AccentSoft, BackgroundTransparency = 0.88 }, 0.12)
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey        = input.KeyCode
                    keyBtn.Text       = currentKey.Name
                    keyBtn.TextColor3 = C.TextPrimary
                    Tween(keyBtn, { BackgroundColor3 = C.TrackBg, BackgroundTransparency = 0 }, 0.12)
                    listening = false
                    if kcfg.Flag then RBX.Flags[kcfg.Flag] = currentKey end
                    if kcfg.Callback then pcall(kcfg.Callback, currentKey) end
                elseif not listening and currentKey ~= Enum.KeyCode.Unknown
                       and input.KeyCode == currentKey then
                    if kcfg.OnPress then pcall(kcfg.OnPress) end
                end
            end)

            local K = {}
            function K:Set(kc) currentKey = kc; keyBtn.Text = kc.Name end
            function K:Get() return currentKey end
            return K
        end

        -- ─── COLORPICKER ───────────────────────────────────────────────────
        function T:ColorPicker(cpcfg)
            cpcfg = cpcfg or {}
            local currentColor = cpcfg.Value or Color3.fromHex("#7c3aed")
            local isOpen       = false
            local h_, s_, v_   = currentColor:ToHSV()

            local wrapper = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 42),
                BackgroundTransparency = 1,
                ClipsDescendants     = false,
                ZIndex               = 10,
                Parent               = page,
            })

            local card = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 42),
                BackgroundColor3 = C.Panel,
                BorderSizePixel  = 0,
                ZIndex           = 10,
                Parent           = wrapper,
            })
            Corner(card, 8)
            Stroke(card, C.Border, 1)
            ElemTitle(card, cpcfg.Title, cpcfg.Description)

            local swatch = Make("Frame", {
                Size             = UDim2.new(0, 52, 0, 26),
                Position         = UDim2.new(1, -62, 0.5, -13),
                BackgroundColor3 = currentColor,
                BorderSizePixel  = 0,
                ZIndex           = 11,
                Parent           = card,
            })
            Corner(swatch, 7)
            Stroke(swatch, C.Border, 1)

            -- Popup picker
            local popH  = 170
            local popup = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 0),
                Position         = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = C.Surface,
                BorderSizePixel  = 0,
                ClipsDescendants = true,
                ZIndex           = 20,
                Visible          = false,
                Parent           = wrapper,
            })
            Corner(popup, 10)
            Stroke(popup, C.Border, 1)
            Padding(popup, 10, 10, 10, 10)

            -- SV gradient square
            local svFrame = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 100),
                BackgroundColor3 = HsvToColor3(h_, 1, 1),
                BorderSizePixel  = 0,
                ZIndex           = 21,
                Parent           = popup,
            })
            Corner(svFrame, 6)

            local wGrad = Make("Frame", { Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.new(1,1,1), BorderSizePixel=0, ZIndex=22, Parent=svFrame })
            Corner(wGrad, 6)
            Make("UIGradient", { Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(1,1)}), Parent=wGrad })

            local bGrad = Make("Frame", { Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.new(0,0,0), BorderSizePixel=0, ZIndex=23, Parent=svFrame })
            Corner(bGrad, 6)
            Make("UIGradient", { Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1), NumberSequenceKeypoint.new(1,0)}), Rotation=-90, Parent=bGrad })

            local svCursor = Make("Frame", {
                Size             = UDim2.new(0, 10, 0, 10),
                Position         = UDim2.new(s_, -5, 1 - v_, -5),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel  = 0,
                ZIndex           = 25,
                Parent           = svFrame,
            })
            Corner(svCursor, 5)
            Stroke(svCursor, Color3.new(0, 0, 0), 1.5)

            -- Hue bar
            local hueBar = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 14),
                Position         = UDim2.new(0, 0, 1, 8),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel  = 0,
                ZIndex           = 21,
                Parent           = svFrame,
            })
            Corner(hueBar, 6)
            Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0,     Color3.fromHex("#ff0000")),
                    ColorSequenceKeypoint.new(0.166, Color3.fromHex("#ffff00")),
                    ColorSequenceKeypoint.new(0.333, Color3.fromHex("#00ff00")),
                    ColorSequenceKeypoint.new(0.5,   Color3.fromHex("#00ffff")),
                    ColorSequenceKeypoint.new(0.666, Color3.fromHex("#0000ff")),
                    ColorSequenceKeypoint.new(0.833, Color3.fromHex("#ff00ff")),
                    ColorSequenceKeypoint.new(1,     Color3.fromHex("#ff0000")),
                }),
                Parent = hueBar,
            })

            local hueCursor = Make("Frame", {
                Size             = UDim2.new(0, 8, 1, 4),
                Position         = UDim2.new(h_, -4, 0, -2),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel  = 0,
                ZIndex           = 25,
                Parent           = hueBar,
            })
            Corner(hueCursor, 4)
            Stroke(hueCursor, Color3.new(0, 0, 0), 1.5)

            -- Hex input
            local hexBox = Make("TextBox", {
                Size                 = UDim2.new(1, 0, 0, 26),
                Position             = UDim2.new(0, 0, 1, 26),
                BackgroundColor3     = C.TrackBg,
                Text                 = ColorToHex(currentColor),
                TextColor3           = C.TextPrimary,
                Font                 = Enum.Font.Code,
                TextSize             = 12,
                BorderSizePixel      = 0,
                ZIndex               = 21,
                Parent               = svFrame,
            })
            Corner(hexBox, 7)
            Stroke(hexBox, C.Border, 1)
            Padding(hexBox, 0, 0, 8, 8)

            local function UpdateColor()
                currentColor = HsvToColor3(h_, s_, v_)
                swatch.BackgroundColor3 = currentColor
                svFrame.BackgroundColor3= HsvToColor3(h_, 1, 1)
                svCursor.Position       = UDim2.new(s_, -5, 1 - v_, -5)
                hueCursor.Position      = UDim2.new(h_, -4, 0, -2)
                hexBox.Text             = ColorToHex(currentColor)
                if cpcfg.Flag then RBX.Flags[cpcfg.Flag] = currentColor end
                if cpcfg.Callback then pcall(cpcfg.Callback, currentColor) end
            end

            local svDrag, hueDrag = false, false

            local svClick = Make("TextButton", { Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", ZIndex=30, Parent=svFrame })
            svClick.MouseButton1Down:Connect(function() svDrag = true end)

            local hueClick = Make("TextButton", { Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", ZIndex=30, Parent=hueBar })
            hueClick.MouseButton1Down:Connect(function() hueDrag = true end)

            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    svDrag = false; hueDrag = false
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType ~= Enum.UserInputType.MouseMovement then return end
                if svDrag then
                    local abs = svFrame.AbsolutePosition
                    local sz  = svFrame.AbsoluteSize
                    s_ = math.clamp((i.Position.X - abs.X) / sz.X, 0, 1)
                    v_ = 1 - math.clamp((i.Position.Y - abs.Y) / sz.Y, 0, 1)
                    UpdateColor()
                elseif hueDrag then
                    local abs = hueBar.AbsolutePosition
                    local sz  = hueBar.AbsoluteSize
                    h_ = math.clamp((i.Position.X - abs.X) / sz.X, 0, 1)
                    UpdateColor()
                end
            end)

            hexBox.FocusLost:Connect(function()
                local hex = hexBox.Text:gsub("#", "")
                if #hex == 6 then
                    local ok, col = pcall(Color3.fromHex, "#" .. hex)
                    if ok then
                        currentColor = col
                        h_, s_, v_ = col:ToHSV()
                        UpdateColor()
                    end
                end
            end)

            local swatchBtn = Make("TextButton", {
                Size                 = UDim2.new(0, 62, 0, 36),
                Position             = UDim2.new(1, -70, 0.5, -18),
                BackgroundTransparency = 1,
                Text                 = "",
                ZIndex               = 12,
                Parent               = card,
            })
            swatchBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    popup.Visible = true
                    popup.Size    = UDim2.new(1, 0, 0, 0)
                    Tween(popup, { Size = UDim2.new(1, 0, 0, popH) }, 0.22, Enum.EasingStyle.Back)
                else
                    Tween(popup, { Size = UDim2.new(1, 0, 0, 0) }, 0.18)
                    task.delay(0.2, function() popup.Visible = false end)
                end
            end)

            local CP = {}
            function CP:Set(c)
                currentColor = c; h_, s_, v_ = c:ToHSV(); UpdateColor()
            end
            function CP:Get() return currentColor end
            return CP
        end

        -- ─── CODE BLOCK ────────────────────────────────────────────────────
        function T:Code(ccfg)
            ccfg = ccfg or {}
            local card = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundColor3     = C.TrackBg,
                BorderSizePixel      = 0,
                Parent               = page,
            })
            Corner(card, 8)
            Stroke(card, C.Border, 1)
            Padding(card, 10, 10, 12, 12)
            ListLayout(card, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, 0)

            if ccfg.Title then
                Make("TextLabel", {
                    Size                 = UDim2.new(1, 0, 0, 18),
                    Text                 = ccfg.Title,
                    TextColor3           = C.TextMuted,
                    Font                 = Enum.Font.GothamBold,
                    TextSize             = 10,
                    TextXAlignment       = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Parent               = card,
                })
            end

            local codeLbl = Make("TextLabel", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                Text                 = ccfg.Code or "",
                TextColor3           = Color3.fromHex("#a78bfa"),
                Font                 = Enum.Font.Code,
                TextSize             = 12,
                TextXAlignment       = Enum.TextXAlignment.Left,
                TextWrapped          = true,
                RichText             = ccfg.RichText or false,
                BackgroundTransparency = 1,
                Parent               = card,
            })

            local C2 = {}
            function C2:Set(t) codeLbl.Text = t end
            return C2
        end

        -- ─── IMAGE ─────────────────────────────────────────────────────────
        function T:Image(imgcfg)
            imgcfg = imgcfg or {}
            local h    = imgcfg.Height or 120
            local card = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, h),
                BackgroundColor3     = C.Panel,
                BorderSizePixel      = 0,
                Parent               = page,
            })
            Corner(card, 8)
            Stroke(card, C.Border, 1)

            local img = Make("ImageLabel", {
                Size                   = UDim2.new(1, -4, 1, -4),
                Position               = UDim2.new(0, 2, 0, 2),
                BackgroundTransparency = 1,
                Image                  = imgcfg.Image or "",
                ScaleType              = imgcfg.ScaleType or Enum.ScaleType.Fit,
                Parent                 = card,
            })
            Corner(img, 7)

            if imgcfg.Title then
                Make("TextLabel", {
                    Size                 = UDim2.new(1, -20, 0, 20),
                    Position             = UDim2.new(0, 10, 0, 6),
                    Text                 = imgcfg.Title,
                    TextColor3           = Color3.new(1, 1, 1),
                    Font                 = Enum.Font.GothamBold,
                    TextSize             = 12,
                    TextXAlignment       = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    ZIndex               = 2,
                    Parent               = card,
                })
            end

            local Im = {}
            function Im:SetImage(id) img.Image = id end
            return Im
        end

        -- ─── TAG ───────────────────────────────────────────────────────────
        function T:Tag(tgcfg)
            tgcfg = tgcfg or {}
            -- Variants: default | primary | success | warning | error | info | outline
            local variants = {
                default = { bg = C.Tag,    fc = C.TextSecondary },
                primary = { bg = C.Accent, fc = Color3.new(1,1,1) },
                success = { bg = C.Success,fc = Color3.new(1,1,1) },
                warning = { bg = C.Warning,fc = Color3.new(0,0,0) },
                error   = { bg = C.Error,  fc = Color3.new(1,1,1) },
                info    = { bg = C.Info,   fc = Color3.new(1,1,1) },
                outline = { bg = Color3.fromRGB(0,0,0), fc = C.TextSecondary },
            }
            local v = variants[tgcfg.Variant or "default"] or variants.default

            local tagRow = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent               = page,
            })
            Padding(tagRow, 4, 4, 0, 0)
            ListLayout(tagRow, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, 6)

            for _, tagData in ipairs(tgcfg.Tags or {{ Label = tgcfg.Label or "Tag", Variant = tgcfg.Variant }}) do
                local tv = variants[tagData.Variant or "default"] or variants.default
                local tag = Make("Frame", {
                    Size                 = UDim2.new(0, 0, 0, 26),
                    AutomaticSize        = Enum.AutomaticSize.X,
                    BackgroundColor3     = tv.bg,
                    BackgroundTransparency = tagData.Variant == "outline" and 1 or 0,
                    BorderSizePixel      = 0,
                    Parent               = tagRow,
                })
                Corner(tag, 13)
                if tagData.Variant == "outline" then
                    Stroke(tag, C.Border, 1)
                end
                Padding(tag, 0, 0, 10, 10)
                Make("TextLabel", {
                    Size                 = UDim2.new(0, 0, 1, 0),
                    AutomaticSize        = Enum.AutomaticSize.X,
                    Text                 = tagData.Label or "",
                    TextColor3           = tv.fc,
                    Font                 = Enum.Font.GothamBold,
                    TextSize             = 11,
                    BackgroundTransparency = 1,
                    Parent               = tag,
                })
            end
        end

        -- ─── PROGRESS BAR ──────────────────────────────────────────────────
        function T:Progress(pgcfg)
            pgcfg  = pgcfg or {}
            local h    = pgcfg.Description and 60 or 50
            local card = Card(h)
            ElemTitle(card, pgcfg.Title, pgcfg.Description)

            local val      = math.clamp(pgcfg.Value or 0, 0, 100)
            local maxVal   = pgcfg.Max or 100
            local showText = pgcfg.ShowText ~= false

            local valLbl = Make("TextLabel", {
                Size                 = UDim2.new(0, 60, 0, 16),
                Position             = UDim2.new(1, -68, 0, pgcfg.Description and 8 or 0.5),
                AnchorPoint          = pgcfg.Description and Vector2.new(0,0) or Vector2.new(0, 0.5),
                Text                 = math.round(val) .. "%",
                TextColor3           = C.Accent,
                Font                 = Enum.Font.GothamBold,
                TextSize             = 11,
                TextXAlignment       = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                ZIndex               = 2,
                Parent               = card,
            })

            local track = Make("Frame", {
                Size             = UDim2.new(1, -24, 0, 6),
                Position         = UDim2.new(0, 12, 1, -16),
                BackgroundColor3 = C.TrackBg,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = card,
            })
            Corner(track, 4)

            local fill = Make("Frame", {
                Size             = UDim2.new(val / 100, 0, 1, 0),
                BackgroundColor3 = C.Accent,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = track,
            })
            Corner(fill, 4)

            local PG = {}
            function PG:Set(p)
                p = math.clamp(p, 0, 100)
                val = p
                Tween(fill, { Size = UDim2.new(p / 100, 0, 1, 0) }, 0.3, Enum.EasingStyle.Quart)
                valLbl.Text = math.round(p) .. "%"
            end
            function PG:Get() return val end
            return PG
        end

        -- ─── GROUP ─────────────────────────────────────────────────────────
        function T:Group(gcfg)
            gcfg = gcfg or {}
            local grp = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundColor3     = C.Panel,
                BorderSizePixel      = 0,
                Parent               = page,
            })
            Corner(grp, 10)
            Stroke(grp, C.Border, 1)

            -- Header bar
            local hdr = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = C.Surface,
                BorderSizePixel  = 0,
                Parent           = grp,
            })
            Make("UICorner", { CornerRadius = UDim.new(0, 10), Parent = hdr })
            Make("TextLabel", {
                Size                 = UDim2.new(1, -20, 1, 0),
                Position             = UDim2.new(0, 12, 0, 0),
                Text                 = gcfg.Title or "Group",
                TextColor3           = C.TextPrimary,
                Font                 = Enum.Font.GothamBold,
                TextSize             = 13,
                TextXAlignment       = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Parent               = hdr,
            })

            local body = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent               = grp,
            })
            ListLayout(body, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 4)
            Padding(body, 6, 8, 8, 8)

            -- Return a sub-tab-like object that places elements in the group body
            local G = { _frame = body }
            for k, v in pairs(T) do
                if type(v) == "function" and k ~= "Group" and k ~= "Section" then
                    G[k] = function(_, cfg2)
                        local orig = page
                        page = body
                        local r = v(T, cfg2)
                        page = orig
                        return r
                    end
                end
            end
            return G
        end

        -- ─── HSTACK ────────────────────────────────────────────────────────
        function T:HStack(hscfg)
            hscfg = hscfg or {}
            local stack = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, hscfg.Height or 44),
                BackgroundTransparency = 1,
                Parent               = page,
            })
            ListLayout(stack, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, hscfg.Spacing or 6)

            local S = {}
            S._frame = stack

            function S:Item(icfg)
                icfg = icfg or {}
                local item = Make("Frame", {
                    Size             = UDim2.new(0, icfg.Width or 80, 1, 0),
                    BackgroundColor3 = C.Panel,
                    BorderSizePixel  = 0,
                    Parent           = stack,
                })
                Corner(item, 8)
                Stroke(item, C.Border, 1)
                if icfg.Text then
                    Make("TextLabel", {
                        Size                 = UDim2.new(1, 0, 1, 0),
                        Text                 = icfg.Text,
                        TextColor3           = icfg.Color or C.TextPrimary,
                        Font                 = Enum.Font.GothamSemibold,
                        TextSize             = 12,
                        BackgroundTransparency = 1,
                        Parent               = item,
                    })
                end
                return item
            end

            return S
        end

        -- ─── VSTACK ────────────────────────────────────────────────────────
        function T:VStack(vscfg)
            vscfg = vscfg or {}
            local stack = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent               = page,
            })
            ListLayout(stack, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, vscfg.Spacing or 4)

            local S = {}
            S._frame = stack

            function S:Item(icfg)
                icfg = icfg or {}
                local item = Make("Frame", {
                    Size             = UDim2.new(1, 0, 0, icfg.Height or 40),
                    BackgroundColor3 = C.Panel,
                    BorderSizePixel  = 0,
                    Parent           = stack,
                })
                Corner(item, 8)
                Stroke(item, C.Border, 1)
                if icfg.Text then
                    Make("TextLabel", {
                        Size                 = UDim2.new(1, -20, 1, 0),
                        Position             = UDim2.new(0, 12, 0, 0),
                        Text                 = icfg.Text,
                        TextColor3           = icfg.Color or C.TextPrimary,
                        Font                 = Enum.Font.GothamSemibold,
                        TextSize             = 12,
                        TextXAlignment       = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        Parent               = item,
                    })
                end
                return item
            end

            return S
        end

        -- ─── TAB SECTION ───────────────────────────────────────────────────
        function T:TabSection(tscfg)
            tscfg = tscfg or {}
            local tabs = tscfg.Tabs or {}

            local wrapper = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundColor3     = C.Panel,
                BorderSizePixel      = 0,
                Parent               = page,
            })
            Corner(wrapper, 10)
            Stroke(wrapper, C.Border, 1)

            -- Tab buttons row
            local tabBar = Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = C.Surface,
                BorderSizePixel  = 0,
                Parent           = wrapper,
            })
            Make("UICorner", { CornerRadius = UDim.new(0, 10), Parent = tabBar })
            Make("Frame", {
                Size             = UDim2.new(1, 0, 0, 1),
                Position         = UDim2.new(0, 0, 1, -1),
                BackgroundColor3 = C.Border,
                BorderSizePixel  = 0,
                Parent           = tabBar,
            })
            Padding(tabBar, 0, 0, 6, 6)
            ListLayout(tabBar, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, 4)

            -- Content frame
            local contentFrame = Make("Frame", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent               = wrapper,
            })
            Padding(contentFrame, 8, 8, 8, 8)
            ListLayout(contentFrame, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 4)

            local tabObjects = {}
            local activeTS = nil

            local function selectTS(obj)
                if activeTS then
                    Tween(activeTS._btn, { BackgroundColor3 = C.Panel, BackgroundTransparency = 1 }, 0.15)
                    activeTS._btnLbl.TextColor3 = C.TextSecondary
                    activeTS._pane.Visible = false
                end
                activeTS = obj
                Tween(obj._btn, { BackgroundColor3 = C.Accent, BackgroundTransparency = 0 }, 0.15)
                obj._btnLbl.TextColor3 = Color3.new(1, 1, 1)
                obj._pane.Visible = true
            end

            for i, tabInfo in ipairs(tabs) do
                local tbtn = Make("TextButton", {
                    Size                 = UDim2.new(0, 0, 1, -8),
                    AutomaticSize        = Enum.AutomaticSize.X,
                    BackgroundColor3     = C.Panel,
                    BackgroundTransparency = 1,
                    BorderSizePixel      = 0,
                    Text                 = "",
                    Parent               = tabBar,
                })
                Corner(tbtn, 8)
                Padding(tbtn, 0, 0, 10, 10)

                local tLbl = Make("TextLabel", {
                    Size                 = UDim2.new(0, 0, 1, 0),
                    AutomaticSize        = Enum.AutomaticSize.X,
                    Text                 = tabInfo.Title or ("Tab " .. i),
                    TextColor3           = C.TextSecondary,
                    Font                 = Enum.Font.GothamBold,
                    TextSize             = 12,
                    BackgroundTransparency = 1,
                    Parent               = tbtn,
                })

                local pane = Make("Frame", {
                    Size                 = UDim2.new(1, 0, 0, 0),
                    AutomaticSize        = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Visible              = false,
                    Parent               = contentFrame,
                })
                ListLayout(pane, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Center, 4)

                local tObj = { _btn = tbtn, _btnLbl = tLbl, _pane = pane }
                table.insert(tabObjects, tObj)

                tbtn.MouseButton1Click:Connect(function() selectTS(tObj) end)

                if i == 1 then selectTS(tObj) end
            end

            local TS = {}
            for i, tObj in ipairs(tabObjects) do
                TS[i] = { _page = tObj._pane }
                -- Forward element methods
                local capPage = tObj._pane
                for k, v in pairs(T) do
                    if type(v) == "function" then
                        TS[i][k] = function(_, cfg2)
                            local orig = page
                            page = capPage
                            local r = v(T, cfg2)
                            page = orig
                            return r
                        end
                    end
                end
            end

            return TS
        end

        return T
    end  -- Window:Tab

    -- ─── SIDEBAR SECTION LABEL ──────────────────────────────────────────────
    function Window:SidebarSection(title)
        Make("TextLabel", {
            Size                 = UDim2.new(1, 0, 0, 22),
            Text                 = ("  " .. (title or "")):upper(),
            TextColor3           = C.TextMuted,
            Font                 = Enum.Font.GothamBold,
            TextSize             = 9,
            LetterSpacing        = 1,
            TextXAlignment       = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent               = tabList,
        })
    end

    -- ─── SIDEBAR DIVIDER ────────────────────────────────────────────────────
    function Window:SidebarDivider()
        Make("Frame", {
            Size             = UDim2.new(0.85, 0, 0, 1),
            BackgroundColor3 = C.Border,
            BorderSizePixel  = 0,
            Parent           = tabList,
        })
    end

    -- ─── DIALOG ─────────────────────────────────────────────────────────────
    function Window:Dialog(dcfg)
        dcfg = dcfg or {}
        local dW = dcfg.Width or 320

        local overlay = Make("Frame", {
            Size                 = UDim2.new(1, 0, 1, 0),
            BackgroundColor3     = Color3.new(0, 0, 0),
            BackgroundTransparency = 0.45,
            BorderSizePixel      = 0,
            ZIndex               = 50,
            Parent               = win,
        })

        local dialog = Make("Frame", {
            Size             = UDim2.new(0, dW, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            Position         = UDim2.new(0.5, -dW/2, 0.5, -80),
            BackgroundColor3 = C.Surface,
            BorderSizePixel  = 0,
            ZIndex           = 51,
            Parent           = overlay,
        })
        Corner(dialog, 12)
        Stroke(dialog, C.Border, 1)
        Padding(dialog, 16, 16, 16, 16)
        ListLayout(dialog, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, 8)

        -- Icon
        if dcfg.Icon then
            Make("TextLabel", {
                Size                 = UDim2.new(0, 32, 0, 32),
                Text                 = dcfg.Icon,
                Font                 = Enum.Font.GothamBold,
                TextSize             = 20,
                BackgroundTransparency = 1,
                ZIndex               = 52,
                Parent               = dialog,
            })
        end

        Make("TextLabel", {
            Size                 = UDim2.new(1, 0, 0, 22),
            Text                 = dcfg.Title or "Dialog",
            TextColor3           = C.TextPrimary,
            Font                 = Enum.Font.GothamBold,
            TextSize             = 15,
            TextXAlignment       = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex               = 52,
            Parent               = dialog,
        })

        if dcfg.Content then
            Make("TextLabel", {
                Size                 = UDim2.new(1, 0, 0, 0),
                AutomaticSize        = Enum.AutomaticSize.Y,
                Text                 = dcfg.Content,
                TextColor3           = C.TextSecondary,
                Font                 = Enum.Font.Gotham,
                TextSize             = 12,
                TextXAlignment       = Enum.TextXAlignment.Left,
                TextWrapped          = true,
                BackgroundTransparency = 1,
                ZIndex               = 52,
                Parent               = dialog,
            })
        end

        local btnRow = Make("Frame", {
            Size                 = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            ZIndex               = 52,
            Parent               = dialog,
        })
        ListLayout(btnRow, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Right, 8)

        for _, b in ipairs(dcfg.Buttons or {}) do
            local isPrimary = b.Variant == "Primary"
            local db = Make("TextButton", {
                Size             = UDim2.new(0, 94, 0, 32),
                BackgroundColor3 = isPrimary and C.Accent or C.TrackBg,
                Text             = b.Title or "OK",
                TextColor3       = isPrimary and Color3.new(1, 1, 1) or C.TextSecondary,
                Font             = Enum.Font.GothamBold,
                TextSize         = 12,
                BorderSizePixel  = 0,
                ZIndex           = 53,
                Parent           = btnRow,
            })
            Corner(db, 8)
            if not isPrimary then Stroke(db, C.Border, 1) end

            db.MouseEnter:Connect(function()
                Tween(db, { BackgroundColor3 = isPrimary and C.AccentHover or C.SurfaceHover }, 0.12)
            end)
            db.MouseLeave:Connect(function()
                Tween(db, { BackgroundColor3 = isPrimary and C.Accent or C.TrackBg }, 0.12)
            end)
            db.MouseButton1Click:Connect(function()
                overlay:Destroy()
                if b.Callback then pcall(b.Callback) end
            end)
        end

        -- Entrance
        dialog.Position         = UDim2.new(0.5, -dW/2, 0.5, -60)
        dialog.BackgroundTransparency = 1
        Spring(dialog, { Position = UDim2.new(0.5, -dW/2, 0.5, -80), BackgroundTransparency = 0 }, 0.35)
    end

    -- ─── POPUP ──────────────────────────────────────────────────────────────
    function Window:Popup(pcfg)
        pcfg = pcfg or {}
        local typeColors = { success = C.Success, warning = C.Warning, error = C.Error, info = C.Info }
        local typeIcons  = { success = "✓", warning = "⚠", error = "✕", info = "ℹ" }
        local accent = typeColors[pcfg.Type or "success"] or C.Success

        local popup = Make("Frame", {
            Size             = UDim2.new(0, 260, 0, 60),
            Position         = UDim2.new(0.5, -130, 0.5, -30),
            BackgroundColor3 = C.Surface,
            BorderSizePixel  = 0,
            ZIndex           = 60,
            Parent           = win,
        })
        Corner(popup, 10)
        Stroke(popup, C.Border, 1)

        Make("Frame", { Size=UDim2.new(0,3,1,0), BackgroundColor3=accent, BorderSizePixel=0, Parent=popup })

        Make("TextLabel", {
            Size                 = UDim2.new(0, 28, 0, 28),
            Position             = UDim2.new(0, 14, 0.5, -14),
            Text                 = typeIcons[pcfg.Type or "success"],
            TextColor3           = accent,
            Font                 = Enum.Font.GothamBold,
            TextSize             = 16,
            BackgroundTransparency = 1,
            ZIndex               = 61,
            Parent               = popup,
        })

        Make("TextLabel", {
            Size                 = UDim2.new(1, -60, 0, 20),
            Position             = UDim2.new(0, 48, 0, 10),
            Text                 = pcfg.Title or "Success!",
            TextColor3           = C.TextPrimary,
            Font                 = Enum.Font.GothamBold,
            TextSize             = 13,
            TextXAlignment       = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            ZIndex               = 61,
            Parent               = popup,
        })

        if pcfg.Content then
            Make("TextLabel", {
                Size                 = UDim2.new(1, -60, 0, 18),
                Position             = UDim2.new(0, 48, 0, 30),
                Text                 = pcfg.Content,
                TextColor3           = C.TextSecondary,
                Font                 = Enum.Font.Gotham,
                TextSize             = 11,
                TextXAlignment       = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                ZIndex               = 61,
                Parent               = popup,
            })
        end

        local closeBtn = Make("TextButton", {
            Size                 = UDim2.new(0, 22, 0, 22),
            Position             = UDim2.new(1, -26, 0, 4),
            BackgroundTransparency = 1,
            Text                 = "×",
            TextColor3           = C.TextMuted,
            Font                 = Enum.Font.GothamBold,
            TextSize             = 14,
            ZIndex               = 62,
            Parent               = popup,
        })

        popup.Position = UDim2.new(0.5, -130, 0, -70)
        Spring(popup, { Position = UDim2.new(0.5, -130, 0, 10) }, 0.35)

        local function dismiss()
            Tween(popup, { Position = UDim2.new(0.5, -130, 0, -80), BackgroundTransparency = 1 }, 0.22)
            task.delay(0.28, function() popup:Destroy() end)
        end

        closeBtn.MouseButton1Click:Connect(dismiss)
        task.delay(pcfg.Duration or 3, dismiss)
    end

    -- ─── NOTIFICATION shortcut ──────────────────────────────────────────────
    function Window:Notify(cfg2)
        cfg2.Theme = self.ThemeName
        return Notify(cfg2)
    end

    -- ─── CONFIGS ────────────────────────────────────────────────────────────
    function Window:SaveConfig(name)
        -- Encode all flags to JSON and store in a DataStore-like table
        local data = {}
        for k, v in pairs(RBX.Flags) do
            local t = typeof(v)
            if t == "boolean" or t == "number" or t == "string" then
                data[k] = v
            elseif t == "EnumItem" then
                data[k] = "__enum__" .. tostring(v)
            elseif t == "Color3" then
                data[k] = "__color3__" .. ColorToHex(v)
            end
        end
        -- In a real hub you'd persist via writefile/DataStore
        return data
    end

    function Window:LoadConfig(data)
        if type(data) ~= "table" then return end
        for k, v in pairs(data) do
            if type(v) == "string" then
                if v:sub(1, 8) == "__enum__" then
                    local enumStr = v:sub(9)
                    local parts   = enumStr:split(".")
                    if #parts == 2 then
                        local ok, ev = pcall(function() return Enum[parts[1]][parts[2]] end)
                        if ok then RBX.Flags[k] = ev end
                    end
                elseif v:sub(1, 10) == "__color3__" then
                    local ok, col = pcall(Color3.fromHex, v:sub(11))
                    if ok then RBX.Flags[k] = col end
                else
                    RBX.Flags[k] = v
                end
            else
                RBX.Flags[k] = v
            end
        end
    end

    -- ─── THEME SWITCHER ─────────────────────────────────────────────────────
    function Window:SetTheme(name)
        local nc = Themes[name]
        if not nc then return end
        C              = nc
        self.Theme     = nc
        self.ThemeName = name
        Tween(win,    { BackgroundColor3 = nc.Background }, 0.3)
        Tween(topbar, { BackgroundColor3 = nc.Topbar },     0.3)
        Tween(sidebar,{ BackgroundColor3 = nc.Sidebar },    0.3)
    end

    -- ─── VISIBILITY ─────────────────────────────────────────────────────────
    function Window:Toggle()
        win.Visible    = not win.Visible
        shadow.Visible = win.Visible
    end

    function Window:Open()
        win.Visible    = true
        shadow.Visible = true
        win.Size       = UDim2.new(0, W * 0.94, 0, H * 0.94)
        win.BackgroundTransparency = 1
        Spring(win, { Size = UDim2.new(0, W, 0, H), BackgroundTransparency = 0 }, 0.38)
    end

    function Window:Close()
        Tween(win, { Size = UDim2.new(0, W * 0.94, 0, H * 0.94), BackgroundTransparency = 1 }, 0.2)
        task.delay(0.26, function() win.Visible = false; shadow.Visible = false end)
    end

    function Window:Destroy()
        self:Close()
        task.delay(0.32, function() sg:Destroy() end)
    end

    -- ── Toggle key ──────────────────────────────────────────────────────────
    if cfg.ToggleKey then
        UserInputService.InputBegan:Connect(function(input, gpe)
            if not gpe and input.KeyCode == cfg.ToggleKey then
                Window:Toggle()
            end
        end)
    end

    -- ── Entrance animation ──────────────────────────────────────────────────
    win.Size                  = UDim2.new(0, W * 0.9, 0, H * 0.9)
    win.BackgroundTransparency = 0.4
    Spring(win, { Size = UDim2.new(0, W, 0, H), BackgroundTransparency = 0 }, 0.45)

    table.insert(RBX._windows, Window)
    return Window
end

-- ─────────────────────────────────────────────────────────────────────────────
return RBX
