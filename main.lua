require("Drawable")
require("InfoTable")

step = 1
mode = "none"

count = 0

dialog_list_totle = {"Hello, I am Aristotle!", "I tutored Alexander the Great!", "He who has overcome his fears will truly be free",
"Misfortune shows those who are not really friends",
"Without friends no one would choose to live, though he had all other goods",
"Man is by nature a polictial animal",
"Nature does nothing uselessly",
"They should rule who are able to rule best"
}

dialog_plato = 1
dialog_list_plato = {
"Hello, I am Plato, and welcome to my Academy.", 
"I created this academy in 387 BC and it became the place of teaching for many famous philosophers.", 
"The most famous philosopher to study here was Aristotle, who remained here for twenty years!",
"Take a look around and talk to the people here, I'm sure you'll find it interesting and maybe learn something new!",
"Have fun!"
}

dialog_list_speu = {"Hello, I am Speusippus!", "I was the first head of the academy after Plato",

}
dialog_list_arce = {"Hello, I am Arcesilaus!", 
"Where you find the laws most numerous, there you will find also the greatest injustice", "dolet", "test"}

loading_screen = true
plato_screen = false

function love.keypressed(key, unicode)
	if optionmenu and ((unicode >= 48 and unicode <= 57) or (unicode==61 or unicode==45)) then
		if subtractstep and (unicode >= 48 and unicode <= 57) then
			step = step-key				
		elseif addstep and (unicode >= 48 and unicode <= 57) then
			step = step+math.abs(key)
		end
	
		if key=="=" then
			mode = "addition"
			addstep = true
			subtractstep = false
		elseif key=="-" then
			mode = "subtraction"
			subtractstep = true
			addstep = false
		end
	
	end
	if key=="w" or key=="up" then
		moveup()
	elseif key=="s" or key=="down" then
		movedown()
	elseif key=="a" or key=="left" then
		moveleft()
	elseif key=="d" or key=="right" then
		moveright()
	elseif key==" " then
		if loading_screen then
			loading_screen = false
			plato_screen = true
				
		else
			tryspeak()
		end
	elseif key=="escape" then
		options()
	elseif key=="m" then
		love.audio.stop()
	elseif key=="n" then
		love.audio.play(love.audio.newSource("aoeIII.mp3"))
	elseif key=="r" then
		step = 1
		loading_screen = true
		for i = 1, table.getn(drawables) do
			drawables[i].talk = false
			drawables[i].dialog_index = 0
		end		
		dialog_plato = 1
		plato_screen = false
	elseif key=="q" then
		love.event.push("quit")	
	else
		todrawplayer = player_standing
	end
end

function love.load()
	
	oldefont = love.graphics.newFont("roman.ttf", 20)
	talkfont = love.graphics.newFont("roman.ttf", 30)
	love.graphics.setFont( oldefont )

	plato_mugshot = love.graphics.newImage("info/plato.jpg")
	--love.audio.play(love.audio.newSource("aoeIII.mp3"))
	
	ball = Drawable.create(400, 300, "bouncy ball")
	ball.destx = 0
	ball.desty = 0
	
	aristotle = Drawable.create(60, 250, "aristotle")

	aristotle:addDialog(dialog_list_totle)
	aristotle:loadAnimStand("totle/totleStand.png")
	aristotle:loadAnimTalk("totle/totleTalking.png")
	aristotle:loadAnimFidget("totle/totleFidget.png")
	
	speusippus = Drawable.create(400, 100, "speusippus")
	
	speusippus:addDialog(dialog_list_speu)
	speusippus:loadAnimStand("speu/speuStand.png")
	speusippus:loadAnimTalk("speu/speuTalk.png")
	speusippus:loadAnimFidget("speu/speuFidget.png")
	
	arcesilau = Drawable.create(700, 250, "Arcesilau")
	
	arcesilau:addDialog(dialog_list_arce)
	arcesilau:loadAnimStand("arce/arceStand.png")
	arcesilau:loadAnimTalk("arce/arceTalk.png")
	arcesilau:loadAnimFidget("arce/arceFidget.png")

	player = Drawable.create(400, 350, "player")
	
	player:loadAnimStand("player/playerStand.png")
	player:loadAnimFidget("player/playerFidget.png")
	player:loadAnimTalk("player/playerTalking.png")
	player:loadAnimWalkUp("player/playerWalkUp.png")
	player:loadAnimWalkDown("player/playerWalkDown.png")
	player:loadAnimWalkLeftRight("player/playerWalkLeftRight.png")
	player.stand = true
	
	title = Drawable.create(100, 0, "title")
	title:loadAnimDef("title/title.png")
	
	background = Drawable.create(0,0, "background")
	background:loadAnimDef("background/background.png")
	
	drawables = {aristotle, speusippus, arcesilau, player}
	
	infoAristotle = InfoTable.create()
	infoAristotle:addMugshot("info/totle.png")
	infoAristotle:addName("Aristotle")
	infoAristotle:addBirthYear("384 BC")
	infoAristotle:addBirthCity("Stagira")
	infoAristotle:addDeathYear("322 BC")
	
	infoSpeusippus = InfoTable.create()
	infoSpeusippus:addMugshot("info/speu.png")
	infoSpeusippus:addName("Speusippus")
	infoSpeusippus:addBirthYear("408 BC")
	infoSpeusippus:addBirthCity("Athens")
	infoSpeusippus:addDeathYear("339 BC")
	
	infoArcesilau = InfoTable.create()
	infoArcesilau:addMugshot("info/arce.png")
	infoArcesilau:addName("Arcesilau")
	infoArcesilau:addBirthYear("316 BC")
	infoArcesilau:addBirthCity("Pitane")
	infoArcesilau:addDeathYear("241 BC")
	
end

function love.update(dt)
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		player:chgy(-step)
	elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		player:chgx(-step)
	elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		player:chgy(step)
	elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		player:chgx(step)
	else
		todrawplayer = player_default
	end
end

--[[function love.focus(f)
	if f then
		--print("Lose or gain")
	end
end--]]

function love.draw()
	if optionmenu then
		love.graphics.print("Adjust movement speed: "..step, 0, 0)
		love.graphics.print("Currently in "..mode.." mode", 20, 20)
		
		--instructions
		love.graphics.print("Use the WASD or the arrow keys to move around, and use the space bar to talk", 150, 200)
		love.graphics.print("To change movement speed choose a mode; subtraction (- key) or addition (+ key)", 150, 215)
		love.graphics.print("Then press the number that you want to add (or subtract) to the current speed", 150, 230)
		
		love.graphics.print("Press \"r\" to reset the game or \"q\" to quit", 200, 245)
		
		love.graphics.setColor(0, 0, 230)
		love.graphics.circle("fill", ball.x, ball.y, 40)
		for i = 1, step do
			love.graphics.setColor(math.random(0,255), math.random(0,255), math.random(0,255))
			love.graphics.line(ball.x+math.random(0, 100), ball.y+math.random(0,100), ball.destx, ball.desty)
			love.graphics.setColor(math.random(0,255), math.random(0,255), math.random(0,255))
			love.graphics.line(ball.x-math.random(0, 100), ball.y+math.random(0,100), ball.destx, ball.desty)
			love.graphics.setColor(math.random(0,255), math.random(0,255), math.random(0,255))
			love.graphics.line(ball.x-math.random(0, 100), ball.y-math.random(0,100), ball.destx, ball.desty)
			love.graphics.setColor(math.random(0,255), math.random(0,255), math.random(0,255))
			love.graphics.line(ball.x+math.random(0, 100), ball.y-math.random(0,100), ball.destx, ball.desty)
		end
		love.graphics.circle("fill", ball.destx, ball.desty, 10)
		
		if ball.x == ball.destx and ball.y == ball.desty then
			ball.destx = math.random(0, 800)
			ball.desty = math.random(0, 600)
		else
			if ball.x < ball.destx then
				ball.x = ball.x + 1
			end
			if ball.y < ball.desty then
				ball.y = ball.y + 1
			end
			if ball.x > ball.destx then
				ball.x = ball.x - 1
			end
			if ball.y > ball.desty then
				ball.y = ball.y - 1
			end			
		end
		love.graphics.setColor(255, 255, 255)
		return
	end
	
	love.graphics.draw(background.default, background.x, background.y)
	love.graphics.rectangle("line", 0, 500, 800, 100)
	love.graphics.rectangle("line", 5, 505, 790, 90)
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
	
	if loading_screen then			
		love.graphics.draw(title.draw, title.x, title.y)
		count=count+1
		if title.y ~= 100 and count%2==1 then
			title.y = title.y+1
		elseif title.y==100 and not (count%10==1) then
			love.graphics.setFont(talkfont)
			love.graphics.print("Press space to contiune", 170, 200, 0)
			love.graphics.setFont(oldefont) 
		end		
		if count>=9999999999 then
			count = 0
		end
	end
	
	if plato_screen then
		love.graphics.circle("line", 400, 250, 100)
		love.graphics.circle("fill", 400, 250, 95)
		drawInfoPlato()		
		speak(dialog_list_plato[dialog_plato])		
	end
	
	talkfidgettoggle(aristotle, infoAristotle)
	talkfidgettoggle(arcesilau, infoArcesilau)
	talkfidgettoggle(speusippus, infoSpeusippus)	
	
	if not loading_screen then
		for i = 1, table.getn(drawables) do
			--print(drawables[i].name)
			love.graphics.draw(drawables[i].draw, drawables[i].x, drawables[i].y)
		end	
	end
	
	player:toggle("stand")	
	
end

function moveup()
	player:chgy(step)
	player.draw = player.walkup
end

function movedown()
	player:chgy(-step)
	player.draw = player.walkdown
end

function moveleft()
	player:chgx(step)
	player.draw = player.walkhorizon
end

function moveright()
	player:chgx(-step)
	player.draw = player.walkhorizon
end

function tryspeak()
	--speusippus
	if plato_screen then
		if dialog_plato < table.getn(dialog_list_plato) then
			dialog_plato = dialog_plato+1
		else
			plato_screen = false
		end
	elseif player.x <= 400 and player.x >= 300 and player.y >=100 and player.y <=200 then
		speusippus.talk = true		
		arcesilau.talk = false
		aristotle.talk = false
		plato_screen = false
		if speusippus.dialog_index < table.getn(speusippus.dialog) then
			speusippus.dialog_index = speusippus.dialog_index+1
		end
	--for totle, in the left part
	elseif player.x <= 300 and player.y <= 300 and player.x >=0 and player.y >=200 then
		speusippus.talk = false		
		arcesilau.talk = false
		plato_screen = false
		aristotle.talk = true
		if aristotle.dialog_index < table.getn(aristotle.dialog) then
			aristotle.dialog_index = aristotle.dialog_index+1
		end
	--arcesilau
	elseif player.x >= 500 and player.y <= 300 and player.y >=200 then
		speusippus.talk = false		
		arcesilau.talk = true
		aristotle.talk = false
		plato_screen = false
		if arcesilau.dialog_index < table.getn(arcesilau.dialog) then
			arcesilau.dialog_index = arcesilau.dialog_index + 1
		end
	end
end

function options()
	if optionmenu then
		optionmenu = false
	else
		optionmenu = true
	end
end

function speak(dialog)
	love.graphics.setFont(talkfont)
	love.graphics.printf(dialog, 10, 510, 700, "center")
	love.graphics.setFont(oldefont)
end

function drawInfoPlato()
	love.graphics.draw(plato_mugshot, 338, 179, 0, .5, .5)
end

function talkfidgettoggle(drawable, infotable)
	if drawable.talk then
		infotable:drawInfo()
		drawable:toggle("talk")
		speak(drawable.dialog[drawable.dialog_index])
	else
		drawable:toggle("stand")
	end

end