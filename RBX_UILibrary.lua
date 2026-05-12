-- ============================================
--         RBX UI Library v1.0
--      Modern • Clean • Powerful
-- ============================================

local RBXLib = {}
RBXLib.__index = RBXLib

-- ══════════════════════════════════════
--              THEME CONFIG
-- ══════════════════════════════════════
local Theme = {
    Background     = Color3.fromRGB(18, 14, 30),      -- dark bg
    Sidebar        = Color3.fromRGB(24, 18, 40),       -- sidebar bg
    Panel          = Color3.fromRGB(30, 24, 50),       -- panel/card bg
    Accent         = Color3.fromRGB(138, 79, 255),     -- purple accent
    AccentHover    = Color3.fromRGB(160, 100, 255),
    TextPrimary    = Color3.fromRGB(255, 255, 255),
    TextSecondary  = Color3.fromRGB(170, 160, 200),
    ToggleOn       = Color3.fromRGB(138, 79, 255),
    ToggleOff      = Color3.fromRGB(70, 60, 90),
    ToggleKnob     = Color3.fromRGB(255, 255, 255),
    NavActive      = Color3.fromRGB(138, 79, 255),
    NavHover       = Color3.fromRGB(45, 35, 65),
    Border         = Color3.fromRGB(60, 45, 90),
}

-- ══════════════════════════════════════
--           UTILITY FUNCTIONS
-- ══════════════════════════════════════

local TweenService  = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function Tween(obj, props, duration, style, dir)
    local info = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        dir   or Enum.EasingDirection.Out
    )
    TweenService:Create(obj, info, props):Play()
end

local function MakeInstance(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        inst[k] = v
    end
    return inst
end

local function AddCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
end

local function AddStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Border
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
end

-- ══════════════════════════════════════
--           CREATE WINDOW
-- ══════════════════════════════════════

function RBXLib:CreateWindow(config)
    config = config or {}
    local title    = config.Title    or "RBX UI Library"
    local subtitle = config.Subtitle or "Modern • Clean • Powerful"
    local size     = config.Size     or UDim2.new(0, 680, 0, 460)

    -- ScreenGui
    local ScreenGui = MakeInstance("ScreenGui", {
        Name            = "RBXUILibrary",
        ResetOnSpawn    = false,
        ZIndexBehavior  = Enum.ZIndexBehavior.Sibling,
        Parent          = game:GetService("CoreGui"),
    })

    -- Main Frame
    local MainFrame = MakeInstance("Frame", {
        Name            = "MainFrame",
        Size            = size,
        Position        = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint     = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent          = ScreenGui,
    })
    AddCorner(MainFrame, 14)
    AddStroke(MainFrame, Theme.Border, 1)

    -- Drop Shadow (illusion via another frame)
    local Shadow = MakeInstance("Frame", {
        Name              = "Shadow",
        Size              = UDim2.new(1, 20, 1, 20),
        Position          = UDim2.new(0, -10, 0, 8),
        BackgroundColor3  = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.65,
        BorderSizePixel   = 0,
        ZIndex            = 0,
        Parent            = MainFrame,
    })
    AddCorner(Shadow, 18)

    -- ── SIDEBAR ───────────────────────────────────
    local Sidebar = MakeInstance("Frame", {
        Name            = "Sidebar",
        Size            = UDim2.new(0, 200, 1, 0),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        Parent          = MainFrame,
    })
    AddCorner(Sidebar, 14)

    -- Fix right corners of sidebar (clip to straight edge)
    local SidebarFix = MakeInstance("Frame", {
        Size              = UDim2.new(0, 14, 1, 0),
        Position          = UDim2.new(1, -14, 0, 0),
        BackgroundColor3  = Theme.Sidebar,
        BorderSizePixel   = 0,
        Parent            = Sidebar,
    })

    -- Logo Icon
    local LogoFrame = MakeInstance("Frame", {
        Name             = "LogoFrame",
        Size             = UDim2.new(0, 64, 0, 64),
        Position         = UDim2.new(0.5, -32, 0, 24),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel  = 0,
        Parent           = Sidebar,
    })
    AddCorner(LogoFrame, 14)

    local LogoInner = MakeInstance("Frame", {
        Size             = UDim2.new(0, 22, 0, 22),
        Position         = UDim2.new(0.5, -11, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(24, 10, 50),
        BorderSizePixel  = 0,
        Parent           = LogoFrame,
    })
    AddCorner(LogoInner, 4)

    -- Title
    MakeInstance("TextLabel", {
        Name             = "Title",
        Size             = UDim2.new(1, -20, 0, 22),
        Position         = UDim2.new(0, 10, 0, 100),
        BackgroundTransparency = 1,
        Text             = title,
        TextColor3       = Theme.TextPrimary,
        Font             = Enum.Font.GothamBold,
        TextSize         = 16,
        TextXAlignment   = Enum.TextXAlignment.Center,
        Parent           = Sidebar,
    })

    MakeInstance("TextLabel", {
        Name             = "Subtitle",
        Size             = UDim2.new(1, -20, 0, 16),
        Position         = UDim2.new(0, 10, 0, 124),
        BackgroundTransparency = 1,
        Text             = subtitle,
        TextColor3       = Theme.TextSecondary,
        Font             = Enum.Font.Gotham,
        TextSize         = 11,
        TextXAlignment   = Enum.TextXAlignment.Center,
        Parent           = Sidebar,
    })

    -- Divider
    MakeInstance("Frame", {
        Size             = UDim2.new(1, -30, 0, 1),
        Position         = UDim2.new(0, 15, 0, 154),
        BackgroundColor3 = Theme.Border,
        BorderSizePixel  = 0,
        Parent           = Sidebar,
    })

    -- Nav container
    local NavList = MakeInstance("Frame", {
        Name             = "NavList",
        Size             = UDim2.new(1, -20, 1, -175),
        Position         = UDim2.new(0, 10, 0, 165),
        BackgroundTransparency = 1,
        Parent           = Sidebar,
    })
    local NavLayout = MakeInstance("UIListLayout", {
        Padding          = UDim.new(0, 6),
        SortOrder        = Enum.SortOrder.LayoutOrder,
        Parent           = NavList,
    })

    -- ── CONTENT AREA ─────────────────────────────
    local Content = MakeInstance("Frame", {
        Name             = "Content",
        Size             = UDim2.new(1, -210, 1, -20),
        Position         = UDim2.new(0, 205, 0, 10),
        BackgroundTransparency = 1,
        Parent           = MainFrame,
    })

    -- Section Title
    local SectionTitle = MakeInstance("TextLabel", {
        Name             = "SectionTitle",
        Size             = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Text             = "TOGGLE BUTTON",
        TextColor3       = Theme.Accent,
        Font             = Enum.Font.GothamBold,
        TextSize         = 13,
        TextXAlignment   = Enum.TextXAlignment.Left,
        Parent           = Content,
    })

    -- Item container
    local ItemList = MakeInstance("Frame", {
        Name             = "ItemList",
        Size             = UDim2.new(1, 0, 1, -35),
        Position         = UDim2.new(0, 0, 0, 35),
        BackgroundTransparency = 1,
        Parent           = Content,
    })
    MakeInstance("UIListLayout", {
        Padding    = UDim.new(0, 8),
        SortOrder  = Enum.SortOrder.LayoutOrder,
        Parent     = ItemList,
    })

    -- ── DRAG SUPPORT ─────────────────────────────
    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = input.Position
            startPos  = MainFrame.Position
        end
    end)
    MainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Window object
    local Window = {
        ScreenGui   = ScreenGui,
        MainFrame   = MainFrame,
        NavList     = NavList,
        ItemList    = ItemList,
        SectionTitle = SectionTitle,
        _tabs       = {},
        _activeTab  = nil,
    }

    -- ══════════════════════════════════════
    --         ADD TAB (Nav Button)
    -- ══════════════════════════════════════
    function Window:AddTab(config)
        config = config or {}
        local tabName = config.Name or "Tab"
        local icon    = config.Icon or "rbxassetid://0"   -- replace with real asset

        local NavBtn = MakeInstance("TextButton", {
            Name             = tabName,
            Size             = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = Theme.NavHover,
            BackgroundTransparency = 1,
            Text             = "",
            AutoButtonColor  = false,
            Parent           = NavList,
        })
        AddCorner(NavBtn, 8)

        -- Icon
        local Icon = MakeInstance("ImageLabel", {
            Size             = UDim2.new(0, 18, 0, 18),
            Position         = UDim2.new(0, 12, 0.5, -9),
            BackgroundTransparency = 1,
            Image            = icon,
            ImageColor3      = Theme.TextSecondary,
            Parent           = NavBtn,
        })

        -- Label
        local Label = MakeInstance("TextLabel", {
            Size             = UDim2.new(1, -40, 1, 0),
            Position         = UDim2.new(0, 38, 0, 0),
            BackgroundTransparency = 1,
            Text             = tabName,
            TextColor3       = Theme.TextSecondary,
            Font             = Enum.Font.GothamSemibold,
            TextSize         = 13,
            TextXAlignment   = Enum.TextXAlignment.Left,
            Parent           = NavBtn,
        })

        local Tab = { Name = tabName, Button = NavBtn, _sections = {} }

        -- Activate tab
        local function Activate()
            -- Deactivate others
            for _, t in pairs(Window._tabs) do
                Tween(t.Button, { BackgroundTransparency = 1 })
                t.Button:FindFirstChild("TextLabel") and
                    Tween(t.Button.TextLabel, { TextColor3 = Theme.TextSecondary })
                t.Button:FindFirstChild("ImageLabel") and
                    Tween(t.Button.ImageLabel, { ImageColor3 = Theme.TextSecondary })
            end
            -- Activate this
            NavBtn.BackgroundColor3 = Theme.NavActive
            Tween(NavBtn, { BackgroundTransparency = 0 })
            Tween(Label, { TextColor3 = Theme.TextPrimary })
            Tween(Icon,  { ImageColor3 = Theme.TextPrimary })
            Window._activeTab = Tab
        end

        NavBtn.MouseButton1Click:Connect(Activate)
        NavBtn.MouseEnter:Connect(function()
            if Window._activeTab ~= Tab then
                Tween(NavBtn, { BackgroundTransparency = 0.8 })
                NavBtn.BackgroundColor3 = Theme.NavHover
            end
        end)
        NavBtn.MouseLeave:Connect(function()
            if Window._activeTab ~= Tab then
                Tween(NavBtn, { BackgroundTransparency = 1 })
            end
        end)

        table.insert(Window._tabs, Tab)

        -- Auto-activate first tab
        if #Window._tabs == 1 then Activate() end

        return Tab
    end

    -- ══════════════════════════════════════
    --           ADD TOGGLE
    -- ══════════════════════════════════════
    function Window:AddToggle(config)
        config = config or {}
        local label    = config.Label       or "Toggle"
        local desc     = config.Description or ""
        local default  = config.Default     or false
        local icon     = config.Icon        or nil
        local callback = config.Callback    or function() end

        local state = default

        -- Card
        local Card = MakeInstance("Frame", {
            Name             = label,
            Size             = UDim2.new(1, 0, 0, 62),
            BackgroundColor3 = Theme.Panel,
            BorderSizePixel  = 0,
            Parent           = ItemList,
        })
        AddCorner(Card, 10)
        AddStroke(Card, Theme.Border, 1)

        -- Optional icon
        local textOffsetX = 14
        if icon then
            local IconImg = MakeInstance("ImageLabel", {
                Size             = UDim2.new(0, 22, 0, 22),
                Position         = UDim2.new(0, 14, 0.5, -11),
                BackgroundTransparency = 1,
                Image            = icon,
                ImageColor3      = Theme.TextSecondary,
                Parent           = Card,
            })
            textOffsetX = 46
        end

        -- Label
        MakeInstance("TextLabel", {
            Size             = UDim2.new(1, -80, 0, 20),
            Position         = UDim2.new(0, textOffsetX, 0, 12),
            BackgroundTransparency = 1,
            Text             = label,
            TextColor3       = Theme.TextPrimary,
            Font             = Enum.Font.GothamBold,
            TextSize         = 13,
            TextXAlignment   = Enum.TextXAlignment.Left,
            Parent           = Card,
        })

        -- Description
        if desc ~= "" then
            MakeInstance("TextLabel", {
                Size             = UDim2.new(1, -80, 0, 16),
                Position         = UDim2.new(0, textOffsetX, 0, 34),
                BackgroundTransparency = 1,
                Text             = desc,
                TextColor3       = Theme.TextSecondary,
                Font             = Enum.Font.Gotham,
                TextSize         = 11,
                TextXAlignment   = Enum.TextXAlignment.Left,
                Parent           = Card,
            })
        end

        -- Toggle Track
        local Track = MakeInstance("Frame", {
            Name             = "Track",
            Size             = UDim2.new(0, 44, 0, 24),
            Position         = UDim2.new(1, -56, 0.5, -12),
            BackgroundColor3 = state and Theme.ToggleOn or Theme.ToggleOff,
            BorderSizePixel  = 0,
            Parent           = Card,
        })
        AddCorner(Track, 12)

        -- Toggle Knob
        local Knob = MakeInstance("Frame", {
            Name             = "Knob",
            Size             = UDim2.new(0, 18, 0, 18),
            Position         = state and UDim2.new(0, 23, 0, 3) or UDim2.new(0, 3, 0, 3),
            BackgroundColor3 = Theme.ToggleKnob,
            BorderSizePixel  = 0,
            Parent           = Track,
        })
        AddCorner(Knob, 9)

        -- Click handler on entire card
        local ClickBtn = MakeInstance("TextButton", {
            Size             = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text             = "",
            ZIndex           = 5,
            Parent           = Card,
        })

        ClickBtn.MouseButton1Click:Connect(function()
            state = not state
            Tween(Track, { BackgroundColor3 = state and Theme.ToggleOn or Theme.ToggleOff }, 0.15)
            Tween(Knob,  { Position = state and UDim2.new(0, 23, 0, 3) or UDim2.new(0, 3, 0, 3) }, 0.15)
            pcall(callback, state)
        end)

        -- Hover glow
        ClickBtn.MouseEnter:Connect(function()
            Tween(Card, { BackgroundColor3 = Color3.fromRGB(38, 30, 62) }, 0.1)
        end)
        ClickBtn.MouseLeave:Connect(function()
            Tween(Card, { BackgroundColor3 = Theme.Panel }, 0.1)
        end)

        local Toggle = {}
        function Toggle:Set(value)
            state = value
            Tween(Track, { BackgroundColor3 = state and Theme.ToggleOn or Theme.ToggleOff }, 0.15)
            Tween(Knob,  { Position = state and UDim2.new(0, 23, 0, 3) or UDim2.new(0, 3, 0, 3) }, 0.15)
        end
        function Toggle:Get() return state end

        return Toggle
    end

    return Window
end

-- ══════════════════════════════════════
--            DEMO / EXAMPLE
-- ══════════════════════════════════════
-- Uncomment to run a demo:

--[[
local lib = RBXLib:CreateWindow({
    Title    = "RBX UI Library",
    Subtitle = "Modern • Clean • Powerful",
    Size     = UDim2.new(0, 680, 0, 460),
})

local homeTab = lib:AddTab({ Name = "Home",     Icon = "rbxassetid://7733960981" })
local playerTab = lib:AddTab({ Name = "Player", Icon = "rbxassetid://7733715400" })
local settingsTab = lib:AddTab({ Name = "Settings", Icon = "rbxassetid://7734053495" })

local t1 = lib:AddToggle({
    Label       = "Toggle ON",
    Description = "This is an active toggle button.",
    Default     = true,
    Callback    = function(v) print("Toggle ON:", v) end,
})

local t2 = lib:AddToggle({
    Label       = "Toggle OFF",
    Description = "This is an inactive toggle button.",
    Default     = false,
    Callback    = function(v) print("Toggle OFF:", v) end,
})

local t3 = lib:AddToggle({
    Label       = "Toggle with Icon",
    Description = "Enable notifications",
    Default     = true,
    Icon        = "rbxassetid://7734045455",
    Callback    = function(v) print("Notifications:", v) end,
})
]]

return RBXLib
