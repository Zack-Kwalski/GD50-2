Bird = Class{}

local GRAVITY = 20

function Bird:init()
	self.image = love.graphics.newImage('bird.png')
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = VIRTUAL_WIDTH/2 - self.width/2
	self.y = VIRTUAL_HEIGHT/2 - self.height/2
	self.yspeed = 0
end

function Bird:collision(pipe)
	if (self.x + self.width - 2 >= pipe.x) and (self.x + 2 <= pipe.x + pipe.width) then 
		return (self.y + self.height - 2) >= pipe.y and (self.y + 2) <= (pipe.y + pipe.height)
	--if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
      --  return (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT
    end 
end
function Bird:update(dt)
	if love.keyboard.wasPressed('space') then
		sounds['jump']:play()
		self.yspeed  = -5
	end
	self.yspeed  = self.yspeed + GRAVITY*dt
	self.y = self.y + self.yspeed
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end