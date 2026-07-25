Inside obj_player | Create, a function called **"scr_characterspr()"** is runned, initializing all of peppino's sprites.
Some changes were made at the end of this function, to prevent something from breaking.
## Sprites to be added as a variable

spr_player_Sjumpcancelstart
spr_player_Sjumpcancel
spr_player_poundcancel1
spr_player_poundcancel2
spr_pizzaportalentrancestart
spr_pizzaportalend
spr_player_throw
spr_vstitle_player
spr_vspeppino
spr_vspeppinoshadow
spr_bossfight_playerhp + palette
spr_player_gnomecutscene1
spr_player_gnomecutscene2
spr_player_gnomecutscene3
spr_player_gnomecutscene4
spr_player_screamtransition
spr_player_kungfu1
spr_player_kungfu2
spr_player_kungfu3
spr_player_lungehit
spr_peppino_superattackHUD
spr_player_levelcomplete
spr_peppinoelevator
spr_player_firemouthspin ==> scr_player_firemouth()
spr_player_mortattackfront
spr_player_mortattackup
spr_player_mortattackdown
spr_player_pistolintro
spr_player_pistolidle
spr_player_pistoljump1
spr_player_pistoljump2
spr_player_pistolland
spr_player_pistolwalk
spr_player_pistolshotend
spr_peppino_duel
spr_player_rocketslide
spr_player_rocketrun
spr_spacetravelcutscene
spr_noise_intro1
spr_player_fightball ==> Unused
spr_noise_phasetrans1P
spr_player_ratballoon
spr_taxitransition_pep
spr_player_rampjump ==> scr_player_trickjump() and others
spr_taxitransition_cop
spr_taxitransition_pizzaface
spr_boxxedpep_spin
spr_boxxedpep_flap
spr_cheesepepwalljump
spr_player_trashstart
spr_player_trashjump
spr_player_trashjump2
spr_player_trashfall
spr_player_trashslide
spr_player_jetpackstart
spr_player_jetpackmid
spr_player_jetpackend
spr_player_poweredup
spr_pepanimatronic
spr_animatronicdebris
spr_pepbossintro1
spr_pepbossintro2
spr_pepbossintro3
spr_player_suplexmash5
spr_player_suplexmash6
spr_player_suplexmash7
spr_pizzahead_beatdown*
spr_pizzahead_piledriverfinal
bg_piledrivercloseshot
ALL TITLE CARDS
spr_player_idle => obj_johnresurrection
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