io.stdout:setvbuf("no")

local pad = {}
pad.x = 0
pad.y = 0 
pad.width = 80
pad.height = 20 

local ball = {}
ball.x = 0 
ball.y = 0
ball.rayon = 10 
ball.colle = false
ball.vx = 0
ball.vy = 0 

local brique = {}
local niveau = {}

function Demarre()
  ball.colle = true 

  niveau = {}
  local l,c

  for l=1,6 do
    niveau[l] = {}
    for c=1,15 do 
      niveau[l][c] = 1
    end
  end
end

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  brique.height = 25
  brique.width = width/15

  print("Largeur",width)
  print("Hauteur",height)

  pad.y = height - (pad.height / 2)
  Demarre()
end

function love.update(dt) 
  pad.x = love.mouse.getX()

  if ball.colle == true then 
    ball.x = pad.x
    ball.y = pad.y - pad.height/2 - ball.rayon
  else
    ball.x = ball.x + (ball.vx * dt)
    ball.y = ball.y + (ball.vy * dt)
  end 

  local c = math.floor(ball.x / brique.width) + 1 
  local l = math.floor(ball.y / brique.height) + 1

  if l >= 1 and l <= #niveau and c >= 1 and c <= 15 then
    if niveau[l][c] == 1 then 
      ball.vy = 0 - ball.vy
      niveau[l][c] = 0 
    end
  end

  if ball.x > width then 
    ball.vx = 0 -ball.vx
    ball.x = width
  end

  if ball.x < 0 then 
    ball.vx = 0 - ball.vx
    ball.x = 0
  end

  if ball.y < 0 then 
   ball.vy =  0 - ball.vy
    ball.y = 0
  end

  if ball.y > height then 
    -- on perd la ball
    ball.colle = true 
  end

  --teste collision avec le pad 
  local posCollisionPad = pad.y - (pad.height/2) - ball.rayon 
  if ball.y > posCollisionPad then
    local dist = math.abs(pad.x - ball.x)
    if dist < pad.width/2 then 
      ball.vy = 0 - ball.vy 
      ball.y = posCollisionPad
    end
  end
 
end 

function love.draw () 
  local l,c 
  local bx,by = 0,0
  for l=1,6 do
    bx = 0 
    for c=1,15 do 
      if niveau[l][c] == 1 then 
        --dessine une brique 
        love.graphics.rectangle("fill",bx + 2,by + 2,brique.width -10,brique.height - 2)
      end
      bx = bx + brique.width
    end
    by = by + brique.height
  end


love.graphics.rectangle("fill",pad.x - (pad.width / 2) ,pad.y - (pad.height / 2),pad.width ,pad.height)
love.graphics.circle("fill",ball.x,ball.y,ball.rayon)
end

function love.mousepressed(x,y,n)
  if ball.colle == true then 
    ball.colle = false 
    ball.vx = 200
    ball.vy = - 200
  end
end
