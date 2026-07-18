Changes done directly to previous code
## Instakill()

~~~js
// Makes wm not have a hit anim
if (characterID == 1 && (!brick))
    return;
~~~
## scr_dotaunt()

~~~js
//Right at the start, to prevent lone wetham from supertaunting
if (characterID == 1 && key_up && supercharged && (!((brick || instance_exists(obj_mango_companion)))))
    return;
~~~
## scr_hurtplayer()

~~~js
// Prevents the back hurt anim when lone wetham
if (xscale == (-_old_xscale))
{
    sprite_index = spr_hurtjump
    if (characterID == 1 && (!brick))
    {
        xscale *= -1
        sprite_index = spr_hurt
    }
}
else
    sprite_index = spr_hurt
~~~
## scr_player_ladder()

~~~js
if (key_up && hooked == 0)  
{  
	sprite_index = spr_laddermove  
	vsp = -6  
	if (steppybuffer > 0)  
		steppybuffer--  
	else  
	{  
		create_particle(x, (y + 43), (1 << 0), 0)  
		steppybuffer = 12  
		fmod_event_one_shot_3d("event:/sfx/pep/step", x, y)  
	}  
	image_speed = 0.35  
}  
else if (key_down && hooked == 0)  
{  
	sprite_index = spr_ladderdown  
	vsp = 10  
	// H e r e, changed speed for wm when going down stairs
	if (characterID == 1)  
		vsp = 15  
	image_speed = -0.35  
}  
else  
{  
	sprite_index = spr_Ladder  
	vsp = 0  
} 
// Added at the end, so mango appears while going down stairs
if (characterID == 1 && brick && (!instance_exists(obj_mango_companion)))  
{  
	with (instance_create(x, y, obj_mango_companion))  
		wait = 1  
	brick = 0  
}
~~~
## scr_player_bump()
#states
~~~js
function scr_player_bump() //gml_Script_scr_player_bump  
{  
    if (sprite_index != spr_wallsplat)  
    {  
        movespeed = 0  
        mach2 = 0  
        var _gus = (sprite_index == spr_player_ratmountbump || sprite_index == spr_lonegustavo_bump)  
        start_running = 1  
        alarm[4] = 14  
        if (grounded && vsp > 0)  
            hsp = 0  
        var can_end = 1  
        if (sprite_index == spr_tumbleend)  
            can_end = (!(place_meeting(x, y, obj_pepgoblin_kickhitbox)))  
        if (sprite_index == spr_tumbleend && (!can_end))  
            image_speed = 0  
        else  
            image_speed = 0.35  
        if (sprite_index == spr_tumbleend && floor(image_index) >= 3 && (!grounded))  
            image_index = 3  
        if (sprite_index == spr_rockethitwall && grounded && vsp > 0)  
            image_index = image_number - 1  
        if (floor(image_index) == (image_number - 1) && sprite_index != spr_player_catched && sprite_index != spr_boxxedpep_air && (!_gus))  
        {  
            if (!skateboarding)  
            {  
                if (sprite_index != spr_rockethitwall || (grounded && vsp > 0))  
                    state = (0 << 0)  
            }  
            else  
                state = (104 << 0)  
        }  
        if (sprite_index != spr_player_catched && sprite_index != spr_boxxedpep_air && sprite_index != spr_rockethitwall && sprite_index != spr_tumbleend && sprite_index != spr_hitwall && (!_gus) && sprite_index != spr_mach && sprite_index != spr_mach4)  
            sprite_index = ((!skateboarding) ? spr_bump : spr_clownbump)  
        // H e r e, due to wm crash anims only having 1 frame, the image index animation ender doesnt work properly, they can only stand up when grounded
        if (characterID == 1 && grounded && vsp >= 0.5)  
        {  
            movespeed = 0  
            hsp = 0  
            vsp = 0  
            state = (0 << 0)  
            return;  
        }  
    }  
    else  
    {  
		// Bump overwritter, if pressed shoot key, jumpsout in a ball bounce
        var hasM = (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_brickcomeback) && obj_brickcomeback.sprite_index == spr_m_flykicked))  
        if (key_shoot && characterID == 1 && hasM)  
        {  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                brick = 1  
            }  
            if instance_exists(obj_brickcomeback)  
            {  
                with (obj_brickcomeback)  
                    instance_destroy()  
                instance_create(other.x, other.y, obj_genericpoofeffect)  
                flash = 1  
                brick = 1  
            }  
            scr_wm_bouncejaws(1)  
        }  
        movespeed = 0  
        hsp = 0  
        vsp = 0  
        if (floor(image_index) == (image_number - 1))  
            state = (0 << 0)  
        image_speed = 0.35  
    }  
}
~~~
## obj_player | RoomStart
#states
[[obj_player#RoomStart]]
~~~js
// If mango is superjumping and calling wetham, while trasitioning rooms, prevents softlock
if (sprite_index == spr_m_call)  
{  
    move = key_left + key_right  
    mangocall = 0  
    brick = 1  
    flash = 1  
    if (move != 0)  
        xscale = move  
    input_buffer_jump = 0  
    particle_set_scale((4 << 0), xscale, 1)  
    create_particle(x, y, (4 << 0), 0)  
    ratmount_movespeed = abs(16)  
    movespeed = ratmount_movespeed * xscale  
    hsp = movespeed  
    sprite_index = spr_player_ratmountdashjump  
    image_index = 0  
    jumpAnim = 1  
    state = (192 << 0)  
    vsp = 0  
    jumpstop = 0  
}  
// When mango falls into a vertival hallway, betters the player movement by forcing a bomb dive when starting the next room
if (sprite_index == spr_wm_balltochomp)  
{  
    state = (108 << 0)  
    scr_wm_dobombdive(true)  
}

hallway = 0  
verticalhallway = 0  
box = 0  
// Right below the above 3 variables
// Retrive mango when changing rooms
if (isgustavo || characterID == 1)  
{  
    brick = 1  
    brickskinbuffer = 1  
    scr_wm_skinswitch()  
}
~~~
## obj_baddiecollisionbox | Step
#states
~~~js
// WM duo can stomp kill enemies, this needs more checkers to prevent forced kills, like greaseball
if (characterID == 1)  
	instance_destroy(other.baddieID)
	

// Used to prevent or allow bumping into enemies in the below cases
var exec = (characterID == 1 && sprite_index == spr_wethamroll)  
var allow = (characterID == 1 && state == (23 << 0))  
if (instance_exists(other.baddieID) && (!exec) && other.baddieID.object_index != obj_bigcheese && state != (61 << 0) && (state == (5 << 0) || state == (104 << 0) || state == (105 << 0) || allow || sprite_index == spr_player_ratmountattack || sprite_index == spr_lonegustavo_dash) && other.baddieID.state != (80 << 0) && other.baddieID.state != (137 << 0) && (!pepp_grab) && other.baddieID.thrown == 0 && other.baddieID.stuntouchbuffer <= 0 && other.baddieID.state != (4 << 0) && other.baddieID.state != (41 << 0) && other.baddieID.state != (61 << 0) && (!other.baddieID.invincible))  
~~~
## obj_ladder | Step
#states
~~~js
// Exception when playing as WM duo, to make them go down ladder while on tumble or crouch
var wmp = (characterID == 1 && (state == (100 << 0) || state == (5 << 0)))  
if (place_meeting(x, (y + 1), obj_ladder) && (!(place_meeting((other.x + 16), (y + 1), obj_solid))) && key_down && (wmp || state == (100 << 0) || ((character == "S" || character == "M") && (state == (0 << 0) || state == (103 << 0)))) && place_meeting(x, (y + 1), obj_platform) && sprite_index != spr_wm_pounce_slide)
~~~
## obj_boxofpizza | Step
#states
~~~js
// While going down the pizzabox
var wmadd = (state == (198 << 0) && (vsp > 1 || key_down) && characterID == 1 && (place_meeting(x, (y + vsp), other) || place_meeting(x, (y + 1), other)) && (!instance_exists(obj_fadeout)))  

if ((((key_down && (!(place_meeting(x, (y + 1), obj_destructibles))) && place_meeting(x, (y + 1), other) && (state == (100 << 0) || character == "S" || character == "M" || state == (65 << 0) || (state == (5 << 0) && sprite_index == spr_dive))) || ((state == (102 << 0) || (state == (5 << 0) && key_down) || state == (306 << 0) || state == (300 << 0) || state == (303 << 0) || state == (108 << 0) || state == (111 << 0)) && (!(place_meeting(x, (y + 1), obj_destructibles))) && place_meeting(x, (y + 1), other))) && (!instance_exists(obj_fadeout)) && state != (112 << 0) && state != (95 << 0)) || wmadd)

// While going up
wmadd = (((state == (198 << 0) && vsp < 1) || (state == (104 << 0) && vsp < 1) || (state == (37 << 0) && vsp < 1)) && characterID == 1 && (place_meeting(x, (y + vsp), other) || place_meeting(x, (y - 1), other)) && (!instance_exists(obj_fadeout)))  

if ((((key_up && (!(place_meeting(x, (y - 1), obj_destructibles))) && place_meeting(x, (y - 10), other) && (state == (0 << 0) || state == (306 << 0) || state == (58 << 0) || state == (300 << 0) || state == (302 << 0) || state == (306 << 0) || state == (92 << 0) || state == (103 << 0) || state == (104 << 0) || state == (121 << 0) || state == (99 << 0) || (state == (80 << 0) && sprite_index == spr_breakdanceuppercut))) || ((state == (97 << 0) || state == (306 << 0) || state == (123 << 0)) && (!(place_meeting(x, (y - 1), obj_destructibles))) && place_meeting(x, (y - 1), other))) && (!instance_exists(obj_fadeout)) && state != (112 << 0) && state != (95 << 0)) || wmadd)
~~~
## obj_fadeout | Step
#states
~~~js
if (other.fadein == true && obj_player1.state == (112 << 0) && (obj_player1.sprite_index == spr_downpizzabox || obj_player1.sprite_index == spr_uppizzabox))  
{  
	// H e r e, Coming out downwards as wm goes in a bodyslam
	if (characterID == 1 && obj_player1.sprite_index == spr_downpizzabox)  
	{  
		sprite_index = spr_bodyslamstart  
		image_index = 0  
		state = (108 << 0)  
		hsp = 0  
		pistolanim = -4  
	}  
	else  
	{  
		state = (101 << 0)  
		uncrouch = 20  
	}  
	if (global.coop == true)  
		obj_player2.state = (101 << 0)  
}
~~~

## obj_brickcomeback
### Create

~~~js
comeback = 0  
hsp = 0  
vsp = 0  
cbspeed = 0  
wait = 0  
trapped = 0  
baddieID = -4  
stunned = 0  
alarm[0] = 25  
image_speed = 0.4  
depth = obj_player1.depth + 1  
alarm[1] = 75  
forcecomeback = 0  
comebackaccel = 5  
if obj_player.callstored  
{  
    wait = 0  
    comeback = 1  
}  
poof = 1
~~~
### Destroy

~~~js
if poof  
    instance_create(other.x, other.y, obj_genericpoofeffect)
~~~
### Alarms

#### 0

~~~js
comeback = true  
wait = false
~~~
#### 1

~~~js
forcecomeback = 1
~~~
#### 2

~~~js
stunned = 0
~~~
### Step

~~~js
if trapped  
    sprite_index = spr_mango_cries  
if stunned  
    return;  
if obj_player.callstored  
{  
    comeback = 1  
    wait = 0  
}  
if (!trapped)  
{  
    depth = obj_player1.depth + 1  
    x = Approach(x, obj_player1.x, cbspeed)  
    y = Approach(y, obj_player1.y, cbspeed)  
    if ((!obj_player1.callstored) && sprite_index != spr_m_flykicked)  
        cbspeed = Approach(cbspeed, 20, (comebackaccel / 5))  
    else  
        cbspeed = Approach(cbspeed, 45, comebackaccel)  
    if (sprite_index != spr_lonebrick_comeback && sprite_index != spr_m_flykicked)  
        sprite_index = spr_lonebrick_comeback  
}  
if (comebackaccel < 5)  
    comebackaccel += 0.1  
else if (baddieID == noone)  
{  
    vsp = -10  
    if ((y + vsp) < 80 || scr_solid(x, (y - 78)))  
        vsp = 0  
    y += vsp  
}  
else if (!instance_exists(baddieID))  
    trapped = 0
~~~
### Collision | obj_player
#states
~~~js
if (!trapped)  
{  
    if (comeback == 1 && obj_player1.sprite_index != spr_w_spinkick && obj_player1.state != (2 << 0) && obj_player1.sprite_index != spr_lonegustavo_hurt && obj_player1.state != (108 << 0) && obj_player1.state != (111 << 0) && obj_player1.state != (202 << 0) && obj_player1.sprite_index != spr_wetham_bd && obj_player1.sprite_index != spr_wethamwalljump && obj_player1.state != (37 << 0) && obj_player1.state != (93 << 0) && obj_player1.state != (100 << 0) && obj_player1.state != (5 << 0) && obj_player1.sprite_index != spr_wetham_longjump && obj_player1.sprite_index != spr_wetham_longjump_loop)  
    {  
        other.brick = 1  
        instance_create(other.x, other.y, obj_genericpoofeffect)  
        instance_destroy()  
    }  
    else  
    {  
        with (instance_create(x, y, obj_mango_companion))  
            wait = 1  
        instance_destroy()  
    }  
}  
else if (other.state == (259 << 0) && baddieID == -4)  
{  
    fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
    vsp = -6  
    hsp = other.xscale * 8  
    trapped = 0  
    wait = 1  
    comeback = 0  
    alarm[0] = 30  
}
~~~
### Draw

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
## obj_ratmountgroundpound
### Create

~~~js
vsp = 0  
hsp = 0  
grounded = 0  
grav = 0  
platformid = -4  
hsp_carry = 0  
vsp_carry = 0  
image_speed = 0  
alarm[0] = 5  
alarm[1] = 200  
kicked = 0  
hitbox = 0  
prem = 0  
di = 1
~~~
### Destroy

~~~js
if (prem == 0)  
{  
    with (instance_create(x, y, obj_brickcomeback))  
    {  
        vsp = 0  
        fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
        sprite_index = spr_ratmountgroundpound_dead  
        image_index = 0  
        stunned = 1  
        alarm[2] = 50  
    }  
    with (obj_camera)  
    {  
        shake_mag = 10  
        shake_mag_acc = 30 / room_speed  
    }  
    repeat (3)  
    {  
        with (create_debris(x, y, 1646))  
        {  
            hsp = random_range(-5, 5)  
            vsp = random_range(-10, 10)  
        }  
    }  
    instance_create(x, y, obj_bangeffect)  
    create_particle(x, (y + 3), (14 << 0), 0)  
}  
else  
{  
    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
    instance_create(x, y, obj_brickcomeback)  
}
~~~
### Alarms

#### 0

~~~js
image_speed = 0.5  
vsp = 10  
grav = 0.5  
kicked = true
~~~
#### 1

~~~js
instance_destroy()
~~~
### Step

~~~js
instance_destroy(instance_place(x, (y + 16), obj_destructibles))  
instance_destroy(instance_place(x, (y + vsp), obj_destructibles))  
instance_destroy(instance_place(x, (y + 16), obj_metalblock))  
instance_destroy(instance_place(x, (y + vsp), obj_metalblock))  
if (!kicked)  
{  
    x = obj_player.x - obj_player.xscale * 10  
    y = obj_player.y + 60  
}  
vsp += 2  
if (hitbox == 0)  
{  
    with (instance_create(x, y, obj_shotgunbullet))  
    {  
        brick = 1  
        visible = 0  
        mask_index = spr_ratmountgroundpound  
        image_index = other.image_index  
        brickid = other.id  
        other.hitbox = 1  
    }  
}  
scr_collide()  
if (grounded && kicked && (!(place_meeting(x, (y + 1 * di), obj_destructibles))) && (!(place_meeting(x, (y + 1), obj_metalblock))))  
    instance_destroy()  
if (!(point_in_camera(x, y, view_camera[0])))  
    instance_destroy()
~~~
### OutsideRoom

~~~js
instance_destroy()
~~~
### Draw

~~~js
shader_set(global.Pal_Shader)  
if scr_checkMT(obj_player1.paletteselect)  
{  
    var mangoPattern = scr_searchMT(obj_player1.paletteselect)  
    pattern_set([9, 10], sprite_index, image_index, image_xscale, image_yscale, mangoPattern)  
    pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
    draw_self()  
}  
pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
draw_self()  
shader_reset()
~~~
## scr_collide_destructibles()
Made some changes to destructibles detections
==Should rebuild this one, some messy code is here==
## obj_door
### Collision | obj_player

~~~js
var wm = ((state == (100 << 0) && sprite_index == spr_wm_roll) || state == (5 << 0) || state == (105 << 0) || state == (80 << 0))  
// When checking the up key, we allow roll and other states
if (key_up && (!instance_exists(obj_jumpscare)) && grounded && (state == (191 << 0) || state == (198 << 0) || state == (283 << 0) || state == (0 << 0) || wm || state == (103 << 0) || state == (104 << 0) || state == (58 << 0) || state == (121 << 0) || state == (99 << 0)) && y == (other.y + 50) && (!instance_exists(obj_noisesatellite)) && (!instance_exists(obj_fadeout)) && state != (112 << 0) && state != (95 << 0))  
        {  
~~~