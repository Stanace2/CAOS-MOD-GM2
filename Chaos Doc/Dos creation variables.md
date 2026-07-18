Variables initialized in create | obj_player, used by Donisha
## create | obj_player
[[obj_player#Create]]
### Local

~~~js
// Donisha's variables
snaphold = 0  
wallclimbbuffer = 0
fightmode = 0  
snapjumps = 0  
drillexitspd = 0  
mach5 = 0  
machengineprev = -1  
mach5buffer = 0
canrollsnd = 0  // Have to check this one to optimize it
poundbuffer = 0
quickroll = 0
// Italian manners
dos = 1
// unused
machhold = 1  
~~~
### Var init outside Chaos custom scripts
#### snapjump
##### obj_player | EndStep
#states 
[[obj_player#EndStep]]
~~~js
if (sprite_index != spr_player_snapjumpstart && sprite_index != spr_player_snapjumpstart && state != (306 << 0))  
    snapjumps = 0
~~~
#### snaphold
##### obj_player | EndStep
#states
[[obj_player#EndStep]]
~~~js
if (state != (306 << 0) && ispeppino)  
    snaphold = 0
~~~
#### fightmode
##### obj_player | EndStep
[[obj_player#EndStep]]
~~~js
// This can go anywhere
fightmode = (instance_exists(obj_bosscontroller) && ispeppino && (!instance_exists(obj_pistolpickup)))
~~~
##### scr_player_handstandjump
#states
This goes at the top of the handgrab state
~~~js
// Donisha's awesome kicks
if (fightmode && dos && (!instance_exists(obj_pizzaface_thunderdark)))  
{  
	if (!grounded)  
	{  
		state = (80 << 0)  
		flash = 1  
		fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
		sprite_index = choose(spr_player_kungfuair1, spr_player_kungfuair2, spr_player_kungfuair3)
		image_index = 0  
		movespeed = 13  
	}  
	else  
	{  
		state = (80 << 0)  
		flash = 1  
		fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
		sprite_index = choose(spr_player_kungfu1, spr_player_kungfu2, spr_player_kungfu3)
		image_index = 0  
		movespeed = 13  
	}  
	return;  
}
else  
{  
	if (shoot == 1)  
		var attackdash = spr_player_pistolshot  
	else  
		attackdash = spr_suplexdash  
		var airattackdash = spr_suplexdashjump  
		var airattackdashstart = spr_suplexdashjumpstart  
}
~~~
#### mach5 || mach5buffer
##### obj_player | EndStep
[[obj_player#EndStep]]
~~~js
if (movespeed < 21)  
{  
    if mach5  
        alarm[11] = 350  
    mach5 = 0  
}
~~~
##### obj_player | Alarm 11

~~~js
if (!mach5)  
    mach5buffer = 0
~~~