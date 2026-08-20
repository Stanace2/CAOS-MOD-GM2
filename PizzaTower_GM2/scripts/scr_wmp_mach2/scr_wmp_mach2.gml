function scr_wmp_mach2() //gml_Script_scr_wmp_mach2  
{  
    if (sprite_index == spr_wm_djump)  
    {  
        scr_wmp_doublejump()  
        return;  
    }  
    move = key_left + key_right  
    var accel = 2  
    if (sprite_index != spr_walljumpstart)  
        accel = 0.5  
    if (move != 0)  
        hsp = Approach(hsp, (movespeed * xscale), accel)  
    if (movespeed >= 10)  
        hsp = movespeed * xscale  
    if (move != xscale)  
        movespeed = 8  
    if (move != 0)  
        xscale = move  
    if (floor(image_index) == (image_number - 1))  
    {  
        switch sprite_index  
        {  
            case spr_walljumpstart:  
                sprite_index = spr_fall  
                break  
            case spr_w_lonjump:  
                sprite_index = spr_w_lonjump_end  
                break  
        }  
  
    }  
    if key_down2  
    {  
        input_buffer_down = 0  
        clingexitspeed = movespeed  
        sprite_index = spr_bodyslamstart  
        image_index = 0  
        state = states.freefall
        pistolanim = -4  
        if (brick == 1)  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        return;  
    }  
    if ((!grounded) && sprite_index != spr_w_spinball && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))))  
    {  
        var _climb = ledge_bump(40)  
        if _climb  
        {  
            if ledge_bump((vsp >= 0 ? 32 : 22))  
            {  
                scr_wm_dowallcling()  
                return;  
            }  
        }  
    }  
    if (grounded && vsp >= 0.5)  
    {  
        if (movespeed < 12)  
            state = states.normal
        else  
            state = states.mach3
    }  
    if scr_wm_lastbreath()  
        return;  
    scr_wm_doyosh()  
    scr_wm_dodoublejump()  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
    scr_dotaunt()  
    if (sprite_index == spr_wm_airspin)  
        image_speed = 0.45  
    else  
        image_speed = 0.35  
}