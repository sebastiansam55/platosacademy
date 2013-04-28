CreditItem = {}
CreditItem.__index = CreditItem


function CreditItem.create(x,y, descrip, text, fontdir, size)
	local item = {}
	setmetatable(item, CreditItem)
	item.x = x
	item.y = y
	item.text = text
	item.des = descrip
	item.font = love.graphics.newFont(fontdir, size)
	return item
end

function CreditItem.create(x,y, text)
	local item = {}
	setmetatable(item, CreditItem)
	item.x = x
	item.y = y
	item.text = text
	return item
end

function CreditItem:draw()
	--local oldfont = love.graphics.getFont()
	--love.grapics.setFont(self.font)
	--love.graphics.print(self.descrip, self.x, self.y)
	love.graphics.print(self.text, self.x, self.y)
	--love.graphics.setFont(oldfont)
end