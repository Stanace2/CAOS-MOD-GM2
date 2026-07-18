Aight, do your secrets
~~~js
function scr_chaoschaser_secret() //gml_Script_scr_chaoschaser_secret  
{  
    endsecret = 1  
    if (!startsecret)  
    {  
        startsecret = 1  
        sprite_index = spr_caos_chill1  
        state = (0 << 0)  
    }  
    if (targetplayer.state == (84 << 0) && state != (1 << 0))  
    {  
        tauntID = instance_create(x, y, obj_baddietaunteffect)  
        sprite_index = spr_caos_taunt  
        image_index = random_range(0, (image_number - 1))  
        state = (1 << 0)  
    }  
    image_alpha = 1  
    var mult = 1  
    if (abs(targetplayer.hsp) > 9)  
        mult = (-targetplayer.xscale)  
    else  
        mult = sign(x - targetplayer.x)  
    var tx = targetplayer.x + 150 * mult  
    var ty = targetplayer.y - 100  
    var acc = 0.1  
    switch state  
    {  
        case (0 << 0):  
            if sign(x - targetplayer.x)  
                sprite_index = spr_caos_chill2  
            else  
                sprite_index = spr_caos_chill1  
            if (x > (tx - 8) && x < (tx + 8) && y > (ty - 8) && y < (ty + 8))  
                acc = 0.05  
            x = lerp(x, tx, acc)  
            y = lerp(y, ty, acc)  
            break  
        case (1 << 0):  
            if (targetplayer.state != (84 << 0))  
            {  
                instance_destroy(tauntID)  
                state = (0 << 0)  
            }  
            break  
    }  
  
}
~~~