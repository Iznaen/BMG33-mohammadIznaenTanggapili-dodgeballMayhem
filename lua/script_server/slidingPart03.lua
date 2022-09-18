local slidingPart = {}

local part = nil
local maxPosition = Vector3.new(16, 6, 6)
local minPosition = Vector3.new(16, 6, -5) 
local startPosition = Vector3.new(16, 6, 2)
local speed = 0.095
local nextPosition = nil
local intervalVector = nil
local timer = nil

local function Move()
  local distance = Vector3.Distance(part.WorldPosition, nextPosition)
  
  if distance < 0.5 then
    local isMinPosition = nextPosition == minPosition
    nextPosition = isMinPosition and maxPosition or minPosition
    
    local direction = nextPosition - part.WorldPosition
    intervalVector = direction.Normalized * speed
  
  else
    part.WorldPosition = part.WorldPosition + intervalVector
  end
end

function slidingPart:Start(map)
  part = map.Root:FindFirstChild("slidingPart03", true)
  part.WorldPosition = startPosition
  
  nextPosition = minPosition
  local direction = nextPosition - part.WorldPosition
  intervalVector = direction.Normalized * speed
  
  timer = Timer.new (1, Move)
  timer.Loop = true
  timer:Start()
end


return slidingPart