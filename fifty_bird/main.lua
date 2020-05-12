push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

nFont =  love.graphics.newFont('font.ttf',10)

local background  = love.graphics.newImage('background.png')
local ground = love.graphics.newImage("ground.png")

local backgroundScroll =0 
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()
local pipePairs = {}

local spawnTimer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

--local scrolling = true

function love.load()

	love.graphics.setDefaultFilter('nearest','nearest')
	love.window.setTitle('Zack_Kwalski(Shikhar)')

	math.randomseed(os.time())

	push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT, {
		vsync =true,
		fullscreen =false,
		resizable =true 
	})

	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)

	love.keyboard.keysPressed[key] = true
	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.update(dt)

	frameSpeed = dt 

	--if scrolling == true then

		backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED*dt) % BACKGROUND_LOOPING_POINT
		groundScroll = (groundScroll + GROUND_SCROLL_SPEED*dt) % VIRTUAL_WIDTH

		spawnTimer = spawnTimer + dt 

		if spawnTimer > 2  then
			local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-20,20), VIRTUAL_HEIGHT - 90 -PIPE_HEIGHT)) -- Spawning position ??
			lastY = y
			table.insert(pipePairs, PipePair(y))
	    	spawnTimer = 0  
		end

		bird:update(dt)

		for k, pair in pairs(pipePairs) do 
			pair:update(dt)

			--for l, pipe in pairs(pair.pipes) do

				--if bird:collision(pipe) then
				--	scrolling = false
				--end
			--end

			if pair.remove then
				table.remove(pipePairs , k)
			end
		end
	--end

	love.keyboard.keysPressed = {}
end

function love.draw()

	push:start()
	love.graphics.draw(background,-backgroundScroll,0)

	for k, pair in pairs(pipePairs) do
		pair:render()
	end

	love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT -16)
   
	bird:render()

	love.graphics.setFont(nFont)
	love.graphics.setColor(255,0, 0, 255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()),10,10)
	love.graphics.print(tostring(frameSpeed),100,10)
	push:finish()
end