InfoTable = {}
InfoTable.__index = InfoTable

function drawTemplate()
	love.graphics.circle("line", 400, 225, 55)
	love.graphics.circle("fill", 400, 225, 50)
	love.graphics.rectangle("line", 470, 170, 100, 130)
	love.graphics.print("Birth:", 472, 185)
	love.graphics.print("Birth City:", 472, 220)
	love.graphics.print("Death:", 472, 255)
end

function InfoTable.create()
	local infotable = {}
	setmetatable(infotable, InfoTable)
	return infotable
end

function InfoTable:drawInfo()
	drawTemplate()
	love.graphics.draw(self.mugshot, 365, 190)
	love.graphics.print(self.name, 480, 170)
	love.graphics.print(self.yob, 474, 200)
	love.graphics.print(self.city, 474, 235)
	love.graphics.print(self.dod, 474, 270)
end

function InfoTable:addMugshot(shotdir)
	self.mugshot = love.graphics.newImage(shotdir)
end

function InfoTable:addName(name)
	self.name = name
end

function InfoTable:addBirthYear(birth)
	self.yob = birth
end

function InfoTable:addBirthCity(city)
	self.city = city
end

function InfoTable:addDeathYear(year)
	self.dod = year
end