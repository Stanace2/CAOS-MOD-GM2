# PowerUps
## Replacements
### Level placements
#### badland_5a
![[Pasted image 20260714192259.png]]
#### badland_5b
![[Pasted image 20260714192321.png]]
#### badland_mart3
![[Pasted image 20260714192348.png]]

#### space_7
![[Pasted image 20260711102154.png]]
#### space_9
![[Pasted image 20260711102238.png]]
#### space_12
![[Pasted image 20260711102327.png]]
#### sewer_7
![[Pasted image 20260711103049.png]]
#### Industrial_1
![[Pasted image 20260711101549.png]]
#### Industrial_5
![[Pasted image 20260711101744.png]]
### RatPoison
#### obj_baddiespawner | Step

~~~js
// Right at the top
if global.kpowerups  
{  
    if (content == obj_kentukykenny && global.caoschase)  
    {  
        instance_create(x, (y - 25), obj_chaosflamedash)  
        instance_destroy()  
    }  
    // Exception for replacing bombs for pizza time
    if (content == obj_pizzagoblinbomb && global.caoschase && global.panic)  
    {  
        instance_create(x, (y - 25), obj_chaosratkiller)  
        instance_destroy()  
    }  
}
~~~
#### obj_cheeseballspawner | Create
##### obj_swordstone | Create
##### obj_bigcheese | Create
##### obj_weeniemount | Create
##### obj_barrel | Create

~~~js
// At the bottom
if (global.caoschase && global.kpowerups)  
{  
    instance_create(x, y, obj_chaosratkiller)  
    instance_destroy()  
}
~~~
#### obj_boxcrusher | Create

~~~js
// At the bottom
if (global.caoschase && global.kpowerups)  
{  
    instance_create(x, y + 100, obj_chaosratkiller)  
    instance_destroy()  
}
~~~
### FlameDash
#### obj_noisejetpack | Step
==Pizza pepper==
Last case
~~~js
case (146 << 0):  
        if (flamebuffer > 0)  
            flamebuffer--  
        else  
        {  
            flamebuffer = 8  
            repeat (3)  
            {  
                with (instance_create(x, y, obj_firemouthflame))  
                {  
                    hsp *= 1.5  
                    vsp *= 1.5  
                }  
            }  
        }  
        if (cutscenebuffer > 0)  
            cutscenebuffer--  
        else  
        {  
            with (obj_music)  
            {  
                if (music != noone)  
                    fmod_event_instance_set_parameter(music.event, "state", 1, 1)  
            }  
            // H e r e
            if global.caoschase  
            {  
                fmod_event_one_shot("event:/sfx/misc/collectgiantpizza")  
                with (instance_create(x, y, obj_chaosangel))  
                {  
                    type = 2  
                    playerid = other.playerid  
                }  
            }  
            playerid.state = (0 << 0)  
            playerid.landAnim = 0  
            playerid.flash = 1  
            instance_destroy()  
            create_transformation_tip(lang_get_value("jetpack2tip"), "jetpack2")  
        }  
        break
~~~
#### obj_baddiespawner | Step

~~~js
// Right at the top
if global.kpowerups  
{  
	// H e r e
    if (content == obj_kentukykenny && global.caoschase)  
    {  
        instance_create(x, (y - 25), obj_chaosflamedash)  
        instance_destroy()  
    }  
    if (content == obj_pizzagoblinbomb && global.caoschase && global.panic)  
    {  
        instance_create(x, (y - 25), obj_chaosratkiller)  
        instance_destroy()  
    }  
}
~~~
#### obj_ghosthazard | Create

~~~js
// At the bottom
if (global.caoschase && global.kpowerups)  
{  
    instance_create(x, y, obj_chaosflamedash)  
    instance_destroy()  
}
~~~
### InfiJump
#### obj_trash | Create
##### obj_stringycheese | Create

~~~js
// At the bottom
if (global.caoschase && global.kpowerups)  
{  
    instance_create(x, y, obj_chaosinfijump  
    instance_destroy()  
}
~~~
### BlinkSnap
#### obj_rocket | Create

~~~js
// At the bottom
if (global.caoschase && global.kpowerups)  
{  
    instance_create(x, (y - 10), obj_chaosdragonsnap)  
    instance_destroy()  
}
~~~
## Chandeleirs
### obj_chaospw_feedback
This displays the powerup being grabbed, the sprites need to be rescaled, i just was lazy
#### Create

~~~js
depth = -6  
image_speed = 0.35  
image_xscale = 1.5  
image_yscale = 1.5
~~~
#### Step

~~~js
y -= 0.8  
image_alpha -= 0.005  
if (image_alpha <= 0)  
    instance_destroy()
~~~
### obj_chaosratkiller
Big daddy of all powerups
**sprite : spr_chaospowerup**
#### Create

~~~js
image_speed = 0.35  
mask_index = spr_chaospowerup  
depth = 1  
type = 0  
if (ds_list_find_index(global.saveroom, id) != -1)  
    instance_destroy()
~~~
#### Step

~~~js
if (instance_exists(obj_chaosangel) && obj_player.ratpoison)  
    instance_destroy()
~~~
#### Collision | obj_player

~~~js
fmod_event_one_shot("event:/sfx/pep/pray")  
var p = other.id  
with (instance_create((other.x - 540), (camera_get_view_y(view_camera[0]) - 100), obj_chaosangel))  
{  
    playerid = p  
    type = other.type  
    if instance_exists(obj_chaosUI)  
        array_push(obj_chaosUI.angelqueue, id)  
}  
var ad = ""  
if (type > 0)  
    ad = string(type + 1)  
with (instance_create(x, y, obj_chaospw_feedback))  
    sprite_index = asset_get_index(concat("spr_chaospowerup", ad, "_collect"))  
if (ds_list_find_index(global.saveroom, id) == -1)  
{  
    if (!global.panic)  
        ds_list_add(global.saveroom, id)  
    var val = 500  
    global.collect += val  
    global.combotime = 60  
    with (instance_create((x + 16), y, obj_smallnumber))  
        number = string(val)  
    fmod_event_one_shot("event:/sfx/misc/collectgiantpizza")  
    instance_destroy()  
}
~~~
#### RoomStart

~~~js
if (ds_list_find_index(global.saveroom, id) != -1)  
    instance_destroy()  
if (!global.caoschase)  
    instance_destroy()  
if (!global.kpowerups)  
    instance_destroy()
~~~
### obj_chaosflamedash
**Sprite : spr_chaospowerup3**
**Parent : obj_chaosratkiller**
#### Create

~~~js
image_speed = 0.35  
mask_index = spr_chaospowerup  
depth = 1  
type = 2  
if (ds_list_find_index(global.saveroom, id) != -1)  
    instance_destroy()
~~~
#### Step

~~~js
if (instance_exists(obj_chaosangel) && obj_player.flamedash)  
    instance_destroy()
~~~
### obj_chaosinfijump
**Sprite : spr_chaospowerup2**
**Parent : obj_chaosratkiller**
#### Create

~~~js
image_speed = 0.35  
mask_index = spr_chaospowerup  
depth = 1  
type = 1  
if (ds_list_find_index(global.saveroom, id) != -1)  
    instance_destroy()
~~~
#### Step

~~~js
if (instance_exists(obj_chaosangel) && obj_player.infijump)  
    instance_destroy()
~~~
### obj_chaosdragonsnap
**Sprite : spr_chaospowerup4**
**Parent : obj_chaosratkiller**
#### Create

~~~js
image_speed = 0.35  
mask_index = spr_chaospowerup4  
depth = 1  
type = 3  
if (ds_list_find_index(global.saveroom, id) != -1)  
    instance_destroy()
~~~
#### Step

~~~js
if (instance_exists(obj_chaosangel) && obj_player.dragonsnap)  
    instance_destroy()
~~~
## Angels
### obj_chaosangel
#newstates
Little guys that tell you what powerup you have, also assigns tells the player if the powerup should stay at all
**Mask : spr_ratkillsign**
**Persistent**
#### Create

~~~js
state = (0 << 0)  
playerid = -4  
image_speed = 0.35  
depth = -99  
type = 0  
posyoffset = 0  
posxoffset = 0
~~~
#### Destroy
Manages the color shifting for the player, this always has in mind all angels desapearing at once
~~~js
switch type  
{  
    case 0:  
        global.khaosactives[3] = 0  
        obj_player.ratpoison = 0  
        break  
    case 1:  
        global.khaosactives[2] = 0  
        obj_player.infijump = 0  
        break  
    case 2:  
        global.khaosactives[1] = 0  
        obj_player.flamedash = 0  
        break  
    case 3:  
        global.khaosactives[0] = 0  
        obj_player.dragonsnap = 0  
        break  
}  
  
obj_player.kolorindex = -1  
obj_player.kolorhexsat = 0  
global.khaoshex = c_white  
global.khaosr = 1  
global.khaosg = 1  
global.khaosb = 1  
obj_player.currentkolors = []  
obj_player.currentkolorindex = 0  
if instance_exists(obj_chaosUI)  
{  
    for (var i = 0; i < array_length(obj_chaosUI.angelqueue); i++)  
    {  
        if (id == obj_chaosUI.angelqueue[i])  
            array_delete(obj_chaosUI.angelqueue, i, 1)  
    }  
}
~~~
#### BeginStep
Who am i?
Enables the booleans for the managers to work
~~~js
if (sprite_index == -1)  
{  
    switch type  
    {  
        case 0:  
            global.khaosactives[3] = 1  
            sprite_index = spr_ratkillsign  
            obj_player.ratpoison = 1  
            if (instance_number(obj_chaosangel) > 1)  
                obj_player.kolorindex = 3  
            break  
        case 1:  
            create_transformation_tip("[J]")  
            global.khaosactives[2] = 1  
            sprite_index = spr_infijumpsign  
            if instance_exists(obj_chaosUI)  
                obj_chaosUI.barxinfijump = 1  
            obj_player.infijump = 1  
            if (instance_number(obj_chaosangel) > 1)  
                obj_player.kolorindex = 2  
            break  
        case 2:  
            create_transformation_tip("[G]")  
            global.khaosactives[1] = 1  
            sprite_index = spr_flamedashsign  
            obj_player.flamedash = 1  
            with (obj_player)  
            {  
                fmod_event_one_shot_3d("event:/sfx/firemouth/dash", (x + 12 * xscale), y)  
                flamedashkick = 22  
                flamedashbuffer = 30  
                grav = 0  
                image_index = 0  
                sprite_index = spr_dos_flamedash3  
                state = (265 << 0)  
                flash = 1  
            }  
            if (instance_number(obj_chaosangel) > 1)  
                obj_player.kolorindex = 1  
            return;  
        case 3:  
            create_transformation_tip("[S]")  
            global.khaosactives[0] = 1  
            sprite_index = spr_dragonsnapsign  
            obj_player.dragonsnap = 1  
            if (instance_number(obj_chaosangel) > 1)  
                obj_player.kolorindex = 0  
            break  
    }  
  
}
~~~
#### Step
#states
~~~js
var tx = playerid.x + 75 + posxoffset  
var ty = playerid.y - 60 + posyoffset  
var acc = 0.1  
switch state  
{  
    case (0 << 0):  
        x = lerp(x, tx, acc)  
        y = lerp(y, ty, acc)  
        if (x > (tx - 3) && x < (tx + 3) && y > (ty - 3) && y < (ty + 3))  
        {  
            x = tx  
            y = ty  
        }  
        break  
}  
  
if place_meeting(x, y, playerid)  
    image_alpha = Approach(image_alpha, 0.1, 0.1)  
else  
    image_alpha = Approach(image_alpha, 1, 0.01)  
if (playerid.flamedash && global.noisejetpack && sprite_index == spr_flamedashsign)  
    return;  
if (playerid.state == (119 << 0) || playerid.state == (98 << 0) || playerid.state == (90 << 0) || playerid.state == (46 << 0) || playerid.state == (112 << 0) || playerid.state == (292 << 0))  
    instance_destroy()
~~~
#### Draw

~~~js
if (sprite_index != -1)  
    draw_self()
~~~
## Managers
### RatPoison
#### obj_player | EndStep

~~~js
if ratpoison  
{  
    with (collision_rectangle((x - 50), (y - 100), (x + 50), (y + 100), obj_ratblock, 0, 0))  
    {  
        instance_destroy()  
        GamepadSetVibration(0, 0.5, 0.5, 0.8)  
    }  
    with (collision_rectangle((x - 50), (y - 100), (x + 50), (y + 100), obj_badrat, 0, 0))  
    {  
        instance_destroy()  
        GamepadSetVibration(0, 0.5, 0.5, 0.8)  
    }  
}
~~~
### FlameDash
#### Executers
##### scr_doni_flamedash()
This code kicks the flame dash
~~~js
function scr_doni_flamedash()
{  
    if (killbuffer <= 0)  
        flameheat += 75  
    if instance_exists(obj_antigravbubble)  
        instance_destroy(obj_antigravbubble)  
    fmod_event_one_shot_3d("event:/sfx/firemouth/dash", x, y)  
    flamedashkick = 22  
    flamedashbuffer = 10  
    grav = 0  
    image_index = 0  
    sprite_index = spr_dos_flamedash3  
    state = (265 << 0)  
    fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
}
~~~
##### obj_player | EndStep

~~~js
// Flamelock doesnt let you flamedash when stunned
var flamelock = (state != (265 << 0) && state != (146 << 0) && state != (296 << 0) && state != (150 << 0) && state != (9 << 0) && state != (8 << 0) && state != (84 << 0) && state != (107 << 0) && state != (97 << 0) && state != (165 << 0) && state != (108 << 0) && state != (165 << 0) && state != (111 << 0) && state != (101 << 0) && state != (95 << 0) && state != (106 << 0) && state != (147 << 0) && state != (105 << 0))  
if flamedash  
{  
    if (key_slap && flamelock && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
        scr_doni_flamedash()  
    if (flameheat > 0)  
        flameheat--  
    if (flameheat < 0)  
        flameheat = 0  
}
~~~
##### scr_player_handstandjump

~~~js
// Right at the top
if flamedash  
{  
	scr_doni_flamedash()  
	return;  
}
~~~
##### scr_player_punch()

~~~js
// Goes inside the uppercut checker
if (sprite_index == spr_breakdanceuppercut || sprite_index == spr_breakdanceuppercutend)  
{  
	if flamedash  
	{  
		scr_doni_flamedash()  
		return;  
	}
}
~~~
#### Vainilla changes
##### Instakill()
#states
~~~js
// Right on top of the last state change
if (state == (265 << 0) && flamedash)  
	return;
state = (61 << 0)
~~~
#### State override
==This could use a new state for it to work properly==
##### scr_player_antigrav() | "(265 << 0)"

~~~js
// Right at the top
if (flamedash && instance_exists(obj_chaosangel) && (!instance_exists(obj_antigravbubble)))  
{  
	state_chaos_player_flamedash()  
	return;  
}
~~~
##### state_chaos_player_flamedash()
#states
~~~js
function state_chaos_player_flamedash() //gml_Script_state_chaos_player_flamedash  
{  
    if (flameheat > 350)  
    {  
        flameheat = 0  
        var _pindex = (object_index == obj_player1 ? 0 : 1)  
        GamepadSetVibration(_pindex, 1, 1, 0.85)  
        if (state != (9 << 0))  
            notification_push((37 << 0), [room])  
        state = (9 << 0)  
        vsp = -11  
        fireasslock = 0  
        sprite_index = spr_fireass  
        image_index = 0  
        xscale *= -1  
        movespeed = 15  
        fmod_event_one_shot_3d("event:/sfx/pep/burn", x, y)  
        if (!fmod_event_instance_is_playing(global.snd_fireass))  
            fmod_event_instance_play(global.snd_fireass)  
        return;  
    }  
    var cap = 8  
    if (key_shoot2 && dos && flamedashbuffer == 0)  
    {  
        poundbuffer = 15  
        input_buffer_slap = 0  
        if (movespeed >= 12)  
        {  
            repeat (5)  
                instance_create(x, y, obj_firemouthflame)  
        }  
        fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)  
        if global.noisejetpack  
            snapjumps += 1  
        sprite_index = spr_player_snapjumpstart  
        vsp = -12  
        jumpstop = 0  
        movespeed = abs(hsp)  
        state = (306 << 0)  
        image_index = 0  
        flamejumped = 0  
        return;  
    }  
    if (place_meeting(x, (y + 1), obj_ladder) && (!(place_meeting(x, y, obj_ladder))) && (!(place_meeting(x, (y - 1), obj_ladder))))  
        y += 10  
    if (flamedashkick > cap)  
        flamedashkick = Approach(flamedashkick, cap, 0.115)  
    if (flameheat > 0)  
    {  
        flameheat--  
        if (flamedashkick < 21)  
            flameheat--  
        if (flamedashkick < 18)  
            flameheat--  
        if (flamedashkick < 14)  
            flameheat--  
    }  
    if (flamedashbuffer > 0 || key_slap)  
    {  
        move = key_left + key_right  
        if (sprite_index == spr_dos_flamedash3)  
            image_speed = 0.4  
        else  
            image_speed = 0.35  
        scr_doFlamedash(key_up, key_down, (-key_left), key_right)  
        if (move != 0)  
        {  
            xscale = move  
            hsp = movespeed * move  
        }  
        else  
            hsp = Approach(hsp, 0, 0.1)  
        if place_meeting(x, y, obj_baddie)  
        {  
            with (place_meeting(x, y, obj_baddie))  
                instance_destroy()  
        }  
        if (flamedashkick > 18)  
        {  
            with (create_firemouth_afterimage(x, y, sprite_index, (image_index - 1), xscale))  
                playerid = other.id  
        }  
        with (obj_destructibles)  
        {  
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))  
            {  
                instance_destroy()  
                GamepadSetVibration(0, 0.5, 0.5, 0.8)  
            }  
        }  
        with (obj_metalblock)  
        {  
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))  
            {  
                instance_destroy()  
                GamepadSetVibration(0, 0.5, 0.5, 0.8)  
            }  
        }  
        with (obj_ghostblock)  
        {  
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))  
            {  
                instance_destroy()  
                GamepadSetVibration(0, 0.5, 0.5, 0.8)  
            }  
        }  
        with (obj_tntblock)  
        {  
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))  
            {  
                instance_destroy()  
                GamepadSetVibration(0, 0.5, 0.5, 0.8)  
            }  
        }  
        with (obj_ghostwall)  
        {  
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))  
            {  
                var t = other.id  
                fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
                notification_push((2 << 0), [room, id, object_index])  
                global.combotime = 60  
                instance_create(x, y, obj_bangeffect)  
                instance_create(x, y, obj_genericpoofeffect)  
                with (instance_create(x, y, obj_sausageman_dead))  
                {  
                    image_xscale = (-t.xscale)  
                    sprite_index = spr_cheesegratter  
                    hsp = t.xscale * 10  
                }  
                instance_destroy()  
                GamepadSetVibration(0, 0.5, 0.5, 0.8)  
            }  
        }  
        var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)  
        var xfactor = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)  
        if (place_meeting((x + xscale), y, obj_solid) && grounded && (gap == -4 || xfactor != -4))  
        {  
            state = (5 << 0)  
            sprite_index = spr_machroll  
            return;  
        }  
    }  
    else  
    {  
        if (movespeed < 11)  
            movespeed = 11  
        if (key_down && grounded)  
        {  
            state = (5 << 0)  
            sprite_index = spr_machroll  
            return;  
        }  
        image_speed = 0.8  
        sprite_index = spr_player_rolljump  
        state = (121 << 0)  
        return;  
    }  
    if (flamedashbuffer > 0)  
        flamedashbuffer--  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_dos_flamedash3)  
        sprite_index = spr_dos_flamecharge  
}  
~~~

This goes inside the same script
~~~js
function scr_doFlamedash(argument0, argument1, argument2, argument3)
{  
    var _speed = flamedashkick  
    var press = argument0 + argument1 + argument2 + argument3  
    if (hsp != 0)  
        vsp = 0  
    if (press > 0)  
    {  
        if (argument0 && (!argument1) && (!(place_meeting(x, (y - 1), obj_solid))))  
            vsp = (-_speed)  
        else if (argument1 && (!argument0) && (!(place_meeting(x, (y + 1), obj_solid))))  
            vsp = _speed  
        if (argument2 || argument3)  
            movespeed = _speed  
    }  
    else  
    {  
        vsp = Approach(vsp, 0, 1)  
        movespeed = Approach(movespeed, 0, 1)  
    }  
}
~~~
[^1]: argument0 : *up* | num 0-1
[^2]: argument1 : *down* | num 0-1
[^3]: argument2 : *left* | num 0-1
[^4]: argument3 : *right* | num 0-1
### InfiJump
#### obj_player | EndStep

~~~js
// Executer
if infijump  
{  
	// In very specific cases you cant infijump
    var infiblock = (state != (150 << 0) && state != (265 << 0) && state != (146 << 0) && state != (146 << 0) && state != (93 << 0))  
    if (infiblock && visible)  
    {  
        if (key_jump && state != (306 << 0))  
        {  
            fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)  
            input_buffer_jump = 0  
            snapjumps += 1  
            if (snapjumps > 1 || movespeed >= 12)  
            {  
                instance_create(x, y, obj_noiseeffect)  
                repeat (5)  
                    instance_create(x, y, obj_firemouthflame)  
            }  
            else  
                instance_create(x, (y + 30), obj_bumpeffect)  
            if (movespeed >= 9 && movespeed <= 20)  
                movespeed += 4  
            sprite_index = spr_player_snaphighjump  
            image_index = 0  
            vsp = -22  
            jumpstop = 0  
            state = (306 << 0)  
            return;  
        }  
    }  
}
~~~
#### scr_doniSnapjump()
This is an exception for Donisha, other characters should use different states or overstates
~~~js
mask_index = spr_player_mask  
var init = ((sprite_index == spr_player_snapjumpstart || sprite_index == spr_player_snaphighjump) && image_index < 2)  
if (key_down && (!init))  
	vsp = Approach(vsp, 15, 0.5)  
if infijump  
{  
	if (vsp > -3)  
	{  
		if key_jump2  
			vsp = Approach(vsp, 4, 1)  
		else  
			vsp += 0.5  
		if key_jump  
		{  
			snapjumps += 1  
			fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)  
			fmod_event_one_shot_3d("event:/sfx/misc/mushroombounce", x, y)  
			instance_create(x, (y + 30), obj_bumpeffect)  
			sprite_index = spr_player_snaphighjump  
			image_index = 0  
			vsp = -22  
		}  
	}  
}
~~~
### BlinkSnap
#### Executers

~~~js
if dragonsnap  
{  
	// Executer
    var _dsc = collision_line(x, (y + 1), x, (y + 10), obj_solid, 0, 1)  
    if (dragonbuffer == 0 && flamelock && key_shoot2 && point_in_camera(x, y, view_camera[0]) && visible && (!instance_exists(obj_dragonsnap_effect)) && _dsc == -4)  
    {  
        dragonbuffer = 20  
        var ass1 = x - camera_get_view_x(view_camera[0])  
        var ass2 = y - camera_get_view_y(view_camera[0])  
        with (instance_create(x, y, obj_dragoncursor))  
            targetplayer = other.id  
        with (instance_create(x, y, obj_dragonsnap_effect))  
            player = [ass1, ass2, other.xscale]  
    }  
    // Count down, hurry your ass
    if (dragonbuffer > 0)  
        dragonbuffer--  
    // An additional checker for the asteroids
    if (dragonsnap && (sprite_index == spr_dos_dragonsnap || abs(other.hsp) > 16))  
    {  
        with (obj_asteroid)  
        {  
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - 1), y, other) || place_meeting((x + 1), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))  
            {  
                instance_destroy()  
                GamepadSetVibration(0, 0.5, 0.5, 0.8)  
            }  
        }  
    }  
}
~~~
#### Vainilla changes
##### obj_asteroid | Collision | obj_player
~~~js
// Checks for the player to break under dragonsnap
if (other.dragonsnap && (other.sprite_index == spr_dos_dragonsnap || abs(other.hsp) > 15))  
    instance_destroy()
~~~
#### Objects
##### obj_dragoncursor
This is the guy behind the scenes
**sprite : spr_player_mask**
**mask : spr_player_mask**
###### Create

~~~js
angle = 0  
radius = 400  
coll = 0  
goodtogo = 0  
savepos = [x, y]  
targetplayer = -4  
targetx = 0  
targety = 0  
hsp = 0  
vsp = 0  
vsp_carry = 0  
hsp_carry = 0  
platformid = -4  
grav = 0  
limit = 0
~~~
###### Step

~~~js
// Gathers info so the effect can read it
var tx = targetplayer.x  
var ty = targetplayer.y + 25  
var _y = y + 25  
var dis = abs(point_distance(x, _y, tx, ty))  
limit = dis >= 400  
var _solid = collision_line(tx, ty, x, _y, obj_solid, 0, 1)  
var _slope = collision_line(tx, ty, x, _y, obj_slope, 1, 1)  
coll = (_solid != -4 || _slope != -4 || place_meeting(x, y, obj_solid) || limit)  
scr_collide()  
goodtogo = ((!(place_meeting(x, y, obj_solid))) && (!(place_meeting(x, y, obj_solid))))  
if ((!limit) && (!coll) && goodtogo)  
    savepos = [x, y]
~~~
###### OutsideView 0

~~~js
coll = 1
~~~
##### obj_dragonsnap_effect
Im not explaning this magnifisent act thoroughly
Scripts:
- [[scr_dragonsnap_destructibles]]
###### Create

~~~js
if obj_chaoschaser.berserk  
    zawarudo = 1  
else  
    zawarudo = 0  
player = []  
buffer = 28  
imageindex = 0  
imagedindex = 0  
scr_init_input()  
scr_layout_init()  
cursorr = 200  
cursora = 0  
cursoras = 0.05  
sprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), 0, 0, 0, 0)  
instance_list = ds_list_create()  
sound_list = ds_list_create()  
scr_pause_deactivate_objects(0)  
instance_deactivate_object(obj_pause)  
instance_activate_object(obj_player)  
instance_activate_object(obj_solid)  
instance_activate_object(obj_slope)  
instance_activate_object(obj_platform)  
instance_activate_object(obj_dragoncursor)  
instance_activate_object(obj_screensizer)  
instance_activate_object(obj_chaosangel)  
instance_deactivate_object(obj_destructibles)  
instance_deactivate_object(obj_metalblock)  
instance_deactivate_object(obj_asteroid)  
with (obj_chaosangel)  
{  
    if (sprite_index == spr_ratkillsign)  
        instance_deactivate_object(obj_ratblock)  
}  
if zawarudo  
{  
    instance_activate_object(obj_chaoschaser)  
    instance_activate_object(obj_chaosUI)  
}
~~~
###### Destroy

~~~js
instance_destroy(obj_dragoncursor)
~~~
###### Step
#states 
~~~js
// Manages the cursor and has the main logic
imageindex += 0.35  
if (imagedindex < 5)  
    imagedindex += 0.35  
buffer--  
scr_menu_getinput()  
with (obj_player)  
{  
    state = (8 << 0)  
    vsp = 0  
    hsp = 0  
    movespeed = 0  
}  
if (key_back || key_jump || obj_dragoncursor.coll || buffer <= 0)  
{  
    scr_pause_activate_objects(0)  
    instance_activate_object(obj_pause)  
    fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
    fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
    with (obj_dragoncursor)  
    {  
        if (coll || limit)  
        {  
            x = savepos[0]  
            y = savepos[1]  
        }  
    }  
    with (instance_create(x, y, obj_dragonsnap_afterimage))  
    {  
        oldx = obj_player1.x  
        oldy = obj_player1.y + 25  
        finalx = obj_dragoncursor.x  
        finaly = obj_dragoncursor.y + 25  
        ajax = [oldx, oldy]  
    }  
    with (obj_camera)  
    {  
        followspeed = 30  
        followtarget = 587  
        state = (299 << 0)  
    }  
    with (obj_player1)  
    {  
        visible = 1  
        poundbuffer = 15  
        input_buffer_slap = 0  
        repeat (5)  
            instance_create(x, y, obj_firemouthflame)  
        fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)  
        xscale = sign(obj_dragoncursor.x - other.player[0])  
        if (xscale == 0)  
            xscale = 1  
        snapjumps = 4  
        sprite_index = spr_dos_dragonsnap  
        var ceiling = 0  
        with (obj_dragoncursor)  
        {  
            if place_meeting(x, (y - 1), obj_solid)  
                ceiling = 1  
        }  
        if (other.key_up && (!ceiling))  
            vsp = -18  
        movespeed = 18  
        jumpstop = 0  
        state = (306 << 0)  
        image_index = 0  
        x = obj_dragoncursor.x  
        y = obj_dragoncursor.y  
        clean_dragonexit()  
    }  
    instance_destroy()  
    return;  
}  
var pivotx = camera_get_view_x(view_camera[0]) + player[0] / obj_screensizer.actual_width * camera_get_view_width(view_camera[0])  
var pivoty = camera_get_view_y(view_camera[0]) + player[1] / obj_screensizer.actual_height * camera_get_view_height(view_camera[0])  
with (obj_dragoncursor)  
{  
    var l = (-other.key_left)  
    var r = other.key_right  
    var u = other.key_up  
    var d = other.key_down  
    if (!limit)  
    {  
        if l  
            hsp = -30  
        if r  
            hsp = 30  
        if u  
            vsp = -30  
        if d  
            vsp = 30  
    }  
    if ((l + r) == 0)  
        hsp = Approach(hsp, 0, 0.5)  
    if ((u + d) == 0)  
        vsp = Approach(vsp, 0, 0.5)  
}
~~~
###### DrawGUI

~~~js
// Draws all the time stop effect
var cursorx = obj_dragoncursor.x - camera_get_view_x(view_camera[0])  
var cursory = obj_dragoncursor.y - camera_get_view_y(view_camera[0])  
draw_sprite_ext(sprite, 0, 0, 0, 1, 1, 0, make_color_rgb(63, 0, 181), 1)  
draw_sprite(spr_dragonsnap_ring, 0, player[0], (player[1] + 25))  
for (var i = 0; i < (array_length(todisplay) - 1); i++)  
    draw_sprite_ext(todisplay[i][0], todisplay[i][1], todisplay[i][3], todisplay[i][4], todisplay[i][2], 1, 0, c_aqua, 0.9)  
draw_sprite_line(4824, imageindex, player[0], (player[1] + 25), cursorx, (cursory + 25))  
draw_sprite(spr_dragon_mask, imageindex, cursorx, cursory)  
shader_set(global.Pal_Shader)  
pal_swap_set(spr_blankpalette, 1, 0)  
var _or = sign(cursorx - player[0])  
if (_or == 0)  
    _or = 1  
draw_sprite_ext(spr_dos_dragonsnap_prep, imagedindex, player[0], player[1], _or, 1, 0, c_white, 1)  
pattern_reset()  
reset_shader_fix()  
if zawarudo  
    draw_sprite_ext(obj_chaoschaser.sprite_index, obj_chaoschaser.image_index, (obj_chaoschaser.x - camera_get_view_x(view_camera[0])), (obj_chaoschaser.y - camera_get_view_y(view_camera[0])), obj_chaoschaser.image_xscale, obj_chaoschaser.image_yscale, 0, c_white, obj_chaoschaser.image_alpha)
~~~
###### CleanUp

~~~js
ds_list_destroy(instance_list)  
ds_list_destroy(sound_list)  
sprite_delete(sprite)
~~~

##### obj_dragonsnap_afterimage
After image, grabbing points and destroying shit
###### Create

~~~js
oldx = 0  
oldy = 0  
finalx = 0  
finaly = 0  
murder = -4  
victims = [obj_baddie, obj_destructibles, obj_metalblock, obj_asteroid, obj_ratblock]  
collect = [obj_collect, obj_bigcollect, obj_giantcollect]  
pizzakin = obj_pizzaboxunopen  
depth = -999  
done = 0  
ajax = [0, 0]  
path = []  
kick = 0  
sprite_index = spr_player_taunt  
image_alpha = 1
~~~
###### BeginStep
Should add the powerups exceptions as well
~~~js
// Kill and collect
for (var i = 0; i < array_length(victims); i++)  
{  
    var offset = -25  
    for (var j = 1; j <= 3; j++)  
    {  
        murder = collision_line(oldx, (oldy + offset), finalx, (finaly + offset), victims[i], 0, 1)  
        if (murder != noone)  
            instance_destroy(murder)  
        offset += 25  
    }  
}  
for (i = 0; i < array_length(collect); i++)  
{  
    offset = -25  
    for (j = 1; j <= 5; j++)  
    {  
        murder = collision_line(oldx, (oldy + offset), finalx, (finaly + offset), collect[i], 0, 1)  
        if (murder != noone)  
        {  
            with (obj_player)  
            {  
                with (other.murder)  
                    event_perform(ev_collision, obj_player)  
            }  
        }  
        offset += 10  
    }  
}  
offset = -25  
for (j = 1; j <= 10; j++)  
{  
    murder = collision_line(oldx, (oldy + offset), finalx, (finaly + offset), pizzakin, 0, 1)  
    if (murder != noone)  
    {  
        with (obj_player)  
            other.murder.force = 1  
    }  
    offset += 10  
}
~~~
###### Step

~~~js
ajax[0] = abs(Approach(ajax[0], finalx, 60))  
ajax[1] = abs(Approach(ajax[1], finaly, 60))  
// This path filler should be reworked
if (ajax[0] != finalx || ajax[1] != finaly)  
    array_push(path, [ajax[0], ajax[1], random_range(0, (image_number - 1))])  
image_alpha -= 0.035  
if (image_alpha <= 0)  
    instance_destroy()
~~~
###### Draw

~~~js
for (var i = 0; i < array_length(path); i++)  
{  
    shader_set(shd_color_afterimage)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), 0.9607843137254902)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), 0.12941176470588237)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), 1)  
    draw_sprite_ext(sprite_index, path[i][2], path[i][0], path[i][1], 1, 1, 0, c_white, image_alpha)  
    shader_reset()  
}
~~~
# Helpers
## obj_chaos_golfhelper
#newstates
Sexy lady with the ball
**sprite : spr_caos_golf_helper_wait**
**mask : spr_player_mask**
Created in:
- obj_pizzaball | Create
~~~js
// Right at the end of the method
// Last check prevents from not making possible to gather points in the second secrect of golf
if (global.caoschase && global.kpowerups && room != minigolf_secret1)  
{  
    with (instance_create(x, y, obj_chaos_golfhelper))  
        golfhit = other.golfhit  
    force = 1  
    instance_destroy()  
}
~~~
### Create

~~~js
image_speed = 0.35  
depth = -7  
turbo = 0  
angle = 0  
state = (0 << 0)  
golfhit = [4, 6, 8] // Necessary i guess 
vsp = 0  
hsp = 0  
grounded = 0  
grav = 1.5  
platformid = -4  
hsp_carry = 0  
vsp_carry = 0
~~~
### Step

~~~js
if (room == timesuproom)  
    instance_destroy()  
distance = distance_to_point(obj_player1.x, obj_player1.y)  
if (!instance_exists(obj_ballgoal))  
    return;  
goaldistance = distance_to_point(obj_ballgoal.x, obj_ballgoal.y)  
switch state  
{  
    case (0 << 0):  
        if (x != obj_player1.x)  
            image_xscale = sign(x - obj_player1.x)  
        if (distance < 100)  
        {  
            state = (1 << 0)  
            fmod_event_one_shot("event:/sfx/misc/collectpizza")  
        }  
        break  
    case (1 << 0):  
        image_xscale = 1  
        sprite_index = spr_caos_golf_helper_idle  
        dir = point_direction(x, y, obj_player1.x, obj_player1.y)  
        x = lerp(x, (obj_player1.x - 100 * obj_player1.xscale), 0.15)  
        y = lerp(y, (obj_player1.y - 100), 0.15)  
        if (goaldistance < 250)  
        {  
            sprite_index = spr_caos_golf_helper_jump  
            turbo = abs(obj_player1.hsp)  
            vsp = -8  
            state = (2 << 0)  
        }  
        break  
    case (2 << 0):  
        if (x != obj_ballgoal.x)  
            image_xscale = (-(sign(x - obj_ballgoal.x)))  
        x = Approach(x, obj_ballgoal.x, 15)  
        y = Approach(y, obj_ballgoal.y, 8)  
        break  
    case (3 << 0):  
        if (vsp < 20)  
            vsp += grav  
        x += hsp  
        y += floor(vsp)  
        angle += 1  
        break  
}
~~~
### EndStep

~~~js
if ((!instance_exists(obj_pizzaballblock)) && state != (3 << 0))  
    instance_destroy()
~~~
### Collision | obj_ballgoal

~~~js
if (state == (2 << 0))  
{  
    state = (3 << 0)  
    vsp = random_range(-10, -18)  
    hsp = random_range(-10, 18)  
    grav = 0.4  
    sprite_index = spr_caos_golf_helper_dunk  
    instance_destroy(obj_pizzaballblock)  
    instance_create(x, y, obj_slapstar)  
    instance_create(x, y, obj_slapstar)  
    instance_create(x, y, obj_slapstar)  
    instance_create(x, y, obj_baddiegibs)  
    instance_create(x, y, obj_baddiegibs)  
    instance_create(x, y, obj_baddiegibs)  
    fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
    var gh = golfhit  
    with (instance_create(0, 0, obj_pizzaball_rank))  
    {  
        fmod_event_instance_play(global.snd_golfjingle)  
        var s = 0  
        if (global.golfhit <= gh[0] || (!obj_player1.ispeppino))  
        {  
            s = 3  
            collect = 400  
            sprite_index = spr_pizzaball_rank1  
        }  
        else if (global.golfhit <= gh[1])  
        {  
            s = 2  
            collect = 250  
            sprite_index = spr_pizzaball_rank2  
        }  
        else if (global.golfhit <= gh[2])  
        {  
            s = 1  
            collect = 100  
            sprite_index = spr_pizzaball_rank3  
        }  
        else  
        {  
            collect = 0  
            sprite_index = spr_pizzaball_rank4  
        }  
        fmod_event_instance_set_parameter(global.snd_golfjingle, "state", s, 1)  
        collectminus = round(collect / 10)  
        notification_push((18 << 0), [sprite_index])  
    }  
    global.golfhit = 0  
}
~~~
### OutsideView 0

~~~js
if (state == (3 << 0))  
    instance_destroy()
~~~
### Draw
For later
~~~js
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, c_white, image_alpha)
~~~

## obj_chaos_bell
Relax dude, ill put up some coco melon
**sprite : spr_kbell_idle**
### Level placements
#### ruin_12
![[Pasted image 20260715165224.png]]
#### badland_8
![[Pasted image 20260714192541.png]]
#### graveyard_6
![[Pasted image 20260714192645.png]]
#### space_11b
![[Pasted image 20260714193338.png]]
#### industrial_3
![[Pasted image 20260714193950.png]]
#### chateau_6
![[Pasted image 20260714193523.png]]
### Create

~~~js
if ((!global.kbells) || (!global.caoschase))  
    instance_destroy()  
ring = 0  
shoot = 0  
ri = 0  
outlinekolor = 0  
ck = obj_player.chaoskolors[1]  
kickcolor = 0  
image_xscale = 1.1  
image_yscale = 1.1  
sprite_index = spr_kbell_idle  
image_speed = 0.35  
depth = 10
~~~
### Step
#newstates 
#states
~~~js
kickcolor++  
if (kickcolor >= 3)  
{  
    kickcolor = 0  
    outlinekolor++  
    if (outlinekolor > 3)  
        outlinekolor = 0  
}  
if ring  
{  
    if (sprite_index == spr_kbell_ring && floor(image_index) == (image_number - 1))  
        image_alpha -= 0.01  
    y -= 0.2  
    if (sprite_index == spr_kbell_ring && floor(image_index) == (image_number - 1))  
        image_index = image_number - 1  
    if (distance_to_point(obj_chaoschaser.x, obj_chaoschaser.y) <= ri)  
        obj_chaoschaser.high = 200  
    if (distance_to_point(obj_chaoschaser.x, obj_chaoschaser.y) <= ri && obj_chaoschaser.state != (8 << 0))  
    {  
        with (obj_chaoschaser)  
        {  
            if (state == (6 << 0))  
            {  
	            // Should use chaosvomit here
                with (targetplayer)  
                {  
	                
                    if (state == (8 << 0))  
                    {  
                        state = (108 << 0)  
                        vsp = 10  
                        sprite_index = spr_rockethitwall  
                        visible = 1  
                    }  
                }  
            }  
            hitlag = 40  
            hitLagX = x  
            hitLagY = y  
            image_index = 0  
            sprite_index = spr_caos_high1  
            state = (8 << 0)  
            berserk = 0  
        }  
    }  
}  
if (ring && (!shoot))  
{  
    shoot = 1  
    fmod_event_one_shot_3d("event:/sfx/misc/bellcollectbig", x, y)  
    image_index = 0  
    sprite_index = spr_kbell_ring  
}  
if (image_alpha < 0.01)  
    instance_destroy()
~~~
### Collision | obj_player

~~~js
ring = 1
~~~
### Draw

~~~js
if ring  
{  
    ri = Approach(ri, 300, 10)  
    draw_set_circle_precision(64)  
    draw_set_alpha(0.5 * image_alpha)  
    draw_circle_colour(x, y, ri, c_aqua, c_aqua, 0)  
}  
else  
{  
    shader_set(shd_color_afterimage)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), ck[outlinekolor][0])  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), ck[outlinekolor][1])  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), ck[outlinekolor][2])  
    draw_sprite_ext(sprite_index, image_index, x, y, (image_xscale * 1.25), (image_yscale * 1.25), 0, c_white, image_alpha)  
    shader_reset()  
}  
draw_self()  
draw_set_alpha(1)
~~~
# Level geometry
## obj_chaosbarrier
Caos brought the baby oil
**sprite : spr_chaospillarhug**
**parent : obj_solid**
Managed by:
- [[obj_hungrypillar]] Create - Destroy - RoomStart methods affected
### Create

~~~js
image_speed = 0.35  
depth = 2  
if (global.ktoppingoal == 0 || global.panic || (!global.ktoppins))  
    instance_destroy()
~~~
### Step

~~~js
if (!instance_exists(obj_chaoschaser))  
    return;  
if (obj_chaoschaser.toppins == global.ktoppingoal && (!global.panic))  
{  
    with (instance_create(x, y, obj_hungrypillar))  
        image_xscale = other.image_xscale  
    instance_destroy()  
}
~~~
### Roomstart

~~~js
if global.panic  
    instance_destroy()
~~~
