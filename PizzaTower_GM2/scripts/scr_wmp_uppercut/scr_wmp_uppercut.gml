function scr_wmp_uppercut() {
    if (key_up && (!wethamcombo[4]))
    {
        wethamcombo[4] = 1
        input_buffer_slap = 0
        fmod_event_one_shot_3d("event:/sfx/pep/uppercut", x, y)
        kpulsebuffer = 0
        fakehsp = 0
        if (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_mangocomeback) && obj_mangocomeback.sprite_index == spr_m_flykicked))
        {
            if instance_exists(obj_mango_companion)
            {
                with (obj_mango_companion)
                    instance_destroy()
            }
            if instance_exists(obj_mangocomeback)
            {
                with (obj_mangocomeback)
                    instance_destroy()
                instance_create(other.x, other.y, obj_genericpoofeffect)
            }
            brick = 1
            if (move != 0)
                xscale = move
            ballvertical = 1
            if (movespeed < 14)
            {
                ballspeed = 14
                movespeed = 14
            }
            else
                ballspeed = movespeed
            input_buffer_chaos = 0
            jumpstop = 1
            hsp = 0
            if grounded
                vsp = -20
            else
                vsp = -15
            state = states.ratmountbounce
            image_index = 0
            sprite_index = spr_wm_ball_doublejumpl
            flash = 1
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)
            instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)
            scr_wmp_ballmode()
        }
        else
        {
            with (instance_create(x, y, obj_wethamtornado))
            {
                state = wrstates.wait
                image_xscale = 1.5
                image_yscale = 1.5
                image_speed = 0.45
                image_alpha = 0.8
                sprite_index = spr_w_windspin
            }
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/windwhirl", x, y)
            hsp = 0
            movespeed = 8
            vsp = -11
            image_index = 0
            sprite_index = spr_w_spinball
            state = states.mach4
        }
        return true;
    }
    return false;
}