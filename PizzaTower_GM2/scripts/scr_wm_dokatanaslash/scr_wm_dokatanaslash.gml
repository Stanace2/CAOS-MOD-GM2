function scr_wm_dokatana(force_jaws = false, force_katana = false)
{  
    var lj_th = -8.5  
    move = key_left + key_right  
    if ((((((input_buffer_chaos < 30 && input_buffer_chaos != 0) || (sprite_index == spr_wethamdivel && key_shoot)) && sprite_index != spr_wm_pounce_dive && sprite_index != spr_wm_pounce_slide && (state != states.punch || sprite_index == spr_wm_longjump || sprite_index == spr_wm_longjump_loop)) || (state == states.mach3 && grounded && vsp > 0.5 && key_shoot && sprite_index != spr_wm_katanaboost)) && (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_mangocomeback) && obj_mangocomeback.sprite_index == spr_m_flykicked))) || force_jaws)  
    {  
        if (wethamcombo[1] == 0)  
        {  
			clingexitspeed = movespeed
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
                instance_create(x, y, obj_wm_note)  
                brick = 1  
            }  
            if instance_exists(obj_mangocomeback)  
            {  
                with (obj_mangocomeback)  
                    instance_destroy()  
                instance_create(other.x, other.y, obj_genericpoofeffect)  
                flash = 1  
                brick = 1  
            }  
            input_buffer_slap = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
            if (move != 0 && state != states.climbwall)  
                xscale = move  
            if (state != states.slap)  
            {  
                if (vsp < -0.5)  
                    jawsup = 1  
                else  
                    jawsup = 0  
            }  
            image_index = 0  
            if (state == states.climbwall)  
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
                vsp = 0  
                move = 0  
                movespeed = clingexitspeed  
                xscale *= -1  
            }  
            if (allowjawsfly && (!grounded) && vsp > lj_th)  
                jawsbuffer = 25  
            if (movespeed > 18)  
                movespeed = 18  
            if (movespeed < 8)  
                movespeed = 8  
            if (state == states.dynamite || sprite_index == spr_wethamcansh)  
            {  
                if (sprite_index == spr_w_spinkick)  
                    wethamcombo[3] = 1  
                wethamcombo[1] = 1  
                if (fakehsp != 0)  
                    movespeed = fakehsp  
                if ((fakehsp < 13.5 && kpulsebuffer > 0 && (!grounded)) || (grounded && movespeed < 13.5))  
                {  
                    movespeed = 13.5  
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
                kpulsebuffer = 0  
                fakehsp = 0  
            }  
            if ((!grounded) && vsp > lj_th)  
                vsp = 0  
            if (state == states.machslide)  
                movespeed = 8  
            hsp = movespeed * xscale  
            if (state == states.dynamite || sprite_index == spr_wethamcansh)  
            {  
                image_index = 0  
                input_buffer_chaos = 0  
                sprite_index = spr_wm_katanaboost  
                state = states.mach3  
                return;  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/pounce", x, y)  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/mdash", x, y)  
            jawsfriction = 40  
            state = states.punch
            if (vsp > lj_th)  
                sprite_index = spr_wm_pounce  
            else  
            {  
                sprite_index = spr_wm_longjump  
                input_buffer_chaos = 0  
            }  
            return;  
        }  
    }  
    var wallbuffer = (state == states.climbwall && wallclingbuffer > 0 && move != (xscale * -1))  
    var ducking = (scr_solid(x, (y - 16)) && scr_solid(x, (y - 32)) && (state == states.tumble || sprite_index == spr_wm_pounce_slide))  
    if ((input_buffer_slap > 0 && state != states.freefall && state != states.dynamite && sprite_index != spr_w_spinkick && (!ducking)) || force_katana)  
    {  
        if (wallbuffer && (!force_katana))  
            return;  
        if scr_wmp_uppercut()  
            return;  
        if (!wethamcombo[3])  
        {  
            input_buffer_chaos = 0  
            var k = false  
            input_buffer_slap = 0  
            if (movespeed < 8)  
                movespeed = 8  
            particle_set_scale(particletypes.jumpdust, xscale, 1)  
            create_particle(x, y, particletypes.jumpdust, 0)  
            jumpstop = 0  
            input_buffer_slap = 0  
            if (state == states.climbwall)  
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
                xscale *= -1  
                if place_meeting(x, y, obj_destructibles)  
                    xscale *= -1  
                if (clingexitspeed >= 16)  
                    movespeed = clingexitspeed  
                else  
                    movespeed = 16  
                katanawallexit = 1  
            }  
            else if (move != 0)  
                xscale = move  
            if (state == states.punch)  
                wethamcombo[3] = 1  
            if (state == states.punch || (state == states.ratmountbounce && ballvertical == 0) || (state == states.mach3 && (sprite_index == spr_wm_katanaboost || sprite_index == spr_wm_katanaboost_loop)))  
            {  
                if (state == states.punch && move != xscale && move != 0)  
                    movespeed = 0  
                else  
                {  
                    state = states.slap
                    sprite_index = spr_wm_balltokatana  
                    image_index = 0  
                    fmod_event_one_shot_3d("event:/sfx/misc/comboend", x, y)  
                    fmod_event_one_shot_3d("event:/sfx/misc/toppingot", x, y)  
                    return;  
                }  
            }  
            if (state == states.ratmountbounce)  
            {  
                k = true  
                if (movespeed < 17)  
                {  
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
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/slashmiss", x, y)  
            if (state == states.machslide)  
                movespeed = 8  
            scr_wm_katanapulse(k)  
            state = states.dynamite
            image_index = 0  
            if (katanatype == 1)  
            {  
                sprite_index = spr_wethamslash2  
                katanatype = 2  
            }  
            else  
            {  
                sprite_index = spr_wethamslash  
                katanatype = 1  
            }  
            slashstored++  
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
            return;  
        }  
    }  
    if (key_shoot2 && brickcallbuffer > 0)  
    {  
        if wm_mangokick()  
            return;  
    }  
}