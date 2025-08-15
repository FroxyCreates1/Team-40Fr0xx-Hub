local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- ==== PLAYER ESP ====
local PlayersFolder = Workspace:WaitForChild("Players")

local PLAYER_ESP_NAME = "PlayerESP"
local COLOR_SURVIVOR = Color3.fromRGB(0, 255, 0)
local COLOR_KILLER = Color3.fromRGB(255, 0, 0)

local function applyPlayerESP(character, color)
	if not character:IsA("Model") then return end
	if character:FindFirstChild(PLAYER_ESP_NAME) then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = PLAYER_ESP_NAME
	highlight.FillColor = color
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 1
	highlight.Adornee = character
	highlight.Parent = character
	if character:FindFirstChild("Highlight") then
		character.Highlight:Destroy()
	end
end

-- Player ESP loop
RunService.Heartbeat:Connect(function()
	local survivors = PlayersFolder:FindFirstChild("Survivors")
	local killers = PlayersFolder:FindFirstChild("Killers")

	if survivors then
		for _, char in ipairs(survivors:GetChildren()) do
			applyPlayerESP(char, COLOR_SURVIVOR)
		end
	end

	if killers then
		for _, char in ipairs(killers:GetChildren()) do
			applyPlayerESP(char, COLOR_KILLER)
		end
	end
end)

-- ==== ITEM ESP ====
local ITEM_ESP_NAME = "ToolESPHighlight"

local function applyItemHighlight(tool, color)
	if not tool:FindFirstChild(ITEM_ESP_NAME) then
		local highlight = Instance.new("Highlight")
		highlight.Name = ITEM_ESP_NAME
		highlight.Adornee = tool
		highlight.FillColor = color
		highlight.OutlineColor = Color3.new(1, 1, 1)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.Parent = tool
	end
end

local function highlightToolIfNeeded(tool)
	if tool:IsA("Tool") then
		if tool.Name == "Medkit" then
			applyItemHighlight(tool, Color3.fromRGB(0, 255, 0))
		elseif tool.Name == "BloxyCola" then
			applyItemHighlight(tool, Color3.fromRGB(0, 150, 255))
		end
	end
end

-- Medkit and Cola Scan
for _, tool in ipairs(Workspace:GetDescendants()) do
	highlightToolIfNeeded(tool)
end

-- Look for new medkits and colas added
Workspace.DescendantAdded:Connect(function(descendant)
	highlightToolIfNeeded(descendant)
end)

-- ==== GENERATOR ESP ====
local GENERATOR_ESP_NAME = "GeneratorESP"

local function addGeneratorHighlight(model)
	if model:FindFirstChild(GENERATOR_ESP_NAME) then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = GENERATOR_ESP_NAME
	highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Yellow
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 1
	highlight.Adornee = model
	highlight.Parent = model
end

local function removeGeneratorHighlight(model)
	local existing = model:FindFirstChild(GENERATOR_ESP_NAME)
	if existing then
		existing:Destroy()
	end
end

local function trackGenerator(generator)
	local progress = generator:FindFirstChild("Progress")
	local instances = generator:FindFirstChild("Instances")

	if not progress or not instances then return end

	local genModel = instances:FindFirstChild("Generator")
	if not genModel or not genModel:IsA("Model") then return end

	-- Initial check
	if progress.Value < 100 then
		addGeneratorHighlight(genModel)
	else
		removeGeneratorHighlight(genModel)
	end

	-- remove highlight on generator done
	progress:GetPropertyChangedSignal("Value"):Connect(function()
		if progress.Value >= 100 then
			removeGeneratorHighlight(genModel)
		else
			addGeneratorHighlight(genModel)
		end
	end)
end

-- Generator ESP loop
RunService.Heartbeat:Connect(function()
	coroutine.wrap(function()
		local mapContainer
		game:GetService("TextChatService").ChatWindowConfiguration.Enabled = true

		-- Wait for the full path to exist
		repeat
			mapContainer = Workspace:FindFirstChild("Map")
			if mapContainer then
				mapContainer = mapContainer:FindFirstChild("Ingame")
				if mapContainer then
					mapContainer = mapContainer:FindFirstChild("Map")
				end
			end
			task.wait(1)
		until mapContainer

		-- Give it time to fully load
		task.wait(1)

		for _, gen in ipairs(mapContainer:GetChildren()) do
			if gen.Name == "Generator" and gen:IsA("Model") then
				trackGenerator(gen)
			end
		end
	end)()
end)
