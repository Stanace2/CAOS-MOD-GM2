function scr_wmp_katana()
{  
    if (floor(image_index) < 4 && (!instance_exists(obj_slashhitbox)))  
    {  
        parry_inst = instance_create(x, y, obj_slashhitbox)  
        var _playerid = 1  
        if (object_index == obj_player2)  
            _playerid = 2  
        with (parry_inst)  
        {  
            player_id = _playerid  
            image_xscale = other.xscale  
        }  
    }  
    if (floor(image_index) >= 4 || sprite_index == spr_wethamclash)  
        instance_destroy(parry_inst)  
    image_speed = 0.35  
    var wall = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_solid, 0, 1)  
    var owb = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_onewaybigblock, 0, 1)  
    var owbc = false  
    if (owb != noone && owb.id.image_xscale == xscale)  
        owbc = true
    var cockblock = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_destructibles, 0, 1)  
    var cockblock2 = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_slope, 0, 1)  
    var checkclash = ((wall != obj_grindrailslope && wall != noone && (cockblock == -4 || cockblock == 4) && (cockblock2 == -4 || cockblock2 == 4)) || owbc)  
    if (checkclash && floor(image_index) < 2 && sprite_index != spr_wethamclash && grounded && (!(place_meeting(x, (y + 1), obj_slope))))  
    {  
        if (xscale == 1)  
            instance_create(wall.bbox_left, (y - 10), obj_bumpeffect)  
        else  
            instance_create(wall.bbox_right, (y - 10), obj_bumpeffect)  
        hsp = 6 * (-xscale)  
        image_index = 0  
        sprite_index = spr_wethamclash  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/clash", x, y)  
    }  
    if (sprite_index == spr_wethamclash)  
    {  
        if (floor(image_index) == (image_number - 1))  
        {  
            hsp = 0  
            ratmount_speed = 0  
            movespeed = 0  
            if (!grounded)  
            {  
                sprite_index = spr_fall  
                state = states.jump
            }  
            else  
                state = states.normal
        }  
        hsp = Approach(hsp, 0, 0.5)  
        katanawallexit = 0  
        return;  
    }  
    if scr_wmp_uppercut()  
        return;  
    move = key_left + key_right  
    if (movespeed < 12)  
        hsp = movespeed * (power(slashstored, -0.3)) * xscale  
    else  
        hsp = movespeed * xscale  
    if (slashstored <= 1 && image_index < 3)  
        vsp = 0  
    if (input_buffer_slap < 30 && input_buffer_slap != 0 && floor(image_index) == (image_number - 1))  
    {  
        input_buffer_slap = 0  
        particle_set_scale(particletypes.jumpdust, xscale, 1)  
        create_particle(x, y, particletypes.jumpdust, 0)  
        image_index = 0  
        slashstored++  
        if (sprite_index != spr_wethamslash)  
        {  
            sprite_index = spr_wethamslash  
            katanatype = 1  
        }  
        else  
        {  
            sprite_index = spr_wethamslash2  
            katanatype = 2  
        }  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/slashmiss", x, y)  
    }  
    if (floor(image_index) == (image_number - 1))  
    {  
        if grounded  
            slashstored = 0  
        if (movespeed >= 12)  
            state = states.mach3
        else if grounded  
        {  
            jumpAnim = true  
            landAnim = false  
            state = states.normal 
        }  
        else  
        {  
            sprite_index = spr_fall  
            state = states.jump
        }  
        scr_wm_doroll()  
        katanawallexit = 0  
    }  
    if (move != xscale && move != 0 && katanawallexit == 0)  
    {  
        if grounded  
            slashstored = 0  
        kpulsebuffer = 0  
        state = states.jump 
        image_index = 0  
        sprite_index = spr_wethamcansh  
        movespeed = 8  
        hsp = 0  
        return;  
    }  
    if (input_buffer_jump < 30 && input_buffer_jump != 0 && (grounded || coyote_time > 0))  
    {  
        slashstored = 0  
        input_buffer_down = 0  
        image_index = 3  
        state = states.mach2
        vsp = -11  
        jumpAnim = 1  
        kpulsebuffer = 0  
        if (movespeed < 12)  
            movespeed = 12  
        if (move != 0)  
            hsp = movespeed * move  
        else  
            hsp = movespeed * xscale  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
        sprite_index = spr_w_lonjump  
        katanawallexit = 0  
        return;  
    }  
    scr_wm_dokatana()  
    if (place_meeting((x + hsp), y, obj_solid) && place_meeting((x + hsp), y, obj_slope))  
        ledge_bump(40)  
    if (((!grounded) || place_meeting(x, (y + 1), obj_slope)) && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))))  
    {  
        slashstored = 0  
        with (instance_create(x, (y - 35 + vsp), obj_wethamtornado))  
        {  
            state = wrstates.wait
            image_xscale = other.xscale * 1.5  
            image_yscale = 1.5  
            image_index = 0  
            image_speed = 0.45  
            image_alpha = 0.8  
            sprite_index = spr_w_wallcurrent  
        }  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/wallcurrent", x, y)  
        if (grounded && movespeed < 16)  
            movespeed = 16  
        if ((fakehsp < 16 || movespeed < 16) && fakehsp != 0)  
            movespeed = 16  
        else if (fakehsp > movespeed)  
            movespeed = fakehsp  
        scr_wm_dowallcling()  
        vsp = -18.4  
        wallclingpulse = 30  
        katanawallexit = 0  
        return;  
    }  
}