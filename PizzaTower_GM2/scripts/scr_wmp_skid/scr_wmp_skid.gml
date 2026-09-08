function scr_wmp_skid()
{  
    if scr_wm_lastbreath()  
        return;  
    if (!(place_meeting(x, (y + 1), obj_railparent)))  
        hsp = xscale * (-movespeed)  
    else  
    {  
        var _railinst = instance_place(x, (y + 1), obj_railparent)  
        hsp = xscale * movespeed + _railinst.movespeed * _railinst.dir  
    }  
    move = key_right + key_left  
    movespeed = Approach(movespeed, 0, 0.8)  
    if (movespeed <= 0)  
    {  
        hsp = 0  
        movespeed = 0  
        if grounded  
            state = states.normal
        else  
        {  
            sprite_index = spr_fall  
            state = states.jump
            if key_down  
            {  
                clingexitspeed = movespeed  
                sprite_index = spr_bodyslamstart  
                image_index = 0  
                state = states.freefall 
                return;  
            }  
        }  
        return;  
    }  
    image_speed = 0.35  
    landAnim = 0  
    if brick  
        sprite_index = spr_mach3boost  
    else  
        sprite_index = spr_w_skid  
    scr_wm_doyosh()  
    scr_wm_dokatana()  
    if (input_buffer_shoot > 0)  
    {  
        if shotgunAnim  
        {  
            if (move != 0)  
                xscale = move  
            scr_shotgunshoot()  
        }  
        else if global.pistol  
            scr_pistolshoot(states.normal)  
    }  
    if ((!instance_exists(dashcloudid)) && grounded && (!(place_meeting(x, (y + 1), obj_water))))  
    {  
        with (instance_create(x, y, obj_dashcloud2))  
        {  
            image_xscale = other.xscale  
            other.dashcloudid = id  
        }  
    }  
    if ((!instance_exists(dashcloudid)) && grounded && place_meeting(x, (y + 1), obj_water))  
    {  
        with (instance_create(x, y, obj_dashcloud2))  
        {  
            sprite_index = spr_watereffect  
            image_xscale = other.xscale  
            other.dashcloudid = id  
        }  
    }  
}