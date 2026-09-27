local Weave = loadstring(game:HttpGet("https://raw.githubusercontent.com/SvenaEE/Testlibary-/refs/heads/main/Weave-Release"))()

local Window = Weave:CreateWindow({
    Name = "Project Nova",
    LoadingSubtitle = "Sky Changer",
    ConfigurationSaving = { Enabled = true, FolderName = nil, FileName = "ProjectNova" },
    KeySystem = false,
    ToggleKey = Enum.KeyCode.RightShift
})

local Lighting = game:GetService("Lighting")
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local SKY_DATA = {
    ["Blue Night Sky"] = {
        Bk = "rbxassetid://1233158420", Dn = "rbxassetid://1233158838", Ft = "rbxassetid://1233157105",
        Lf = "rbxassetid://1233157640", Rt = "rbxassetid://1233157995", Up = "rbxassetid://1233159158"
    },
    ["Anime Island Sky"] = {
        Bk = "rbxassetid://14753804949", Dn = "rbxassetid://14753795573", Ft = "rbxassetid://14753807625",
        Lf = "rbxassetid://14753797417", Rt = "rbxassetid://14753799966", Up = "rbxassetid://14753810287"
    },
    ["Blue And Purple Sky"] = {
        Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021016390", Ft = "rbxassetid://6021015479",
        Lf = "rbxassetid://6021014807", Rt = "rbxassetid://6021012347", Up = "rbxassetid://6021011228"
    },
    ["Blue Aurora Mountains"] = {
        Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621",
        Lf = "rbxassetid://134105463289425", Rt = "rbxassetid://89099449712918", Up = "rbxassetid://138429250948648"
    },
    ["Cartoon Sky"] = {
        Bk = "rbxassetid://5333954202", Dn = "rbxassetid://5333944933", Ft = "rbxassetid://5333954202",
        Lf = "rbxassetid://5333954202", Rt = "rbxassetid://5333954202", Up = "rbxassetid://5333943668"
    },
    ["Cloudy Winter Sky"] = {
        Bk = "rbxassetid://7307273436", Dn = "rbxassetid://7307275898", Ft = "rbxassetid://7307282434",
        Lf = "rbxassetid://7307284944", Rt = "rbxassetid://7307287254", Up = "rbxassetid://7307289342"
    },
    ["Dune Sky"] = {
        Bk = "rbxassetid://138907351102721", Dn = "rbxassetid://138907351102721", Ft = "rbxassetid://138907351102721",
        Lf = "rbxassetid://138907351102721", Rt = "rbxassetid://138907351102721", Up = "rbxassetid://138907351102721"
    },
    ["Fantasy Aurora Borealis Sky"] = {
        Bk = "rbxassetid://138907351102721", Dn = "rbxassetid://138907351102721", Ft = "rbxassetid://138907351102721",
        Lf = "rbxassetid://138907351102721", Rt = "rbxassetid://138907351102721", Up = "rbxassetid://138907351102721"
    },
    ["Galaxy Beam Sky"] = {
        Bk = "rbxassetid://138907351102721", Dn = "rbxassetid://138907351102721", Ft = "rbxassetid://138907351102721",
        Lf = "rbxassetid://138907351102721", Rt = "rbxassetid://138907351102721", Up = "rbxassetid://138907351102721"
    },
    ["Twin Mountain Night Sky"] = {
        Bk = "rbxassetid://138907351102721", Dn = "rbxassetid://138907351102721", Ft = "rbxassetid://138907351102721",
        Lf = "rbxassetid://138907351102721", Rt = "rbxassetid://138907351102721", Up = "rbxassetid://138907351102721"
    },
    ["Dark Clouds Orange Atmosphere Sky"] = {
        Bk = "rbxassetid://138907351102721", Dn = "rbxassetid://138907351102721", Ft = "rbxassetid://138907351102721",
        Lf = "rbxassetid://138907351102721", Rt = "rbxassetid://138907351102721", Up = "rbxassetid://138907351102721"
    },
    ["Sun Halo Sky"] = {
        Bk = "rbxassetid://138907351102721", Dn = "rbxassetid://138907351102721", Ft = "rbxassetid://138907351102721",
        Lf = "rbxassetid://138907351102721", Rt = "rbxassetid://138907351102721", Up = "rbxassetid://138907351102721"
    },
}

local CurrentSky = "Blue Night Sky"
local SkyEnabled = false

local function ApplySky()
    local oldSky = Lighting:FindFirstChildOfClass("Sky")
    if oldSky then oldSky:Destroy() end
    if not SkyEnabled then return end
    local data = SKY_DATA[CurrentSky]
    if not data then return end
    local sky = Instance.new("Sky")
    sky.SkyboxBk = data.Bk
    sky.SkyboxDn = data.Dn
    sky.SkyboxFt = data.Ft
    sky.SkyboxLf = data.Lf
    sky.SkyboxRt = data.Rt
    sky.SkyboxUp = data.Up
    sky.Parent = Lighting
end

local function Notify(t, d, dur)
    Weave:Notify({ Title = t, Content = d, Duration = dur or 3 })
end

local AntiAFKConn = nil
local function ServerHop()
    local ok, result = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")
    end)
    if ok and result then
        local data = HttpService:JSONDecode(result)
        if data and data.data and #data.data > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, data.data[math.random(#data.data)].id, LocalPlayer)
        end
    end
end

local wmGui = Instance.new("ScreenGui", PlayerGui)
wmGui.Name = "NovaWatermark"
wmGui.ResetOnSpawn = false
wmGui.DisplayOrder = 999999
local wmFrame = Instance.new("Frame", wmGui)
wmFrame.Size = UDim2.fromOffset(220, 32)
wmFrame.Position = UDim2.new(1, -230, 0, 10)
wmFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
wmFrame.BorderSizePixel = 0
Instance.new("UICorner", wmFrame).CornerRadius = UDim.new(0, 8)
local wmLabel = Instance.new("TextLabel", wmFrame)
wmLabel.Size = UDim2.new(1, -40, 1, 0)
wmLabel.Position = UDim2.fromOffset(10, 0)
wmLabel.BackgroundTransparency = 1
wmLabel.Text = "Project Nova | Toggle"
wmLabel.TextColor3 = Color3.fromRGB(170, 0, 255)
wmLabel.TextSize = 13
wmLabel.Font = Enum.Font.GothamBold
wmLabel.TextXAlignment = Enum.TextXAlignment.Left
local wmBtn = Instance.new("TextButton", wmFrame)
wmBtn.Size = UDim2.fromOffset(30, 26)
wmBtn.Position = UDim2.new(1, -32, 0, 3)
wmBtn.BackgroundTransparency = 1
wmBtn.Text = "O"
wmBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
wmBtn.TextSize = 18
wmBtn.Font = Enum.Font.GothamBold

local menuOpen = true
wmBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if Window.SetVisible then Window:SetVisible(menuOpen) elseif Window.Toggle then Window:Toggle() end
    wmBtn.Text = menuOpen and "O" or "X"
    wmBtn.TextColor3 = menuOpen and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 65, 65)
end)

local dragging, dragStart, startPos = false, nil, nil
wmFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = wmFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        wmFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local WorldTab = Window:CreateTab("World", "globe")
local SkySec = WorldTab:CreateSection("Sky Changer")
SkySec:CreateToggle({ Name = "Enabled", CurrentValue = false, Callback = function(v)
    SkyEnabled = v
    ApplySky()
end })
SkySec:CreateDropdown({ Name = "Sky", Options = {
    "Blue Night Sky", "Anime Island Sky", "Blue And Purple Sky", "Blue Aurora Mountains",
    "Cartoon Sky", "Cloudy Winter Sky", "Dune Sky", "Fantasy Aurora Borealis Sky",
    "Galaxy Beam Sky", "Twin Mountain Night Sky", "Dark Clouds Orange Atmosphere Sky", "Sun Halo Sky"
}, CurrentOption = "Blue Night Sky", Callback = function(v)
    CurrentSky = v
    ApplySky()
end })

local USec = Window:CreateTab("Utility", "settings")
USec:CreateButton({ Name = "Reconnect", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end })
USec:CreateButton({ Name = "Server Hop", Callback = ServerHop })
USec:CreateToggle({ Name = "Anti-AFK", CurrentValue = false, Callback = function(v)
    if v then
        AntiAFKConn = RunService.Heartbeat:Connect(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
        end)
    elseif AntiAFKConn then
        AntiAFKConn:Disconnect()
        AntiAFKConn = nil
    end
end })

Notify("Project Nova", "Sky Changer loaded", 4)
