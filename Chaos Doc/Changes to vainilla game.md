## obj_player
### EndStep
[[obj_player#EndStep]]
~~~js
// This breaks ice block when playing without italian manners
if ((global.noisejetpack || flamedash) && ispeppino && dos)  
{  
    with (obj_iceblock_breakable)  
    {  
        if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))  
        {  
            instance_destroy()  
            GamepadSetVibration(0, 0.5, 0.5, 0.8)  
        }  
    }  
}
// Creates blood droplets with the flesh costume
if (paletteselect == 23 && ispeppino)  
{  
    if (vsp < 0 && (floor(image_index) % 2) == 0)  
        create_debris(x, (y + 43), spr_blooddrop)  
    if (hsp != 0 && (floor(image_index) % 4) == 0)  
        create_debris(x, (y + 43), spr_blooddrop)  
}
// Dumb shit, maybe later if i add a noise skin
if (key_shoot2 && (!ispeppino))  
    instance_create(x, y, obj_canonexplosion)
// Debug stuff
if keyboard_check(ord("1"))  
{  
    characterID = 0  
    scr_character_spr_init()  
}  
if keyboard_check(ord("2"))  
{  
    characterID = 1  
    scr_character_spr_init()  
}  
if keyboard_check(ord("9"))  
{  
    characterID = 10  
    scr_character_spr_init()  
}  
if (keyboard_check(ord("0")) && (!instance_exists(obj_fakedonisha)))  
    instance_create(x, y, obj_fakedonisha)  
if keyboard_check_pressed(ord("P"))  
    instance_create(x, (y - 200), obj_slipnslide)
~~~
## scr_dotaunt()

~~~js
// Taunts for some reason only count to an static value
// Fix
scr_create_parryhitbox()
fmod_event_one_shot_3d("event:/sfx/pep/taunt", x, y)
taunttimer = 20
sprite_index = spr_taunt
if (paletteselect == 18) // pep palette, should be allocated for charid = 0 only
	image_index = random_range(30, (image_number - 1))
else
	image_index = random_range(0, (image_number - 1))
~~~
## Instakill()
#states
This code IS REALLY IMPORTANT DONT MISS IT
~~~js
// Right at the bottom of the function, helps characters not stuck in place when hsp doesnt carry a movespeed variable
if (sprite_index != spr_player_ratmountwalljump && sprite_index != spr_player_snapjump && sprite_index != spr_player_snaphighjump && sprite_index != spr_player_spinkf && sprite_index != spr_player_rolljump && sprite_index != spr_player_poundcancel && sprite_index != spr_player_poundcanceldive && sprite_index != spr_player_snapjumpstart && sprite_index != spr_player_snapjumpinter && state != (97 << 0))  
        state = (61 << 0)
~~~