function scr_wm_doyosh() {  
    if (key_jump && (brick || instance_exists(obj_mango_companion)) && key_up)  
    {  
        if (!wethamcombo[2])  
        {  
            input_buffer_chaos = 0  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
                instance_create(x, y, obj_wm_note)  
                brick = 1  
            }  
            fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, (y + 50))  
            jumpAnim = 1  
            vsp = -20  
            state = states.jump
            sprite_index = spr_stompprep  
            image_index = 0  
            image_speed = 0.35  
            gustavokicktimer = 5  
            jumpstop = 0  
            brick = 0  
            with (instance_create(x, (y + 50), obj_ratmountgroundpound))  
            {  
                vsp = 11  
                image_xscale = other.xscale  
                image_index = 0  
            }  
            wethamcombo[0] = 0  
            wethamcombo[1] = 0  
            wethamcombo[2] = 1  
            wethamcombo[3] = 0  
            return;  
        }  
        else  
            fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)  
    }  
	/*
    if (key_jump && instance_exists(obj_mangoghost) && key_up)  
    {  
        if (obj_mangoghost.state == (0 << 0) && (!obj_mangoghost.hide))  
        {  
            jumpstop = 0  
            fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, (y + 50))  
            jumpAnim = 1  
            vsp = -15  
            state = states.jump  
            sprite_index = spr_stompprep  
            image_index = 0  
            image_speed = 0.35  
            gustavokicktimer = 5  
            with (obj_mangoghost)  
            {  
                state = (1 << 0)  
                image_alpha = target_alpha  
                x = obj_player.x  
                y = obj_player.y  
            }  
        }  
        return;  
    }  
	*/
}