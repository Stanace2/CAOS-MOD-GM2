# obj_door
Some changes got done to this object, for a very VERY niche interaction with italian manners and Wetham and Mango from v1.1
It's pretty good non the less, so im keeping it
variable *forceDoor* should be added at the creation code for the transition to happen
## Create

~~~js
image_speed = 0.35  
visited = 0  
depth = 103  
targetDoor = "A"  
forceDoor = ""  // Variable to mark a door to hover to, instead of room transition
group_arr = -4  
offload_arr = -4  
locked = 0  
john = 0  
alarm[0] = 1  
uparrowID = scr_create_uparrowhitbox()  
if (room == tower_5)  
{  
    if global.panic  
    {  
        with (obj_door)  
            instance_create((x + 50), (y + 96), obj_rubble)  
        with (obj_bossdoor)  
            instance_create((x + 50), (y + 96), obj_rubble)  
    }  
}
~~~
## Collision | obj_player

~~~js
if locked  
    return;  
var _actor = 0  
var door = id  
with (obj_player)  
{  
    if (state == (146 << 0))  
        _actor = 1  
}  
if _actor  
    return;  
if global.horse  
    return;  
if (john && global.panic)  
    return;  
if (!(place_meeting(x, y, obj_doorblocked)))  
{  
    with (other)  
    {  
	    // A lil exception when playing as WM duo
        var wm = ((state == (100 << 0) && sprite_index == spr_wm_roll) || state == (5 << 0) || state == (105 << 0) || state == (80 << 0))  
        if (key_up && (!instance_exists(obj_jumpscare)) && grounded && (state == (191 << 0) || state == (198 << 0) || state == (283 << 0) || state == (0 << 0) || wm || state == (103 << 0) || state == (104 << 0) || state == (58 << 0) || state == (121 << 0) || state == (99 << 0)) && y == (other.y + 50) && (!instance_exists(obj_noisesatellite)) && (!instance_exists(obj_fadeout)) && state != (112 << 0) && state != (95 << 0))  
        {  
	        // Right h e r e
	        // This code moves the player and changes the camere state to hover and intercept the player
            if (other.forceDoor != "")  
            {  
                state = (95 << 0)  
                x = (asset_get_index("obj_door" + other.forceDoor).x) + 16  
                y = (asset_get_index("obj_door" + other.forceDoor).y) - 14  
                fmod_event_one_shot("event:/sfx/misc/door")  
                if (object_index == obj_player1)  
                {  
                    image_index = 0  
                    if isgustavo  
                    {  
                        if (!brick)  
                        {  
                            instance_destroy(obj_brickball)  
                            instance_destroy(obj_ratmountgroundpound)  
                            instance_destroy(obj_brickcomeback)  
                            instance_destroy(obj_mangoghost)  
                            brick = 1  
                        }  
                        sprite_index = spr_ratmount_exitdoor  
                    }  
                    else  
                        sprite_index = spr_walkfront  
                }  
                if (object_index == obj_player2)  
                    obj_player2.sprite_index = obj_player2.spr_lookdoor  
                if (instance_exists(obj_player2) && global.coop == 1)  
                {  
                    if (object_index == obj_player2)  
                    {  
                        obj_player1.x = obj_player2.x  
                        obj_player1.y = obj_player2.y  
                    }  
                    if (object_index == obj_player1)  
                    {  
                        obj_player2.x = obj_player1.x  
                        obj_player2.y = obj_player1.y  
                    }  
                }  
                with (obj_player2)  
                {  
                    if instance_exists(obj_coopplayerfollow)  
                        state = (186 << 0)  
                }  
                with (obj_camera)  
                {  
                    followspeed = 30  
                    followtarget = 587  
                    state = (299 << 0)  
                }  
                return;  
            }  
            else  
            {  
                if (room == tower_5 || other.object_index == obj_pumpkindoor)  
                {  
                    if (other.object_index == obj_pumpkindoor)  
                    {  
                        notification_push((61 << 0), [room])  
                        global.levelreset = 1  
                    }  
                    obj_player1.backtohubroom = room  
                    obj_player1.backtohubstartx = obj_player1.x  
                    obj_player1.backtohubstarty = obj_player1.y  
                }  
                if (room == trickytreat_1)  
                    notification_push((63 << 0), [room])  
                obj_player1.lastroom = room  
                obj_player2.lastroom = room  
                fmod_event_one_shot("event:/sfx/misc/door")  
                obj_camera.chargecamera = 0  
                ds_list_add(global.saveroom, id)  
                if (object_index == obj_player1)  
                {  
                    if obj_player1.isgustavo  
                    {  
                        if brick  
                            obj_player1.sprite_index = spr_ratmount_enterdoor  
                        else  
                            obj_player1.sprite_index = spr_wethamenter  
                    }  
                    else  
                        obj_player1.sprite_index = obj_player1.spr_lookdoor  
                }  
                if (object_index == obj_player2)  
                    obj_player2.sprite_index = obj_player2.spr_lookdoor  
                obj_player1.targetDoor = other.targetDoor  
                obj_player1.targetRoom = other.targetRoom  
                obj_player2.targetDoor = other.targetDoor  
                obj_player2.targetRoom = other.targetRoom  
                with (obj_player)  
                {  
                    image_index = 0  
                    if (state != (186 << 0))  
                        state = (112 << 0)  
                    mach2 = 0  
                }  
                if (instance_exists(obj_player2) && global.coop == 1)  
                {  
                    if (object_index == obj_player2)  
                    {  
                        obj_player1.x = obj_player2.x  
                        obj_player1.y = obj_player2.y  
                    }  
                    if (object_index == obj_player1)  
                    {  
                        obj_player2.x = obj_player1.x  
                        obj_player2.y = obj_player1.y  
                    }  
                }  
                with (obj_player2)  
                {  
                    if instance_exists(obj_coopplayerfollow)  
                        state = (186 << 0)  
                }  
                other.visited = 1  
                if (ds_list_find_index(global.saveroom, other.id) == -1)  
                    ds_list_add(global.saveroom, other.id)  
                with (instance_create(x, y, obj_fadeout))  
                {  
                    offload_arr = door.offload_arr  
                    group_arr = door.group_arr  
                }  
            }  
        }  
    }  
}
~~~