var exc = (place_meeting((x + hsp), y, obj_destructibles) || place_meeting((x + hsp), y, obj_metalblock))  
var coll = (scr_solid((x + image_xscale), y) || place_meeting((x + hsp), y, obj_hallway))  
var slope = place_meeting((x + hsp), y, obj_slope)  
switch state  
{  
    case mbstates.rolling:  
        if (movespeed < 15)  
            movespeed = 15  
        if (floor(image_index) == (image_number - 1))  
        {  
            switch sprite_index  
            {  
                case spr_m_bb:  
                    sprite_index = spr_m_bb_loop  
                    break  
                case spr_m_bb_air:  
                    sprite_index = spr_m_bb_air_loop  
                    break  
            }  
  
        }  
        if (coll && (!exc) && (!slope))  
        {  
            if (place_meeting((x + hsp), y, obj_hallway) || place_meeting((x + image_xscale), y, obj_hallway))  
            {  
                image_xscale *= -1  
                fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
                if (!grounded)  
                {  
                    state = mbstates.ball
                    sprite_index = spr_m_roll  
                    vsp = 10  
                    hover = 0  
                }  
                else  
                    sprite_index = spr_m_bb  
                movespeed = 15  
                return;  
            }  
            else  
            {  
                var _climb = mango_ledge_bump(40)  
                if _climb  
                {  
                    if mango_ledge_bump((vsp >= 0 ? 32 : 22))  
                    {  
                        image_xscale *= -1  
                        fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                        instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
                        if (!grounded)  
                        {  
                            state = mbstates.ball 
                            sprite_index = spr_lonebrick_roll  
                            vsp = 10  
                            hover = 0  
                        }  
                        else  
                            sprite_index = spr_m_bb  
                        movespeed = 15  
                        return;  
                    }  
                }  
            }  
        }  
        if ((!grounded) && (sprite_index == spr_m_bb || sprite_index == spr_m_bb_loop))  
        {  
            sprite_index = spr_m_bb_air  
            image_index = 0  
        }  
        if (grounded && (sprite_index == spr_m_bb_air || sprite_index == spr_m_bb_air_loop))  
        {  
            sprite_index = spr_m_bb  
            image_index = 0  
        }  
        if ((!grounded) && vsp < 10)  
            vsp++  
        if grounded  
        {  
            var sauce = 0  
            for (var i = 0; i < 2; i++)  
            {  
                if (collision_line((x + sauce * image_xscale), y, (x + sauce * image_xscale), (y + 200), obj_boilingsauce, false, true) != -4)  
                {  
                    if (!(place_meeting((x + sauce * image_xscale), (y + 1), obj_platform)))  
                    {  
                        sprite_index = spr_m_bb_jump  
                        state = mbstates.longjump
                        vsp = -6.5  
                    }  
                }  
                sauce += 70  
            }  
            if (obj_player1.state == states.jump || abs(obj_player1.hsp) < 9)  
            {  
                var sitbox = -25  
                for (i = 0; i < 3; i++)  
                {  
                    if place_meeting((x + sitbox), y, obj_player1)  
                    {  
                        with (instance_place((x + sitbox), y, obj_player1))  
                        {  
                            if (vsp > 2)  
                            {  
                                global.combotime = 60  
                                fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/roar", x, y)  
                                fmod_event_one_shot("event:/sfx/misc/collectpizza")  
                                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmmount", x, y)  
                                instance_create(other.x, other.y, obj_genericpoofeffect)  
                                instance_destroy(other)  
                                brick = 1  
                                if (state != states.normal && state != states.machslide && state != states.jump && state != states.mach3)  
                                {  
                                    with (instance_create(x, y, obj_mango_companion))  
                                        wait = 1  
                                    brick = 0  
                                }  
                                return;  
                            }  
                        }  
                    }  
                    sitbox += 25  
                }  
            }  
        }  
        break  
    case mbstates.longjump:  
        if (movespeed < 15)  
            movespeed = 15  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_m_bb_jump)  
                sprite_index = spr_m_bb_jump_loop  
        }  
        if (grounded && vsp > 0.5)  
        {  
            sprite_index = spr_m_bb  
            image_index = 0  
            state = mbstates.rolling
            return;  
        }  
        if (coll && (!exc))  
        {  
            image_xscale *= -1  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
            state = mbstates.bodyslam
            vsp = 0  
            sprite_index = spr_lonemango_groundpound_start  
            movespeed = 15  
            return;  
        }  
        break  
    case (2 << 0):  
        movespeed = 0  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_lonemango_groundpound_start)  
                sprite_index = spr_lonemango_groundpound  
        }  
        if grounded  
        {  
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            with (obj_camera)  
            {  
                shake_mag = 5  
                shake_mag_acc = 15 / room_speed  
            }  
            with (obj_baddie)  
            {  
                if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                {  
                    state = states.stun
                    if (stunned < 60)  
                        stunned = 60  
                    vsp = -8  
                    image_xscale *= -1  
                    hsp = 0  
                    momentum = 0  
                }  
            }  
            with (obj_camera)  
            {  
                shake_mag = 10  
                shake_mag_acc = 30 / room_speed  
            }  
            create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
            state = mbstates.rolling
            sprite_index = spr_m_bb  
            image_index = 0  
            return;  
        }  
        if (vsp < 20)  
            vsp++  
        break  
    case mbstates.callback:  
        vsp = 0  
        movespeed = Approach(movespeed, 0, 1)  
        if (floor(image_index) == (image_number - 1))  
            image_index = image_number - 1  
        break  
    case mbstates.ball:  
        if grounded  
        {  
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            with (obj_camera)  
            {  
                shake_mag = 5  
                shake_mag_acc = 15 / room_speed  
            }  
            with (obj_baddie)  
            {  
                if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                {  
                    state = states.stun
                    if (stunned < 60)  
                        stunned = 60  
                    vsp = -8  
                    image_xscale *= -1  
                    hsp = 0  
                    momentum = 0  
                }  
            }  
            with (obj_camera)  
            {  
                shake_mag = 10  
                shake_mag_acc = 30 / room_speed  
            }  
            create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
            state = mbstates.rolling
            sprite_index = spr_m_bb  
            image_index = 0  
            return;  
        }  
        if (coll && (!exc))  
        {  
            image_xscale *= -1  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            instance_create((x + image_xscale * 10), (y + 20), obj_bumpeffect)  
            movespeed = 15  
        }  
        if (vsp < 10)  
            vsp = 10  
        break  
    case mbstates.verticalhallway:  
        visible = false  
        sprite_index = spr_mango_cries  
        vsp = 0  
        movespeed = 0  
        break  
}  
  
if (hover > 0)  
{  
    hover--  
    if (vsp > -0.5)  
        vsp = 0  
}  
if (sit_buffer > 0)  
    sit_buffer--  
if (state != mbstates.verticalhallway)  
{  
    var killbox = -25  
    for (i = 0; i < 3; i++)  
    {  
        if place_meeting((x + killbox), y, obj_baddie)  
        {  
            with (instance_place((x + killbox), y, obj_baddie))  
            {  
                if ((parryable != 0 || supertauntable != 0) && destroyable != 0)  
                    instance_destroy()  
            }  
        }  
        killbox += 25  
    }  
}  
if exc  
{  
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
}  
if grounded  
    movespeed = Approach(movespeed, 15, 0.05)  
if (sprite_index == spr_lonebrick_roll)  
    image_speed = 0.55  
else  
    image_speed = 0.35  
scr_collide()