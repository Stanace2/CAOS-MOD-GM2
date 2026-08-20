function scr_wmp_attackprep()
{  
    move = key_left + key_right  
    if (sprite_index == spr_wm_balltokatana)  
        hsp = Approach(hsp, 0, 0.5)  
    else if (sprite_index == spr_lonegustavo_kick)  
    {  
        hsp = movespeed * (-xscale)  
        movespeed = Approach(movespeed, 0, 0.25)  
    }  
    else if (sprite_index == spr_wetham_machmango_kick)  
        hsp = movespeed * xscale  
    else  
        hsp = Approach(hsp, 0, 1)  
    if (sprite_index != spr_lonegustavo_kick)  
        vsp = 0  
    if (move != 0)  
        xscale = move  
    if (floor(image_index) == (image_number - 1))  
    {  
        switch sprite_index  
        {  
            case spr_wm_balltokatana:  
                movespeed = clingexitspeed  
                if (movespeed < 15)  
                {  
                    movespeed = 15  
                    with (instance_create(x, y, obj_wethamtornado))  
                    {  
                        state = wrstates.wait
                        image_xscale = other.xscale  
                        image_speed = 0.45  
                        image_alpha = 0.8  
                        sprite_index = spr_w_windpulse  
                    }  
                    fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/speedboost", x, y)  
                }  
                if allowjawsfly  
                    jawsbuffer = 25  
                allowjawsfly = 0  
                image_index = 0  
                sprite_index = spr_w_spinkick  
                state = states.mach3
                if grounded  
                    vsp = -4  
                else  
                    vsp = 0  
                if (brick == 1)  
                {  
                    fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", (x + xscale * 32), y)  
                    with (instance_create((x + xscale * 40 * -1), y, obj_mango_companion))  
                    {  
                        vsp = 0  
                        image_xscale = other.xscale  
                        if (other.movespeed > 13)  
                            hsp = image_xscale * other.movespeed * 0.33  
                        state = mstates.flykick  
                        image_index = 0  
                        sprite_index = spr_m_flykick  
                    }  
                    brick = 0  
                }  
                return;  
            case spr_wm_balltochomp:  
                flash = 1  
                if (move != 0)  
                    xscale = move  
                input_buffer_jump = 0  
                particle_set_scale(particletypes.highjumpcloud2, xscale, 1)  
                create_particle(x, y, particletypes.highjumpcloud2, 0)  
                movespeed = 17  
                hsp = movespeed * move  
                sprite_index = spr_mach4  
                image_index = 0  
                jumpAnim = 1  
                state = states.mach3
                vsp = -4  
                jumpstop = 0  
                if key_down  
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
                }  
                break  
            case spr_w_megaslash:  
                state = states.boots
                sprite_index = spr_w_lastbreath_travel  
                create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
                return;  
            case spr_w_kick:  
                if grounded  
                {  
                    landAnim = 0  
                    state = states.normal
                }  
                else  
                {  
                    sprite_index = spr_fall  
                    state = states.jump
                }  
                break  
            case spr_wetham_machmango_kick:  
                spr_mach4 = spr_wetham_machslash  
                spr_mach3jump = spr_wetham_machslash_air
                sprite_index = spr_mach4  
                katanatype = 1  
                state = states.mach3
                break  
        }  
  
    }  
    if (sprite_index == spr_wm_balltochomp)  
    {  
        if (input_buffer_slap < 30 && input_buffer_slap != 0)  
        {  
            flash = 1  
            movespeed = 17  
            hsp = movespeed * move  
            with (instance_create(x, y, obj_wethamtornado))  
            {  
                state = wrstates.wait  
                image_xscale = other.xscale  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_windpulse  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/speedboost", x, y)  
            if allowjawsfly  
                jawsbuffer = 25  
            allowjawsfly = 0  
            image_index = 0  
            sprite_index = spr_w_spinkick  
            state = states.mach3
            if grounded  
                vsp = -4  
            else  
                vsp = 0  
            if (brick == 1)  
            {  
                fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", (x + xscale * 32), y)  
                with (instance_create((x + xscale * 40 * -1), y, obj_mango_companion))  
                {  
                    vsp = 0  
                    image_xscale = other.xscale  
                    if (other.movespeed > 13)  
                        hsp = image_xscale * other.movespeed * 0.33  
                    state = mstates.flykick  
                    image_index = 0  
                    sprite_index = spr_m_flykick  
                }  
                brick = 0  
            }  
            return;  
        }  
        if (input_buffer_chaos < 30 && input_buffer_chaos != 0)  
        {  
            flash = 1  
            movespeed = 17  
            hsp = movespeed * move  
            scr_wm_dokatana(true)  
            return;  
        }  
    }  
    if ((sprite_index == spr_wm_balltokatana || sprite_index == spr_wm_balltochomp) && key_up && (!wethamcombo[4]))  
    {  
        if (move != 0)  
            xscale = move  
        ballvertical = 1  
        if (movespeed < 14)  
        {  
            ballspeed = 14  
            movespeed = 14  
        }  
        else  
            ballspeed = movespeed  
        input_buffer_chaos = 0  
        jumpstop = 1  
        hsp = 0  
        if grounded  
            vsp = -20  
        else  
            vsp = -15  
        state = states.ratmountbounce 
        image_index = 0  
        sprite_index = spr_wm_ball_doublejumpl  
        flash = 1  
        fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
        fmod_event_one_shot_3d("event:/sfx/pep/uppercut", x, y)  
        instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)  
        wethamcombo[4] = 1  
        scr_wmp_ballmode()  
        return;  
    }  
    if (sprite_index == spr_wm_balltokatana && key_down && (!wethamcombo[4]))  
    {  
        scr_wm_dobombdive()  
        return;  
    }  
    if (movespeed >= 15 && sprite_index == spr_wm_balltokatana)  
        image_speed = 0.85  
    else if (sprite_index == spr_wm_balltokatana || sprite_index == spr_wetham_machmango_kick)  
        image_speed = 0.65  
    else  
        image_speed = 0.35  
}