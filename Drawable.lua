Drawable = {}
Drawable.__index = Drawable

function Drawable:getX()
	return self.x
end

function Drawable:getY()
	return self.y
end

function Drawable:setX(newx)
	self.x = newx
end

function Drawable:setY(newy)
	self.y = newy
end

function Drawable:addDialog(dialog_list)
	self.dialog = dialog_list
	self.dialog_index = 0
end

function Drawable:loadAnimStand(filedir)
	self.standing = love.graphics.newImage(filedir)
	self.draw = self.standing
	self.default = self.standing
end

function Drawable:loadAnimDef(filedir)
	self.default = love.graphics.newImage(filedir)
	self.draw = self.default
end

function Drawable:loadAnimFidget(filedir)
	self.fidget = love.graphics.newImage(filedir)
end

function Drawable:loadAnimTalk(filedir)
	self.talking = love.graphics.newImage(filedir)
end

function Drawable:loadAnimWalkUp(filedir)
	self.walkup = love.graphics.newImage(filedir)
end

function Drawable:loadAnimWalkLeftRight(filedir)
	self.walkhorizon = love.graphics.newImage(filedir)
end

function Drawable:loadAnimWalkDown(filedir)
	self.walkdown = love.graphics.newImage(filedir)
end

function Drawable:reset()

end

function Drawable:getDraw()
	return self.draw
end

function Drawable:toggle(which)
	if which == "stand" then
		if self.curStanding then
			self.curStanding = false
			self.draw = self.fidget
		else
			self.curStanding = true
			self.draw = self.standing
		end
	elseif which == "talk" then
		if self.curTalking then
			self.curTalking = false
			self.draw = self.fidget
		else
			self.curTalking = true
			self.draw = self.talking
		end
	end
		
end


function Drawable:chgx(num)
	if self.x < 0 then
		self.x = 0
	elseif self.x > 730 then
		self.x = 730
	elseif self.x < 75 then
		self.x = 75
	else
		self.x = self.x + num
	end
end

function Drawable:chgy(num)
	if self.y < 0 then
		self.y = 0
	elseif self.y > 350 then
		self.y = 350
	elseif self.y < 25 then
		self.y = 25
	else
		self.y = self.y + num
	end
end

function Drawable.create(x,y, name)
	local draw = {}
	setmetatable(draw, Drawable)
	draw.x = x
	draw.y = y
	draw.name = name
	draw.talking = false
	draw.curTalking = false
	draw.curStanding = false
	return draw
end

