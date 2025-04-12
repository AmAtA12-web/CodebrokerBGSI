local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFarmUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Фиксированные размеры
local WINDOW_WIDTH = 450
local WINDOW_HEIGHT = 302
local TITLEBAR_HEIGHT = 30

-- Основной фрейм (фиксированный размер)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, WINDOW_WIDTH, 0, WINDOW_HEIGHT)
mainFrame.Position = UDim2.new(0.5, -WINDOW_WIDTH/2, 0.5, -WINDOW_HEIGHT/2)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.2
mainFrame.ClipsDescendants = true

-- Скругление углов основного фрейма
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0.1, 0)
mainCorner.Parent = mainFrame

-- Затемнение фона
local darkOverlay = Instance.new("Frame")
darkOverlay.Size = UDim2.new(1, 0, 1, 0)
darkOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
darkOverlay.BackgroundTransparency = 0.7
darkOverlay.BorderSizePixel = 0
darkOverlay.Parent = mainFrame

-- Заголовок с кнопками управления
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, TITLEBAR_HEIGHT)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

-- Скругление углов только сверху
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0.1, 0)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Text = "@cod3broker"
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0.2, 0, 0, 0)
title.TextColor3 = Color3.fromRGB(150, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Кнопка сворачивания (светло-голубая)
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, TITLEBAR_HEIGHT)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)
minimizeButton.Text = "_"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = titleBar

-- Кнопка закрытия (светло-голубая)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, TITLEBAR_HEIGHT)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

-- Разделитель
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 0, TITLEBAR_HEIGHT)
divider.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
divider.BorderSizePixel = 0
divider.Parent = mainFrame

-- Чекбокс Auto-Farm Collectibles
local farmCheckBox = Instance.new("TextButton")
farmCheckBox.Size = UDim2.new(0.9, 0, 0, 30)
farmCheckBox.Position = UDim2.new(0.05, 0, 0.15, TITLEBAR_HEIGHT)
farmCheckBox.Text = "☐ Auto-Farm Collectibles"
farmCheckBox.Font = Enum.Font.Gotham
farmCheckBox.TextSize = 14
farmCheckBox.TextColor3 = Color3.fromRGB(200, 200, 200)
farmCheckBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
farmCheckBox.BackgroundTransparency = 0.5
farmCheckBox.BorderSizePixel = 0

-- Скругление углов для чекбоксов
local checkBoxCorner = Instance.new("UICorner")
checkBoxCorner.CornerRadius = UDim.new(0.1, 0)
checkBoxCorner.Parent = farmCheckBox
farmCheckBox.Parent = mainFrame

-- Чекбокс Auto-Open Void Chest
local voidChestCheck = Instance.new("TextButton")
voidChestCheck.Size = UDim2.new(0.9, 0, 0, 30)
voidChestCheck.Position = UDim2.new(0.05, 0, 0.3, TITLEBAR_HEIGHT)
voidChestCheck.Text = "☐ Auto-Open Void Chest"
voidChestCheck.Font = Enum.Font.Gotham
voidChestCheck.TextSize = 14
voidChestCheck.TextColor3 = Color3.fromRGB(200, 200, 200)
voidChestCheck.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
voidChestCheck.BackgroundTransparency = 0.5
voidChestCheck.BorderSizePixel = 0
voidChestCheck.Parent = mainFrame

local voidChestCorner = Instance.new("UICorner")
voidChestCorner.CornerRadius = UDim.new(0.1, 0)
voidChestCorner.Parent = voidChestCheck

-- Таймер Void Chest
local chestTimerLabel = Instance.new("TextLabel")
chestTimerLabel.Text = "Next Void Chest: --:--"
chestTimerLabel.Size = UDim2.new(0.9, 0, 0, 20)
chestTimerLabel.Position = UDim2.new(0.05, 0, 0.45, TITLEBAR_HEIGHT)
chestTimerLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
chestTimerLabel.Font = Enum.Font.Gotham
chestTimerLabel.TextSize = 12
chestTimerLabel.BackgroundTransparency = 1
chestTimerLabel.TextXAlignment = Enum.TextXAlignment.Left
chestTimerLabel.Parent = mainFrame

-- Ползунок задержки телепорта
local delayLabel = Instance.new("TextLabel")
delayLabel.Text = "Teleport delay: 0.1s"
delayLabel.Size = UDim2.new(0.9, 0, 0, 20)
delayLabel.Position = UDim2.new(0.05, 0, 0.55, TITLEBAR_HEIGHT)
delayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
delayLabel.Font = Enum.Font.Gotham
delayLabel.TextSize = 12
delayLabel.BackgroundTransparency = 1
delayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayLabel.Parent = mainFrame

local delaySlider = Instance.new("Frame")
delaySlider.Size = UDim2.new(0.9, 0, 0, 10)
delaySlider.Position = UDim2.new(0.05, 0, 0.6, TITLEBAR_HEIGHT)
delaySlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
delaySlider.BackgroundTransparency = 0.5
delaySlider.BorderSizePixel = 0
delaySlider.Parent = mainFrame

local delayCorner = Instance.new("UICorner")
delayCorner.CornerRadius = UDim.new(0.5, 0)
delayCorner.Parent = delaySlider

local delayFill = Instance.new("Frame")
delayFill.Size = UDim2.new(0, 0, 1, 0)  -- Изначально установлено для 0.1 секунды
delayFill.Position = UDim2.new(0, 0, 0, 0)
delayFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
delayFill.BorderSizePixel = 0
delayFill.Parent = delaySlider

local delayFillCorner = Instance.new("UICorner")
delayFillCorner.CornerRadius = UDim.new(0.5, 0)
delayFillCorner.Parent = delayFill

-- Ползунок ограничения FPS
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Text = "FPS Limit: 60"
fpsLabel.Size = UDim2.new(0.9, 0, 0, 20)
fpsLabel.Position = UDim2.new(0.05, 0, 0.7, TITLEBAR_HEIGHT)
fpsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 12
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Parent = mainFrame

local fpsSlider = Instance.new("Frame")
fpsSlider.Size = UDim2.new(0.9, 0, 0, 10)
fpsSlider.Position = UDim2.new(0.05, 0, 0.75, TITLEBAR_HEIGHT)
fpsSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
fpsSlider.BackgroundTransparency = 0.5
fpsSlider.BorderSizePixel = 0
fpsSlider.Parent = mainFrame

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0.5, 0)
fpsCorner.Parent = fpsSlider

local fpsFill = Instance.new("Frame")
fpsFill.Size = UDim2.new(0.5, 0, 1, 0)
fpsFill.Position = UDim2.new(0, 0, 0, 0)
fpsFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
fpsFill.BorderSizePixel = 0
fpsFill.Parent = fpsSlider

local fpsFillCorner = Instance.new("UICorner")
fpsFillCorner.CornerRadius = UDim.new(0.5, 0)
fpsFillCorner.Parent = fpsFill

-- Статус работы
local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "Status: Ready"
statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
statusLabel.Position = UDim2.new(0.05, 0, 0.85, TITLEBAR_HEIGHT)
statusLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.BackgroundTransparency = 1
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

mainFrame.Parent = gui

-- Настройки
local isFarming = false
local isVoidChestActive = false
local scriptActive = true
local teleportDelay = 0.1 -- Уменьшено с 0.5 до 0.1
local fpsLimit = 60
local voidChestCooldown = 40 * 60 -- 35 минут в секундах
local lastVoidChestTime = 0
local bannedParts = {
    ["workspace.Stages:GetChildren()[35].Trampoline.Root"] = true
}
local playerWalkSpeed = 32 -- Добавлена скорость передвижения

-- Функция для плавного перемещения
local function tweenPosition(object, newPosition, duration)
    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    
    local tween = game:GetService("TweenService"):Create(object, tweenInfo, {Position = newPosition})
    tween:Play()
    return tween
end

-- Функция для плавного изменения размера
local function tweenSize(object, newSize, duration)
    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    
    local tween = game:GetService("TweenService"):Create(object, tweenInfo, {Size = newSize})
    tween:Play()
    return tween
end

-- Функция для нажатия клавиши E
local function pressE()
    local virtualInput = game:GetService("VirtualInputManager")
    virtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.1)
    virtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- Функция для проверки запрещенных частей
local function isBannedPart(part)
    local fullName = part:GetFullName()
    return bannedParts[fullName] or false
end

-- Функция для обновления задержки телепорта
local function updateTeleportDelay(value)
    teleportDelay = math.clamp(value, 0.1, 2)
    local fillAmount = (teleportDelay - 0.1) / 1.9
    tweenSize(delayFill, UDim2.new(fillAmount, 0, 1, 0), 0.2)
    delayLabel.Text = string.format("Teleport delay: %.1fs", teleportDelay)
end

-- Функция для обновления лимита FPS
local function updateFPSLimit(value)
    fpsLimit = math.clamp(value, 10, 144)
    local fillAmount = (fpsLimit - 10) / 134
    tweenSize(fpsFill, UDim2.new(fillAmount, 0, 1, 0), 0.2)
    fpsLabel.Text = string.format("FPS Limit: %d", fpsLimit)
    setfpscap(fpsLimit)
end

-- Функция сворачивания в заголовок с анимацией
local function toggleMinimize()
    if mainFrame.Size.Y.Offset == TITLEBAR_HEIGHT then
        -- Разворачиваем с анимацией
        tweenSize(mainFrame, UDim2.new(0, WINDOW_WIDTH, 0, WINDOW_HEIGHT), 0.3)
        minimizeButton.Text = "_"
    else
        -- Сворачиваем с анимацией
        tweenSize(mainFrame, UDim2.new(0, WINDOW_WIDTH, 0, TITLEBAR_HEIGHT), 0.3)
        minimizeButton.Text = "+"
    end
end

-- Обработчики кнопок
minimizeButton.MouseButton1Click:Connect(toggleMinimize)

closeButton.MouseButton1Click:Connect(function()
    scriptActive = false
    isFarming = false
    isVoidChestActive = false
    tweenPosition(mainFrame, UDim2.new(0.5, -WINDOW_WIDTH/2, -0.5, -TITLEBAR_HEIGHT), 0.5)
    task.wait(0.5)
    gui:Destroy()
end)

farmCheckBox.MouseButton1Click:Connect(function()
    if not scriptActive then return end
    isFarming = not isFarming
    if isFarming then
        farmCheckBox.Text = "☑ Auto-Farm ACTIVE"
        statusLabel.Text = "Status: Farming..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        farmCheckBox.Text = "☐ Auto-Farm Collectibles"
        statusLabel.Text = "Status: Paused"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

voidChestCheck.MouseButton1Click:Connect(function()
    if not scriptActive then return end
    isVoidChestActive = not isVoidChestActive
    if isVoidChestActive then
        voidChestCheck.Text = "☑ Void Chest ACTIVE"
        lastVoidChestTime = 0 -- Сброс таймера при активации
    else
        voidChestCheck.Text = "☐ Auto-Open Void Chest"
        chestTimerLabel.Text = "Next Void Chest: --:--"
    end
end)

-- Обработчик ползунка задержки
local delaySliderDragging = false
delaySlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        delaySliderDragging = true
        local xPos = (input.Position.X - delaySlider.AbsolutePosition.X) / delaySlider.AbsoluteSize.X
        updateTeleportDelay(0.1 + xPos * 1.9)
    end
end)

-- Обработчик ползунка FPS
local fpsSliderDragging = false
fpsSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        fpsSliderDragging = true
        local xPos = (input.Position.X - fpsSlider.AbsolutePosition.X) / fpsSlider.AbsoluteSize.X
        updateFPSLimit(10 + math.floor(xPos * 134))
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        delaySliderDragging = false
        fpsSliderDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if delaySliderDragging then
            local xPos = (input.Position.X - delaySlider.AbsolutePosition.X) / delaySlider.AbsoluteSize.X
            updateTeleportDelay(0.1 + math.clamp(xPos, 0, 1) * 1.9)
        elseif fpsSliderDragging then
            local xPos = (input.Position.X - fpsSlider.AbsolutePosition.X) / fpsSlider.AbsoluteSize.X
            updateFPSLimit(10 + math.floor(math.clamp(xPos, 0, 1) * 134))
        end
    end
end)

-- Логика перетаскивания UI с ограничениями и плавностью
local dragging = false
local dragStartPos, frameStartPos
local viewportSize = workspace.CurrentCamera.ViewportSize

local function startDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        frameStartPos = mainFrame.Position
    end
end

local function endDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end

local function updateDrag(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos
        local newX = frameStartPos.X.Offset + delta.X
        local newY = frameStartPos.Y.Offset + delta.Y
        
        -- Ограничиваем позицию в пределах экрана
        newX = math.clamp(newX, -mainFrame.AbsoluteSize.X/2, viewportSize.X - mainFrame.AbsoluteSize.X/2)
        newY = math.clamp(newY, -mainFrame.AbsoluteSize.Y/2, viewportSize.Y - mainFrame.AbsoluteSize.Y/2)
        
        local newPos = UDim2.new(
            frameStartPos.X.Scale, 
            newX,
            frameStartPos.Y.Scale, 
            newY
        )
        
        -- Плавное перемещение с твином
        tweenPosition(mainFrame, newPos, 0.1)
    end
end

-- Обработчики перетаскивания
titleBar.InputBegan:Connect(startDrag)
game:GetService("UserInputService").InputEnded:Connect(endDrag)
game:GetService("UserInputService").InputChanged:Connect(updateDrag)

-- Улучшенная функция для открытия Void Chest с плавным телепортом
local function openVoidChest()
    local success, err = pcall(function()
        local chest = workspace.Rendered.Generic["Void Chest"]
        if not chest then
            statusLabel.Text = "Status: Void Chest not found"
            return false
        end

        local outer = chest:FindFirstChild("Outer")
        if not outer then
            statusLabel.Text = "Status: Chest Outer not found"
            return false
        end

        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        -- Отключаем физику на время телепортации
        humanoidRootPart.Anchored = true
        statusLabel.Text = "Status: Teleporting to Void Chest..."
        
        -- Целевая позиция (немного выше сундука)
        local targetCFrame = outer.CFrame * CFrame.new(0, 3, 0)
        
        -- Параметры твина
        local tweenInfo = TweenInfo.new(
            1, -- Длительность телепортации (1 секунда)
            Enum.EasingStyle.Quad, -- Плавное ускорение и замедление
            Enum.EasingDirection.Out, -- Эффект замедления в конце
            0, -- Количество повторов
            false, -- Обратный твин
            0 -- Задержка перед началом
        )
        
        -- Создаем и запускаем твин
        local tween = game:GetService("TweenService"):Create(
            humanoidRootPart,
            tweenInfo,
            {CFrame = targetCFrame}
        )
        tween:Play()
        
        -- Ждем завершения твина
        tween.Completed:Wait()
        
        -- Включаем физику обратно
        humanoidRootPart.Anchored = false
        
        -- Небольшая задержка перед нажатием E
        task.wait(0.5)
        
        -- Нажимаем E несколько раз с интервалом
        for i = 1, 5 do
            if not isVoidChestActive then break end
            pressE()
            task.wait(0.3)
        end

        lastVoidChestTime = os.time()
        chestTimerLabel.Text = "Void Chest opened!"
        statusLabel.Text = "Status: Void Chest opened"
        return true
    end)

    if not success then
        statusLabel.Text = "Status: Error - " .. tostring(err)
        return false
    end
    return true
end

-- Улучшенный цикл фарма с поиском всех коллектаблей
local function farmCollectibles()
    local targetFolder = workspace.Rendered:GetChildren()[12]
    if not targetFolder then
        statusLabel.Text = "Status: Error - Folder not found"
        task.wait(0.3)
        return
    end

    -- Ищем все коллектабли (монеты, гемы и другие объекты)
    local teleportTargets = {}
    for _, child in ipairs(targetFolder:GetDescendants()) do
        if child:IsA("BasePart") and not isBannedPart(child) then
            -- Проверяем, является ли объект коллектаблем (по имени или другим признакам)
            local isCollectible = string.find(child.Name:lower(), "coin") or 
                                string.find(child.Name:lower(), "gem") or
                                string.find(child.Name:lower(), "collect") or
                                child:FindFirstChild("IsCollectible") ~= nil
            
            if isCollectible then
                table.insert(teleportTargets, child)
            end
        end
    end

    if #teleportTargets == 0 then
        statusLabel.Text = "Status: No collectibles found"
        task.wait(0.3)
        return
    end

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    -- Увеличиваем скорость ходьбы для более быстрого перемещения
    humanoid.WalkSpeed = playerWalkSpeed

    while isFarming and scriptActive and #teleportTargets > 0 do
        -- Находим ближайший объект
        local closestTarget = nil
        local closestDistance = math.huge
        local playerPos = humanoidRootPart.Position

        for i, part in ipairs(teleportTargets) do
            if part and part.Parent then -- Проверяем, что объект еще существует
                local distance = (part.Position - playerPos).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestTarget = part
                end
            else
                -- Удаляем несуществующие объекты
                table.remove(teleportTargets, i)
            end
        end

        if closestTarget then
            -- Удаляем обработанный объект из списка
            for i, part in ipairs(teleportTargets) do
                if part == closestTarget then
                    table.remove(teleportTargets, i)
                    break
                end
            end

            -- Обновляем статус
            statusLabel.Text = "Status: Moving to "..closestTarget.Name

            -- Целевая позиция (немного выше объекта)
            local targetCFrame = closestTarget.CFrame * CFrame.new(0, 3, 0)
            local distance = (closestTarget.Position - playerPos).Magnitude
            local duration = distance / humanoid.WalkSpeed -- Время зависит от расстояния и скорости

            -- Ограничиваем длительность для ускорения
            duration = math.clamp(duration, teleportDelay, 1.5) -- Минимум - установленная задержка, максимум 1.5 секунды

            -- Отключаем физику на время телепортации
            humanoidRootPart.Anchored = true
            
            -- Создаем и запускаем твин
            local tween = game:GetService("TweenService"):Create(
                humanoidRootPart,
                TweenInfo.new(duration, Enum.EasingStyle.Linear),
                {CFrame = targetCFrame}
            )
            tween:Play()
            
            -- Ждем завершения твина
            tween.Completed:Wait()
            
            -- Включаем физику обратно
            humanoidRootPart.Anchored = false
            
            -- Небольшая пауза между точками
            task.wait(0.1) -- Уменьшенная задержка для ускорения фарма
        else
            break
        end
    end
    
    -- Восстанавливаем обычную скорость при завершении фарма
    humanoid.WalkSpeed = 16
    
    -- Обновляем статус при завершении цикла сбора
    if not isFarming then
        statusLabel.Text = "Status: Paused"
    else
        statusLabel.Text = "Status: Collecting complete, searching..."
    end
end

-- Установка начального лимита FPS и задержки
updateFPSLimit(60)
updateTeleportDelay(0.1)

-- Главный цикл
while scriptActive do
    -- Обработка Void Chest
    if isVoidChestActive then
        local currentTime = os.time()
        if currentTime - lastVoidChestTime >= voidChestCooldown then
            openVoidChest()
        else
            local remaining = voidChestCooldown - (currentTime - lastVoidChestTime)
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60
            chestTimerLabel.Text = string.format("Next Void Chest: %02d:%02d", minutes, seconds)
        end
    end

    -- Обработка фарма
    if isFarming then
        local success, err = pcall(farmCollectibles)
        if not success then
            statusLabel.Text = "Status: Error - " .. tostring(err)
            task.wait(1)
        end
    end

    task.wait(0.5) -- Основная задержка цикла (уменьшена для более быстрого обновления)
end
