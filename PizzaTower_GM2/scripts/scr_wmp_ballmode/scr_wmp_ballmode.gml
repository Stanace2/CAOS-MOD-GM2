function scr_wmp_ballmode()
{  
    move = key_left + key_right  
    if (ballspeed > 18)  
        ballspeed = 18 
	clingexitspeed = ballspeed
    if key_jump2  
        jawsup = 1  
    if ((sprite_index == spr_player_mangoboost || sprite_index == spr_player_mangoboostend || sprite_index == spr_player_mangoboostfly || sprite_index == spr_wm_ball_doublejumpl) && (!ballvertical))  
        hsp = ballspeed * xscale  
    if ballvertical  
    {  
        if (move != 0)  
            hsp = Approach(hsp, (move * 8), 1)  
        else  
            hsp = Approach(hsp, 0, 0.5)  
        if (vsp > 0.5)  
            vsp++  
    }  
    var bombspeed = 6  
    if (sprite_index == spr_wm_bombdive)  
    {  
        if (movespeed <= bombspeed)  
        {  
            if (move != 0)  
                hsp = Approach(hsp, (move * bombspeed), 1)  
            else  
                hsp = Approach(hsp, 0, 1)  
        }  
        else  
        {  
            if (move != xscale && move != 0 && movespeed != 12)  
                movespeed = bombspeed  
            hsp = Approach(hsp, (move * movespeed), 1)  
        }  
        if (vsp > 4)  
            vsp++  
        if (vsp > 0)  
            bombdivesmash++  
    }  
    else  
        movespeed = ballspeed  
    if (grounded && sprite_index != spr_player_mangoboost && sprite_index != spr_player_mangoboostend && vsp > 0 && (!(place_meeting(x, (y + vsp + 2), obj_grindrail))) && (!(place_meeting(x, (y + 10), obj_grindrail))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (!(place_meeting(x, (y + vsp + 2), obj_destructibles))) && (!(place_meeting(x, (y + 10), obj_destructibles))))  
    {  
        jumpAnim = 1  
        jumpstop = 0  
        if (sprite_index == spr_wm_bombdive || sprite_index == spr_player_mangoboostfly || sprite_index == spr_wm_ball_doublejumpl)  
        {  
            if (sprite_index == spr_wm_bombdive)  
            {  
                if scr_slope()  
                {  
                    with (instance_place(x, (y + 1), obj_slope))  
                    {  
                        other.xscale = (-sign(image_xscale))  
                        with (instance_create(other.x, other.y, obj_jumpdust))  
                            image_xscale = (-sign(other.image_xscale))  
                        with (other)  
                            scr_wm_doroll(1)  
                        if (other.bombdivesmash > 25)  
                            other.movespeed = 16  
                        else  
                            other.movespeed = 12  
                    }  
                    if (clingexitspeed > movespeed)  
                        movespeed = clingexitspeed  
                    hsp = clingexitspeed * xscale  
                }  
                else  
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
                            state = states.stun
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
                    create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
                    movespeed = 0  
                    hsp = 0  
                    if (clingexitspeed < 16)  
                    {  
                        if (bombdivesmash > 25)  
                            clingexitspeed = 16  
                        else if (clingexitspeed < 12)  
                            clingexitspeed = 12  
                    }  
                    state = states.freefallland
                    image_index = 0  
                    sprite_index = spr_wm_bombdive_land  
                }  
                return;  
            }  
            else  
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
                        state = states.stun
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
                create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
            }  
            if (move != 0)  
                xscale = move  
            if (sign(hsp) != move && move != 0)  
                hsp *= -1  
        }  
        image_index = 0  
        state = states.mach3  
        scr_wm_doroll()  
        if (key_shoot && (!key_down))  
            scr_wm_dokatana(true)  
    }  
    if (sprite_index == spr_player_mangoboost || sprite_index == spr_player_mangoboostend || sprite_index == spr_player_mangoboostfly || sprite_index == spr_wm_ball_doublejumpl)  
    {  
        if (sign(hsp) != 0)  
            xscale = sign(hsp)  
        if ((!instance_exists(chargeeffectid)) && (!ballvertical))  
        {  
            with (instance_create(x, y, obj_chargeeffect))  
            {  
                playerid = other.object_index  
                other.chargeeffectid = id  
            }  
        }  
        if ((!jumpstop) && vsp < 0.5 && (!key_jump2) && (!jawsup) && (!ballvertical))  
        {  
            vsp /= 10  
            jumpstop = 1  
        }  
        if (sprite_index == spr_player_mangoboostfly && key_jump && (!grounded))  
        {  
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
            sprite_index = spr_wm_ball_doublejumpl  
            jawsup = true  
            vsp = -15  
            if (move != 0)  
                xscale = move  
        }  
        if (sprite_index == spr_player_mangoboostend && (!grounded) && sprite_index != spr_player_mangoboost)  
        {  
            image_index = 0  
            sprite_index = spr_player_mangoboostfly  
        }  
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_mangoboost)  
        {  
            image_index = 2  
            sprite_index = spr_player_mangoboost  
        }  
        if (floor(image_index) == (image_number - 3) && sprite_index == spr_player_mangoboost)  
        {  
            image_index = 0  
            sprite_index = spr_player_mangoboostend  
        }  
        if ((!ballvertical) && place_meeting((x + sign(hsp)), y, obj_solid) && (!(place_meeting((x + hsp), y, obj_metalblock))) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))))  
        {  
            hoverspin = 15  
            if (ballspeed < 15)  
                ballspeed += 0.5  
            if (vsp < 10)  
                vsp = 10  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)  
            xscale *= -1  
            hsp = ballspeed * xscale  
            wethamcombo[4] = 0  
            allowjawsfly = 1  
        }  
        scr_wm_dokatana()  
        if (key_down && (!grounded))  
        {  
            jawsup = false  
            if (vsp < 0)  
                vsp = 0  
            if (vsp < 20)  
                vsp++  
        }  
    }  
    if (hoverspin < 15)  
        hoverspin = 15  
    var spinspid = 0  
    if (max(abs(hsp), abs(vsp)) < 8)  
        spinspid = 8  
    else  
        spinspid = max(abs(hsp), abs(vsp))  
    if (sprite_index == spr_wm_ball_doublejumpl)  
    {  
        hoverspin = Approach(hoverspin, 50, 0.3)  
        image_speed = Approach(image_speed, (spinspid / hoverspin), 1)  
    }  
    else  
    {  
        hoverspin = Approach(hoverspin, 50, 0.1)  
        image_speed = Approach(image_speed, (8 / hoverspin), 1)  
    }  
    if (punch_afterimage > 0)  
        punch_afterimage--  
    else  
    {  
        punch_afterimage = 5  
        with (create_mach3effect(x, y, sprite_index, (image_index - 1)))  
        {  
            image_xscale = other.xscale  
            playerid = other.id  
        }  
    }  
    scr_wm_doyosh()  
    scr_wm_dobombdive()  
    instance_destroy(instance_place(x, (y + vsp), obj_destructibles))  
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
    instance_destroy(instance_place(x, (y + vsp), obj_metalblock))  
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
}