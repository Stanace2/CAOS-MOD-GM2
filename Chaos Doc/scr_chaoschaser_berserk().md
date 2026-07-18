#newstates
Caos is fed up with your bs
~~~js
function scr_chaoschaser_berserk() //gml_Script_scr_chaoschaser_berserk  
{  
    if (state != (0 << 0) && state != (1 << 0) && state != (2 << 0) && state != (7 << 0))  
        state = (0 << 0)  
    image_alpha = 1  
    var dir = point_direction(x, y, targetplayer.x, targetplayer.y)  
    var invdir = point_direction(targetplayer.x, targetplayer.y, x, y)  
    switch state  
    {  
        case (0 << 0):  
            var xden = 1  
            var yden = 1  
            if (abs(relhsp) < 1 && state == (0 << 0))  
                yden = 4  
            var xthreshold = ((dir < 91 && dir > 89) || (dir < 271 && dir > 269) || (abs(relvsp) < 1 && abs(targetplayer.x - x) < 10) || sign(targetplayer.x - x) == 0 || (abs(relhsp) < 1 && abs(targetplayer.x - x) < 10))  
            if (!treasure)  
            {  
                if (!xthreshold)  
                    x += lengthdir_x((movespeed / xden), dir)  
                y += lengthdir_y((movespeed / yden), dir)  
            }  
            if (chasedistance < 100)  
            {  
                br = abs(distance_to_point(targetplayer.x, targetplayer.y))  
                ba = invdir * pi / 180  
                state = (1 << 0)  
            }  
            else  
                movespeed = Approach(movespeed, 30, 5)  
            break  
        case (1 << 0):  
            br = Approach(br, 200, 5)  
            ba += bas  
            x = targetplayer.x + cos(ba) * br  
            y = targetplayer.y + sin(ba) * br  
            tackletimer--  
            if (tackletimer < 1 && br > 198 && br < 202)  
            {  
                state = (2 << 0)  
                hitlag = 35  
                hitLagX = x  
                hitLagY = y  
            }  
            break  
        case (2 << 0):  
            if (hitlag > 0)  
            {  
                if (point_distance(x, y, (targetplayer.x + cos(ba) * br + (random_range(-10, 10))), (targetplayer.y + sin(ba) * br + (random_range(-10, 10)))) >= 60)  
                {  
                    x = Approach(x, (targetplayer.x + cos(ba) * br + (random_range(-10, 10))), 15)  
                    y = Approach(y, (targetplayer.y + sin(ba) * br + (random_range(-10, 10))), 15)  
                }  
                else  
                {  
                    x = targetplayer.x + cos(ba) * br + (random_range(-10, 10))  
                    y = targetplayer.y + sin(ba) * br + (random_range(-10, 10))  
                }  
                movespeed = 30  
                hitlag--  
            }  
            else  
            {  
                ba = dir  
                state = (7 << 0)  
            }  
            break  
        case (7 << 0):  
            movespeed = Approach(movespeed, 0, 1)  
            x += lengthdir_x(movespeed, ba)  
            y += lengthdir_y(movespeed, ba)  
            if (movespeed == 0)  
            {  
                bas += 0.03  
                tackles++  
                tackletimer = 100 / tackles  
                state = (0 << 0)  
            }  
            break  
    }  
  
    with (targetplayer)  
    {  
        if (state == (119 << 0) || state == (296 << 0) || state == (150 << 0) || state == (98 << 0) || state == (90 << 0) || state == (46 << 0) || state == (112 << 0) || state == (292 << 0) || (!visible))  
            other.awake = 0  
    }  
    if (awake && place_meeting(x, y, targetplayer) && sprite_index == spr_caos_berserk_tackle && point_in_camera(targetplayer.x, targetplayer.y, view_camera[0]))  
    {  
        if instance_exists(obj_dragonsnap_effect)  
        {  
            with (obj_dragonsnap_effect)  
            {  
                instance_activate_object(obj_pause)  
                scr_pause_activate_objects(0)  
            }  
        }  
        if instance_exists(obj_wethamtornado)  
        {  
            with (obj_wethamtornado)  
                instance_destroy()  
        }  
        fmod_event_instance_stop(snd, 1)  
        alarm[2] = 1  
    }  
    if (state == (2 << 0) || state == (99 << 0))  
        sprite_index = spr_caos_berserk_tacklestart  
    else if (state == (7 << 0))  
        sprite_index = spr_caos_berserk_tackle  
    else  
        sprite_index = spr_caos_berserk  
}
~~~