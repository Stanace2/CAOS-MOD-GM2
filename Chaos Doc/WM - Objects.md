Objects create and handled by the WM duo moveset
- ==Most of these objects need a new state enum==
# obj_mango_ghost
#newstates
Ghost bear to haunt wetham after he falls into a pit or is eaten by caos
**sprite : spr_mangoghost**
**mask : spr_player_mask**
## Create

~~~js
alarm[0] = 1  
alarm[1] = 40  
depth = -11  
image_alpha = 0  
target_alpha = 0.6  
state = (0 << 0)  
image_speed = 0.35  
hide = 1  
vsp = 0  
hsp = 0  
grounded = 0  
grav = 0  
platformid = -4  
hsp_carry = 0  
vsp_carry = 0
~~~
## Alarms
### 0

~~~js
alarm[0] = 2  
if (image_alpha >= target_alpha)  
    create_blur_afterimage(x, y, sprite_index, (image_index - 1), image_xscale)
~~~
### 1

~~~js
hide = 0
~~~
## Step
#states
~~~js
if (room == timesuproom)  
    instance_destroy()  
switch state  
{  
	// Idle hovering
    case (0 << 0):  
        sprite_index = spr_mangoghost  
        var dir = point_direction(x, y, obj_player1.x, obj_player1.y)  
        x = lerp(x, (obj_player1.x - 100 * obj_player1.xscale), 0.15)  
        y = lerp(y, (obj_player1.y - 100), 0.15)  
        if (x != obj_player1.x)  
            image_xscale = (-(sign(x - obj_player1.x)))  
        break  
    // kicked downwards
    case (1 << 0):  
        image_alpha = target_alpha  
        sprite_index = spr_mangoghost_projectile  
        instance_destroy(instance_place(x, (y + 16), obj_destructibles))  
        instance_destroy(instance_place(x, (y + vsp), obj_destructibles))  
        instance_destroy(instance_place(x, (y + 16), obj_metalblock))  
        instance_destroy(instance_place(x, (y + vsp), obj_metalblock))  
        vsp += 3  
        if (grounded && (!(place_meeting(x, (y + 1), obj_destructibles))) && (!(place_meeting(x, (y + 1), obj_metalblock))))  
        {  
            create_particle(x, y, (9 << 0))  
            image_alpha = 0  
            state = (0 << 0)  
            hide = 1  
            alarm[1] = 100  
        }  
        scr_collide()  
        break  
    // Baloon
    case (2 << 0):  
        image_alpha = target_alpha  
        x = obj_player1.x  
        y = obj_player1.y  
        break  
    // Diving
    case (3 << 0):  
        image_alpha = target_alpha  
        sprite_index = spr_mangoghost_projectile  
        x = obj_player1.x  
        y = obj_player1.y + 25  
        instance_destroy(instance_place(x, (y + 16), obj_destructibles))  
        instance_destroy(instance_place(x, (y + vsp), obj_destructibles))  
        instance_destroy(instance_place(x, (y + 16), obj_metalblock))  
        instance_destroy(instance_place(x, (y + vsp), obj_metalblock))  
        break  
}  
  
if (obj_player1.state == (197 << 0))  
    state = (3 << 0)  
if (obj_player1.grounded && state == (3 << 0))  
    state = (0 << 0)  
if (!hide)  
{  
    if (image_alpha < target_alpha)  
        image_alpha = Approach(image_alpha, target_alpha, 0.025)  
}
~~~
## Draw

~~~js
shader_set(global.Pal_Shader)  
if scr_checkMT(obj_player1.paletteselect)  
{  
    var mangoPattern = scr_searchMT(obj_player1.paletteselect)  
    pattern_set([9, 10], sprite_index, image_index, image_xscale, image_yscale, mangoPattern)  
    pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
    draw_self()  
}  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
draw_self()  
shader_reset()
~~~
# obj_wm_note
Created when calling mango back
**mask : spr_wm_note**
## Create

~~~js
depth = -6  
image_speed = 0.35  
buffer = 30
~~~
## Step

~~~js
buffer--  
if (buffer <= 0)  
    instance_destroy()  
y -= 3
~~~
# obj_wetham_R
#newstates
Wetham left behind after doing a superjump
**sprite : spr_w_lastbreath**
**mask : spr_player_mask**
## Create

~~~js
vsp = -6  
hsp = 0  
grounded = 0  
grav = 0.5  
platformid = -4  
hsp_carry = 0  
vsp_carry = 0  
image_speed = 0.35  
image_index = 0  
state = (0 << 0)  
angle = 0  
distance = 0  
notfade = 0
~~~
## Destroy

~~~js
instance_create(x, y, obj_genericpoofeffect)
~~~
## Step
#states
~~~js
switch state  
{  
	// idle and prepare, can be some like wait
    case (0 << 0):  
        if (sprite_index == spr_w_megaslash)  
            vsp = 0  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_w_lastbreath)  
            {  
                if (!grounded)  
                {  
                    image_index = 0  
                    sprite_index = spr_w_lastbreath_fall  
                }  
            }  
            if (sprite_index == spr_w_megaslash)  
            {  
                state = (1 << 0)  
                sprite_index = spr_w_lastbreath_travel  
                create_particle(x, (y + 3), (14 << 0), 0)  
            }  
            image_index = image_number - 1  
        }  
        scr_collide()  
        break  
    // Travel
    case (1 << 0):  
        distance = distance_to_point(obj_player1.x, obj_player1.y)  
        angle = point_direction(x, y, obj_player1.x, obj_player1.y)  
        var _speed = 95  
        if (distance < 95)  
            _speed = distance  
        x += lengthdir_x(_speed, angle)  
        y += lengthdir_y(_speed, angle)  
        if (distance <= 100)  
        {  
            with (obj_player1)  
            {  
                move = key_left + key_right  
                mangocall = 0  
                brick = 1  
                flash = 1  
                if (move != 0)  
                {  
                    if (move != 0)  
                        xscale = move  
                    input_buffer_jump = 0  
                    particle_set_scale((4 << 0), xscale, 1)  
                    create_particle(x, y, (4 << 0), 0)  
                    movespeed = 16  
                    hsp = movespeed * move  
                    sprite_index = spr_mach4  
                    image_index = 0  
                    jumpAnim = 1  
                    state = (121 << 0)  
                    vsp = 0  
                    jumpstop = 0  
                    if key_down  
                    {  
                        input_buffer_down = 0  
                        state = (5 << 0)  
                        sprite_index = spr_dive  
                        if (brick == 1)  
                        {  
                            with (instance_create(x, y, obj_mango_companion))  
                                wait = 1  
                            brick = 0  
                        }  
                    }  
                }  
                else  
                {  
                    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
                    image_speed = 0.9  
                    GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                    state = (104 << 0)  
                    instance_create(x, y, obj_highjumpcloud2)  
                    sprite_index = spr_wm_djump  
                    image_index = 0  
                    vsp = -25  
                    if place_meeting(x, (y - 1), obj_solid)  
                        vsp = 25  
                }  
            }  
            instance_destroy()  
        }  
        break  
}  
  
if (instance_exists(obj_fadeout) && (!notfade))  
    instance_destroy()
~~~
## OutsideRoom

~~~js
// Unused, will be needing this one though
~~~
## Draw

~~~js
shader_set(global.Pal_Shader)  
if scr_checkMT(obj_player1.paletteselect)  
{  
    var mangoPattern = scr_searchMT(obj_player1.paletteselect)  
    pattern_set([9, 10], sprite_index, image_index, image_xscale, image_yscale, mangoPattern)  
    pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, angle, c_white, 1)  
}  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, angle, c_white, 1)  
shader_reset()
~~~
# obj_wethamtornado
#newstates
Wind and tornado effects
**Persistent**
## Create

~~~js
image_speed = 0  
state = (0 << 0)  
image_alpha = 0.8  
depth = -8  
starter = 0
~~~
## Step
#states
~~~js
switch state  
{  
	// Wind, if windboost, follows the player a lil while
    case (0 << 0):  
        if (sprite_index == spr_w_windpulse && floor(image_index) < 6)  
        {  
            x = obj_player1.x - 70 * obj_player1.xscale  
            y = obj_player1.y  
        }  
        if (floor(image_index) == (image_number - 1))  
            instance_destroy()  
        break  
    // Superjump tornado
    case (1 << 0):  
        x = obj_player1.x  
        y = obj_player1.y  
        break  
}  
  
if (obj_player1.state != (97 << 0) && state == (1 << 0))  
    instance_destroy()
~~~
## EndStep

~~~js
if (instance_number(object_index) > 1 && state != (1 << 0))  
{  
    if (sprite_index != undefined)  
    {  
        for (var i = 0; i < instance_number(object_index); i++)  
        {  
            if (instance_find(object_index, i).sprite_index == sprite_index && instance_find(object_index, i) != id)  
                instance_destroy()  
        }  
    }  
}
~~~
## Draw

~~~js
shader_set(global.Pal_Shader)  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_windpalette, obj_player1.paletteselect, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)  
shader_reset()
~~~
# obj_mango_companion
#newstates
Wetham Pal forever
**sprite : spr_lonemango_idle**
**Parent : obj_followcharacter**
**mask : spr_plater_mask**
Scripts:
- [[scr_mangostates]]
## Create

~~~js
dir = obj_player1.xscale  
space = 0  
maxspace = 1  
spaceaccel = 0.2  
lastplayerposx = obj_player1.x  
lastplayerposy = obj_player1.y  
playerid = obj_player1.id  
xoffset = 80  
yoffset = 0  
LAG_STEPS = 8  
instakilled = 0  
use_collision = 0  
interp = 0.05  
relinterp = 1  
lock = 0  
hsp = 0  
vsp = 0  
hsp_carry = 0  
vsp_carry = 0  
platformid = -4  
grav = 0.5  
grounded = 0  
followqueue = ds_queue_create()  
dummylist = ds_list_create()  
ds_list_add_unique(dummylist, id)  
pos = ds_list_find_index(dummylist, id)  
followid = (pos > 0 ? ds_list_find_value(dummylist, (pos - 1)) : -4)  
image_speed = 0.35  
comeback = 0  
cbspeed = 8  
wait = 0  
trapped = 0  
baddieID = -4  
state = (0 << 0)  
substate = playerid.state  
relativestate = playerid.state  
savedstate = state  
savedsubstate = substate  
savedsprite = sprite_index  
savedin = 0  
tauntID = -4  
moving = 1  
grounded = 1  
xprev = x  
solidarr = [obj_solid, obj_slope, obj_platform]  
flash = 0  
slashbuffer = 0  
depth = obj_player1.depth  
visible = 0  
if obj_player.callstored  
{  
    wait = 0  
    comeback = 1  
}  
poof = 1
~~~

## Destroy

~~~js
if poof  
    instance_create(other.x, other.y, obj_genericpoofeffect)
~~~
## Alarms
### 0

~~~js
comeback = 1  
wait = 0
~~~
### 1

~~~js
flash = 0
~~~
## EndStep
#states
~~~js
// Playerfollower shenanigans
if (lock || (followid != noone && (!instance_exists(obj_player1))) || state != (0 << 0))  
{  
}  
else  
{  
    interp = Approach(interp, relinterp, 0.05)  
    playerid = obj_player1.id  
    if (playerid.state != (93 << 0) && playerid.state != (112 << 0) && playerid.state != (95 << 0))  
    {  
        if (space < maxspace && dir == -1)  
            space += spaceaccel  
        if (space > (-maxspace) && dir == 1)  
            space -= spaceaccel  
    }  
    else  
        space = Approach(space, 0, spaceaccel)  
    if (dir != playerid.xscale)  
        dir = playerid.xscale  
    if (followid == noone && object_index != obj_swapmodefollow && instance_exists(obj_swapmodefollow))  
        followid = obj_swapmodefollow.id  
    if (followid != noone && (!instance_exists(followid)))  
        followid = noone  
    var tx = round(xoffset * space)  
    var xx = (followid == noone ? playerid.x : followid.x)  
    var yy = (followid == noone ? playerid.y : followid.y)  
    var msk = (followid == noone ? playerid.mask_index : followid.mask_index)  
    var ixs = (followid == noone ? playerid.xscale : followid.image_xscale)  
    var ss = playerid.state  
    ds_queue_enqueue(followqueue, (xx + tx))  
    ds_queue_enqueue(followqueue, (yy + yoffset))  
    ds_queue_enqueue(followqueue, msk)  
    ds_queue_enqueue(followqueue, ixs)  
    ds_queue_enqueue(followqueue, ss)  
    if (ds_queue_size(followqueue) > (LAG_STEPS * 2))  
    {  
        var _x = ds_queue_dequeue(followqueue)  
        var _y = ds_queue_dequeue(followqueue)  
        if (!use_collision)  
        {  
            if (!comeback)  
            {  
                if (interp < 1)  
                {  
                    x = lerp(x, _x, interp)  
                    y = lerp(y, _y, interp)  
                }  
                else  
                {  
                    x = _x  
                    y = _y  
                }  
            }  
        }  
        mask_index = ds_queue_dequeue(followqueue)  
        image_xscale = ds_queue_dequeue(followqueue)  
        relativestate = ds_queue_dequeue(followqueue)  
        lastplayerposx = _x  
        lastplayerposy = _y  
    }  
    image_xscale = playerid.xscale * playerid.scale_xs  
    image_yscale = playerid.yscale * playerid.scale_ys  
    following_moonwalk_fix()  
}  
// Grounded and flash manager
var off = 0  
if place_meeting(x, (y + 1), obj_solid)  
    off = 1  
if place_meeting(x, y, obj_solid)  
    off = 0  
if place_meeting(x, (y + 1), obj_slope)  
    off = 1  
if place_meeting(x, (y + 1), obj_platform)  
    off = 1  
grounded = off  
moving = x != xprev  
if (abs(x - xprev) <= 2 || abs(x + xprev) <= 2)  
    moving = 0  
else  
    moving = x != xprev  
xprev = x  
if (flash && alarm[1] == -1)  
    alarm[1] = 10
~~~
## Step
#states
~~~js
switch state  
{  
	
    case (0 << 0):  
        if (playerid.state == (98 << 0) || playerid.state == (112 << 0) || playerid.state == (46 << 0))  
        {  
            instance_destroy()  
            playerid.brick = 1  
        }  
        if (playerid.state == (84 << 0) && state != (1 << 0))  
        {  
            savedstate = state  
            savedsubstate = substate  
            savedsprite = sprite_index  
            savedin = image_index  
            state = (1 << 0)  
        }  
        if (relativestate == (93 << 0))  
            substate = (93 << 0)  
        if (relativestate == (107 << 0))  
            substate = (107 << 0)  
        var _states = (obj_player1.state != (0 << 0) && obj_player1.state != (105 << 0) && obj_player1.state != (92 << 0) && obj_player1.state != (121 << 0) && obj_player1.state != (290 << 0))  
        if (_states || (room == tower_soundtest && obj_soundtest.play) || obj_player1.sprite_index == obj_player1.spr_breakdance || (obj_player1.state == (104 << 0) && sprite_index == spr_wethamwalljump))  
        {  
            wait = 1  
            if (obj_player1.movespeed < 16 && abs(obj_player1.hsp) < 16)  
                alarm[0] = 50  
            depth = obj_player1.depth + 1  
            comeback = 0  
            interp = 0.5  
        }  
        if (obj_player1.movespeed >= 16 && abs(obj_player1.hsp) >= 16)  
            alarm[0] = -1  
        if (comeback == 1)  
        {  
            var direx = point_direction(x, y, playerid.x, playerid.y)  
            x += lengthdir_x(cbspeed, direx)  
            y += lengthdir_y(cbspeed, direx)  
            cbspeed = Approach(cbspeed, 30, 1)  
        }  
        if (obj_player1.state == (106 << 0) || obj_player1.state == (37 << 0) || obj_player1.state == (108 << 0))  
        {  
            xoffset = 0  
            yoffset = 0  
        }  
        else if (obj_player1.state == (93 << 0))  
        {  
            xoffset = 0  
            yoffset = Approach(yoffset, -20, 50)  
        }  
        else  
        {  
            xoffset = Approach(xoffset, 80, 10)  
            yoffset = Approach(yoffset, 0, 10)  
        }  
        if (substate != (0 << 0))  
            relinterp = 1  
        else  
            relinterp = 0.2  
        if (obj_player1.breakdance_speed > 0.5)  
            sprite_index = spr_mango_bd  
        else if (room == tower_soundtest && obj_soundtest.play)  
            sprite_index = spr_mango_bd  
        else  
            scr_mangostates()  
        break  
    case (1 << 0):  
        if (sprite_index != spr_lonemango_taunt)  
        {  
            sprite_index = spr_lonemango_taunt  
            image_index = irandom(sprite_get_number(sprite_index) - 1)  
            tauntID = instance_create(x, y, obj_baddietaunteffect)  
        }  
        if (sprite_index == spr_lonemango_taunt && playerid.state != (84 << 0))  
        {  
            instance_destroy(tauntID)  
            state = savedstate  
            substate = savedsubstate  
            sprite_index = savedsprite  
            image_index = savedin  
        }  
        break  
    case (2 << 0):  
        sprite_index = spr_lonebrick_roll  
        break  
    case (3 << 0):  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_m_flykick)  
            {  
                with (instance_create(x, y, obj_brickcomeback))  
                {  
                    sprite_index = spr_m_flykicked  
                    comeback = 1  
                    comebackaccel = 2  
                }  
                poof = 0  
                instance_destroy()  
            }  
        }  
        scr_collide()  
        break  
}  
  
image_yscale = playerid.yscale * image_yscale  
visible = playerid.visible
~~~
## BeginStep

~~~js
// Somewhat useless
if (playerid.brick || playerid.state == (198 << 0) || playerid.state == (80 << 0) || (state == (5 << 0) && sprite_index == spr_wm_pounce_slide))  
{  
    poof = 0  
    brick = 1  
    instance_destroy()  
}
~~~
## Collision | obj_player

~~~js
if (comeback == 1)  
{  
    other.brick = 1  
    instance_destroy()  
}
~~~
## Draw

~~~js
shader_set(global.Pal_Shader)  
if scr_checkMT(obj_player1.paletteselect)  
{  
    var mangoPattern = scr_searchMT(obj_player1.paletteselect)  
    pattern_set([9, 10], sprite_index, image_index, image_xscale, image_yscale, mangoPattern)  
    pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
    draw_self()  
}  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
draw_self()  
if flash  
{  
    shader_set(shd_color_afterimage)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), 1)  
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)  
}  
shader_reset()
~~~
## DrawUI
Debug only
~~~js
if (playerid != noone)  
{  
    if playerid.displaydata  
    {  
        draw_set_font(lang_get_font("creditsfont"))  
        draw_set_halign(fa_left)  
        draw_set_valign(fa_top)  
        draw_text(10, 340, concat("M_imagespeed: ", image_speed))  
        draw_text(10, 360, concat("M_state: ", state))  
        draw_text(10, 380, concat("M_substate: ", substate))  
    }  
}
~~~
# obj_mango_flee
#newstates 
Mango shit himself
**sprite : spr_mango_slip**
**mask : spr_plater_mask**
## Create

~~~js
hsp = 0  
vsp = -11  
hsp_carry = 0  
vsp_carry = 0  
platformid = -4  
grav = 0.5  
grounded = 0  
depth = obj_player1.depth + 1  
image_speed = 0.35  
image_xscale = choose(-1, 1)  
state = (0 << 0)  
launchforce = irandom_range(8, 14)  
launchbuffer = 5  
flee_speed = 10.5  
flash = 0  
collect = [obj_collect, obj_bigcollect, obj_giantcollect]  
pizzakin = obj_pizzaboxunopen  
toppins = -4  
collectibles = -4  
fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/mflee", x, y)
~~~
## Alarms
### 0

~~~js
flash = 0
~~~
## Step

~~~js
switch state  
{  
    case (0 << 0):  
        if (sprite_index != spr_mango_slip_bump)  
            sprite_index = spr_mango_slip  
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_mango_slip)  
            image_index = image_number - 1  
        hsp = launchforce * image_xscale  
        if (grounded && sprite_index == spr_mango_slip && launchbuffer == 0)  
        {  
            sprite_index = spr_mango_slip_bump  
            launchbuffer = 5  
            vsp = -9  
            launchforce /= 2  
            fmod_event_one_shot_3d("event:/sfx/pep/slipbump", x, y)  
            instance_create(x, (y + 39), obj_bangeffect)  
        }  
        if (grounded && launchbuffer == 0 && sprite_index == spr_mango_slip_bump)  
            state = (1 << 0)  
        if ((scr_solid((x + sign(hsp)), y) || scr_solid((x + image_xscale), y)) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + image_xscale), y, obj_destructibles))))  
        {  
            image_xscale *= -1  
            fmod_event_one_shot_3d("event:/sfx/pep/slipbump", x, y)  
            instance_create((x + -35 * image_xscale), y, obj_bangeffect)  
        }  
        scr_collide()  
        break  
    case (1 << 0):  
        hsp = flee_speed * image_xscale  
        if (sprite_index != spr_mango_flee_bump)  
        {  
            if grounded  
                sprite_index = spr_mango_flee  
            else  
                sprite_index = spr_mango_flee_air  
        }  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_mango_flee_bump)  
                sprite_index = spr_mango_flee  
        }  
        var sitbox = -25  
        for (var i = 0; i < 3; i++)  
        {  
            if place_meeting((x + sitbox), y, obj_player1)  
            {  
                with (instance_place((x + sitbox), y, obj_player1))  
                {  
                    if (vsp > 2 && state != (165 << 0))  
                    {  
                        global.combotime = 60  
                        fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/roar", x, y)  
                        fmod_event_one_shot("event:/sfx/misc/collectpizza")  
                        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmmount", x, y)  
                        instance_create(other.x, other.y, obj_genericpoofeffect)  
                        instance_destroy(other)  
                        brick = 1  
                        if (state != (0 << 0) && state != (105 << 0) && state != (92 << 0) && state != (121 << 0))  
                        {  
                            with (instance_create(x, y, obj_mango_companion))  
                                wait = 1  
                            brick = 0  
                        }  
                        return;  
                    }  
                }  
            }  
            sitbox += 25  
        }  
        var exc = (place_meeting((x + hsp), y, obj_destructibles) || place_meeting((x + hsp), y, obj_metalblock))  
        var coll = (scr_solid((x + image_xscale), y) || place_meeting((x + hsp), y, obj_hallway))  
        var slope = place_meeting((x + hsp), y, obj_slope)  
        if (coll && (!exc) && (!slope))  
        {  
            image_xscale *= -1  
            sprite_index = spr_mango_flee_bump  
            image_index = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            fmod_event_one_shot_3d("event:/sfx/pep/slipbump", x, y)  
            instance_create((x + -35 * image_xscale), y, obj_bangeffect)  
        }  
        if exc  
        {  
            instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
            instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
        }  
        toppins = instance_place(x, y, pizzakin)  
        if (toppins != noone)  
        {  
            with (obj_player)  
                other.toppins.force = 1  
        }  
        for (i = 0; i < array_length(collect); i++)  
        {  
            collectibles = instance_place(x, y, collect[i])  
            if (collectibles != noone)  
            {  
                with (obj_player)  
                {  
                    with (other.collectibles)  
                        event_perform(ev_collision, obj_player)  
                }  
            }  
        }  
        var banan = instance_place(x, y, obj_slipnslide)  
        if (banan != noone)  
        {  
            fmod_event_one_shot_3d("event:/sfx/pep/slip", x, y)  
            vsp = -11  
            state = (0 << 0)  
            launchforce = flee_speed + 4  
            launchbuffer = 5  
            sprite_index = spr_mango_slip  
            image_index = 0  
            instance_destroy(banan)  
            return;  
        }  
        scr_collide()  
        break  
}  
  
if (obj_player1.state == (296 << 0))  
{  
    instance_destroy()  
    instance_create(x, y, obj_genericpoofeffect)  
}  
if (state == (0 << 0) || state == (1 << 0))  
{  
    while scr_solid(x, y)  
    {  
        y--  
        if (!(scr_solid(x, y)))  
            break  
        else  
            continue  
    }  
}  
if (launchbuffer > 0)  
    launchbuffer--
~~~
## EndStep

~~~js
if (flash && alarm[1] == -1)  
    alarm[1] = 10
~~~
## Draw

~~~js
shader_set(global.Pal_Shader)  
if scr_checkMT(obj_player1.paletteselect)  
{  
    var mangoPattern = scr_searchMT(obj_player1.paletteselect)  
    pattern_set([9, 10], sprite_index, image_index, image_xscale, image_yscale, mangoPattern)  
    pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
    draw_self()  
}  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
draw_self()  
if flash  
{  
    shader_set(shd_color_afterimage)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), 1)  
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)  
}  
shader_reset()
~~~
# obj_jaws_grindeffect
Effect used to give feedback on losing speed while holding jaws
## Create

~~~js
image_speed = 0.5  
image_xscale = obj_player.xscale
~~~
## Step
#states
~~~js
if (obj_player.state == (5 << 0))  
    x = obj_player.x + 40 * obj_player.xscale * -1  
else  
    x = obj_player.x + 20 * obj_player.xscale * -1  
y = obj_player.y  
image_xscale = obj_player.xscale  
if (obj_player.state != (80 << 0) && obj_player.state != (5 << 0))  
    instance_destroy()
~~~
# obj_mango_brickball
#newstates 
Mango maims, bites, scratches...
Mango Projectile
**sprite : spr_lonebrick_roll** ==(Subject to change)==
**mask : spr_plater_mask**
Scripts:
- [[List of tool functions#mango_ledge_bump()]]
## Create

~~~js
hsp = 0  
vsp = 0  
grav = 0.5  
movespeed = 0  
grounded = 0  
vsp_carry = 0  
hsp_carry = 0  
platformid = -4  
state = (0 << 0)  
sit_buffer = 20  
collect = [obj_collect, obj_bigcollect, obj_giantcollect]  
pizzakin = obj_pizzaboxunopen  
toppins = -4  
collectibles = -4  
hover = 0  
canhover = 1  
flash = 0  
recover_distance = 1350  
depth = obj_player1.depth + 1  
image_speed = 0.35  
instance_create(x, y, obj_mango_brickball_indicator)
~~~
## Alarms
### 0

~~~js
flash = 0
~~~
## Step
#states
~~~js
var exc = (place_meeting((x + hsp), y, obj_destructibles) || place_meeting((x + hsp), y, obj_metalblock))  
var coll = (scr_solid((x + image_xscale), y) || place_meeting((x + hsp), y, obj_hallway))  
var slope = place_meeting((x + hsp), y, obj_slope)  
switch state  
{  
    case (0 << 0):  
        if (movespeed < 15)  
            movespeed = 15  
        if (floor(image_index) == (image_number - 1))  
        {  
            switch sprite_index  
            {  
                case spr_m_bb:  
                    sprite_index = spr_m_bb_loop  
                    break  
                case 4981:  
                    sprite_index = spr_m_bb_air_loop  
                    break  
            }  
  
        }  
        if (coll && (!exc) && (!slope))  
        {  
            if (place_meeting((x + hsp), y, obj_hallway) || place_meeting((x + image_xscale), y, obj_hallway))  
            {  
                image_xscale *= -1  
                fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
                if (!grounded)  
                {  
                    state = (4 << 0)  
                    sprite_index = spr_lonebrick_roll  
                    vsp = 10  
                    hover = 0  
                }  
                else  
                    sprite_index = spr_m_bb  
                movespeed = 15  
                return;  
            }  
            else  
            {  
                var _climb = mango_ledge_bump(40)  
                if _climb  
                {  
                    if mango_ledge_bump((vsp >= 0 ? 32 : 22))  
                    {  
                        image_xscale *= -1  
                        fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                        instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
                        if (!grounded)  
                        {  
                            state = (4 << 0)  
                            sprite_index = spr_lonebrick_roll  
                            vsp = 10  
                            hover = 0  
                        }  
                        else  
                            sprite_index = spr_m_bb  
                        movespeed = 15  
                        return;  
                    }  
                }  
            }  
        }  
        if ((!grounded) && (sprite_index == spr_m_bb || sprite_index == spr_m_bb_loop))  
        {  
            sprite_index = spr_m_bb_air  
            image_index = 0  
        }  
        if (grounded && (sprite_index == spr_m_bb_air || sprite_index == spr_m_bb_air_loop))  
        {  
            sprite_index = spr_m_bb  
            image_index = 0  
        }  
        if ((!grounded) && vsp < 10)  
            vsp++  
        if grounded  
        {  
            var sauce = 0  
            for (var i = 0; i < 2; i++)  
            {  
                if (collision_line((x + sauce * image_xscale), y, (x + sauce * image_xscale), (y + 200), obj_boilingsauce, false, true) != -4)  
                {  
                    if (!(place_meeting((x + sauce * image_xscale), (y + 1), obj_platform)))  
                    {  
                        sprite_index = spr_m_bb_jump  
                        state = (1 << 0)  
                        vsp = -6.5  
                    }  
                }  
                sauce += 70  
            }  
            if (obj_player1.state == (92 << 0) || abs(obj_player1.hsp) < 9)  
            {  
                var sitbox = -25  
                for (i = 0; i < 3; i++)  
                {  
                    if place_meeting((x + sitbox), y, obj_player1)  
                    {  
                        with (instance_place((x + sitbox), y, obj_player1))  
                        {  
                            if (vsp > 2)  
                            {  
                                global.combotime = 60  
                                fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/roar", x, y)  
                                fmod_event_one_shot("event:/sfx/misc/collectpizza")  
                                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmmount", x, y)  
                                instance_create(other.x, other.y, obj_genericpoofeffect)  
                                instance_destroy(other)  
                                brick = 1  
                                if (state != (0 << 0) && state != (105 << 0) && state != (92 << 0) && state != (121 << 0))  
                                {  
                                    with (instance_create(x, y, obj_mango_companion))  
                                        wait = 1  
                                    brick = 0  
                                }  
                                return;  
                            }  
                        }  
                    }  
                    sitbox += 25  
                }  
            }  
        }  
        break  
    case (1 << 0):  
        if (movespeed < 15)  
            movespeed = 15  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_m_bb_jump)  
                sprite_index = spr_m_bb_jump_loop  
        }  
        if (grounded && vsp > 0.5)  
        {  
            sprite_index = spr_m_bb  
            image_index = 0  
            state = (0 << 0)  
            return;  
        }  
        if (coll && (!exc))  
        {  
            image_xscale *= -1  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
            state = (2 << 0)  
            vsp = 0  
            sprite_index = spr_lonemango_groundpound_start  
            movespeed = 15  
            return;  
        }  
        break  
    case (2 << 0):  
        movespeed = 0  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_lonemango_groundpound_start)  
                sprite_index = spr_lonemango_groundpound  
        }  
        if grounded  
        {  
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            with (obj_camera)  
            {  
                shake_mag = 5  
                shake_mag_acc = 15 / room_speed  
            }  
            with (obj_baddie)  
            {  
                if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                {  
                    state = (138 << 0)  
                    if (stunned < 60)  
                        stunned = 60  
                    vsp = -8  
                    image_xscale *= -1  
                    hsp = 0  
                    momentum = 0  
                }  
            }  
            with (obj_camera)  
            {  
                shake_mag = 10  
                shake_mag_acc = 30 / room_speed  
            }  
            create_particle(x, (y + 3), (14 << 0), 0)  
            state = (0 << 0)  
            sprite_index = spr_m_bb  
            image_index = 0  
            return;  
        }  
        if (vsp < 20)  
            vsp++  
        break  
    case (3 << 0):  
        vsp = 0  
        movespeed = Approach(movespeed, 0, 1)  
        if (floor(image_index) == (image_number - 1))  
            image_index = image_number - 1  
        break  
    case (4 << 0):  
        if grounded  
        {  
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            with (obj_camera)  
            {  
                shake_mag = 5  
                shake_mag_acc = 15 / room_speed  
            }  
            with (obj_baddie)  
            {  
                if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                {  
                    state = (138 << 0)  
                    if (stunned < 60)  
                        stunned = 60  
                    vsp = -8  
                    image_xscale *= -1  
                    hsp = 0  
                    momentum = 0  
                }  
            }  
            with (obj_camera)  
            {  
                shake_mag = 10  
                shake_mag_acc = 30 / room_speed  
            }  
            create_particle(x, (y + 3), (14 << 0), 0)  
            state = (0 << 0)  
            sprite_index = spr_m_bb  
            image_index = 0  
            return;  
        }  
        if (coll && (!exc))  
        {  
            image_xscale *= -1  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
            movespeed = 15  
        }  
        if (vsp < 10)  
            vsp = 10  
        break  
    case (5 << 0):  
        visible = false  
        sprite_index = spr_mango_cries  
        vsp = 0  
        movespeed = 0  
        break  
}  
  
if (hover > 0)  
{  
    hover--  
    if (vsp > -0.5)  
        vsp = 0  
}  
if (sit_buffer > 0)  
    sit_buffer--  
if (state != (5 << 0))  
{  
    var killbox = -25  
    for (i = 0; i < 3; i++)  
    {  
        if place_meeting((x + killbox), y, obj_baddie)  
        {  
            with (instance_place((x + killbox), y, obj_baddie))  
            {  
                if ((parryable != 0 || supertauntable != 0) && destroyable != 0)  
                    instance_destroy()  
            }  
        }  
        killbox += 25  
    }  
}  
if exc  
{  
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
}  
if grounded  
    movespeed = Approach(movespeed, 15, 0.05)  
if (sprite_index == spr_lonebrick_roll)  
    image_speed = 0.55  
else  
    image_speed = 0.35  
scr_collide()
~~~
## BeginStep

~~~js
hsp = movespeed * image_xscale
~~~
## EndStep
#states
~~~js
if (obj_player1.state == (296 << 0))  
{  
    instance_destroy()  
    instance_create(x, y, obj_genericpoofeffect)  
}  
var exc = (place_meeting((x + hsp), y, obj_destructibles) || place_meeting((x + hsp), y, obj_metalblock))  
if exc  
{  
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
}  
if (flash && alarm[1] == -1)  
    alarm[1] = 10  
if (state == (5 << 0))  
    return;  
toppins = instance_place(x, y, pizzakin)  
if (toppins != noone)  
{  
    with (obj_player)  
        other.toppins.force = 1  
}  
for (var i = 0; i < array_length(collect); i++)  
{  
    collectibles = instance_place(x, y, collect[i])  
    if (collectibles != noone)  
    {  
        with (obj_player)  
        {  
            with (other.collectibles)  
                event_perform(ev_collision, obj_player)  
        }  
    }  
}  
var banan = instance_place(x, y, obj_slipnslide)  
if (banan != noone)  
{  
    with (instance_create(x, y, obj_mango_flee))  
    {  
        image_xscale = other.image_xscale  
        launchforce = abs(other.hsp) + 4  
        fmod_event_one_shot_3d("event:/sfx/pep/slip", x, y)  
        vsp = -11  
        state = (0 << 0)  
        launchbuffer = 5  
        sprite_index = spr_mango_slip  
        image_index = 0  
    }  
    instance_destroy(banan)  
    instance_destroy()  
    return;  
}
~~~
## Collision | obj_verticalhallway

~~~js
state = (5 << 0)
~~~
## Draw

~~~js
shader_set(global.Pal_Shader)  
if scr_checkMT(obj_player1.paletteselect)  
{  
    var mangoPattern = scr_searchMT(obj_player1.paletteselect)  
    pattern_set([9, 10], sprite_index, image_index, image_xscale, image_yscale, mangoPattern)  
    pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
    draw_self()  
}  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
draw_self()  
if flash  
{  
    shader_set(shd_color_afterimage)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), 1)  
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)  
}  
shader_reset()
~~~
# obj_mango_brickball_indicator
Handy to indicate the distance and availability of Mango
**Persistent**
## Create

~~~js
depth = obj_player1.depth + 1  
ini_alpha = 0.8  
losing_him = 0  
lost_him = 0  
current = -1  
hand_image_speed = 0
~~~
## Alarms
### 0

~~~js
if losing_him  
{  
    alarm[0] = 10  
    image_alpha = ini_alpha  
    fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/distanceBeep", x, y)  
}
~~~
## BeginStep

~~~js
if ((!instance_exists(obj_player1)) || (!instance_exists(obj_mango_brickball)))  
{  
    instance_destroy()  
    return;  
}  
var _recover = 650  
current = point_distance(obj_player1.x, obj_player1.y, obj_mango_brickball.x, obj_mango_brickball.y)  
if (current >= (obj_mango_brickball.recover_distance - _recover) && current < obj_mango_brickball.recover_distance && (!lost_him))  
    losing_him = true  
else  
    losing_him = false  
if (current > obj_mango_brickball.recover_distance)  
    lost_him = true  
if (current < (obj_mango_brickball.recover_distance - _recover))  
    lost_him = false  
if (losing_him && alarm[0] == -1)  
    alarm[0] = 5  
if (alarm[0] > -1)  
    image_alpha = Approach(image_alpha, 0, 0.1)  
else  
    image_alpha = ini_alpha  
hand_image_speed += 0.35
~~~
## Draw

~~~js
if (instance_exists(obj_player1) && instance_exists(obj_mango_brickball) && current != -1)  
{  
    var ispd = hand_image_speed  
    if (current < obj_mango_brickball.recover_distance)  
    {  
        draw_set_color(make_colour_rgb(0, 255, 115))  
        ini_alpha = 0.8  
    }  
    else  
    {  
        draw_set_color(make_colour_rgb(61, 61, 61))  
        ispd = 0  
        ini_alpha = 0.5  
    }  
    draw_sprite_line(spr_lastbreath_indicator, image_index, obj_player1.x, (obj_player1.y + 20), obj_mango_brickball.x, (obj_mango_brickball.y + 20), true, image_alpha, 180)  
    var _angle = point_direction(obj_player1.x, (obj_player1.y + 20), obj_mango_brickball.x, (obj_mango_brickball.y + 20))  
    var dis = point_distance(obj_player1.x, (obj_player1.y + 20), obj_mango_brickball.x, (obj_mango_brickball.y + 20))  
    var offset = 160 - sprite_get_width(spr_lastbreath_indicator)  
    if (dis < offset)  
        offset = dis  
    draw_sprite_ext(spr_lastbreath_hand, ispd, (obj_player1.x + (lengthdir_x(offset, _angle))), (obj_player1.y + 20 + (lengthdir_y(offset, _angle))), 1, 1, _angle, draw_get_color(), image_alpha)  
}
~~~