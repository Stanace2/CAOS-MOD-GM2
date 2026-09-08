function scr_doniMoveset() //gml_Script_scr_doniMoveset
{
    if (sprite_index == spr_machsplit && floor(image_index) < 4)
        vsp = 0.5
    if 
	(
		grounded && input_buffer_jump < 30 && input_buffer_jump != 0 && vsp > -0.5 && 
		(sprite_index == spr_machsplit_loop || sprite_index == spr_machsplit || sprite_index == spr_spinkf)
	)
    {
        poundbuffer = 15
        input_buffer_slap = 0
        instance_create(x, y, obj_noiseeffect)
        if (movespeed >= 12)
        {
            repeat (5)
                instance_create(x, y, obj_firemouthflame)
        }
        fmod_event_one_shot_3d("event:/sfx/misc/mushroombounce", x, y)
        fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
        if global.noisejetpack
            snapjumps += 1
        sprite_index = spr_snaphighjump
        vsp = -15
        jumpstop = 0
        state = states.machcancel
        image_index = 0
        return 0;
    }
    if (move != xscale && move != 0 && (sprite_index == spr_machsplit_loop || sprite_index == spr_machsplit))
    {
        fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)
        sprite_index = spr_poundaircancel
        image_index = 0
        jumpAnim = 1
        grav = 0.5
        state = states.jump
        return 0;
    }
    if ((!grounded) && (sprite_index == spr_machsplit_loop || sprite_index == spr_machsplit) && (key_down2 || (key_shoot2 && (!dragonsnap))))
    {
        drillexitspd = movespeed
        sprite_index = spr_machdrill
        hsp = 0
        freefallsmash = 13
        movespeed = 0
        vsp = 20
        state = states.freefall
        return 0;
    }
    if ((sprite_index == spr_rolljump || sprite_index == spr_mach3hit) && ispeppino && (!grounded) && hsp == 0)
    {
        hsp = movespeed * xscale
        image_speed = 0.8
        sprite_index = spr_rolljump
    }
    if (!((global.caoschase && global.ikframes && (!global.iexception))))
    {
        if (punch_afterimage > 0)
            punch_afterimage--
        else
        {
            punch_afterimage = 5
            with (create_mach3effect(x, y, sprite_index, image_index))
            {
                image_xscale = other.xscale
                playerid = other.id
            }
        }
    }
    if (grounded && poundbuffer < 13)
        poundbuffer = 0
    if ((!grounded) && (sprite_index == spr_machsplit_loop || sprite_index == spr_machsplit) && (place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))))
    {
        var _climb = 1
        if (!ispeppino)
            _climb = ledge_bump(40, (abs(hsp) + 1))
        if _climb
        {
            if key_down
            {
                wallspeed = (-movespeed)
                grabclimbbuffer = 0
                state = states.climbwall
                return;
            }
            else
            {
                wallspeed = movespeed
                grabclimbbuffer = 0
                if (movespeed < 1)
                    wallspeed = 1
                else
                    movespeed = wallspeed
                state = states.climbwall
            }
        }
    }
    if ((sprite_index == spr_rolljump || sprite_index == spr_spinkf) && (!grounded))
    {
        if ((!key_jump2) && poundbuffer == 0 && jumpstop == 0 && vsp < 0.5)
        {
            vsp /= 20
            jumpstop = 1
        }
        if key_down
            vsp += 1.5
        if doSnapjump()
            return 0;
        if (key_jump && key_down)
        {
            input_buffer_down = 0
            sprite_index = spr_bombdive
            image_index = 0
            state = states.freefall
            dir = xscale
            vsp = -6
            return;
        }
        if (input_buffer_slap > 0 && shotgunAnim == 0 && (!global.pistol))
        {
            if key_up
            {
                input_buffer_slap = 0
                state = states.punch
                image_index = 0
                sprite_index = spr_breakdanceuppercut
                fmod_event_instance_play(snd_uppercut)
                if ispeppino
                    vsp = -10
                else
                    vsp = -21
                movespeed = hsp
                particle_set_scale(states.grabbed, xscale, 1)
                create_particle(x, y, states.grabbed, 0)
            }
            else
            {
                input_buffer_slap = 0
                sprite_index = spr_suplexdash
                suplexmove = 1
                fmod_event_instance_play(suplexdashsnd)
                particle_set_scale(states.tumble, xscale, 1)
                create_particle(x, y, states.tumble, 0)
                state = states.handstandjump
                if (movespeed < 5)
                    movespeed = 5
                image_index = 0
            }
        }
        else if (input_buffer_shoot > 0 && sprite_index != spr_dashpadmach && sprite_index != spr_machsplit)
        {
            if shotgunAnim
                scr_shotgunshoot()
            else if global.pistol
                scr_pistolshoot(states.mach3)
        }
        if ((!grounded) && (place_meeting((x + xscale), y, obj_solid) || place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))))
        {
            _climb = 1
            if (!ispeppino)
                _climb = ledge_bump(40, (abs(hsp) + 1))
            if _climb
            {
                if key_down
                {
                    wallspeed = (-movespeed)
                    grabclimbbuffer = 0
                    state = states.climbwall
                    return;
                }
                else
                {
                    wallspeed = movespeed
                    grabclimbbuffer = 0
                    if (movespeed < 1)
                        wallspeed = 1
                    else
                        movespeed = wallspeed
                    state = states.climbwall
                }
            }
        }
        scr_dotaunt()
        return 0;
    }
    if (poundbuffer > 0)
    {
        poundbuffer--
        return 0;
    }
    return 1;
}

function scr_doniSnapjump() //gml_Script_scr_doniSnapjump
{
    if ((sprite_index == spr_snapjumpstart || /*sprite_index == spr_dos_dragonsnap || sprite_index == spr_player_snapcut ||*/ sprite_index == spr_snapjump || sprite_index == spr_snapjumpinter || sprite_index == spr_snaphighjump) && ispeppino)
    {
        mask_index = spr_player_mask
        var init = ((sprite_index == spr_snapjumpstart || sprite_index == spr_snaphighjump) && image_index < 2)
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
                    sprite_index = spr_snaphighjump
                    image_index = 0
                    vsp = -22
                }
            }
        }
        if ((!grounded) && (!key_down) && (key_slap2 || key_shoot2) && (place_meeting((x + xscale), y, obj_solid) || scr_solid_slope((x + xscale), y)) && (!(place_meeting((x + xscale), y, obj_destructibles))) && (!(place_meeting((x + xscale), y, obj_metalblock))))
        {
            input_buffer_slap = 0
            if (movespeed < 12 && snapjumps < 2)
                wallspeed = 9
            else if (snapjumps >= 2 && movespeed < 12)
                wallspeed = 14
            else
                wallspeed = movespeed
            grabclimbbuffer = 10
            state = states.climbwall
            snapjumps = 0
            return 0;
        }
        if (key_slap2 || key_shoot2)
        {
            if (!key_down)
            {
                if ((!grounded) && (place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))))
                {
                    _climb = 1
                    if (!ispeppino)
                        _climb = ledge_bump(40, (abs(hsp) + 1))
                    if _climb
                    {
                        if key_down
                        {
                            wallspeed = (-movespeed)
                            grabclimbbuffer = 0
                            state = states.climbwall
                            return;
                        }
                        else
                        {
                            wallspeed = movespeed
                            grabclimbbuffer = 0
                            if (movespeed < 1)
                                wallspeed = 1
                            else
                                movespeed = wallspeed
                            state = states.climbwall
                        }
                    }
                }
                else
                {
                    image_speed = 0.35
                    input_buffer_slap = 0
                    input_buffer_chaos = -1
                    fmod_event_one_shot_3d("event:/sfx/playerN/balloonflap", x, y)
                    sprite_index = spr_machsplit
                    state = states.mach3
                    vsp = -5
                    particle_set_scale(states.tumble, xscale, 1)
                    create_particle(x, y, states.tumble, 0)
                    fmod_event_instance_play(rollgetupsnd)
                    if (movespeed >= 9)
                    {
                        with (instance_create(x, y, obj_crazyrunothereffect))
                            image_xscale = other.xscale
                    }
                    else
                    {
                        switch snapjumps
                        {
                            case 0:
                                movespeed = 8
                                break
                            case 1:
                                movespeed = 12
                                break
                            case 2:
                                movespeed = 16
                                break
                            default:
                                with (instance_create(x, y, obj_crazyrunothereffect))
                                    image_xscale = other.xscale
                                movespeed = 21.5
                                break
                        }

                    }
                    if (movespeed < 21.5)
                    {
                        if (movespeed < 12)
                            movespeed = 12
                        else if (movespeed < 16)
                            movespeed = 16
                        else if (movespeed < 21)
                            movespeed = 21.5
                    }
                    hsp = movespeed * xscale
                    image_index = 0
                    snapjumps = 0
                    var s = 0
                    if (movespeed < 16)
                        s = 1
                    else if (movespeed < 21)
                        s = 2
                    else if (movespeed < 30)
                        s = 3
                    if ((!mach5) && s != machengineprev)
                    {
                        fmod_event_instance_set_paused(machenginesnd, 0)
                        fmod_event_instance_play(machenginesnd)
                        fmod_event_instance_set_parameter(machenginesnd, "state", s, 1)
                        machengineprev = s
                    }
                }
            }
            else
            {
                input_buffer_slap = 0
                input_buffer_chaos = -1
                drillexitspd = movespeed
                sprite_index = spr_machdrill
                hsp = 0
                freefallsmash = 13
                movespeed = 0
                vsp = 20
                state = states.freefall
            }
            return 0;
        } /*
        else if (input_buffer_slap > 0 && sprite_index != spr_player_snapcut && key_up)
        {
            input_buffer_slap = 0
            image_index = 0
            sprite_index = spr_player_snapcut
            fmod_event_instance_play(snd_uppercut)
            vsp = -14
            particle_set_scale(states.grabbed, xscale, 1)
            create_particle(x, y, states.grabbed, 0)
        }
		*/
        move = key_right + key_left
        if (key_down && poundbuffer == 0)
            vsp += 1
        if (move != 0)
            xscale = move
        if ((!key_jump2) && (!key_slap) && vsp < 0.5 && jumpstop == 0)
        {
            if (poundbuffer == 0)
                vsp /= 20
            else
                vsp /= 2
            jumpstop = 1
        }
        if ((move != sign(hsp) || abs(hsp) <= 8.5 || snaphold) /*&& sprite_index != spr_dos_dragonsnap*/)
        {
            snaphold = 1
            hsp = Approach(hsp, (move * (8.5 + snapjumps * 0.5)), 2)
        }
        else if (move != 0 /*|| sprite_index == spr_dos_dragonsnap*/)
            hsp = Approach(hsp, (move * movespeed), 2)
        else
            hsp = Approach(hsp, 0, 0.25)
        if (poundbuffer > 0)
            poundbuffer--
        if (punch_afterimage > 0)
            punch_afterimage--
        else
            punch_afterimage = 6
        if ((punch_afterimage % 2) == 0)
        {
            with (create_blur_afterimage(x, y, sprite_index, image_index, xscale))
            {
                image_xscale = other.xscale
                playerid = other.id
                vertical = 1
            }
        }
        if (snapjumps < 1 && movespeed < 12)
            image_speed = 0.35
        else if (snapjumps > 1 || movespeed >= 12 || (/*sprite_index == spr_player_snapcut &&*/ vsp < 0))
        {
            if (punch_afterimage == 6)
            {
                with (create_mach3effect(x, y, sprite_index, image_index))
                {
                    image_xscale = other.xscale
                    playerid = other.id
                }
                instance_create((x + (random_range(5, -5))), (y + (random_range(20, -20))), obj_tornadoeffect)
            }
            if (snapjumps > 2 || movespeed >= 16)
                image_speed = 0.7
            else
                image_speed = 0.45
        }
        if (vsp > 4 && key_down)
            image_speed = 1
        if (floor(image_index) == (image_number - 1) && (sprite_index == spr_snapjumpstart || sprite_index == spr_snaphighjump))
        {
            sprite_index = spr_snapjumpinter
            image_index = 0
        }
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_snapjumpinter)
        {
            sprite_index = spr_snapjump
            image_index = 7
        }
        if (grounded && vsp >= 0 && image_index > 1)
        {
            jumpstop = 0
            if ((!key_attack) && move == 0)
            {
                landAnim = 0
                hsp = 0
                movespeed = 0
                state = states.normal
                image_index = 0
                sprite_index = spr_snapnailit
                snapjumps = 0
                return;
            }
            if (input_buffer_jump < 30 && input_buffer_jump != 0)
            {
                fmod_event_one_shot_3d("event:/sfx/misc/mushroombounce", x, y)
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
                if (movespeed >= 9 && movespeed < 21.5)
                {
                    if (movespeed < 16)
                        movespeed += 4
                    else
                        movespeed += 8
                    if (movespeed > 21.5)
                        movespeed = 21.5
                }
                sprite_index = spr_snaphighjump
                image_index = 0
                vsp = -15
            }
            else
            {
                var machExit = 0
                var fw = (place_meeting((x + xscale), y, obj_solid) || place_meeting((x + hsp), y, obj_solid))
                var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)
                var metal = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_metalblock, 0, 1)
                if ((fw && (movespeed >= 9 || snapjumps > 0) && metal != -4) || place_meeting(x, (y + 1), obj_water))
                    machExit = 1
                fmod_event_instance_play(rollgetupsnd)
                if (movespeed >= 9)
                {
                    sprite_index = spr_machroll
                    flash = 1
                    if (movespeed < 27)
                        hsp += (2.5 * xscale)
                    if (movespeed >= 9 && machExit)
                    {
                        state = states.mach3
                        sprite_index = spr_mach4
                    }
                    else if (!key_down)
                    {
                        state = states.mach2
                        sprite_index = spr_mach
                    }
                    else if machExit
                    {
                        state = states.mach3
                        sprite_index = spr_mach4
                    }
                    else
                        state = states.tumble
                    with (instance_create(x, y, obj_crazyrunothereffect))
                        image_xscale = other.xscale
                }
                else
                {
                    switch snapjumps
                    {
                        case 0:
                            if machExit
                            {
                                state = states.mach2
                                sprite_index = spr_mach
                            }
                            else
                            {
                                state = states.tumble
                                sprite_index = spr_machroll
                            }
                            movespeed = 9
                            break
                        case 1:
                            if machExit
                            {
                                state = states.mach3
                                sprite_index = spr_mach4
                            }
                            else
                            {
                                state = states.tumble
                                sprite_index = spr_machroll
                            }
                            flash = 1
                            movespeed = 12
                            break
                        case 2:
                            if machExit
                            {
                                sprite_index = spr_crazyrun
                                state = states.mach3
								mach4mode = 1
                            }
                            else
                            {
                                state = states.tumble
                                sprite_index = spr_machroll
                            }
                            flash = 1
                            with (instance_create(x, y, obj_crazyrunothereffect))
                                image_xscale = other.xscale
                            movespeed = 16
                            break
                        default:
                            if machExit
                            {
                                sprite_index = spr_crazyrun
                                state = states.mach3
                            }
                            else
                            {
                                state = states.tumble
                                sprite_index = spr_machroll
                            }
                            flash = 1
                            with (instance_create(x, y, obj_crazyrunothereffect))
                                image_xscale = other.xscale
                            movespeed = 21.5
                            break
                    }

                    hsp = movespeed * xscale
                }
                snapjumps = 0
                return 0;
            }
            GamepadSetVibration(0, 0.5, 0.5, 0.5)
        }
        scr_dotaunt()
        return 0;
    }
    return 1;
}