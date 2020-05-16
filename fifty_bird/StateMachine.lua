StateMachine  = Class{}

function StateMachine:init(states)
	self.empty = {
		render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
	}
	self.states = states or {}
	self.current  = self.empty
end

function StateMachine:change(stateName, enterParams)
	assert(self.states[stateName])
	self.current:exit()                           -- can a function be called separately for one variable ??
	self.current = self.states[stateName]()       -- what is the use of '()' ???
    self.current:enter(enterParams)
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:render()
	self.current:render()
end


