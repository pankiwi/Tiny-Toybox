--https://github.com/Keyslam/Inky/blob/main/examples/menu/slider.lua

local Knob = Inky.defineElement(function(self)
	self.props.hovered = false

	self:onPointerEnter(function()
		self.props.hovered = true
	end)

	self:onPointerExit(function()
		self.props.hovered = false
	end)

	return function(_, x, y, w, h)
		love.graphics.setColor(0.8, 0.8, 0.8, 1)
		love.graphics.rectangle("fill", x + 3, y + 3, w - 6, h - 6, 2)

		if (self.props.hovered) then
			love.graphics.rectangle("line", x, y, w, h, 2)
		end
	end
end)

local function inverseLerp(a, b, v)
	return (v - a) / (b - a)
end

return Inky.defineElement(function(self, scene)
	self.props.color = self.props.color or {0.6, 0.6, 0.6}
	self.props.progress = self.props.progress or 0
	self.props.onProgress = self.props.onProgress or Utils.NILFUNCTION

	self.props._prog  = self.props.progress or 0

	local knob = Knob(scene)


	local function setProgress(pointerX)
		local x, _, w, _ = self:getView()
		local progress = inverseLerp(x, x + w, pointerX)
		progress = math.max(0, progress)
		progress = math.min(1, progress)

		self.props.progress = progress
	end

	self:onPointer("press", function(_, pointer)
		pointer:captureElement(self)

		local pointerX, _ = pointer:getPosition()
		setProgress(pointerX)
	end)

	self:onPointer("release", function(_, pointer)
		pointer:captureElement(self, false)

		Assets:Sound("knock"):play {
			pitch = math.random(1, 2.5)
		}

		Globals.Timer:tween(0.5, self.props, {_prog = self.props.progress})
	end)

	self:onPointer("drag", function(_, pointer)
		local pointerX, _ = pointer:getPosition()
		setProgress(pointerX)
	end)

	self:useEffect(function ()
		self.props.onProgress(self.props.progress)
	end, "progress")

	return function(_, x, y, w, h)
		do -- Rail
			local railHeight = h / 4
			local railY = y + (h - railHeight) / 2

			love.graphics.setColor(self.props.color)
			love.graphics.rectangle("fill", x, railY, w * self.props._prog, railHeight, 2)

			love.graphics.setColor(0.8, 0.8, 0.8, 1)
			love.graphics.rectangle("fill", x + w * self.props._prog, railY, w * (1 - self.props._prog), railHeight, 2)
		end

		do -- Knob
			local knobH = h
			local knobW = knobH
			local knobX = x + w * self.props.progress - knobW / 2
			local knobY = y

			knob:render(knobX, knobY, knobW, knobH)
		end
	end
end)