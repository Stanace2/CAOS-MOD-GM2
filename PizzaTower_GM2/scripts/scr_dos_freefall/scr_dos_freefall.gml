function scr_dos_freefall() //gml_Script_scr_dos_freefall
{
    var mach5exit = 21.5
    if (characterID == characters.fdos)
        mach5exit = 24
    doSnapjump()
    if (key_slap2 && sprite_index == spr_bombdive)
    {
        input_buffer_slap = 0
        fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)
        sprite_index = spr_poundaircancel
        image_index = 0
        jumpAnim = 1
        grav = 0.5
        state = states.jump
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
            create_particle((x + (irandom_range(-25, 25))), (y + (irandom_range(-10, 35))), states.revolver, 0)
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
                    fadeoutstate = states.freefall
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
        if (move != 0 && sprite_index != spr_bombdive)
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
        if (scr_slope() && sprite_index != spr_machdrill)
        {
            with (instance_place(x, (y + 1), obj_slope))
            {
                other.xscale = (-sign(image_xscale))
                other.state = states.tumble
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
            if (sprite_index == spr_machdrill)
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
                    sprite_index = spr_snapcrouch
                    crouchslipbuffer = 5
                    jumpstop = 0
                    state = states.tumble
                    image_index = 0
                    return;
                }
                else
                {
                    particle_set_scale(states.tumble, xscale, 1)
                    create_particle(x, y, states.tumble, 0)
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
                    state = states.mach3
                    jumpstop = 1
                    canrollsnd = 1
                    image_index = 0
                    sprite_index = spr_spinkf
                    return;
                }
            }
            else if ((sprite_index == spr_bombdive || sprite_index == spr_bodyslamfall) && scr_check_superjump() && ispeppino)
            {
                sprite_index = spr_superjumpprep
                state = states.Sjumpprep
                hsp = 0
                image_index = 0
                return;
            }
            else if (sprite_index == spr_bombdive && (!key_attack))
                sprite_index = spr_bombdive_land
            else if ((sprite_index == spr_bombdive || spr_shotgunjump2) && key_attack)
            {
                if (freefallsmash > 12)
                    quickroll = 1
                else
                    quickroll = 0
                sprite_index = spr_poundmach
                fmod_event_one_shot_3d("event:/sfx/playerN/break", x, y)
            }
            else if (shotgunAnim == 0)
                sprite_index = spr_bodyslamland
            else
                sprite_index = spr_shotgunjump2
            image_index = 0
            state = states.freefallland
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
                        state = states.stun
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
            create_particle(x, (y + 3), states.morthook, 0)
            freefallstart = 0
        }
    }
    image_speed = 0.35
    if (sprite_index == spr_bodyslamstart)
        image_speed = 0.4
    if (sprite_index == spr_machdrill)
        image_speed = 0.8
    if (character == "M")
    {
        if (!key_down)
        {
            state = statesjump
            sprite_index = spr_fall
            image_index = 0
        }
    }
}