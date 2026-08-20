function scr_wmp_megadash() //gml_Script_scr_wmp_megadash  
{  
    if instance_exists(obj_mango_brickball)  
    {  
        var distance = distance_to_point(obj_mango_brickball.x, obj_mango_brickball.y)  
        angle = point_direction(x, y, obj_mango_brickball.x, obj_mango_brickball.y)  
        var _speed = 95  
        if (distance < 95)  
            _speed = distance  
        x += lengthdir_x(_speed, angle)  
        y += lengthdir_y(_speed, angle)  
        xscale = 1  
        if (distance <= 100)  
        {  
            move = key_left + key_right  
            x = obj_mango_brickball.x  
            y = obj_mango_brickball.y  
            mangocall = 0  
            brick = 1  
            flash = 1  
            state = states.slap 
            sprite_index = spr_wm_balltochomp  
            image_index = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/superjumpcancel", x, y)  
            with (obj_mango_brickball)  
                instance_destroy()  
        }  
    }  
    else  
        state = states.normal
}