Variables initialized in create | obj_player, used by Wetham and Mango
## obj_player | create
[[obj_player#Create]]
### Global

~~~js
global.wdodge_color1 = [109, 255, 243]
global.wdodge_color2 = [47, 52, 255]
// Pep gustavo switch Probably be obsolete later on
global.wetham = 0
~~~
### Local

~~~js
// Mango's
ballspeed = 14
allowjawsfly = 1 // jawsHover
jawsbuffer = 0
jawsup = 0
hoverspin = 5
mkickbuffer = 0
wallstick = 0 // Unused
callstored = 0
brickcallbuffer = 0
mangocall = 0
bombdivesmash = 0
jawsfriction = 0
ballvertical = 0
// Wetham's
ninjablock = 1 // variable used for old wetham divel, not really used in current dev build
tornadospeed = -16 // Used for movement for the superjump
slashstored = 1
wrollbuffer = 0
wcrouchbuffer = 0
wallclingbuffer = 0
wallclingpulse = 0
wmlongjumpbuffer = 0
katanatype = 0
katanatypebuffer = katanatype
katanawallexit = 0
kpulsebuffer = 0
allowkpulse = 1 // Katanapulse
fakehsp = 0 // Katanapulse
katanaxscale = 0 // Katanapulse
wsndroll = 0
clingboost = 0
clingexitspeed = 0
wethamcombo = [0, 0, 0, 0, 0]
katanawalloutbuffer = 0
kickiw = 0 // Dodge kick afterimages
iwalpha = 0 // Dodge afterimages
// Italian manners variable, obsolete
wm = 1
// Vainilla is brick
brickskinbuffer = 1 // Used for the skinswitcher for these guys
~~~
### Var init outside Chaos custom scripts
#### obj_player | EndStep
#states 
[[obj_player#EndStep]]
~~~js
// All variables managed by WM duo are inside this conditional
if (isgustavo || characterID == 1)  
{  
	// For the longjump effect when jumping prematurely with jaws
    if (!flash)  
        wmlongjumpbuffer = 0  
    // When superjumping, restart some variables when going inside secrets or executing cutscenes?
    if (state == (296 << 0) || state == (146 << 0))  
    {  
        clingexitspeed = 0  
        if instance_exists(obj_wethamtornado)  
        {  
            with (obj_wethamtornado)  
            {  
                if (state == (1 << 0))  
                    instance_destroy()  
            }  
            with (obj_wetham_R)  
                instance_destroy()  
            brick = 1  
        }  
    }  
    // Rollsound executer
    if (sprite_index == spr_wethamroll && (!wsndroll))  
    {  
        wsndroll = 1  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/roll", x, y)  
    }  
    // Double tap thingy
    if (brickcallbuffer > 0)  
        brickcallbuffer--  
    // Do megaslash when after kicking mango
    // THIS USES A CONDITIONAL USED FOR CAOS CHALLENGE BE CAREFUL
    if (key_shoot2 && instance_exists(obj_mango_brickball) && state != (3 << 0) && state != (23 << 0) && flamelock)  
    {  
        if (distance_to_point(obj_mango_brickball.x, obj_mango_brickball.y) <= obj_mango_brickball.recover_distance)  
        {  
            state = (23 << 0)  
            sprite_index = spr_w_megaslash  
            image_index = 0  
            fmod_event_one_shot_3d("event:/sfx/misc/comboend", x, y)  
            fmod_event_one_shot_3d("event:/sfx/misc/toppingot", x, y)  
            with (obj_mango_brickball)  
            {  
                state = (3 << 0)  
                sprite_index = spr_m_call  
                instance_create(x, y, obj_wm_note)  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/call", x, y)  
            }  
        }  
        else if key_shoot2  
            fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)  
    }  
    // Megaslash angle fuckery
    if (state != (3 << 0))  
        angle = 0  
    // Prevent premature kicking after receiving mango
    if (mkickbuffer > 0)  
        mkickbuffer--  
    // Double tap init
    if (key_shoot2 && brickcallbuffer == 0)  
        brickcallbuffer = 13  
    // For calling obj_brickcomeback | may call it something else in the future, or maybe not
    if brick  
        callstored = 0  
    // Hoverspin speed restarter
    if (sprite_index != spr_wm_djump && sprite_index != spr_player_mangoboostfly && sprite_index != spr_wm_ball_doublejumpl)  
        hoverspin = 5  
    // This should go along with the upper line
    if (sprite_index != spr_wethamroll)  
        wsndroll = 0  
    // This was used as a multiplier for the consecutive wetham dive jumps, no longer works
    if (grounded || abs(hsp) < 12)  
        ninjablock = 1  
    // Gusbrick breakdance, obsolete
    if ((!isgustavo) || state != (191 << 0) || key_attack)  
        ratdance_speed = 0.25  
    // Manages the katana pulse
    if (kpulsebuffer > 0)  
    {  
        movespeed = fakehsp + kpulsebuffer  
        kpulsebuffer -= 0.5  
        if (grounded || xscale != katanaxscale)  
            kpulsebuffer -= 0.5  
        if (state == (37 << 0))  
            kpulsebuffer = 0  
    }  
    else  
        kpulsebuffer = 0  
    // When losing or recovering mango, takes the hand in changing the sprites
    if (brick != brickskinbuffer)  
    {  
        scr_wm_skinswitch()  
        brickskinbuffer = brick  
    }  
    // When entering a secret portal
    if ((!brick) && (instance_exists(obj_mango_companion) || instance_exists(obj_brickcomeback)))  
    {  
        if (state == (296 << 0))  
        {  
            brick = 1  
            instance_destroy(obj_mango_companion)  
            instance_destroy(obj_brickcomeback)  
        }  
    }  
    // Companion creation when forcing mango to go into wetham
    if ((!instance_exists(obj_mango_companion)) && brick)  
    {  
        if ((state == (5 << 0) && sprite_index != spr_wm_pounce_dive && sprite_index != spr_wm_pounce_slide) || (state == (37 << 0) && string_copy(sprite_get_name(sprite_index), 1, 11) != "spr_wm_wall") || state == (2 << 0) || state == (106 << 0) || state == (100 << 0) || state == (101 << 0) || state == (108 << 0) || (state == (104 << 0) && sprite_index == spr_wethamwalljump) || state == (290 << 0))  
        {  
            instance_create(x, y, obj_mango_companion)  
            brick = 0  
        }  
    }  
    // When exiting superjump, restart the call variable
    if (state != (97 << 0))  
        mangocall = 0  
    // Combo manager, prevents spam
    if ((grounded && vsp > -0.5) || state == (37 << 0) || state == (198 << 0))  
    {  
        wethamcombo[0] = 0  
        wethamcombo[1] = 0  
        wethamcombo[2] = 0  
        wethamcombo[3] = 0  
    }  
    if ((grounded && vsp > -0.5) || state == (37 << 0))  
        wethamcombo[4] = 0  
    // Resetting the hover for both katana and jaws
    if (grounded || state == (37 << 0))  
    {  
        allowkpulse = 1  
        allowjawsfly = 1  
    }  
    // Uppercut restarter w/ mango
    if (state != (198 << 0))  
        ballvertical = 0  
    // Resetting katanatype
    if (state == (0 << 0))  
        katanatype = 0  
    // In some cases, jawsup is not possible, makes the bounce horizontal and not downwards
    if (state != (198 << 0) && state != (37 << 0) && state != (23 << 0) && state != (80 << 0))  
        jawsup = 0  
    // Used in spaming katana, when out the katana state, resets it
    if (state != (2 << 0) && grounded)  
        slashstored = 0  
    // Slip along with manog or companion, creates mango flee
    if (state == (165 << 0))  
    {  
        if brick  
        {  
            brick = 0  
            with (instance_create(x, y, obj_mango_flee))  
            {  
                image_xscale = other.xscale  
                launchforce = abs(other.hsp) + 4  
            }  
        }  
        else if instance_exists(obj_mango_companion)  
        {  
            with (instance_create(obj_mango_companion.x, obj_mango_companion.y, obj_mango_flee))  
            {  
                image_xscale = other.xscale  
                launchforce = abs(other.hsp) + 4  
            }  
            with (obj_mango_companion)  
                instance_destroy()  
        }  
    }  
    // Katana skin manager
    if (katanatypebuffer != katanatype && (!brick))  
    {  
        switch katanatype  
        {  
            case 0:  
                spr_mach4 = 1165  
                spr_mach3jump = 3546  
                break  
            case 1:  
                spr_mach4 = 4911  
                spr_mach3jump = 4913  
                break  
            case 2:  
                spr_mach4 = 4910  
                spr_mach3jump = 3546  
                break  
        }  
  
        scr_arc_wmspr()  
        katanatypebuffer = katanatype  
    }  
    // Doublejump copter sound reset
    if (sprite_index != spr_wm_djump)  
        fmod_event_instance_stop(wmcopter, 1)  
}
~~~
#### [[scr_wm_skinswitch()]]