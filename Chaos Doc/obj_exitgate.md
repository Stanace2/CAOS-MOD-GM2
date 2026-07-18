### Create
Refers to:
- Chaos toppin goal | [[Chaos UI]] | [[scr_ktoppingoal]]
- Cigartracker | [[Cigar ocurrences and tracking spots#obj_exitgate]]
~~~js
image_speed = 0  
image_index = 1  
if (room != tower_entrancehall)  
    instance_destroy(obj_pigtotal)  
if (room == tower_entrancehall)  
    alarm[0] = 2  
if (room != rm_editor)  
    depth = 50  
random_secret = 0  
roomname = room_get_name(room)  
global.progress = string_letters(roomname)  
drop = 0  
drop_y = y  
vsp = 0  
grav = 0.5  
dropstate = (0 << 0)  
hand_y = y - 1000  
handsprite = 307  
handindex = 0  
uparrow = 0  
uparrowID = -4  
if (obj_player.character == "S")  
    instance_destroy()  
snd = 0  
// Chaos challenge level toppin goal
scr_settoppingoal()  
// Creates the cigertracker if none exists
if (!instance_exists(obj_cigartracker))  
    instance_create(0, 0, obj_cigartracker)
~~~
### Collision_obj_player
Refers to:
- Chaos Util functions | [[List of tool functions#scr_chaos_utils#scr_corrupt_door()]]
- Chaos chaser | [[Caos Chaser]]
~~~js
if (image_index == 1 && global.panic == 0 && room != war_13)  
{  
    with (obj_player)  
    {  
        if (state == (95 << 0) && floor(image_index) == (image_number - 2))  
        {  
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            GamepadSetVibration(0, 1, 1, 0.9)  
            GamepadSetVibration(1, 1, 1, 0.9)  
            with (obj_player1)  
            {  
                lastroom = room  
                sprite_index = spr_levelstart  
                image_index = 0  
                with (obj_camera)  
                {  
                    shake_mag = 10  
                    shake_mag_acc = 30 / room_speed  
                }  
            }  
            if (global.coop == 1)  
            {  
                with (obj_player2)  
                {  
                    lastroom = room  
                    sprite_index = spr_levelstart  
                    image_index = 0  
                    with (obj_camera)  
                    {  
                        shake_mag = 10  
                        shake_mag_acc = 30 / room_speed  
                    }  
                }  
            }  
            other.image_index = 0  
            // Spawns chaos chaser, in the future it'll do more cool shit
            scr_corrupt_door()  
            ds_list_add(global.saveroom, other.id)  
        }  
    }  
}  
if (drop && dropstate != (126 << 0))  
    return;  
with (obj_player)  
{  
    if (grounded && x > (other.x - 160) && x < (other.x + 160) && key_up && (state == (0 << 0) || state == (99 << 0) || state == (103 << 0) || state == (104 << 0) || state == (121 << 0)) && (global.panic == 1 || global.snickchallenge == 1 || room == war_13 || other.random_secret))  
    {  
        global.noisejetpack = 0  
        global.startgate = 0  
        stop_music()  
        if (global.collect <= 0)  
            global.collect = 10  
        scr_do_rank()  
    }  
}
~~~
### RoomStart

~~~js
// No clue why this is here if create already does the job?
scr_settoppingoal()  
if (ds_list_find_index(global.saveroom, id) != -1 && global.panic == 0)  
    image_index = 0  
if (ds_list_find_index(global.baddieroom, id) != -1 && drop)  
{  
    y = drop_y  
    dropstate = (126 << 0)  
    hand_y = -100  
}  
random_secret = (instance_exists(obj_randomsecret) && obj_randomsecret.start)
~~~
### RoomEnd

~~~js
if (drop && global.panic && dropstate != (0 << 0) && ds_list_find_index(global.baddieroom, id) == -1)  
    ds_list_add(global.baddieroom, id)  
global.prank_cankillenemy = 0  
if (room == Realtitlescreen || room == Longintro || room == Mainmenu || room == rank_room || room == rm_levelselect || room == timesuproom || room == boss_room1 || room == characterselect || room == hub_loadingscreen || (string_copy(room_get_name(room), 1, 5) == "tower" && (!global.panic)))  
{  
}  
else if (global.caoschase && (!instance_exists(obj_chaoschaser)))  
{  
	// All in a tiny package
    obj_player1.supercharged = 1  
    instance_create(x, y, obj_chaoschaser)  
}
~~~