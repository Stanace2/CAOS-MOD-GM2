function scr_wmp_doublejump() //gml_Script_scr_wmp_doublejump  
{  
    if place_meeting((x + move), y, obj_solid)  
    {  
        if (xscale != move)  
            xscale = move  
        scr_wm_dowallcling()  
        jumpstop = 0  
        return;  
    }  
    var hoverSpeed = abs(hsp)  
    var spinspid = 0  
    if (max(abs(hsp), abs(vsp)) < 8)  
        spinspid = 8  
    else  
        spinspid = max(abs(hsp), abs(vsp))  
    hoverspin = Approach(hoverspin, 15, 0.3)  
    image_speed = Approach(image_speed, (spinspid / hoverspin), 1)  
    if (key_jump2 && vsp > 0)  
        vsp = Approach(vsp, 4, 1)  
    if (hoverSpeed < 8)  
        hoverSpeed = 8  
    move = key_left + key_right  
    movespeed = hoverSpeed  
    if (move != 0)  
        hsp = Approach(hsp, (move * hoverSpeed), 1)  
    else if (movespeed < 12)  
        hsp = Approach(hsp, 0, 0.5)  
    if ((!jumpstop) && movespeed >= 12)  
    {  
        if ((!key_jump2) && vsp < 0.5)  
        {  
            vsp /= 10  
            jumpstop = 1  
        }  
    }  
    if (grounded && vsp > -0.5 && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (!(place_meeting(x, (y + 15), obj_destructibles))) && (!(place_meeting(x, (y + 15), obj_grindrail))) && brick)  
    {  
        if (sprite_index != spr_w_kick)  
        {  
            doublejump = 0  
            create_particle(x, y, particletypes.landcloud, 0)  
            landAnim = 1  
            jumpstop = 0  
            if (move != 0)  
                xscale = move  
            if (movespeed < 12)  
            {  
                sprite_index = spr_idle  
                state = states.normal 
            }  
            else  
            {  
                sprite_index = spr_mach4  
                state = states.mach3  
            }  
            fmod_event_one_shot_3d("event:/sfx/mort/down", x, y)  
            fmod_event_one_shot_3d("event:/sfx/moisc/sniffbump", x, y)  
            return;  
        }  
    }  
    if (state != states.mach3)  
    {  
        if (punch_afterimage > 0)  
            punch_afterimage--  
        else  
            punch_afterimage = 6  
        if (punch_afterimage == 6 && hoverspin < 10)  
        {  
            with (create_mach3effect(x, y, sprite_index, (image_index - 1)))  
            {  
                image_xscale = other.xscale  
                playerid = other.id  
            }  
        }  
    }  
    if (movespeed < 12)  
        state = states.mach2
    if (input_buffer_down < 30 && input_buffer_down != 0)  
    {  
        clingexitspeed = movespeed  
        sprite_index = spr_bodyslamstart  
        image_index = 0  
        state = states.freefall
        hsp = 0  
        pistolanim = -4  
        if (brick == 1)  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        return;  
    }  
    if scr_wm_lastbreath()  
        return;  
    scr_wm_doyosh()  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
    scr_dotaunt()  
    instance_destroy(instance_place(x, (y + vsp), obj_destructibles))  
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
    if (!fmod_event_instance_is_playing(wmcopter))  
        fmod_event_instance_play(wmcopter)  
    fmod_event_instance_set_parameter(wmcopter, "speed", ((image_speed - 0.53) * 5 + image_speed / 1.005), 1)  
    fmod_event_instance_set_3d_attributes(wmcopter, x, y)  
}