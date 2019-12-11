pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--init
function _init()
	t = true 
	f = false 
	
	walls = t
	display = f
	counter = 0
	
	map_tile=mget(0,0)
	
	item1={}
	
	state = 0
	step = 0

	plr = {
		sp=96,
		x=16,
		y=16,
		w=8,
		h=8,
		moving=false,
		flp = false, 
		d=0,
		acc=0.35,
		anim=0,
		move="down",
		maxhp=5,
		health = 5,
		coins = 10,
		keys = 1,
	}
	reticle = {
		sp=38,
		x=16,
		y=24,
		w=8,
		h=8
	}
	
	--shop init 
	buy = {16,36,51}
	shp = {}
	spawned = f
	select = 1

	level = 4
	difficulty = 3
	tiles = {}
	enemy = {}
	mbosses = {}
	cboss = {}
	scythe = {
		sp=92,
		spd=1,
		move="up",
		x=0,
		y=0,
		w=16,
		h=16,
		enret = {
		x=0,
		y=0,
		w=8,
		h=8
		}
	}
	projectiles = {}
 genlevel()
 genenemies()
 
 dis_diag = f
	diag = ""
	d_tick = 0
	
	music(1)
end

function start_muzak(n)
	if not playing then
		music(n) playing=true
		end
end

function stop_muzak()
	music(-1) playing=false
end
-->8
--update and draw--

--this just handles moves right now
function _update()
 if state == 0 then
   if btnp(5) then
     step += 1
   end
   if btnp(4) then
     step -= 1
   end
   if step >= 6 then
     state = 1
   end
   if step < 0 then
     step = 0
   end
 elseif state == 1 then
 			
 			--reset shop 
 		spawned = f 
 		shopping = f 
 		mset(7,8,61)
			mset(8,8,61)
				
    plr_update()
    enemy_update()
    proj_update()

		if walls then
			if #enemy <= 0 then
				local rand = flr(rnd(4))
				if rand == 0 then
					mset(6, 1, 61)
					mset(7, 1, 45)
					mset(8, 1, 45)
					mset(9, 1, 61)
					walls = f
				elseif rand == 1 then
					mset(15, 7, 61)
					mset(15, 8, 45)
					mset(15, 9, 45)
					walls = f
				elseif rand == 2 then
					mset(6, 15, 61)
					mset(7, 15, 45)
					mset(8, 15, 45)
					mset(9, 15, 61)
					walls = f
				elseif rand == 3 then
					mset(0, 7, 61)
					mset(0, 8, 45)
					mset(0, 9, 45)
					walls = f
				end
			end
		end
   if level == 5 then 
    state = 2
			end
			

 elseif state == 2 then
 if shopping and spawned then 
			use_menu()
	else 
		plr_update()
	end
	if cboss.hp > 0 then
 	boss_update()
 	mset(23,1,202)
 	mset(24,1,202)
 	mset(25,1,202)
 	mset(26,1,202)
 	mset(17,7,218)
 	mset(17,8,218)
 	mset(17,9,218)
 	mset(32,7,219)
 	mset(32,8,219)
 	mset(32,9,219)
 	mset(23,15,203)
 	mset(24,15,203)
 	mset(25,15,203)
 	mset(26,15,203)
 else
 	if difficulty == 4 then
 		stop_muzak()
 	 start_muzak(3)
 	 step = 0
			state = 3
		end
 	mset(23,1,227)
 	mset(24,1,227)
 	mset(25,1,227)
 	mset(26,1,227)
 	mset(17,7,227)
 	mset(17,8,227)
 	mset(17,9,227)
 	mset(32,7,227)
 	mset(32,8,227)
 	mset(32,9,227)
 	mset(23,15,227)
 	mset(24,15,227)
 	mset(25,15,227)
 	mset(26,15,227)
 	
 	--shop spawn 
 	if not spawned then 
 		stop_muzak()
 		spawnshop() 
 		start_muzak(1)
	 end
	 
 end
 proj_update()
 elseif state == 3 then
 	if btnp(5) then
     step += 1
    end
    if btnp(4) then
     step -= 1
    end
    if step >= 6 then
     state = 99
    end
   if step < 0 then
     step = 0
   end
 elseif state==4 then
 	if btnp(4) or btnp(5) then
	  _init()
    reload()
  end
	end
end

--this draws the base map, player, and the generated wall tiles
function _draw()
 palt(3, true)
	palt(0, false)
	
 if state==0 then
	draw_intro()
 elseif state==1 then
 draw_diag()
	draw_main()
	draw_ui()
 draw_enemy_health()
 elseif state==2 then
   cls()
   map(17, 0, 0, 0, 16, 16)
   drawshop()
   
 		
 		if shopping then
 			draw_box()
 			draw_menu()
 		end
   spr(plr.sp, plr.x, plr.y,1,1,plr.flp)
   spr(reticle.sp, reticle.x, reticle.y)
   if cboss.hp > 0 then
   	draw_boss()
   	if cboss.name == "grim reaper" then
   		draw_scythe()
   	end
   	draw_boss_health()
   	for k in all(projectiles) do
   		spr(k.sp, k.x, k.y)
   	end
   end
   draw_ui()
   draw_diag()

 elseif state==3 then
   cls()
   draw_outro()

 elseif state==4 then
   cls()
   camera(0,0)
   map(70,70,0,0,16,16)
   print("game over.\npress z to restart",40,60,7)
 elseif state==99 then
	print("thank you for playing!", h_center("thank you for playing!"), 60)
 end
end

function h_center(s)
	return 64-#s*2
end

function draw_intro()
	local text
    if step == 0 then
		    cls()
		    for i=1,5 do
		      spr(199+i, 8+(8*i) + i, 48)
		      spr(215+i, 53+(8*i) + i, 48)
		    end
		    spr(236, 102, 48)
		    spr(219, 49, 57)
		    spr(200, 58, 57)
		    spr(232, 67, 57)
		    spr(235, 76, 57)
		    advanceui()
    elseif step == 1 then
		    cls()
		    text = "bailey is scared."
		    print(text, h_center(text), 52)
		    advanceui()
		    sspr(112, 56, 8, 8, 48, 72, 24, 24)
    elseif step == 2 then
		    cls()
		    text = "monsters haunt his nightmares."
		    print(text, h_center(text), 52)
		    sspr(112, 40, 16, 16, 36, 72, 32, 32)
		    advanceui()
    elseif step == 3 then
		    cls()
		    text = "bailey decides tonight is"
		    print(text, h_center(text), 52)
		    text = " the night to put an end to this!"
      print(text, h_center(text), 58)
      sspr(0, 48, 8, 8, 48, 72, 24, 24)
      advanceui()
    elseif step == 4 then
		    cls()
		    text = "do you think it will be easy?"
		    print(text, h_center(text), 52, 1)
		    advanceui()
 	  elseif step == 5 then
		    cls()
   		 print("i can use ⬆️⬇️⬅️➡️ to move!", 0, 16, 7)
   		 print("if i press ❎ while walking at\nan enemy, i'll attack!", 0, 30)
   		 print("if i press ❎ after walking up \nto a chest i'll use a key to \nopen it", 0, 52)
   		 advanceui()
   		 print("i can't wait to meet you...", h_center("i can't wait to meet you..."), 112, 1)
   		 for i = 1,4 do
      		spr(147+i, 36+(8*i), 100)
   		 end
     end
end

function draw_outro()
	local text
    if step == 0 then
		    cls()
		    text = "with mr. nightmare vanquished"
		    print(text, h_center(text), 52)
		    advanceui()
    elseif step == 1 then
		    cls()
		    text = "and all his fears conquered"
		    print(text, h_center(text), 52)
		    advanceui()
		    sspr(112, 40, 16, 16, 36, 72, 32, 32)
    elseif step == 2 then
		    cls()
		    text = "bailey feels far more confident"
		    print(text, h_center(text), 52)
		    advanceui()
    elseif step == 3 then
		    cls()
		    text = "and will wake up in the morning"
		    print(text, h_center(text), 52)
		    text = "feeling excited and happy."
      print(text, h_center(text), 58)
      sspr(0, 48, 8, 8, 48, 72, 24, 24)
      advanceui()
    elseif step == 4 then
		    cls()
		    text = "but what about"
		    print(text, h_center(text), 52, 1)
			text = "his next challenge?"
			print(text, h_center(text), 60, 1)
		    advanceui()
 	  elseif step == 5 then
		    cls()
   			advanceui()
   			print("i can't wait to meet you...", h_center("i can't wait to meet you..."), 112, 8)
      		sspr(48, 48, 8, 8, 48, 72, 24, 24)
     end
end

function advanceui()
  if display then
		  print("x➡️", 112, 120, 7)
		  print("⬅️z", 0, 120, 7)
		end
		counter += 1
		if counter > 25 then
		  display = not display
		  counter = 0
		end
end

function draw_main()
   cls()
   map(0, 0, 0, 0, 16, 16)
   spr(plr.sp, plr.x, plr.y,1,1,plr.flp)
   spr(reticle.sp, reticle.x, reticle.y) 
   
   for i in all(tiles) do
  	  mset(i.x, i.y, i.s)
   end
   
   for j in all(enemy) do
  		an_enemy(j)
   end
   
   for k in all(projectiles) do
   	spr(k.sp, k.x, k.y)
   end
end

function draw_ui()
   rectfill(0,0,128,7,0)
   spr(21, 128-24, 0)
   print(plr.coins, 128-16, 1, 10)
   spr(36, 128-40, 0)
   print(plr.keys, 128-32, 1, 10)
   
   for i = 1,plr.maxhp do
     spr(19, -8 + (i*8), 0)
   end  
   
   for i = 1,plr.health do
     spr(20, -8 + (i*8), 0)
   end

end
-->8
--collisions
function collide_map(obj,aim,flag)
	--obj = table x,y,w,h

	local x=obj.x local y=obj.y
	local w=obj.w local h=obj.h

	local x1=x local y1=y
	local x2=x+w-1 local y2=y+h-1

	--pixels to tiles

	x1/=8  x2/=8
	y1/=8  y2/=8


	if fget(mget(x1,y1),flag)
	or fget(mget(x1,y2),flag)
	or fget(mget(x2,y1),flag)
	or fget(mget(x2,y2),flag) then
		return true
	else
		return false
	end

end

function ranintochest(obj, aim)
	local x=obj.x local y=obj.y
	local w=obj.w local h=obj.h


	local x1=reticle.x local y1=reticle.y
	local x2=reticle.x+reticle.w local y2=reticle.y+reticle.h
	if aim=="left" then
		x1=x-1 y1=y
		x2=x-w y2=y+h-1
		
	elseif aim=="right" then 
		x1=x+1 y1=y
		x2=x+w y2=y+h-1
	
	elseif aim=="up" then
		x1=x  y1=y-h
		x2=x+w-1 y2=y-1
	
	elseif aim=="down" then 
		x1=x  y1=y+1
	 x2=x+w-1 y2=y+h
	end
	
	--pixels to tiles
	
	x1/=8  x2/=8
	y1/=8  y2/=8
  
	if plr.keys > 0 then
		if fget(mget(x1,y1),1) then
			if btnp(5) then
				mset(x1, y1, 18)
				if flr(rnd(10)) == 1 then 
					diag = "found a potion.\ni feel a bit better!"
					dis_diag = t
					plr.health = plr.maxhp
				else
					plr.coins += 10
					plr.keys -= 1
					diag = "found 10 coins!"
					dis_diag = t
				end
			end
		elseif fget(mget(x1,y2),1) then
			if btnp(5) then
				sfx(3)
				mset(x1, y2, 18)			
				if flr(rnd(10)) == 1 then 
					diag = "found a potion.\ni feel a bit better!"
					dis_diag = t
					plr.health = plr.maxhp
				else
					plr.coins += 10
					plr.keys -= 1
					diag = "found 10 coins!"
					dis_diag = t
				end 
			end
		elseif fget(mget(x2,y1),1) then
			if btnp(5) then
				sfx(3)
				mset(x2, y1, 18)
				if flr(rnd(10)) == 1 then 
					diag = "found a potion.\ni feel a bit better!"
					dis_diag = t
					plr.health = plr.maxhp
				else
					plr.coins += 10
					plr.keys -= 1
					diag = "found 10 coins!"
					dis_diag = t
				end 
				plr.coins += 10
				plr.keys -= 1
			end
		elseif fget(mget(x2,y2),1) then
			if btnp(5) then
				sfx(3)
				mset(x2, y2, 18)
				if flr(rnd(10)) == 1 then 
					diag = "found a potion.\ni feel a bit better!"
					dis_diag = t
					plr.health = plr.maxhp
				else
					plr.coins += 10
					plr.keys -= 1
					diag = "found 10 coins!"
					dis_diag = t
				end 
			end
		end	
	end
end

function melee_attack(obj,aim)
	local x1=0 local y1=0
	local x2=0 local y2=0
	local enx1=0 local eny1=0
	local enx2=0 local eny2=0
			
	x1=obj.enret.x
	x2=obj.enret.x+obj.enret.w
	y1=obj.enret.y
	y2=obj.enret.y+obj.enret.h
		
	enx1=plr.x
	enx2=plr.x+plr.w
	eny1=plr.y
	eny2=plr.y+plr.h
			
	if (x1<enx1 and x2>enx1 and y1<eny1 and y2>eny1)
	or (x1<enx1 and x2>enx1 and y1<eny2 and y2>eny2)
	or (x1<enx2 and x2>enx2 and y1<eny1 and y2>eny1)
	or (x1<enx2 and x2>enx2 and y1<eny2 and y2>eny2) then
		plr.health -= 1
		sfx(5)
		return true
	end
	
end

function enemy_in_range(i)
	local x1=0 local y1=0
	local x2=0 local y2=0
	local enx1=0 local eny1=0
	local enx2=0 local eny2=0
			
	x1=reticle.x
	x2=reticle.x+reticle.w
	y1=reticle.y
	y2=reticle.y+reticle.h
		
	enx1=i.x
	enx2=i.x+i.w
	eny1=i.y
	eny2=i.y+i.h
			
	if (x1<=enx1 and x2>=enx1 and y1<=eny1 and y2>=eny1)
	or (x1<=enx1 and x2>=enx1 and y1<=eny2 and y2>=eny2)
	or (x1<=enx2 and x2>=enx2 and y1<=eny1 and y2>=eny1)
	or (x1<=enx2 and x2>=enx2 and y1<=eny2 and y2>=eny2) then
		return true
	else
		return false
	end
	
end

function	boss_in_range()
	local x1=0 local y1=0
	local x2=0 local y2=0
	local enx1=0 local eny1=0
	local enx2=0 local eny2=0
			
	x1=reticle.x
	x2=reticle.x+reticle.w
	y1=reticle.y
	y2=reticle.y+reticle.h
			
	enx1=cboss.x
	enx2=cboss.x+cboss.w
	enx3=cboss.x+8
	eny1=cboss.y
	eny2=cboss.y+cboss.h
	eny3=cboss.y+8
			
			if (x1<=enx1 and x2>=enx1 and y1<=eny1 and y2>=eny1)
			or (x1>=enx1 and x2<=enx2 and y1<=eny1 and y2>=eny1)
			or (x1<=enx1 and x2>=enx1 and y1<=eny2 and y2>=eny2)
			or (x1>=enx1 and x2<=enx2 and y1>=eny1 and y2<=eny2) 
			or (x1<=enx2 and x2>=enx2 and y1<=eny1 and y2>=eny1)
			or (x1>=enx1 and x2<=enx2 and y1<=eny2 and y2>=eny2)
			or (x1<=enx2 and x2>=enx2 and y1<=eny2 and y2>=eny2) then
	 		return true
			end
end
-->8
--map functions--

--this randomly generates walls
function genlevel()
	if not walls then
		mset(6, 1, 29)
		mset(7, 1, 29)
		mset(8, 1, 29)
		mset(9, 1, 29)
		mset(15, 7, 13)
		mset(15, 8, 13)
		mset(15, 9, 13)
		mset(6, 15, 12)
		mset(7, 15, 12)
		mset(8, 15, 12)
		mset(9, 15, 12)
		mset(0, 7, 14)
		mset(0, 8, 14)
		mset(0, 9, 14)
		walls = t
	end
  for i=3, 12 do
    for j= 3, 12 do
    	temp = {}
     temp.x = i
     temp.y = j
     if flr(rnd(15)) == 0 and i!=1 and j!= 1 then
      temp.s = 12
      add(tiles,temp)
     elseif flr(rnd(150)) == 1 and i!=j and j!=1 then
      temp.s = 17
      add(tiles, temp)
     elseif flr(rnd(125)) == 1 and i!=j and j !=1 then 
      temp.s = 25
      add(tiles,temp)
     end
    end
  end
	
end

function updatemap()
	enemy = {}
	projectiles = {}
	
	for i in all(tiles) do
		mset(i.x, i.y, 45)
	end
	
	tiles = {}
	
	cls()
	
	level = level + 1
	if level == 5 then
		make_mboss()
		spawn_mboss()
	elseif level == 6 then
		difficulty = difficulty + 1
		if difficulty >= 4 then
			--reset shop 
 		spawned = f 
 		shopping = f 
 		mset(7,8,198)
			mset(8,8,198)
			make_mboss()
			spawn_nmreboss()
		else
			level = 1
			state = 1
			genlevel()
			genenemies()
		end
	else
		genlevel()
		genenemies()		
	end
	
	map(0, 0, 0, 0, 16, 16)
 
 
 for i in all(tiles) do
   mset(i.x, i.y, i.s)
 end
  
 for j in all(enemy) do
   spr(j.s, j.x, j.y,1,1,fl)
 end

end  

-->8
--player functions--

function plr_update()
	if(plr.health <= 0) then
		stop_muzak()
		start_muzak(4)	
		state = 4
	end
	plr.moving = false
	plr.lastmove = plr.move
	
	grid_x = flr(reticle.x/8)
	grid_y = flr(reticle.y/8)
	
	map_tile = mget(grid_x,grid_y)
	
	ranintochest(plr, plr.lastmove)
	attack_enemy()
	if level == 5 or difficulty >= 4 then
		attack_boss()
	end
	
	if btn(0) then
		plr.x-= 1
		plr.move = "left"
		plr.moving=true
		reticle_aim("left")
		
		--animate 
		plr.flp = true
		plr_walk()
		
		if collide_map(plr,"left",0) then
			plr.x +=1
		end
		if plr.x < 0 then
			updatemap()
			plr.x = 112
		end
	elseif btn(1) then
		plr.x += 1
		plr.move = "right"
		plr.moving=true
		reticle_aim("right")
		--animate
		plr.flp = false
		plr_walk()
		
		if collide_map(plr,"right",0) then
			plr.x -= 1
		end
		if plr.x > 120 then
			updatemap()
			plr.x = 16
		end
	elseif btn(2) then
		plr.y -= 1
		plr.move = "up"
		plr.moving=true
		reticle_aim("up")
		if plr.sp == 96 or plr.sp ==97 then plr.sp = 99 end 
		plr_up()
		
		if collide_map(plr,"up",0) then
			plr.y += 1
		end
		if plr.y < 8 then
			updatemap()
			plr.y = 112
		end
	elseif btn(3) then
		plr.y += 1
		plr.move = "down"
		plr.moving=true
		reticle_aim("down")

		--animate 
		plr.flp = false
		plr_walk()
		
		if collide_map(plr,"down",0) then
			plr.y -= 1
			end
		if plr.y > 128 then
			updatemap()
			plr.y = 16

			end
	elseif spawned == t and btn(5) then
		if enemy_in_range(item1) then
			shopping = t
			map_tile = item1.tile
		end
	end
end

function attack_enemy()
	for i in all(enemy) do
		if enemy_in_range(i) and btnp(5) then
			i.health -= 1
			if plr.move == "right" then
				i.x += 6
				while collide_map(i,"right",0) do
					i.x -= 1
				end
				if i.x > 120 then
					i.x = 112
				end
			elseif plr.move == "left" then
				i.x -= 6
				while collide_map(i,"left",0) do
					i.x -= 1
				end
				if i.x < 8 then
					i.x = 8
				end
			elseif plr.move == "up" then
				i.y -= 6
				while collide_map(i,"up",0) do
					i.y -= 1
				end
				if i.y < 8 then
					i.y = 8
				end
			elseif plr.move == "down" then
				i.y += 6
				while collide_map(i,"down",0) do
					i.y -= 1
				end
				if i.y > 128 then
					i.y = 120
				end
			end
		end
	end
end

function attack_boss()
	if boss_in_range(i) and btnp(5) then
			cboss.hp -= 1		
	end
end

function reticle_aim(aim)
	if aim == "left" then
		reticle.x = plr.x-8
		reticle.y = plr.y
	elseif aim == "right" then
		reticle.x = plr.x+7
		reticle.y = plr.y
	elseif aim == "up" then
		reticle.x = plr.x
		reticle.y = plr.y-7
	elseif aim == "down" then
		reticle.x = plr.x
		reticle.y = plr.y+8
	end
end

-->8
--enemy functions--
function genenemies()
		if difficulty == 0 then
  	sn = 2
  elseif difficulty == 1 then
   sn = 3
  elseif difficulty == 2 then
   sn = 4
  elseif difficulty == 3 then
   sn = 5
  end
		for i=3, 12 do
    for j= 3, 12 do
    	for k in all(tiles) do
    		if k.x != i and k.y != j then
    					sc = flr(rnd(60))
        	if sc == 0 and sn > 0 and i!=1 and j!= 1 then
          sn -= 1
          temp = {}
          temp.x = i*8
          temp.y = j*8
          temp.w = 8
          temp.h = 8
          temp.moving = false
          temp.d = 0
          temp.enret = {
											x=temp.x+8,
											y=temp.y,
											w=8,
											h=8
										}
          temp.acc = 0.35
		  						temp.spd = 1
		  						temp.last = time() - 4
		  						temp.lastjump = time() - 4
          temp.anim = 0
          temp.move = "down"
          temp.health = 3
          temp.detected = false
          spawnchance = flr(rnd(7))
          if spawnchance == 0 then
        	   temp.name = "slime"
        	   temp.s = 64
          elseif spawnchance == 1 then
        	   temp.name = "skull"
        	   temp.s = 90
          elseif spawnchance == 2 then
        	   temp.name = "ghost"
        	   temp.s = 69
        	   movechance = flr(rnd(4))
        	   if movechance == 1 or movechance == 3 then
        	   	temp.move = "right"
        	   end
        	   temp.count = 15
          elseif spawnchance == 3 then
        	   temp.name = "shadow"
        	   temp.s = 72
          elseif spawnchance == 4 then
        	   temp.name = "eye"
        	   temp.s = 74
          elseif spawnchance == 5 then
        	   temp.name = "blood"
        	   temp.s = 77
        	   temp.xgoal = temp.x
        	   temp.ygoal = temp.y
          elseif spawnchance == 6 then
        	   temp.name = "fire"
        	   temp.s = 86
        	   temp.xgoal = temp.x
        	   temp.ygoal = temp.y
        	   temp.spd = 2
          end
        		temp.fl = false
        		add(enemy,temp)
      			end
     	end
     end
    end
  end
end

function enemy_update()
	for i in all(enemy) do
		enret_update(i)
		an_enemy(i)
		detect(i)
   		if i.health <= 0 then
			del(enemy, i)
   		end
		if i.detected then
			if enemy_attack(i) then
				print("weak")
			else
				if i.name == "slime" or
							i.name == "shadow" or
							i.name == "eye" or
							i.name == "skull" then			 
					x_diff = i.x - plr.x
					y_diff = i.y - plr.y
					if plr.y > 60 then
						y_diff += 8
					else
						y_diff -= 8
					end
					if abs(x_diff) > abs(y_diff) then
						if x_diff < 0 then
							h=enemy_move(i,"right")
							if not h then
								enemy_move(i,"up")
							end
						elseif x_diff > 0 then
							h=enemy_move(i,"left")
							if not h then
								enemy_move(i,"down")
							end
						end
					else
						if y_diff < 0 then
							h=enemy_move(i,"down")
							if not h then
								enemy_move(i,"right")
							end
						elseif y_diff > 0 then
							h=enemy_move(i,"up")
							if not h then
								enemy_move(i,"left")
							end
						end
					end
				elseif i.name == "blood" then
					can_dash(i)
					if i.x != i.xgoal or i.y != i.ygoal then
						if i.xgoal > i.x then
							h=enemy_move(i,"right")
						elseif i.xgoal < i.x then
							h=enemy_move(i,"left") 
						elseif i.ygoal > i.y then
							h=enemy_move(i,"down")
						elseif i.ygoal < i.y then
							h=enemy_move(i,"up")
						end
						if not h then
							i.xgoal = i.x
							i.ygoal = i.y
						end
					else
						i.spd = 0.2
						x_diff = i.x - plr.x
						y_diff = i.y - plr.y
						if plr.y > 60 then
							y_diff += 8
						else
							y_diff -= 8
						end
						if abs(x_diff) > abs(y_diff) then
							if x_diff < 0 then
								h=enemy_move(i,"right")
								if not h then
									enemy_move(i,"up")
								end
							elseif x_diff > 0 then
								h=enemy_move(i,"left")
								if not h then
									enemy_move(i,"down")
								end
							end
						else
							if y_diff < 0 then
								h=enemy_move(i,"down")
								if not h then
									enemy_move(i,"right")
								end
							elseif y_diff > 0 then
								h=enemy_move(i,"up")
								if not h then
									enemy_move(i,"left")
								end
							end
						end
					end
				elseif i.name == "ghost" then
					if i.count < 30 then
						enemy_move(i, i.move)
					elseif i.move == "right" then
						i.move = "left"
						i.count = 0
					elseif i.move == "left" then
						i.move = "right"
						i.count = 0
					elseif i.move == "up" then
						i.move = "down"
						i.count = 0
					elseif i.move == "down" then
						i.move = "up"
						i.count = 0
					end
				elseif i.name == "fire" then
					if time() - i.lastjump > 3 and i.x==i.xgoal and i.y==i.ygoal then 
						jump(i)
					end
					if i.xgoal > i.x then
						h=enemy_move(i,"right")
					elseif i.xgoal < i.x then
						h=enemy_move(i,"left") 
					elseif i.ygoal > i.y then
						h=enemy_move(i,"down")
					elseif i.ygoal < i.y then
						h=enemy_move(i,"up")
					end
					if not h then
						i.xgoal = i.x
						i.ygoal = i.y
					end
				end
			end
		else
			if i.name == "slime" or
						i.name == "shadow" then
					d = flr(rnd(4)+1)
					if d == 1 then
						i.x += 1
						if collide_map(i, "right", 0) then
							i.x -= 1
						end
					elseif d == 2 then
						i.x -= 1
						if collide_map(i, "left", 0) then
							i.x += 1
						end
					elseif d == 3 then
						i.y += 1
						if collide_map(i, "down", 0) then
							i.y -= 1
						end
					elseif d == 4 then
						i.x -= 1
						if collide_map(i, "up", 0) then
							i.x += 1
						end
					end
				elseif i.name == "eye" then
					d = flr(rnd(2)+1)
					if d == 1 then
						i.y += 1
						if collide_map(i, "down", 0) then
							i.y -= 1
						end
					elseif d == 2 then
						i.y -= 1
						if collide_map(i, "up", 0) then
							i.y += 1
						end
					end
				elseif i.name == "fire" then
					if time() - i.lastjump > 3 and i.x==i.xgoal and i.y==i.ygoal then 
						jump(i)
					end
					if i.xgoal > i.x then
						h=enemy_move(i,"right")
					elseif i.xgoal < i.x then
						h=enemy_move(i,"left") 
					elseif i.ygoal > i.y then
						h=enemy_move(i,"down")
					elseif i.ygoal < i.y then
						h=enemy_move(i,"up")
					end
					if not h then
						i.xgoal = i.x
						i.ygoal = i.y
					end
				end
		end
	end
end

function jump(i)
	i.lastjump = time()
 d = flr(rnd(4)+1)
	if d == 1 then
		i.xgoal += 32
	elseif d == 2 then
 	i.xgoal -= 32
	elseif d == 3 then
		i.ygoal += 32
	elseif d == 4 then
		i.ygoal -= 32
	end
end

function enemy_move(enem,direction)
	moved = true
	if direction == "right" then
		enem.x += enem.spd
		enem.move = "right"
		enem.moving=true
		if collide_map(enem,"right",0) or enem.x+8 == plr.x then
			enem.x -= enem.spd
			enemy_move("up")
			moved = false
		elseif enem.x > 104 then
			enem.x = 104
			moved = false
		end
	elseif direction == "left" then
		enem.x -= enem.spd
		enem.move = "left"
		enem.moving=true
		if collide_map(enem,"left",0) or enem.x == plr.x+8 then
			enem.x += enem.spd
			enemy_move("down")
			moved = false
		elseif enem.x < 8 then
			enem.x = 8
			moved = false
		end
	elseif direction == "up" then
		enem.y -= enem.spd
		enem.move = "up"
		enem.moving=true
		if collide_map(enem,"up",0) or enem.y == plr.y+8 then
			enem.y += enem.spd
			enemy_move("right")
			moved = false
		elseif enem.y < 16 then
			enem.y = 16
			moved = false
		end
	elseif direction == "down" then
		enem.y += enem.spd
		enem.move = "down"
		enem.moving=true
		if collide_map(enem,"down",0) or enem.y+8 == plr.y then
			enem.y -= enem.spd
			enemy_move("left")
			moved = false
		elseif enem.y > 112 then
			enem.y = 112
			moved = false
		end
	end
	return moved
end

function enret_update(i)
	if i.move == "left" then
		i.enret.x = i.x-i.enret.w
		i.enret.y = i.y
	elseif i.move == "right" then
		i.enret.x = i.x+i.w
		i.enret.y = i.y
	elseif i.move == "up" then
		i.enret.x = i.x
		i.enret.y = i.y-i.enret.h
	elseif i.move == "down" then
		i.enret.x = i.x
		i.enret.y = i.y+i.h
	end
end

function enret_update(i)
	if i.move == "left" then
		i.enret.x = i.x-i.enret.w
		i.enret.y = i.y
	elseif i.move == "right" then
		i.enret.x = i.x+i.w
		i.enret.y = i.y
	elseif i.move == "up" then
		i.enret.x = i.x
		i.enret.y = i.y-i.enret.h
	elseif i.move == "down" then
		i.enret.x = i.x
		i.enret.y = i.y+i.h
	end
end

function detect(enem)
	if enem.name == "slime" then
		if plr.x - enem.x < 48 and plr.y - enem.y < 48 then
			enem.detected = true
		end
	elseif enem.name == "skull" then
		if plr.x - enem.x < 48 and plr.y - enem.y < 48 then
			enem.detected = true
		end
	elseif enem.name == "ghost" then
		if plr.x - enem.x < 48 and plr.y - enem.y < 48 then
			enem.detected = true
		end
	elseif enem.name == "shadow" then
		if plr.x - enem.x < 48 and plr.y - enem.y < 48 then
			enem.detected = true
		else
			enem.detected = false
		end
	elseif enem.name == "eye" then
		if plr.x - enem.x < 32 and plr.y - enem.y < 32 then
			enem.detected = true
		else
			enem.detected = false
		end
	elseif enem.name == "blood" then
		if plr.x - enem.x < 48 and plr.y - enem.y < 48 then
			enem.detected = true
		end
	elseif enem.name == "spike" then
		enem.detected = true
	elseif enem.name == "fire" then
		if plr.x - enem.x < 48 and plr.y - enem.y < 48 then
			enem.detected = true
		end
	end
end

function enemy_attack(enem)
		attacked = false
		if time() - enem.last > 5 then 
		if enem.name == "slime"
		or enem.name == "skull"
		or enem.name == "ghost"
		or enem.name == "blood"
		or enem.name == "shadow" then
			if melee_attack(enem, enem.move) then
				enem.last = time()
				attacked = true
			end
		elseif enem.name == "fire"
		or enem.name == "eye" then
			if can_shoot(enem) then
				enem.last = time()-3
				attacked = true
			end
		end
		end
		return attacked
	end

function can_shoot(enem)
	if plr.y >= enem.y and plr.y <= enem.y+enem.h then
		direction = "left"
		if plr.x > enem.x then
			direction = "right"
		end
		if enem.name == "eye" then
			shoot(106,enem.x, plr.y, direction, 3)
			return true
		elseif enem.name == "fire" or enem.name == "mr.nightmare" then
			shoot(84,enem.x, enem.y, direction, 2)
			return true
		elseif enem.name == "tik tok clock" then
			shoot(125,enem.x, plr.y, direction, 3)
			return true
		end
	elseif plr.x >= enem.x and plr.x <= enem.y+enem.w then
		direction = "up"
		if plr.y > enem.y then
			direction = "down"
		end
		if enem.name == "eye" then
			shoot(107,plr.x, enem.y, direction, 3)
			return true
		elseif enem.name == "fire" or enem.name == "mr.nightmare" then
			shoot(123,enem.x, enem.y, direction, 2)
			return true
		elseif enem.name == "tik tok clok" then
			shoot(124,enem.x, enem.y, direction, 3)
			return true
		end
	end
	return false
end

function shoot(s,x,y,direc,spd)
	temp = {}
	temp.x = x
	temp.y = y
	temp.w = 8
	temp.h = 8
	temp.sp = s
	temp.direction = direc
	temp.speed = spd
	add(projectiles,temp)
end

function proj_update()
	for i in all(projectiles) do
		if direction == "right" then
		i.x += i.speed
		if collide_map(i,"right",0) then
			del(projectiles,i)
		elseif proj_hit(i) then
			sfx(5)
			plr.health -= 1
			del(projectiles,i)
		end
	elseif direction == "left" then
		i.x -= i.speed
		if collide_map(i,"left",0) then
			del(projectiles,i)
		elseif proj_hit(i) then
			sfx(5)
			plr.health -= 1
			del(projectiles,i)
		end
	elseif direction == "up" then
		i.y -= i.speed
		if collide_map(i,"up",0) then
			del(projectiles,i)
		elseif proj_hit(i) then
			sfx(5)
			plr.health -= 1
			del(projectiles,i)
		end
	elseif direction == "down" then
		i.y += i.speed
		if collide_map(i,"down",0) then
			del(projectiles,i)
		elseif proj_hit(i) then
			sfx(5)
			plr.health -= 1
			del(projectiles,i)
		end
	end
	end
end

function proj_hit(p)
	local x1=0 local y1=0
	local x2=0 local y2=0
	local enx1=0 local eny1=0
	local enx2=0 local eny2=0
			
	x1=p.x
	x2=p.x+p.w
	y1=p.y
	y2=p.y+p.h
		
	enx1=plr.x
	enx2=plr.x+plr.w
	eny1=plr.y
	eny2=plr.y+plr.h
			
	if (x1<enx1 and x2>enx1 and y1<eny1 and y2>eny1)
	or (x1<enx1 and x2>enx1 and y1<eny2 and y2>eny2)
	or (x1<enx2 and x2>enx2 and y1<eny1 and y2>eny1)
	or (x1<enx2 and x2>enx2 and y1<eny2 and y2>eny2) then
		return true
	end
end

function can_dash(enem)
 if plr.x/8 == enem.x/8-(enem.x/8)%1 then
 	if plr.y > enem.y then
 		enem.ygoal = plr.y-8
 	else
 		enem.ygoal = plr.y+8
 	end
 	enem.spd = 3
 elseif plr.y/8 == enem.y/8-(enem.y/8)%1 then
 	if plr.x > enem.x then
 		enem.xgoal = plr.x-8
 	else
 		enem.xgoal = plr.x+8
 	end
 	enem.xgoal = plr.x
 	enem.spd = 3
 end
end
-->8
-- animations, dialogue, shop --

--player--
--walk left, right, down 
d = 5 
function plr_walk() 
	d=d-1 
	if d < 0  then 
		plr.sp=plr.sp+1 
		if plr.sp != 97 then plr.sp=96 end 
		d=5
	end
end 

-- animation up 
d2=5 
function plr_up()
	d2=d2-1 
	if d2 < 0 then 
	plr.sp=plr.sp+1
	if plr.sp > 100 then plr.sp=99 end
	d2=5
	end 
end 

function an_plr()
	
	pflp = f
	if plr.move == "up" then  
		psf = 99
		pnf = 2 
		psp = 5
 else
 	psf = 96
 	pnf = 2
 	psp = 5 
 	
 	if plr.move == "left" then 
 		pflip = t 
 	end 
	end
	
	anim(plr,psf,pnf,psp,pflp)
	 
end 

-- enenmies
function an_enemy(i)
	--check which way to flip
	eflp = f
	
	if plr.x > i.x then 
		eflp = t
	end 
	
	func = f 
	
	if i.name == "slime" then
		func = t 
		sf = 64
		nf = 2 
		sp = 8
		  
	elseif i.name == "shadow" then 
		if i.moving == false then 
			i.s = 73
		else 
			i.s = 72
		end
		
	elseif i.name == "eye" then 
		if i.moving == f then 
			i.s = 74 
		elseif i.moving == true then 
			if plr.y < i.y then
				i.s = 122
			else
			 i.s = 75
			end 
		end
		
	elseif i.name == "skull" then 
		if plr.y > i.y then 
			i.s = 91
		else 
			i.s = 68
		end 
	
	elseif i.name == "ghost" then
		if i.moving == f then 
			i.s = 71
		else 
			func = t 
			sf = 69
			nf = 2 
			sp = 8 
		end
		
	elseif i.name == "blood" then
		if i.moving == f then 
			i.s = 77
		elseif plr.y < i.y then 
			i.s = 79
		elseif plr.y > i.y then 
			i.s = 76 
		else
			i.s = 79
		end  
	elseif i.name == "fire" then 
		func = t 
		sf = 86
		nf = 2 
		sp = 6
	elseif i.name == "spike" then
		func = t 
		sf = 80
		nf = 2
		sp = 9
	
	end
	
	-- if we use the function
	if func == t then 
		anim(i,sf,nf,sp,eflp)
	else 
		spr(i.s,i.x,i.y,1,1,eflp)
	end
	  
end 

--animation
function anim(o,sf,nf,sp,fl)
  if(not o.a_ct) o.a_ct=0
  if(not o.a_st) o.a_st=0

  o.a_ct+=1

  if(o.a_ct%(30/sp)==0) then
    o.a_st+=1
    if(o.a_st==nf) o.a_st=0
  end

  o.a_fr=sf+o.a_st
  spr(o.a_fr,o.x,o.y,1,1,fl)
end
	
-- dialogeeee
function draw_box()
	for i=8, 112,8 do
	 for j=112, 128,8 do 
			spr(3,i,104)
			spr(6,i,j)
		end 
	end
	
	--corner
	spr(2,0,104)
	spr(2,120,104,1,1,t,f)
	
	--side, left
	spr(7,0,112,1,1)
	spr(7,0,120,1,1)
	
	--side, right 
	spr(7, 120,112,1,1,t)
	spr(7, 120,120,1,1,t)
end

function draw_diag()
	
	if dis_diag == t then 
		draw_box() 
		print(sub(diag,1,flr(d_tick+6/3)),8,107)
		d_tick+=1
		if d_tick > 90 and input == f then
			dis_diag = false
			diag = ""
			d_tick = 0
		end
	end 
end 


--function to spawn our shop 
function spawnshop()
	
	spawned = t
	
	dis_diag = t
	input = f
	diag = "do you want to buy something?"

	draw_diag()

	item1.sp = buy[flr(rnd(3)) + 1]
	
	item1.x = 56
	item1.y = 64
	item1.tile = mget(item1.x/8,item1.y/8)
	item1.w = 8
	item1.h = 8
	
	item1.b = f 
	
	
	mset(7,8,item1.sp)
end

--draws shop
function drawshop()
	
	if spawned then --spr
		spr(152,48,56,4,3)
		--hamster
		spr(116,56,56,2,1)
		spr(118,60,51)
		
		--two items 
		if not  item1.b then 
			spr(item1.sp,56,64)
		end 
		
		--print(map_tile, 64,120,10)
	end 
end  

--info shows the items info
function i_info(it)
	if it == item1.tile then 
			thissp = item1.sp
		end 
	diag = "this is a"
	
	if thissp == 51 or thissp == 50 then 
		diag = diag.." heart.\nit willraise your health by one."
	elseif thissp == 36 then
		diag = diag.." key.\nyou can use these to open chests."
	elseif thissp == 16 then 
		diag = diag.." potion.\nthis will restore your health."
	end 
	
	dis_diag = t
		
end 

--wip
--this buys the item and applies effect
function buyitem(it)
	
	if plr.coins > 5 then 
	
		diag = "thanks for shopping!"
		dis_diag = t
		
		if it == item1.tile then 
			item1.b = t 
			thissp = item1.sp
			mset(item1.x/8,item1.y/8,0)
		end 
		
		if thissp == 51 or thissp == 50 then 
			plr.maxhp += 1
		elseif thissp == 36 then
			plr.keys += 1
		elseif thissp == 16 then 
			plr.health = plr.maxhp		
		end
		plr.coins-= 5
	else 
		diag = "you don't have enough money!"
		dis_diag = t
	end 
	
	shopping = f 
end 

--draws the would u like to buy
--will add the amount with it 
function draw_menu() 
	t1 = "buy"
	t2 = "info"
	
	if select == 1 then
		t1 = "➡️"..sub(t1,1)
	elseif select == 2 then 
		t2 = "➡️"..sub(t2,1)
	end

	print(t1,16,120)
	print(t2,80,120)

end

-- use the selection menu for 
-- our shop 
function use_menu()	
	if btn(0) then
		if not (select % 2 == 1) then
			select-=1
		end
	elseif btn(1) then
		if not (select % 2 == 0) then
			select +=1
		end
	elseif btnp(4) then
		shopping = f 
	elseif btnp(5) then
	 selected = true
		selection = select
	end
	
	selection_check()
end

--checks which one were trying to do
function selection_check()
	if selected then
		selected = false
		if select == 1 then 
		 buyitem(map_tile) 
		else 
			i_info(map_tile)  
		end 
	end 
end  
	 
-->8
-- boss code 

-- function to create boss 
newboss = function (name,hp)

	return {
	
	name = name, 
	hp = hp,
	spawned = false,
	sprts = {},
	enret = {},
	flp = false,
	last = time() - 10,
	lastjump = time()-10,
	attack = {"bite"},
	move = "down",
	spd = 1,
	x = 60,
	y = 64,
	w = 16,
	h = 16
	} 
	
end 

--function to make mini bosses and to set their sprites 
function make_mboss()
	clock = newboss("tik tok clok", 3) 
	clock.sprts = {88} 
	clock.sp = 88
	
	grim = newboss("grim reaper", 4)
	grim.sprts = {92,94}
	grim.sp = 94
	scythe.x = grim.x - 16
	scythe.y = grim.y 
	scythe.enret.x = scythe.x+8
	scythe.enret.y = scythe.y
	
	fish = newboss("rotting fish", 4)
	fish.sprts = {160,162}
	fish.sp = 160
	fish.spd = 0.5
	fish.enret = {
		x=fish.x+8,
		y=fish.y,
		w=8,
		h=8
	}  

	
	nmre = newboss("mr.nightmare",7)
	nmre.sprts = {132} 
	nmre.sp = 132
	nmre.spd = 0.2
	nmre.enret = {
		x=nmre.x+8,
		y=nmre.y,
		w=8,
		h=8
	} 
	nmre.w = 32
	nmre.h = 32 
	
	mbosses = {clock, grim, fish, bat, nmre} 
end 


--function to spawn a boss 
function spawn_mboss() 

	stop_muzak()
	start_muzak(2)
	
	--current boss 
	rndm = flr(rnd(3) + 1)
	
	--pick a boss we have not spawned 
	cboss = mbosses[rndm] 
	while cboss.spawn == false do 
		 cboss = mbosses[flr(rnd(3)+1)]
			cboss.spawn = true 
	end 
end

function spawn_nmreboss() 
	--pick a boss we have not spawned 
	cboss = mbosses[5]  
end

--draw the bosses 
function draw_boss()

	if cboss.name != "mr.nightmare" then
		spr(cboss.sp,cboss.x,cboss.y,2,2,flp)
	else 
		spr(cboss.sp,cboss.x,cboss.y,4,4,flp)
		draweye()
	end
end 

function draw_scythe()
	spr(scythe.sp,scythe.x,scythe.y,2,2, flp)
end
	
-- function to draw health 
-- and name, needs work tbh 
function draw_enemy_health()
  for i in all(enemy) do
    rectfill(i.x, i.y - 2, i.x + (2 * i.health), i.y-1, 8)
  end
end

function draw_boss_health()
	--figure out how to center 
	-- or just do a rect fill 
	print(cboss.name,40,16)
	local i = 0
	spr(5,40+i*8 ,8 , 1,1,t)
	while i < cboss.hp do
		spr(4,40+(i*8), 8)
		i+=1
	end 
	spr(5,40+(i*8),8)
	
end
 
 
function draweye()
	
	if plr.x < cboss.x-24 and plr.y > cboss.y+8 then
		eye = 136
		efl = f
		dr  = t
	elseif plr.x > cboss.x+24 and plr.y > cboss.y+8 then
		eye = 136
		efl = t
		dr  = t 
	elseif plr.y < cboss.y+8 then 
		eye = 138
		elf = false 
		dr  = t 
	else
		eye = 174 
		elf = false  
		dr = f 
	end 
	
	spr(eye, cboss.x+6, cboss.y+8, 2,1,efl,false)  	
	
end  

function boss_update()
	--an_enemy(cboss)
		if boss_attack() then
				print("weak")
		else 
			if cboss.name == "rotting fish" or cboss.name == "mr.nightmare" then
				x_diff = cboss.x - plr.x
				y_diff = cboss.y - plr.y 
				if abs(x_diff) > abs(y_diff) then
					if x_diff < 8 then
						boss_move("right",1)
					elseif x_diff > -8 then
						boss_move("left",1)
					end
				else
					if y_diff < 8 then
						boss_move("down",1)
					elseif y_diff > -8 then
						boss_move("up",1)
					end
				end
				enret_update(cboss)
			elseif cboss.name == "grim reaper" then
				x_diff = scythe.x - plr.x
				y_diff = scythe.y - plr.y 
				if abs(x_diff) > abs(y_diff) then
					if x_diff < 7 then
						enemy_move(scythe,"right")
					elseif x_diff > -7 then
						enemy_move(scythe,"left")
					end
				else
					if y_diff < 7 then
						enemy_move(scythe,"down")
					elseif y_diff > -7 then
						enemy_move(scythe,"up")
					end
				end
				enret_update(scythe)
				x_diff = cboss.x - plr.x
				y_diff = cboss.y - plr.y 
				if abs(x_diff) > abs(y_diff) then
					if x_diff < 16 then
						boss_move("right",1)
					elseif x_diff > -16  then
						boss_move("left",1)
					end
				else
					if y_diff < 16 then
						boss_move("down",1)
					elseif y_diff > -16 then
						boss_move("up",1)
					end
				end
			elseif cboss.name == "tik tok clok" then
				x_diff = cboss.x - plr.x
				y_diff = cboss.y - plr.y 
				if abs(x_diff) > abs(y_diff) then
					if x_diff < 32 then
						boss_move("right",1)
					elseif x_diff > -32  then
						boss_move("left",1)
					end
				else
					if y_diff < 32 then
						boss_move("down",1)
					elseif y_diff > -32 then
						boss_move("up",1)
					end
				end
			end
		end
end

function boss_move(direction,errors)
	if errors == 4 then
		return false
	end
	if direction == "right" then
		cboss.x += cboss.spd
		cboss.move = "right"
		if collide_map(cboss,"right",0) or cboss.x+cboss.w == plr.x or cboss.x > 104 then
			cboss.x -= cboss.spd
			errors += 1
		 boss_move("up",errors)
		end
	elseif direction == "left" then
			cboss.x -= cboss.spd
			cboss.move = "left"
			if collide_map(cboss,"left",0)or cboss.x == plr.x+8 or cboss.x < 24 then
				cboss.x += cboss.spd
				errors += 1
				boss_move("down",errors)
			end
	elseif direction == "up" then
			cboss.y -= cboss.spd
			cboss.move = "up"
			if collide_map(cboss,"up",0) or cboss.y == plr.y+8or cboss.y < 24 then
				cboss.y += cboss.spd
				errors += 1
				boss_move("right",errors)
			end
	elseif direction == "down" then
			cboss.y += cboss.spd
			cboss.move = "down"
			if collide_map(cboss,"down",0) or cboss.y+cboss.h == plr.y or cboss.y > 104 then
				cboss.y -= cboss.spd
				errors += 1
				boss_move("left",errors)
			end
	end
end

function boss_attack()
		attacked = false
		if time() - cboss.last > 3 then
		if cboss.name == "rotting fish" then
			if melee_attack(cboss,cboss.move) then
				cboss.last = time()
				attacked = true
			end
		elseif cboss.name == "tik tok clok" then
			if can_shoot(cboss) then
				cboss.last = time()-1
				attacked = true
			end
		elseif cboss.name == "grim reaper" then
		 if melee_attack(scythe,scythe.move) then
		 	cboss.last = time()
		 	attacked = true
		 end
		elseif cboss.name == "mr.nightmare" then
			if melee_attack(cboss,cboss.move) then
				cboss.last = time()+5
				plr.health -= 2
				attacked = true
			elseif can_shoot(cboss) then
				cboss.last = time()+5
				attacked = true
			end
		end
		end
		return attacked
end
__gfx__
0000000000000000377777777777777733333333333333330000000000000000000000000000000050000005dd001550dddddddd011156dddd111550dddddddd
0000000000011000700000000000000000000000000000030000000000000000000000000000000000000000dd111d5055515551056155dddd551d50dddddddd
0070070001000010700000000000000088888888888888800000000000000000000000000000000050000005dd0016505d615d6105d111ddddd51750666d51dd
0007700001000010700000000000000022222222222222200000000000000000000000000000000010100101dd11111011111111055156dddd751110555516dd
0007700001000010700000000000000000000000000000030000000000000000000000000000000015100151dd00155015555155011156dddd751550111156dd
0070070001000010700000000000000033333333333333330000000000000000000000000000000015000051dd111d5015d6615505615ddddd111d50661156dd
0000000000011000700000000000000033333333333333330000000000000000000000000000000051000015dd551650dddddddd05d155dddd55175051615ddd
0000000000000000700000000000000033333333333333330000000000000000000000000000000010000001dd651110dddddddd055111dddd751110155155dd
3344433311111111111111113333333333333333333333333333333333333333333333335111115500000000dddddddddddddddddddddddddddddddddddddddd
3302033314244241144aa4413388388333883883333aaa333393333333a333a333a333331115121500000000d550055dd500005ddddddddddddddddddddddddd
330303332444444214000041383383383888888833aa99a333a3393333a33333333333331188111100000000505005055000000565166d5165101010dd1666d5
303730339aaaaaa940000004383333383888888833a9a9a333993a33aa3aa33333333a331888882100000000505aa505500000055515555155101010dd515555
087882032449944224499442338333833388888333a9aaa333aa393333a333333333a3a3128822110000000050599505500000051111111111111111ddd51111
0888220324422442244224423338383333388833333aaa33399a999333a33a3333333a331122111500000000505005055000000516d516d516d516d5dd651165
30822033022222200222222033338333333383333333333399a99aa9333333333a333333511221210000000050111105501111051555155515551555dd651615
33000333300000033000000333333333333333333333333333999993a33333333333333a551111110000000001111111011111110000000000000000dd651651
333339333339333333393333333933333399933333330443aaa33aaa0000000000000000000000001111100000000000011111111111111111111111dd551551
33a3933333333393339a9333333a93333393933333307303a333333a0000000000000000000000001100000000000000000001111115111115111111ddd51615
33393933333393333339a933339aa333339993333307d033a333333a0000000000000000000000001000000000000000000000111551551511111111dd651166
339aaa933399a933339aa933339aa933333a333330dd0033333333330000000000000000000000001000000000000000000000111511115511111111dd651111
339aa993339aa9933399a9333399a933333aa33330d01103333333330000000000000000000000001000000000000000000000111115515511111111dd615555
34444933344449333332433333324333333a333330100103a333333a0000000000000000000000000000000000000000000000011515511151111111dd15d666
42232444422324443332433333324333333aa33330111103a333333a0000000000000000000000000000000000000000000000015511155151111111dddddddd
333332433333324333333333333333333333333333000033aaa33aaa0000000000000000000000000000000000000000000000011511511111111111dddddddd
33333333333333333d033dd03d033dd03333333333333333000000000000000000000000000000000000000000000000000000001111115111111111156156dd
33900933330000333d800d033d800d033300000030111133000000000000000000000000000000000000000000000000000000001155155511111111516156dd
30955903305555030888dd030888dd033099499401515113000000000000000000000000000000001000000000000000000000001551115511111111561156dd
0599995005000050088d8203088d8203330940940111151300000000000000000000000000000000000000000000000000000001111551111111111111115ddd
004004000000000002828203308282033309409401551513000000000000000000000000000000001000000000000000000000011515115511111111555515dd
000000000000000002822803308220333a99aaa4015115130000000000000000000000000000000010000000000000000000000115511551111111115d6661dd
30000003300000033022203330220333a94aa44430155113000000000000000000000000000000001100000000000000000000111111515111111111dddddddd
333333333333333330220333330033330000000033011133000000000000000000000000000000001111110000000000000011115515511111111111dddddddd
33000033333003333333333333333333333333333333033333333333333333333300003333000033333333333333333333088833333333333088033333300333
30888803330880333333333333333333333776633033333333333033333333333000000330000003330003333300033330886823333333330888803333088033
08222280308228030b33333b0b3333333370766d3330003303000330330003333700700330700703306870333087703330860783333333330868803333088833
82f8222830872803bbb333b3bbb33bb3337006dd33070703307070333070703330000003300000030d8086030808760308070080300888333378823330888803
82882228382222830b3bbb330b3bb33b376666dd33000003300000333000003330000003300000030d80860308087d0308000078088888233738820330288823
0888888038288283333333333333333336d6ddd000000000000000033000003330000003300000030d808d030808dd0328800002888882228688222232288222
3000000330800803333333333333333336d60003300003333300003333000333300000033000000330d8d033308dd03330288800302222000882220030022200
33333333333333333333333333333333300033333333333333333333333333333003003330030033330003333300033333000033330000333000003333302033
33333333336333338888888893333333333339333333333333338333338333833333344444433333333333333333333333333330066003333333333330000333
33333333336333333828823339998333399833333333333338388833333883333334499999944333333776633367776333333306655503333333333301111033
3666333336663633383823239aa998839aa98333333983333380983333899833334999a4aa9994333370766d3660706633333065555003333333333311111033
333333333333363332382333a77a9998a77a98833a798833338aa9833380a9393499aaa4aaaa9903337006dd3600700633333655500040333333333310111103
3333666333636663333223339aa998839aa9833333983333339a0999389a7093499a4aaaaaa4a990376666dd3677777633333650033040333333333110011110
333333333363333332333333399983333998333333333333338a7a99399a7a9349aaaaaaaaaaaa9036d6ddd03067676033333603333340333333333170711110
3666333336663333333233333333338393333333333333333339a9933339a933494a0aaaaa0aa49036d600033306d60333333033333302033333333100011110
33333333333333333333333333933333333333a333333333333333333333333349aaa0a90000aa90300033333330003333333333333330033333333101111110
333333333333333333333333333333333333333333333343333333333399993349aaaaa0aa0aaa90333333333333333333333333333330203333333111111103
439999333333333339999333399993433333333339999343232222333999ff93494aaaa0aaaaa49033333333333c333333333333333333003333333111111103
4999ff9334999933999ff9339999994339999343999999432222ee233f0ff0f349aaaaa0aaaaaa90333333333333333333333333333333003333333011111113
4f0ff0f33499ff93f0ff0f339999994399999943999999f32e8ee8e334ffff33499aaa000aaaa990cc3cc3c3333c333333333333333333333333333011111113
43ffff33340ff0f33ffff333399993439999994339999d4323eeee333fdddd3334994aa0aaa4990333333333333c333333333333333333333333333311103113
fddddd3334ffff334f4444443dddddf339999343fdddd333e888883334ddddf3334999aa4a999033333333333333333333333333333333333333333301103333
43ddddf33fdddd333ddddf33fdddd3433dddddf33dddd333238888e334833833333449999990033333333333333c333333333333333333333333333333103313
3383383334ddddf33833833338338333fdddd343383383333323323334333333333330000000333333333333333c333333333333333333333333333313033333
3333333333333333333f333333330003330999000099903333333333336663363333333333333333333333333939a93333333333333333333333333300000000
333633333333342333f7e3333330665330ff99999999ff033333333336333633336633333333333333000333339a7a9333393333333333333399993300000000
333633333333423333eee3333366555330ff79999999ff033311133363663363366363333333333330808033339a7a93333a3333333333a33999ff9300000000
3336333333342333333e333333655043330f70799079f033311111336363336336336333336663330d8086033389a983333a33333339aaaa3f0ff0f300000000
333633333342333333323333365033433307700770099090311111336333336333663333333666330d88860333389833333a3333333333a333cffc3300000000
339993333423333333323333350333433307777777779990310000333633363333333633333333330dd8dd0333338339333a33333333333333dddd3300000000
333c333333333333333233333033334330ff7777777ff9033733333333666363333333333333333330ddd033a333833333aaa333333333333fddddf300000000
333c33333333333333333333333333433300000000000033333333333333333333333333333333333300033333333333333a3333333333333383383300000000
33333033033333333333333333333333333333333333333333333333333333333330000000003333333300000000333333333333338333333333333333833333
3333300300333333333333333333333333333333333333333333333333333333330dd010dddd00333300dd01110d003333333333938333333333338333333333
333330030030333333333333333333333333333333000000000333333333333330dd01110ddddd0330dddd01110ddd0333333333998333333333333333333333
33333003003003333333333333333333333333330000000000000033333333330ddd01110dddddd00ddddd01110dddd0338333339a8333333333333339333333
30330000000003333333333113011333333333300000000000000003333333330ddd01110dddddd00ddddd01110dddd0333333339a9833333333338339933333
30011000000033333301130010001333333333300000000000000000333333330ddd01110dddddd00dddddd010ddddd033833388aa9933333383338899933933
300000000013333333010000000003333333333000000000000000003333333330dd01110ddddd0330dddddd0ddddd0338833389aaa9333338833389aaa93333
3300000001333333300000000000033333333300000000000000000033333333330dd010dddd00333300dddddddd00333893380000a938333893380000a93933
33300001111333333000000000000033333333000000000000000000033333330000000000000000000000000000000038a3300000093338300a900000099008
333331001113333330000000000000333333300000ddd010ddd00000033333330440000000000000000000000000044039a38010010938833800a01001090083
3333300001333333300000000dd0003033333000dddd01110dddd000003333330444444400000000000000004444444039aaa901100999833300090110000033
333300000133333330d00dd0030d0d033333000ddddd01110ddddd00003333330044222244444444444444442222240080000001100000038300000110000033
d0000000111333333ddd0d3d033333333333000ddddd01110ddddd00003333330042444422222222222222224444240038000011110000833303001111003033
3dd000d0dd1113333333d333333333333333000ddddd01110ddddd00003333330042444444444444444444444444240033003011110300333333301111033333
3333d33333ddd333333333333333333333300000dddd01110dddd000003333330042444444444444444444444444240033033300003330333333330000333333
333333333333333333333333333333333330000000ddd010ddd00000003333330042444444444444444444444444240033333333333333333333333333333333
33333333333333333333333333333333330000000000000000000000001333330004244444444444444444444442400033333333333333330000000000000000
3333333333333333333333333333333333100000000000000000000000133333000424444444444444444444444240003333333333333333000ddd010ddd0000
333330003333333333333000333333333310000000000000000000000013333300042444444444444444444444424000333333333333333300ddd01110dddd00
33330ddd0033333333330ddd00333333331000000000000000000000001333330004244444444444444444444442400033333333333333330dddd01110ddddd0
333330dddd033333333330dddd033333331000000000000000000000001133330004244444444444444444444442400033333333333333330dddd01110ddddd0
3333111111d033333333111111d03333331000000000000000000000001133330004244444444444444444444442400033333333333333330dddd01110ddddd0
33311111111d033333311111111d03313311000000000000000000000011333300042444444444444444444444424000333333333333333300ddd01110dddd00
3302222111111003331111111111100131110000000000000000000000111133000424444444444444444444444240003333330000333333000ddd010ddd0000
32260602011111103101111111111111311100000000000000000000001111130042444444444444444444444444240033333000000333330000000000000000
32000006211111113211111111111111311110000000000000000000001111130042444444444444444444444444240033333010010333330000000000000000
3260000021111111022221101111111033d1110000000011110000000111d1130042444444444444444444444444240033333301100333330000000000000000
122060602111000111222222111100033333110000000111110000000111dd330042444422222222222222224444240033000001100000330000000000000000
000222222001133000000000011033333333dd100000111111111100011dd3330044222244444444444444442222440030000000000000030000000000000000
33300000033003333333333011033333333333d1100111d111ddddd1133333330444444400000000000000004444444033003300330300330000000000000000
333333333333333333333333003333333333331111dddd3311333333333333330440000000000000000000000000044033033333333330330000000000000000
33333333333333333333333333333333333331111333333333333333333333330000000000000000000000000000000033333333333333330000000000000000
00000000111111111111111111111111200020002222200000000000022222222220027702227770002227770220227022277770000000000000000030000333
00000000111111111111111111111111002000202200000000000000000002220220002700222200022222202220022722222227000000000000000001111033
00000000111000000000000000000111020022002000000000000000000000220227002700022000222000002200002722022202000000000000000011111033
00000000110120202022022002001011000200202000000000000000000000222222702700022000220022702227702720022000000000000000000010111103
00000000110010020000002000012011200200002000000000000000000000222202222700022000220002272222222200022000000000000000000010011110
00000000110001000022000220100011002002000000000000000000000000022200222700227000222700272200222200022000000000000000000070711110
00000000110200100220022001002011000020000000000000000000000000022270022700222700022272222270022200227000000000000000000000011110
00000000110002010000000010020011220020020000000000000000000000022227002202222270002222020220222002222700000000000000000001111110
00000000110002001111111111111111000020110000000000000000000000000222007000277770222777000222277027700000000000000000000011111103
00000000110200201100000000000000020020110000000000000000000000002220002700022227222222702222222722700000000000000000000011111103
00000000110000201000202020002020020000112000000000000000000000002222022700022227022000222200022202200000000000000000000011111113
00000000110020001020002020200020000200110000000000000000000000022222222700222022022000222227000222000000000000000000000011111113
00000000110020001020200022202000000200112000000000000000000000022202222202270022027002200222700000000000000000000000000011103113
00000000110000201020202220202022020000112000000000000000000000022200202202227222022722002220007700000000000000000000000001103333
00000000110200201022200220222002020020112200000000000000000000222270002222222222222022702222222700000000000000000000000033103313
00000000110200001020220202202202002000112222220000000000000022222227022222000222222002270222222000000000000000000000000013033333
00000000110020011002200220002020102000112022000111111111000000002277770000000000277000000227700002222770000000000000000000000000
00000000110200101022020220200020010020110202020100000011000000002222227000000000227000000222200022222227000000000000000000000000
00000000110001021000020022202000001000110200020122222001000000000220222200000000022000000022000002220022000000000000000000000000
00000000110210001022200220202022200100110202000102000001000000000220022200000000220000000022000000222002000000000000000000000000
00000000110100201000202020222002020210112002220122220201000000000270002200000000000000000022700070022700000000000000000000000000
00000000111000001020002002202202000001110020000120000001000000002227022200000000000000000000000027002270000000000000000000000000
00000000111111111020202000202020111111112020220100202201000000002222722200000000000000000027700022222227000000000000000000000000
00000000111111111000220222202000111111112002200122200001000000002222222000000000000000000022000002222220000000000000000000000000
00000000000000000000000000000000202202201000022220220201000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000220020200000000200222021022020020022201000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000002000220000000000220202021000000222020201000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000200000000000000000202221020222200020201000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000020222000000000020002021000002002000201000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000020200021002222202020001000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001111111100000000000000001100000000000011000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001111111100000000111111111111111111111111000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000100000000000000010101010105030100000000000000000000010101000000000500000000000000000000010000050500000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010101000000000000010100000000010100010000000000000101000000000001000000000000000000000000000000010000000000000000000000000000
__map__
0000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1f1d1e1e1d1d1d1d1d1d1d1e1e1d1d0f00c1c2c2c2c2c3cacacacac1c2c2c2c2c30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2d2d2d2d2d2d3d3d2d2d2d2d2d2d0d00d1d2d3d3d3d3e3e3e3e3d3d3d3d3e6d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b2d2d2d3d3d3d3d3d2d2d3d3d3d2d0d00d1e2e3c5c6e3e3e3e3e3e3e3e3e3e5d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2d2d2d3d3d3d2e3d2d3d3d3d3d2d0d00d1e2e3d5d6e3c4c4c4c4c4c4e3e3e5d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2d2d2d2d2d2d2d2d2d2d2d2d2d2d0d00d1e2c4c4e3e3c4c4c4c4c4c4e3e3e5d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2d3d3d3d3d3d3d2d2d2d2d2d2d2d0d00e1e2c4c4c4e3e3e3e3e3e3e3e3e3e5e40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e3d3d3d3d3d3d3d2d2d2d2d2d2d2d0d00dae3e3c4c4e3e3c5c6c7e3e3e3e3e3db0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e3d3d3d3d2d2d2d2d2d2d3d3d3d2d0d00dae3c4c4e3e3e3c6c6c6e3e3e3e3e3db0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e3d3d3d2d2d2d2d2d2d2d3d3d3d2d0d00dae3e3e3e3e3e3c6c6d7e3c4e3e3e3db0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2d2d2d2d3d3d3d3d2d2d3d3d3d2d0d00c1e2e3e3e3e3e3d5d7c4c4c4e3e3e5c30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2d2d2d2d2d2d2d3d2d2d2d3d3d2d0d00d1e2e3e3e3e3e3e3c4c4c4c7e3e3e5d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e2d2d2d2d2d2d2d2d2d2d2d3d3d2d0d00d1e2e3c5e3e3c4c4c4c4c4d7e3e3e5d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b2d2d2d2d3d3d3d2d2d2d2d2d2d2d0d00d1e2e3d5c7c4e3c4c4e3e3c4e3e3e5d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b2d2d2d2d3d3d2d2d2d2d2d2d2d2d0d00d1f5f4f4f4f4e3e3e3e3f4f4f4f4f6d40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f0c0c0c0c0c0c0c0c0c0c0c0c0c0c3f00e1f2f2f2f2e4cbcbcbcbe1f2f2f2f2e40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000082000b2000b2001e000240002d000310003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002475015550195501a55020550175501455024700197001a900167001c000137000000031000000001870000000197000000006700000000b70000000157001180013700000001b700000001270000000
0116001e0e0520f052055520f0520f052065520d0520d052065520c0520c052065520905209052045520905209052035520805208052025520905209052025520d0520d052045520d0520d052055520d00200000
011000001e05520055220550010019f0014f000ef000bf000af0009f0007f0007f0007f000ad0007f0008d0007d0007d0009c0007d0007d00000001ec001ac000000016c0012c0011c0010c00000000000000000
011000002e710317101a0020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000625000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000376511425214252256510f2520f252136510325203252326000b2000b2000d2000f200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000025913299130d8001080009800000003880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010a000023f5226f5229f520000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000
001200003f372000000b7003f372097000b7003f372000003f3723f3003f3723c3003f3723b3523f3523a3523f352363522b3521632203322023120000000000000000000000c00000000000000c000000021300
0010000000a1000a700167005a7001a400062001a2002670026700167001660006500064001630016300063000630016300003000030016200001000010006100061000610000000000000000000000000000000
001000003c3300000000000000000000000000000003c3300000000000000000000000000000003c33000000000000000000000000003b3003c33000000000000000000000000003f30030370000000000000000
001000000b05008050000000405005050010000300003000050000605006050000000305003050000000f6700f6700f6700f67000000000000000000000000000000000000000000000000000000000000000000
0016001e01c7001c7002c0000c7004c0003c7003c7001c0000c700cc0007c7007c7001c0000c7002c000fc700fc7005c0000c7005c000ac700ac7007c0000c700000006c7006c7007b0000c700000001c7001c70
001600180007004070000000000000070000000000000000000700010000000000000007004070000000000000070001000000000000000700000000000000000000005000000000000000000095000000003500
001600201151011510115100d5100d5100d5101051010510105100c5100c5100c5101151011510115101151011510155101551015510105101051012510125101251013510135101351013510125101151011510
0012001f000000d9500d9500c9500c9500c9500b9000b9500b9500b9500a9500a9500a9500a9500a9500a9000b9500b9500c9500c9500c9500c9500c9500d9500d9500d9500c9500c9000b9500b9500b9500b950
015000200f522075220e5220e5220b522095220b5220c5220c5221252215522155221552212522115221052211522115220d5220e52211522115220e5220b52208522085220b5220b5220b522095220b52213522
005a001e0055002550045520055002550045520755000550055520455007550045520255000550025520455000550025520455007550005520255000550005520055004550025520055004550025520210003100
005a00000077300000000000077300000000000077300000000000077300000000000077300000000000077300000000000077300000000000077300000000000077300000000000077300000000000077300000
015000000012201122021220112200122011220212201122001220112202122011220012201122021220112200122011220212201122001220112202122011220012201122021220112200122011220212201122
015000200311507115021150211505115041150511500115001150611509115091150911506115051150411505115051150111502115051150511502115051150511505115041150511507115061150311506115
005000202421226212282122921224212262122821229212292122821224212262122921228212262122921224212262122921228212292122821228212242122921228212262122421224212262122821226212
__music__
00 12135444
03 11155644
03 024f5044
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 4d4e4344

