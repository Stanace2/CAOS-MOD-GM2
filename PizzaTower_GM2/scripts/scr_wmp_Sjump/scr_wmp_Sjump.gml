function scr_wmp_Sjump() //gml_Script_scr_wmp_Sjump  
{  
    if (!mangocall)  
    {  
        move = key_left + key_right  
        vsp = tornadospeed  
        if (tornadospeed > -30)  
            tornadospeed -= 0.25  
        if place_meeting(x, (y - 1), obj_solid)  
            hsp = Approach(hsp, (3 * move), 0.25)  
        else  
            hsp = Approach(hsp, (8 * move), 2)  
    }  
    else  
    {  
        hsp = Approach(hsp, 0, 0.1)  
        vsp = Approach(vsp, 0, 3)  
    }  
    if (sprite_index != spr_m_call)  
    {  
        if place_meeting(x, (y - 25), obj_solid)  
        {  
            sprite_index = spr_m_lastbreath_ceiling  
            vsp = -16  
            tornadospeed = vsp  
        }  
        else  
            sprite_index = spr_m_lastbreath  
    }  
    else if (floor(image_index) == (image_number - 1))  
        image_index = image_number - 1  
    if place_meeting(x, y, obj_baddie)  
    {  
        with (obj_baddie)  
        {  
            if place_meeting(x, y, obj_player)  
            {  
                if ((!invincible) && instantkillable)  
                    instance_destroy()  
            }  
        }  
    }  
    if (key_slap2 && (!mangocall))  
    {  
        mangocall = 1  
        image_index = 0  
        sprite_index = spr_m_call  
        instance_create(x, y, obj_wm_note)  
        with (obj_wethamtornado)  
        {  
            if (state == states.Sjump)  
            {  
                sprite_index = spr_tornado_lastbreath_end  
                image_index = 0  
                state = wrstates.wait 
            }  
        }  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/call", x, y)  
        fmod_event_one_shot_3d("event:/sfx/pep/superjumpcancel", x, y)  
        if instance_exists(obj_wetham_R)  
        {  
            with (obj_wetham_R)  
            {  
                if (!(point_in_camera(x, (y - 30), view_camera[0])))  
                {  
                    y = other.y + 600  
                    while point_in_camera(x, (y - 30), view_camera[0])  
                        y++  
                }  
                image_index = 0  
                sprite_index = spr_w_megaslash  
            }  
        }  
        else  
        {  
            with (instance_create(x, (y + 600), obj_wetham_R))  
            {  
                notfade = 1  
                while point_in_camera(x, (y - 30), view_camera[0])  
                    y++  
                image_index = 0  
                sprite_index = spr_w_megaslash  
            }  
        }  
    }  
    scr_collide_player()  
}