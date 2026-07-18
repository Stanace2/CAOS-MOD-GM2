#states
All of these are "managed" by controllers inside the movement scripts of the player [[Moveset controllers]]
## Behaviour scripts
### scr_fakeDoniMoveset
These both go inside the same script
#### Mach3 changes
Referenced in [[#scr_dos_mach3()]]
~~~js
function scr_fakeDoniMoveset() //gml_Script_scr_fakeDoniMoveset  
{  
    if (sprite_index == spr_player_poundcancelstart && floor(image_index) < 4)  
        vsp = 0.5  
    if (grounded && input_buffer_jump < 30 && input_buffer_jump != 0 && vsp > -0.5 && (sprite_index == spr_player_poundcancel || sprite_index == spr_player_poundcancelstart || sprite_index == spr_player_spinkf))  
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
        sprite_index = spr_player_snaphighjump  
        vsp = -15  
        jumpstop = 0  
        state = (306 << 0)  
        image_index = 0  
        return;  
    }  
    if (move != xscale && move != 0 && (sprite_index == spr_player_poundcancel || sprite_index == spr_player_poundcancelstart))  
    {  
        fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
        sprite_index = spr_player_poundaircancel  
        image_index = 0  
        jumpAnim = 1  
        grav = 0.5  
        state = (92 << 0)  
        return 0;  
    }  
    if ((!grounded) && (sprite_index == spr_player_poundcancel || sprite_index == spr_player_poundcancelstart) && (key_down2 || (key_shoot2 && (!dragonsnap))))  
    {  
        drillexitspd = movespeed  
        sprite_index = spr_player_poundcanceldive  
        hsp = 0  
        freefallsmash = 13  
        movespeed = 0  
        vsp = 20  
        state = (108 << 0)  
        return 0;  
    }  
    if ((sprite_index == spr_player_rolljump || sprite_index == spr_mach3hit) && ispeppino && (!grounded) && hsp == 0)  
    {  
        hsp = movespeed * xscale  
        image_speed = 0.8  
        sprite_index = spr_player_rolljump  
    }  
    if (!((global.caoschase && global.ikframes && (!global.iexception))))  
    {  
        if (punch_afterimage > 0)  
            punch_afterimage--  
        else  
        {  
            punch_afterimage = 5  
            with (create_mach3effect(x, y, sprite_index, image_index, 1))  
            {  
                image_xscale = other.xscale  
                playerid = other.id  
            }  
        }  
    }  
    if (grounded && poundbuffer < 13)  
        poundbuffer = 0  
    if ((!grounded) && (sprite_index == spr_player_poundcancel || sprite_index == spr_player_poundcancelstart) && (place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))))  
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
                state = (37 << 0)  
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
                state = (37 << 0)  
            }  
        }  
    }  
    if ((sprite_index == spr_player_rolljump || sprite_index == spr_player_spinkf) && (!grounded))  
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
            sprite_index = spr_player_poundcancel1  
            image_index = 0  
            state = (108 << 0)  
            dir = xscale  
            vsp = -6  
            return;  
        }  
        if (input_buffer_slap > 0 && shotgunAnim == 0 && (!global.pistol))  
        {  
            if key_up  
            {  
                input_buffer_slap = 0  
                state = (80 << 0)  
                image_index = 0  
                sprite_index = spr_breakdanceuppercut  
                fmod_event_instance_play(snd_uppercut)  
                if ispeppino  
                    vsp = -10  
                else  
                    vsp = -21  
                movespeed = hsp  
                particle_set_scale((4 << 0), xscale, 1)  
                create_particle(x, y, (4 << 0), 0)  
            }  
            else  
            {  
                input_buffer_slap = 0  
                sprite_index = spr_suplexdash  
                suplexmove = 1  
                fmod_event_instance_play(suplexdashsnd)  
                particle_set_scale((5 << 0), xscale, 1)  
                create_particle(x, y, (5 << 0), 0)  
                state = (42 << 0)  
                if (movespeed < 5)  
                    movespeed = 5  
                image_index = 0  
            }  
        }  
        else if (input_buffer_shoot > 0 && sprite_index != spr_dashpadmach && sprite_index != spr_player_poundcancelstart)  
        {  
            if shotgunAnim  
                scr_shotgunshoot()  
            else if global.pistol  
                scr_pistolshoot((121 << 0))  
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
                    state = (37 << 0)  
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
                    state = (37 << 0)  
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
~~~
#### Noise's "machCancel"
[[Moveset controllers#scr_playerN_machcancel()]]
~~~js
function scr_doniFakeSnapjump() //gml_Script_scr_doniFakeSnapjump  
{  
    if ((sprite_index == spr_player_snapjumpstart || sprite_index == spr_dos_dragonsnap || sprite_index == spr_player_snapcut || sprite_index == spr_player_snapjump || sprite_index == spr_player_snapjumpinter || sprite_index == spr_player_snaphighjump) && ispeppino)  
    {  
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
            state = (37 << 0)  
            snapjumps = 0  
            return 0;  
        }  
        if (key_slap2 || key_shoot2)  
        {  
            input_buffer_slap = 0  
            input_buffer_chaos = -1  
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
                            state = (37 << 0)  
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
                            state = (37 << 0)  
                        }  
                    }  
                }  
                else  
                {  
                    image_speed = 0.35  
                    fmod_event_one_shot_3d("event:/sfx/playerN/balloonflap", x, y)  
                    sprite_index = spr_player_poundcancelstart  
                    state = (121 << 0)  
                    vsp = -5  
                    particle_set_scale((5 << 0), xscale, 1)  
                    create_particle(x, y, (5 << 0), 0)  
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
                                movespeed = 24  
                                break  
                        }  
  
                    }  
                    if (movespeed < 24)  
                    {  
                        if (movespeed < 12)  
                            movespeed = 12  
                        else if (movespeed < 16)  
                            movespeed = 16  
                        else if (movespeed < 21)  
                            movespeed = 24  
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
                sprite_index = spr_player_poundcanceldive  
                hsp = 0  
                freefallsmash = 13  
                movespeed = 0  
                vsp = 20  
                state = (108 << 0)  
            }  
            return 0;  
        }  
        else if (input_buffer_slap > 0 && sprite_index != spr_player_snapcut && key_up)  
        {  
            input_buffer_slap = 0  
            image_index = 0  
            sprite_index = spr_player_snapcut  
            fmod_event_instance_play(snd_uppercut)  
            vsp = -14  
            particle_set_scale((4 << 0), xscale, 1)  
            create_particle(x, y, (4 << 0), 0)  
        }  
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
        if ((move != sign(hsp) || abs(hsp) <= 8.5 || snaphold) && sprite_index != spr_dos_dragonsnap)  
        {  
            snaphold = 1  
            hsp = Approach(hsp, (move * (8.5 + snapjumps * 0.5)), 2)  
        }  
        else if (move != 0 || sprite_index == spr_dos_dragonsnap)  
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
        else if (snapjumps > 1 || movespeed >= 12 || (sprite_index == spr_player_snapcut && vsp < 0))  
        {  
            if (punch_afterimage == 6)  
            {  
                with (create_mach3effect(x, y, sprite_index, (image_index - 1)))  
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
        if (floor(image_index) == (image_number - 1) && (sprite_index == spr_player_snapjumpstart || sprite_index == spr_player_snaphighjump))  
        {  
            sprite_index = spr_player_snapjumpinter  
            image_index = 0  
        }  
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_snapjumpinter)  
        {  
            sprite_index = spr_player_snapjump  
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
                state = (0 << 0)  
                image_index = 0  
                sprite_index = spr_player_snapnailit  
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
                if (movespeed >= 9 && movespeed < 24)  
                {  
                    if (movespeed < 16)  
                        movespeed += 4  
                    else  
                        movespeed += 8  
                    if (movespeed > 24)  
                        movespeed = 24  
                }  
                sprite_index = spr_player_snaphighjump  
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
                        state = (121 << 0)  
                        sprite_index = spr_mach4  
                    }  
                    else if (!key_down)  
                    {  
                        state = (104 << 0)  
                        sprite_index = spr_mach  
                    }  
                    else if machExit  
                    {  
                        state = (121 << 0)  
                        sprite_index = spr_mach4  
                    }  
                    else  
                        state = (5 << 0)  
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
                                state = (104 << 0)  
                                sprite_index = spr_mach  
                            }  
                            else  
                            {  
                                state = (5 << 0)  
                                sprite_index = spr_machroll  
                            }  
                            movespeed = 9  
                            break  
                        case 1:  
                            if machExit  
                            {  
                                state = (121 << 0)  
                                sprite_index = spr_mach4  
                            }  
                            else  
                            {  
                                state = (5 << 0)  
                                sprite_index = spr_machroll  
                            }  
                            flash = 1  
                            movespeed = 12  
                            break  
                        case 2:  
                            if machExit  
                            {  
                                sprite_index = spr_crazyrun  
                                state = (121 << 0)  
                            }  
                            else  
                            {  
                                state = (5 << 0)  
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
                                state = (121 << 0)  
                            }  
                            else  
                            {  
                                state = (5 << 0)  
                                sprite_index = spr_machroll  
                            }  
                            flash = 1  
                            with (instance_create(x, y, obj_crazyrunothereffect))  
                                image_xscale = other.xscale  
                            movespeed = 24  
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
~~~
### scr_fakeclimboutchecker()
Function to help the player climbout cleanly
~~~js
function scr_fakeclimboutchecker(argument0, argument1, argument2) 
{  
    while (!(scr_solid((x + xscale), y)))  
    {  
        if (wallspeed >= 0)  
        {  
            argument0++  
            y++  
            if scr_solid((x + xscale), y)  
            {  
                y--  
                break  
            }  
            else if (argument0 > 40)  
            {  
                x = argument1  
                y = argument2  
                break  
            }  
            else  
                continue  
        }  
        else  
        {  
            argument0++  
            y--  
            if scr_solid((x + xscale), y)  
            {  
                y++  
                break  
            }  
            else if (argument0 > 40)  
            {  
                x = argument1  
                y = argument2  
                break  
            }  
            else  
                continue  
        }  
    }  
}
~~~
[^1]: argument0 : *start point* | num
[^2]: argument1 : *initial x* | num
[^3]: argument2 : *initial y* | num
### scr_fdos_climbwall()
[[Moveset controllers#scr_player_climbwall()]]
~~~js
function scr_fdos_climbwall() //gml_Script_scr_fdos_climbwall  
{  
    var climbdir = 1  
    var exitspeed = 0.7  
    var mach5exit = 21.5  
    var mach5limit = 21  
    if (characterID == 10)  
    {  
        mach5exit = 24  
        mach5limit = 22  
    }  
    move = key_left + key_right  
    if (wallclimbbuffer > 0)  
        wallclimbbuffer--  
    switch character  
    {  
        case "P":  
            if doSnapjump()  
                return;  
            if (sprite_index == spr_dos_walllaunch)  
            {  
                if (floor(image_index) == (image_number - 1))  
                {  
                    sprite_index = spr_machclimbwall  
                    image_index = 0  
                }  
            }  
            else  
            {  
                if (key_down && wallspeed >= 0)  
                {  
                    fmod_event_instance_play(snd_crouchslide)  
                    wallspeed *= -1  
                    with (instance_create(x, (y - 16), obj_parryeffect))  
                        sprite_index = spr_knightpep_downcloud  
                }  
                if (grounded && scr_slope() && wallspeed < 0)  
                {  
                    with (instance_place(x, (y + 1), obj_slope))  
                    {  
                        other.xscale = (-sign(image_xscale))  
                        other.state = (5 << 0)  
                        other.sprite_index = other.spr_machroll  
                        other.movespeed = (-other.wallspeed)  
                        if (other.movespeed > 18 && other.movespeed < mach5limit)  
                            other.movespeed = 18  
                        if (other.movespeed >= mach5limit)  
                            other.movespeed = mach5exit  
                        with (instance_create(other.x, other.y, obj_jumpdust))  
                            image_xscale = (-sign(other.image_xscale))  
                        return;  
                    }  
                }  
            }  
            if (grounded && wallclimbbuffer == 0 && ispeppino && (!scr_slope()) && wallspeed < 0 && (!(place_meeting(x, (y + 1), obj_destructibles))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (place_meeting(x, (y + 1), obj_solid) || place_meeting(x, (y + 1), obj_platform)))  
            {  
                var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)  
                var dx = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)  
                if (gap == 4 || gap == -4 || (dx != -4 && dx != 4))  
                {  
                    mask_index = spr_crouchmask  
                    state = (5 << 0)  
                    sprite_index = spr_machroll  
                    image_index = 0  
                    fmod_event_instance_play(snd_dive)  
                    movespeed = (-wallspeed)  
                }  
                else  
                {  
                    trace("climbwall hit ass")  
                    xscale *= -1  
                    image_index = 0  
                    state = (121 << 0)  
                }  
                return;  
            }  
            with (obj_destructibles)  
            {  
                if (place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y - 1), other))  
                    instance_destroy()  
            }  
            if (wallspeed < 0)  
                climbdir = -1  
            else  
                climbdir = 1  
            if (windingAnim < 200)  
                windingAnim++  
            suplexmove = 0  
            vsp = (-wallspeed)  
            if (abs(wallspeed) < 20)  
            {  
                if (climbdir == 1)  
                    wallspeed += (0.09 * climbdir)  
                else  
                    wallspeed += (0.2 * climbdir)  
            }  
            crouchslideAnim = 1  
            if (sprite_index != spr_dos_walllaunch)  
            {  
                if (vsp < 0)  
                    sprite_index = spr_machclimbwall  
                else  
                    sprite_index = spr_player_wallslide  
            }  
            if skateboarding  
            {  
                if (wallspeed < 0)  
                    wallspeed = 6  
                sprite_index = spr_player_clownwallclimb  
                if (!ispeppino)  
                    sprite_index = spr_playerN_clownwallclimb  
            }  
            if (grabclimbbuffer > 0)  
                grabclimbbuffer--  
            if ((!key_attack) && (!skateboarding) && grabclimbbuffer == 0)  
            {  
                state = (0 << 0)  
                movespeed = 0  
                railmovespeed = 6  
                raildir = (-xscale)  
            }  
            if (wallclimbbuffer > 0)  
                return;  
            if (verticalbuffer <= 0 && (!(scr_solid((x + xscale), y))) && (!(place_meeting(x, y, obj_verticalhallway))) && (!(place_meeting(x, (y - 12), obj_verticalhallway))))  
            {  
                input_buffer_chaos = -1  
                trace("climbwall out")  
                instance_create(x, y, obj_jumpdust)  
                vsp = 0  
                var old_x = x  
                var old_y = y  
                var i = 0  
                scr_fakeclimboutchecker(i, old_x, old_y)  
                if (wallspeed >= 0)  
                    fakeceilingrun = 0  
                else  
                {  
                    fakeceilingrun = 1  
                    wallspeed *= -1  
                }  
                if ((wallspeed >= 0 && wallspeed < 12) || skateboarding)  
                {  
                    state = (104 << 0)  
                    movespeed = wallspeed  
                }  
                else if (wallspeed >= 12)  
                {  
                    state = (121 << 0)  
                    sprite_index = spr_mach4  
                    movespeed = wallspeed  
                }  
                hsp = xscale  
                return;  
            }  
            if (wallspeed < 0 && place_meeting(x, (y + 12), obj_solid) && xscale == 2)  
                wallspeed = 0  
            if ((!ispeppino) && (!skateboarding))  
            {  
                with (instance_create(x, y, obj_noiseeffect))  
                    sprite_index = spr_noisewalljumpeffect  
                sprite_index = spr_playerN_wallbounce  
                state = (306 << 0)  
                savedmove = xscale  
                vsp = (-((17 * (1 - noisewalljump * 0.15))))  
                noisewalljump++  
                hsp = 0  
                movespeed = 0  
                image_index = 0  
            }  
            if (input_buffer_jump > 8 && ispeppino && sprite_index != spr_dos_walllaunch)  
            {  
                if (wallspeed >= 0)  
                {  
                    fmod_event_one_shot_3d("event:/sfx/pep/jump", x, y)  
                    input_buffer_jump = 0  
                    key_jump = 0  
                    movespeed = 10  
                    railmovespeed = 0  
                    state = (104 << 0)  
                    image_index = 0  
                    sprite_index = spr_walljumpstart  
                    if skateboarding  
                        sprite_index = spr_clownjump  
                    vsp = -11  
                    xscale *= -1  
                    jumpstop = 0  
                    walljumpbuffer = 4  
                }  
                else  
                {  
                    flash = 1  
                    create_particle(x, y, (9 << 0))  
                    canrollsnd = 1  
                    fmod_event_one_shot_3d("event:/sfx/pep/jump", x, y)  
                    input_buffer_jump = 0  
                    xscale *= -1  
                    state = (5 << 0)  
                    image_index = 0  
                    sprite_index = spr_dive  
                    vsp = 10  
                    movespeed = abs(wallspeed)  
                    if (movespeed > 17 && movespeed < mach5limit)  
                        movespeed = 16  
                    if (movespeed >= mach5limit)  
                        movespeed = mach5exit  
                    walljumpbuffer = 4  
                }  
            }  
            if (state != (104 << 0) && (!fakeceilingrun) && verticalbuffer <= 0 && place_meeting(x, (y - 1), obj_solid) && scr_solid((x + xscale), y) && (!(place_meeting(x, (y - 1), obj_verticalhallway))) && (!(place_meeting(x, (y - 1), obj_destructibles))) && ((!(place_meeting((x + sign(hsp)), y, obj_slope))) || scr_solid_slope((x + sign(hsp)), y)) && (!(place_meeting((x - sign(hsp)), y, obj_slope))))  
            {  
                trace("climbwall hit head")  
                fakeceilingrun = 1  
                xscale *= -1  
                image_index = 0  
                state = (121 << 0)  
            }  
            image_speed = 0.6  
            if (steppybuffer > 0)  
                steppybuffer--  
            else  
            {  
                create_particle((x + xscale * 10), (y + 43), (1 << 0), 0)  
                steppybuffer = 10  
            }  
            break  
    }  
  
}
~~~
### scr_fdos_mach3()
[[Moveset controllers#scr_player_mach3()]]
~~~js
function scr_fdos_mach3() //gml_Script_scr_fdos_mach3  
{  
    if (!scr_fakeDoniMoveset())  
        return;  
    if (sprite_index == spr_fightball)  
    {  
        scr_player_fightball()  
        return;  
    }  
    if fakeceilingrun  
        vsp = 0  
    switch character  
    {  
        case "P":  
            var slopeaccel = 0.1  
            var slopedeccel = 0.2  
            var speedcap = 27  
            var mach4movespeed = 24  
            var mach3movespeed = 16  
            var accel = 0.03  
            var capaccel = 0.01  
            var mach4accel = 0.1  
            var jumpspeed = -11  
            var machrollspeed = 10  
            var mach3_spr = spr_mach4  
            if (global.swapmode && key_attack && key_fightball && (!instance_exists(obj_swapmodegrab)) && (!instance_exists(obj_swapdeatheffect)) && (!instance_exists(obj_noiseanimatroniceffect)) && obj_swapmodefollow.animatronic <= 0)  
            {  
                sprite_index = spr_fightball  
                jump_p2 = 0  
                if noisecrusher  
                    instance_create_unique(x, y, 158)  
                return;  
            }  
            if (windingAnim < 2000)  
                windingAnim++  
            if place_meeting(x, (y + 1), obj_railparent)  
            {  
                var _railinst = instance_place(x, (y + 1), obj_railparent)  
                railmovespeed = _railinst.movespeed  
                raildir = _railinst.dir  
            }  
            hsp = xscale * movespeed + railmovespeed * raildir  
            if grounded  
            {  
                if (scr_slope() && hsp != 0 && movespeed > 10 && movespeed < 18)  
                    scr_player_addslopemomentum(slopeaccel, slopedeccel)  
            }  
            if (move == xscale && (grounded || ceilinded))  
            {  
                if (movespeed < 16)  
                    movespeed += accel  
                else if (movespeed < 20)  
                    movespeed += mach4accel  
            }  
            if ((!key_jump2) && jumpstop == 0 && vsp < 0.5)  
            {  
                vsp /= 20  
                jumpstop = 1  
            }  
            if (grounded && sprite_index == spr_playerN_skateboarddoublejump)  
            {  
                sprite_index = mach3_spr  
                fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)  
            }  
            mach2 = 100  
            momemtum = 1  
            move = key_right + key_left  
            move2 = key_right2 + key_left2  
            if (fightball == 1 && global.coop == 1)  
            {  
                if (object_index == obj_player1)  
                {  
                    x = obj_player2.x  
                    y = obj_player2.y  
                }  
                if (object_index == obj_player2)  
                {  
                    x = obj_player1.x  
                    y = obj_player1.y  
                }  
            }  
            if (sprite_index == spr_crazyrun)  
            {  
                if (flamecloud_buffer > 0)  
                    flamecloud_buffer--  
                else  
                {  
                    flamecloud_buffer = 10  
                    with (instance_create(x, y, obj_dashcloud))  
                    {  
                        image_xscale = other.xscale  
                        sprite_index = spr_flamecloud  
                    }  
                }  
            }  
            if (sprite_index == spr_dos_unhingedrun)  
            {  
                if (flamecloud_buffer > 0)  
                    flamecloud_buffer--  
                else  
                {  
                    flamecloud_buffer = 5  
                    with (instance_create(x, y, obj_dashcloud))  
                    {  
                        image_xscale = other.xscale  
                        sprite_index = spr_flamecloud  
                    }  
                }  
            }  
            crouchslideAnim = 1  
            if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_poundcancelstart)  
                sprite_index = spr_player_poundcancel  
            if (floor(image_index) == (image_number - 1) && sprite_index == spr_playerN_skateboarddoublejump)  
                image_index = image_number - 3  
            if (sprite_index == spr_playerN_skateboarddoublejump && grounded && vsp > 0)  
                sprite_index = mach3_spr  
            if ((grounded || ceilinded) && vsp > 0)  
                jumpstop = 0  
            if (input_buffer_jump > 0 && sprite_index != spr_mach3jump && can_jump && (!((move == 1 && xscale == -1))) && (!((move == -1 && xscale == 1))))  
            {  
                input_buffer_jump = 0  
                scr_fmod_soundeffect(jumpsnd, x, y)  
                particle_set_scale((5 << 0), xscale, 1)  
                create_particle(x, y, (5 << 0), 0)  
                if (sprite_index != spr_fightball && sprite_index != spr_crazyrun && sprite_index != spr_dos_unhingedrun)  
                {  
                    image_index = 0  
                    sprite_index = spr_mach3jump  
                }  
                if (sprite_index == spr_crazyrun && ispeppino)  
                {  
                    mach4mode = 1  
                    image_index = 0  
                    sprite_index = spr_player_rolljump  
                }  
                if (character == "P")  
                    vsp = jumpspeed  
                else  
                    vsp = -13  
            }  
            if (input_buffer_jump > 0 && (!can_jump) && key_up && (!ispeppino) && character == "P" && noisedoublejump)  
                scr_player_do_noisecrusher()  
            if (fightball == 0)  
            {  
                if (mach4mode && (!grounded) && (!ceilinded) && sprite_index != spr_dos_unhingedrun && sprite_index != spr_player_spinkf && sprite_index != spr_player_poundcancel && sprite_index != spr_player_poundcancelstart && ispeppino)  
                    sprite_index = spr_player_rolljump  
                if (sprite_index == spr_mach3jump && floor(image_index) == (image_number - 1))  
                    sprite_index = mach3_spr  
                if (sprite_index == spr_player_Sjumpcancel && grounded)  
                    sprite_index = mach3_spr  
                if ((sprite_index == spr_player_poundcancel || sprite_index == spr_player_spinkf) && grounded)  
                {  
                    flash = 1  
                    sprite_index = spr_rollgetup  
                    image_index = 0  
                }  
                if (floor(image_index) == (image_number - 1) && (sprite_index == spr_player_rollgetupALT || sprite_index == spr_rollgetup || sprite_index == spr_mach3hit || sprite_index == spr_dashpadmach))  
                    sprite_index = mach3_spr  
                if (sprite_index == spr_player_rolljump && grounded && vsp > 0 && movespeed <= mach3movespeed)  
                {  
                    flash = 1  
                    sprite_index = mach3_spr  
                }  
                if (sprite_index == spr_playerN_sidewayspin && floor(image_index) == (image_number - 1))  
                    sprite_index = spr_playerN_sidewayspinend  
                if (grounded && (sprite_index == spr_playerN_sidewayspin || sprite_index == spr_playerN_sidewayspinend))  
                    sprite_index = mach3_spr  
                if ((movespeed > mach3movespeed && sprite_index != spr_dos_unhingedrun && sprite_index != spr_crazyrun && sprite_index != spr_player_Sjumpcancelstart && sprite_index != spr_player_spinkf && sprite_index != spr_player_poundcancel && sprite_index != spr_player_poundcancelstart && sprite_index != spr_taunt && sprite_index != spr_player_rolljump) || (sprite_index == spr_player_rolljump && (grounded || ceilinded) && movespeed >= mach3movespeed))  
                {  
                    mach4mode = 1  
                    flash = 1  
                    sprite_index = spr_crazyrun  
                }  
                else if (movespeed <= mach3movespeed && (sprite_index == spr_crazyrun || sprite_index == spr_dos_unhingedrun))  
                    sprite_index = mach3_spr  
                if (movespeed >= mach4movespeed && (grounded || ceilinded) && sprite_index != spr_dos_unhingedrun)  
                {  
                    if (!mach5)  
                    {  
                        mach5 = 1  
                        if (!mach5buffer)  
                            fmod_event_one_shot("event:/chaos-sfx/donisha/mach5Horn")  
                        mach5buffer = 1  
                    }  
                    sprite_index = spr_dos_unhingedrun  
                    flash = 1  
                }  
            }  
            if ((sprite_index == spr_crazyrun || sprite_index == spr_dos_unhingedrun) && (!instance_exists(crazyruneffectid)))  
            {  
                with (instance_create(x, y, obj_crazyrunothereffect))  
                {  
                    playerid = other.object_index  
                    other.crazyruneffectid = id  
                }  
            }  
            if (sprite_index == mach3_spr || sprite_index == spr_fightball)  
                image_speed = 0.4  
            else if (sprite_index == spr_dos_unhingedrun)  
                image_speed = 0.4  
            else if (sprite_index == spr_crazyrun)  
                image_speed = 0.75  
            else if (sprite_index == spr_player_rollgetupALT || sprite_index == spr_rollgetup || sprite_index == spr_mach3hit || sprite_index == spr_dashpadmach)  
                image_speed = 0.4  
            if (fightball == 0 && (sprite_index != spr_dashpadmach || dropboost))  
            {  
                if doSnapjump()  
                    return;  
            }  
            if (scr_mach_check_dive() && fightball == 0 && sprite_index != spr_player_spinkf && sprite_index != spr_player_poundcancelstart && sprite_index != spr_player_poundcancel && (sprite_index != spr_dashpadmach || dropboost))  
            {  
                particle_set_scale((5 << 0), xscale, 1)  
                create_particle(x, y, (5 << 0), 0)  
                flash = 0  
                state = (5 << 0)  
                image_index = 0  
                vsp = machrollspeed  
                if ((!grounded) && ispeppino)  
                    sprite_index = spr_player_rolljump  
                else  
                    sprite_index = spr_machroll  
                if (character == "V")  
                    sprite_index = spr_playerV_divekickstart  
            }  
            if (((place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock)))) || (grounded && (place_meeting((x + sign(hsp)), (y - 16), obj_solid) || scr_solid_slope((x + sign(hsp)), (y - 16))) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))) && place_meeting(x, (y + 1), obj_slope)))  
            {  
                if ceilinded  
                    wallspeed = (-movespeed)  
                else  
                    wallspeed = movespeed  
                grabclimbbuffer = 0  
                state = (37 << 0)  
                return;  
            }  
            if (place_meeting((x + sign(hsp)), y, obj_climbablewall) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))))  
            {  
                var _climb = 1  
                if (!ispeppino)  
                    _climb = ledge_bump(40)  
                if _climb  
                {  
                    if ceilinded  
                        wallspeed = (-movespeed)  
                    else  
                        wallspeed = movespeed  
                    grabclimbbuffer = 0  
                    state = (37 << 0)  
                }  
            }  
            if (input_buffer_slap > 0 && (!key_up) && shotgunAnim == 0 && (!global.pistol) && sprite_index != spr_dashpadmach)  
            {  
                input_buffer_slap = 0  
                sprite_index = spr_suplexdash  
                suplexmove = 1  
                fmod_event_instance_play(suplexdashsnd)  
                particle_set_scale((5 << 0), xscale, 1)  
                create_particle(x, y, (5 << 0), 0)  
                state = (42 << 0)  
                if (movespeed < 5)  
                    movespeed = 5  
                image_index = 0  
            }  
            else if (input_buffer_slap > 0 && key_up && shotgunAnim == 0 && sprite_index != spr_dashpadmach && ((!global.pistol) || (!ispeppino)))  
            {  
                input_buffer_slap = 0  
                state = (80 << 0)  
                image_index = 0  
                sprite_index = spr_breakdanceuppercut  
                fmod_event_instance_play(snd_uppercut)  
                if ispeppino  
                    vsp = -10  
                else  
                    vsp = -21  
                movespeed = hsp  
                particle_set_scale((4 << 0), xscale, 1)  
                create_particle(x, y, (4 << 0), 0)  
                if (!ispeppino)  
                {  
                    repeat (4)  
                    {  
                        with (instance_create((x + (irandom_range(-40, 40))), (y + (irandom_range(-40, 40))), obj_explosioneffect))  
                        {  
                            sprite_index = spr_shineeffect  
                            image_speed = 0.35  
                        }  
                    }  
                }  
            }  
            if (input_buffer_shoot > 0 && sprite_index != spr_dashpadmach && sprite_index != spr_player_poundcancelstart)  
            {  
                if shotgunAnim  
                    scr_shotgunshoot()  
                else if global.pistol  
                    scr_pistolshoot((121 << 0))  
            }  
            break  
    }  
  
    var b = 0  
    with (obj_hamkuff)  
    {  
        if (state == (206 << 0) && playerid == other.id)  
            b = 1  
    }  
    if ((!instance_exists(dashcloudid)) && (grounded || ceilinded) && (!(place_meeting(x, (y + 1), obj_water))) && (!b))  
    {  
        with (instance_create(x, y, obj_superdashcloud))  
        {  
            if (other.fightball == 1)  
                instance_create(obj_player.x, obj_player.y, obj_slapstar)  
            image_xscale = other.xscale  
            other.dashcloudid = id  
        }  
    }  
    if ((!instance_exists(dashcloudid)) && (grounded || ceilinded) && place_meeting(x, (y + 1), obj_water) && (!b))  
    {  
        with (instance_create(x, y, obj_superdashcloud))  
        {  
            if (other.fightball == 1)  
                instance_create(obj_player.x, obj_player.y, obj_slapstar)  
            image_xscale = other.xscale  
            sprite_index = spr_watereffect  
            other.dashcloudid = id  
        }  
    }  
    scr_dotaunt()  
    if (!instance_exists(chargeeffectid))  
    {  
        with (instance_create(x, y, obj_chargeeffect))  
        {  
            playerid = other.object_index  
            other.chargeeffectid = id  
        }  
    }  
    if (sprite_index == mach3_spr || sprite_index == spr_fightball)  
        image_speed = 0.4  
    else if (sprite_index == spr_dos_unhingedrun)  
        image_speed = 0.4  
    else if (sprite_index == spr_crazyrun)  
        image_speed = 0.75  
    else if (sprite_index == spr_player_poundcancel)  
        image_speed = 0.8  
    else if (sprite_index == spr_player_rollgetupALT || sprite_index == spr_rollgetup || sprite_index == spr_mach3hit)  
        image_speed = 0.4  
    else if (sprite_index == spr_player_rolljump && movespeed >= mach3movespeed)  
        image_speed = 0.8  
    else if (sprite_index == spr_player_rolljump && movespeed < mach3movespeed)  
        image_speed = 0.6  
    else if (sprite_index == spr_player_poundcancelstart || sprite_index == spr_player_spinkf)  
        image_speed = 0.35  
    else  
        image_speed = 0.4  
    if (scr_check_superjump() && fightball == 0 && state == (121 << 0) && grounded && vsp > 0 && sprite_index != spr_dashpadmach && (!(place_meeting(x, y, obj_dashpad))))  
    {  
        sprite_index = spr_superjumpprep  
        state = (99 << 0)  
        hsp = 0  
        image_index = 0  
    }  
    if (global.attackstyle == 2 && key_slap2)  
    {  
        randomize_animations([spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, 801, 800, 797, spr_punch])  
        image_index = 0  
        state = (43 << 0)  
    }  
    if (movespeed > speedcap)  
        movespeed = speedcap  
}
~~~
## Executers
### scr_chaosmod_doSnapjump
Snapjumps inherited from Donisha [[Dos - Moveset#scr_chaosmod_doSnapjump]]