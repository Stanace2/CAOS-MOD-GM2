Inside obj_player | Create, a function called **"scr_characterspr()"** is runned, initializing all of peppino's sprites.
Some changes were made at the end of this function, to prevent something from breaking.
## scr_character_spr_init()
Uses:
- characterID variable | [[Player create shenanigans]]
- Script where this is initialy executed | [[obj_player#Create]]
~~~js
function scr_character_spr_init() // starts only the necessary sprites for the characters
{  
    switch characterID  
    {  
        case 0:  
            scr_spr_dos()  
            break  
        case 1:  
            scr_spr_wm()  
            break  
        case 10:  
            scr_spr_fakedos()  
            break  
    }  
}
~~~

## Lap portal changes
For other characters to use the lap portal, the following has to be changed
### obj_lapportal | Step
Look for the sprite **"spr_pizzaportalend"** and replacethem with the line:
~~~js
spr_lapportal_in
// Or in the case of not using with(player)
obj_player.spr_lapportal_in
~~~
### obj_lapportalentrance | Step
Same goes for this one **"spr_pizzaportalentrancestart"**
~~~js
obj_player.spr_lapportal_out
~~~
## scr_player_timesup()
~~~js
if (sprite_index != spr_player_ratmounttimesup)  
	sprite_index = spr_deathend  
else  
{  
	sprite_index = spr_player_ratmountgameover  
	// This sprite was changed to add mango to timesup, without screwing anything else in the code
	with (create_debris(x, y, spr_mango_dead))  
	{  
		hsp = 4  
		vsp = -8  
	}  
}
~~~