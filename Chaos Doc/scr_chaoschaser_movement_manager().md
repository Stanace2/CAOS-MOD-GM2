Speed, movement and state machine
~~~js
function scr_chaoschaser_movement_manager() //gml_Script_scr_chaoschaser_movement_manager  
{  
    var dir = point_direction(x, y, targetplayer.x, targetplayer.y)  
    var xden = 1  
    var yden = 1  
    if (abs(relhsp) < 1 && state == (0 << 0))  
        yden = 4  
    var xthreshold = ((dir < 91 && dir > 89) || (dir < 271 && dir > 269) || (abs(relvsp) < 1 && abs(targetplayer.x - x) < 10) || sign(targetplayer.x - x) == 0 || (abs(relhsp) < 1 && abs(targetplayer.x - x) < 10))  
    if (!treasure)  
    {  
        var fmx = movespeed / xden  
        var fmy = movespeed / yden  
        if (chasedistance < fmx)  
            fmx = chasedistance  
        if (!xthreshold)  
            x += lengthdir_x(fmx, dir)  
        y += lengthdir_y(fmy, dir)  
        if (image_alpha < 1)  
            image_alpha += 0.01  
    }  
    else  
    {  
        x = -200  
        y = -200  
    }  
    var panicx = 1  
    if global.panic  
        panicx = 1.25  
    if (global.kpm > 1)  
        panicx *= (1 / (global.kpm * 0.5))  
    switch state  
    {  
        case (0 << 0):  
            if (slakin == 1 && relhsp < 1)  
            {  
                state = (1 << 0)  
                break  
            }  
            else if (slakin == 1 && chasedistance < 300 && patience <= 0)  
            {  
                state = (1 << 0)  
                break  
            }  
            else if (lock == 1 && patience > 0 && chasedistance < 350)  
            {  
                state = (2 << 0)  
                break  
            }  
            else  
            {  
                var _speed = 1  
                if (movespeed < 8.25 && chasedistance >= 150 && movespeed < 17)  
                    movespeed += 0.05  
                if (chasedistance < 150)  
                    _speed = 5  
                else if (chasedistance < 300)  
                    _speed = 8  
                else if (chasedistance < 450)  
                    _speed = 12  
                else  
                    _speed = 17  
                movespeed = Approach(movespeed, (_speed * panicx), accel)  
                if (chasedistance < 150)  
                    x += (movespeed / 4 * targetplayer.xscale)  
                else if ((targetplayer.y + 350) > y && (targetplayer.y - 350) < y)  
                    x += (movespeed * targetplayer.xscale)  
                break  
            }  
        case (1 << 0):  
            if (awake && startbuffer == 0)  
                image_alpha = 1  
            _speed = 1  
            if (chasedistance < 100)  
                _speed = 5  
            else if (chasedistance < 150)  
                _speed = 8  
            else if (chasedistance < 300)  
                _speed = 12  
            else  
                _speed = 17  
            movespeed = Approach(movespeed, (_speed * panicx), accel)  
            if ((!targetplayer.isgustavo) && (!hasmort))  
            {  
                if (slackfury && (!xthreshold))  
                    x += ((movespeed + slackfuryspeed) * (sign(targetplayer.x - x)))  
            }  
            if (slakin == 0)  
                state = (0 << 0)  
            break  
        case (2 << 0):  
            hitbreak = 1  
            if (chasedistance < 450)  
                _speed = 5  
            else  
                _speed = 12  
            if (chasedistance < 350)  
                movespeed = Approach(movespeed, 0, accel)  
            else  
                movespeed = Approach(movespeed, (_speed * panicx), accel)  
            if (slakin == 1)  
            {  
                accel = 0  
                hitbreak = 0  
                movespeed = 0  
                state = (1 << 0)  
                break  
            }  
            else if (slakin == 0 && patience <= 0)  
            {  
                accel = 0  
                hitbreak = 0  
                movespeed = 0  
                state = (0 << 0)  
                break  
            }  
            else  
                break  
        case (3 << 0):  
            if (hitlag > 0)  
            {  
                x = hitLagX + (random_range(-30, 30))  
                y = hitLagY + (random_range(-30, 30))  
                movespeed = 0  
                hitlag--  
            }  
            else  
                movespeed = -12  
            break  
        case (4 << 0):  
            if (chasedistance < 450)  
                state = (0 << 0)  
            else  
                movespeed = Approach(movespeed, 10, 2.5)  
            break  
        case (5 << 0):  
            movespeed = Approach(movespeed, 0, 0.1)  
            if (movespeed == 0)  
                state = (4 << 0)  
            break  
        case (6 << 0):  
            movespeed = 0  
            if (floor(image_index) == (image_number - 5))  
                scr_chaosvomit()  
            if (floor(image_index) == (image_number - 1))  
            {  
                state = (0 << 0)  
                if (!global.panic)  
                    sprite_index = spr_caos_laugh  
                else if global.lap  
                    sprite_index = spr_caos_haunt  
                else  
                    sprite_index = spr_caos_chase  
            }  
            break  
        case (8 << 0):  
            if (high > 0)  
                high--  
            if (hitlag > 0)  
            {  
                x = hitLagX + (random_range(-5, 5))  
                y = hitLagY + (random_range(-5, 5))  
                movespeed = 0  
                hitlag--  
            }  
            else if (chasedistance < 300)  
                movespeed = Approach(movespeed, 0, 0.5)  
            else  
                movespeed = Approach(movespeed, 10, 1)  
            break  
    }  
  
}
~~~