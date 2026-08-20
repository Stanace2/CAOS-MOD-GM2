function scr_wm_bouncejaws(dirchange = false) {
	if (((grounded && (!key_jump2) && (!(place_meeting(x, (y + 1), obj_destructibles)))) || sprite_index == spr_wm_pounce_slide) && (!dirchange))  
    {  
        xscale *= -1  
        jawsfriction = 50  
        image_index = 0  
    }  
    else  
    {  
        if (movespeed < 14)  
        {  
            ballspeed = 14  
            movespeed = 14  
        }  
        else  
            ballspeed = movespeed  
        input_buffer_chaos = 0  
        jumpstop = 1  
        hsp = 4  
        vsp = 4  
        if (key_jump2 || jawsup)  
            vsp = -4  
        if key_down  
        {  
            vsp = 10  
            jawsup = 0  
        }  
        if ((!jawsup))  
            vsp = 4 
        state = states.ratmountbounce 
        image_index = 0  
        sprite_index = spr_player_mangoboostfly  
        xscale *= -1  
        flash = 1  
        hoverspin = 15  
        wethamcombo[1] = 0  
        allowjawsfly = 1  
        scr_wmp_ballmode()  
    }  
    fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
    instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)  
}