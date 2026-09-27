local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local Skies = {
    ["Nebula Purple"] = {
        SkyboxBk = "rbxassetid://159454299",
        SkyboxDn = "rbxassetid://159454296",
        SkyboxFt = "rbxassetid://159454293",
        SkyboxLf = "rbxassetid://159454286",
        SkyboxRt = "rbxassetid://159454300",
        SkyboxUp = "rbxassetid://159454288",
        StarCount = 8000,
    },
    ["Galaxy Night"] = {
        SkyboxBk = "rbxassetid://12064107",
        SkyboxDn = "rbxassetid://12064152",
        SkyboxFt = "rbxassetid://12064121",
        SkyboxLf = "rbxassetid://12063984",
        SkyboxRt = "rbxassetid://12064115",
        SkyboxUp = "rbxassetid://12064136",
        StarCount = 5000,
    },
    ["Aurora Borealis"] = {
        SkyboxBk = "rbxassetid://251248383",
        SkyboxDn = "rbxassetid://251248395",
        SkyboxFt = "rbxassetid://251248379",
        SkyboxLf = "rbxassetid://251248374",
        SkyboxRt = "rbxassetid://251248392",
        SkyboxUp = "rbxassetid://251248387",
        StarCount = 6000,
    },
    ["Purple Nebula"] = {
        SkyboxBk = "rbxassetid://1876545003",
        SkyboxDn = "rbxassetid://1876545368",
        SkyboxFt = "rbxassetid://1876545709",
        SkyboxLf = "rbxassetid://1876546002",
        SkyboxRt = "rbxassetid://1876545156",
        SkyboxUp = "rbxassetid://1876545584",
        StarCount = 9000,
    },
    ["Deep Space"] = {
        SkyboxBk = "rbxassetid://271057365",
        SkyboxDn = "rbxassetid://271057412",
        SkyboxFt = "rbxassetid://271057458",
        SkyboxLf = "rbxassetid://271057503",
        SkyboxRt = "rbxassetid://271057541",
        SkyboxUp = "rbxassetid://271057574",
        StarCount = 7000,
    },
    ["Blue Nebula"] = {
        SkyboxBk = "rbxassetid://159454299",
        SkyboxDn = "rbxassetid://159454296",
        SkyboxFt = "rbxassetid://159454293",
        SkyboxLf = "rbxassetid://159454286",
        SkyboxRt = "rbxassetid://159454300",
        SkyboxUp = "rbxassetid://159454288",
        StarCount = 12000,
    },
}

local oldSky = Lighting:FindFirstChildOfClass("Sky")

local function applySky(data)
    if oldSky then
        oldSky:Destroy()
        oldSky = nil
    end

    local sky = Instance.new("Sky")
    sky.Name = "CustomSky"
    sky.SkyboxBk = data.SkyboxBk
    sky.SkyboxDn = data.SkyboxDn
    sky.SkyboxFt = data.SkyboxFt
    sky.SkyboxLf = data.SkyboxLf
    sky.SkyboxRt = data.SkyboxRt
    sky.SkyboxUp = data.SkyboxUp
    sky.StarCount = data.StarCount or 3000
    sky.SunAngularSize = 21
    sky.MoonAngularSize = 21
    sky.Parent = Lighting

    Lighting.FogEnd = 100000
    Lighting.FogStart = 0
    Lighting.Brightness = 2
    Lighting.ClockTime = 0
    Lighting.Ambient = Color3.fromRGB(80, 80, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 130)
    Lighting.EnvironmentDiffuseScale = 0.5
    Lighting.EnvironmentSpecularScale = 0.5
end

local gui = Instance.new("ScreenGui")
gui.Name = "SkyChanger"
gui.ResetOnSpawn = false
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 340)
frame.Position = UDim2.new(0.5, -130, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(150, 100, 255)
stroke.Thickness = 2
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "🌌 Sky Changer"
title.TextColor3 = Color3.fromRGB(200, 170, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(60, 30, 80)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 150, 150)
close.TextScaled = true
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.Parent = frame

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = close

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 55)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

for name, data in pairs(Skies) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(40, 25, 65)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(230, 220, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Parent = scroll

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = btn

    local bs = Instance.new("UIStroke")
    bs.Color = Color3.fromRGB(120, 80, 200)
    bs.Thickness = 1
    bs.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 45, 110)
    end)

    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 25, 65)
    end)

    btn.MouseButton1Click:Connect(function()
        applySky(data)
    end)
end

local reset = Instance.new("TextButton")
reset.Size = UDim2.new(1, -6, 0, 34)
reset.BackgroundColor3 = Color3.fromRGB(80, 30, 50)
reset.Text = "Reset Sky"
reset.TextColor3 = Color3.fromRGB(255, 200, 200)
reset.TextScaled = true
reset.Font = Enum.Font.GothamBold
reset.BorderSizePixel = 0
reset.Parent = scroll

local rc = Instance.new("UICorner")
rc.CornerRadius = UDim.new(0, 8)
rc.Parent = reset

reset.MouseButton1Click:Connect(function()
    local s = Lighting:FindFirstChild("CustomSky")
    if s then s:Destroy() end
    if oldSky then
        oldSky.Parent = Lighting
    end
end)
