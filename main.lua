require("Drawable")
require("InfoTable")

count = 0

dialog_list_totle = {"Hello, I am Aristotle!", "I tutored Alexander the Great!"}

dialog_plato = 1
dialog_list_plato = {
"Hello, I am Plato, and welcome to my Academy.", 
"I created this academy in 387 BC and it became the place of teaching for many famous philosophers.", 
"The most famous philosopher to study here was Aristotle, who remained here for twenty years!",
"Take a look around and talk to the people here, I'm sure you'll find it interesting and maybe learn something new!",
"Have fun!"
}

dialog_list_speu = {"test speech", "lorem ipsum", "dolet", "test"}
dialog_list_arce = {"test speech", "lorem ipsum", "dolet", "test"}

loading_screen = true
plato_screen = false

function love.keypressed(key)
	--print(key)
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
		loading_screen = true
		speaking_crates = false
		speaking_totle = false
		dialog_totle = 0
		dialog_crates = 0
		dialog_plato = 1
		plato_screen = false
	elseif key=="q" then
		love.event.push("quit")
	
	else
		todrawplayer = player_standing
	end
end

function love.load()
	--love.audio.play(love.audio.newSource("aoeIII.mp3"))
	
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
	loadinfopics()
	
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
		player:chgy(-1)
	elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		player:chgx(-1)
	elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		player:chgy(1)
	elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		player:chgx(1)
	else
		todrawplayer = player_default
	end
end

function love.draw()
	love.graphics.draw(background.default, background.x, background.y)
	love.graphics.rectangle("line", 0, 500, 800, 100)
	love.graphics.rectangle("line", 5, 505, 790, 90)
	--Drawing the FPS in the upper left hand corner
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
	
	if loading_screen then			
		love.graphics.draw(title.draw, title.x, title.y)
		count=count+1
		if title.y ~= 100 and count%2==1 then
			title.y = title.y+1
		elseif title.y==100 and not (count%10==1) then
			love.graphics.print("Press space to contiune", 170, 200, 0, 2, 2)
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
	
	if aristotle.talk then
		infoAristotle:drawInfo()
		aristotle:toggle("talk")
		speak(aristotle.dialog[aristotle.dialog_index])
	else
		aristotle:toggle("stand")
	end
	
	
	if arcesilau.talk then
		infoArcesilau:drawInfo()
		arcesilau:toggle("talk")
		speak(arcesilau.dialog[arcesilau.dialog_index])
	else
		arcesilau:toggle("stand")
	end
	
	
	if speusippus.talk then
		infoSpeusippus:drawInfo()
		speusippus:toggle("talk")
		speak(speusippus.dialog[speusippus.dialog_index])
	else
		speusippus:toggle("stand")
	end
	
	
	if not loading_screen then
		for i = 1, table.getn(drawables) do
			love.graphics.draw(drawables[i].draw, drawables[i].x, drawables[i].y)
		end	
	end
	
	player:toggle("stand")
end

function moveup()
	player:chgy(1)
	player.draw = player.walkup
end

function movedown()
	player:chgy(-1)
	player.draw = player.walkdown
end

function moveleft()
	player:chgx(1)
	player.draw = player.walkhorizon
end

function moveright()
	player:chgx(-1)
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
	optionmenu = true
end

function speak(dialog)
	love.graphics.print(dialog, 10, 510)
end

function loadinfopics()
	local dir = "info/"
	plato_mugshot = love.graphics.newImage(dir.."plato.jpg")
end

function drawInfoPlato()
	love.graphics.draw(plato_mugshot, 338, 179, 0, .5, .5)
end