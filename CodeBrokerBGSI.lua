local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Цветовая схема
local COLORS = {
    background = Color3.fromRGB(40, 40, 40),
    header = Color3.fromRGB(76, 118, 186),
    accent = Color3.fromRGB(76, 118, 186),
    text = Color3.fromRGB(255, 255, 255),
    disabled = Color3.fromRGB(100, 100, 100),
    tab_selected = Color3.fromRGB(60, 60, 60),
    tab_unselected = Color3.fromRGB(30, 30, 30)
}

local player = Players.LocalPlayer
local bubbleRemote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote")

-- Настройки окна
local config = {
    width = 400,
    height = 437,
    cornerRadius = 12
}

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuckyCC"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, config.width, 0, config.height)
MainFrame.Position = UDim2.new(0.8, 0, 0.3, 0)
MainFrame.BackgroundColor3 = COLORS.background
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, config.cornerRadius)
UICorner.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = COLORS.header
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, config.cornerRadius)
TitleBarCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Text = "lucky.cc"
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = COLORS.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2
Title.Parent = TitleBar

-- Кнопки управления
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "_"
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -61, 0.5, -12)
MinimizeButton.BackgroundColor3 = COLORS.accent
MinimizeButton.TextColor3 = COLORS.text
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.ZIndex = 3
MinimizeButton.Parent = TitleBar

local MinimizeButtonCorner = Instance.new("UICorner")
MinimizeButtonCorner.CornerRadius = UDim.new(0, 6)
MinimizeButtonCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "×"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -31, 0.5, -12)
CloseButton.BackgroundColor3 = COLORS.accent
CloseButton.TextColor3 = COLORS.text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.ZIndex = 3
CloseButton.Parent = TitleBar

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 6)
CloseButtonCorner.Parent = CloseButton

-- Боковая панель для вкладок
local TabPanel = Instance.new("Frame")
TabPanel.Size = UDim2.new(0, 50, 1, -30)
TabPanel.Position = UDim2.new(0, 0, 0, 30)
TabPanel.BackgroundColor3 = COLORS.tab_unselected
TabPanel.ZIndex = 2
TabPanel.Parent = MainFrame

local TabPanelCorner = Instance.new("UICorner")
TabPanelCorner.CornerRadius = UDim.new(0, config.cornerRadius)
TabPanelCorner.Parent = TabPanel

-- Контейнер для вкладок
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -50, 1, -30)
ContentFrame.Position = UDim2.new(0, 50, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 1
ContentFrame.Parent = MainFrame

-- Вкладки
local HomeTab = Instance.new("Frame")
HomeTab.Size = UDim2.new(1, 0, 1, 0)
HomeTab.BackgroundTransparency = 1
HomeTab.Visible = true
HomeTab.Parent = ContentFrame

local FarmTab = Instance.new("Frame")
FarmTab.Size = UDim2.new(1, 0, 1, 0)
FarmTab.BackgroundTransparency = 1
FarmTab.Visible = false
FarmTab.Parent = ContentFrame

local MiscTab = Instance.new("Frame")
MiscTab.Size = UDim2.new(1, 0, 1, 0)
MiscTab.BackgroundTransparency = 1
MiscTab.Visible = false
MiscTab.Parent = ContentFrame

-- Кнопки вкладок
local HomeTabButton = Instance.new("TextButton")
HomeTabButton.Size = UDim2.new(1, 0, 0, 25)
HomeTabButton.Position = UDim2.new(0, 0, 0, 30)
HomeTabButton.BackgroundColor3 = COLORS.tab_selected
HomeTabButton.Text = "Home"
HomeTabButton.TextColor3 = COLORS.text
HomeTabButton.Font = Enum.Font.GothamBold
HomeTabButton.TextSize = 12
HomeTabButton.ZIndex = 3
HomeTabButton.Parent = TabPanel

local FarmTabButton = Instance.new("TextButton")
FarmTabButton.Size = UDim2.new(1, 0, 0, 25)
FarmTabButton.Position = UDim2.new(0, 0, 0, 55)
FarmTabButton.BackgroundColor3 = COLORS.tab_unselected
FarmTabButton.Text = "Farm"
FarmTabButton.TextColor3 = COLORS.text
FarmTabButton.Font = Enum.Font.GothamBold
FarmTabButton.TextSize = 12
FarmTabButton.ZIndex = 3
FarmTabButton.Parent = TabPanel

local MiscTabButton = Instance.new("TextButton")
MiscTabButton.Size = UDim2.new(1, 0, 0, 25)
MiscTabButton.Position = UDim2.new(0, 0, 0, 80)
MiscTabButton.BackgroundColor3 = COLORS.tab_unselected
MiscTabButton.Text = "Misc"
MiscTabButton.TextColor3 = COLORS.text
MiscTabButton.Font = Enum.Font.GothamBold
MiscTabButton.TextSize = 12
MiscTabButton.ZIndex = 3
MiscTabButton.Parent = TabPanel

-- Вкладка Home: WalkSpeed Slider
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Size = UDim2.new(1, -20, 0, 50)
WalkSpeedFrame.Position = UDim2.new(0, 10, 0, 10)
WalkSpeedFrame.BackgroundTransparency = 1
WalkSpeedFrame.ZIndex = 1
WalkSpeedFrame.Parent = HomeTab

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Text = "WalkSpeed: 16"
WalkSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.TextColor3 = COLORS.text
WalkSpeedLabel.Font = Enum.Font.Gotham
WalkSpeedLabel.TextSize = 14
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedLabel.ZIndex = 1
WalkSpeedLabel.Parent = WalkSpeedFrame

local WalkSpeedSliderTrack = Instance.new("TextButton")
WalkSpeedSliderTrack.Size = UDim2.new(1, 0, 0, 6)
WalkSpeedSliderTrack.Position = UDim2.new(0, 0, 0, 30)
WalkSpeedSliderTrack.BackgroundColor3 = COLORS.disabled
WalkSpeedSliderTrack.Text = ""
WalkSpeedSliderTrack.ZIndex = 1
WalkSpeedSliderTrack.Parent = WalkSpeedFrame

local WalkSpeedTrackCorner = Instance.new("UICorner")
WalkSpeedTrackCorner.CornerRadius = UDim.new(1, 0)
WalkSpeedTrackCorner.Parent = WalkSpeedSliderTrack

local WalkSpeedSliderFill = Instance.new("Frame")
WalkSpeedSliderFill.Size = UDim2.new(0.032, 0, 1, 0)
WalkSpeedSliderFill.BackgroundColor3 = COLORS.accent
WalkSpeedSliderFill.ZIndex = 2
WalkSpeedSliderFill.Parent = WalkSpeedSliderTrack

local WalkSpeedFillCorner = Instance.new("UICorner")
WalkSpeedFillCorner.CornerRadius = UDim.new(1, 0)
WalkSpeedFillCorner.Parent = WalkSpeedSliderFill

local WalkSpeedSliderButton = Instance.new("TextButton")
WalkSpeedSliderButton.Size = UDim2.new(0, 16, 0, 16)
WalkSpeedSliderButton.Position = UDim2.new(0.032, -8, 0.5, -8)
WalkSpeedSliderButton.BackgroundColor3 = COLORS.text
WalkSpeedSliderButton.Text = ""
WalkSpeedSliderButton.ZIndex = 3
WalkSpeedSliderButton.Parent = WalkSpeedSliderTrack

local WalkSpeedSliderButtonCorner = Instance.new("UICorner")
WalkSpeedSliderButtonCorner.CornerRadius = UDim.new(1, 0)
WalkSpeedSliderButtonCorner.Parent = WalkSpeedSliderButton

-- Вкладка Home: Infinite Jump Toggle
local InfiniteJumpFrame = Instance.new("Frame")
InfiniteJumpFrame.Size = UDim2.new(1, -20, 0, 30)
InfiniteJumpFrame.Position = UDim2.new(0, 10, 0, 70)
InfiniteJumpFrame.BackgroundTransparency = 1
InfiniteJumpFrame.ZIndex = 1
InfiniteJumpFrame.Parent = HomeTab

local InfiniteJumpToggle = Instance.new("TextButton")
InfiniteJumpToggle.Size = UDim2.new(0, 22, 0, 22)
InfiniteJumpToggle.Position = UDim2.new(0, 0, 0.5, -11)
InfiniteJumpToggle.BackgroundColor3 = COLORS.disabled
InfiniteJumpToggle.Text = ""
InfiniteJumpToggle.ZIndex = 2
InfiniteJumpToggle.Parent = InfiniteJumpFrame

local InfiniteJumpToggleCorner = Instance.new("UICorner")
InfiniteJumpToggleCorner.CornerRadius = UDim.new(0, 6)
InfiniteJumpToggleCorner.Parent = InfiniteJumpToggle

local InfiniteJumpLabel = Instance.new("TextLabel")
InfiniteJumpLabel.Text = "Infinite Jump"
InfiniteJumpLabel.Size = UDim2.new(1, -30, 1, 0)
InfiniteJumpLabel.Position = UDim2.new(0, 30, 0, 0)
InfiniteJumpLabel.BackgroundTransparency = 1
InfiniteJumpLabel.TextColor3 = COLORS.text
InfiniteJumpLabel.Font = Enum.Font.Gotham
InfiniteJumpLabel.TextSize = 14
InfiniteJumpLabel.TextXAlignment = Enum.TextXAlignment.Left
InfiniteJumpLabel.ZIndex = 1
InfiniteJumpLabel.Parent = InfiniteJumpFrame

-- Вкладка Farm: Auto Blow Bubble
local AutoBubbleFrame = Instance.new("Frame")
AutoBubbleFrame.Size = UDim2.new(1, -20, 0, 30)
AutoBubbleFrame.Position = UDim2.new(0, 10, 0, 10)
AutoBubbleFrame.BackgroundTransparency = 1
AutoBubbleFrame.ZIndex = 1
AutoBubbleFrame.Parent = FarmTab

local AutoBubbleToggle = Instance.new("TextButton")
AutoBubbleToggle.Size = UDim2.new(0, 22, 0, 22)
AutoBubbleToggle.Position = UDim2.new(0, 0, 0.5, -11)
AutoBubbleToggle.BackgroundColor3 = COLORS.disabled
AutoBubbleToggle.Text = ""
AutoBubbleToggle.ZIndex = 2
AutoBubbleToggle.Parent = AutoBubbleFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = AutoBubbleToggle

local AutoBubbleLabel = Instance.new("TextLabel")
AutoBubbleLabel.Text = "Auto Blow Bubble"
AutoBubbleLabel.Size = UDim2.new(1, -30, 1, 0)
AutoBubbleLabel.Position = UDim2.new(0, 30, 0, 0)
AutoBubbleLabel.BackgroundTransparency = 1
AutoBubbleLabel.TextColor3 = COLORS.text
AutoBubbleLabel.Font = Enum.Font.Gotham
AutoBubbleLabel.TextSize = 14
AutoBubbleLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoBubbleLabel.ZIndex = 1
AutoBubbleLabel.Parent = AutoBubbleFrame

-- Вкладка Farm: Frequency Slider
local FrequencyFrame = Instance.new("Frame")
FrequencyFrame.Size = UDim2.new(1, -20, 0, 50)
FrequencyFrame.Position = UDim2.new(0, 10, 0, 50)
FrequencyFrame.BackgroundTransparency = 1
FrequencyFrame.ZIndex = 1
FrequencyFrame.Parent = FarmTab

local FrequencyLabel = Instance.new("TextLabel")
FrequencyLabel.Text = "Frequency: 0.5s"
FrequencyLabel.Size = UDim2.new(1, 0, 0, 20)
FrequencyLabel.BackgroundTransparency = 1
FrequencyLabel.TextColor3 = COLORS.text
FrequencyLabel.Font = Enum.Font.Gotham
FrequencyLabel.TextSize = 14
FrequencyLabel.TextXAlignment = Enum.TextXAlignment.Left
FrequencyLabel.ZIndex = 1
FrequencyLabel.Parent = FrequencyFrame

local SliderTrack = Instance.new("TextButton")
SliderTrack.Size = UDim2.new(1, 0, 0, 6)
SliderTrack.Position = UDim2.new(0, 0, 0, 30)
SliderTrack.BackgroundColor3 = COLORS.disabled
SliderTrack.Text = ""
SliderTrack.ZIndex = 1
SliderTrack.Parent = FrequencyFrame

local TrackCorner = Instance.new("UICorner")
TrackCorner.CornerRadius = UDim.new(1, 0)
TrackCorner.Parent = SliderTrack

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
SliderFill.BackgroundColor3 = COLORS.accent
SliderFill.ZIndex = 2
SliderFill.Parent = SliderTrack

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = SliderFill

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 16, 0, 16)
SliderButton.Position = UDim2.new(0.5, -8, 0.5, -8)
SliderButton.BackgroundColor3 = COLORS.text
SliderButton.Text = ""
SliderButton.ZIndex = 3
SliderButton.Parent = SliderTrack

local SliderButtonCorner = Instance.new("UICorner")
SliderButtonCorner.CornerRadius = UDim.new(1, 0)
SliderButtonCorner.Parent = SliderButton

-- Вкладка Farm: Auto Sell Bubble
local AutoSellFrame = Instance.new("Frame")
AutoSellFrame.Size = UDim2.new(1, -20, 0, 30)
AutoSellFrame.Position = UDim2.new(0, 10, 0, 110)
AutoSellFrame.BackgroundTransparency = 1
AutoSellFrame.ZIndex = 1
AutoSellFrame.Parent = FarmTab

local AutoSellToggle = Instance.new("TextButton")
AutoSellToggle.Size = UDim2.new(0, 22, 0, 22)
AutoSellToggle.Position = UDim2.new(0, 0, 0.5, -11)
AutoSellToggle.BackgroundColor3 = COLORS.disabled
AutoSellToggle.Text = ""
AutoSellToggle.ZIndex = 2
AutoSellToggle.Parent = AutoSellFrame

local SellToggleCorner = Instance.new("UICorner")
SellToggleCorner.CornerRadius = UDim.new(0, 6)
SellToggleCorner.Parent = AutoSellToggle

local AutoSellLabel = Instance.new("TextLabel")
AutoSellLabel.Text = "Auto Sell Bubble"
AutoSellLabel.Size = UDim2.new(1, -30, 1, 0)
AutoSellLabel.Position = UDim2.new(0, 30, 0, 0)
AutoSellLabel.BackgroundTransparency = 1
AutoSellLabel.TextColor3 = COLORS.text
AutoSellLabel.Font = Enum.Font.Gotham
AutoSellLabel.TextSize = 14
AutoSellLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoSellLabel.ZIndex = 1
AutoSellLabel.Parent = AutoSellFrame

-- Вкладка Farm: Auto Farm Toggle
local AutoFarmFrame = Instance.new("Frame")
AutoFarmFrame.Size = UDim2.new(1, -20, 0, 30)
AutoFarmFrame.Position = UDim2.new(0, 10, 0, 150)
AutoFarmFrame.BackgroundTransparency = 1
AutoFarmFrame.ZIndex = 1
AutoFarmFrame.Parent = FarmTab

local AutoFarmToggle = Instance.new("TextButton")
AutoFarmToggle.Size = UDim2.new(0, 22, 0, 22)
AutoFarmToggle.Position = UDim2.new(0, 0, 0.5, -11)
AutoFarmToggle.BackgroundColor3 = COLORS.disabled
AutoFarmToggle.Text = ""
AutoFarmToggle.ZIndex = 2
AutoFarmToggle.Parent = AutoFarmFrame

local FarmToggleCorner = Instance.new("UICorner")
FarmToggleCorner.CornerRadius = UDim.new(0, 6)
FarmToggleCorner.Parent = AutoFarmToggle

local AutoFarmLabel = Instance.new("TextLabel")
AutoFarmLabel.Text = "Auto Farm"
AutoFarmLabel.Size = UDim2.new(1, -30, 1, 0)
AutoFarmLabel.Position = UDim2.new(0, 30, 0, 0)
AutoFarmLabel.BackgroundTransparency = 1
AutoFarmLabel.TextColor3 = COLORS.text
AutoFarmLabel.Font = Enum.Font.Gotham
AutoFarmLabel.TextSize = 14
AutoFarmLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoFarmLabel.ZIndex = 1
AutoFarmLabel.Parent = AutoFarmFrame

-- Вкладка Farm: Teleport Delay Slider
local TeleportDelayFrame = Instance.new("Frame")
TeleportDelayFrame.Size = UDim2.new(1, -20, 0, 50)
TeleportDelayFrame.Position = UDim2.new(0, 10, 0, 190)
TeleportDelayFrame.BackgroundTransparency = 1
TeleportDelayFrame.ZIndex = 1
TeleportDelayFrame.Parent = FarmTab

local TeleportDelayLabel = Instance.new("TextLabel")
TeleportDelayLabel.Text = "Teleport Delay: 0.1s"
TeleportDelayLabel.Size = UDim2.new(1, 0, 0, 20)
TeleportDelayLabel.BackgroundTransparency = 1
TeleportDelayLabel.TextColor3 = COLORS.text
TeleportDelayLabel.Font = Enum.Font.Gotham
TeleportDelayLabel.TextSize = 14
TeleportDelayLabel.TextXAlignment = Enum.TextXAlignment.Left
TeleportDelayLabel.ZIndex = 1
TeleportDelayLabel.Parent = TeleportDelayFrame

local TeleportDelaySliderTrack = Instance.new("TextButton")
TeleportDelaySliderTrack.Size = UDim2.new(1, 0, 0, 6)
TeleportDelaySliderTrack.Position = UDim2.new(0, 0, 0, 30)
TeleportDelaySliderTrack.BackgroundColor3 = COLORS.disabled
TeleportDelaySliderTrack.Text = ""
TeleportDelaySliderTrack.ZIndex = 1
TeleportDelaySliderTrack.Parent = TeleportDelayFrame

local TeleportDelayTrackCorner = Instance.new("UICorner")
TeleportDelayTrackCorner.CornerRadius = UDim.new(1, 0)
TeleportDelayTrackCorner.Parent = TeleportDelaySliderTrack

local TeleportDelaySliderFill = Instance.new("Frame")
TeleportDelaySliderFill.Size = UDim2.new(0, 0, 1, 0)
TeleportDelaySliderFill.BackgroundColor3 = COLORS.accent
TeleportDelaySliderFill.ZIndex = 2
TeleportDelaySliderFill.Parent = TeleportDelaySliderTrack

local TeleportDelayFillCorner = Instance.new("UICorner")
TeleportDelayFillCorner.CornerRadius = UDim.new(1, 0)
TeleportDelayFillCorner.Parent = TeleportDelaySliderFill

local TeleportDelaySliderButton = Instance.new("TextButton")
TeleportDelaySliderButton.Size = UDim2.new(0, 16, 0, 16)
TeleportDelaySliderButton.Position = UDim2.new(0, -8, 0.5, -8)
TeleportDelaySliderButton.BackgroundColor3 = COLORS.text
TeleportDelaySliderButton.Text = ""
TeleportDelaySliderButton.ZIndex = 3
TeleportDelaySliderButton.Parent = TeleportDelaySliderTrack

local TeleportDelaySliderButtonCorner = Instance.new("UICorner")
TeleportDelaySliderButtonCorner.CornerRadius = UDim.new(1, 0)
TeleportDelaySliderButtonCorner.Parent = TeleportDelaySliderButton

-- Вкладка Misc: Auto Collect Playtime
local AutoCollectFrame = Instance.new("Frame")
AutoCollectFrame.Size = UDim2.new(1, -20, 0, 30)
AutoCollectFrame.Position = UDim2.new(0, 10, 0, 10)
AutoCollectFrame.BackgroundTransparency = 1
AutoCollectFrame.ZIndex = 1
AutoCollectFrame.Parent = MiscTab

local AutoCollectToggle = Instance.new("TextButton")
AutoCollectToggle.Size = UDim2.new(0, 22, 0, 22)
AutoCollectToggle.Position = UDim2.new(0, 0, 0.5, -11)
AutoCollectToggle.BackgroundColor3 = COLORS.disabled
AutoCollectToggle.Text = ""
AutoCollectToggle.ZIndex = 2
AutoCollectToggle.Parent = AutoCollectFrame

local CollectToggleCorner = Instance.new("UICorner")
CollectToggleCorner.CornerRadius = UDim.new(0, 6)
CollectToggleCorner.Parent = AutoCollectToggle

local AutoCollectLabel = Instance.new("TextLabel")
AutoCollectLabel.Text = "Auto Collect Playtime"
AutoCollectLabel.Size = UDim2.new(1, -30, 1, 0)
AutoCollectLabel.Position = UDim2.new(0, 30, 0, 0)
AutoCollectLabel.BackgroundTransparency = 1
AutoCollectLabel.TextColor3 = COLORS.text
AutoCollectLabel.Font = Enum.Font.Gotham
AutoCollectLabel.TextSize = 14
AutoCollectLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoCollectLabel.ZIndex = 1
AutoCollectLabel.Parent = AutoCollectFrame

-- Вкладка Misc: Golden Chest Highlight Toggle
local GoldenChestHighlightFrame = Instance.new("Frame")
GoldenChestHighlightFrame.Size = UDim2.new(1, -20, 0, 30)
GoldenChestHighlightFrame.Position = UDim2.new(0, 10, 0, 50)
GoldenChestHighlightFrame.BackgroundTransparency = 1
GoldenChestHighlightFrame.ZIndex = 1
GoldenChestHighlightFrame.Parent = MiscTab

local GoldenChestHighlightToggle = Instance.new("TextButton")
GoldenChestHighlightToggle.Size = UDim2.new(0, 22, 0, 22)
GoldenChestHighlightToggle.Position = UDim2.new(0, 0, 0.5, -11)
GoldenChestHighlightToggle.BackgroundColor3 = COLORS.disabled
GoldenChestHighlightToggle.Text = ""
GoldenChestHighlightToggle.ZIndex = 2
GoldenChestHighlightToggle.Parent = GoldenChestHighlightFrame

local GoldenChestHighlightToggleCorner = Instance.new("UICorner")
GoldenChestHighlightToggleCorner.CornerRadius = UDim.new(0, 6)
GoldenChestHighlightToggleCorner.Parent = GoldenChestHighlightToggle

local GoldenChestHighlightLabel = Instance.new("TextLabel")
GoldenChestHighlightLabel.Text = "Golden Chest Highlight"
GoldenChestHighlightLabel.Size = UDim2.new(1, -30, 1, 0)
GoldenChestHighlightLabel.Position = UDim2.new(0, 30, 0, 0)
GoldenChestHighlightLabel.BackgroundTransparency = 1
GoldenChestHighlightLabel.TextColor3 = COLORS.text
GoldenChestHighlightLabel.Font = Enum.Font.Gotham
GoldenChestHighlightLabel.TextSize = 14
GoldenChestHighlightLabel.TextXAlignment = Enum.TextXAlignment.Left
GoldenChestHighlightLabel.ZIndex = 1
GoldenChestHighlightLabel.Parent = GoldenChestHighlightFrame

-- Вкладка Misc: Black-Market (Need Mastery) Toggle
local BlackMarketFrame = Instance.new("Frame")
BlackMarketFrame.Size = UDim2.new(1, -20, 0, 30)
BlackMarketFrame.Position = UDim2.new(0, 10, 0, 90)
BlackMarketFrame.BackgroundTransparency = 1
BlackMarketFrame.ZIndex = 1
BlackMarketFrame.Parent = MiscTab

local BlackMarketToggle = Instance.new("TextButton")
BlackMarketToggle.Size = UDim2.new(0, 22, 0, 22)
BlackMarketToggle.Position = UDim2.new(0, 0, 0.5, -11)
BlackMarketToggle.BackgroundColor3 = COLORS.disabled
BlackMarketToggle.Text = ""
BlackMarketToggle.ZIndex = 2
BlackMarketToggle.Parent = BlackMarketFrame

local BlackMarketToggleCorner = Instance.new("UICorner")
BlackMarketToggleCorner.CornerRadius = UDim.new(0, 6)
BlackMarketToggleCorner.Parent = BlackMarketToggle

local BlackMarketLabel = Instance.new("TextLabel")
BlackMarketLabel.Text = "Black-Market (Need Mastery)"
BlackMarketLabel.Size = UDim2.new(1, -30, 1, 0)
BlackMarketLabel.Position = UDim2.new(0, 30, 0, 0)
BlackMarketLabel.BackgroundTransparency = 1
BlackMarketLabel.TextColor3 = COLORS.text
BlackMarketLabel.Font = Enum.Font.Gotham
BlackMarketLabel.TextSize = 14
BlackMarketLabel.TextXAlignment = Enum.TextXAlignment.Left
BlackMarketLabel.ZIndex = 1
BlackMarketLabel.Parent = BlackMarketFrame

-- Вкладка Misc: Alien-Shop Toggle
local AlienShopFrame = Instance.new("Frame")
AlienShopFrame.Size = UDim2.new(1, -20, 0, 30)
AlienShopFrame.Position = UDim2.new(0, 10, 0, 130)
AlienShopFrame.BackgroundTransparency = 1
AlienShopFrame.ZIndex = 1
AlienShopFrame.Parent = MiscTab

local AlienShopToggle = Instance.new("TextButton")
AlienShopToggle.Size = UDim2.new(0, 22, 0, 22)
AlienShopToggle.Position = UDim2.new(0, 0, 0.5, -11)
AlienShopToggle.BackgroundColor3 = COLORS.disabled
AlienShopToggle.Text = ""
AlienShopToggle.ZIndex = 2
AlienShopToggle.Parent = AlienShopFrame

local AlienShopToggleCorner = Instance.new("UICorner")
AlienShopToggleCorner.CornerRadius = UDim.new(0, 6)
AlienShopToggleCorner.Parent = AlienShopToggle

local AlienShopLabel = Instance.new("TextLabel")
AlienShopLabel.Text = "Alien-Shop"
AlienShopLabel.Size = UDim2.new(1, -30, 1, 0)
AlienShopLabel.Position = UDim2.new(0, 30, 0, 0)
AlienShopLabel.BackgroundTransparency = 1
AlienShopLabel.TextColor3 = COLORS.text
AlienShopLabel.Font = Enum.Font.Gotham
AlienShopLabel.TextSize = 14
AlienShopLabel.TextXAlignment = Enum.TextXAlignment.Left
AlienShopLabel.ZIndex = 1
AlienShopLabel.Parent = AlienShopFrame

-- Переменные
local autoBubbleEnabled = false
local autoSellEnabled = false
local autoCollectEnabled = false
local autoFarmEnabled = false
local infiniteJumpEnabled = false
local goldenChestHighlightEnabled = false
local blackMarketEnabled = false
local alienShopEnabled = false
local bubbleCooldown = 0.5
local teleportDelay = 0.1
local walkSpeed = 16
local isDragging = false
local isDraggingTeleport = false
local isDraggingWalkSpeed = false
local isMinimized = false
local isDraggingWindow = false
local startPos = nil
local dragStart = nil
local scriptActive = true
local goldenChestHighlights = {}

-- Список объектов для подсветки
local goldenChestPaths = {
    "workspace.Rendered.Rifts['golden-chest'].Chest.Decoration.Bottom",
    "workspace.Rendered.Rifts['golden-chest'].Chest.Decoration.Coins",
    "workspace.Rendered.Rifts['golden-chest'].Chest.Decoration.Top",
    "workspace.Rendered.Rifts['golden-chest'].Chest['golden-chest']"
}

-- Настройки автофарма
local bannedParts = {
    ["workspace.Stages:GetChildren()[35].Trampoline.Root"] = true
}

-- Анимации
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Функция переключения вкладок
local function switchTab(selectedTab, selectedButton)
    HomeTab.Visible = selectedTab == HomeTab
    FarmTab.Visible = selectedTab == FarmTab
    MiscTab.Visible = selectedTab == MiscTab
    HomeTabButton.BackgroundColor3 = selectedTab == HomeTab and COLORS.tab_selected or COLORS.tab_unselected
    FarmTabButton.BackgroundColor3 = selectedTab == FarmTab and COLORS.tab_selected or COLORS.tab_unselected
    MiscTabButton.BackgroundColor3 = selectedTab == MiscTab and COLORS.tab_selected or COLORS.tab_unselected
end

-- Функция для получения объекта по пути
local function getObjectFromPath(path)
    local success, result = pcall(function()
        local current = game
        for part in path:gmatch("[^%.%[%]]+") do
            if part:match("^%['.-'%]$") then
                local key = part:match("%['(.-)'%]")
                current = current[key]
            else
                current = current[part]
            end
        end
        return current
    end)
    if success and result and result:IsDescendantOf(game) then
        return result
    end
    return nil
end

-- Функция для создания подсветки
local function createHighlight(object)
    if not object then return nil end
    local highlight = Instance.new("Highlight")
    highlight.Name = "GoldenChestHighlight"
    highlight.Adornee = object
    highlight.FillColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.8
    highlight.OutlineColor = Color3.fromRGB(255, 165, 0)
    highlight.OutlineTransparency = 0
    highlight.Parent = object
    return highlight
end

-- Функция для управления подсветкой Golden Chest
local function manageGoldenChestHighlight(enabled)
    for _, highlight in pairs(goldenChestHighlights) do
        if highlight and highlight.Parent then
            highlight.Enabled = enabled
        end
    end

    if not enabled then
        return
    end

    local anyObjectFound = false
    for _, path in ipairs(goldenChestPaths) do
        if not goldenChestHighlights[path] or not goldenChestHighlights[path].Parent then
            local object = getObjectFromPath(path)
            if object then
                anyObjectFound = true
                local highlight = createHighlight(object)
                if highlight then
                    goldenChestHighlights[path] = highlight
                    highlight.Enabled = true
                    print("Highlight created for: " .. path)
                end
            end
        else
            anyObjectFound = true
        end
    end

    if not anyObjectFound then
        warn("No Golden Chest objects found. Retrying...")
        task.spawn(function()
            while scriptActive and enabled and not anyObjectFound do
                for _, path in ipairs(goldenChestPaths) do
                    if not goldenChestHighlights[path] or not goldenChestHighlights[path].Parent then
                        local object = getObjectFromPath(path)
                        if object then
                            local highlight = createHighlight(object)
                            if highlight then
                                goldenChestHighlights[path] = highlight
                                highlight.Enabled = true
                                print("Highlight created for: " .. path)
                                anyObjectFound = true
                            end
                        end
                    end
                end
                if anyObjectFound then
                    break
                end
                task.wait(1)
            end
        end)
    end
end

-- Функция для покупки в Black-Market
local function buyBlackMarket()
    print("Attempting to buy all Black-Market items")
    for i = 1, 3 do
        local success, error = pcall(function()
            local args = {
                [1] = "BuyShopItem",
                [2] = "shard-shop",
                [3] = i
            }
            bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
        end)
        if not success then
            warn("Failed to buy Black-Market item " .. i .. ": " .. tostring(error))
        else
            print("Black-Market item " .. i .. " purchased successfully")
        end
        task.wait(0.1) -- Небольшая задержка между покупками
    end
end

-- Функция для покупки в Alien-Shop
local function buyAlienShop()
    print("Attempting to buy all Alien-Shop items")
    for i = 1, 3 do
        local success, error = pcall(function()
            local args = {
                [1] = "BuyShopItem",
                [2] = "alien-shop",
                [3] = i
            }
            bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
        end)
        if not success then
            warn("Failed to buy Alien-Shop item " .. i .. ": " .. tostring(error))
        else
            print("Alien-Shop item " .. i .. " purchased successfully")
        end
        task.wait(0.1) -- Небольшая задержка между покупками
    end
end

-- Обработчик переключателя Golden Chest Highlight
GoldenChestHighlightToggle.MouseButton1Click:Connect(function()
    goldenChestHighlightEnabled = not goldenChestHighlightEnabled
    print("Golden Chest Highlight toggled to: " .. tostring(goldenChestHighlightEnabled))
    local tween = TweenService:Create(GoldenChestHighlightToggle, tweenInfo, {
        BackgroundColor3 = goldenChestHighlightEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
    manageGoldenChestHighlight(goldenChestHighlightEnabled)
end)

-- Обработчик переключателя Black-Market
BlackMarketToggle.MouseButton1Click:Connect(function()
    blackMarketEnabled = not blackMarketEnabled
    print("Black-Market toggled to: " .. tostring(blackMarketEnabled))
    local tween = TweenService:Create(BlackMarketToggle, tweenInfo, {
        BackgroundColor3 = blackMarketEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
end)

-- Обработчик переключателя Alien-Shop
AlienShopToggle.MouseButton1Click:Connect(function()
    alienShopEnabled = not alienShopEnabled
    print("Alien-Shop toggled to: " .. tostring(alienShopEnabled))
    local tween = TweenService:Create(AlienShopToggle, tweenInfo, {
        BackgroundColor3 = alienShopEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
end)

-- Обработчики кнопок вкладок
HomeTabButton.MouseButton1Click:Connect(function()
    switchTab(HomeTab, HomeTabButton)
end)

FarmTabButton.MouseButton1Click:Connect(function()
    switchTab(FarmTab, FarmTabButton)
end)

MiscTabButton.MouseButton1Click:Connect(function()
    switchTab(MiscTab, MiscTabButton)
end)

-- Функция надутия пузыря
local function blowBubble()
    print("Attempting to blow bubble")
    local success, error = pcall(function()
        bubbleRemote:WaitForChild("Event"):FireServer("BlowBubble")
    end)
    if not success then
        warn("Failed to blow bubble: " .. tostring(error))
    else
        print("Bubble blown successfully")
    end
end

-- Функция продажи пузыря
local function sellBubble()
    print("Attempting to sell bubble")
    local success, error = pcall(function()
        local args = { [1] = "SellBubble" }
        bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
    end)
    if not success then
        warn("Failed to sell bubble: " .. tostring(error))
    else
        print("Bubble sold successfully")
    end
end

-- Функция сбора игрового времени
local function collectPlaytime()
    print("Attempting to collect all playtime rewards")
    for i = 1, 9 do
        local success, error = pcall(function()
            local args = {
                [1] = "ClaimPlaytime",
                [2] = i
            }
            bubbleRemote:WaitForChild("Function"):InvokeServer(unpack(args))
        end)
        if not success then
            warn("Failed to collect playtime for amount " .. i .. ": " .. tostring(error))
        else
            print("Playtime collected successfully for amount " .. i)
        end
        task.wait(0.1) -- Небольшая задержка между вызовами
    end
end

-- Функция для проверки запрещенных частей
local function isBannedPart(part)
    local fullName = part:GetFullName()
    return bannedParts[fullName] or false
end

-- Функция для плавного перемещения
local function tweenPosition(object, newCFrame, duration)
    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    local tween = TweenService:Create(object, tweenInfo, {CFrame = newCFrame})
    tween:Play()
    return tween
end

-- Функция автофарма
local function farmCollectibles()
    while autoFarmEnabled and scriptActive do
        local targetFolder = workspace.Rendered:GetChildren()[12]
        if not targetFolder then
            print("Error: Folder not found")
            task.wait(0.3)
            continue
        end

        local teleportTargets = {}
        for _, child in ipairs(targetFolder:GetDescendants()) do
            if child:IsA("BasePart") and not isBannedPart(child) then
                table.insert(teleportTargets, child)
            end
        end

        if #teleportTargets == 0 then
            print("No valid objects")
            task.wait(1)
            continue
        end

        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        while autoFarmEnabled and scriptActive and #teleportTargets > 0 do
            local closestTarget = nil
            local closestDistance = math.huge
            local playerPos = humanoidRootPart.Position

            for i, part in ipairs(teleportTargets) do
                if part and part.Parent then
                    local distance = (part.Position - playerPos).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestTarget = part
                    end
                end
            end

            if closestTarget then
                for i, part in ipairs(teleportTargets) do
                    if part == closestTarget then
                        table.remove(teleportTargets, i)
                        break
                    end
                end

                local targetCFrame = closestTarget.CFrame * CFrame.new(0, 3, 0)
                local distance = (closestTarget.Position - playerPos).Magnitude
                local duration = math.clamp(distance / walkSpeed, 0.5, 1.5)

                local tween = tweenPosition(humanoidRootPart, targetCFrame, duration)
                tween.Completed:Wait()

                task.wait(teleportDelay)
            else
                break
            end
        end
        task.wait(1)
    end
end

-- Функция установки WalkSpeed
local function setWalkSpeed(value)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
end

-- Обработчик бесконечного прыжка
local function onInfiniteJump(input, gameProcessedEvent)
    if infiniteJumpEnabled and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space and not gameProcessedEvent then
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end

-- Обработчик переключателя Auto Bubble
AutoBubbleToggle.MouseButton1Click:Connect(function()
    autoBubbleEnabled = not autoBubbleEnabled
    print("AutoBubble toggled to: " .. tostring(autoBubbleEnabled))
    local tween = TweenService:Create(AutoBubbleToggle, tweenInfo, {
        BackgroundColor3 = autoBubbleEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
end)

-- Обработчик переключателя Auto Sell
AutoSellToggle.MouseButton1Click:Connect(function()
    autoSellEnabled = not autoSellEnabled
    print("AutoSell toggled to: " .. tostring(autoSellEnabled))
    local tween = TweenService:Create(AutoSellToggle, tweenInfo, {
        BackgroundColor3 = autoSellEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
end)

-- Обработчик переключателя Auto Collect
AutoCollectToggle.MouseButton1Click:Connect(function()
    autoCollectEnabled = not autoCollectEnabled
    print("AutoCollect toggled to: " .. tostring(autoCollectEnabled))
    local tween = TweenService:Create(AutoCollectToggle, tweenInfo, {
        BackgroundColor3 = autoCollectEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
end)

-- Обработчик переключателя Auto Farm
AutoFarmToggle.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    print("AutoFarm toggled to: " .. tostring(autoFarmEnabled))
    local tween = TweenService:Create(AutoFarmToggle, tweenInfo, {
        BackgroundColor3 = autoFarmEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
    if autoFarmEnabled then
        task.spawn(farmCollectibles)
    end
end)

-- Обработчик переключателя Infinite Jump
InfiniteJumpToggle.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    print("InfiniteJump toggled to: " .. tostring(infiniteJumpEnabled))
    local tween = TweenService:Create(InfiniteJumpToggle, tweenInfo, {
        BackgroundColor3 = infiniteJumpEnabled and COLORS.accent or COLORS.disabled
    })
    tween:Play()
end)

-- Обновление ползунка частоты
local function updateSlider(value)
    value = math.clamp(value, 0.1, 2)
    local percent = (value - 0.1) / 1.9
    local tween = TweenService:Create(SliderFill, tweenInfo, {Size = UDim2.new(percent, 0, 1, 0)})
    local tween2 = TweenService:Create(SliderButton, tweenInfo, {Position = UDim2.new(percent, -8, 0.5, -8)})
    tween:Play()
    tween2:Play()
    bubbleCooldown = math.round(value * 10) / 10
    FrequencyLabel.Text = string.format("Frequency: %.1fs", bubbleCooldown)
end

-- Обновление ползунка задержки телепорта
local function updateTeleportDelaySlider(value)
    value = math.clamp(value, 0.1, 2)
    local percent = (value - 0.1) / 1.9
    local tween = TweenService:Create(TeleportDelaySliderFill, tweenInfo, {Size = UDim2.new(percent, 0, 1, 0)})
    local tween2 = TweenService:Create(TeleportDelaySliderButton, tweenInfo, {Position = UDim2.new(percent, -8, 0.5, -8)})
    tween:Play()
    tween2:Play()
    teleportDelay = math.round(value * 10) / 10
    TeleportDelayLabel.Text = string.format("Teleport Delay: %.1fs", teleportDelay)
end

-- Обновление ползунка WalkSpeed
local function updateWalkSpeedSlider(value)
    value = math.clamp(value, 10, 200)
    local percent = (value - 10) / 190
    local tween = TweenService:Create(WalkSpeedSliderFill, tweenInfo, {Size = UDim2.new(percent, 0, 1, 0)})
    local tween2 = TweenService:Create(WalkSpeedSliderButton, tweenInfo, {Position = UDim2.new(percent, -8, 0.5, -8)})
    tween:Play()
    tween2:Play()
    walkSpeed = math.round(value)
    WalkSpeedLabel.Text = string.format("WalkSpeed: %d", walkSpeed)
    setWalkSpeed(walkSpeed)
end

-- Обработчики ползунка частоты
SliderButton.MouseButton1Down:Connect(function()
    isDragging = true
end)

SliderTrack.MouseButton1Down:Connect(function()
    isDragging = true
    local mousePos = UserInputService:GetMouseLocation()
    local sliderPos = SliderTrack.AbsolutePosition.X
    local sliderWidth = SliderTrack.AbsoluteSize.X
    local percent = math.clamp((mousePos.X - sliderPos) / sliderWidth, 0, 1)
    updateSlider(0.1 + percent * 1.9)
end)

-- Обработчики ползунка задержки телепорта
TeleportDelaySliderButton.MouseButton1Down:Connect(function()
    isDraggingTeleport = true
end)

TeleportDelaySliderTrack.MouseButton1Down:Connect(function()
    isDraggingTeleport = true
    local mousePos = UserInputService:GetMouseLocation()
    local sliderPos = TeleportDelaySliderTrack.AbsolutePosition.X
    local sliderWidth = TeleportDelaySliderTrack.AbsoluteSize.X
    local percent = math.clamp((mousePos.X - sliderPos) / sliderWidth, 0, 1)
    updateTeleportDelaySlider(0.1 + percent * 1.9)
end)

-- Обработчики ползунка WalkSpeed
WalkSpeedSliderButton.MouseButton1Down:Connect(function()
    isDraggingWalkSpeed = true
end)

WalkSpeedSliderTrack.MouseButton1Down:Connect(function()
    isDraggingWalkSpeed = true
    local mousePos = UserInputService:GetMouseLocation()
    local sliderPos = WalkSpeedSliderTrack.AbsolutePosition.X
    local sliderWidth = WalkSpeedSliderTrack.AbsoluteSize.X
    local percent = math.clamp((mousePos.X - sliderPos) / sliderWidth, 0, 1)
    updateWalkSpeedSlider(10 + percent * 190)
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if isDragging then
            local mousePos = input.Position
            local sliderPos = SliderTrack.AbsolutePosition.X
            local sliderWidth = SliderTrack.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - sliderPos) / sliderWidth, 0, 1)
            updateSlider(0.1 + percent * 1.9)
        elseif isDraggingTeleport then
            local mousePos = input.Position
            local sliderPos = TeleportDelaySliderTrack.AbsolutePosition.X
            local sliderWidth = TeleportDelaySliderTrack.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - sliderPos) / sliderWidth, 0, 1)
            updateTeleportDelaySlider(0.1 + percent * 1.9)
        elseif isDraggingWalkSpeed then
            local mousePos = input.Position
            local sliderPos = WalkSpeedSliderTrack.AbsolutePosition.X
            local sliderWidth = WalkSpeedSliderTrack.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - sliderPos) / sliderWidth, 0, 1)
            updateWalkSpeedSlider(10 + percent * 190)
        elseif isDraggingWindow then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
        isDraggingTeleport = false
        isDraggingWalkSpeed = false
        isDraggingWindow = false
    end
end)

-- Подключение бесконечного прыжка
UserInputService.InputBegan:Connect(onInfiniteJump)

-- Кнопка закрытия
CloseButton.MouseButton1Click:Connect(function()
    print("Close button clicked")
    scriptActive = false
    manageGoldenChestHighlight(false)
    local tween = TweenService:Create(MainFrame, tweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset + config.width / 2, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset + config.height / 2)
    })
    tween.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
    tween:Play()
end)

-- Кнопка сворачивания
MinimizeButton.MouseButton1Click:Connect(function()
    print("Minimize button clicked")
    isMinimized = not isMinimized
    if isMinimized then
        local tween = TweenService:Create(ContentFrame, tweenInfo, {Size = UDim2.new(1, -50, 0, 0)})
        local tween2 = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, config.width, 0, 30)})
        tween:Play()
        tween2:Play()
        MinimizeButton.Text = "+"
    else
        local tween = TweenService:Create(ContentFrame, tweenInfo, {Size = UDim2.new(1, -50, 1, -30)})
        local tween2 = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, config.width, 0, config.height)})
        tween:Play()
        tween2:Play()
        MinimizeButton.Text = "_"
    end
end)

-- Перемещение окна
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDraggingWindow = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

-- Автоматическое выполнение функций
task.spawn(function()
    while scriptActive do
        if autoBubbleEnabled then
            blowBubble()
        end
        if autoSellEnabled then
            sellBubble()
        end
        if autoCollectEnabled then
            collectPlaytime()
        end
        if blackMarketEnabled then
            buyBlackMarket()
        end
        if alienShopEnabled then
            buyAlienShop()
        end
        task.wait(bubbleCooldown)
    end
end)

-- Инициализация
updateSlider(0.5)
updateTeleportDelaySlider(0.1)
updateWalkSpeedSlider(16)
