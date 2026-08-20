function scr_wmp_jaws() //gml_Script_scr_wmp_jaws  
{  
    move = key_left + key_right  
    hsp = xscale * movespeed  
    if (sprite_index != spr_wm_katanaboost)  
    {  
        if (jawsfriction == 0 && grounded)  
        {  
            movespeed = Approach(movespeed, 8, 0.05)  
            if (!instance_exists(obj_jaws_grindeffect))  
                instance_create(x, y, obj_jaws_grindeffect)  
        }  
        else  
            instance_destroy(obj_jaws_grindeffect)  
        if (jawsfriction > 0 && grounded)  
        {  
            jawsfriction--  
            instance_destroy(obj_jaws_grindeffect)  
        }  
    }  
    if scr_wm_dobombdive()  
    {  
        input_buffer_jump = 0  
        return;  
    }  
    if (jawsbuffer > 0)  
    {  
        jawsbuffer--  
        if (vsp > -0.5)  
            vsp = 0  
    }  
    if (input_buffer_jump < 30 && input_buffer_jump != 0)  
        jawsup = 1  
    scr_wm_doroll()  
    if (sprite_index == spr_wm_pounce_slide || sprite_index == spr_wm_pounce_dive)  
    {  
        if (movespeed < 8)  
            movespeed = 8  
        if ((!key_down) && grounded && sprite_index == spr_wm_pounce_slide && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
        {  
            flash = 1  
            sprite_index = spr_wm_pounce  
            if key_shoot  
                image_index = 0  
            else  
            {  
                image_index = 8  
                wmlongjumpbuffer = 1  
            }  
        }  
        if (sprite_index == spr_wm_pounce_dive && grounded)  
        {  
            if (!key_down)  
            {  
                flash = 1  
                sprite_index = spr_wm_pounce  
                if key_shoot  
                    image_index = 0  
                else  
                {  
                    image_index = 8  
                    wmlongjumpbuffer = 1  
                }  
            }  
            else  
                sprite_index = spr_wm_pounce_slide  
        }  
        if ((!grounded) && sprite_index != spr_wm_pounce_dive)  
        {  
            sprite_index = spr_wm_pounce_dive  
            vsp = 10  
        }  
    }  
    if (sprite_index == spr_wm_katanaboost)  
    {  
        if (movespeed < 12)  
            movespeed = 12  
        if (floor(image_index) == (image_number - 1))  
            sprite_index = spr_wm_katanaboost_loop  
        if (floor(image_index) >= 10)  
        {  
            if (grounded && vsp >= 0)  
            {  
                if (move != 0)  
                {  
                    if (xscale != move)  
                        flash = 1  
                    xscale = move  
                }  
                input_buffer_chaos = 0  
                image_index = 0  
                sprite_index = spr_wm_katanaboost_recover  
                state = states.mach3 
            }  
        }  
    }  
    if (sprite_index == spr_wm_katanaboost_loop)  
    {  
        if (grounded && vsp >= 0)  
        {  
            if (move != 0)  
            {  
                if (xscale != move)  
                    flash = 1  
                xscale = move  
            }  
            input_buffer_chaos = 0  
            image_index = 0  
            sprite_index = spr_wm_katanaboost_recover  
            state = states.mach3
        }  
    }  
    if (floor(image_index) == (image_number - 1))  
    {  
        if (sprite_index == spr_wm_longjump)  
            sprite_index = spr_wm_longjump_loop  
        if (sprite_index == spr_wm_pounce)  
        {  
            if (movespeed >= 12)  
            {  
                if key_attack  
                {  
                    if (move != 0)  
                    {  
                        if (xscale != move)  
                            flash = 1  
                        xscale = move  
                    }  
                    input_buffer_chaos = 0  
                    sprite_index = spr_mach4  
                    state = states.mach3
                }  
                else  
                {  
                    input_buffer_chaos = 0  
                    sprite_index = spr_idle  
                    state = states.normal
                }  
            }  
            else  
            {  
                input_buffer_chaos = 0  
                state = states.normal 
            }  
        }  
        if (sprite_index == spr_wm_pouncestart_air)  
            sprite_index = spr_wm_pounce_air  
        if (sprite_index == spr_wm_pounce_dj)  
            image_index = image_number - 2  
    }  
    if ((!grounded) && sprite_index != spr_wm_longjump && sprite_index != spr_wm_pounce_dive && sprite_index != spr_wm_longjump_loop && sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop && sprite_index != spr_wm_pouncestart_air && sprite_index != spr_wm_pounce_air && sprite_index != spr_wm_pounce_dj)  
    {  
        image_index = 0  
        sprite_index = spr_wm_pouncestart_air  
    }  
    if ((sprite_index == spr_wm_pouncestart_air || sprite_index == spr_wm_longjump || sprite_index == spr_wm_longjump_loop || sprite_index == spr_wm_pounce_dj || sprite_index == spr_wm_pounce_air) && grounded && vsp > 0.5)  
    {  
        flash = 1  
        sprite_index = spr_wm_pounce  
        if key_shoot  
            image_index = 0  
        else  
        {  
            wmlongjumpbuffer = 1  
            image_index = 8  
        }  
    }  
    scr_wm_doyosh()  
    if (key_jump && (!grounded) && brick && sprite_index != spr_wm_pounce_dj)  
    {  
        input_buffer_jump = 0  
        input_buffer_chaos = 0  
        GamepadSetVibration(0, 0.8, 0.8, 0.65)  
        instance_create(x, y, obj_highjumpcloud2)  
        sprite_index = spr_wm_pounce_dj  
        image_index = 0  
        state = states.punch
        if key_jump  
            jumpstop = 0  
        else  
            jumpstop = 1  
        if (movespeed < 20)  
        {  
            if (movespeed < 8)  
                movespeed = 8  
            else  
                movespeed += 1  
        }  
        vsp = -11  
    }  
    if scr_wm_lastbreath()  
    {  
        input_buffer_chaos = 0  
        return;  
    }  
    scr_wm_dokatana()  
    if (key_down && (!grounded) && sprite_index != spr_wm_longjump)  
    {  
        jawsup = 0  
        jawsbuffer = 0  
        if (vsp < 0)  
            vsp = 0  
        if (vsp < 20)  
            vsp++  
    }  
    if (place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + xscale), y, obj_metalblock))) && (!(place_meeting((x + xscale), y, obj_destructibles))) && jawsbuffer < 23)  
    {  
        if (sprite_index != spr_wm_pounce_dive)  
        {  
            var _climb = ledge_bump(40)  
            if _climb  
            {  
                if ledge_bump((vsp >= 0 ? 32 : 22))  
                    scr_wm_bouncejaws()  
            }  
        }  
        else  
            scr_wm_bouncejaws()  
    }  
    if (grounded && vsp > -0.5 && sprite_index != spr_wm_pounce_slide)  
    {  
        if (input_buffer_jump < 30 && input_buffer_jump != 0)  
        {  
            if wmlongjumpbuffer  
            {  
                if (movespeed >= 12)  
                {  
                    if key_attack  
                    {  
                        if (move != 0)  
                        {  
                            if (xscale != move)  
                                flash = 1  
                            xscale = move  
                        }  
                        input_buffer_chaos = 0  
                        sprite_index = spr_mach4  
                        state = states.mach3
                    }  
                    else  
                    {  
                        input_buffer_chaos = 0  
                        sprite_index = spr_idle  
                        state = states.normal 
                    }  
                }  
                else  
                {  
                    input_buffer_chaos = 0  
                    state = states.normal  
                }  
                wmlongjumpbuffer = 0  
                return;  
            }  
            else  
            {  
                input_buffer_chaos = 0  
                sprite_index = spr_wm_longjump  
                image_index = 0  
                state = states.punch 
                input_buffer_jump = 0  
                if (movespeed < 20)  
                {  
                    if (movespeed < 8)  
                        movespeed = 8  
                }  
                hsp = movespeed * xscale  
                vsp = -11  
                jawsbuffer = 0  
                return;  
            }  
        }  
    }  
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
    if (key_shoot && sprite_index == spr_wm_pounce && floor(image_index) > 7 && sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop)  
        image_index = 5  
    if (sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop)  
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
    image_speed = 0.35  
}