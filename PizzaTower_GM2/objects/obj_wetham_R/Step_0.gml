switch state  
{  
	// idle and prepare, can be some like wait
    case wrstates.wait:  
        if (sprite_index == spr_w_megaslash)  
            vsp = 0  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_w_lastbreath)  
            {  
                if (!grounded)  
                {  
                    image_index = 0  
                    sprite_index = spr_w_lastbreath_fall  
                }  
            }  
            if (sprite_index == spr_w_megaslash)  
            {  
                state = wrstates.travel
                sprite_index = spr_w_lastbreath_travel  
                create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
            }  
            image_index = image_number - 1  
        }  
        scr_collide()  
        break  
    // Travel
    case wrstates.travel:  
        distance = distance_to_point(obj_player1.x, obj_player1.y)  
        angle = point_direction(x, y, obj_player1.x, obj_player1.y)  
        var _speed = 95  
        if (distance < 95)  
            _speed = distance  
        x += lengthdir_x(_speed, angle)  
        y += lengthdir_y(_speed, angle)  
        if (distance <= 100)  
        {  
            with (obj_player1)  
            {  
                move = key_left + key_right  
                mangocall = 0  
                brick = 1  
                flash = 1  
                if (move != 0)  
                {  
                    if (move != 0)  
                        xscale = move  
                    input_buffer_jump = 0  
                    particle_set_scale(particletypes.highjumpcloud2, xscale, 1)  
                    create_particle(x, y, particletypes.highjumpcloud2, 0)  
                    movespeed = 16  
                    hsp = movespeed * move  
                    sprite_index = spr_mach4  
                    image_index = 0  
                    jumpAnim = 1  
                    state = states.mach3
                    vsp = 0  
                    jumpstop = 0  
                    if key_down  
                    {  
                        input_buffer_down = 0  
                        state = states.tumble
                        sprite_index = spr_dive  
                        if (brick == 1)  
                        {  
                            with (instance_create(x, y, obj_mango_companion))  
                                wait = 1  
                            brick = 0  
                        }  
                    }  
                }  
                else  
                {  
                    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
                    image_speed = 0.9  
                    GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                    state = states.mach2
                    instance_create(x, y, obj_highjumpcloud2)  
                    sprite_index = spr_wm_djump  
                    image_index = 0  
                    vsp = -25  
                    if place_meeting(x, (y - 1), obj_solid)  
                        vsp = 25  
                }  
            }  
            instance_destroy()  
        }  
        break  
}  
  
if (instance_exists(obj_fadeout) && (!notfade))  
    instance_destroy()