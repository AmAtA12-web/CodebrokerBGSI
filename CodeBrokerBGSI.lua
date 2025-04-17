local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

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

-- Основные настройки
local config = {
    width = 500,
    height = 350,
    cornerRadius = 8,
    tabs = {"Home", "Farm", "Misc", "Teleport", "FPS", "Alts", "ESP"}
}

-- Инициализация игрока и ремов
local player = Players.LocalPlayer
local bubbleRemote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote")
local pickupRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Pickups") and ReplicatedStorage.Remotes.Pickups:FindFirstChild("CollectPickup")

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuckyCC"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1000
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, config.width, 0, config.height)
MainFrame.Position = UDim2.new(0.5, -config.width / 2, 0.5, -config.height / 2)
MainFrame.BackgroundColor3 = COLORS.background
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, config.cornerRadius)
UICorner.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = COLORS.header
TitleBar.Parent = MainFrame

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, config.cornerRadius)
TitleBarCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Text = "lucky.cc"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = COLORS.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Кнопки управления
local function createControlButton(text, positionX)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0, 20, 0, 20)
    button.Position = UDim2.new(1, positionX, 0.5, -10)
    button.BackgroundColor3 = COLORS.accent
    button.TextColor3 = COLORS.text
    button.Font = Enum.Font.GothamBold
    button.TextSize = text == "_" and 14 or 16
    button.Parent = TitleBar
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = button
    
    return button
end

local MinimizeButton = createControlButton("_", -45)
local CloseButton = createControlButton("×", -25)

-- Панель вкладок
local TabPanel = Instance.new("Frame")
TabPanel.Size = UDim2.new(0, 45, 1, -25)
TabPanel.Position = UDim2.new(0, 0, 0, 25)
TabPanel.BackgroundColor3 = COLORS.tab_unselected
TabPanel.Parent = MainFrame

local TabPanelCorner = Instance.new("UICorner")
TabPanelCorner.CornerRadius = UDim.new(0, config.cornerRadius)
TabPanelCorner.Parent = TabPanel

-- Контейнер контента
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -45, 1, -25)
ContentFrame.Position = UDim2.new(0, 45, 0, 25)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Создание вкладок
local tabs = {}
for i, tabName in ipairs(config.tabs) do
    local tab = Instance.new("Frame")
    tab.Name = tabName .. "Tab"
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = i == 1
    tab.Parent = ContentFrame
    
    tabs[tabName] = tab
end

-- Создание кнопок вкладок
local tabButtons = {}
for i, tabName in ipairs(config.tabs) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 22)
    button.Position = UDim2.new(0, 0, 0, 22 + (i-1)*22)
    button.BackgroundColor3 = i == 1 and COLORS.tab_selected or COLORS.tab_unselected
    button.Text = tabName
    button.TextColor3 = COLORS.text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 11
    button.Parent = TabPanel
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 3, 1, 0)
    indicator.Position = UDim2.new(0, 0, 0, 0)
    indicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    indicator.BorderSizePixel = 0
    indicator.Visible = i == 1
    indicator.Parent = button
    
    tabButtons[tabName] = {button = button, indicator = indicator}
end

-- Функция переключения вкладок
local function switchTab(selectedTab)
    for tabName, tab in pairs(tabs) do
        tab.Visible = tab == selectedTab
        tabButtons[tabName].button.BackgroundColor3 = tab == selectedTab and COLORS.tab_selected or COLORS.tab_unselected
        tabButtons[tabName].indicator.Visible = tab == selectedTab
    end
end

-- Обработчики кнопок вкладок
for tabName, data in pairs(tabButtons) do
    data.button.MouseButton1Click:Connect(function()
        switchTab(tabs[tabName])
    end)
end

-- Создаем элементы управления
local function createToggle(parent, name, positionY, description)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, description and 40 or 25)
    frame.Position = UDim2.new(0, 5, 0, positionY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local toggle = Instance.new("TextButton")
    toggle.Name = name .. "Toggle"
    toggle.Size = UDim2.new(0, 18, 0, 18)
    toggle.Position = UDim2.new(0, 0, 0.5, -9)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.Text = ""
    toggle.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(1, -25, description and 0.5 or 1, 0)
    label.Position = UDim2.new(0, 25, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = COLORS.text
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    if description then
        local desc = Instance.new("TextLabel")
        desc.Text = description
        desc.Size = UDim2.new(1, -25, 0.5, 0)
        desc.Position = UDim2.new(0, 25, 0.5, 0)
        desc.BackgroundTransparency = 1
        desc.TextColor3 = COLORS.disabled
        desc.Font = Enum.Font.Gotham
        desc.TextSize = 10
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.TextWrapped = true
        desc.Parent = frame
    end
    
    return toggle
end

local function createSlider(parent, name, positionY, minValue, maxValue, defaultValue, formatFunc)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.Position = UDim2.new(0, 5, 0, positionY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = name .. ": " .. formatFunc(defaultValue)
    label.Size = UDim2.new(1, 0, 0, 15)
    label.BackgroundTransparency = 1
    label.TextColor3 = COLORS.text
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local track = Instance.new("TextButton")
    track.Size = UDim2.new(1, 0, 0, 5)
    track.Position = UDim2.new(0, 0, 0, 20)
    track.BackgroundColor3 = COLORS.disabled
    track.Text = ""
    track.Parent = frame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    fill.BackgroundColor3 = COLORS.accent
    fill.Parent = track
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 12, 0, 12)
    button.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -6, 0.5, -6)
    button.BackgroundColor3 = COLORS.text
    button.Text = ""
    button.Parent = track
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = button
    
    return {
        frame = frame,
        label = label,
        track = track,
        fill = fill,
        button = button,
        min = minValue,
        max = maxValue,
        value = defaultValue,
        formatFunc = formatFunc
    }
end

-- Создаем элементы для вкладок
local sliders = {}
local toggles = {}

-- Home Tab
toggles.InfiniteJump = createToggle(tabs.Home, "Infinite Jump", 10)
toggles.AntiAFK = createToggle(tabs.Home, "Anti-AFK", 40)
sliders.WalkSpeed = createSlider(tabs.Home, "WalkSpeed", 70, 16, 100, 16, function(v) return string.format("%d", v) end)

-- Farm Tab
toggles.AutoBubble = createToggle(tabs.Farm, "Auto Blow Bubble", 10)
sliders.Frequency = createSlider(tabs.Farm, "Frequency", 40, 0.1, 1, 0.5, function(v) return string.format("%.1fs", v) end)
toggles.AutoSell = createToggle(tabs.Farm, "Auto Sell Bubble", 80)
toggles.AutoFarm = createToggle(tabs.Farm, "Auto Farm", 110)
sliders.CollectDelay = createSlider(tabs.Farm, "Collect Delay", 140, 0.1, 1, 0.1, function(v) return string.format("%.1fs", v) end)

-- Misc Tab
toggles.AutoCollect = createToggle(tabs.Misc, "Auto Collect Playtime", 10)
toggles.AlienShop = createToggle(tabs.Misc, "Alien-Shop", 40)
toggles.BlackMarket = createToggle(tabs.Misc, "Black-Market", 70)
toggles.AutoWheelTickets = createToggle(tabs.Misc, "Auto Wheel Tickets", 100)
toggles.AutoVoidChest = createToggle(tabs.Misc, "Auto Void Chest", 130)
toggles.AutoGiantChest = createToggle(tabs.Misc, "Auto Giant Chest", 160)
toggles.AutoMysteryGift = createToggle(tabs.Misc, "Auto MysteryGift", 190)
sliders.MysteryGiftAmount = createSlider(tabs.Misc, "MysteryGift Amount", 220, 1, 100, 1, function(v) return string.format("%d", v) end)

-- FPS Tab
toggles.BlackScreen = createToggle(tabs.FPS, "Black Screen", 10)
sliders.FPSLimit = createSlider(tabs.FPS, "FPS Limit", 40, 10, 144, 60, function(v) return string.format("%d", v) end)

-- Alts Tab
toggles.AutoProgress = createToggle(tabs.Alts, "Auto-Progress", 10, "Автопокупка жвачек и пузырей")
toggles.AutoOpenIslands = createToggle(tabs.Alts, "Auto-Open Islands", 50)

-- ESP Tab
toggles.GoldenChestESP = createToggle(tabs.ESP, "Golden Chest ESP", 10, "Подсветка золотых сундуков")

-- Teleport Tab
local worldPaths = {
    "Workspace.Worlds.The Overworld.PortalSpawn",
    "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn",
    "Workspace.Worlds.The Overworld.Islands.Outer Space.Island.Portal.Spawn",
    "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn",
    "Workspace.Worlds.The Overworld.Islands.The Void.Island.Portal.Spawn",
    "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"
}

for i = 1, 6 do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 25)
    button.Position = UDim2.new(0, 5, 0, 10 + (i - 1) * 30)
    button.BackgroundColor3 = COLORS.tab_unselected
    button.Text = "World " .. i
    button.TextColor3 = COLORS.text
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Parent = tabs.Teleport
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        if worldPaths[i] then
            local args = {[1] = "Teleport", [2] = worldPaths[i]}
            bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
        end
    end)
end

-- Состояния и функции
local states = {
    autoBubbleEnabled = false,
    autoSellEnabled = false,
    autoCollectEnabled = false,
    autoFarmEnabled = false,
    infiniteJumpEnabled = false,
    antiAFKEnabled = false,
    goldenChestESPEnabled = false,
    alienShopEnabled = false,
    blackMarketEnabled = false,
    autoWheelTicketsEnabled = false,
    autoVoidChestEnabled = false,
    autoGiantChestEnabled = false,
    autoMysteryGiftEnabled = false,
    blackScreenEnabled = false,
    autoOpenIslandsEnabled = false,
    autoProgressEnabled = false,
    
    bubbleCooldown = 0.5,
    collectDelay = 0.1,
    walkSpeed = 16,
    mysteryGiftAmount = 1,
    fpsLimit = 60,
    
    scriptActive = true,
    goldenChestESPs = {},
    blackScreenEffect = nil
}

local function updateToggleVisual(toggle, enabled)
    local tween = TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
    })
    tween:Play()
end

-- Улучшенная функция Anti-AFK
local function antiAFK()
    local bb = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
    end)
end

-- Функции для работы с игрой
local function blowBubble()
    pcall(function()
        bubbleRemote:WaitForChild("Event"):FireServer("BlowBubble")
    end)
end

local function sellBubble()
    pcall(function()
        local args = {[1] = "SellBubble"}
        bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
    end)
end

local function collectPlaytime()
    for i = 1, 9 do
        pcall(function()
            local args = {[1] = "ClaimPlaytime", [2] = i}
            bubbleRemote:WaitForChild("Function"):InvokeServer(unpack(args))
        end)
        task.wait(0.1)
    end
end

local function buyAlienShop()
    for i = 1, 3 do
        pcall(function()
            local args = {[1] = "BuyShopItem", [2] = "alien-shop", [3] = i}
            bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
        end)
        task.wait(0.1)
    end
end

local function buyBlackMarket()
    for i = 1, 3 do
        pcall(function()
            local args = {[1] = "BuyShopItem", [2] = "shard-shop", [3] = i}
            bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
        end)
        task.wait(0.1)
    end
end

local function collectWheelTickets()
    pcall(function()
        local args = {[1] = "ClaimFreeWheelSpin"}
        bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
    end)
end

local function openVoidChest()
    pcall(function()
        local args = {[1] = "ClaimChest", [2] = "Void Chest"}
        bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
    end)
end

local function openGiantChest()
    pcall(function()
        local args = {[1] = "ClaimChest", [2] = "GiantJIT Chest"}
        bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
    end)
end

local function useMysteryGift()
    pcall(function()
        local args = {
            [1] = "UseGift",
            [2] = "Mystery Box",
            [3] = states.mysteryGiftAmount
        }
        bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
    end)
end

local function autoProgressPurchase()
    local gumItems = {
        "Blueberry", "Watermelon", "Cherry", "Chocolate", "Contrast",
        "Donut", "Gold", "Lemon", "Molten", "Pizza", "Swirl",
        "Alien Gum", "Chewy Gum", "Cosmic Gum", "Epic Gum", "Experiment #52",
        "Mega Gum", "Omega Gum", "Quantum Gum", "Radioactive Gum", 
        "Stretchy Gum", "Ultra Gum", "Unreal Gum", "XL Gum"
    }
    
    for _, gumName in ipairs(gumItems) do
        if not states.autoProgressEnabled then break end
        
        pcall(function()
            local args = {[1] = "GumShopPurchase", [2] = gumName}
            bubbleRemote:WaitForChild("Event"):FireServer(unpack(args))
        end)
        task.wait(0.5)
    end
end

local function autoOpenIslands()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not states.autoOpenIslandsEnabled then
            connection:Disconnect()
            return
        end
        
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end

local function farmCollectibles()
    while states.autoFarmEnabled and states.scriptActive do
        local rendered = Workspace:FindFirstChild("Rendered")
        if rendered then
            local itemsToRemove = {}
            
            for _, chunker in ipairs(rendered:GetChildren()) do
                if chunker.Name:match("Chunker") then
                    for _, item in ipairs(chunker:GetChildren()) do
                        if item.Name:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
                            table.insert(itemsToRemove, item)
                        end
                    end
                end
            end
            
            for _, item in ipairs(itemsToRemove) do
                if item and item.Parent then
                    pcall(function()
                        pickupRemote:FireServer(item.Name)
                        item:Destroy()
                    end)
                    task.wait(states.collectDelay)
                end
            end
        end
        task.wait(5)
    end
end

local function createESP(object)
    if not object then return nil end
    
    -- Create highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "GoldenChestESP"
    highlight.Adornee = object
    highlight.FillColor = Color3.fromRGB(255, 215, 0)
    highlight.FillTransparency = 0.7
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Parent = object
    
    -- Create text label
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "GoldenChestLabel"
    billboard.Adornee = object
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = object
    
    local label = Instance.new("TextLabel")
    label.Text = "GOLDEN CHEST"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.Parent = billboard
    
    return {highlight = highlight, billboard = billboard}
end

local function manageGoldenChestESP(enabled)
    if not enabled then
        for _, esp in pairs(states.goldenChestESPs) do
            if esp and esp.highlight and esp.highlight.Parent then
                esp.highlight:Destroy()
            end
            if esp and esp.billboard and esp.billboard.Parent then
                esp.billboard:Destroy()
            end
        end
        states.goldenChestESPs = {}
        return
    end

    local goldenChestNames = {"golden-chest"}
    
    task.spawn(function()
        while states.scriptActive and enabled do
            local rendered = Workspace:FindFirstChild("Rendered")
            if rendered then
                for _, name in ipairs(goldenChestNames) do
                    local chest = rendered:FindFirstChild(name, true)
                    if chest and not states.goldenChestESPs[name] then
                        states.goldenChestESPs[name] = createESP(chest)
                    end
                end
            end
            task.wait(5)
        end
    end)
end

local function manageBlackScreen(enabled)
    if enabled and not states.blackScreenEffect then
        states.blackScreenEffect = Instance.new("ColorCorrectionEffect")
        states.blackScreenEffect.Brightness = -1
        states.blackScreenEffect.Parent = Lighting
    elseif not enabled and states.blackScreenEffect then
        states.blackScreenEffect:Destroy()
        states.blackScreenEffect = nil
    end
end

local function restrictFPS()
    local frameTime = 1 / states.fpsLimit
    while states.scriptActive do
        local startTime = tick()
        RunService.RenderStepped:Wait()
        local elapsed = tick() - startTime
        if elapsed < frameTime then
            task.wait(frameTime - elapsed)
        end
    end
end

-- Обработчики тогглов
toggles.InfiniteJump.MouseButton1Click:Connect(function()
    states.infiniteJumpEnabled = not states.infiniteJumpEnabled
    updateToggleVisual(toggles.InfiniteJump, states.infiniteJumpEnabled)
end)

toggles.AntiAFK.MouseButton1Click:Connect(function()
    states.antiAFKEnabled = not states.antiAFKEnabled
    updateToggleVisual(toggles.AntiAFK, states.antiAFKEnabled)
    
    if states.antiAFKEnabled then
        antiAFK()
    end
end)

toggles.AutoBubble.MouseButton1Click:Connect(function()
    states.autoBubbleEnabled = not states.autoBubbleEnabled
    updateToggleVisual(toggles.AutoBubble, states.autoBubbleEnabled)
    
    if states.autoBubbleEnabled then
        task.spawn(function()
            while states.autoBubbleEnabled and states.scriptActive do
                blowBubble()
                task.wait(states.bubbleCooldown)
            end
        end)
    end
end)

toggles.AutoSell.MouseButton1Click:Connect(function()
    states.autoSellEnabled = not states.autoSellEnabled
    updateToggleVisual(toggles.AutoSell, states.autoSellEnabled)
    
    if states.autoSellEnabled then
        task.spawn(function()
            while states.autoSellEnabled and states.scriptActive do
                sellBubble()
                task.wait(0.5)
            end
        end)
    end
end)

toggles.AutoCollect.MouseButton1Click:Connect(function()
    states.autoCollectEnabled = not states.autoCollectEnabled
    updateToggleVisual(toggles.AutoCollect, states.autoCollectEnabled)
    
    if states.autoCollectEnabled then
        task.spawn(function()
            while states.autoCollectEnabled and states.scriptActive do
                collectPlaytime()
                task.wait(5)
            end
        end)
    end
end)

toggles.AutoFarm.MouseButton1Click:Connect(function()
    states.autoFarmEnabled = not states.autoFarmEnabled
    updateToggleVisual(toggles.AutoFarm, states.autoFarmEnabled)
    
    if states.autoFarmEnabled and pickupRemote then
        task.spawn(farmCollectibles)
    end
end)

toggles.GoldenChestESP.MouseButton1Click:Connect(function()
    states.goldenChestESPEnabled = not states.goldenChestESPEnabled
    updateToggleVisual(toggles.GoldenChestESP, states.goldenChestESPEnabled)
    manageGoldenChestESP(states.goldenChestESPEnabled)
end)

toggles.AlienShop.MouseButton1Click:Connect(function()
    states.alienShopEnabled = not states.alienShopEnabled
    updateToggleVisual(toggles.AlienShop, states.alienShopEnabled)
    
    if states.alienShopEnabled then
        task.spawn(function()
            while states.alienShopEnabled and states.scriptActive do
                buyAlienShop()
                task.wait(5)
            end
        end)
    end
end)

toggles.BlackMarket.MouseButton1Click:Connect(function()
    states.blackMarketEnabled = not states.blackMarketEnabled
    updateToggleVisual(toggles.BlackMarket, states.blackMarketEnabled)
    
    if states.blackMarketEnabled then
        task.spawn(function()
            while states.blackMarketEnabled and states.scriptActive do
                buyBlackMarket()
                task.wait(5)
            end
        end)
    end
end)

toggles.AutoWheelTickets.MouseButton1Click:Connect(function()
    states.autoWheelTicketsEnabled = not states.autoWheelTicketsEnabled
    updateToggleVisual(toggles.AutoWheelTickets, states.autoWheelTicketsEnabled)
    
    if states.autoWheelTicketsEnabled then
        task.spawn(function()
            while states.autoWheelTicketsEnabled and states.scriptActive do
                collectWheelTickets()
                task.wait(5)
            end
        end)
    end
end)

toggles.AutoVoidChest.MouseButton1Click:Connect(function()
    states.autoVoidChestEnabled = not states.autoVoidChestEnabled
    updateToggleVisual(toggles.AutoVoidChest, states.autoVoidChestEnabled)
    
    if states.autoVoidChestEnabled then
        task.spawn(function()
            while states.autoVoidChestEnabled and states.scriptActive do
                openVoidChest()
                task.wait(5)
            end
        end)
    end
end)

toggles.AutoGiantChest.MouseButton1Click:Connect(function()
    states.autoGiantChestEnabled = not states.autoGiantChestEnabled
    updateToggleVisual(toggles.AutoGiantChest, states.autoGiantChestEnabled)
    
    if states.autoGiantChestEnabled then
        task.spawn(function()
            while states.autoGiantChestEnabled and states.scriptActive do
                openGiantChest()
                task.wait(5)
            end
        end)
    end
end)

toggles.AutoMysteryGift.MouseButton1Click:Connect(function()
    states.autoMysteryGiftEnabled = not states.autoMysteryGiftEnabled
    updateToggleVisual(toggles.AutoMysteryGift, states.autoMysteryGiftEnabled)
    
    if states.autoMysteryGiftEnabled then
        task.spawn(function()
            while states.autoMysteryGiftEnabled and states.scriptActive do
                useMysteryGift()
                task.wait(0.01)
            end
        end)
    end
end)

toggles.BlackScreen.MouseButton1Click:Connect(function()
    states.blackScreenEnabled = not states.blackScreenEnabled
    updateToggleVisual(toggles.BlackScreen, states.blackScreenEnabled)
    manageBlackScreen(states.blackScreenEnabled)
end)

toggles.AutoProgress.MouseButton1Click:Connect(function()
    states.autoProgressEnabled = not states.autoProgressEnabled
    updateToggleVisual(toggles.AutoProgress, states.autoProgressEnabled)
    
    if states.autoProgressEnabled then
        task.spawn(function()
            while states.autoProgressEnabled and states.scriptActive do
                autoProgressPurchase()
                task.wait(5)
            end
        end)
    end
end)

toggles.AutoOpenIslands.MouseButton1Click:Connect(function()
    states.autoOpenIslandsEnabled = not states.autoOpenIslandsEnabled
    updateToggleVisual(toggles.AutoOpenIslands, states.autoOpenIslandsEnabled)
    
    if states.autoOpenIslandsEnabled then
        autoOpenIslands()
    end
end)

-- Плавные ползунки
local function setupSmoothSlider(sliderData, valueName, updateFunc)
    local isDragging = false
    
    local function updateValue(input)
        local mousePos = input.Position.X
        local trackPos = sliderData.track.AbsolutePosition.X
        local trackWidth = sliderData.track.AbsoluteSize.X
        local fillAmount = math.clamp((mousePos - trackPos) / trackWidth, 0, 1)
        local value = sliderData.min + (fillAmount * (sliderData.max - sliderData.min))
        
        if valueName == "bubbleCooldown" or valueName == "collectDelay" then
            value = math.floor(value * 10 + 0.5) / 10
            fillAmount = (value - sliderData.min) / (sliderData.max - sliderData.min)
        end
        
        sliderData.fill.Size = UDim2.new(fillAmount, 0, 1, 0)
        sliderData.button.Position = UDim2.new(fillAmount, -6, 0.5, -6)
        states[valueName] = value
        sliderData.label.Text = sliderData.label.Text:gsub(": .+", ": " .. sliderData.formatFunc(value))
        
        if updateFunc then
            updateFunc(value)
        end
    end
    
    sliderData.button.MouseButton1Down:Connect(function()
        isDragging = true
    end)
    
    sliderData.track.MouseButton1Down:Connect(function(x, y)
        isDragging = true
        updateValue({Position = Vector2.new(x, y)})
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
end

-- Настройка плавных ползунков
setupSmoothSlider(sliders.WalkSpeed, "walkSpeed", function(value)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
end)

setupSmoothSlider(sliders.Frequency, "bubbleCooldown")
setupSmoothSlider(sliders.CollectDelay, "collectDelay")
setupSmoothSlider(sliders.FPSLimit, "fpsLimit", function(value)
    setfpscap(value)
end)

setupSmoothSlider(sliders.MysteryGiftAmount, "mysteryGiftAmount")

-- Обработчики кнопок управления
CloseButton.MouseButton1Click:Connect(function()
    states.scriptActive = false
    ScreenGui:Destroy()
    manageBlackScreen(false)
    manageGoldenChestESP(false)
    setfpscap(60)
end)

local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = isMinimized and UDim2.new(0, config.width, 0, 25) or UDim2.new(0, config.width, 0, config.height)
    })
    tween:Play()
    TabPanel.Visible = not isMinimized
    ContentFrame.Visible = not isMinimized
end)

-- Перетаскивание окна
local isDraggingWindow = false
local dragStartMousePos, dragStartFramePos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDraggingWindow = true
        dragStartMousePos = input.Position
        dragStartFramePos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDraggingWindow = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingWindow and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartMousePos
        MainFrame.Position = UDim2.new(
            dragStartFramePos.X.Scale,
            dragStartFramePos.X.Offset + delta.X,
            dragStartFramePos.Y.Scale,
            dragStartFramePos.Y.Offset + delta.Y
        )
    end
end)

-- Бесконечный прыжок
UserInputService.JumpRequest:Connect(function()
    if states.infiniteJumpEnabled then
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- Инициализация
setfpscap(states.fpsLimit)
task.spawn(restrictFPS)
