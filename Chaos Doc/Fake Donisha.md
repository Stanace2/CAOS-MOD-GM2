# obj_fakedonisha
#states 
#newstates
==This girl is not finished, but the bare bones structure is in here
State logic and enemy behaviour are not implemented==
She's almost ready to chase you down and grab your ass
**Sprite : spr_fd_idle**
**Persistent**
**Mask : spr_player_mask**
Scripts:
- [[scr_fakedos_stalker()]]
- [[scr_fakedos_chase()]]
## Create

~~~js
hsp = 0  
vsp = 1  
nodestate = (0 << 0)  
grav = 0.5  
grounded = 0  
movespeed = 0  
state = (0 << 0)  
substate = (0 << 0)  
savedsubstate = (0 << 0)  
savedstate = (0 << 0)  
image_speed = 0.35  
depth = -1  
visible = 0  
appeartimer = 200  
start_x = 0  
start_y = 0  
platformid = -4  
hsp_carry = 0  
vsp_carry = 0  
nodes = []  
LAG_STEPS = 35  
touched = 0  
targetRoom = room  
targetDoor = obj_player1.targetDoor  
targetplayer = instance_nearest(x, y, obj_player)  
steppy = 0  
startbuffer = 100  
lock = 0  
philly = [x, y, image_xscale, 0, 0, 0, (0 << 0)]  
iseeyou = 0  
sightbuffer = 50  
kickopt = 100  
goingfast = 0  
nodekick = 0  
with (instance_create(x, y, obj_chaostracker))  
{  
    depth = -999  
    objectID = other.id  
    sprite_index = spr_icon_horsey  
    image_speed = 0.35  
}
~~~
## BeginStep
Player data gathering and some behaviour logic
~~~js
targetplayer = instance_nearest(x, y, obj_player)  
chasedistance = distance_to_point(targetplayer.x, targetplayer.y)  
var _solid = collision_line(x, y, targetplayer.x, targetplayer.y, obj_solid, 0, 1)  
var _slope = collision_line(x, y, targetplayer.x, targetplayer.y, obj_slope, 1, 1)  
var _platform = collision_line(x, y, targetplayer.x, targetplayer.y, obj_platform, 0, 1)  
var _pthrouh = 1  
if (_platform != noone)  
{  
    if (sign(_platform.y - y) == 1)  
        _pthrouh = 0  
}  
iseeyou = (_solid == -4 && _slope == -4 && _pthrouh)  
if (startbuffer < 1 && (!visible))  
    visible = 1  
if iseeyou  
    sightbuffer--  
else  
    sightbuffer = 65  
if (sightbuffer < 0)  
    sightbuffer = 0  
if (chasedistance > 500)  
{  
    if (abs(targetplayer.hsp) < 13 && abs(targetplayer.vsp) < 16 && movespeed < 14)  
        goingfast = 0  
    else  
        goingfast = 1  
}  
else  
    goingfast = 0
~~~
## Step
Main state machine and brain of FakeDonisha
~~~js
if (!touched)  
{  
	// Read player movement
    if goingfast  
        nodekick++  
    else  
        nodekick = 0  
    if (nodekick == 6)  
        nodekick = 0  
    else  
    {  
        var xx = targetplayer.x  
        var yy = targetplayer.y  
        var ixs = targetplayer.xscale  
        var v = targetplayer.vsp  
        var h = targetplayer.hsp  
        var rs = targetplayer.state  
        if (!((targetplayer.xprevious == targetplayer.x && targetplayer.yprevious == targetplayer.y)))  
            array_push(nodes, [xx, yy, ixs, v, h, 0, rs])  
    }  
    // Taunt detector
    if (targetplayer.state == (84 << 0) && point_in_camera(x, y, view_camera[0]) && state != (2 << 0))  
    {  
        savedsubtate = substate  
        savedstate = state  
        state = (2 << 0)  
    }  
    // This should be moved to be inside the substates
    image_speed = 0.35  
    // State machine
    switch state  
    {  
        case (0 << 0):  
	        // Mimic movement while not in sight
            scr_fakedos_stalker()  
            break  
        case (1 << 0):  
		    // Manual chase, turns into an "enemy"
            scr_fakedos_chase()  
            break  
        case (2 << 0):  
	        // Taunt
            if (sprite_index != spr_fd_taunt)  
            {  
                if (savedstate == (0 << 0))  
                {  
                    if (array_length(nodes) > 0)  
                    {  
                        philly = nodes[0]  
                        array_delete(nodes, 0, 1)  
                        x = philly[0]  
                        y = philly[1]  
                        image_xscale = philly[2]  
                        vsp = philly[3]  
                        hsp = philly[4]  
                        nodestate = philly[6]  
                    }  
                }  
                fmod_event_one_shot_3d("event:/sfx/fakepep/taunt", x, y)  
                sprite_index = spr_fd_taunt  
                if (targetplayer.image_index > 28)  
                    image_index = irandom(sprite_get_number(sprite_index) - 1)  
                else  
                    image_index = targetplayer.image_index  
                tauntID = instance_create(x, (y - 50), obj_baddietaunteffect)  
            }  
            if (sprite_index == spr_fd_taunt && targetplayer.state != (84 << 0))  
            {  
                instance_destroy(tauntID)  
                state = savedstate  
                substate = savedsubstate  
            }  
            break  
    }  
  
    if (startbuffer > 0)  
        startbuffer--  
}
~~~
## EndStep
We don't talk about bruno
~~~js
// This puppy optimizes the follow path of fake Donisha
// Thats all youre gonna get
if (kickopt < 1)  
{  
    if (!goingfast)  
        kickopt = 100  
    else  
        kickopt = 50  
    var optphilly = -4  
    var relphilly = -4  
    if (array_length(nodes) > 0)  
    {  
        for (var i = 0; i < (array_length(nodes) - 2); i++)  
        {  
            if (nodes[i][5] == 1)  
            {  
	            //UTMT DOESNT FUCKING LET YOU USE CONTINUE, works DONT FIX IT
            }  
            else  
            {  
                var npd = abs(point_distance(nodes[i][0], nodes[i][1], nodes[(i + 1)][0], nodes[(i + 1)][1]))  
                for (var j = i + 1; j < (array_length(nodes) - 2); j++)  
                {  
                    var opt = abs(point_distance(nodes[i][0], nodes[i][1], nodes[j][0], nodes[j][1]))  
                    if (opt < npd)  
                    {  
                        relphilly = i + 1  
                        optphilly = j  
                    }  
                }  
                nodes[i][5] = 1  
                if (optphilly != -4)  
                    i = array_length(nodes) - 2  
            }  
        }  
        if (optphilly != -4)  
        {  
            for (var z = relphilly; z < (optphilly + 1); z++)  
                array_delete(nodes, relphilly, 1)  
        }  
    }  
}  
if (kickopt > 0)  
    kickopt--
~~~
## Collision | obj_player
Unused, but it can give you an idea on how it'll work
~~~js
var dud = 1  
if dud  
    return;  
if (state != (119 << 0) && state != (98 << 0) && state != (90 << 0) && state != (46 << 0) && state != (112 << 0) && state != (292 << 0) && startbuffer < 1)  
    scr_hurtplayer(other)
~~~
## RoomStart
Reset fakeDos
~~~js
nodes = []  
if (!goingfast)  
    startbuffer = 100  
else  
    startbuffer = 50  
if instance_exists(obj_player1)  
{  
    x = obj_player1.x  
    y = obj_player1.y  
}  
if (room == rank_room)  
    instance_destroy()  
with (instance_create(x, y, obj_chaostracker))  
{  
    depth = -999  
    objectID = other.id  
    sprite_index = spr_icon_horsey  
    image_speed = 0.35  
}
~~~
## RoomEnd
Just making sure
~~~js
nodes = []
~~~
## Draw
Draws some debug stuff, it'll be long until i remove them
~~~js
shader_set(global.Pal_Shader)  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_blankpalette, 1, 0)  
draw_self()  
pattern_reset()  
shader_reset()  
if (array_length(nodes) > 0)  
{  
    for (var i = 0; i < (array_length(nodes) - 1); i++)  
    {  
        if (array_length(nodes[i]) > 0)  
        {  
            if (nodes[i][5] == 1)  
                draw_set_colour(c_aqua)  
            else  
                draw_set_colour(c_red)  
            draw_circle(nodes[i][0], nodes[i][1], 3, 0)  
        }  
    }  
}  
if iseeyou  
    draw_set_colour(c_lime)  
else  
    draw_set_colour(c_red)  
draw_line(x, y, targetplayer.x, targetplayer.y)
~~~