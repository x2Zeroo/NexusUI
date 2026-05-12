local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Theme = require(script.Parent.Theme)

local Library = {
    Themes = Theme,
    CurrentTheme = Theme.Default,
    Notifications = {}
}

-- Utility functions
local function Create(class, properties, children)
    local instance = Instance.new(class)
    for i, v in pairs(properties) do
        instance[i] = v
    end
    if children then
        for _, child in pairs(children) do
            child.Parent = instance
        end
    end
    return instance
end

function Library:CreateWindow(options)
    options = options or {}
    local title = options.Title or "Manus UI Library"
    local size = options.Size or UDim2.new(0, 550, 0, 350)
    
    local ScreenGui = Create("ScreenGui", {
        Name = "ManusUI",
        Parent = CoreGui,
        ResetOnSpawn = false
    })

    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        BackgroundColor3 = self.CurrentTheme.MainBackground,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2),
        Size = size,
        ClipsDescendants = true,
        Active = true,
        Draggable = true -- Simple draggable, can be improved with custom logic
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 8)}),
        Create("UIStroke", {
            Color = self.CurrentTheme.Border,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
    })

    -- Title Bar
    local TitleBar = Create("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 40)
    }, {
        Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 15, 0, 0),
            Size = UDim2.new(1, -30, 1, 0),
            Text = title,
            TextColor3 = self.CurrentTheme.Text,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    })

    -- Sidebar (Tabs)
    local Sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 150, 1, 0)
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 8)}),
        Create("Frame", { -- Cover right corners of sidebar
            Size = UDim2.new(0, 20, 1, 0),
            Position = UDim2.new(1, -20, 0, 0),
            BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
            BorderSizePixel = 0
        })
    })

    local TabContainer = Create("ScrollingFrame", {
        Name = "TabContainer",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 5, 0, 50),
        Size = UDim2.new(1, -10, 1, -60),
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    }, {
        Create("UIListLayout", {Padding = UDim.new(0, 5)})
    })

    -- Content Area
    local ContentArea = Create("Frame", {
        Name = "ContentArea",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 150, 0, 40),
        Size = UDim2.new(1, -150, 1, -40)
    })

    local PageContainer = Create("Frame", {
        Name = "PageContainer",
        Parent = ContentArea,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    })

    local Window = {
        Tabs = {},
        CurrentTab = nil
    }

    function Window:CreateTab(name, icon)
        local Tab = {
            Sections = {},
            Name = name
        }

        local TabButton = Create("TextButton", {
            Name = name .. "Tab",
            Parent = TabContainer,
            BackgroundColor3 = Library.CurrentTheme.ElementBackground,
            Size = UDim2.new(1, 0, 0, 35),
            AutoButtonColor = false,
            Text = name,
            TextColor3 = Library.CurrentTheme.TextSecondary,
            TextSize = 14,
            Font = Enum.Font.GothamMedium
        }, {
            Create("UICorner", {CornerRadius = UDim.new(0, 6)})
        })

        local Page = Create("ScrollingFrame", {
            Name = name .. "Page",
            Parent = PageContainer,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = Library.CurrentTheme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0)
        }, {
            Create("UIListLayout", {Padding = UDim.new(0, 10), HorizontalAlignment = Enum.HorizontalAlignment.Center}),
            Create("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10)})
        })

        function Tab:Select()
            if Window.CurrentTab then
                Window.CurrentTab.Page.Visible = false
                TweenService:Create(Window.CurrentTab.Button, TweenInfo.new(0.3), {TextColor3 = Library.CurrentTheme.TextSecondary, BackgroundColor3 = Library.CurrentTheme.ElementBackground}):Play()
            end
            Window.CurrentTab = {Page = Page, Button = TabButton}
            Page.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.3), {TextColor3 = Library.CurrentTheme.Text, BackgroundColor3 = Library.CurrentTheme.Accent}):Play()
        end

        TabButton.MouseButton1Click:Connect(function()
            Tab:Select()
        end)

        Tab.Page = Page
        Tab.Button = TabButton

        if not Window.CurrentTab then
            Tab:Select()
        end

        function Tab:CreateSection(sectionName)
            local SectionFrame = Create("Frame", {
                Name = sectionName .. "Section",
                Parent = Page,
                BackgroundColor3 = Library.CurrentTheme.SecondaryBackground,
                Size = UDim2.new(0.9, 0, 0, 30),
                BorderSizePixel = 0
            }, {
                Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                Create("UIListLayout", {Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center}),
                Create("UIPadding", {PaddingTop = UDim.new(0, 30), PaddingBottom = UDim.new(0, 10)})
            })

            local SectionTitle = Create("TextLabel", {
                Name = "SectionTitle",
                Parent = SectionFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0, -25),
                Size = UDim2.new(1, -20, 0, 25),
                Text = sectionName,
                TextColor3 = Library.CurrentTheme.Accent,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local function UpdateSectionSize()
                local contentSize = SectionFrame.UIListLayout.AbsoluteContentSize
                SectionFrame.Size = UDim2.new(0.9, 0, 0, contentSize.Y + 40)
                Page.CanvasSize = UDim2.new(0, 0, 0, Page.UIListLayout.AbsoluteContentSize.Y + 20)
            end

            SectionFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)

            local Section = {
                Frame = SectionFrame
            }
            
            function Section:CreateButton(text, callback)
                local Button = Create("TextButton", {
                    Name = text .. "Button",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 35),
                    AutoButtonColor = false,
                    Text = text,
                    TextColor3 = Library.CurrentTheme.Text,
                    TextSize = 14,
                    Font = Enum.Font.GothamMedium
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)})
                })

                Button.MouseButton1Click:Connect(function()
                    callback()
                    TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Library.CurrentTheme.ElementHover}):Play()
                    wait(0.1)
                    TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Library.CurrentTheme.ElementBackground}):Play()
                end)
                
                return Button
            end

            function Section:CreateToggle(text, default, callback)
                local Toggled = default or false
                local ToggleFrame = Create("Frame", {
                    Name = text .. "Toggle",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 35)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("TextLabel", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -50, 1, 0),
                        Text = text,
                        TextColor3 = Library.CurrentTheme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })

                local ToggleOuter = Create("Frame", {
                    Parent = ToggleFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 34, 0, 18),
                    BackgroundColor3 = Toggled and Library.CurrentTheme.Accent or Color3.fromRGB(50, 50, 50)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(1, 0)})
                })

                local ToggleInner = Create("Frame", {
                    Parent = ToggleOuter,
                    Position = Toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
                    Size = UDim2.new(0, 14, 0, 14),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(1, 0)})
                })

                local Button = Create("TextButton", {
                    Parent = ToggleFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = ""
                })

                Button.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    TweenService:Create(ToggleOuter, TweenInfo.new(0.2), {BackgroundColor3 = Toggled and Library.CurrentTheme.Accent or Color3.fromRGB(50, 50, 50)}):Play()
                    TweenService:Create(ToggleInner, TweenInfo.new(0.2), {Position = Toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
                    callback(Toggled)
                end)

                return {
                    Set = function(val)
                        Toggled = val
                        TweenService:Create(ToggleOuter, TweenInfo.new(0.2), {BackgroundColor3 = Toggled and Library.CurrentTheme.Accent or Color3.fromRGB(50, 50, 50)}):Play()
                        TweenService:Create(ToggleInner, TweenInfo.new(0.2), {Position = Toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
                        callback(Toggled)
                    end
                }
            end

            function Section:CreateSlider(text, min, max, default, callback)
                local Value = default or min
                local SliderFrame = Create("Frame", {
                    Name = text .. "Slider",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 50)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("TextLabel", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 5),
                        Size = UDim2.new(1, -20, 0, 20),
                        Text = text,
                        TextColor3 = Library.CurrentTheme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })

                local ValueLabel = Create("TextLabel", {
                    Parent = SliderFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -60, 0, 5),
                    Size = UDim2.new(0, 50, 0, 20),
                    Text = tostring(Value),
                    TextColor3 = Library.CurrentTheme.TextSecondary,
                    TextSize = 14,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Right
                })

                local SliderOuter = Create("Frame", {
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 10, 0, 35),
                    Size = UDim2.new(1, -20, 0, 6),
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(1, 0)})
                })

                local SliderInner = Create("Frame", {
                    Parent = SliderOuter,
                    Size = UDim2.new((Value - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Library.CurrentTheme.Accent
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(1, 0)})
                })

                local SliderButton = Create("TextButton", {
                    Parent = SliderOuter,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = ""
                })

                local function UpdateSlider()
                    local mousePos = UserInputService:GetMouseLocation().X
                    local sliderPos = SliderOuter.AbsolutePosition.X
                    local sliderWidth = SliderOuter.AbsoluteSize.X
                    local percent = math.clamp((mousePos - sliderPos) / sliderWidth, 0, 1)
                    Value = math.floor(min + (max - min) * percent)
                    ValueLabel.Text = tostring(Value)
                    SliderInner.Size = UDim2.new(percent, 0, 1, 0)
                    callback(Value)
                end

                local dragging = false
                SliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        UpdateSlider()
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider()
                    end
                end)

                return {
                    Set = function(val)
                        Value = val
                        ValueLabel.Text = tostring(Value)
                        SliderInner.Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)
                        callback(Value)
                    end
                }
            end

            function Section:CreateInput(text, placeholder, callback)
                local InputFrame = Create("Frame", {
                    Name = text .. "Input",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 40)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("TextLabel", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 100, 1, 0),
                        Text = text,
                        TextColor3 = Library.CurrentTheme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })

                local TextBox = Create("TextBox", {
                    Parent = InputFrame,
                    BackgroundTransparency = 0,
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                    Position = UDim2.new(1, -160, 0.5, -12),
                    Size = UDim2.new(0, 150, 0, 24),
                    Text = "",
                    PlaceholderText = placeholder,
                    TextColor3 = Library.CurrentTheme.Text,
                    PlaceholderColor3 = Library.CurrentTheme.TextSecondary,
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 4)})
                })

                TextBox.FocusLost:Connect(function(enterPressed)
                    callback(TextBox.Text)
                end)

                return TextBox
            end

            function Section:CreateDropdown(text, list, callback)
                local DropdownFrame = Create("Frame", {
                    Name = text .. "Dropdown",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 40),
                    ClipsDescendants = true
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("TextLabel", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -40, 0, 40),
                        Text = text,
                        TextColor3 = Library.CurrentTheme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })

                local DropdownButton = Create("TextButton", {
                    Parent = DropdownFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 40),
                    Text = ""
                })

                local ListFrame = Create("Frame", {
                    Parent = DropdownFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 40),
                    Size = UDim2.new(1, 0, 0, 0)
                }, {
                    Create("UIListLayout", {Padding = UDim.new(0, 2)})
                })

                local toggled = false
                DropdownButton.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    local targetSize = toggled and UDim2.new(0.95, 0, 0, 40 + ListFrame.UIListLayout.AbsoluteContentSize.Y + 10) or UDim2.new(0.95, 0, 0, 40)
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
                end)

                for _, item in pairs(list) do
                    local ItemButton = Create("TextButton", {
                        Parent = ListFrame,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 30),
                        Text = item,
                        TextColor3 = Library.CurrentTheme.TextSecondary,
                        TextSize = 13,
                        Font = Enum.Font.Gotham
                    })

                    ItemButton.MouseButton1Click:Connect(function()
                        callback(item)
                        toggled = false
                        TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {Size = UDim2.new(0.95, 0, 0, 40)}):Play()
                    end)
                end

                return DropdownFrame
            end

            function Section:CreateParagraph(title, content)
                local ParagraphFrame = Create("Frame", {
                    Name = title .. "Paragraph",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 60)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 5),
                        Size = UDim2.new(1, -20, 0, 20),
                        Text = title,
                        TextColor3 = Library.CurrentTheme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamBold,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    Create("TextLabel", {
                        Name = "Content",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 25),
                        Size = UDim2.new(1, -20, 0, 30),
                        Text = content,
                        TextColor3 = Library.CurrentTheme.TextSecondary,
                        TextSize = 13,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        TextYAlignment = Enum.TextYAlignment.Top
                    })
                })

                local function UpdateParagraphSize()
                    local textHeight = game:GetService("TextService"):GetTextSize(content, 13, Enum.Font.Gotham, Vector2.new(ParagraphFrame.AbsoluteSize.X - 20, 1000)).Y
                    ParagraphFrame.Size = UDim2.new(0.95, 0, 0, textHeight + 40)
                end

                ParagraphFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateParagraphSize)
                UpdateParagraphSize()

                return {
                    Set = function(newTitle, newContent)
                        ParagraphFrame.Title.Text = newTitle
                        ParagraphFrame.Content.Text = newContent
                        content = newContent
                        UpdateParagraphSize()
                    end
                }
            end

            function Section:CreateKeybind(text, default, callback)
                local Key = default or Enum.KeyCode.E
                local KeybindFrame = Create("Frame", {
                    Name = text .. "Keybind",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 35)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("TextLabel", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -100, 1, 0),
                        Text = text,
                        TextColor3 = Library.CurrentTheme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })

                local KeyLabel = Create("TextLabel", {
                    Parent = KeybindFrame,
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 60, 0, 24),
                    Text = Key.Name,
                    TextColor3 = Library.CurrentTheme.Text,
                    TextSize = 13,
                    Font = Enum.Font.Gotham
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 4)})
                })

                local Binding = false
                local Button = Create("TextButton", {
                    Parent = KeybindFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = ""
                })

                Button.MouseButton1Click:Connect(function()
                    Binding = true
                    KeyLabel.Text = "..."
                end)

                UserInputService.InputBegan:Connect(function(input)
                    if Binding and input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = input.KeyCode
                        KeyLabel.Text = Key.Name
                        Binding = false
                        callback(Key)
                    elseif not Binding and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Key then
                        callback(Key)
                    end
                end)

                return {
                    Set = function(newKey)
                        Key = newKey
                        KeyLabel.Text = Key.Name
                    end
                }
            end

            function Section:CreateColorpicker(text, default, callback)
                local Color = default or Color3.fromRGB(255, 255, 255)
                local ColorpickerFrame = Create("Frame", {
                    Name = text .. "Colorpicker",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 35)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("TextLabel", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -50, 1, 0),
                        Text = text,
                        TextColor3 = Library.CurrentTheme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })

                local ColorDisplay = Create("Frame", {
                    Parent = ColorpickerFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 30, 0, 20),
                    BackgroundColor3 = Color
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 4)})
                })

                -- Simplified Colorpicker: In real lib, you'd want a full RGB/HSV picker popup
                local Button = Create("TextButton", {
                    Parent = ColorpickerFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = ""
                })

                Button.MouseButton1Click:Connect(function()
                    -- This would open a Dialog with a color picker
                    -- For now, let's just cycle some colors or use a placeholder
                    print("Colorpicker clicked for: " .. text)
                end)

                return {
                    Set = function(newColor)
                        Color = newColor
                        ColorDisplay.BackgroundColor3 = Color
                        callback(Color)
                    end
                }
            end

            function Section:CreateCode(title, code)
                local CodeFrame = Create("Frame", {
                    Name = title .. "Code",
                    Parent = SectionFrame,
                    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                    Size = UDim2.new(0.95, 0, 0, 100)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
                    Create("UIStroke", {Color = Library.CurrentTheme.Border, Thickness = 1}),
                    Create("ScrollingFrame", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 10),
                        Size = UDim2.new(1, -20, 1, -20),
                        ScrollBarThickness = 2,
                        CanvasSize = UDim2.new(0, 0, 0, 0)
                    }, {
                        Create("TextLabel", {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 1, 0),
                            Text = code,
                            TextColor3 = Color3.fromRGB(200, 200, 200),
                            TextSize = 12,
                            Font = Enum.Font.Code,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextYAlignment = Enum.TextYAlignment.Top,
                            RichText = true
                        })
                    })
                })
                return CodeFrame
            end

            function Section:CreateAdvanced(text, callback)
                -- Placeholder for advanced/custom elements
                local AdvancedFrame = Create("Frame", {
                    Name = text .. "Advanced",
                    Parent = SectionFrame,
                    BackgroundColor3 = Library.CurrentTheme.ElementBackground,
                    Size = UDim2.new(0.95, 0, 0, 40)
                }, {
                    Create("UICorner", {CornerRadius = UDim.new(0, 6)})
                })
                callback(AdvancedFrame)
                return AdvancedFrame
            end

            return Section
        end

        return Tab
    end

    function Window:CreateDialog(options)
        options = options or {}
        local title = options.Title or "Dialog"
        local content = options.Content or "Are you sure?"
        local buttons = options.Buttons or {{Text = "Confirm", Callback = function() end}, {Text = "Cancel", Callback = function() end}}

        local Overlay = Create("Frame", {
            Name = "DialogOverlay",
            Parent = ScreenGui,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.5,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 100
        })

        local DialogFrame = Create("Frame", {
            Name = "DialogFrame",
            Parent = Overlay,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 300, 0, 150),
            BackgroundColor3 = Library.CurrentTheme.MainBackground,
            ZIndex = 101
        }, {
            Create("UICorner", {CornerRadius = UDim.new(0, 8)}),
            Create("UIStroke", {Color = Library.CurrentTheme.Border, Thickness = 1})
        })

        Create("TextLabel", {
            Parent = DialogFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 15, 0, 10),
            Size = UDim2.new(1, -30, 0, 30),
            Text = title,
            TextColor3 = Library.CurrentTheme.Text,
            TextSize = 18,
            Font = Enum.Font.GothamBold,
            ZIndex = 102
        })

        Create("TextLabel", {
            Parent = DialogFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 15, 0, 45),
            Size = UDim2.new(1, -30, 0, 50),
            Text = content,
            TextColor3 = Library.CurrentTheme.TextSecondary,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            TextWrapped = true,
            ZIndex = 102
        })

        local ButtonContainer = Create("Frame", {
            Parent = DialogFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 1, -45),
            Size = UDim2.new(1, -20, 0, 35),
            ZIndex = 102
        }, {
            Create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), HorizontalAlignment = Enum.HorizontalAlignment.Center})
        })

        for _, btn in pairs(buttons) do
            local Button = Create("TextButton", {
                Parent = ButtonContainer,
                BackgroundColor3 = btn.Primary and Library.CurrentTheme.Accent or Library.CurrentTheme.ElementBackground,
                Size = UDim2.new(0, 100, 1, 0),
                Text = btn.Text,
                TextColor3 = Library.CurrentTheme.Text,
                TextSize = 14,
                Font = Enum.Font.GothamMedium,
                ZIndex = 103
            }, {
                Create("UICorner", {CornerRadius = UDim.new(0, 6)})
            })

            Button.MouseButton1Click:Connect(function()
                btn.Callback()
                Overlay:Destroy()
            end)
        end
    end

    return Window
end

function Library:Notify(options)
    options = options or {}
    local title = options.Title or "Notification"
    local content = options.Content or "This is a notification."
    local duration = options.Duration or 5
    local type = options.Type or "Info" -- Info, Success, Error, Warning

    local NotifyGui = CoreGui:FindFirstChild("ManusNotifications") or Create("ScreenGui", {Name = "ManusNotifications", Parent = CoreGui})
    local NotifyContainer = NotifyGui:FindFirstChild("Container") or Create("Frame", {
        Name = "Container",
        Parent = NotifyGui,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -310, 0, 20),
        Size = UDim2.new(0, 300, 1, -40)
    }, {
        Create("UIListLayout", {VerticalAlignment = Enum.VerticalAlignment.Bottom, Padding = UDim.new(0, 10)})
    })

    local color = self.CurrentTheme[type] or self.CurrentTheme.Info

    local Notification = Create("Frame", {
        Name = "Notification",
        Parent = NotifyContainer,
        BackgroundColor3 = self.CurrentTheme.NotificationBackground,
        Size = UDim2.new(1, 0, 0, 70),
        Position = UDim2.new(1, 10, 0, 0)
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 6)}),
        Create("UIStroke", {Color = color, Thickness = 1}),
        Create("Frame", { -- Side bar color
            Size = UDim2.new(0, 4, 1, 0),
            BackgroundColor3 = color,
            BorderSizePixel = 0
        }, {
            Create("UICorner", {CornerRadius = UDim.new(0, 6)})
        }),
        Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 15, 0, 10),
            Size = UDim2.new(1, -30, 0, 20),
            Text = title,
            TextColor3 = color,
            TextSize = 14,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        Create("TextLabel", {
            Name = "Content",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 15, 0, 30),
            Size = UDim2.new(1, -30, 0, 30),
            Text = content,
            TextColor3 = self.CurrentTheme.TextSecondary,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        })
    })

    TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    
    task.delay(duration, function()
        TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 0, 0)}):Play()
        wait(0.5)
        Notification:Destroy()
    end)
end

function Library:CreateTag(parent, text, color)
    local Tag = Create("Frame", {
        Name = text .. "Tag",
        Parent = parent,
        BackgroundColor3 = color or self.CurrentTheme.Accent,
        Size = UDim2.new(0, 0, 0, 20),
        AutomaticSize = Enum.AutomaticSize.X
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 4)}),
        Create("TextLabel", {
            BackgroundTransparency = 1,
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            Size = UDim2.new(1, 0, 1, 0),
            Text = text,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 11,
            Font = Enum.Font.GothamBold
        })
    })
    return Tag
end

return Library
