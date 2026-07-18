#states
All of these are "managed" by controllers inside the movement scripts of the player [[Moveset controllers]]
## Behaviour scripts
### scr_doniMoveset
These both go inside the same script
#### Mach3 changes
Referenced in [[#scr_dos_mach3()]]
~~~js
function scr_doniMoveset() //gml_Script_scr_doniMoveset
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
        return 0;
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
function scr_doniSnapjump() //gml_Script_scr_doniSnapjump
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
                    input_buffer_slap = 0
                    input_buffer_chaos = -1
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
                if (movespeed >= 9 && movespeed < 21.5)
                {
                    if (movespeed < 16)
                        movespeed += 4
                    else
                        movespeed += 8
                    if (movespeed > 21.5)
                        movespeed = 21.5
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
~~~
### scr_climboutchecker()
Function to help the player climbout cleanly
~~~js
function scr_climboutchecker(argument0, argument1, argument2) 
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
                y += 10  
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
### scr_dos_climbwall()
[[Moveset controllers#scr_player_climbwall()]]
~~~js
function scr_dos_climbwall() //gml_Script_scr_dos_climbwall
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
                    return;
                }
                movespeed = 0
                hsp = 0
                wallspeed = 0
                vsp = 0
                state = (0 << 0)
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
                scr_climboutchecker(i, old_x, old_y)
                if (wallspeed >= 0)
                {
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
                }
                else
                {
                    state = (5 << 0)
                    sprite_index = spr_dive
                    fmod_event_instance_play(snd_dive)
                    if (abs(wallspeed) >= 18 && abs(wallspeed) < mach5limit)
                        wallspeed = -18
                    if (abs(wallspeed) >= mach5limit)
                        wallspeed = mach5exit * -1
                    movespeed = (-wallspeed)
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
            if (state != (104 << 0) && verticalbuffer <= 0 && place_meeting(x, (y - 1), obj_solid) && scr_solid((x + xscale), y) && (!(place_meeting(x, (y - 1), obj_verticalhallway))) && (!(place_meeting(x, (y - 1), obj_destructibles))) && ((!(place_meeting((x + sign(hsp)), y, obj_slope))) || scr_solid_slope((x + sign(hsp)), y)) && (!(place_meeting((x - sign(hsp)), y, obj_slope))))
            {
                trace("climbwall hit head")
                if (!skateboarding)
                {
                    sprite_index = spr_superjumpland
                    fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                    image_index = 0
                    state = (123 << 0)
                    machhitAnim = 0
                }
                else if (!key_jump)
                {
                    state = (106 << 0)
                    hsp = -2.5 * xscale
                    vsp = -3
                    mach2 = 0
                    image_index = 0
                }
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
### scr_dos_tumble()
[[Moveset controllers#scr_player_tumble()]]
~~~js
function scr_dos_tumble() //gml_Script_scr_dos_tumble
{
    var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)
    doSnapjump()
    var _dsc = collision_line(x, (y + 1), x, (y + 10), obj_solid, 0, 1)
    if (sprite_index == spr_player_snapjump || sprite_index == spr_player_snapjumpinter || sprite_index == spr_player_snapjumpstart)
    {
        state = (306 << 0)
        return;
    }
    if place_meeting(x, (y + 1), obj_railparent)
    {
        var _railinst = instance_place(x, (y + 1), obj_railparent)
        railmovespeed = _railinst.movespeed
        raildir = _railinst.dir
    }
    hsp = xscale * movespeed + railmovespeed * raildir
    move = key_right + key_left
    if (sprite_index == spr_player_snapcrouch || sprite_index == spr_player_snapcrouch_loop)
    {
        with (obj_metalblock)
        {
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - 1), y, other) || place_meeting((x + 1), y, other))
            {
                instance_destroy()
                GamepadSetVibration(0, 0.5, 0.5, 0.8)
            }
        }
        if (sprite_index == spr_player_snapcrouch)
        {
            if (move != 0)
                xscale = move
        }
    }
    mask_index = spr_crouchmask
    if (sprite_index == spr_tumblestart)
        movespeed = 6
    if ((!grounded) && (sprite_index == spr_crouchslip || sprite_index == spr_player_snapcrouch || sprite_index == spr_player_snapcrouch_loop || sprite_index == spr_machroll || sprite_index == spr_player_rolljump || sprite_index == spr_backslide || sprite_index == spr_mach2jump || sprite_index == spr_backslideland))
    {
        if (!ispeppino)
        {
            sprite_index = spr_playerN_divebomb
            state = (306 << 0)
            savedmove = xscale
            vsp = 20
            movespeed = hsp
            input_buffer_slap = 0
            input_buffer_jump = 0
            image_index = 0
            return;
        }
        else if (movespeed < 12)
        {
            vsp = 10
            sprite_index = spr_dive
            fmod_event_instance_play(snd_dive)
        }
        else
        {
            var frick = collision_line(x, (y + 50), x, (y + 75), obj_solid, 0, 1)
            if (frick == 4 || frick == -4)
            {
                if (!(place_meeting(x, (y + 10), obj_solid)))
                    y += 10
            }
            vsp = 7
            sprite_index = spr_player_rolljump
            state = (121 << 0)
        }
    }
    if (sprite_index == spr_tumble && grounded)
    {
        if (move == xscale)
            movespeed = Approach(movespeed, 12, 0.25)
        else if (move == (-xscale))
            movespeed = Approach(movespeed, 8, 0.25)
        else
            movespeed = Approach(movespeed, 10, 0.25)
    }
    if (grounded && sprite_index == spr_dive)
    {
        sprite_index = spr_machroll
        image_index = 0
    }
    if (grounded && sprite_index == spr_player_snapcrouch_air)
    {
        _dsc = collision_line(x, (y + 1), x, (y + 10), obj_solid, 0, 1)
        flash = 1
        if key_down
            sprite_index = spr_machroll
        if (_dsc == -4 && (!key_down))
        {
            with (instance_create(x, y, obj_jumpdust))
                image_xscale = other.xscale
            state = (121 << 0)
            sprite_index = spr_player_rollgetupALT
        }
        image_index = 0
    }
    if (sprite_index == spr_dive && key_jump)
    {
        if ispeppino
        {
            sprite_index = spr_player_poundcancel1
            image_index = 0
            state = (108 << 0)
            dir = xscale
            vsp = -6
        }
        else
        {
            sprite_index = spr_playerN_divebomb
            state = (306 << 0)
            vsp = 20
            hsp = 0
            savedmove = xscale
            movespeed = 0
            input_buffer_slap = 0
            input_buffer_jump = 0
            image_index = 0
            return;
        }
    }
    if (movespeed <= 2 && sprite_index != spr_tumble && sprite_index != spr_breakdance)
        state = (0 << 0)
    if ((!scr_slope()) && sprite_index == spr_tumblestart && floor(image_index) < 11)
        image_index = 11
    if (sprite_index == spr_mach2jump && grounded)
    {
        image_index = 0
        sprite_index = spr_machroll
    }
    if (sprite_index == spr_player_rolljump && grounded)
    {
        image_index = 0
        sprite_index = spr_machroll
    }
    if (sprite_index == spr_crouchslip && (!grounded))
        sprite_index = spr_player_jumpdive2
    if (sprite_index == spr_player_Sjumpcancelland && floor(image_index) == (image_number - 1))
        sprite_index = spr_player_Sjumpcancelslide
    if (sprite_index == spr_player_jumpdive2 && grounded)
        sprite_index = spr_crouchslip
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_machroll && movespeed > 12)
    {
        sprite_index = spr_backslideland
        image_index = 0
    }
    if (sprite_index == spr_machroll && (!grounded))
        sprite_index = spr_player_rolljump
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_backslideland)
        sprite_index = spr_backslide
    if (sprite_index == spr_player_Sjumpcancel && grounded)
        sprite_index = spr_player_Sjumpcancelland
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_Sjumpcancelland)
        sprite_index = spr_player_Sjumpcancelslide
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_breakdance)
    {
        particle_set_scale((5 << 0), xscale, 1)
        create_particle(x, y, (5 << 0), 0)
        movespeed = 12
        sprite_index = spr_breakdancesuper
    }
    if (sprite_index == spr_player_snapcrouch && floor(image_index) == (image_number - 1))
    {
        image_index = 0
        sprite_index = spr_player_snapcrouch_loop
    }
    if (sprite_index == spr_tumblestart && floor(image_index) == (image_number - 1))
    {
        sprite_index = spr_tumble
        movespeed = 14
    }
    if (grounded && gap != -4 && ispeppino && sprite_index != spr_tumble && (place_meeting((x + sign(hsp)), (y - 20), obj_solid) || place_meeting((x + xscale), (y - 20), obj_solid) || scr_solid_slope((x + sign(hsp)), (y - 16))) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))) && place_meeting(x, (y + 1), obj_slope))
    {
        fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)
        move *= -1
        instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)
        xscale *= -1
        sprite_index = spr_backslideland
        image_index = 0
    }
    if ((state != (108 << 0) && grounded && sprite_index != spr_tumble && sprite_index != spr_dive && (place_meeting((x + xscale), y, obj_solid) || scr_solid_slope((x + xscale), y)) && (!(place_meeting((x + hsp), y, obj_rollblock))) && ((!(place_meeting((x + hsp), y, obj_rattumble))) || sprite_index != spr_tumble) && (!(place_meeting((x + hsp), y, obj_destructibles)))) || place_meeting(x, y, obj_timedgate))
    {
        hsp = 0
        movespeed = 0
        if (sprite_index == spr_player_snapcrouch && (place_meeting((x + hsp), y, obj_metalblock) || place_meeting((x + xscale), y, obj_metalblock)))
        {
        }
        else
        {
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)
            state = (106 << 0)
            image_index = 0
            sprite_index = spr_wallsplat
        }
        return;
    }
    if (((state != (108 << 0) && sprite_index != spr_dive && (place_meeting((x + xscale), y, obj_solid) || scr_solid_slope((x + xscale), y)) && (!(place_meeting((x + hsp), y, obj_rollblock))) && ((!(place_meeting((x + hsp), y, obj_rattumble))) || sprite_index != spr_tumble) && (!(place_meeting((x + hsp), y, obj_destructibles)))) || place_meeting(x, y, obj_timedgate)) && (sprite_index == spr_tumble || sprite_index == spr_tumblestart))
    {
        hsp = 0
        movespeed = 0
        fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y)
        state = (106 << 0)
        landAnim = 0
        sprite_index = spr_tumbleend
        image_index = 0
        hsp = (-xscale) * 2
        vsp = -3
        jumpstop = 1
        return;
    }
    if (ispeppino && (!grounded) && sprite_index != spr_tumble && dos && gap != -4 && (place_meeting((x + xscale), y, obj_solid) || place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))))
    {
        var _climb = 1
        if (!ispeppino)
            _climb = ledge_bump(40, (abs(hsp) + 1))
        if _climb
        {
            wallspeed = (-movespeed)
            grabclimbbuffer = 0
            state = (37 << 0)
            return;
        }
    }
    if ((!key_jump2) && jumpstop == 0 && vsp < 0.5 && stompAnim == 0)
    {
        vsp /= 2
        jumpstop = 1
    }
    if (grounded && vsp > 0 && (!(place_meeting(x, y, obj_bigcheese))))
        jumpstop = 0
    if (input_buffer_jump > 0 && can_jump && state != (106 << 0) && hsp != 0 && sprite_index == spr_tumble && (!(place_meeting(x, y, obj_pinballlauncher))) && (!(place_meeting(x, y, obj_bigcheese))))
    {
        if (!(scr_solid(x, (y - 16))))
        {
            with (instance_create(x, y, obj_highjumpcloud2))
                image_xscale = other.xscale
            vsp = -11
            scr_fmod_soundeffect(jumpsnd, x, y)
        }
    }
    if (crouchslipbuffer > 0)
        crouchslipbuffer--
    var _ccc = ((sprite_index == spr_player_snapcrouch || sprite_index == spr_player_snapcrouch_loop) && key_shoot)
    if ((!key_down) && (!_ccc) && key_attack && grounded && state != (106 << 0) && sprite_index != spr_tumble && sprite_index != spr_tumbleend && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) && sprite_index != spr_breakdance)
    {
        if (crouchslipbuffer == 0)
        {
            if (sprite_index == spr_crouchslip && dos && ispeppino)
                movespeed = 8.5
            with (instance_create(x, y, obj_jumpdust))
                image_xscale = other.xscale
            if (movespeed >= 12)
            {
                state = (121 << 0)
                sprite_index = spr_player_rollgetupALT
            }
            else
            {
                state = (104 << 0)
                sprite_index = spr_rollgetup
            }
            image_index = 0
            if (!ispeppino)
                sprite_index = spr_rollgetup
            fmod_event_instance_play(rollgetupsnd)
        }
    }
    if ((!key_down) && (!_ccc) && (!key_attack) && grounded && vsp > 0 && state != (106 << 0) && sprite_index != spr_tumble && sprite_index != spr_tumbleend && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) && sprite_index != spr_breakdance)
    {
        if (crouchslipbuffer == 0)
        {
            if (movespeed > 6)
            {
                state = (105 << 0)
                sprite_index = spr_machslidestart
                image_index = 0
            }
            else
                state = (0 << 0)
        }
    }
    if (sprite_index == spr_crouchslip || sprite_index == spr_breakdancesuper || sprite_index == spr_machroll || sprite_index == spr_tumble || sprite_index == spr_tumblestart || sprite_index == spr_machroll || sprite_index == spr_player_rolljump)
        image_speed = abs(movespeed) / 15
    else if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_rolljump)
        image_speed = 0
    else if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_Sjumpcancel)
        image_speed = 0
    else
        image_speed = 0.35
    if ((!instance_exists(dashcloudid)) && grounded)
    {
        with (instance_create(x, y, obj_dashcloud))
        {
            image_xscale = other.xscale
            other.dashcloudid = id
        }
    }
    if (sprite_index == spr_dive && vsp < 10)
        vsp = 10
}
~~~
### scr_dos_freefall()
[[Moveset controllers#scr_player_freefall()]]
~~~js
function scr_dos_freefall() //gml_Script_scr_dos_freefall
{
    var mach5exit = 21.5
    if (characterID == 10)
        mach5exit = 24
    doSnapjump()
    if (key_slap2 && sprite_index == spr_player_poundcancel1)
    {
        input_buffer_slap = 0
        fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)
        sprite_index = spr_player_poundaircancel
        image_index = 0
        jumpAnim = 1
        grav = 0.5
        state = (92 << 0)
        return;
    }
    if (poundbuffer > 0)
    {
        poundbuffer -= 1
        hsp = Approach(hsp, 0, 0.25)
    }
    landAnim = 1
    if (vsp >= 2)
    {
        if (steppybuffer > 0)
            steppybuffer--
        else
        {
            create_particle((x + (irandom_range(-25, 25))), (y + (irandom_range(-10, 35))), (1 << 0), 0)
            steppybuffer = 8
        }
        if (vsp > 21)
        {
            if ispeppino
                vsp += 0.7
            if (punch_afterimage > 0)
                punch_afterimage--
            else
            {
                punch_afterimage = 5
                with (create_mach3effect(x, y, sprite_index, image_index))
                {
                    image_xscale = other.xscale
                    playerid = other.id
                    maxmovespeed = 6
                    vertical = 1
                    fadeoutstate = (108 << 0)
                }
            }
            if (piledrivereffect > 0)
                piledrivereffect--
            else
            {
                with (instance_create(x, y, obj_parryeffect))
                    sprite_index = spr_piledrivereffect
                piledrivereffect = 15
            }
        }
        vsp += 0.25
    }
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_bodyslamstart)
        sprite_index = spr_bodyslamfall
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_shotgunjump1)
        sprite_index = spr_shotgunjump3
    move = key_left + key_right
    if ((!grounded) && poundbuffer == 0)
    {
        if (sprite_index != spr_rockethitwall)
            hsp = move * movespeed
        else
            hsp = 0
        if (move != xscale && momemtum == 1 && movespeed != 0)
            movespeed -= 0.05
        if (movespeed == 0)
            momemtum = 0
        if (move != dir && move != 0)
        {
            dir = move
            movespeed = 0
        }
        if ((move == 0 && momemtum == 0) || scr_solid((x + hsp), y))
        {
            movespeed = 0
            mach2 = 0
        }
        if (move != 0 && movespeed < 7)
            movespeed += 0.25
        if (movespeed > 7)
            movespeed -= 0.05
        if ((scr_solid((x + 1), y) && move == 1) || (scr_solid((x - 1), y) && move == -1))
            movespeed = 0
        if (move != 0 && sprite_index != spr_player_poundcancel1)
            xscale = move
    }
    if (vsp > 0)
        freefallsmash++
    else if (vsp < 0)
        freefallsmash = -14
    if (freefallsmash >= 10 && (!instance_exists(superslameffectid)) && vsp > 25)
    {
        with (instance_create(x, y, obj_superslameffect))
        {
            playerid = other.object_index
            other.superslameffectid = id
        }
    }
    if (grounded && vsp > 0 && (freefallsmash < 10 || (!(place_meeting(x, (y + vsp), obj_metalblock)))) && (!(place_meeting(x, (y + 1), obj_destructibles))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (!(place_meeting(x, (y + vsp + 6), obj_destructibles))))
    {
        poundbuffer = 0
        if (scr_slope() && sprite_index != spr_player_poundcanceldive)
        {
            with (instance_place(x, (y + 1), obj_slope))
            {
                other.xscale = (-sign(image_xscale))
                other.state = (5 << 0)
                other.sprite_index = other.spr_machroll
                if (other.freefallsmash > 30)
                    other.movespeed = 16
                else if (other.freefallsmash > 20)
                    other.movespeed = 14
                else
                    other.movespeed = 10
                with (instance_create(other.x, other.y, obj_jumpdust))
                    image_xscale = (-sign(other.image_xscale))
            }
            return;
        }
        else
        {
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
            if (sprite_index == spr_player_poundcanceldive)
            {
                if (key_down || key_shoot)
                {
                    var exitSpeed = 12
                    if (freefallsmash > 20)
                    {
                        flash = 1
                        repeat (5)
                            instance_create(x, y, obj_firemouthflame)
                        exitSpeed = 16
                    }
                    if (freefallsmash > 27)
                    {
                        flash = 1
                        repeat (5)
                            instance_create(x, y, obj_firemouthflame)
                        exitSpeed = mach5exit
                    }
                    if (exitSpeed < drillexitspd)
                    {
                        exitSpeed = drillexitspd
                        if (drillexitspd > 16.5)
                            exitSpeed = 16.5
                    }
                    hsp = exitSpeed * xscale
                    movespeed = exitSpeed
                    poundbuffer = 15
                    input_buffer_slap = 0
                    if (movespeed >= 12)
                    {
                        repeat (5)
                            instance_create(x, y, obj_firemouthflame)
                    }
                    fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
                    sprite_index = spr_player_snapcrouch
                    crouchslipbuffer = 5
                    jumpstop = 0
                    state = (5 << 0)
                    image_index = 0
                    return;
                }
                else
                {
                    particle_set_scale((5 << 0), xscale, 1)
                    create_particle(x, y, (5 << 0), 0)
                    fmod_event_instance_play(rollgetupsnd)
                    vsp = -8
                    exitSpeed = 12
                    if (freefallsmash > 20)
                    {
                        flash = 1
                        repeat (5)
                            instance_create(x, y, obj_firemouthflame)
                        exitSpeed = 16
                    }
                    if (freefallsmash > 27)
                    {
                        flash = 1
                        repeat (5)
                            instance_create(x, y, obj_firemouthflame)
                        exitSpeed = mach5exit
                    }
                    if (exitSpeed < drillexitspd)
                    {
                        exitSpeed = drillexitspd
                        if (drillexitspd > 16.5)
                            exitSpeed = 16.5
                    }
                    hsp = exitSpeed * xscale
                    movespeed = exitSpeed
                    state = (121 << 0)
                    jumpstop = 1
                    canrollsnd = 1
                    image_index = 0
                    sprite_index = spr_player_spinkf
                    return;
                }
            }
            else if ((sprite_index == spr_player_poundcancel1 || sprite_index == spr_bodyslamfall) && scr_check_superjump() && ispeppino)
            {
                sprite_index = spr_superjumpprep
                state = (99 << 0)
                hsp = 0
                image_index = 0
                return;
            }
            else if (sprite_index == spr_player_poundcancel1 && (!key_attack))
                sprite_index = spr_player_poundcancel2
            else if ((sprite_index == spr_player_poundcancel1 || spr_shotgunjump2) && key_attack && ispeppino)
            {
                if (freefallsmash > 12)
                    quickroll = 1
                else
                    quickroll = 0
                sprite_index = spr_player_poundmach
                fmod_event_one_shot_3d("event:/sfx/playerN/break", x, y)
            }
            else if (shotgunAnim == 0)
                sprite_index = spr_bodyslamland
            else
                sprite_index = spr_shotgunjump2
            image_index = 0
            state = (111 << 0)
            jumpAnim = 1
            jumpstop = 0
            with (obj_camera)
            {
                shake_mag = 5
                shake_mag_acc = 15 / room_speed
            }
            if (freefallsmash >= 10)
            {
                with (obj_baddie)
                {
                    if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)
                    {
                        state = (138 << 0)
                        if (stunned < 60)
                            stunned = 60
                        vsp = -11
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
                combo = 0
                bounce = 0
            }
            create_particle(x, (y + 3), (14 << 0), 0)
            freefallstart = 0
        }
    }
    image_speed = 0.35
    if (sprite_index == spr_bodyslamstart)
        image_speed = 0.4
    if (sprite_index == spr_player_poundcanceldive)
        image_speed = 0.8
    if (character == "M")
    {
        if (!key_down)
        {
            state = (92 << 0)
            sprite_index = spr_fall
            image_index = 0
        }
    }
}
~~~
### scr_dos_freefallland()
[[Moveset controllers#scr_player_freefallland()]]
~~~js
function scr_dos_freefallland() //gml_Script_scr_dos_freefallland
{
    move = key_right + key_left
    mach2 = 0
    poundbuffer = 0
    jumpAnim = 1
    dashAnim = 1
    landAnim = 0
    moveAnim = 1
    stopAnim = 1
    crouchslideAnim = 1
    crouchAnim = 0
    machhitAnim = 0
    movespeed = 0
    facehurt = 1
    start_running = 1
    alarm[4] = 14
    vsp = 0
    hsp = 0
    if (sprite_index == spr_player_poundmach)
    {
        if (move != 0 && floor(image_index) < 3)
            xscale = move
        if (floor(image_index) >= 3)
            hsp = xscale * 3
        if (!grounded)
        {
            hsp = 0
            movespeed = 0
            vsp = 10
            freefallsmash = 13
            sprite_index = spr_player_poundcanceldive
            state = (108 << 0)
            return;
        }
    }
    if (floor(image_index) == (image_number - 1))
    {
        if (scr_check_superjump() && ispeppino)
        {
            sprite_index = spr_superjumpprep
            state = (99 << 0)
            hsp = 0
            image_index = 0
            return;
        }
        if (sprite_index == spr_player_poundmach)
        {
            jumpstop = 1
            if quickroll
                movespeed = 14
            else
                movespeed = 10
            sprite_index = spr_machroll
            flash = 1
            image_index = 0
            if (!key_down)
            {
                vsp = -7
                sprite_index = spr_player_poundcancelstart
                if quickroll
                {
                    repeat (5)
                        instance_create(x, y, obj_firemouthflame)
                    movespeed = 16
                }
                else
                    movespeed = 12
                with (instance_create(x, y, obj_crazyrunothereffect))
                    image_xscale = other.xscale
                quickroll = 0
                state = (121 << 0)
                return;
            }
            state = (5 << 0)
        }
        else
        {
            facehurt = 1
            sprite_index = spr_facehurtup
            image_index = 0
            state = (0 << 0)
            jumpstop = 1
        }
    }
    if quickroll
        image_speed = 0.7
    else
        image_speed = 0.35
}
~~~
### scr_dos_mach3()
[[Moveset controllers#scr_player_mach3()]]
~~~js
function scr_dos_mach3() //gml_Script_scr_dos_mach3
{
    if (!scr_doniMoveset())
        return;
    if (sprite_index == spr_fightball)
    {
        scr_player_fightball()
        return;
    }
    switch character
    {
        case "P":
            var slopeaccel = 0.1
            var slopedeccel = 0.2
            var speedcap = 30
            var mach4movespeed = 21
            var mach3movespeed = 16
            var accel = 0.03
            var capaccel = 0.01
            var mach4accel = 0.0001
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
            if (move == xscale && grounded)
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
            if (grounded && vsp > 0)
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
                if (mach4mode && (!grounded) && sprite_index != spr_dos_unhingedrun && sprite_index != spr_player_spinkf && sprite_index != spr_player_poundcancel && sprite_index != spr_player_poundcancelstart && ispeppino)
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
                if ((movespeed > mach3movespeed && sprite_index != spr_dos_unhingedrun && sprite_index != spr_crazyrun && sprite_index != spr_player_Sjumpcancelstart && sprite_index != spr_player_spinkf && sprite_index != spr_player_poundcancel && sprite_index != spr_player_poundcancelstart && sprite_index != spr_taunt && sprite_index != spr_player_rolljump) || (sprite_index == spr_player_rolljump && grounded && movespeed >= mach3movespeed))
                {
                    mach4mode = 1
                    flash = 1
                    sprite_index = spr_crazyrun
                }
                else if (movespeed <= mach3movespeed && (sprite_index == spr_crazyrun || sprite_index == spr_dos_unhingedrun))
                    sprite_index = mach3_spr
                if (movespeed >= mach4movespeed && grounded && sprite_index != spr_dos_unhingedrun)
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
            if (((!key_attack) && fightball == 0 && (!launched) && sprite_index != spr_dashpadmach && grounded && vsp > 0 && (character == "P" || character == "N")) || (character == "S" && (move == 0 || move != xscale) && grounded && fightball == 0))
            {
                sprite_index = spr_machslidestart
                if ispeppino
                    fmod_event_one_shot_3d("event:/sfx/pep/break", x, y)
                else
                    fmod_event_one_shot_3d("event:/sfx/playerN/break", x, y)
                state = (105 << 0)
                image_index = 0
                launched = 0
            }
            if (move == (-xscale) && grounded && vsp > 0 && (!launched) && (character == "P" || character == "N") && fightball == 0 && sprite_index != spr_dashpadmach)
            {
                if ispeppino
                    fmod_event_one_shot_3d("event:/sfx/pep/machslideboost", x, y)
                else
                    fmod_event_one_shot_3d("event:/sfx/playerN/machslide", x, y)
                sprite_index = spr_mach3boost
                state = (105 << 0)
                image_index = 0
            }
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
            if (grounded && sprite_index == spr_dos_unhingedrun && place_meeting((x + sign(hsp)), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))) && (!(place_meeting((x + hsp), y, obj_mach3solid))))
            {
                var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)
                var dx = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)
                if ((gap == -4 || dx != -4) && sprite_index == spr_dos_unhingedrun)
                {
                    mask_index = spr_crouchmask
                    state = (5 << 0)
                    sprite_index = spr_machroll
                    image_index = 0
                    fmod_event_instance_play(snd_dive)
                    return;
                }
                var _climb = 1
                if (!ispeppino)
                    _climb = ledge_bump(40)
                if _climb
                {
                    wallspeed = movespeed
                    grabclimbbuffer = 0
                    state = (37 << 0)
                    sprite_index = spr_dos_walllaunch
                    image_index = 0
                    image_speed = 0.35
                }
                instance_create(x, y, obj_noiseeffect)
                fmod_event_one_shot_3d("event:/sfx/misc/superspring", x, y)
                return;
            }
            if (((!grounded) && (place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock)))) || (grounded && (place_meeting((x + sign(hsp)), (y - 16), obj_solid) || scr_solid_slope((x + sign(hsp)), (y - 16))) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))) && place_meeting(x, (y + 1), obj_slope)))
            {
                _climb = 1
                if (!ispeppino)
                    _climb = ledge_bump(40, (abs(hsp) + 1))
                if _climb
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
            if ((!grounded) && place_meeting((x + sign(hsp)), y, obj_climbablewall) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))))
            {
                _climb = 1
                if (!ispeppino)
                    _climb = ledge_bump(40)
                if _climb
                {
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
            if (scr_solid((x + sign(hsp)), y) && (!(place_meeting((x + sign(hsp)), y, obj_mach3solid))) && (!scr_slope()) && (scr_solid_slope((x + sign(hsp)), y) || place_meeting((x + sign(hsp)), y, obj_solid)) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_climbablewall))) && grounded)
            {
                var _bump = 1
                if (ispeppino || noisemachcancelbuffer <= 0)
                    _bump = ledge_bump((vsp >= 0 ? 32 : 22))
                if _bump
                {
                    with (obj_camera)
                    {
                        shake_mag = 20
                        shake_mag_acc = 40 / room_speed
                    }
                    with (obj_baddie)
                    {
                        if (shakestun && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0)
                        {
                            stun = 1
                            alarm[0] = 200
                            ministun = 0
                            vsp = -5
                            hsp = 0
                        }
                    }
                    if (!fightball)
                    {
                        sprite_index = spr_hitwall
                        fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                        fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y)
                        hsp = 0
                        flash = 0
                        state = (106 << 0)
                        hsp = -6 * xscale
                        vsp = -6
                        mach2 = 0
                        image_index = 0
                        instance_create((x + xscale * 15), (y + 10), obj_bumpeffect)
                    }
                    else
                    {
                        fightball = 0
                        with (obj_player)
                        {
                            sprite_index = spr_hitwall
                            instance_create((x + 10), (y + 10), obj_bumpeffect)
                            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                            fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y)
                            hsp = 0
                            flash = 0
                            state = (106 << 0)
                            hsp = -6 * xscale
                            vsp = -6
                            mach2 = 0
                            image_index = 0
                        }
                    }
                }
            }
            break
    }

    var b = 0
    with (obj_hamkuff)
    {
        if (state == (206 << 0) && playerid == other.id)
            b = 1
    }
    if ((!instance_exists(dashcloudid)) && grounded && (!(place_meeting(x, (y + 1), obj_water))) && (!b))
    {
        with (instance_create(x, y, obj_superdashcloud))
        {
            if (other.fightball == 1)
                instance_create(obj_player.x, obj_player.y, obj_slapstar)
            image_xscale = other.xscale
            other.dashcloudid = id
        }
    }
    if ((!instance_exists(dashcloudid)) && grounded && place_meeting(x, (y + 1), obj_water) && (!b))
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
Does snapjumps, already checks for the right character
References are found here: [[Dos - Changes to vainilla game]]
~~~js
function doSnapjump() //gml_Script_doSnapjump
{
    var _dsc = collision_line(x, (y + 1), x, (y + 10), obj_solid, 0, 1)
    if (_dsc != -4 && state != (37 << 0))
        return 0;
    var exec = sprite_index == spr_player_poundcancelstart
    if ((key_shoot2 || (input_buffer_chaos < 15 && input_buffer_chaos > 0 && state != (37 << 0))) && ispeppino && (characterID == 0 || characterID == 10) && dos && (!isgustavo) && state != (108 << 0) && (!exec))
    {
        input_buffer_chaos = -1
        if (state == (37 << 0))
        {
            input_buffer_down = 0
            input_buffer_slap = 0
            poundbuffer = 15
            if (movespeed >= 12)
            {
                repeat (5)
                    instance_create(x, y, obj_firemouthflame)
            }
            fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
            if global.noisejetpack
                snapjumps += 1
            sprite_index = spr_player_snapjumpinter
            jumpstop = 1
            fmod_event_one_shot_3d("event:/sfx/pep/jump", x, y)
            image_index = 0
            vsp = -5
            movespeed = abs(wallspeed)
            hsp = 10 * xscale
            walljumpbuffer = 4
            state = (306 << 0)
            return 1;
        }
        else if grounded
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
            vsp = -9
            jumpstop = 1
            image_index = 0
            state = (306 << 0)
            return 1;
        }
        else
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
            if key_down
            {
                vsp = 0
                if (sprite_index == spr_player_rolljump || sprite_index == spr_player_spinkf)
                    vsp = -5
            }
            else
                vsp = -11
            sprite_index = spr_player_snapjumpinter
            jumpstop = 1
            image_index = 0
            state = (306 << 0)
            return 1;
        }
    }
    return 0;
}
~~~