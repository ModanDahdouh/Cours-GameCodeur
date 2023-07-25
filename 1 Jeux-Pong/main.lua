-- jeux ping pong entrainement 
pad_1 = {}

pad_1.x = 20
pad_1.y = 290
pad_1.width = 20
pad_1.height = 80

pad_2 = {}

pad_2.x = 760
pad_2.y = 290
pad_2.width = 20
pad_2.height = 80

ball = {}

ball.x = 390
ball.y = 290
ball.width = 20 
ball.height = 20
ball.speed_x = 1
ball.speed_y = 1

ScoreJoueur_1 = 0
ScoreJoueur_2 = 0 

terein = {}

terein.x = 395
terein.y = 30
terein.width = 2
terein.height = 770

listeTrail = {}

function CentreBall_2 ()
  ball.x = love.graphics.getWidth () / 2 - ball.width / 2 
  ball.y = love.graphics.getHeight () / 2  - ball.height /2
  ball.speed_x = -1
  ball.speed_y = -1
  --reset pad1 pad2 quand on marque un but 
  pad_1.x = 0
  pad_1.y = 0 
  pad_2.x = love.graphics.getWidth () - pad_2.width
  pad_2.y = love.graphics.getHeight () - pad_2.height
end

function CentreBall () 
  ball.x = love.graphics.getWidth () / 2 - ball.width / 2 
  ball.y = love.graphics.getHeight () / 2  - ball.height /2
  ball.speed_x = 1
  ball.speed_y = 1
  pad_2.x = love.graphics.getWidth () - pad_2.width
  pad_2.y = love.graphics.getHeight () - pad_2.height
end

function love.load ()
  CentreBall() 
  CentreBall_2()
end

function love.update (dt)

  if love.keyboard.isDown("z")   and pad_1.y  > 0 then 
    pad_1.y = pad_1.y - 3
  end
  if love.keyboard.isDown("s") and pad_1.height < love.graphics.getHeight () - pad_1.y then -- bloque le pad de sortir du ecran 
    pad_1.y = pad_1.y + 3 
  end
  if love.keyboard.isDown("up") and pad_2.y > 0 then 
    pad_2.y = pad_2.y - 3 
  end
  if love.keyboard.isDown("down") and pad_2.height < love.graphics.getHeight () - pad_2.y then 
    pad_2.y = pad_2.y + 3 
  end
  
  for n=#listeTrail,1,-1 do 
    local t = listeTrail[n]
    t.vie = t.vie - dt 
    t.x = t.x + t.vx 
    t.y = t.y + t.vy
    if t.vie <= 0 then 
      table.remove(listeTrail,n)
    end
  end
  
  local maTrainee = {} -- avant que la ball bouje 
  maTrainee.x = ball.x
  maTrainee.y = ball.y
  maTrainee.vx = math.random()
  maTrainee.vy = math.random()
  maTrainee.vie = 1
  maTrainee.r = math.random()
  maTrainee.v = math.random() 
  maTrainee.b = math.random()
  
  table.insert(listeTrail,maTrainee)
  
  ball.x = ball.x + ball.speed_x
  ball.y = ball.y + ball.speed_y
  
  -- rebond 
  if ball.x > love.graphics.getWidth () - ball.width then 
    ball.speed_x = ball.speed_x *-1
    CentreBall () 
    ScoreJoueur_1 = ScoreJoueur_1 + 1 
  end
  if ball.y > love.graphics.getHeight () - ball.height then 
    ball.speed_y = -ball.speed_y 
  end
  if ball.x < 0 then
     CentreBall_2 ()
     ScoreJoueur_2 = ScoreJoueur_2 + 1 
  end
  
  if ball.y < 0 then 
    ball.speed_y = ball.speed_y*-1 
     
  end
  -- faire rebondir la ball sur le pad 
  if ball.x <=  pad_1.x + pad_1.width then
    
    if ball.y + ball.height > pad_1.y and ball.y < pad_1.y + pad_1.height then 
       ball.speed_x = -ball.speed_x
       ball.x = pad_1.x + pad_1.width
    end
  end
  if ball.x + ball.width > pad_2.x  then 
    
    if ball.y + ball.height > pad_2.y and ball.y < pad_2.y + pad_2.height then 
       ball.speed_x = -ball.speed_x
    end
  end
end 

function love.draw () -- affiche les graphics
  love.graphics.rectangle("fill",pad_1.x,pad_1.y,pad_1.width,pad_1.height)
  love.graphics.rectangle("fill",pad_2.x,pad_2.y,pad_2.width,pad_2.height)
  -- dessin la trainee
  for n = 1,#listeTrail do 
    local t = listeTrail[n]
     --bleu 
     --love.graphics.setColor(0.5,0.5,1, t.vie/4)
     love.graphics.setColor(t.v,t.b,t.r,t.vie/2)
     -- ball fantome
     --love.graphics.rectangle("fill",t.x,t.y,ball.width,ball.height)
     -- bulles
     --love.graphics.circle("line",t.x + ball.width/2,t.y + ball.height/2,5)
     -- ball fantome 2 
     love.graphics.rectangle("fill",t.x,t.y,ball.width,ball.height)
  end
  
  love.graphics.setColor(1,1,1,1)
  love.graphics.rectangle("fill",terein.x,terein.y,terein. width,terein.height)
  love.graphics.rectangle("fill",ball.x,ball.y,ball.width,ball.height)
  -- affichage score centre sur lecran
  local Score = ScoreJoueur_1.."   "..ScoreJoueur_2
  love.graphics.print(Score,380,10)
end