function scr_wm_dodoublejump() {
	if (place_meeting(x, (y + 16), obj_solid) || place_meeting(x, (y + 16), obj_slope))  
        return;  
    if (key_jump && (!grounded) && (brick || instance_exists(obj_mango_companion)) && sprite_index != spr_wm_djump)  
    {  
        if (!wethamcombo[0])  
        {  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
                instance_create(x, y, obj_wm_note)  
                brick = 1  
            }  
            input_buffer_jump = 0  
            image_speed = 0.9  
            GamepadSetVibration(0, 0.8, 0.8, 0.65)  
            instance_create(x, y, obj_highjumpcloud2)  
            sprite_index = spr_wm_djump  
            image_index = 0  
            if key_jump  
                jumpstop = 0  
            else  
                jumpstop = 1  
            if (move != 0)  
            {  
                if (movespeed < 20)  
                {  
                    if (movespeed < 8)  
                        movespeed = 8  
                }  
                hsp = movespeed * xscale  
                vsp = -15  
            }  
            else  
            {  
                vsp = -18  
                jumpstop = 1  
            }  
            if (state != states.mach3)  
                state = states.mach2
            wethamcombo[0] = 1  
            wethamcombo[1] = 0  
            wethamcombo[3] = 0  
            wethamcombo[4] = 0  
            return;  
        }  
        else if key_jump  
            fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)  
    } 
}