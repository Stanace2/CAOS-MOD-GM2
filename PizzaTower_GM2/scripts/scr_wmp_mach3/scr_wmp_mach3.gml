function scr_wmp_mach3() 
{  
    if scr_wm_lastbreath()  
        return;  
    if (sprite_index == spr_fightball)  
    {  
        scr_player_fightball()  
        return;  
    }  
    if (sprite_index == spr_wm_djump || sprite_index == spr_wm_airspin)  
    {  
        scr_wmp_doublejump()  
        return;  
    }  
    if (sprite_index == spr_wm_katanaboost || sprite_index == spr_wm_katanaboost_loop)  
    {  
        scr_wmp_jaws()  
        return;  
    }  
    if (sprite_index == spr_w_spinkick)  
    {  
        move = key_left + key_right  
        hsp = xscale * movespeed  
        if (jawsbuffer > 0)  
        {  
            jawsbuffer--  
            if (vsp > -0.5)  
                vsp = 0  
        }  
        if (grounded && vsp >= 0)  
        {  
            image_index = 0  
            sprite_index = spr_mach4  
        }  
        if scr_mach_check_dive()  
        {  
            jawsbuffer = 0  
            if (vsp < 10)  
                vsp = 10  
        }  
        scr_wm_dokatana()  
        if key_jump  
        {  
            with (instance_create(x, y, obj_wethamtornado))  
            {  
                state = wrstates.wait 
                image_xscale = 1.5  
                image_yscale = 1.5  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_windspin  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/windwhirl", x, y)  
            image_index = 2  
            state = states.mach2 
            vsp = -11  
            jumpAnim = 1  
            sprite_index = spr_wethamwalljump  
            return;  
        }  
        if (((!grounded) || place_meeting(x, (y + 1), obj_slope)) && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))))  
        {  
            slashstored = 0  
            with (instance_create(x, (y - 35 + vsp), obj_wethamtornado))  
            {  
                state = wrstates.wait 
                image_xscale = other.xscale * 1.5  
                image_yscale = 1.5  
                image_index = 0  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_wallcurrent  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/wallcurrent", x, y)  
            if (movespeed < 16)  
                movespeed = 16  
            wallclingpulse = 45  
            if (place_meeting((x + hsp), y, obj_solid) && place_meeting((x + hsp), y, obj_slope))  
                ledge_bump(40)  
            scr_wm_dowallcling()  
            vsp = -18.4  
            return;  
        }  
        image_speed = 0.65  
        return;  
    }  
    switch character  
    {  
        case "P":  
            var slopeaccel = 0.1  
            var slopedeccel = 0.2  
            var mach4movespeed = 20  
            var mach3movespeed = 16  
            var accel = 0.09  
            var mach4accel = 0.1  
            var jumpspeed = -11  
            var machrollspeed = 10  
            var speedCap = 12  
            if brick  
                speedCap = 16  
            var mach3_spr = spr_mach4  
            var mach3jump_spr = spr_mach3jump   
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
            if (move == xscale && grounded && movespeed < speedCap)  
                movespeed += accel  
			if (movespeed > 16 && grounded && vsp >= 0.5)
				movespeed = Approach(movespeed, 16, 0.05)
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
            crouchslideAnim = 1  
            if ((!key_jump2) && jumpstop == 0 && vsp < 0.5)  
            {  
                vsp /= 20  
                jumpstop = 1  
            }  
            if (grounded && vsp > 0)  
                jumpstop = 0  
            if (input_buffer_jump > 0 && sprite_index != mach3jump_spr && can_jump && (!((move == 1 && xscale == -1))) && (!((move == -1 && xscale == 1))))  
            {  
                input_buffer_jump = 0  
                scr_fmod_soundeffect(jumpsnd, x, y)  
                particle_set_scale(particletypes.jumpdust, xscale, 1)  
                create_particle(x, y, particletypes.jumpdust, 0)  
                if (sprite_index != spr_fightball)  
                {  
                    image_index = 0  
                    sprite_index = mach3jump_spr  
                }  
                if (character == "P")  
                    vsp = jumpspeed  
                else  
                    vsp = -13  
            }  
            if (fightball == 0 && sprite_index != spr_wm_airspin && sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop && sprite_index != spr_wm_katanaboost_recover)  
            {  
                if (grounded && vsp >= 0)
                    sprite_index = mach3_spr  
                else  
                    sprite_index = mach3jump_spr  
            }  
            if (sprite_index == spr_wm_katanaboost_recover)  
            {  
                if (floor(image_index) == (image_number - 1) || (!((grounded && vsp >= 0))))  
                    sprite_index = mach3_spr  
            }  
            if (sprite_index == spr_wm_airspin && grounded && vsp >= 0)  
                sprite_index = mach3_spr  
            if (sprite_index == spr_crazyrun && (!instance_exists(crazyruneffectid)))  
            {  
                with (instance_create(x, y, obj_crazyrunothereffect))  
                {  
                    playerid = other.object_index  
                    other.crazyruneffectid = id  
                }  
            }  
            if (sprite_index == mach3_spr || sprite_index == spr_fightball)  
                image_speed = 0.4  
            else if (sprite_index == spr_crazyrun)  
                image_speed = 0.75  
            else if (sprite_index == spr_rollgetup || sprite_index == spr_mach3hit || sprite_index == spr_dashpadmach)  
                image_speed = 0.4  
            else  
                image_speed = 0.4  
            if (((!key_attack) && fightball == 0 && (!launched) && sprite_index != spr_dashpadmach && grounded && vsp > 0 && (character == "P" || character == "N")) || (character == "S" && (move == 0 || move != xscale) && grounded && fightball == 0))  
            {  
                sprite_index = spr_move  
                state = states.normal
                image_index = 0  
                movespeed = 8  
                hsp = movespeed * xscale  
                return;  
            }  
            if (move == (-xscale) && grounded && vsp > 0 && (!launched) && (character == "P" || character == "N") && fightball == 0 && sprite_index != spr_dashpadmach)  
            {  
                fmod_event_one_shot_3d("event:/sfx/pep/backslide", x, y)  
                sprite_index = spr_mach3boost  
                state = states.machslide 
                image_index = 0  
                xscale *= -1  
                return;  
            }  
            if (move == (-xscale) && (!grounded) && sprite_index != spr_dashpadmach)  
            {  
                movespeed = 2  
                state = states.jump 
                return;  
            }  
            if (((!grounded) || place_meeting(x, (y + 1), obj_slope)) && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))))  
            {  
                var _climb = ledge_bump(40)  
                if _climb  
                {  
                    if ledge_bump((vsp >= 0 ? 32 : 22))  
                    {  
                        wallclingpulse = 15  
                        scr_wm_dowallcling()  
                        return;  
                    }  
                    return;  
                }  
            }  
            scr_wm_dokatana()  
            if (input_buffer_shoot > 0 && sprite_index != spr_dashpadmach)  
            {  
                if shotgunAnim  
                    scr_shotgunshoot()  
                else if global.pistol  
                    scr_pistolshoot(states.mach2)  
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
                        state = states.bump
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
                            state = states.bump
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
        if (state == states.blockstance && playerid == other.id)  
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
    if grounded  
        scr_wm_doroll()  
    else if key_down  
    {  
        input_buffer_down = 0  
        state = states.tumble
        sprite_index = spr_dive  
        if (brick == 1)  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        fmod_event_instance_play(snd_crouchslide)  
        return;  
    }  
    scr_wm_doyosh()  
    scr_wm_dodoublejump()  
    scr_wm_dobombdive()  
    scr_dotaunt()  
    if (!instance_exists(chargeeffectid))  
    {  
        with (instance_create(x, y, obj_chargeeffect))  
        {  
            playerid = other.object_index  
            other.chargeeffectid = id  
        }  
    }  
    if (movespeed < 11)  
        movespeed = 11  
}