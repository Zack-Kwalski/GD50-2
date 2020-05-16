ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)                                 --#1
	self.score = params.score
end

function ScoreState:update(dt)
	if --love.keyboard.wasPressed('enter') or
	 love.keyboard.wasPressed('return') or love.mouse.wasPressed(1) then
		gStateMachine:change('countdown')
	end
end

function ScoreState:render()
	for k, pair in pairs(pipePairs) do
        pair:render()
    end
    bird:render()

	love.graphics.setFont(flappyFont)
	love.graphics.printf('GAME OVER !',0,64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
	love.graphics.printf('Score :' .. tostring(self.score),0,100, VIRTUAL_WIDTH, 'center')

	love.graphics.printf('Press Enter To Play Again',0,160, VIRTUAL_WIDTH, 'center')
end