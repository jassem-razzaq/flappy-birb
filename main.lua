require("math")

function love.load()
  number = 0
  sec = 0
end

function love.update(dt)
  number = number + 1
  if(math.fmod(number, 60) == 0) then
    sec = sec + 1
  end
end

function love.draw()
  
  love.graphics.print(sec)
end