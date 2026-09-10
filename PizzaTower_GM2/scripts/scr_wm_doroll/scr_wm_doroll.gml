function scr_wm_doroll(force = false) {
    var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)  
    var dx = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)  
    var divex = (state == states.freefallland && key_attack && move != 0)  
    if ((((((move != 0 || key_attack) && key_down) || divex) && (gap == 4 || gap == -4 || (dx != -4 && dx != 4))) || force) && grounded && sprite_index != spr_wm_pounce_slide)  
    {  
        input_buffer_chaos = 0  
        if (state != states.punch && state != states.ratmountbounce)  
            input_buffer_down = 0  
        var hasM = (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_brickcomeback) && obj_brickcomeback.sprite_index == spr_m_flykicked))  
        if ((state == states.punch || state == states.ratmountbounce || (key_shoot && hasM)) && sprite_index != spr_wm_bombdive)  
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
            if instance_exists(obj_mangocomeback)  
            {  
                with (obj_mangocomeback)  
                    instance_destroy()  
                instance_create(other.x, other.y, obj_genericpoofeffect)  
                flash = 1  
                brick = 1  
            }  
            state = states.tumble 
            image_index = 0  
            sprite_index = spr_wm_pounce_slide  
        }  
        else  
        {  
            if (state == states.freefallland)  
                movespeed = clingexitspeed  
            if (move != 0 && (!force))  
                xscale = move  
            wrollbuffer = 10  
            image_index = 0  
            sprite_index = spr_wm_roll  
            image_speed = 0.35  
            with (instance_create(x, y, obj_dashcloud))  
            {  
                image_xscale = other.xscale  
                other.dashcloudid = id  
            }  
            state = states.crouch
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
        }  
    }  
}