Sprites and image speed manager
~~~js
function scr_chaoschaser_animation_manager() //gml_Script_scr_chaoschaser_animation_manager  
{  
    var _kpm = 1  
    if (global.kpm == 0)  
        _kpm = 1  
    else  
        _kpm = 1 - 60 / exp(5) * exp(global.kpm) / 100  
    if (sprite_index != spr_caos_munch)  
        image_speed = 0.35 * _kpm  
    else  
        image_speed = 0.35  
    if (chasedistance < 400 && (!global.panic) && iframes && state != (3 << 0) && state != (5 << 0) && state != (6 << 0))  
        image_alpha = relalpha  
    relalpha = chasedistance / 350  
    if (!awake)  
        image_alpha = Approach(image_alpha, 0, 0.05)  
    if ((!awake) && sprite_index != spr_caos_pragin)  
    {  
        sprite_index = spr_caos_pragin  
        image_index = 0  
    }  
    if (sprite_index == spr_caos_pragin && floor(image_index) == (image_number - 1))  
        image_index = image_number - 1  
    if (awake && sprite_index == spr_caos_pragin)  
    {  
        sprite_index = spr_caos_pragout  
        image_index = 0  
    }  
    if (sprite_index == spr_caos_pragout && floor(image_index) == (image_number - 1))  
        sprite_index = spr_caos_chase  
    if awake  
    {  
        if (sprite_index == spr_caos_laugh && global.lap)  
        {  
            image_index = 0  
            sprite_index = spr_caos_haunt  
        }  
        if (sprite_index == spr_caos_pragout || sprite_index == spr_caos_pragin)  
            return;  
        if (targetplayer.state == (106 << 0) && global.kpm != 0 && (!global.panic) && state != (8 << 0))  
        {  
            sprite_index = spr_caos_laugh  
            return;  
        }  
        if (state == (3 << 0))  
        {  
            if (hitlag > 0)  
                sprite_index = spr_caos_stunned  
            else  
                sprite_index = spr_caos_dizzy  
            return;  
        }  
        if (sprite_index == spr_caos_stagger && floor(image_index) == (image_number - 1))  
            image_index = image_number - 1  
        if (state == (5 << 0) && sprite_index != spr_caos_stagger)  
        {  
            sprite_index = spr_caos_stagger  
            image_index = 0  
            return;  
        }  
        if (state == (8 << 0))  
        {  
            if (sprite_index == spr_caos_high1 && floor(image_index) == (image_number - 1))  
                sprite_index = spr_caos_high2  
            if (sprite_index == spr_caos_high2 && floor(image_index) == (image_number - 1))  
                image_index = image_number - 1  
            if (high == 0 && sprite_index != spr_caos_high3)  
            {  
                image_index = 0  
                sprite_index = spr_caos_high3  
            }  
            if (sprite_index == spr_caos_high3 && floor(image_index) == (image_number - 1))  
            {  
                state = (0 << 0)  
                sprite_index = spr_caos_chase  
            }  
            return;  
        }  
        if global.lap  
        {  
            if (state != (5 << 0) && state != (8 << 0))  
            {  
                if ((chasedistance >= 450 && haunt) || image_alpha < 1 || state == (2 << 0) || state == (4 << 0))  
                {  
                    haunt = 0  
                    image_index = 0  
                    sprite_index = spr_caos_chase  
                }  
                if (chasedistance < 450 && state != (2 << 0) && image_alpha >= 1 && (!haunt) && state != (3 << 0))  
                {  
                    haunt = 1  
                    image_index = 0  
                    sprite_index = spr_caos_haunt  
                }  
                if (sprite_index == spr_caos_haunt && floor(image_index) == (image_number - 1))  
                    sprite_index = spr_caos_hauntloop  
            }  
            return;  
        }  
        if (state != (5 << 0) && state != (8 << 0))  
        {  
            if ((chasedistance > 160 && haunt) || image_alpha < 1 || state == (2 << 0) || state == (4 << 0))  
            {  
                haunt = 0  
                image_index = 0  
                sprite_index = spr_caos_chase  
            }  
            if (chasedistance < 150 && state != (2 << 0) && image_alpha >= 1 && (!haunt) && state != (3 << 0))  
            {  
                haunt = 1  
                image_index = 0  
                sprite_index = spr_caos_haunt  
            }  
            if (sprite_index == spr_caos_haunt && floor(image_index) == (image_number - 1))  
                sprite_index = spr_caos_hauntloop  
        }  
    }  
}
~~~