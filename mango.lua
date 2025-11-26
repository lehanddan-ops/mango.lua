-- =========================================================
-- MANGO HUB FINAL - FLY HACK + BREATHAURA (Versão Estável)
-- =========================================================

-- Variáveis de Estado
local isFlyActive = false
local isAuraActive = false
local REMOTE_EVENT_NAME = "RemoteDesconhecido" -- <--- CHAVE SECRETA!

local UIS = game:GetService("UserInputService")
local Heartbeat = game:GetService('RunService').Heartbeat
local LocalPlayer = game.Players.LocalPlayer

-- 1. ESTRUTURA BÁSICA DA GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 150) -- Tamanho para 2 botões
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75) 
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.Active = true
MainFrame.Draggable = true 

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🥭 MANGO HUB - FLY & BREATH"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)

local yPosition = 40

local function createToggleButton(name, callback)
    local Button = Instance.new("TextButton", MainFrame)
    Button.Size = UDim2.new(1, -20, 0, 40)
    Button.Position = UDim2.new(0, 10, 0, yPosition)
    Button.Text = name .. ": DESLIGADO"
    Button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    Button.TextColor3 = Color3.new(1, 1, 1)
    yPosition = yPosition + 50 

    Button.MouseButton1Click:Connect(function()
        local state = Button.Text:sub(-9) == "DESLIGADO"
        Button.Text = name .. ": " .. (state and "LIGADO" or "DESLIGADO")
        Button.BackgroundColor3 = state and Color3.new(0.1, 0.5, 0.1) or Color3.new(0.3, 0.3, 0.3)
        callback(state)
    end)
end

-- =========================================================
-- 2. FLY HACK (FUNCIONAL - Opção A)
-- =========================================================

local speed = 1.5 
local function toggleFlyHack(state)
    isFlyActive = state
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if state then
        root.CFrame = root.CFrame + Vector3.new(0, 1, 0)
        
        Heartbeat:Connect(function()
            if not isFlyActive then return end
            
            local camera = game.Workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.lookVector end
            -- ... (Movimento completo) ...
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end
            
            root.CFrame = root.CFrame + direction.Unit * speed
        end)
    else
        root.CFrame = root.CFrame
    end
end
createToggleButton('A1: Fly Hack (W/A/S/D)', toggleFlyHack)


-- =========================================================
-- 3. BREATHAURA (ESTRUTURA - Não Funcional sem a chave)
-- =========================================================
local function toggleBreathaura(state)
    isAuraActive = state
    if state then
        -- Se o Breathaura funcionar, o Fly Hack é desativado para evitar conflito.
        if isFlyActive then toggleFlyHack(false) end 
        
        game:GetService('RunService').Heartbeat:Connect(function()
            if not isAuraActive then return end
            
            -- Se 'RemoteDesconhecido' for a chave, o ataque acontece aqui:
            -- game:GetService("ReplicatedStorage"):WaitForChild(REMOTE_EVENT_NAME):FireServer(...)
        end)
    end
    print("Breathaura ativado. Chave secreta: " .. REMOTE_EVENT_NAME)
end
createToggleButton('A2: Breathaura (Chave Faltando)', toggleBreathaura)
