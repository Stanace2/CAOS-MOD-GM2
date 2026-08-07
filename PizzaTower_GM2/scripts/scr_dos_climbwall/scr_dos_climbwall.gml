function scr_dos_climbwall() //gml_Script_scr_dos_climbwall
{
    var climbdir = 1
    var exitspeed = 0.7
    var mach5exit = 21.5
    var mach5limit = 21
    if (characterID == characters.fdos)
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
                        other.state = states.tumble
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
                    state = states.tumble
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
                state = states.normal
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
                if (climbdir == 1 && wallspeed < 16)
                    wallspeed += (0.09 * climbdir)
                if (climbdir == -1)
                    wallspeed += (0.2 * climbdir)
            }
            crouchslideAnim = 1
            if (sprite_index != spr_dos_walllaunch)
            {
                if (vsp < 0)
                    sprite_index = spr_machclimbwall
                else
                    sprite_index = spr_wallslide
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
                state = states.normal
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
                        state = states.mach2
                        movespeed = wallspeed
                    }
                    else if (wallspeed >= 12)
                    {
                        state = states.mach3
                        sprite_index = spr_mach4
                        movespeed = wallspeed
                    }
                }
                else
                {
                    state = states.tumble
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
                state = states.machcancel
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
                    state = states.mach2
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
                    create_particle(x, y, states.fireass)
                    canrollsnd = 1
                    fmod_event_one_shot_3d("event:/sfx/pep/jump", x, y)
                    input_buffer_jump = 0
                    xscale *= -1
                    state = states.tumble
                    image_index = 0
                    sprite_index = spr_dive
                    vsp = 10
                    movespeed = abs(wallspeed)
                    if (movespeed > 17 && movespeed < mach5limit)
                        movespeed = 16
                    if (movespeed >= mach5limit)
                        movespeed = mach5exit
                    walljumpbuffer = 4
					fmod_event_one_shot_3d("event:/chaos-sfx/donisha/walldivejump", x + (50 * xscale), y + 50)
                }
            }
            if (state != states.mach2 && verticalbuffer <= 0 && place_meeting(x, (y - 1), obj_solid) && scr_solid((x + xscale), y) && (!(place_meeting(x, (y - 1), obj_verticalhallway))) && (!(place_meeting(x, (y - 1), obj_destructibles))) && ((!(place_meeting((x + sign(hsp)), y, obj_slope))) || scr_solid_slope((x + sign(hsp)), y)) && (!(place_meeting((x - sign(hsp)), y, obj_slope))))
            {
                trace("climbwall hit head")
                if (!skateboarding)
                {
                    sprite_index = spr_superjumpland
                    fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                    image_index = 0
                    state = states.Sjumpland
                    machhitAnim = 0
                }
                else if (!key_jump)
                {
                    state = states.bump
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
                create_particle((x + xscale * 10), (y + 43), states.revolver, 0)
                steppybuffer = 10
            }
            break
    }

}