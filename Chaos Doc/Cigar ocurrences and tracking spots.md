List of appearances of the cigartracker in code
## obj_exitgate
[[obj_exitgate#Create]]
### Create
~~~js
// Creating the cigartracker right in the lobby of the tower
if (!instance_exists(obj_cigartracker))  
    instance_create(0, 0, obj_cigartracker)
~~~
## gml_GlobalScript_scr_do_rank

~~~js
// Right below the function statement
// This helps the cigartracker decide where to check if the parameters of a palette were met, or when to save info inside the save file for optimization
if instance_exists(obj_cigartracker)  
{  
	obj_cigartracker.boss_trigger = 0  
	obj_cigartracker.checklevel = 1  
	obj_cigartracker.lvl = global.leveltosave  
	obj_cigartracker.checkexit = 1  
}
~~~
## obj_endingrank

### Create
~~~js
// In the part of code where the game checks if the final rank is one of the speed run ones, the cigartracker should jump
if (ini_read_string("Game", "finalrank", "none") == "none")  
{  
	// Maguma
    if (global.file_minutes < 240 && _perc >= 95)  
    {  
        rank_spr = 3646  
        if instance_exists(obj_cigartracker)  
        {  
            with (obj_cigartracker)  
                alarm[1] = 1  
        }  
    }  
    // Aqua pop
    else if (global.file_minutes < 120)  
    {  
        rank_spr = 1876  
        if instance_exists(obj_cigartracker)  
        {  
            with (obj_cigartracker)  
                alarm[2] = 1  
        }  
    }  
}
// Quetzal cook
if (_perc == 69)  
{  
    if instance_exists(obj_cigartracker)  
    {  
        with (obj_cigartracker)  
            alarm[3] = 1  
    }  
}
~~~
## scr_chaos_restart
[[Restart function#gml_Script_scr_chaos_restart]]
~~~js
// This block saves the goth kills
// Tells cigartracker to check for shadow palette and hellish
// Deactivates boss trigger
if instance_exists(obj_cigartracker)  
	{  
	with (obj_cigartracker)  
	{  
		alarm[0] = 5  
		shadow_chk = 1  
		hellish_chk = 1  
		boss_trigger = 0  
	}  
}
~~~
## scr_player_superslam

~~~js
// Inside this player script is a single line that add the goth kill to the global variable
if (sprite_index == spr_piledriverland && floor(image_index) == (image_number - 1))  
{  
	// H e r e
	global.gothkills++  
	vsp = -6  
	state = (92 << 0)  
}
~~~