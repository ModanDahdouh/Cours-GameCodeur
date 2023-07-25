io.stdout:setvbuf("no")

lander = {}
lander.x = 0
lander.y = 0 
lander.angle = 270
lander.vx = 0 
lander.vy = 0
lander.speed = 1
lander.speed_R_L = 150
lander.engineOn = false 
lander.img = love.graphics.newImage("images/ship.png")
lander.imgEngine = love.graphics.newImage("images/engine.png")

function love.load ()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight() 
    lander.x = width/2
    lander.y = height/2 
end

function love.update(dt)
    
    if love.keyboard.isDown("right") then 
        lander.angle = lander.angle + (90 * dt) 
        lander.angle = (lander.angle) + (lander.speed_R_L * dt)
        if lander.angle > 360 then lander.angle = 0 end  
    end

    if love.keyboard.isDown("left") then
        lander.angle = lander.angle - (90 * dt )
        lander.angle = lander.angle - (lander.speed_R_L * dt)
        if lander.angle < 0 then lander.angle = 360 end
        
    end

    if love.keyboard.isDown("up") then 
        lander.engineOn = true 
        local angle_radian = math.rad(lander.angle)
        local force_x = math.cos(angle_radian) * (lander.speed * dt)
        local force_y = math.sin(angle_radian) * (lander.speed * dt)

        lander.vx = lander.vx + force_x
        lander.vy = lander.vy + force_y
    else
        lander.engineOn = false
    end

    lander.vy = lander.vy + (0.6 * dt )

    if math.abs(lander.vx) > 0.3 then 
        if lander.vx > 0 then 
            lander.vx = 0.3
          else
            lander.vx = - 0.3
        end
    end 
    if math.abs(lander.vy) > 0.3 then 
        if lander.vy > 0 then 
            lander.vy = 0.3
          else
            lander.vy = - 0.3
        end
    end 

    lander.x = lander.x + lander.vx
    lander.y = lander.y + lander.vy
    
end

function love.draw ()
    love.graphics.draw(lander.img,lander.x,lander.y,math.rad(lander.angle),1,1,lander.img:getWidth()/2,lander.img:getHeight()/2)
    if lander.engineOn == true then 
    love.graphics.draw(lander.imgEngine,lander.x,lander.y,math.rad(lander.angle),1,1,lander.imgEngine:getWidth()/2,lander.imgEngine:getHeight()/2)
    end
    local sDebug = "sDebug" 
    sDebug = sDebug.." angle= "..tostring(lander.angle)
    sDebug = sDebug.." vx= "..tostring(lander.vx)
    sDebug = sDebug.." vy= "..tostring(lander.vy)
    love.graphics.print(sDebug)
end
