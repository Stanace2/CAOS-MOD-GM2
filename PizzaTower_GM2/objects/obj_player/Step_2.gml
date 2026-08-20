player_index = swap_is_player2();
var pal = player_index;
if (global.swapmode && obj_savesystem.ispeppino)
{
	pal = !pal;
}
paletteselect = player_paletteselect[pal];
global.palettetexture = player_patterntexture[pal];
player_paletteindex = pal;
if (global.collect != global.lastcollect)
{
	var diff = global.collect - global.lastcollect;
	global.lastcollect = global.collect;
	if (global.swapmode)
	{
		global.collect_player[player_index] += diff;
	}
}
if ((global.noisejetpack /*|| flamedash*/) && characterID == characters.dos && !global.manners)
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
if characterID == characters.dos {
	fightmode = (instance_exists(obj_bosscontroller) && (!instance_exists(obj_pistolpickup)))
	if (sprite_index != spr_snapjumpstart && state != states.machcancel)  
	    snapjumps = 0
	if (state != states.machcancel)  
	    snaphold = 0
	if (movespeed < 21)  
	{  
	    if mach5  
	        alarm[11] = 350  
	    mach5 = 0  
	}
}
// All variables managed by WM duo are inside this conditional
if characterID == characters.wm {  
	// For the longjump effect when jumping prematurely with jaws
    if (!flash)  
        wmlongjumpbuffer = 0  
    // When superjumping, restart some variables when going inside secrets or executing cutscenes?
    if (state == states.secretportal || state == states.actor)  
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
    if (sprite_index == spr_wm_roll && (!wsndroll))  
    {  
        wsndroll = 1  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/roll", x, y)  
    }  
    // Double tap thingy
    if (brickcallbuffer > 0)  
        brickcallbuffer--  
    // Do megaslash after kicking mango
    if (key_shoot2 && instance_exists(obj_mango_brickball) && state != states.boots && state != states.slap && !PLAYER_LOCK && !PLAYER_STUNNED)  
    {  
        if (distance_to_point(obj_mango_brickball.x, obj_mango_brickball.y) <= obj_mango_brickball.recover_distance)  
        {  
            state = states.slap
            sprite_index = spr_w_megaslash  
            image_index = 0  
            fmod_event_one_shot_3d("event:/sfx/misc/comboend", x, y)  
            fmod_event_one_shot_3d("event:/sfx/misc/toppingot", x, y)  
            with (obj_mango_brickball)  
            {  
                state = mbstates.callback
                sprite_index = spr_m_call  
                instance_create(x, y, obj_wm_note)  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/call", x, y)  
            }  
        }  
        else if key_shoot2  
            fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)  
    }  
    // Megaslash angle fuckery
    if (state != states.boots)  
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
    // Manages the katana pulse
    if (kpulsebuffer > 0)  
    {  
        movespeed = fakehsp + kpulsebuffer  
        kpulsebuffer -= 0.5  
        if (grounded || xscale != katanaxscale)  
            kpulsebuffer -= 0.5  
        if (state == states.climbwall)  
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
    if ((!brick) && (instance_exists(obj_mango_companion) || instance_exists(obj_mangocomeback)))  
    {  
        if (state == states.secretportal)  
        {  
            brick = 1  
            instance_destroy(obj_mango_companion)  
            instance_destroy(obj_mangocomeback)  
        }  
    }  
    // Companion creation when forcing mango to go into wetham
    if ((!instance_exists(obj_mango_companion)) && brick)  
    {  
        if ((state == states.tumble && sprite_index != spr_wm_pounce_dive && sprite_index != spr_wm_pounce_slide) || (state == states.climbwall && string_copy(sprite_get_name(sprite_index), 1, 11) != "spr_wm_wall") || state == states.dynamite || state == states.bump || state == states.crouch || state == states.crouchjump || state == states.freefall || (state == states.mach2 && sprite_index == spr_wethamwalljump) || state == states.backtohub)  
        {  
            instance_create(x, y, obj_mango_companion)  
            brick = 0  
        }  
    }  
    // When exiting superjump, restart the call variable
    if (state != states.Sjump)  
        mangocall = 0  
    // Combo manager, prevents spam
    if ((grounded && vsp > -0.5) || state == states.climbwall || state == states.ratmountbounce)  
    {  
        wethamcombo[0] = 0  
        wethamcombo[1] = 0  
        wethamcombo[2] = 0  
        wethamcombo[3] = 0  
    }  
    if ((grounded && vsp > -0.5) || state == states.climbwall)  
        wethamcombo[4] = 0  
    // Resetting the hover for both katana and jaws
    if (grounded || state == states.climbwall)  
    {  
        allowkpulse = 1  
        allowjawsfly = 1  
    }  
    // Uppercut restarter w/ mango
    if (state != states.ratmountbounce)  
        ballvertical = 0  
    // Resetting katanatype
    if (state == states.normal)  
        katanatype = 0  
    // In some cases, jawsup is not possible, makes the bounce horizontal and not downwards
    if (state != states.ratmountbounce && state != states.climbwall && state != states.slap && state != states.punch)  
        jawsup = 0  
    // Used in spaming katana, when out the katana state, resets it
    if (state != states.dynamite && grounded)  
        slashstored = 0  
    // Slip along with mango or companion, creates mango flee
    if (state == states.slipbanan)  
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
                spr_mach4 = spr_w_mach3
                spr_mach3jump = spr_w_dashjump
                break  
            case 1:  
                spr_mach4 = spr_wetham_machslash
                spr_mach3jump = spr_wetham_machslash_air
                break  
            case 2:  
                spr_mach4 = spr_wetham_machslash2
                spr_mach3jump = spr_w_dashjump
                break  
        }  
  
        scr_arc_wmspr()  
        katanatypebuffer = katanatype  
    }  
	if state != states.ratmountbounce && state != states.slap && state != states.punch && state != states.freefall && state != states.freefallland && state != states.climbwall
		clingexitspeed = 0
    // Doublejump copter sound reset
    if (sprite_index != spr_wm_djump)  
        fmod_event_instance_stop(wmcopter, 1)  
}
if instance_exists(obj_debugcontroller) && obj_debugcontroller.DEBUG {
	if keyboard_check(ord("1"))
	{
	    characterID = characters.dos
	    scr_character_spr_init()
	}
	if keyboard_check(ord("2"))
	{
	    characterID = characters.wm
		brick = true
	    scr_character_spr_init()
	}
	if keyboard_check(ord("1")) && key_attack
	{
	    characterID = characters.pep
	    scr_character_spr_init()
	}
	if keyboard_check(ord("3")) && key_attack
	{
	    characterID = characters.noise
	    scr_character_spr_init()
	}
	if key_shoot2 && characterID == characters.noise {
		instance_create(x,y, obj_canonexplosion)
	}
}
if (key_shoot2 || input_buffer_chaos > 0)  
    input_buffer_chaos++  
else  
    input_buffer_chaos = 0  
if ((!key_shoot) || input_buffer_chaos == -1)  
    input_buffer_chaos = 0