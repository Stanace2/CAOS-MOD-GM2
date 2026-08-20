function scr_wm_lastbreath() {  
    var g_ex = (place_meeting(x, (y + 20), obj_solid) || place_meeting(x, (y + 20), obj_slope))  
    if (((key_shoot && key_up) || key_superjump) && (grounded || g_ex) && (brick || instance_exists(obj_mango_companion)))  
    {  
        if instance_exists(obj_mango_companion)  
        {  
            with (obj_mango_companion)  
                instance_destroy()  
            flash = 1  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
            instance_create(x, y, obj_wm_note)  
        }  
        brick = 1  
        fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, (y + 50))  
        state = states.Sjump 
        scr_wmp_Sjump()  
        sprite_index = spr_m_lastbreath  
        image_index = 0  
        image_speed = 0.35  
        instance_create(x, y, obj_wetham_R)  
        tornadospeed = -16  
        with (instance_create(x, y, obj_wethamtornado))  
        {  
            state = states.Sjump
            image_speed = 0.66  
            image_alpha = 0.25  
            sprite_index = spr_tornado_lastbreath  
        }  
        with (instance_create(x, y, obj_wethamtornado))  
        {  
            state = wrstates.wait 
            image_index = 0  
            image_speed = 0.45  
            image_alpha = 0.8  
            sprite_index = spr_R_lastbreath  
        }  
        vsp = -16  
        return true;  
    }  
    return false;  
}