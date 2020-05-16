PlayState = Class{__includes = BaseState}

PIPE_WIDTH = 70
PIPE_HEIGHT = 288
PIPE_SPEED = 60

function PlayState:init()
	
	self.timer = 0
	self.lastY = -PIPE_HEIGHT + math.random(80) + 20
	self.score = 0
end

function PlayState:update(dt)
        self.timer = self.timer + dt

        if self.timer > 2 then
            local y = math.max(-PIPE_HEIGHT + 10, 
                math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            self.lastY = y
            
            table.insert(pipePairs, PipePair(y))
            self.timer = 0
        end

        bird:update(dt)

        for k, pair in pairs(pipePairs) do

        	if not pair.scored then
        		if bird.x > pair.x + PIPE_WIDTH then
        			sounds['score']:play()
        			self.score = self.score + 1
        			pair.scored = true
        		end
        	end

            pair:update(dt)

            for l, pipe in pairs(pair.pipes) do
                if bird:collision(pipe) then
                	sounds['hurt']:play()
                	sounds['explosion']:play()
                    gStateMachine:change('score',{               --#1
                    	score = self.score
                    	})
                end
            end

            if pair.x < -PIPE_WIDTH then
                pair.remove = true
            end
        end

        for k, pair in pairs(pipePairs) do
            if pair.remove then
                table.remove(pipePairs, k)
            end
        end

        if bird.y > VIRTUAL_HEIGHT - 15 then
        	sounds['hurt']:play()
        	sounds['explosion']:play()
        	gStateMachine:change('score', {                    --#1
        		score = self.score
        		})
        end
end

function PlayState:render()
	for k, pair in pairs(pipePairs) do
        pair:render()
    end
    bird:render()

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score : '.. tostring(self.score), 0, 10)
end