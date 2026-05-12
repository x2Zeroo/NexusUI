--[[
    KimiUI Library
    A modern, elegant Roblox UI Library with comprehensive features
    
    Features:
    - Beautiful theming system with 10+ built-in themes
    - Smooth animations using TweenService
    - Window system with shadow effects
    - Tab system with icons and sections
    - Rich set of elements: Button, Toggle, Slider, Input, Dropdown, etc.
    - Notification system
    - Dialog/Popup system
    - Color picker with RGB/HSV support
    - Keybind system
    - Code display with syntax highlighting
    - Advanced elements
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

--// Utility Functions
local Utility = {}

function Utility:Tween(instance, properties, duration, easingStyle, easingDirection, callback)
    easingStyle = easingStyle or Enum.EasingStyle.Quart
    easingDirection = easingDirection or Enum.EasingDirection.Out
    duration = duration or 0.4
    
    local tween = TweenService:Create(instance, TweenInfo.new(duration, easingStyle, easingDirection), properties)
    tween:Play()
    
    if callback then
        tween.Completed:Connect(callback)
    end
    
    return tween
end

function Utility:Create(className, properties, children)
    local instance = Instance.new(className)
    
    for property, value in pairs(properties or {}) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
    
    if children then
        for _, child in pairs(children) do
            child.Parent = instance
        end
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

function Utility:Map(value, inMin, inMax, outMin, outMax)
    return outMin + (outMax - outMin) * ((value - inMin) / (inMax - inMin))
end

function Utility:CreateCorner(parent, radius)
    return Utility:Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 6),
        Parent = parent
    })
end

function Utility:CreateStroke(parent, color, thickness, transparency)
    return Utility:Create("UIStroke", {
        Color = color or Color3.fromRGB(60, 60, 60),
        Thickness = thickness or 1,
        Transparency = transparency or 0.8,
        Parent = parent
    })
end

function Utility:CreatePadding(parent, padding)
    padding = padding or 10
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
        Padding = UDim.new(0, padding or 5),
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
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Utility:CreateShadow(parent, transparency)
    local shadow = Utility:Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 3),
        Size = UDim2.new(1, 30, 1, 30),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = transparency or 0.6,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        Parent = parent
    })
    return shadow
end

function Utility:CreateRipple(button, color)
    button.ClipsDescendants = true
    
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local ripple = Utility:Create("Frame", {
                Name = "Ripple",
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = color or Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.8,
                Position = UDim2.new(0, input.Position.X - button.AbsolutePosition.X, 0, input.Position.Y - button.AbsolutePosition.Y),
                Size = UDim2.new(0, 0, 0, 0),
                Parent = button
            })
            Utility:CreateCorner(ripple, 100)
            
            local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.5
            Utility:Tween(ripple, {
                Size = UDim2.new(0, maxSize, 0, maxSize),
                BackgroundTransparency = 1
            }, 0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function()
                ripple:Destroy()
            end)
        end
    end)
end

--// Themes
local Themes = {
    Default = {
        Primary = Color3.fromRGB(30, 30, 35),
        Secondary = Color3.fromRGB(35, 35, 42),
        Accent = Color3.fromRGB(100, 120, 255),
        AccentLight = Color3.fromRGB(120, 140, 255),
        Background = Color3.fromRGB(25, 25, 30),
        Foreground = Color3.fromRGB(45, 45, 52),
        Text = Color3.fromRGB(230, 230, 235),
        TextDark = Color3.fromRGB(150, 150, 160),
        Border = Color3.fromRGB(55, 55, 65),
        Success = Color3.fromRGB(80, 200, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Error = Color3.fromRGB(255, 90, 90),
        Info = Color3.fromRGB(80, 160, 255)
    },
    Dark = {
        Primary = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(28, 28, 35),
        Accent = Color3.fromRGB(120, 120, 130),
        AccentLight = Color3.fromRGB(140, 140, 150),
        Background = Color3.fromRGB(15, 15, 20),
        Foreground = Color3.fromRGB(35, 35, 42),
        Text = Color3.fromRGB(220, 220, 225),
        TextDark = Color3.fromRGB(140, 140, 150),
        Border = Color3.fromRGB(50, 50, 60),
        Success = Color3.fromRGB(70, 180, 100),
        Warning = Color3.fromRGB(230, 160, 50),
        Error = Color3.fromRGB(230, 80, 80),
        Info = Color3.fromRGB(70, 140, 230)
    },
    Midnight = {
        Primary = Color3.fromRGB(25, 28, 45),
        Secondary = Color3.fromRGB(32, 36, 55),
        Accent = Color3.fromRGB(100, 130, 255),
        AccentLight = Color3.fromRGB(120, 150, 255),
        Background = Color3.fromRGB(20, 23, 38),
        Foreground = Color3.fromRGB(38, 42, 62),
        Text = Color3.fromRGB(225, 228, 240),
        TextDark = Color3.fromRGB(150, 155, 175),
        Border = Color3.fromRGB(55, 60, 85),
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
        Background = Color3.fromRGB(15, 28, 42),
        Foreground = Color3.fromRGB(32, 52, 72),
        Text = Color3.fromRGB(220, 235, 245),
        TextDark = Color3.fromRGB(140, 160, 180),
        Border = Color3.fromRGB(45, 65, 90),
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
        Background = Color3.fromRGB(18, 32, 24),
        Foreground = Color3.fromRGB(35, 55, 40),
        Text = Color3.fromRGB(225, 240, 230),
        TextDark = Color3.fromRGB(150, 170, 155),
        Border = Color3.fromRGB(50, 70, 55),
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
        Background = Color3.fromRGB(35, 22, 28),
        Foreground = Color3.fromRGB(55, 38, 48),
        Text = Color3.fromRGB(245, 230, 230),
        TextDark = Color3.fromRGB(180, 155, 155),
        Border = Color3.fromRGB(75, 55, 62),
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
        Background = Color3.fromRGB(35, 22, 32),
        Foreground = Color3.fromRGB(55, 38, 52),
        Text = Color3.fromRGB(245, 228, 235),
        TextDark = Color3.fromRGB(180, 155, 170),
        Border = Color3.fromRGB(72, 52, 68),
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
        Background = Color3.fromRGB(10, 10, 22),
        Foreground = Color3.fromRGB(28, 28, 48),
        Text = Color3.fromRGB(220, 255, 245),
        TextDark = Color3.fromRGB(140, 170, 165),
        Border = Color3.fromRGB(40, 45, 75),
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
        Background = Color3.fromRGB(28, 18, 42),
        Foreground = Color3.fromRGB(48, 35, 68),
        Text = Color3.fromRGB(235, 225, 245),
        TextDark = Color3.fromRGB(165, 145, 185),
        Border = Color3.fromRGB(62, 48, 85),
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
        Background = Color3.fromRGB(22, 22, 22),
        Foreground = Color3.fromRGB(48, 48, 48),
        Text = Color3.fromRGB(235, 235, 235),
        TextDark = Color3.fromRGB(160, 160, 160),
        Border = Color3.fromRGB(60, 60, 60),
        Success = Color3.fromRGB(180, 220, 180),
        Warning = Color3.fromRGB(220, 200, 140),
        Error = Color3.fromRGB(220, 140, 140),
        Info = Color3.fromRGB(180, 200, 220)
    }
}

--// Main Library
local KimiUI = {}
KimiUI.__index = KimiUI

KimiUI.Version = "1.0.0"
KimiUI.Themes = Themes

function KimiUI:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or config.Title or "KimiUI"
    local themeName = config.Theme or "Default"
    local size = config.Size or UDim2.new(0, 650, 0, 450)
    local minSize = config.MinSize or Vector2.new(500, 350)
    local canResize = config.CanResize ~= false
    local canDrag = config.CanDrag ~= false
    local showTitleBar = config.ShowTitleBar ~= false
    local showCloseButton = config.ShowCloseButton ~= false
    local showMinimizeButton = config.ShowMinimizeButton ~= false
    
    local theme = Themes[themeName] or Themes.Default
    
    --// ScreenGui
    local screenGui = Utility:Create("ScreenGui", {
        Name = windowName .. "_KimiUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = CoreGui
    elseif gethui then
        screenGui.Parent = gethui()
    else
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    --// Main Frame
    local mainFrame = Utility:Create("Frame", {
        Name = "Main",
        BackgroundColor3 = theme.Background,
        BorderSizePixel = 0,
        Position = config.Position or UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2),
        Size = size,
        ClipsDescendants = true,
        Parent = screenGui
    })
    Utility:CreateCorner(mainFrame, 10)
    Utility:CreateShadow(mainFrame, 0.5)
    
    --// Stroke
    Utility:CreateStroke(mainFrame, theme.Border, 1.2, 0.5)
    
    --// Dragging
    if canDrag then
        Utility:SetDrag(mainFrame)
    end
    
    --// Resizing
    if canResize then
        local resizeHandle = Utility:Create("Frame", {
            Name = "ResizeHandle",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -20, 1, -20),
            Size = UDim2.new(0, 20, 0, 20),
            Parent = mainFrame
        })
        
        local resizeIcon = Utility:Create("ImageLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 5, 0, 5),
            Size = UDim2.new(0, 10, 0, 10),
            Image = "rbxassetid://6761432098",
            ImageColor3 = theme.TextDark,
            ImageTransparency = 0.5,
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = false
            end
        end)
    end
    
    --// Title Bar
    local titleBar = Utility:Create("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
        Parent = mainFrame
    })
    
    --// Title Bar Accent Line
    Utility:Create("Frame", {
        Name = "AccentLine",
        BackgroundColor3 = theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 2),
        Parent = titleBar
    })
    
    --// Window Icon
    local windowIcon = Utility:Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(0, 24, 0, 24),
        Image = config.Icon or "rbxassetid://7733965386",
        ImageColor3 = theme.Accent,
        Parent = titleBar
    })
    
    --// Window Title
    local windowTitle = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 42, 0, 0),
        Size = UDim2.new(1, -120, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })
    
    --// Window Buttons
    local buttonsFrame = Utility:Create("Frame", {
        Name = "Buttons",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -80, 0, 0),
        Size = UDim2.new(0, 80, 1, 0),
        Parent = titleBar
    })
    
    if showMinimizeButton then
        local minimizeBtn = Utility:Create("TextButton", {
            Name = "Minimize",
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 40, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = "-",
            TextColor3 = theme.TextDark,
            TextSize = 20,
            Parent = buttonsFrame
        })
        
        minimizeBtn.MouseEnter:Connect(function()
            Utility:Tween(minimizeBtn, {TextColor3 = theme.Text}, 0.2)
        end)
        
        minimizeBtn.MouseLeave:Connect(function()
            Utility:Tween(minimizeBtn, {TextColor3 = theme.TextDark}, 0.2)
        end)
        
        local minimized = false
        minimizeBtn.MouseButton1Click:Connect(function()
            minimized = not minimized
            if minimized then
                Utility:Tween(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 40)}, 0.3)
            else
                Utility:Tween(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, size.Y.Offset)}, 0.3)
            end
        end)
    end
    
    if showCloseButton then
        local closeBtn = Utility:Create("TextButton", {
            Name = "Close",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 40, 0, 0),
            Size = UDim2.new(0, 40, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = "×",
            TextColor3 = theme.TextDark,
            TextSize = 20,
            Parent = buttonsFrame
        })
        
        closeBtn.MouseEnter:Connect(function()
            Utility:Tween(closeBtn, {TextColor3 = theme.Error}, 0.2)
        end)
        
        closeBtn.MouseLeave:Connect(function()
            Utility:Tween(closeBtn, {TextColor3 = theme.TextDark}, 0.2)
        end)
        
        closeBtn.MouseButton1Click:Connect(function()
            Utility:Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, function()
                screenGui:Destroy()
            end)
        end)
    end
    
    --// Content Area
    local contentArea = Utility:Create("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(1, 0, 1, -40),
        Parent = mainFrame
    })
    
    --// Tab Container (Left side)
    local tabContainer = Utility:Create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 160, 1, 0),
        Parent = contentArea
    })
    
    --// Tab Container Right Border
    Utility:Create("Frame", {
        Name = "Border",
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -1, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        Parent = tabContainer
    })
    
    local tabScroll = Utility:Create("ScrollingFrame", {
        Name = "TabScroll",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = theme.Accent,
        Parent = tabContainer
    })
    
    local tabListLayout = Utility:CreateListLayout(tabScroll, 2)
    Utility:CreatePadding(tabScroll, 6)
    
    --// Tab Content Area (Right side)
    local tabContentArea = Utility:Create("Frame", {
        Name = "TabContentArea",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 160, 0, 0),
        Size = UDim2.new(1, -160, 1, 0),
        Parent = contentArea
    })
    
    --// Tab Contents Folder
    local tabContents = Utility:Create("Folder", {
        Name = "TabContents",
        Parent = tabContentArea
    })
    
    --// Window Object
    local Window = setmetatable({}, KimiUI)
    Window.Theme = theme
    Window.ThemeName = themeName
    Window.ScreenGui = screenGui
    Window.MainFrame = mainFrame
    Window.TabContainer = tabScroll
    Window.TabContentArea = tabContentArea
    Window.TabContents = tabContents
    Window.Tabs = {}
    Window.ActiveTab = nil
    Window.Elements = {}
    Window.Flags = {}
    Window.Connections = {}
    Window.Config = config
    
    --// Global Config Access
    KimiUI.CurrentWindow = Window
    
    return Window
end

--// Theme System
function KimiUI:SetTheme(themeName)
    local theme = Themes[themeName]
    if not theme then return end
    
    self.Theme = theme
    self.ThemeName = themeName
    
    -- Update all elements
    for _, element in pairs(self.Elements) do
        if element.UpdateTheme then
            element:UpdateTheme(theme)
        end
    end
end

function KimiUI:CreateCustomTheme(name, colors)
    Themes[name] = colors
end

--// Tab System
function KimiUI:AddTab(config)
    config = config or {}
    local tabName = config.Name or "Tab"
    local tabIcon = config.Icon or nil
    local tabColor = config.Color or self.Theme.Accent
    
    local tabButton = Utility:Create("TextButton", {
        Name = tabName .. "Tab",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -12, 0, 36),
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = "",
        Parent = self.TabContainer
    })
    Utility:CreateCorner(tabButton, 6)
    
    --// Tab Button Indicator
    local tabIndicator = Utility:Create("Frame", {
        Name = "Indicator",
        BackgroundColor3 = tabColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 6),
        Size = UDim2.new(0, 3, 1, -12),
        Parent = tabButton
    })
    Utility:CreateCorner(tabIndicator, 2)
    
    --// Tab Icon
    if tabIcon then
        local icon = Utility:Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, 8),
            Size = UDim2.new(0, 20, 0, 20),
            Image = tabIcon,
            ImageColor3 = self.Theme.TextDark,
            Parent = tabButton
        })
        
        local tabText = Utility:Create("TextLabel", {
            Name = "Text",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 36, 0, 0),
            Size = UDim2.new(1, -42, 1, 0),
            Font = Enum.Font.GothamSemibold,
            Text = tabName,
            TextColor3 = self.Theme.TextDark,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabButton
        })
    else
        local tabText = Utility:Create("TextLabel", {
            Name = "Text",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 0),
            Size = UDim2.new(1, -18, 1, 0),
            Font = Enum.Font.GothamSemibold,
            Text = tabName,
            TextColor3 = self.Theme.TextDark,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabButton
        })
    end
    
    --// Tab Content
    local tabContent = Utility:Create("ScrollingFrame", {
        Name = tabName .. "Content",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = self.Theme.Accent,
        ScrollBarImageTransparency = 0.6,
        Visible = false,
        Parent = self.TabContents
    })
    
    local contentLayout = Utility:CreateListLayout(tabContent, 10)
    Utility:CreatePadding(tabContent, 12)
    
    --// Tab Sections Container
    local tabSections = {}
    
    --// Tab Object
    local Tab = {
        Name = tabName,
        Button = tabButton,
        Content = tabContent,
        Indicator = tabIndicator,
        Sections = tabSections,
        Window = self,
        Color = tabColor
    }
    
    table.insert(self.Tabs, Tab)
    
    --// Tab Button Hover Effects
    tabButton.MouseEnter:Connect(function()
        if self.ActiveTab ~= Tab then
            Utility:Tween(tabButton, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if self.ActiveTab ~= Tab then
            Utility:Tween(tabButton, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
        end
    end)
    
    --// Tab Button Click
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(Tab)
    end)
    
    --// Auto select first tab
    if #self.Tabs == 1 then
        self:SelectTab(Tab)
    end
    
    --// Tab Methods
    function Tab:AddSection(config)
        config = config or {}
        local sectionName = config.Name or "Section"
        local sectionSide = config.Side or "Left"
        
        local sectionFrame = Utility:Create("Frame", {
            Name = sectionName .. "Section",
            BackgroundColor3 = self.Window.Theme.Secondary,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -5, 0, 40),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = self.Content
        })
        Utility:CreateCorner(sectionFrame, 8)
        
        local sectionTitle = Utility:Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 8),
            Size = UDim2.new(1, -24, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = sectionName,
            TextColor3 = self.Window.Theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = sectionFrame
        })
        
        local sectionContent = Utility:Create("Frame", {
            Name = "Content",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 32),
            Size = UDim2.new(1, 0, 1, -32),
            Parent = sectionFrame
        })
        
        local sectionLayout = Utility:CreateListLayout(sectionContent, 6)
        Utility:CreatePadding(sectionContent, 8)
        
        local Section = {
            Name = sectionName,
            Frame = sectionFrame,
            Content = sectionContent,
            Tab = self,
            Elements = {}
        }
        
        table.insert(self.Sections, Section)
        table.insert(self.Window.Elements, Section)
        
        function Section:AddButton(config)
            return self.Tab.Window:CreateButton(config, self.Content)
        end
        
        function Section:AddToggle(config)
            return self.Tab.Window:CreateToggle(config, self.Content)
        end
        
        function Section:AddSlider(config)
            return self.Tab.Window:CreateSlider(config, self.Content)
        end
        
        function Section:AddInput(config)
            return self.Tab.Window:CreateInput(config, self.Content)
        end
        
        function Section:AddDropdown(config)
            return self.Tab.Window:CreateDropdown(config, self.Content)
        end
        
        function Section:AddParagraph(config)
            return self.Tab.Window:CreateParagraph(config, self.Content)
        end
        
        function Section:AddKeybind(config)
            return self.Tab.Window:CreateKeybind(config, self.Content)
        end
        
        function Section:AddColorpicker(config)
            return self.Tab.Window:CreateColorpicker(config, self.Content)
        end
        
        function Section:AddCode(config)
            return self.Tab.Window:CreateCode(config, self.Content)
        end
        
        function Section:AddAdvanced(config)
            return self.Tab.Window:CreateAdvanced(config, self.Content)
        end
        
        return Section
    end
    
    --// Direct element addition to tab
    function Tab:AddButton(config)
        return self.Window:CreateButton(config, self.Content)
    end
    
    function Tab:AddToggle(config)
        return self.Window:CreateToggle(config, self.Content)
    end
    
    function Tab:AddSlider(config)
        return self.Window:CreateSlider(config, self.Content)
    end
    
    function Tab:AddInput(config)
        return self.Window:CreateInput(config, self.Content)
    end
    
    function Tab:AddDropdown(config)
        return self.Window:CreateDropdown(config, self.Content)
    end
    
    function Tab:AddParagraph(config)
        return self.Window:CreateParagraph(config, self.Content)
    end
    
    function Tab:AddKeybind(config)
        return self.Window:CreateKeybind(config, self.Content)
    end
    
    function Tab:AddColorpicker(config)
        return self.Window:CreateColorpicker(config, self.Content)
    end
    
    function Tab:AddCode(config)
        return self.Window:CreateCode(config, self.Content)
    end
    
    function Tab:AddAdvanced(config)
        return self.Window:CreateAdvanced(config, self.Content)
    end
    
    return Tab
end

function KimiUI:SelectTab(tab)
    if self.ActiveTab == tab then return end
    
    -- Deselect current tab
    if self.ActiveTab then
        Utility:Tween(self.ActiveTab.Button, {
            BackgroundColor3 = self.Theme.Secondary
        }, 0.2)
        Utility:Tween(self.ActiveTab.Indicator, {
            Size = UDim2.new(0, 3, 0, 0),
            Position = UDim2.new(0, 0, 0.5, 0)
        }, 0.2)
        self.ActiveTab.Content.Visible = false
        
        local icon = self.ActiveTab.Button:FindFirstChild("Icon")
        if icon then
            Utility:Tween(icon, {ImageColor3 = self.Theme.TextDark}, 0.2)
        end
        local text = self.ActiveTab.Button:FindFirstChild("Text")
        if text then
            Utility:Tween(text, {TextColor3 = self.Theme.TextDark}, 0.2)
        end
    end
    
    -- Select new tab
    self.ActiveTab = tab
    Utility:Tween(tab.Button, {
        BackgroundColor3 = self.Theme.Foreground
    }, 0.2)
    Utility:Tween(tab.Indicator, {
        Size = UDim2.new(0, 3, 1, -12),
        Position = UDim2.new(0, 0, 0, 6)
    }, 0.2)
    tab.Content.Visible = true
    
    local icon = tab.Button:FindFirstChild("Icon")
    if icon then
        Utility:Tween(icon, {ImageColor3 = tab.Color}, 0.2)
    end
    local text = tab.Button:FindFirstChild("Text")
    if text then
        Utility:Tween(text, {TextColor3 = self.Theme.Text}, 0.2)
    end
end

--// Button Element
function KimiUI:CreateButton(config, parent)
    config = config or {}
    local buttonText = config.Name or config.Text or "Button"
    local callback = config.Callback or function() end
    local buttonStyle = config.Style or "Default" -- Default, Outline, Ghost
    local buttonSize = config.Size or UDim2.new(1, 0, 0, 34)
    
    local buttonFrame = Utility:Create("TextButton", {
        Name = buttonText .. "Button",
        BackgroundColor3 = buttonStyle == "Default" and self.Theme.Accent or (buttonStyle == "Outline" and self.Theme.Secondary or self.Theme.Secondary),
        BackgroundTransparency = buttonStyle == "Ghost" and 1 or 0,
        BorderSizePixel = 0,
        Size = buttonSize,
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = buttonText,
        TextColor3 = buttonStyle == "Default" and Color3.fromRGB(255, 255, 255) or self.Theme.Text,
        TextSize = 14,
        Parent = parent
    })
    Utility:CreateCorner(buttonFrame, 6)
    
    if buttonStyle == "Outline" then
        Utility:CreateStroke(buttonFrame, self.Theme.Accent, 1.5, 0.5)
    end
    
    Utility:CreateRipple(buttonFrame)
    
    --// Hover Effects
    buttonFrame.MouseEnter:Connect(function()
        if buttonStyle == "Default" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.AccentLight}, 0.2)
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Accent}, 0.2)
            buttonFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            Utility:Tween(buttonFrame, {BackgroundTransparency = 0.8}, 0.2)
        end
    end)
    
    buttonFrame.MouseLeave:Connect(function()
        if buttonStyle == "Default" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Accent}, 0.2)
        elseif buttonStyle == "Outline" then
            Utility:Tween(buttonFrame, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
            buttonFrame.TextColor3 = self.Theme.Text
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
        Type = "Button"
    }
    
    table.insert(self.Elements, Button)
    
    return Button
end

--// Toggle Element
function KimiUI:CreateToggle(config, parent)
    config = config or {}
    local toggleName = config.Name or "Toggle"
    local default = config.Default or false
    local callback = config.Callback or function() end
    local flag = config.Flag or nil
    
    if flag then
        self.Flags[flag] = default
    end
    
    local toggleFrame = Utility:Create("Frame", {
        Name = toggleName .. "Toggle",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        Parent = parent
    })
    Utility:CreateCorner(toggleFrame, 6)
    
    local toggleLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -70, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = toggleName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleFrame
    })
    
    local toggleButton = Utility:Create("TextButton", {
        Name = "ToggleButton",
        BackgroundColor3 = default and self.Theme.Accent or self.Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -52, 0.5, -12),
        Size = UDim2.new(0, 44, 0, 24),
        AutoButtonColor = false,
        Text = "",
        Parent = toggleFrame
    })
    Utility:CreateCorner(toggleButton, 12)
    
    local toggleCircle = Utility:Create("Frame", {
        Name = "Circle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = default and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2),
        Size = UDim2.new(0, 20, 0, 20),
        Parent = toggleButton
    })
    Utility:CreateCorner(toggleCircle, 10)
    
    local toggled = default
    
    toggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        if flag then
            self.Flags[flag] = toggled
        end
        
        Utility:Tween(toggleButton, {
            BackgroundColor3 = toggled and self.Theme.Accent or self.Theme.Border
        }, 0.3)
        Utility:Tween(toggleCircle, {
            Position = toggled and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
        }, 0.3)
        
        callback(toggled)
    end)
    
    local Toggle = {
        Frame = toggleFrame,
        Value = toggled,
        Set = function(self, value)
            toggled = value
            if flag then
                self.Window.Flags[flag] = toggled
            end
            Utility:Tween(toggleButton, {
                BackgroundColor3 = toggled and self.Window.Theme.Accent or self.Window.Theme.Border
            }, 0.3)
            Utility:Tween(toggleCircle, {
                Position = toggled and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
            }, 0.3)
            callback(toggled)
        end,
        Type = "Toggle"
    }
    
    -- Fix Set function to have proper self reference
    Toggle.Set = function(_, value)
        toggled = value
        if flag then
            KimiUI.CurrentWindow.Flags[flag] = toggled
        end
        Utility:Tween(toggleButton, {
            BackgroundColor3 = toggled and KimiUI.CurrentWindow.Theme.Accent or KimiUI.CurrentWindow.Theme.Border
        }, 0.3)
        Utility:Tween(toggleCircle, {
            Position = toggled and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
        }, 0.3)
        callback(toggled)
    end
    
    table.insert(self.Elements, Toggle)
    
    return Toggle
end

--// Slider Element
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
        Size = UDim2.new(1, 0, 0, 56),
        Parent = parent
    })
    Utility:CreateCorner(sliderFrame, 6)
    
    local sliderLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 6),
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
        Position = UDim2.new(1, -70, 0, 6),
        Size = UDim2.new(0, 60, 0, 20),
        Font = Enum.Font.GothamSemibold,
        Text = tostring(default) .. suffix,
        TextColor3 = self.Theme.Accent,
        TextSize = 14,
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
    
    local sliderThumb = Utility:Create("Frame", {
        Name = "Thumb",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        Parent = sliderBackground
    })
    Utility:CreateCorner(sliderThumb, 8)
    
    --// Slider Dragging
    local dragging = false
    
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * pos
        value = math.floor(value / increment + 0.5) * increment
        value = Utility:RoundNumber(value, #tostring(increment) - 2)
        value = math.clamp(value, min, max)
        
        local fillSize = (value - min) / (max - min)
        sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
        sliderThumb.Position = UDim2.new(fillSize, -8, 0.5, -8)
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
        Set = function(_, value)
            value = math.clamp(value, min, max)
            value = math.floor(value / increment + 0.5) * increment
            local fillSize = (value - min) / (max - min)
            sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
            sliderThumb.Position = UDim2.new(fillSize, -8, 0.5, -8)
            valueLabel.Text = tostring(value) .. suffix
            if flag then
                KimiUI.CurrentWindow.Flags[flag] = value
            end
            callback(value)
        end,
        Type = "Slider"
    }
    
    table.insert(self.Elements, Slider)
    
    return Slider
end

--// Input Element
function KimiUI:CreateInput(config, parent)
    config = config or {}
    local inputName = config.Name or "Input"
    local placeholder = config.Placeholder or "Enter text..."
    local default = config.Default or ""
    local callback = config.Callback or function() end
    local inputType = config.Type or "Default" -- Default, Number, Password
    local flag = config.Flag or nil
    
    if flag then
        self.Flags[flag] = default
    end
    
    local inputFrame = Utility:Create("Frame", {
        Name = inputName .. "Input",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 66),
        Parent = parent
    })
    Utility:CreateCorner(inputFrame, 6)
    
    local inputLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -24, 0, 20),
        Font = Enum.Font.GothamSemibold,
        Text = inputName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = inputFrame
    })
    
    local inputBox = Utility:Create("TextBox", {
        Name = "InputBox",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 32),
        Size = UDim2.new(1, -24, 0, 28),
        Font = Enum.Font.Gotham,
        Text = default,
        TextColor3 = self.Theme.Text,
        PlaceholderText = placeholder,
        PlaceholderColor3 = self.Theme.TextDark,
        TextSize = 13,
        ClearTextOnFocus = false,
        Parent = inputFrame
    })
    Utility:CreateCorner(inputBox, 6)
    Utility:CreatePadding(inputBox, 8)
    
    if inputType == "Password" then
        inputBox.Text = string.rep("•", #default)
    end
    
    inputBox.Focused:Connect(function()
        Utility:Tween(inputBox, {BackgroundColor3 = self.Theme.Primary}, 0.2)
    end)
    
    inputBox.FocusLost:Connect(function(enterPressed)
        Utility:Tween(inputBox, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
        local text = inputBox.Text
        if inputType == "Password" then
            -- Keep actual text but display dots
        end
        if flag then
            self.Flags[flag] = text
        end
        callback(text, enterPressed)
    end)
    
    local Input = {
        Frame = inputFrame,
        InputBox = inputBox,
        Value = default,
        Set = function(_, value)
            inputBox.Text = value
            if flag then
                KimiUI.CurrentWindow.Flags[flag] = value
            end
        end,
        Type = "Input"
    }
    
    table.insert(self.Elements, Input)
    
    return Input
end

--// Dropdown Element
function KimiUI:CreateDropdown(config, parent)
    config = config or {}
    local dropdownName = config.Name or "Dropdown"
    local options = config.Options or config.Values or {}
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
        Size = UDim2.new(1, 0, 0, 66),
        ClipsDescendants = true,
        Parent = parent
    })
    Utility:CreateCorner(dropdownFrame, 6)
    
    local dropdownLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 6),
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
        Position = UDim2.new(0, 12, 0, 32),
        Size = UDim2.new(1, -24, 0, 28),
        AutoButtonColor = false,
        Font = Enum.Font.Gotham,
        Text = multiSelect and (default ~= "" and default or "Select...") or (default ~= "" and tostring(default) or "Select..."),
        TextColor3 = self.Theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdownFrame
    })
    Utility:CreateCorner(dropdownButton, 6)
    Utility:CreatePadding(dropdownButton, 10)
    
    local arrowIcon = Utility:Create("ImageLabel", {
        Name = "Arrow",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -26, 0, 4),
        Size = UDim2.new(0, 20, 0, 20),
        Image = "rbxassetid://7072706663",
        ImageColor3 = self.Theme.TextDark,
        Parent = dropdownButton
    })
    
    local optionsFrame = Utility:Create("Frame", {
        Name = "Options",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 64),
        Size = UDim2.new(1, -24, 0, 0),
        ClipsDescendants = true,
        Visible = false,
        Parent = dropdownFrame
    })
    Utility:CreateCorner(optionsFrame, 6)
    
    local optionsLayout = Utility:CreateListLayout(optionsFrame, 1)
    Utility:CreatePadding(optionsFrame, 4)
    
    local selectedValues = multiSelect and {default} or default
    local isOpen = false
    
    local function toggleDropdown()
        isOpen = not isOpen
        if isOpen then
            optionsFrame.Visible = true
            local totalHeight = math.min(#options * 29 + 8, 150)
            Utility:Tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 70 + totalHeight)}, 0.3)
            Utility:Tween(optionsFrame, {Size = UDim2.new(1, -24, 0, totalHeight)}, 0.3)
            Utility:Tween(arrowIcon, {Rotation = 180}, 0.3)
        else
            Utility:Tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 66)}, 0.3)
            Utility:Tween(optionsFrame, {Size = UDim2.new(1, -24, 0, 0)}, 0.3)
            Utility:Tween(arrowIcon, {Rotation = 0}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function()
                optionsFrame.Visible = false
            end)
        end
    end
    
    dropdownButton.MouseButton1Click:Connect(toggleDropdown)
    
    --// Create Options
    for _, option in pairs(options) do
        local optionButton = Utility:Create("TextButton", {
            Name = tostring(option) .. "Option",
            BackgroundColor3 = self.Theme.Secondary,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -8, 0, 28),
            AutoButtonColor = false,
            Font = Enum.Font.Gotham,
            Text = tostring(option),
            TextColor3 = self.Theme.TextDark,
            TextSize = 13,
            Parent = optionsFrame
        })
        Utility:CreateCorner(optionButton, 4)
        
        optionButton.MouseEnter:Connect(function()
            Utility:Tween(optionButton, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
            Utility:Tween(optionButton, {TextColor3 = self.Theme.Text}, 0.2)
        end)
        
        optionButton.MouseLeave:Connect(function()
            Utility:Tween(optionButton, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
            Utility:Tween(optionButton, {TextColor3 = self.Theme.TextDark}, 0.2)
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            if multiSelect then
                -- Toggle selection
                if table.find(selectedValues, option) then
                    table.remove(selectedValues, table.find(selectedValues, option))
                else
                    table.insert(selectedValues, option)
                end
                dropdownButton.Text = #selectedValues > 0 and table.concat(selectedValues, ", ") or "Select..."
            else
                selectedValues = option
                dropdownButton.Text = tostring(option)
                toggleDropdown()
            end
            
            if flag then
                self.Flags[flag] = selectedValues
            end
            
            callback(selectedValues)
        end)
    end
    
    local Dropdown = {
        Frame = dropdownFrame,
        Value = selectedValues,
        Options = options,
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
            -- Clear existing options
            for _, child in pairs(optionsFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            Dropdown.Options = newOptions
        end,
        Type = "Dropdown"
    }
    
    table.insert(self.Elements, Dropdown)
    
    return Dropdown
end

--// Paragraph Element
function KimiUI:CreateParagraph(config, parent)
    config = config or {}
    local title = config.Title or config.Name or ""
    local content = config.Content or config.Text or ""
    local align = config.Align or Enum.TextXAlignment.Left
    
    local paragraphFrame = Utility:Create("Frame", {
        Name = (title ~= "" and title or "Paragraph") .. "Paragraph",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = parent
    })
    Utility:CreateCorner(paragraphFrame, 6)
    
    local contentY = 8
    
    if title ~= "" then
        local titleLabel = Utility:Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 8),
            Size = UDim2.new(1, -24, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = title,
            TextColor3 = self.Theme.Accent,
            TextSize = 14,
            TextXAlignment = align,
            Parent = paragraphFrame
        })
        contentY = 30
    end
    
    local contentLabel = Utility:Create("TextLabel", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, contentY),
        Size = UDim2.new(1, -24, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = content,
        TextColor3 = self.Theme.TextDark,
        TextSize = 13,
        TextXAlignment = align,
        TextWrapped = true,
        Parent = paragraphFrame
    })
    
    -- Calculate height
    local textHeight = TextService:GetTextSize(content, 13, Enum.Font.Gotham, Vector2.new(paragraphFrame.AbsoluteSize.X - 24, 999)).Y
    paragraphFrame.Size = UDim2.new(1, 0, 0, contentY + textHeight + 12)
    
    local Paragraph = {
        Frame = paragraphFrame,
        Title = title,
        Content = content,
        Set = function(_, text)
            contentLabel.Text = text
            local newHeight = TextService:GetTextSize(text, 13, Enum.Font.Gotham, Vector2.new(paragraphFrame.AbsoluteSize.X - 24, 999)).Y
            paragraphFrame.Size = UDim2.new(1, 0, 0, contentY + newHeight + 12)
        end,
        Type = "Paragraph"
    }
    
    table.insert(self.Elements, Paragraph)
    
    return Paragraph
end

--// Keybind Element
function KimiUI:CreateKeybind(config, parent)
    config = config or {}
    local keybindName = config.Name or "Keybind"
    local defaultKey = config.Default or config.Key or Enum.KeyCode.Unknown
    local callback = config.Callback or function() end
    local onHold = config.Hold or false
    local flag = config.Flag or nil
    
    if typeof(defaultKey) == "string" then
        defaultKey = Enum.KeyCode[defaultKey] or Enum.KeyCode.Unknown
    end
    
    if flag then
        self.Flags[flag] = defaultKey
    end
    
    local keybindFrame = Utility:Create("Frame", {
        Name = keybindName .. "Keybind",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        Parent = parent
    })
    Utility:CreateCorner(keybindFrame, 6)
    
    local keybindLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -100, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = keybindName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = keybindFrame
    })
    
    local keybindButton = Utility:Create("TextButton", {
        Name = "KeyButton",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -80, 0.5, -13),
        Size = UDim2.new(0, 72, 0, 26),
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = defaultKey ~= Enum.KeyCode.Unknown and defaultKey.Name or "None",
        TextColor3 = self.Theme.TextDark,
        TextSize = 12,
        Parent = keybindFrame
    })
    Utility:CreateCorner(keybindButton, 4)
    
    local listening = false
    local currentKey = defaultKey
    
    keybindButton.MouseButton1Click:Connect(function()
        listening = true
        keybindButton.Text = "..."
        Utility:Tween(keybindButton, {BackgroundColor3 = self.Theme.Accent}, 0.2)
        keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Delete or input.KeyCode == Enum.KeyCode.Backspace then
                    currentKey = Enum.KeyCode.Unknown
                    keybindButton.Text = "None"
                else
                    currentKey = input.KeyCode
                    keybindButton.Text = input.KeyCode.Name
                end
                listening = false
                Utility:Tween(keybindButton, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
                keybindButton.TextColor3 = self.Theme.TextDark
                
                if flag then
                    self.Flags[flag] = currentKey
                end
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                currentKey = "MouseButton1"
                keybindButton.Text = "MB1"
                listening = false
                Utility:Tween(keybindButton, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
                keybindButton.TextColor3 = self.Theme.TextDark
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                currentKey = "MouseButton2"
                keybindButton.Text = "MB2"
                listening = false
                Utility:Tween(keybindButton, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
                keybindButton.TextColor3 = self.Theme.TextDark
            end
        elseif not gameProcessed then
            local keyMatch = false
            if typeof(currentKey) == "EnumItem" and input.KeyCode == currentKey then
                keyMatch = true
            elseif currentKey == "MouseButton1" and input.UserInputType == Enum.UserInputType.MouseButton1 then
                keyMatch = true
            elseif currentKey == "MouseButton2" and input.UserInputType == Enum.UserInputType.MouseButton2 then
                keyMatch = true
            end
            
            if keyMatch then
                if onHold then
                    callback(true)
                else
                    callback()
                end
            end
        end
    end)
    
    if onHold then
        UserInputService.InputEnded:Connect(function(input)
            local keyMatch = false
            if typeof(currentKey) == "EnumItem" and input.KeyCode == currentKey then
                keyMatch = true
            elseif currentKey == "MouseButton1" and input.UserInputType == Enum.UserInputType.MouseButton1 then
                keyMatch = true
            elseif currentKey == "MouseButton2" and input.UserInputType == Enum.UserInputType.MouseButton2 then
                keyMatch = true
            end
            
            if keyMatch then
                callback(false)
            end
        end)
    end
    
    local Keybind = {
        Frame = keybindFrame,
        Key = currentKey,
        Set = function(_, key)
            if typeof(key) == "string" then
                key = Enum.KeyCode[key] or key
            end
            currentKey = key
            if typeof(key) == "EnumItem" then
                keybindButton.Text = key.Name
            else
                keybindButton.Text = tostring(key)
            end
            if flag then
                KimiUI.CurrentWindow.Flags[flag] = currentKey
            end
        end,
        Type = "Keybind"
    }
    
    table.insert(self.Elements, Keybind)
    
    return Keybind
end

--// Colorpicker Element
function KimiUI:CreateColorpicker(config, parent)
    config = config or {}
    local colorpickerName = config.Name or "Colorpicker"
    local defaultColor = config.Default or config.Color or Color3.fromRGB(255, 255, 255)
    local callback = config.Callback or function() end
    local flag = config.Flag or nil
    
    if flag then
        self.Flags[flag] = defaultColor
    end
    
    local h, s, v = Color3.toHSV(defaultColor)
    
    local colorpickerFrame = Utility:Create("Frame", {
        Name = colorpickerName .. "Colorpicker",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        ClipsDescendants = true,
        Parent = parent
    })
    Utility:CreateCorner(colorpickerFrame, 6)
    
    local colorpickerLabel = Utility:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -70, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = colorpickerName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = colorpickerFrame
    })
    
    local colorPreview = Utility:Create("TextButton", {
        Name = "ColorPreview",
        BackgroundColor3 = defaultColor,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -48, 0.5, -14),
        Size = UDim2.new(0, 40, 0, 28),
        AutoButtonColor = false,
        Text = "",
        Parent = colorpickerFrame
    })
    Utility:CreateCorner(colorPreview, 6)
    Utility:CreateStroke(colorPreview, self.Theme.Border, 1, 0.5)
    
    --// Color Picker Expanded UI
    local pickerFrame = Utility:Create("Frame", {
        Name = "Picker",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 48),
        Size = UDim2.new(1, -24, 0, 180),
        Parent = colorpickerFrame
    })
    
    --// Saturation/Value Box
    local svFrame = Utility:Create("Frame", {
        Name = "SVFrame",
        BackgroundColor3 = Color3.fromHSV(h, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -30, 0, 120),
        Parent = pickerFrame
    })
    Utility:CreateCorner(svFrame, 6)
    
    local svGradient1 = Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        }),
        Parent = svFrame
    })
    
    local svGradient2 = Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
        }),
        Rotation = 180,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        }),
        Parent = svFrame
    })
    
    local svCursor = Utility:Create("Frame", {
        Name = "Cursor",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(s, 0, 1 - v, 0),
        Size = UDim2.new(0, 10, 0, 10),
        Parent = svFrame
    })
    Utility:CreateCorner(svCursor, 5)
    Utility:CreateStroke(svCursor, Color3.fromRGB(0, 0, 0), 1.5)
    
    --// Hue Slider
    local hueFrame = Utility:Create("Frame", {
        Name = "HueFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -22, 0, 0),
        Size = UDim2.new(0, 18, 0, 120),
        Parent = pickerFrame
    })
    Utility:CreateCorner(hueFrame, 6)
    
    local hueGradient = Utility:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        }),
        Rotation = 90,
        Parent = hueFrame
    })
    
    local hueCursor = Utility:Create("Frame", {
        Name = "HueCursor",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 1 - h, 0),
        Size = UDim2.new(1, 4, 0, 6),
        Parent = hueFrame
    })
    Utility:CreateCorner(hueCursor, 3)
    Utility:CreateStroke(hueCursor, Color3.fromRGB(0, 0, 0), 1.5)
    
    --// RGB Values
    local rgbFrame = Utility:Create("Frame", {
        Name = "RGBFrame",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 128),
        Size = UDim2.new(1, -30, 0, 22),
        Parent = pickerFrame
    })
    
    local r = math.floor(defaultColor.R * 255)
    local g = math.floor(defaultColor.G * 255)
    local b = math.floor(defaultColor.B * 255)
    
    local rgbLabel = Utility:Create("TextBox", {
        Name = "RGB",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = string.format("%d, %d, %d", r, g, b),
        TextColor3 = self.Theme.Text,
        TextSize = 12,
        Parent = rgbFrame
    })
    Utility:CreateCorner(rgbLabel, 4)
    
    local hexLabel = Utility:Create("TextBox", {
        Name = "HEX",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 154),
        Size = UDim2.new(1, -30, 0, 22),
        Font = Enum.Font.Gotham,
        Text = string.format("#%02X%02X%02X", r, g, b),
        TextColor3 = self.Theme.Text,
        TextSize = 12,
        Parent = pickerFrame
    })
    Utility:CreateCorner(hexLabel, 4)
    
    --// Picker Logic
    local isOpen = false
    local svDragging = false
    local hueDragging = false
    
    local function updateColor()
        local newColor = Color3.fromHSV(h, s, v)
        colorPreview.BackgroundColor3 = newColor
        svFrame.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        
        local nr = math.floor(newColor.R * 255)
        local ng = math.floor(newColor.G * 255)
        local nb = math.floor(newColor.B * 255)
        
        rgbLabel.Text = string.format("%d, %d, %d", nr, ng, nb)
        hexLabel.Text = string.format("#%02X%02X%02X", nr, ng, nb)
        
        if flag then
            self.Flags[flag] = newColor
        end
        
        callback(newColor)
    end
    
    colorPreview.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            Utility:Tween(colorpickerFrame, {Size = UDim2.new(1, 0, 0, 236)}, 0.3)
        else
            Utility:Tween(colorpickerFrame, {Size = UDim2.new(1, 0, 0, 42)}, 0.3)
        end
    end)
    
    -- SV Dragging
    svFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            svDragging = true
            local pos = math.clamp((input.Position.X - svFrame.AbsolutePosition.X) / svFrame.AbsoluteSize.X, 0, 1)
            local val = math.clamp((input.Position.Y - svFrame.AbsolutePosition.Y) / svFrame.AbsoluteSize.Y, 0, 1)
            s = pos
            v = 1 - val
            svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
            updateColor()
        end
    end)
    
    -- Hue Dragging
    hueFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            hueDragging = true
            local pos = math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
            h = 1 - pos
            hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0)
            updateColor()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if svDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - svFrame.AbsolutePosition.X) / svFrame.AbsoluteSize.X, 0, 1)
            local val = math.clamp((input.Position.Y - svFrame.AbsolutePosition.Y) / svFrame.AbsoluteSize.Y, 0, 1)
            s = pos
            v = 1 - val
            svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
            updateColor()
        elseif hueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
            h = 1 - pos
            hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0)
            updateColor()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            svDragging = false
            hueDragging = false
        end
    end)
    
    local Colorpicker = {
        Frame = colorpickerFrame,
        Color = defaultColor,
        Set = function(_, color)
            h, s, v = Color3.toHSV(color)
            svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
            hueCursor.Position = UDim2.new(0.5, 0, 1 - h, 0)
            updateColor()
        end,
        Type = "Colorpicker"
    }
    
    table.insert(self.Elements, Colorpicker)
    
    return Colorpicker
end

--// Code Display Element
function KimiUI:CreateCode(config, parent)
    config = config or {}
    local codeText = config.Code or config.Text or ""
    local language = config.Language or "lua"
    local showLineNumbers = config.LineNumbers ~= false
    
    local codeFrame = Utility:Create("Frame", {
        Name = "CodeDisplay",
        BackgroundColor3 = self.Theme.Primary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = parent
    })
    Utility:CreateCorner(codeFrame, 6)
    
    --// Code Header
    local codeHeader = Utility:Create("Frame", {
        Name = "Header",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 28),
        Parent = codeFrame
    })
    Utility:CreateCorner(codeHeader, 6)
    
    -- Fix corner for header
    local headerCornerFix = Utility:Create("Frame", {
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 0.5, 0),
        Parent = codeHeader
    })
    
    local langLabel = Utility:Create("TextLabel", {
        Name = "Language",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0, 100, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = language:upper(),
        TextColor3 = self.Theme.Accent,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = codeHeader
    })
    
    --// Copy Button
    local copyBtn = Utility:Create("TextButton", {
        Name = "Copy",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -70, 0, 4),
        Size = UDim2.new(0, 66, 0, 20),
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = "Copy",
        TextColor3 = self.Theme.Text,
        TextSize = 11,
        Parent = codeHeader
    })
    Utility:CreateCorner(copyBtn, 4)
    
    copyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(codeText)
            copyBtn.Text = "Copied!"
            task.wait(1)
            copyBtn.Text = "Copy"
        end
    end)
    
    --// Line Numbers
    local lineNumbersWidth = showLineNumbers and 36 or 0
    
    if showLineNumbers then
        local lineNumbersFrame = Utility:Create("Frame", {
            Name = "LineNumbers",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 32),
            Size = UDim2.new(0, 36, 1, -36),
            Parent = codeFrame
        })
        
        local lines = string.split(codeText, "\n")
        local lineHeight = 18
        
        for i = 1, #lines do
            Utility:Create("TextLabel", {
                Name = "Line" .. i,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, (i - 1) * lineHeight),
                Size = UDim2.new(1, -4, 0, lineHeight),
                Font = Enum.Font.Code,
                Text = tostring(i),
                TextColor3 = self.Theme.TextDark,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = lineNumbersFrame
            })
        end
        
        codeFrame.Size = UDim2.new(1, 0, 0, 40 + (#lines * lineHeight) + 8)
    end
    
    --// Code Text
    local codeTextLabel = Utility:Create("TextLabel", {
        Name = "Code",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, lineNumbersWidth + 4, 0, 32),
        Size = UDim2.new(1, -lineNumbersWidth - 8, 1, -36),
        Font = Enum.Font.Code,
        Text = codeText,
        TextColor3 = self.Theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Parent = codeFrame
    })
    
    local Code = {
        Frame = codeFrame,
        Code = codeText,
        Set = function(_, text)
            codeText = text
            codeTextLabel.Text = text
        end,
        Type = "Code"
    }
    
    table.insert(self.Elements, Code)
    
    return Code
end

--// Advanced Element (Collapsible Group)
function KimiUI:CreateAdvanced(config, parent)
    config = config or {}
    local advancedName = config.Name or "Advanced"
    local advancedDesc = config.Description or ""
    local defaultOpen = config.DefaultOpen or false
    
    local advancedFrame = Utility:Create("Frame", {
        Name = advancedName .. "Advanced",
        BackgroundColor3 = self.Theme.Foreground,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
        ClipsDescendants = true,
        Parent = parent
    })
    Utility:CreateCorner(advancedFrame, 6)
    
    local headerButton = Utility:Create("TextButton", {
        Name = "Header",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 40),
        AutoButtonColor = false,
        Text = "",
        Parent = advancedFrame
    })
    
    local advancedTitle = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 4),
        Size = UDim2.new(1, -50, 0, 18),
        Font = Enum.Font.GothamBold,
        Text = advancedName,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = headerButton
    })
    
    if advancedDesc ~= "" then
        local advancedDescLabel = Utility:Create("TextLabel", {
            Name = "Description",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 22),
            Size = UDim2.new(1, -50, 0, 16),
            Font = Enum.Font.Gotham,
            Text = advancedDesc,
            TextColor3 = self.Theme.TextDark,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = headerButton
        })
    end
    
    local arrowIcon = Utility:Create("ImageLabel", {
        Name = "Arrow",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -34, 0, 8),
        Size = UDim2.new(0, 24, 0, 24),
        Image = "rbxassetid://7072706663",
        ImageColor3 = self.Theme.TextDark,
        Rotation = defaultOpen and 180 or 0,
        Parent = headerButton
    })
    
    local contentFrame = Utility:Create("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 44),
        Size = UDim2.new(1, 0, 0, 0),
        Parent = advancedFrame
    })
    
    local contentLayout = Utility:CreateListLayout(contentFrame, 6)
    Utility:CreatePadding(contentFrame, 8)
    
    local isOpen = defaultOpen
    
    headerButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Utility:Tween(arrowIcon, {Rotation = isOpen and 180 or 0}, 0.3)
        
        if isOpen then
            local contentHeight = contentLayout.AbsoluteContentSize.Y + 16
            Utility:Tween(advancedFrame, {Size = UDim2.new(1, 0, 0, 48 + contentHeight)}, 0.3)
            Utility:Tween(contentFrame, {Size = UDim2.new(1, 0, 0, contentHeight)}, 0.3)
        else
            Utility:Tween(advancedFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.3)
            Utility:Tween(contentFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
        end
    end)
    
    -- Update size when children added
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if isOpen then
            local contentHeight = contentLayout.AbsoluteContentSize.Y + 16
            advancedFrame.Size = UDim2.new(1, 0, 0, 48 + contentHeight)
            contentFrame.Size = UDim2.new(1, 0, 0, contentHeight)
        end
    end)
    
    -- Initial size
    if defaultOpen then
        task.wait()
        local contentHeight = contentLayout.AbsoluteContentSize.Y + 16
        advancedFrame.Size = UDim2.new(1, 0, 0, 48 + contentHeight)
        contentFrame.Size = UDim2.new(1, 0, 0, contentHeight)
    end
    
    local Advanced = {
        Frame = advancedFrame,
        Content = contentFrame,
        IsOpen = isOpen,
        AddButton = function(_, config)
            return KimiUI.CurrentWindow:CreateButton(config, contentFrame)
        end,
        AddToggle = function(_, config)
            return KimiUI.CurrentWindow:CreateToggle(config, contentFrame)
        end,
        AddSlider = function(_, config)
            return KimiUI.CurrentWindow:CreateSlider(config, contentFrame)
        end,
        AddInput = function(_, config)
            return KimiUI.CurrentWindow:CreateInput(config, contentFrame)
        end,
        AddDropdown = function(_, config)
            return KimiUI.CurrentWindow:CreateDropdown(config, contentFrame)
        end,
        AddParagraph = function(_, config)
            return KimiUI.CurrentWindow:CreateParagraph(config, contentFrame)
        end,
        AddKeybind = function(_, config)
            return KimiUI.CurrentWindow:CreateKeybind(config, contentFrame)
        end,
        AddColorpicker = function(_, config)
            return KimiUI.CurrentWindow:CreateColorpicker(config, contentFrame)
        end,
        AddCode = function(_, config)
            return KimiUI.CurrentWindow:CreateCode(config, contentFrame)
        end,
        Type = "Advanced"
    }
    
    table.insert(self.Elements, Advanced)
    
    return Advanced
end

--// Notification System
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
        Size = UDim2.new(0, 300, 0, 80),
        Parent = notifyGui
    })
    Utility:CreateCorner(notificationFrame, 8)
    Utility:CreateShadow(notificationFrame, 0.4)
    Utility:CreateStroke(notificationFrame, self.Theme.Border, 1, 0.6)
    
    --// Type Color Bar
    local typeColors = {
        Info = self.Theme.Info,
        Success = self.Theme.Success,
        Warning = self.Theme.Warning,
        Error = self.Theme.Error
    }
    
    local typeColor = typeColors[notifyType] or self.Theme.Info
    
    local colorBar = Utility:Create("Frame", {
        Name = "ColorBar",
        BackgroundColor3 = typeColor,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 4, 1, 0),
        Parent = notificationFrame
    })
    Utility:CreateCorner(colorBar, 8)
    
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
        Position = UDim2.new(0, 14, 0, 14),
        Size = UDim2.new(0, 24, 0, 24),
        Image = typeIcons[notifyType] or typeIcons.Info,
        ImageColor3 = typeColor,
        Parent = notificationFrame
    })
    
    --// Title
    local titleLabel = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 46, 0, 10),
        Size = UDim2.new(1, -60, 0, 22),
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
        Position = UDim2.new(0, 46, 0, 34),
        Size = UDim2.new(1, -56, 0, 40),
        Font = Enum.Font.Gotham,
        Text = notifyContent,
        TextColor3 = self.Theme.TextDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = notificationFrame
    })
    
    --// Close Button
    local closeBtn = Utility:Create("TextButton", {
        Name = "Close",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -30, 0, 6),
        Size = UDim2.new(0, 24, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = self.Theme.TextDark,
        TextSize = 18,
        Parent = notificationFrame
    })
    
    closeBtn.MouseButton1Click:Connect(function()
        Utility:Tween(notificationFrame, {Position = UDim2.new(1, 20, 1, -100)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In, function()
            notifyGui:Destroy()
        end)
    end)
    
    --// Show Animation
    Utility:Tween(notificationFrame, {Position = UDim2.new(1, -320, 1, -100)}, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    --// Auto Close
    task.delay(duration, function()
        if notificationFrame and notificationFrame.Parent then
            Utility:Tween(notificationFrame, {Position = UDim2.new(1, 20, 1, -100)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In, function()
                if notifyGui and notifyGui.Parent then
                    notifyGui:Destroy()
                end
            end)
        end
    end)
end

--// Dialog/Popup System
function KimiUI:Dialog(config)
    config = config or {}
    local dialogTitle = config.Title or "Dialog"
    local dialogContent = config.Content or config.Text or ""
    local dialogType = config.Type or "Confirm" -- Confirm, Alert, Prompt
    local confirmText = config.ConfirmText or "Confirm"
    local cancelText = config.CancelText or "Cancel"
    local placeholder = config.Placeholder or ""
    local onConfirm = config.OnConfirm or function() end
    local onCancel = config.OnCancel or function() end
    
    local dialogGui = Utility:Create("ScreenGui", {
        Name = "KimiUIDialog",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = self.ScreenGui.Parent
    })
    
    --// Backdrop
    local backdrop = Utility:Create("Frame", {
        Name = "Backdrop",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = dialogGui
    })
    
    Utility:Tween(backdrop, {BackgroundTransparency = 0.5}, 0.3)
    
    --// Dialog Frame
    local dialogFrame = Utility:Create("Frame", {
        Name = "Dialog",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -175, 0.5, -100),
        Size = UDim2.new(0, 350, 0, 200),
        Parent = dialogGui
    })
    Utility:CreateCorner(dialogFrame, 10)
    Utility:CreateShadow(dialogFrame, 0.3)
    Utility:CreateStroke(dialogFrame, self.Theme.Border, 1, 0.5)
    
    --// Title
    local titleLabel = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 20, 0, 16),
        Size = UDim2.new(1, -40, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = dialogTitle,
        TextColor3 = self.Theme.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dialogFrame
    })
    
    --// Content
    local contentLabel = Utility:Create("TextLabel", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 20, 0, 48),
        Size = UDim2.new(1, -40, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = dialogContent,
        TextColor3 = self.Theme.TextDark,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = dialogFrame
    })
    
    local contentHeight = TextService:GetTextSize(dialogContent, 14, Enum.Font.Gotham, Vector2.new(310, 999)).Y
    local promptOffset = dialogType == "Prompt" and 40 or 0
    local dialogHeight = math.max(180, 80 + contentHeight + promptOffset + 60)
    
    dialogFrame.Size = UDim2.new(0, 350, 0, dialogHeight)
    dialogFrame.Position = UDim2.new(0.5, -175, 0.5, -dialogHeight / 2)
    
    --// Prompt Input
    local promptInput = nil
    if dialogType == "Prompt" then
        promptInput = Utility:Create("TextBox", {
            Name = "PromptInput",
            BackgroundColor3 = self.Theme.Primary,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 20, 0, 58 + contentHeight),
            Size = UDim2.new(1, -40, 0, 32),
            Font = Enum.Font.Gotham,
            PlaceholderText = placeholder,
            PlaceholderColor3 = self.Theme.TextDark,
            Text = "",
            TextColor3 = self.Theme.Text,
            TextSize = 14,
            Parent = dialogFrame
        })
        Utility:CreateCorner(promptInput, 6)
        Utility:CreatePadding(promptInput, 10)
    end
    
    --// Buttons
    local buttonsY = dialogHeight - 50
    
    if dialogType == "Confirm" or dialogType == "Prompt" then
        local cancelBtn = Utility:Create("TextButton", {
            Name = "Cancel",
            BackgroundColor3 = self.Theme.Foreground,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 20, 0, buttonsY),
            Size = UDim2.new(0.5, -30, 0, 36),
            AutoButtonColor = false,
            Font = Enum.Font.GothamSemibold,
            Text = cancelText,
            TextColor3 = self.Theme.Text,
            TextSize = 14,
            Parent = dialogFrame
        })
        Utility:CreateCorner(cancelBtn, 6)
        
        cancelBtn.MouseEnter:Connect(function()
            Utility:Tween(cancelBtn, {BackgroundColor3 = self.Theme.Primary}, 0.2)
        end)
        
        cancelBtn.MouseLeave:Connect(function()
            Utility:Tween(cancelBtn, {BackgroundColor3 = self.Theme.Foreground}, 0.2)
        end)
        
        cancelBtn.MouseButton1Click:Connect(function()
            Utility:Tween(backdrop, {BackgroundTransparency = 1}, 0.2)
            Utility:Tween(dialogFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, function()
                dialogGui:Destroy()
            end)
            onCancel()
        end)
    end
    
    local confirmBtn = Utility:Create("TextButton", {
        Name = "Confirm",
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Position = dialogType == "Alert" and UDim2.new(0.25, 0, 0, buttonsY) or UDim2.new(0.5, 10, 0, buttonsY),
        Size = dialogType == "Alert" and UDim2.new(0.5, 0, 0, 36) or UDim2.new(0.5, -30, 0, 36),
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = confirmText,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Parent = dialogFrame
    })
    Utility:CreateCorner(confirmBtn, 6)
    Utility:CreateRipple(confirmBtn)
    
    confirmBtn.MouseEnter:Connect(function()
        Utility:Tween(confirmBtn, {BackgroundColor3 = self.Theme.AccentLight}, 0.2)
    end)
    
    confirmBtn.MouseLeave:Connect(function()
        Utility:Tween(confirmBtn, {BackgroundColor3 = self.Theme.Accent}, 0.2)
    end)
    
    confirmBtn.MouseButton1Click:Connect(function()
        Utility:Tween(backdrop, {BackgroundTransparency = 1}, 0.2)
        Utility:Tween(dialogFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, function()
            dialogGui:Destroy()
        end)
        
        if dialogType == "Prompt" and promptInput then
            onConfirm(promptInput.Text)
        else
            onConfirm()
        end
    end)
    
    --// Show Animation
    dialogFrame.Size = UDim2.new(0, 0, 0, 0)
    Utility:Tween(dialogFrame, {Size = UDim2.new(0, 350, 0, dialogHeight)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    return dialogGui
end

--// Popup System
function KimiUI:Popup(config)
    config = config or {}
    local popupTitle = config.Title or "Popup"
    local popupContent = config.Content or ""
    local buttons = config.Buttons or {}
    local position = config.Position or UDim2.new(0.5, -150, 0.5, -75)
    
    local popupGui = Utility:Create("ScreenGui", {
        Name = "KimiUIPopup",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = self.ScreenGui.Parent
    })
    
    local backdrop = Utility:Create("Frame", {
        Name = "Backdrop",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 0.6,
        Parent = popupGui
    })
    
    local popupFrame = Utility:Create("Frame", {
        Name = "Popup",
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.new(0, 300, 0, 150),
        Parent = popupGui
    })
    Utility:CreateCorner(popupFrame, 10)
    Utility:CreateShadow(popupFrame, 0.3)
    
    local titleLabel = Utility:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 12),
        Size = UDim2.new(1, -32, 0, 22),
        Font = Enum.Font.GothamBold,
        Text = popupTitle,
        TextColor3 = self.Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = popupFrame
    })
    
    local contentLabel = Utility:Create("TextLabel", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 40),
        Size = UDim2.new(1, -32, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Font = Enum.Font.Gotham,
        Text = popupContent,
        TextColor3 = self.Theme.TextDark,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = popupFrame
    })
    
    local buttonsFrame = Utility:Create("Frame", {
        Name = "Buttons",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 1, -44),
        Size = UDim2.new(1, -32, 0, 36),
        Parent = popupFrame
    })
    
    local buttonsLayout = Utility:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Parent = buttonsFrame
    })
    
    for i, btnConfig in pairs(buttons) do
        local btn = Utility:Create("TextButton", {
            Name = btnConfig.Name or "Button" .. i,
            BackgroundColor3 = btnConfig.Style == "Primary" and self.Theme.Accent or self.Theme.Foreground,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 80, 1, 0),
            AutoButtonColor = false,
            Font = Enum.Font.GothamSemibold,
            Text = btnConfig.Text or "Button",
            TextColor3 = btnConfig.Style == "Primary" and Color3.fromRGB(255, 255, 255) or self.Theme.Text,
            TextSize = 13,
            Parent = buttonsFrame
        })
        Utility:CreateCorner(btn, 6)
        
        btn.MouseButton1Click:Connect(function()
            popupGui:Destroy()
            if btnConfig.Callback then
                btnConfig.Callback()
            end
        end)
    end
    
    return popupGui
end

--// Tag System
function KimiUI:CreateTag(config, parent)
    config = config or {}
    local tagText = config.Text or "Tag"
    local tagColor = config.Color or self.Theme.Accent
    local tagStyle = config.Style or "Filled" -- Filled, Outline, Ghost
    
    local tagFrame = Utility:Create("Frame", {
        Name = tagText .. "Tag",
        BackgroundColor3 = tagStyle == "Filled" and tagColor or (tagStyle == "Outline" and self.Theme.Secondary or self.Theme.Secondary),
        BackgroundTransparency = tagStyle == "Ghost" and 0.9 or 0,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 0, 24),
        AutomaticSize = Enum.AutomaticSize.X,
        Parent = parent
    })
    Utility:CreateCorner(tagFrame, 4)
    
    if tagStyle == "Outline" then
        Utility:CreateStroke(tagFrame, tagColor, 1.5, 0.6)
    end
    
    local tagLabel = Utility:Create("TextLabel", {
        Name = "Text",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        Font = Enum.Font.GothamSemibold,
        Text = tagText,
        TextColor3 = tagStyle == "Filled" and Color3.fromRGB(255, 255, 255) or tagColor,
        TextSize = 12,
        Parent = tagFrame
    })
    
    -- Adjust size
    local textWidth = TextService:GetTextSize(tagText, 12, Enum.Font.GothamSemibold, Vector2.new(999, 24)).X
    tagFrame.Size = UDim2.new(0, textWidth + 16, 0, 24)
    
    local Tag = {
        Frame = tagFrame,
        Text = tagText,
        Set = function(_, text)
            tagLabel.Text = text
            local newWidth = TextService:GetTextSize(text, 12, Enum.Font.GothamSemibold, Vector2.new(999, 24)).X
            tagFrame.Size = UDim2.new(0, newWidth + 16, 0, 24)
        end,
        Type = "Tag"
    }
    
    return Tag
end

--// Minimize/Maximize Toggle
function KimiUI:ToggleMinimize()
    local mainFrame = self.MainFrame
    if mainFrame.Size.Y.Offset <= 45 then
        -- Maximize
        Utility:Tween(mainFrame, {Size = self.Config.Size or UDim2.new(0, 650, 0, 450)}, 0.3)
    else
        -- Minimize
        Utility:Tween(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 40)}, 0.3)
    end
end

--// Destroy Window
function KimiUI:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
    KimiUI.CurrentWindow = nil
end

--// Get Flag Value
function KimiUI:GetFlag(flag)
    return self.Flags[flag]
end

--// Set Flag Value
function KimiUI:SetFlag(flag, value)
    self.Flags[flag] = value
    for _, element in pairs(self.Elements) do
        if element.Flag == flag and element.Set then
            element:Set(value)
        end
    end
end

--// Save Config
function KimiUI:SaveConfig(filename)
    if not filename then return end
    if not isfolder then return end
    
    if not isfolder("KimiUI") then
        makefolder("KimiUI")
    end
    
    if not isfolder("KimiUI/Configs") then
        makefolder("KimiUI/Configs")
    end
    
    local configData = {}
    for flag, value in pairs(self.Flags) do
        if typeof(value) == "Color3" then
            configData[flag] = {
                Type = "Color3",
                R = value.R,
                G = value.G,
                B = value.B
            }
        elseif typeof(value) == "EnumItem" then
            configData[flag] = {
                Type = "Enum",
                Value = tostring(value)
            }
        else
            configData[flag] = value
        end
    end
    
    writefile("KimiUI/Configs/" .. filename .. ".json", HttpService:JSONEncode(configData))
end

--// Load Config
function KimiUI:LoadConfig(filename)
    if not filename then return end
    if not isfile then return end
    
    local path = "KimiUI/Configs/" .. filename .. ".json"
    if not isfile(path) then return end
    
    local success, configData = pcall(function()
        return HttpService:JSONDecode(readfile(path))
    end)
    
    if not success then return end
    
    for flag, value in pairs(configData) do
        if typeof(value) == "table" then
            if value.Type == "Color3" then
                self:SetFlag(flag, Color3.new(value.R, value.G, value.B))
            elseif value.Type == "Enum" then
                -- Handle enum
            end
        else
            self:SetFlag(flag, value)
        end
    end
end

return KimiUI
