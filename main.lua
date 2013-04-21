count = 0

playerx = 400
playery = 350 

cratesx = 60
cratesy = 50

totlex = 120
totley = 100

titlex = 0
titley = 0

dialog_crates = 0
dialog_list_crates = {"Hello young Scholar!", "I am the wise scholar Socrates.", 
"Keep talking to me to hear some quotes!",
"The only true wisdom is in knowing you know nothing.",
"All men's souls are immortal, but the souls of the righteous are immortal and divine.",
"Wisdom begins in wonder.",
"An honest man is always a child.",
"Thats it! I have nothing left to say!"
}

dialog_totle = 0
dialog_list_totle = {"Hello, I am Aristotle!", "I tutored Alexander the Great!"}

dialog_plato = 1
dialog_list_plato = {
"Hello, I am Plato, and welcome to my Academy.", 
"I created this academy in 387 BC and it became the place of teaching for many famous philosophers.", 
"The most famous philosopher to study here was Aristotle, who remained here for twenty years!",
"Take a look around and talk to the people here, I'm sure you'll find it interesting and maybe learn something new!",
"Have fun!"
}

loading_screen = true
plato_screen = false;

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
	loadanimsocrates()
	loadanimplayer()
	loadanimtotle()
	loadinfopics()
	loadtitle()
	loadbackground()
end

function love.update(dt)
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		chgplayery(-1)
	elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		chgplayerx(-1)
	elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		chgplayery(1)
	elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		chgplayerx(1)
	else
		todrawplayer = player_default
	end
end

function loadtitle()
	print("Loading!")
	local dir = "title/"
	title = love.graphics.newImage(dir.."title.png")
end

function loadanimplayer()
	print("Loading Player")
	local dir = "player/"
	player_standing = love.graphics.newImage(dir.."playerStand.png")
	
	player_facing_up = love.graphics.newImage(dir.."playerFaceUp.png")
	player_facing_down = love.graphics.newImage(dir.."playerFaceDown.png")
	player_facing_left = love.graphics.newImage(dir.."playerFaceLeft.png")
	player_facing_right = love.graphics.newImage(dir.."playerFaceRight.png")
	
	player_walking_forward = love.graphics.newImage(dir.."playerWalkForward.png")
	player_walking_backward = love.graphics.newImage(dir.."playerWalkBackward.png")
	player_walking_left = love.graphics.newImage(dir.."playerWalkLeft.png")
	player_walking_right = love.graphics.newImage(dir.."playerWalkRight.png")
	
	player_fidget = love.graphics.newImage(dir.."playerFidget.png")
	player_talking = love.graphics.newImage(dir.."playerTalking.png")	
	player_default = player_standing
	todrawplayer = player_standing
end

function loadanimtotle()
	print("Loading Aristotle")
	local dir = "totle/"
	totle_standing = love.graphics.newImage(dir.."totleStand.png")
	totle_fidget = love.graphics.newImage(dir.."totleFidget.png")
	totle_talking = love.graphics.newImage(dir.."totleTalking.png")
	todrawtotle = totle_standing
end

function loadanimsocrates()
	print("Loading so many crates")
	local dir = "crates/"
	crates_standing = love.graphics.newImage(dir.."socratesStand.png")
	crates_fidget = love.graphics.newImage(dir.."socratesFidget.png") 
	crates_talking = love.graphics.newImage(dir.."socratesTalk.png")
	todrawcrates = crates_standing
end

function loadanimarce()
	print("Loading Arcesilaus")
	local dir = "arce/"
	arce_standing = love.graphics.newImage(dir.."arceStand.png")
	arce_fidget = love.graphics.newImage(dir.."arceFidget.png") 
	arce_talking = love.graphics.newImage(dir.."arceTalk.png")
	todrawarce = arce_standing
end

function loadanimspeu()
	print("Loading Speusippus")
	speu_standing = love.graphics.newImage(dir.."speuStand.png")
	speu_fidget = love.graphics.newImage(dir.."speuFidget.png") 
	speu_talking = love.graphics.newImage(dir.."speuTalk.png")
	todrawspeu = speu_standing
end	
	
function loadbackground()
	local dir = "background/"
	background = love.graphics.newImage(dir.."background.png")
end

function love.draw()
	love.graphics.draw(background, 0, 0)
	love.graphics.rectangle("line", 0, 500, 800, 100)
	love.graphics.rectangle("line", 5, 505, 790, 90)
	--Drawing the FPS in the upper left hand corner
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
	
	if loading_screen then	
		
		love.graphics.draw(title, 100, titley)
		count=count+1
		if titley ~= 100 and count%2==1 then
			titley = titley+1
		elseif titley==100 and not (count%10==1) then
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
	
	if speaking_crates then
		drawInfoCrates()
		if talking_crates then
			talking_crates = false
			todrawcrates = crates_standing
		else
			talking_crates = true
			todrawcrates = crates_talking
		end
		--love.graphics.print(dialog_list_crates[dialog_crates], 100, 100)
		speak(dialog_list_crates[dialog_crates])
	else
		--have to have fidgets!
		if standing_crates then
			standing_crates = false
			todrawcrates = crates_fidget
		else
			standing_crates = true
			todrawcrates = crates_standing
		end
	end
	
	
	if speaking_totle then
		drawInfoTotle()
		if talking_totle then
			talking_totle = false
			todrawtotle = totle_standing
		else
			talking_totle = true
			todrawtotle = totle_talking
		end
		--love.graphics.print(dialog_list_totle[dialog_totle], 200, 200)
		speak(dialog_list_totle[dialog_totle])
	else
		if standing_totle then
			standing_totle = false
			todrawtotle = totle_fidget
		else
			standing_totle = true
			todrawtotle = totle_standing
		end
	end
	
	
	if speaking_arce then
		drawInfoArce()
		if talking_arce then
			talking_arce = false
			todrawarce = arce_standing
		else
			talking_arce = true
			todrawarce= arce_talking
		end
		--love.graphics.print(dialog_list_totle[dialog_totle], 200, 200)
		speak(dialog_list_arce[dialog_arce])
	else
		if standing_arce then
			standing_arce = false
			todrawarce = arce_fidget
		else
			standing_arce = true
			todrawarce = arce_standing
		end
	end
	
	
	if speaking_speu then
		drawInfoSpeu()
		if talking_speu then
			talking_speu = false
			todrawspeu = speu_standing
		else
			talking_speu = true
			todrawspeu= speu_talking
		end
		--love.graphics.print(dialog_list_totle[dialog_totle], 200, 200)
		speak(dialog_list_speu[dialog_speu])
	else
		if standing_speu then
			standing_speu = false
			todrawspeu = speu_fidget
		else
			standing_speu = true
			todrawspeu = speu_standing
		end
	end
	
	
	if not loading_screen then
		love.graphics.draw(todrawplayer, playerx, playery)
		love.graphics.draw(todrawcrates, cratesx, cratesy)
		love.graphics.draw(todrawtotle, totlex, totley)
	end
	
	if standing_player then
		standing_player = false
		todrawplayer = player_fidget
	else
		standing_player = true
		todrawplayer = player_standing
	end
end

function moveup()
	chgplayery(1)
	todrawplayer = player_walking_forward
	player_default = player_facing_up
end

function movedown()
	chgplayery(-1)
	todrawplayer = player_walking_backward
	player_default = player_facing_down
end

function moveleft()
	chgplayerx(1)
	todrawplayer = player_walking_left
	player_default = player_facing_left
end

function moveright()
	chgplayerx(-1)
	todrawplayer = player_walking_right
	player_default = player_facing_right
end

function tryspeak()
	if playerx <= 100 and playery <=100 then
		speaking_crates = true
		speaking_totle = false
		plato_screen = false
		if dialog_crates < table.getn(dialog_list_crates) then
			dialog_crates = dialog_crates+1
		end
	elseif playerx <= 200 and playery <= 200 then
		speaking_crates = false
		speaking_totle = true
		plato_screen = false
		if dialog_totle < table.getn(dialog_list_totle) then
			dialog_totle = dialog_totle+1
		end
	elseif playerx <= 450 and playery <= 400 then
		speaking_crates = false
		speaking_totle = false
		love.graphics.print("test", 0, 0)
		if dialog_plato < table.getn(dialog_list_plato) then
			dialog_plato = dialog_plato + 1
		else
			plato_screen = false
		end
	end
end

function chgplayerx(num)
	if playerx < 0 then
		playerx = 0
	elseif playerx > 730 then
		playerx = 730
	--elseif playerx > 700 and playery < 100 then
	--	playerx = 700
	elseif playerx < 75 then
		playerx = 75
	else
		playerx = playerx + num
	end
end

function chgplayery(num)
	if playery < 0 then
		playery = 0
	elseif playery > 350 then
		playery = 350
	elseif playery < 25 then
		playery = 25
	else
		playery = playery + num
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
	crates_mugshot = love.graphics.newImage(dir.."crates.png")
	totle_mugshot = love.graphics.newImage(dir.."totle.png")
	plato_mugshot = love.graphics.newImage(dir.."plato.jpg")
	arce_mugshot = love.graphics.newImage(dir.."arce.png")
	speu_mugshot = love.graphics.newImage(dir.."speu.png")
end

function drawInfoCrates()
	drawInfoTemplate()
	love.graphics.draw(crates_mugshot, 365, 190)
	love.graphics.print("Socrates", 495, 170)
	love.graphics.print("470 BC", 474, 200)
	love.graphics.print("Athens", 474, 235)
	love.graphics.print("399 BC", 474, 270)
end

function drawInfoTotle()
	drawInfoTemplate()
	love.graphics.draw(totle_mugshot, 365, 190)
	love.graphics.print("Aristotle", 495, 170)
	love.graphics.print("384 BC", 474, 200)
	love.graphics.print("Stagira", 474, 235)
	love.graphics.print("322 BC", 474, 270)
	--love.graphics.print("40
end

function drawInfoArce()
	drawInfoTemplate()
	love.graphics.draw(arce_mugshot, 365, 190)
	love.graphics.print("Arcesilau", 495, 170)
	love.graphics.print("316 BC", 474, 200)
	love.graphics.print("Pitane", 474, 235)
	love.graphics.print("241 BC", 474, 270)
end

function drawInfoSpeu()
	drawInfoTemplate()
	love.graphics.draw(speu_mugshot, 365, 190)
	love.graphics.print("Speusippus", 495, 170)
	love.graphics.print("408 BC", 474, 200)
	love.graphics.print("Athens", 474, 235)
	love.graphics.print("339 BC", 474, 270)
end

function drawInfoTemplate()
	love.graphics.circle("line", 400, 225, 55)
	love.graphics.circle("fill", 400, 225, 50)
	love.graphics.rectangle("line", 470, 170, 100, 130)
	love.graphics.print("Birth:", 472, 185)
	love.graphics.print("Birth City:", 472, 220)
	love.graphics.print("Death:", 472, 255)
end

function drawInfoPlato()
	love.graphics.draw(plato_mugshot, 338, 179, 0, .5, .5)
end