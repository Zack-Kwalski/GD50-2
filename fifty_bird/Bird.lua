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

--function Bird:collsion(pipe)
--	if self.x + self.width - 2 >= pipe.x and self.x + 2 <= pipe.x + pipe.width then 
--		return (self.y + self.height - 2 >= pipe.y and self.y + 2 <= pipe.x + pipe.width)
--	end
--end
function Bird:update(dt)
	if love.keyboard.wasPressed('space') then
		self.yspeed  = -5
	end
	self.yspeed  = self.yspeed + GRAVITY*dt
	self.y = self.y + self.yspeed
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end