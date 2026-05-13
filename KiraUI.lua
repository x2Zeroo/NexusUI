--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                        KIRA UI LIBRARY                       ║
    ║                  Premium Roblox UI Framework                 ║
    ║                                                              ║
    ║  Version : 1.0.0                                             ║
    ║  Style   : Modern Minimal (Dark)                             ║
    ║  Support : PC + Mobile                                       ║
    ║                                                              ║
    ║  Usage:                                                      ║
    ║    local Library = loadstring(game:HttpGet("..."))()         ║
    ║    local Window  = Library:CreateWindow("Kira Hub")          ║
    ║    local Tab     = Window:CreateTab("Main")                  ║
    ║    Tab:Button("Click me", function() print("Hi") end)        ║
    ╚══════════════════════════════════════════════════════════════╝
]]

--==============================================================--
--                           SERVICES                           --
--==============================================================--
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local CoreGui           = game:GetService("CoreGui")
local Players           = game:GetService("Players")
local HttpService       = game:GetService("HttpService")
local TextService       = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

--==============================================================--
--                           THEMES                             --
--==============================================================--
local Themes = {
    Dark = {
        Background      = Color3.fromRGB(15, 15, 20),
        Sidebar         = Color3.fromRGB(20, 20, 28),
        Topbar          = Color3.fromRGB(18, 18, 24),
        Card            = Color3.fromRGB(26, 26, 36),
        CardHover       = Color3.fromRGB(32, 32, 44),
        Element         = Color3.fromRGB(34, 34, 46),
        ElementHover    = Color3.fromRGB(42, 42, 56),
        Border          = Color3.fromRGB(40, 40, 54),
        BorderLight     = Color3.fromRGB(50, 50, 66),
        Accent          = Color3.fromRGB(139, 92, 246),
        AccentDark      = Color3.fromRGB(109, 62, 216),
        AccentText      = Color3.fromRGB(255, 255, 255),
        Text            = Color3.fromRGB(245, 245, 250),
        TextSub         = Color3.fromRGB(160, 160, 180),
        TextDim         = Color3.fromRGB(110, 110, 130),
        Success         = Color3.fromRGB(72, 199, 142),
        Warning         = Color3.fromRGB(245, 178, 78),
        Error           = Color3.fromRGB(232, 86, 86),
    },
    Light = {
        Background      = Color3.fromRGB(245, 245, 250),
        Sidebar         = Color3.fromRGB(238, 238, 244),
        Topbar          = Color3.fromRGB(240, 240, 246),
        Card            = Color3.fromRGB(255, 255, 255),
        CardHover       = Color3.fromRGB(248, 248, 252),
        Element         = Color3.fromRGB(240, 240, 245),
        ElementHover    = Color3.fromRGB(232, 232, 240),
        Border          = Color3.fromRGB(225, 225, 232),
        BorderLight     = Color3.fromRGB(210, 210, 220),
        Accent          = Color3.fromRGB(139, 92, 246),
        AccentDark      = Color3.fromRGB(109, 62, 216),
        AccentText      = Color3.fromRGB(255, 255, 255),
        Text            = Color3.fromRGB(20, 20, 28),
        TextSub         = Color3.fromRGB(90, 90, 110),
        TextDim         = Color3.fromRGB(140, 140, 160),
        Success         = Color3.fromRGB(40, 170, 110),
        Warning         = Color3.fromRGB(220, 150, 50),
        Error           = Color3.fromRGB(220, 70, 70),
    },
}

--==============================================================--
--                       UTILITY FUNCTIONS                      --
--==============================================================--
local Util = {}

-- Generic Create function
function Util.Create(class, props, children)
    local inst = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            inst[k] = v
        end
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = inst
        end
    end
    return inst
end

-- Quick tween
function Util.Tween(obj, time, props, style, dir)
    local info = TweenInfo.new(
        time or 0.2,
        style or Enum.EasingStyle.Quint,
        dir or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(obj, info, props)
    tween:Play()
    return tween
end

-- Rounded corner
function Util.Corner(parent, radius)
    return Util.Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 6),
        Parent = parent,
    })
end

-- Stroke
function Util.Stroke(parent, color, thickness, transparency)
    return Util.Create("UIStroke", {
        Color = color or Color3.fromRGB(40, 40, 54),
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

-- Padding
function Util.Padding(parent, top, right, bottom, left)
    top = top or 0
    right = right or top
    bottom = bottom or top
    left = left or right
    return Util.Create("UIPadding", {
        PaddingTop    = UDim.new(0, top),
        PaddingRight  = UDim.new(0, right),
        PaddingBottom = UDim.new(0, bottom),
        PaddingLeft   = UDim.new(0, left),
        Parent = parent,
    })
end

-- List layout
function Util.List(parent, padding, dir, hAlign, vAlign)
    return Util.Create("UIListLayout", {
        Padding = UDim.new(0, padding or 6),
        FillDirection = dir or Enum.FillDirection.Vertical,
        HorizontalAlignment = hAlign or Enum.HorizontalAlignment.Left,
        VerticalAlignment = vAlign or Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = parent,
    })
end

-- Ripple effect
function Util.Ripple(parent, x, y)
    local ripple = Util.Create("Frame", {
        Name = "Ripple",
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Position = UDim2.new(0, x - parent.AbsolutePosition.X, 0, y - parent.AbsolutePosition.Y),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = (parent.ZIndex or 1) + 1,
    })
    Util.Corner(ripple, 100)
    local maxSize = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2
    Util.Tween(ripple, 0.5, {
        Size = UDim2.new(0, maxSize, 0, maxSize),
        BackgroundTransparency = 1,
    })
    task.delay(0.5, function() ripple:Destroy() end)
end

-- Drag system (works on PC + Mobile)
function Util.MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Get text bounds
function Util.TextSize(text, size, font)
    return TextService:GetTextSize(text, size, font or Enum.Font.Gotham, Vector2.new(9999, 9999))
end

-- Mobile detection
function Util.IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

-- Safe parent (handles executor environments)
function Util.SafeParent(gui)
    local ok = pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(gui)
            gui.Parent = CoreGui
        elseif gethui then
            gui.Parent = gethui()
        elseif CoreGui then
            gui.Parent = CoreGui
        end
    end)
    if not ok then
        gui.Parent = PlayerGui
    end
end

--==============================================================--
--                         LIBRARY CORE                         --
--==============================================================--
local Library = {}
Library.__index = Library

Library.Version  = "1.0.0"
Library.Theme    = Themes.Dark
Library.Windows  = {}
Library.Flags    = {}
Library.ConfigFolder = "KiraUI"

function Library.new(themeName)
    local self = setmetatable({}, Library)
    self.Theme   = Themes[themeName or "Dark"] or Themes.Dark
    self.Windows = {}
    self.Flags   = {}
    return self
end

function Library:SetTheme(themeName)
    if Themes[themeName] then
        self.Theme = Themes[themeName]
        -- Theme refresh hooks could be added here
    end
end

--==============================================================--
--                        NOTIFICATION                          --
--==============================================================--
local NotificationGui
local function getNotificationHolder()
    if NotificationGui and NotificationGui.Parent then return NotificationGui end
    NotificationGui = Util.Create("ScreenGui", {
        Name = "KiraUI_Notifications",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 9999,
    })
    Util.SafeParent(NotificationGui)
    local holder = Util.Create("Frame", {
        Name = "Holder",
        Parent = NotificationGui,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -16, 1, -16),
        Size = UDim2.new(0, 300, 1, -32),
    })
    Util.Create("UIListLayout", {
        Parent = holder,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    return holder
end

function Library:Notify(opts)
    opts = opts or {}
    local title    = opts.Title or "Notification"
    local content  = opts.Content or ""
    local duration = opts.Duration or 4
    local kind     = opts.Type or "Info" -- Info / Success / Warning / Error

    local theme = self.Theme
    local accent =
        (kind == "Success" and theme.Success) or
        (kind == "Warning" and theme.Warning) or
        (kind == "Error"   and theme.Error)   or
        theme.Accent

    local holder = getNotificationHolder()

    local notif = Util.Create("Frame", {
        Parent = holder,
        BackgroundColor3 = theme.Card,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ClipsDescendants = true,
        BackgroundTransparency = 1,
    })
    Util.Corner(notif, 8)
    Util.Stroke(notif, theme.Border, 1, 0)
    Util.Padding(notif, 12, 14, 12, 14)

    local accentBar = Util.Create("Frame", {
        Parent = notif,
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundTransparency = 1,
    })
    Util.Corner(accentBar, 2)

    local titleLbl = Util.Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -10, 0, 18),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 1,
    })

    local contentLbl = Util.Create("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 20),
        Size = UDim2.new(1, -10, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = content,
        TextColor3 = theme.TextSub,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        TextTransparency = 1,
    })

    -- Slide in animation
    Util.Tween(notif, 0.3, { BackgroundTransparency = 0 })
    Util.Tween(accentBar, 0.3, { BackgroundTransparency = 0 })
    Util.Tween(titleLbl, 0.3, { TextTransparency = 0 })
    Util.Tween(contentLbl, 0.3, { TextTransparency = 0 })

    task.delay(duration, function()
        Util.Tween(notif, 0.3, { BackgroundTransparency = 1 })
        Util.Tween(accentBar, 0.3, { BackgroundTransparency = 1 })
        Util.Tween(titleLbl, 0.3, { TextTransparency = 1 })
        Util.Tween(contentLbl, 0.3, { TextTransparency = 1 })
        task.wait(0.35)
        notif:Destroy()
    end)
end

--==============================================================--
--                       CONFIG SYSTEM                          --
--==============================================================--
function Library:SaveConfig(name)
    if not (writefile and isfolder and makefolder) then return false, "Executor IO not available" end
    if not isfolder(self.ConfigFolder) then makefolder(self.ConfigFolder) end
    local data = {}
    for flag, val in pairs(self.Flags) do
        local t = typeof(val)
        if t == "boolean" or t == "number" or t == "string" then
            data[flag] = val
        elseif t == "Color3" then
            data[flag] = { _type = "Color3", R = val.R, G = val.G, B = val.B }
        elseif t == "table" then
            data[flag] = val
        end
    end
    local ok, encoded = pcall(HttpService.JSONEncode, HttpService, data)
    if ok then
        writefile(self.ConfigFolder .. "/" .. name .. ".json", encoded)
        return true
    end
    return false
end

function Library:LoadConfig(name)
    if not (readfile and isfile) then return false end
    local path = self.ConfigFolder .. "/" .. name .. ".json"
    if not isfile(path) then return false end
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(path))
    if not ok then return false end
    for flag, val in pairs(decoded) do
        if type(val) == "table" and val._type == "Color3" then
            val = Color3.new(val.R, val.G, val.B)
        end
        local f = self.Flags[flag]
        if f and f.Set then f:Set(val) end
    end
    return true
end

--==============================================================--
--                       WINDOW SYSTEM                          --
--==============================================================--
local Window = {}
Window.__index = Window

function Library:CreateWindow(opts)
    if type(opts) == "string" then opts = { Title = opts } end
    opts = opts or {}
    local title    = opts.Title    or opts.Name or "Kira Hub"
    local subtitle = opts.SubTitle  or opts.Subtitle or "v" .. Library.Version
    local size     = opts.Size     or UDim2.fromOffset(560, 380)
    local minSize  = opts.MinSize  or Vector2.new(420, 300)
    local keybind  = opts.Keybind  or Enum.KeyCode.RightShift

    local theme = self.Theme

    -- Mobile auto-scale
    if Util.IsMobile() then
        size = UDim2.fromOffset(
            math.min(size.X.Offset, workspace.CurrentCamera.ViewportSize.X - 40),
            math.min(size.Y.Offset, workspace.CurrentCamera.ViewportSize.Y - 80)
        )
    end

    --==== Root ScreenGui ====--
    local screenGui = Util.Create("ScreenGui", {
        Name = "KiraUI_" .. HttpService:GenerateGUID(false):sub(1,8),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        DisplayOrder = 100,
    })
    Util.SafeParent(screenGui)

    --==== Shadow ====--
    local shadow = Util.Create("ImageLabel", {
        Parent = screenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(0, size.X.Offset + 60, 0, size.Y.Offset + 60),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6014261993",
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = 0.45,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        SliceScale = 1,
        ZIndex = 1,
    })

    --==== Main Frame ====--
    local main = Util.Create("Frame", {
        Parent = screenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = size,
        BackgroundColor3 = theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 2,
    })
    Util.Corner(main, 10)
    Util.Stroke(main, theme.Border, 1, 0)

    -- Bind shadow to main
    main:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
        shadow.Position = UDim2.fromOffset(
            main.AbsolutePosition.X + main.AbsoluteSize.X/2,
            main.AbsolutePosition.Y + main.AbsoluteSize.Y/2
        )
    end)

    --==== Sidebar ====--
    local sidebarWidth = 140
    local sidebar = Util.Create("Frame", {
        Parent = main,
        BackgroundColor3 = theme.Sidebar,
        BorderSizePixel = 0,
        Size = UDim2.new(0, sidebarWidth, 1, 0),
    })
    Util.Create("Frame", {
        Parent = sidebar,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -1, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
    })

    --==== Sidebar Header ====--
    local header = Util.Create("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 52),
    })
    Util.Padding(header, 14, 12, 12, 14)

    local logo = Util.Create("Frame", {
        Parent = header,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 22, 0, 22),
        Position = UDim2.new(0, 0, 0.5, -11),
    })
    Util.Corner(logo, 6)
    Util.Create("TextLabel", {
        Parent = logo,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "K",
        TextColor3 = theme.AccentText,
        TextSize = 13,
    })

    Util.Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 30, 0, 4),
        Size = UDim2.new(1, -32, 0, 14),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    Util.Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 30, 0, 20),
        Size = UDim2.new(1, -32, 0, 12),
        Font = Enum.Font.Gotham,
        Text = subtitle,
        TextColor3 = theme.TextDim,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    --==== Sidebar Divider ====--
    Util.Create("Frame", {
        Parent = sidebar,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 52),
        Size = UDim2.new(1, -24, 0, 1),
    })

    --==== Tab Buttons Container ====--
    local tabScroll = Util.Create("ScrollingFrame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 60),
        Size = UDim2.new(1, 0, 1, -100),
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
    })
    Util.Padding(tabScroll, 4, 8, 4, 8)
    Util.List(tabScroll, 2)

    --==== Sidebar Footer ====--
    local footer = Util.Create("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 40),
    })
    Util.Padding(footer, 8, 12, 8, 12)

    local userIcon = Util.Create("ImageLabel", {
        Parent = footer,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0, 0, 0.5, -12),
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=48&h=48",
    })
    Util.Corner(userIcon, 12)

    Util.Create("TextLabel", {
        Parent = footer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 32, 0, 0),
        Size = UDim2.new(1, -32, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = LocalPlayer.DisplayName,
        TextColor3 = theme.TextSub,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    --==== Topbar ====--
    local topbar = Util.Create("Frame", {
        Parent = main,
        BackgroundColor3 = theme.Topbar,
        BorderSizePixel = 0,
        Position = UDim2.new(0, sidebarWidth, 0, 0),
        Size = UDim2.new(1, -sidebarWidth, 0, 40),
    })
    Util.Create("Frame", {
        Parent = topbar,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 1),
    })

    local tabTitle = Util.Create("TextLabel", {
        Parent = topbar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 0),
        Size = UDim2.new(1, -120, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "",
        TextColor3 = theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    --==== Close + Minimize ====--
    local function makeTopBtn(icon, xOffset, callback)
        local btn = Util.Create("TextButton", {
            Parent = topbar,
            BackgroundColor3 = theme.Element,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, xOffset, 0.5, 0),
            Size = UDim2.new(0, 22, 0, 22),
            Font = Enum.Font.GothamBold,
            Text = icon,
            TextColor3 = theme.TextSub,
            TextSize = 12,
            AutoButtonColor = false,
        })
        Util.Corner(btn, 5)
        btn.MouseEnter:Connect(function()
            Util.Tween(btn, 0.15, { BackgroundColor3 = theme.ElementHover, TextColor3 = theme.Text })
        end)
        btn.MouseLeave:Connect(function()
            Util.Tween(btn, 0.15, { BackgroundColor3 = theme.Element, TextColor3 = theme.TextSub })
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    local closeBtn    = makeTopBtn("×",  -10, function() screenGui:Destroy() shadow:Destroy() end)
    local minimizeBtn = makeTopBtn("–", -40, function()
        -- handled below
    end)

    --==== Content Area ====--
    local content = Util.Create("Frame", {
        Parent = main,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, sidebarWidth, 0, 40),
        Size = UDim2.new(1, -sidebarWidth, 1, -40),
    })

    --==== Make Draggable ====--
    Util.MakeDraggable(main, topbar)
    Util.MakeDraggable(main, header)

    --==== Window object ====--
    local self = setmetatable({}, Window)
    self.Library    = Library
    self.Theme      = theme
    self.ScreenGui  = screenGui
    self.Main       = main
    self.Shadow     = shadow
    self.Sidebar    = sidebar
    self.TabScroll  = tabScroll
    self.Topbar     = topbar
    self.TabTitle   = tabTitle
    self.Content    = content
    self.Tabs       = {}
    self.ActiveTab  = nil
    self.Toggled    = true
    self.Keybind    = keybind

    --==== Minimize ====--
    local originalSize = size
    local minimized = false
    local function toggle()
        minimized = not minimized
        if minimized then
            Util.Tween(main, 0.25, { Size = UDim2.new(0, originalSize.X.Offset, 0, 40) })
        else
            Util.Tween(main, 0.25, { Size = originalSize })
        end
    end
    minimizeBtn.MouseButton1Click:Connect(toggle)

    --==== Toggle UI Keybind ====--
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == self.Keybind then
            self.Toggled = not self.Toggled
            main.Visible = self.Toggled
            shadow.Visible = self.Toggled
        end
    end)

    --==== Entrance Animation ====--
    main.Size = UDim2.new(0, 0, 0, 0)
    main.BackgroundTransparency = 1
    shadow.ImageTransparency = 1
    Util.Tween(main, 0.4, { Size = size, BackgroundTransparency = 0 }, Enum.EasingStyle.Back)
    Util.Tween(shadow, 0.4, { ImageTransparency = 0.45 })

    table.insert(Library.Windows, self)
    return self
end

--==============================================================--
--                          TAB SYSTEM                          --
--==============================================================--
local Tab = {}
Tab.__index = Tab

function Window:CreateTab(opts)
    if type(opts) == "string" then opts = { Name = opts } end
    opts = opts or {}
    local name = opts.Name or opts.Title or "Tab"
    local icon = opts.Icon

    local theme = self.Theme

    --==== Tab Button ====--
    local tabBtn = Util.Create("TextButton", {
        Parent = self.TabScroll,
        BackgroundColor3 = theme.Element,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -8, 0, 30),
        Font = Enum.Font.GothamMedium,
        Text = "",
        AutoButtonColor = false,
    })
    Util.Corner(tabBtn, 6)
    Util.Padding(tabBtn, 0, 10, 0, 10)

    local tabLabel = Util.Create("TextLabel", {
        Parent = tabBtn,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.TextSub,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    --==== Tab Page ====--
    local page = Util.Create("ScrollingFrame", {
        Parent = self.Content,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.BorderLight,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Visible = false,
    })
    Util.Padding(page, 16, 16, 16, 16)
    Util.List(page, 10)

    local tab = setmetatable({}, Tab)
    tab.Window  = self
    tab.Theme   = theme
    tab.Button  = tabBtn
    tab.Label   = tabLabel
    tab.Page    = page
    tab.Name    = name

    --==== Selection logic ====--
    local function select()
        for _, t in ipairs(self.Tabs) do
            t.Page.Visible = false
            Util.Tween(t.Button, 0.15, { BackgroundTransparency = 1 })
            Util.Tween(t.Label, 0.15, { TextColor3 = theme.TextSub })
        end
        page.Visible = true
        Util.Tween(tabBtn, 0.2, { BackgroundTransparency = 0, BackgroundColor3 = theme.Element })
        Util.Tween(tabLabel, 0.2, { TextColor3 = theme.Text })
        self.TabTitle.Text = name
        self.ActiveTab = tab
    end
    tab.Select = select

    tabBtn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tab then
            Util.Tween(tabLabel, 0.15, { TextColor3 = theme.Text })
        end
    end)
    tabBtn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tab then
            Util.Tween(tabLabel, 0.15, { TextColor3 = theme.TextSub })
        end
    end)
    tabBtn.MouseButton1Click:Connect(select)

    table.insert(self.Tabs, tab)
    if #self.Tabs == 1 then select() end

    return tab
end

--==============================================================--
--                       COMPONENT BASE                         --
--==============================================================--
local function registerFlag(flag, set, get)
    if flag then
        Library.Flags[flag] = { Set = set, Get = get }
    end
end

local function makeElementBase(parent, theme, height)
    local frame = Util.Create("Frame", {
        Parent = parent,
        BackgroundColor3 = theme.Card,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height or 38),
    })
    Util.Corner(frame, 6)
    Util.Stroke(frame, theme.Border, 1, 0)
    Util.Padding(frame, 0, 12, 0, 12)
    return frame
end

--==============================================================--
--                          SECTION                             --
--==============================================================--
-- Section returns an object that inherits all Tab component methods
-- but parents new components into the section's own card.
-- Supports: Section:Button(), Section:Toggle(), Section:Slider(), etc.
function Tab:Section(name)
    local theme = self.Theme

    -- Section card (premium look)
    local card = Util.Create("Frame", {
        Parent  = self.Page,
        BackgroundColor3 = theme.Card,
        BorderSizePixel  = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    Util.Corner(card, 8)
    Util.Stroke(card, theme.Border, 1, 0)
    Util.Padding(card, 12, 14, 12, 14)
    Util.List(card, 8)

    -- Section title
    Util.Create("TextLabel", {
        Parent  = card,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = name or "Section",
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = -1000,
    })

    -- Section inherits Tab methods (Button, Toggle, ...) but uses
    -- its own card as the parent surface for child elements.
    local section = setmetatable({}, Tab)
    section.Window    = self.Window
    section.Theme     = self.Theme
    section.Page      = card
    section.IsSection = true
    section.Parent    = self
    section.Card      = card
    return section
end

-- Alias for users who prefer Rayfield/Fluent style API
Tab.CreateSection = Tab.Section

--==============================================================--
--                          DIVIDER                             --
--==============================================================--
function Tab:Divider()
    local theme = self.Theme
    local d = Util.Create("Frame", {
        Parent = self.Page,
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
    })
    return d
end

--==============================================================--
--                           LABEL                              --
--==============================================================--
function Tab:Label(text)
    local theme = self.Theme
    local lbl = Util.Create("TextLabel", {
        Parent = self.Page,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Font = Enum.Font.GothamMedium,
        Text = text or "Label",
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    return {
        Set = function(_, v) lbl.Text = v end,
        Instance = lbl,
    }
end

--==============================================================--
--                         PARAGRAPH                            --
--==============================================================--
function Tab:Paragraph(title, content)
    local theme = self.Theme
    local frame = Util.Create("Frame", {
        Parent = self.Page,
        BackgroundColor3 = theme.Card,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    Util.Corner(frame, 6)
    Util.Stroke(frame, theme.Border, 1, 0)
    Util.Padding(frame, 10, 12, 10, 12)

    local titleLbl = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = title or "Paragraph",
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local contentLbl = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 18),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = content or "",
        TextColor3 = theme.TextSub,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    return {
        SetTitle   = function(_, v) titleLbl.Text = v end,
        SetContent = function(_, v) contentLbl.Text = v end,
        Instance   = frame,
    }
end

--==============================================================--
--                           BUTTON                             --
--==============================================================--
function Tab:Button(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Callback = callback } end
    opts = opts or {}
    local name  = opts.Name or opts.Title or "Button"
    local desc  = opts.Description or opts.Desc
    local cb    = opts.Callback or function() end
    local theme = self.Theme

    local height = desc and 50 or 38
    local frame = makeElementBase(self.Page, theme, height)
    frame.ClipsDescendants = true

    local titleLbl = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, desc and 0 or 0, desc and 6 or 0),
        Size = UDim2.new(1, -20, 0, desc and 16 or 38),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = desc and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
    })

    local descLbl
    if desc then
        descLbl = Util.Create("TextLabel", {
            Parent = frame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 24),
            Size = UDim2.new(1, -20, 0, 14),
            Font = Enum.Font.Gotham,
            Text = desc,
            TextColor3 = theme.TextDim,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end

    local arrow = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = "›",
        TextColor3 = theme.TextDim,
        TextSize = 16,
    })

    local btn = Util.Create("TextButton", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        AutoButtonColor = false,
    })

    btn.MouseEnter:Connect(function()
        Util.Tween(frame, 0.15, { BackgroundColor3 = theme.CardHover })
        Util.Tween(arrow, 0.15, { TextColor3 = theme.Text })
    end)
    btn.MouseLeave:Connect(function()
        Util.Tween(frame, 0.15, { BackgroundColor3 = theme.Card })
        Util.Tween(arrow, 0.15, { TextColor3 = theme.TextDim })
    end)
    btn.MouseButton1Click:Connect(function()
        Util.Ripple(frame, Mouse.X, Mouse.Y)
        task.spawn(cb)
    end)

    return {
        SetName        = function(_, v) titleLbl.Text = v end,
        SetTitle       = function(_, v) titleLbl.Text = v end,
        SetDescription = function(_, v) if descLbl then descLbl.Text = v end end,
        Fire           = function(_) task.spawn(cb) end,
        Instance       = frame,
    }
end

--==============================================================--
--                           TOGGLE                             --
--==============================================================--
function Tab:Toggle(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Default = false, Callback = callback } end
    opts = opts or {}
    local name    = opts.Name or opts.Title or "Toggle"
    local desc    = opts.Description or opts.Desc
    local default = opts.Default or false
    local flag    = opts.Flag
    local cb      = opts.Callback or function() end
    local theme   = self.Theme

    local height = desc and 50 or 38
    local frame = makeElementBase(self.Page, theme, height)

    local label = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, desc and 6 or 0),
        Size = UDim2.new(1, -50, 0, desc and 16 or 38),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = desc and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
    })

    if desc then
        Util.Create("TextLabel", {
            Parent = frame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 24),
            Size = UDim2.new(1, -50, 0, 14),
            Font = Enum.Font.Gotham,
            Text = desc,
            TextColor3 = theme.TextDim,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end

    local switch = Util.Create("Frame", {
        Parent = frame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 34, 0, 18),
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
    })
    Util.Corner(switch, 9)
    Util.Stroke(switch, theme.BorderLight, 1, 0)

    local knob = Util.Create("Frame", {
        Parent = switch,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.new(0, 14, 0, 14),
        BackgroundColor3 = theme.TextSub,
        BorderSizePixel = 0,
    })
    Util.Corner(knob, 7)

    local btn = Util.Create("TextButton", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        AutoButtonColor = false,
    })

    local state = default
    local function update(animated)
        local t = animated == false and 0 or 0.2
        if state then
            Util.Tween(switch, t, { BackgroundColor3 = theme.Accent })
            Util.Tween(knob,   t, { Position = UDim2.new(0, 18, 0.5, 0), BackgroundColor3 = theme.AccentText })
        else
            Util.Tween(switch, t, { BackgroundColor3 = theme.Element })
            Util.Tween(knob,   t, { Position = UDim2.new(0, 2, 0.5, 0), BackgroundColor3 = theme.TextSub })
        end
    end
    update(false)

    btn.MouseButton1Click:Connect(function()
        state = not state
        update(true)
        task.spawn(cb, state)
    end)
    btn.MouseEnter:Connect(function()
        Util.Tween(frame, 0.15, { BackgroundColor3 = theme.CardHover })
    end)
    btn.MouseLeave:Connect(function()
        Util.Tween(frame, 0.15, { BackgroundColor3 = theme.Card })
    end)

    local api = {
        Set = function(_, v)
            state = v and true or false
            update(true)
            task.spawn(cb, state)
        end,
        Get = function(_) return state end,
        Instance = frame,
    }
    registerFlag(flag, function(_, v) api:Set(v) end, function() return state end)
    return api
end

--==============================================================--
--                           SLIDER                             --
--==============================================================--
function Tab:Slider(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Callback = callback } end
    opts = opts or {}
    local name     = opts.Name or opts.Title or "Slider"
    local min      = opts.Min or 0
    local max      = opts.Max or 100
    local default  = math.clamp(opts.Default or min, min, max)
    local suffix   = opts.Suffix or ""
    local decimals = opts.Decimals or 0
    local flag     = opts.Flag
    local cb       = opts.Callback or function() end
    local theme    = self.Theme

    local frame = makeElementBase(self.Page, theme, 50)
    Util.Padding(frame, 8, 12, 8, 12)

    local label = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -60, 0, 16),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local valueLbl = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 60, 0, 16),
        Font = Enum.Font.GothamMedium,
        Text = tostring(default) .. suffix,
        TextColor3 = theme.Accent,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
    })

    local track = Util.Create("Frame", {
        Parent = frame,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 4),
    })
    Util.Corner(track, 2)

    local fill = Util.Create("Frame", {
        Parent = track,
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
    })
    Util.Corner(fill, 2)

    local knob = Util.Create("Frame", {
        Parent = track,
        BackgroundColor3 = theme.AccentText,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
    })
    Util.Corner(knob, 6)
    Util.Stroke(knob, theme.Accent, 2, 0)

    local value = default
    local dragging = false

    local function setValue(v, fire)
        v = math.clamp(v, min, max)
        local mult = 10 ^ decimals
        v = math.floor(v * mult + 0.5) / mult
        value = v
        local alpha = (v - min) / (max - min)
        Util.Tween(fill, 0.1, { Size = UDim2.new(alpha, 0, 1, 0) })
        Util.Tween(knob, 0.1, { Position = UDim2.new(alpha, 0, 0.5, 0) })
        valueLbl.Text = tostring(v) .. suffix
        if fire ~= false then task.spawn(cb, v) end
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement or
            input.UserInputType == Enum.UserInputType.Touch
        ) then
            local relX = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            relX = math.clamp(relX, 0, 1)
            setValue(min + (max - min) * relX, true)
        end
    end)

    local api = {
        Set = function(_, v) setValue(v, true) end,
        Get = function(_) return value end,
        Instance = frame,
    }
    registerFlag(flag, function(_, v) setValue(v, true) end, function() return value end)
    return api
end

--==============================================================--
--                          DROPDOWN                            --
--==============================================================--
function Tab:Dropdown(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Callback = callback } end
    opts = opts or {}
    local name    = opts.Name or opts.Title or "Dropdown"
    local list    = opts.Options or {}
    local default = opts.Default
    local flag    = opts.Flag
    local cb      = opts.Callback or function() end
    local theme   = self.Theme

    local frame = makeElementBase(self.Page, theme, 38)

    local label = Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local valueBox = Util.Create("TextButton", {
        Parent = frame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 120, 0, 24),
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamMedium,
        Text = "",
        AutoButtonColor = false,
    })
    Util.Corner(valueBox, 5)
    Util.Stroke(valueBox, theme.BorderLight, 1, 0)
    Util.Padding(valueBox, 0, 8, 0, 8)

    local valueLbl = Util.Create("TextLabel", {
        Parent = valueBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 1, 0),
        Font = Enum.Font.Gotham,
        Text = default or "Select...",
        TextColor3 = default and theme.Text or theme.TextDim,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local chevron = Util.Create("TextLabel", {
        Parent = valueBox,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
        Font = Enum.Font.GothamBold,
        Text = "▾",
        TextColor3 = theme.TextSub,
        TextSize = 10,
    })

    local optionsHolder = Util.Create("Frame", {
        Parent = frame,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 1, 4),
        Size = UDim2.new(0, 120, 0, 0),
        Visible = false,
        ZIndex = 5,
        ClipsDescendants = true,
    })
    Util.Corner(optionsHolder, 5)
    Util.Stroke(optionsHolder, theme.BorderLight, 1, 0)

    local optionsScroll = Util.Create("ScrollingFrame", {
        Parent = optionsHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = theme.BorderLight,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 5,
    })
    Util.Padding(optionsScroll, 4, 4, 4, 4)
    Util.List(optionsScroll, 2)

    local selected = default
    local open = false

    local function refresh()
        for _, c in ipairs(optionsScroll:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        for _, opt in ipairs(list) do
            local optBtn = Util.Create("TextButton", {
                Parent = optionsScroll,
                BackgroundColor3 = theme.Card,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 24),
                Font = Enum.Font.Gotham,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 6,
            })
            Util.Corner(optBtn, 4)
            Util.Padding(optBtn, 0, 8, 0, 8)
            Util.Create("TextLabel", {
                Parent = optBtn,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = opt,
                TextColor3 = opt == selected and theme.Accent or theme.TextSub,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 6,
            })
            optBtn.MouseEnter:Connect(function()
                Util.Tween(optBtn, 0.1, { BackgroundTransparency = 0, BackgroundColor3 = theme.ElementHover })
            end)
            optBtn.MouseLeave:Connect(function()
                Util.Tween(optBtn, 0.1, { BackgroundTransparency = 1 })
            end)
            optBtn.MouseButton1Click:Connect(function()
                selected = opt
                valueLbl.Text = opt
                valueLbl.TextColor3 = theme.Text
                open = false
                Util.Tween(optionsHolder, 0.2, { Size = UDim2.new(0, 120, 0, 0) })
                task.delay(0.2, function() optionsHolder.Visible = false end)
                Util.Tween(chevron, 0.2, { Rotation = 0 })
                task.spawn(cb, opt)
            end)
        end
    end
    refresh()

    valueBox.MouseButton1Click:Connect(function()
        open = not open
        if open then
            optionsHolder.Visible = true
            local h = math.min(#list * 26 + 8, 120)
            Util.Tween(optionsHolder, 0.2, { Size = UDim2.new(0, 120, 0, h) })
            Util.Tween(chevron, 0.2, { Rotation = 180 })
        else
            Util.Tween(optionsHolder, 0.2, { Size = UDim2.new(0, 120, 0, 0) })
            task.delay(0.2, function() optionsHolder.Visible = false end)
            Util.Tween(chevron, 0.2, { Rotation = 0 })
        end
    end)

    local api = {
        Set = function(_, v)
            selected = v
            valueLbl.Text = v or "Select..."
            valueLbl.TextColor3 = v and theme.Text or theme.TextDim
            task.spawn(cb, v)
        end,
        Get = function(_) return selected end,
        Refresh = function(_, newList, keep)
            list = newList
            if not keep then selected = nil; valueLbl.Text = "Select..."; valueLbl.TextColor3 = theme.TextDim end
            refresh()
        end,
        Instance = frame,
    }
    registerFlag(flag, function(_, v) api:Set(v) end, function() return selected end)
    return api
end

--==============================================================--
--                       MULTI DROPDOWN                         --
--==============================================================--
function Tab:MultiDropdown(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Callback = callback } end
    opts = opts or {}
    local name    = opts.Name or opts.Title or "Multi Dropdown"
    local list    = opts.Options or {}
    local default = opts.Default or {}
    local flag    = opts.Flag
    local cb      = opts.Callback or function() end
    local theme   = self.Theme

    local selectedSet = {}
    for _, v in ipairs(default) do selectedSet[v] = true end

    local frame = makeElementBase(self.Page, theme, 38)

    Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local valueBox = Util.Create("TextButton", {
        Parent = frame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 120, 0, 24),
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    })
    Util.Corner(valueBox, 5)
    Util.Stroke(valueBox, theme.BorderLight, 1, 0)
    Util.Padding(valueBox, 0, 8, 0, 8)

    local valueLbl = Util.Create("TextLabel", {
        Parent = valueBox,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 1, 0),
        Font = Enum.Font.Gotham,
        Text = "Select...",
        TextColor3 = theme.TextDim,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local chevron = Util.Create("TextLabel", {
        Parent = valueBox,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
        Font = Enum.Font.GothamBold,
        Text = "▾",
        TextColor3 = theme.TextSub,
        TextSize = 10,
    })

    local optionsHolder = Util.Create("Frame", {
        Parent = frame,
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 1, 4),
        Size = UDim2.new(0, 120, 0, 0),
        Visible = false,
        ZIndex = 5,
        ClipsDescendants = true,
    })
    Util.Corner(optionsHolder, 5)
    Util.Stroke(optionsHolder, theme.BorderLight, 1, 0)

    local optionsScroll = Util.Create("ScrollingFrame", {
        Parent = optionsHolder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = theme.BorderLight,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 5,
    })
    Util.Padding(optionsScroll, 4, 4, 4, 4)
    Util.List(optionsScroll, 2)

    local open = false
    local function updateLabel()
        local count = 0
        for _ in pairs(selectedSet) do count = count + 1 end
        if count == 0 then
            valueLbl.Text = "Select..."
            valueLbl.TextColor3 = theme.TextDim
        else
            valueLbl.Text = count .. " selected"
            valueLbl.TextColor3 = theme.Text
        end
    end

    local optionBtns = {}
    local function refresh()
        for _, c in ipairs(optionsScroll:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        optionBtns = {}
        for _, opt in ipairs(list) do
            local optBtn = Util.Create("TextButton", {
                Parent = optionsScroll,
                BackgroundColor3 = theme.Card,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 24),
                Text = "",
                AutoButtonColor = false,
                ZIndex = 6,
            })
            Util.Corner(optBtn, 4)
            Util.Padding(optBtn, 0, 8, 0, 8)
            local lbl = Util.Create("TextLabel", {
                Parent = optBtn,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Font = Enum.Font.Gotham,
                Text = opt,
                TextColor3 = selectedSet[opt] and theme.Accent or theme.TextSub,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 6,
            })
            optionBtns[opt] = lbl
            optBtn.MouseEnter:Connect(function()
                Util.Tween(optBtn, 0.1, { BackgroundTransparency = 0, BackgroundColor3 = theme.ElementHover })
            end)
            optBtn.MouseLeave:Connect(function()
                Util.Tween(optBtn, 0.1, { BackgroundTransparency = 1 })
            end)
            optBtn.MouseButton1Click:Connect(function()
                selectedSet[opt] = not selectedSet[opt] or nil
                lbl.TextColor3 = selectedSet[opt] and theme.Accent or theme.TextSub
                updateLabel()
                local arr = {}
                for k in pairs(selectedSet) do table.insert(arr, k) end
                task.spawn(cb, arr)
            end)
        end
    end
    refresh()
    updateLabel()

    valueBox.MouseButton1Click:Connect(function()
        open = not open
        if open then
            optionsHolder.Visible = true
            local h = math.min(#list * 26 + 8, 140)
            Util.Tween(optionsHolder, 0.2, { Size = UDim2.new(0, 120, 0, h) })
            Util.Tween(chevron, 0.2, { Rotation = 180 })
        else
            Util.Tween(optionsHolder, 0.2, { Size = UDim2.new(0, 120, 0, 0) })
            task.delay(0.2, function() optionsHolder.Visible = false end)
            Util.Tween(chevron, 0.2, { Rotation = 0 })
        end
    end)

    local api = {
        Set = function(_, arr)
            selectedSet = {}
            for _, v in ipairs(arr) do selectedSet[v] = true end
            refresh()
            updateLabel()
        end,
        Get = function(_)
            local arr = {}
            for k in pairs(selectedSet) do table.insert(arr, k) end
            return arr
        end,
        Instance = frame,
    }
    registerFlag(flag, function(_, v) api:Set(v) end, function() return api:Get() end)
    return api
end

--==============================================================--
--                          TEXTBOX                             --
--==============================================================--
function Tab:Textbox(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Callback = callback } end
    opts = opts or {}
    local name        = opts.Name or opts.Title or "Textbox"
    local placeholder = opts.Placeholder or "Enter text..."
    local default     = opts.Default or ""
    local clearOnFocus = opts.ClearOnFocus
    if clearOnFocus == nil then clearOnFocus = false end
    local flag        = opts.Flag
    local cb          = opts.Callback or function() end
    local theme       = self.Theme

    local frame = makeElementBase(self.Page, theme, 38)

    Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local boxHolder = Util.Create("Frame", {
        Parent = frame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 140, 0, 24),
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
    })
    Util.Corner(boxHolder, 5)
    local stroke = Util.Stroke(boxHolder, theme.BorderLight, 1, 0)
    Util.Padding(boxHolder, 0, 8, 0, 8)

    local box = Util.Create("TextBox", {
        Parent = boxHolder,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = default,
        PlaceholderText = placeholder,
        PlaceholderColor3 = theme.TextDim,
        TextColor3 = theme.Text,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = clearOnFocus,
    })

    box.Focused:Connect(function()
        Util.Tween(stroke, 0.15, { Color = theme.Accent })
    end)
    box.FocusLost:Connect(function(enter)
        Util.Tween(stroke, 0.15, { Color = theme.BorderLight })
        task.spawn(cb, box.Text, enter)
    end)

    local api = {
        Set = function(_, v) box.Text = tostring(v); task.spawn(cb, box.Text, false) end,
        Get = function(_) return box.Text end,
        Instance = frame,
    }
    registerFlag(flag, function(_, v) api:Set(v) end, function() return box.Text end)
    return api
end

--==============================================================--
--                           KEYBIND                            --
--==============================================================--
function Tab:Keybind(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Callback = callback } end
    opts = opts or {}
    local name    = opts.Name or opts.Title or "Keybind"
    local default = opts.Default or Enum.KeyCode.E
    local flag    = opts.Flag
    local cb      = opts.Callback or function() end
    local theme   = self.Theme

    local frame = makeElementBase(self.Page, theme, 38)

    Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -90, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local keyBtn = Util.Create("TextButton", {
        Parent = frame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 70, 0, 22),
        BackgroundColor3 = theme.Element,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = default.Name,
        TextColor3 = theme.Text,
        TextSize = 11,
        AutoButtonColor = false,
    })
    Util.Corner(keyBtn, 5)
    Util.Stroke(keyBtn, theme.BorderLight, 1, 0)

    local current = default
    local listening = false

    keyBtn.MouseButton1Click:Connect(function()
        listening = true
        keyBtn.Text = "..."
        keyBtn.TextColor3 = theme.Accent
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            current = input.KeyCode
            keyBtn.Text = current.Name
            keyBtn.TextColor3 = theme.Text
            listening = false
        elseif not listening and not gpe and input.KeyCode == current then
            task.spawn(cb, current)
        end
    end)

    local api = {
        Set = function(_, key)
            current = key
            keyBtn.Text = key.Name
        end,
        Get = function(_) return current end,
        Instance = frame,
    }
    registerFlag(flag, function(_, v) api:Set(v) end, function() return current end)
    return api
end

--==============================================================--
--                        COLOR PICKER                          --
--==============================================================--
function Tab:ColorPicker(opts, callback)
    if type(opts) == "string" then opts = { Name = opts, Callback = callback } end
    opts = opts or {}
    local name    = opts.Name or opts.Title or "Color"
    local default = opts.Default or Color3.fromRGB(139, 92, 246)
    local flag    = opts.Flag
    local cb      = opts.Callback or function() end
    local theme   = self.Theme

    local frame = makeElementBase(self.Page, theme, 38)

    Util.Create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -40, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextColor3 = theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local colorBtn = Util.Create("TextButton", {
        Parent = frame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 28, 0, 20),
        BackgroundColor3 = default,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    })
    Util.Corner(colorBtn, 5)
    Util.Stroke(colorBtn, theme.BorderLight, 1, 0)

    -- Picker panel
    local panel = Util.Create("Frame", {
        Parent = frame,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 1, 4),
        Size = UDim2.new(0, 180, 0, 0),
        BackgroundColor3 = theme.Card,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 10,
        ClipsDescendants = true,
    })
    Util.Corner(panel, 6)
    Util.Stroke(panel, theme.Border, 1, 0)
    Util.Padding(panel, 10, 10, 10, 10)

    local hue, sat, val = 0, 1, 1
    local r,g,b = default.R, default.G, default.B
    do
        local h,s,v = Color3.toHSV(default)
        hue, sat, val = h, s, v
    end

    local satMap = Util.Create("ImageLabel", {
        Parent = panel,
        BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 100),
        Image = "rbxassetid://4155801252",
        ZIndex = 11,
    })
    Util.Corner(satMap, 4)

    local satCursor = Util.Create("Frame", {
        Parent = satMap,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(sat, 0, 1 - val, 0),
        Size = UDim2.new(0, 8, 0, 8),
        BackgroundColor3 = Color3.new(1,1,1),
        BorderSizePixel = 0,
        ZIndex = 12,
    })
    Util.Corner(satCursor, 4)
    Util.Stroke(satCursor, Color3.new(0,0,0), 1, 0)

    local hueBar = Util.Create("ImageLabel", {
        Parent = panel,
        Position = UDim2.new(0, 0, 0, 108),
        Size = UDim2.new(1, 0, 0, 12),
        BorderSizePixel = 0,
        Image = "rbxassetid://3641079629",
        BackgroundColor3 = Color3.new(1,1,1),
        ZIndex = 11,
    })
    Util.Corner(hueBar, 4)

    local hueCursor = Util.Create("Frame", {
        Parent = hueBar,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(hue, 0, 0.5, 0),
        Size = UDim2.new(0, 4, 1, 4),
        BackgroundColor3 = Color3.new(1,1,1),
        BorderSizePixel = 0,
        ZIndex = 12,
    })
    Util.Corner(hueCursor, 2)
    Util.Stroke(hueCursor, Color3.new(0,0,0), 1, 0)

    local hexLbl = Util.Create("TextLabel", {
        Parent = panel,
        Position = UDim2.new(0, 0, 0, 128),
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Text = "",
        TextColor3 = theme.TextSub,
        TextSize = 11,
        ZIndex = 11,
    })

    local function updateColor(fire)
        local c = Color3.fromHSV(hue, sat, val)
        colorBtn.BackgroundColor3 = c
        satMap.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        satCursor.Position = UDim2.new(sat, 0, 1 - val, 0)
        hueCursor.Position = UDim2.new(hue, 0, 0.5, 0)
        hexLbl.Text = string.format("#%02X%02X%02X",
            math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
        if fire ~= false then task.spawn(cb, c) end
    end
    updateColor(false)

    local open = false
    colorBtn.MouseButton1Click:Connect(function()
        open = not open
        if open then
            panel.Visible = true
            Util.Tween(panel, 0.2, { Size = UDim2.new(0, 180, 0, 154) })
        else
            Util.Tween(panel, 0.2, { Size = UDim2.new(0, 180, 0, 0) })
            task.delay(0.2, function() panel.Visible = false end)
        end
    end)

    -- Saturation drag
    local satDragging, hueDragging = false, false
    satMap.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then satDragging = true end
    end)
    hueBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then hueDragging = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            satDragging = false; hueDragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if i.UserInputType ~= Enum.UserInputType.MouseMovement
        and i.UserInputType ~= Enum.UserInputType.Touch then return end
        if satDragging then
            local x = math.clamp((i.Position.X - satMap.AbsolutePosition.X) / satMap.AbsoluteSize.X, 0, 1)
            local y = math.clamp((i.Position.Y - satMap.AbsolutePosition.Y) / satMap.AbsoluteSize.Y, 0, 1)
            sat, val = x, 1 - y
            updateColor(true)
        elseif hueDragging then
            local x = math.clamp((i.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
            hue = x
            updateColor(true)
        end
    end)

    local api = {
        Set = function(_, c)
            local h,s,v = Color3.toHSV(c)
            hue,sat,val = h,s,v
            updateColor(true)
        end,
        Get = function(_) return Color3.fromHSV(hue,sat,val) end,
        Instance = frame,
    }
    registerFlag(flag, function(_, v) api:Set(v) end, function() return api:Get() end)
    return api
end

--==============================================================--
--                       EXAMPLE USAGE                          --
--==============================================================--
--[[
local Library = Library.new("Dark")

local Window = Library:CreateWindow({
    Title = "Kira Hub",
    Subtitle = "Premium UI",
    Size = UDim2.fromOffset(580, 400),
    Keybind = Enum.KeyCode.RightShift,
})

local Main = Window:CreateTab({ Name = "Main" })
local Settings = Window:CreateTab({ Name = "Settings" })

Main:Section("Combat")
Main:Toggle({ Name = "Auto Farm", Default = false, Flag = "autofarm",
    Callback = function(v) print("AutoFarm:", v) end })
Main:Slider({ Name = "Walk Speed", Min = 16, Max = 200, Default = 16, Suffix = "",
    Flag = "walkspeed",
    Callback = function(v) LocalPlayer.Character.Humanoid.WalkSpeed = v end })
Main:Dropdown({ Name = "Target", Options = {"All","Closest","Random"}, Default = "All",
    Callback = function(v) print("Target:", v) end })
Main:MultiDropdown({ Name = "Toggles", Options = {"ESP","Aimbot","Tracers"}, Default = {"ESP"},
    Callback = function(t) print("Multi:", table.concat(t, ", ")) end })

Main:Section("Misc")
Main:Button({ Name = "Rejoin Server", Callback = function()
    Library:Notify({ Title = "Rejoin", Content = "Rejoining...", Type = "Info", Duration = 3 })
end })
Main:Keybind({ Name = "Toggle ESP", Default = Enum.KeyCode.E,
    Callback = function() print("ESP toggled") end })
Main:ColorPicker({ Name = "ESP Color", Default = Color3.fromRGB(139, 92, 246),
    Callback = function(c) print("Color:", c) end })

Settings:Section("Profile")
Settings:Textbox({ Name = "Username", Placeholder = "Enter name", Default = "",
    Callback = function(t, enter) print("Username:", t) end })
Settings:Paragraph("Info", "This is a premium UI library with full mobile support.")

Settings:Section("Config")
Settings:Button({ Name = "Save Config", Callback = function()
    if Library:SaveConfig("default") then
        Library:Notify({ Title = "Saved", Content = "Config saved!", Type = "Success" })
    end
end })
Settings:Button({ Name = "Load Config", Callback = function()
    if Library:LoadConfig("default") then
        Library:Notify({ Title = "Loaded", Content = "Config loaded!", Type = "Success" })
    end
end })
]]

return Library
