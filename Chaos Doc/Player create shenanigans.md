Variables initialized in create | obj_player, used by all characters
## create | obj_player
[[obj_player#Create]]
### Universal Global
~~~js
// Mort friendship
// Used in obj_mort_Collision_obj_player
global.friendShip = 0
// Goth palette
global.gothkills = 0  
global.gothunlocked = 0  
~~~
### Universal Local
~~~js
// Debug options, used in drawGUI | obj_player, set on EndStep | obj_player
displaykeys = 0  
displaydata = 0
input_buffer_chaos = 0
// 0 Donisha 1 WM 2 Stefano 3 Cezar 4 Clery 5 Acexby 9 fakeDonisha
characterID = 0
// Sits right on top of the sprite initializer
scr_characterspr()
~~~
#### global.friendShip
Donisha and mort unite forces
##### obj_mort | Collision_obj_player
Single line to up the friendship meter
~~~js
if (state != (11 << 0) && state != (12 << 0) && state != (13 << 0) && state != (14 << 0) && state != (190 << 0))  
{  
	// H e r e
	global.friendShip += 1  
	repeat (6)  
	create_debris(x, y, 1657)  
	mort = 1  
	movespeed = hsp  
	state = (11 << 0)  
	fmod_event_one_shot_3d("event:/sfx/mort/mortpickup", x, y)  
	create_transformation_tip(lang_get_value("morttip"), "morttip")  
	instance_destroy(other)  
}
~~~
##### scr_player_mort()
Will have to be modified due to the sprite migration
~~~js
if ispeppino  
{  
	if (global.panic || global.friendShip >= 4)  
	{  
		spr_playermortidle = spr_player_mortidleD  
		spr_playermortwalk = spr_player_mortwalkD  
		spr_playermortjump = spr_player_mortjumpD  
		spr_playermortjumpstart = spr_player_mortjumpstartD  
		spr_mortdoublejumpstart = spr_player_mortdoublejumpD
		spr_playermortland = spr_player_mortlandD
		spr_mortdoublejump = spr_player_mortjumpD
		spr_mortattackfront = spr_player_mortattackfrontD  
	}  
	else  
	{  
		spr_playermortidle = spr_player_mortidle  
		spr_playermortwalk = spr_player_mortwalk  
		spr_playermortjump = spr_player_mortjump  
		spr_playermortjumpstart = spr_player_mortjumpstart  
		spr_mortdoublejumpstart = spr_player_mortdoublejump 
		spr_playermortland = spr_player_mortland
		spr_mortdoublejump = spr_player_mortjump
		spr_mortattackfront = spr_player_mortattackfront  
	}  
}
~~~
#### displaykeys || displaydata
##### obj_player | EndStep
Debug toggler [[obj_player#EndStep]]
~~~js
if keyboard_check_pressed(vk_f7)  
    displaykeys = (!displaykeys)  
if keyboard_check_pressed(vk_f6)  
    displaydata = (!displaydata)
~~~
##### obj_player | DrawGUI
Display [[obj_player#DrawGUI]]
~~~js
// Cyan color code
scr_displaykeys(16776960, displaykeys)  
scr_displaydata(displaydata)
~~~
#### input_buffer_chaos
Buffer used for a lot of stuff
##### obj_player | EndStep
[[obj_player#EndStep]]
~~~js
// Placed at the end
if (key_shoot2 || input_buffer_chaos > 0)  
    input_buffer_chaos++  
else  
    input_buffer_chaos = 0  
if ((!key_shoot) || input_buffer_chaos == -1)  
    input_buffer_chaos = 0
~~~