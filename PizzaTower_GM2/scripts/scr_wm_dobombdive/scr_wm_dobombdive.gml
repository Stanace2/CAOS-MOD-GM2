function scr_wm_dobombdive(force = false) //gml_Script_scr_wm_dobombdive  
{  
    move = key_left + key_right  
    var longjumpexec = (sprite_index == spr_wetham_longjump || sprite_index == spr_wetham_longjump_loop)  
    if ((((brick || instance_exists(obj_mango_companion) || (instance_exists(obj_brickcomeback) && obj_brickcomeback.sprite_index == spr_m_flykicked)) && (!grounded) && (key_down || sprite_index == spr_wethamdivel || state == (108 << 0)) && ((key_jump2 && (!longjumpexec)) || (longjumpexec && input_buffer_jump < 30 && input_buffer_jump != 0))) || force) && sprite_index != spr_wm_bombdive)  
    {  
        mask_index = spr_player_mask  
        if (movespeed > 18)  
            movespeed = 18  
        ballspeed = movespeed  
        input_buffer_down = 0  
        input_buffer_jump = 0  
        if (state != states.freefallland)  
            clingexitspeed = movespeed  
        if (state != states.ratmountbounce)  
        {  
            state = states.ratmountbounce 
            scr_wmp_ballmode()  
        }  
        while place_meeting(x, y, obj_solid)  
            y++  
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
        fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
        if ((place_meeting(x, y, obj_stairs) || place_meeting(x, y, obj_ladder)) && state == states.freefall)  
            vsp = 0  
        else  
            vsp = -6  
        bombdivesmash = 0  
        image_index = 0  
        sprite_index = spr_wm_bombdive  
        return true;  
    }  
    return false;  
}