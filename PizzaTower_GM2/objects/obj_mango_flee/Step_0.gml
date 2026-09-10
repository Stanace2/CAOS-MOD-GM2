switch state  
{  
    case mfstates.slip:  
        if (sprite_index != spr_mango_slip_bump)  
            sprite_index = spr_mango_slip  
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_mango_slip)  
            image_index = image_number - 1  
        hsp = launchforce * image_xscale  
        if (grounded && sprite_index == spr_mango_slip && launchbuffer == 0)  
        {  
            sprite_index = spr_mango_slip_bump  
            launchbuffer = 5  
            vsp = -9  
            launchforce /= 2  
            fmod_event_one_shot_3d("event:/sfx/pep/slipbump", x, y)  
            instance_create(x, (y + 39), obj_bangeffect)  
        }  
        if (grounded && launchbuffer == 0 && sprite_index == spr_mango_slip_bump)  
            state = mfstates.run 
        if ((scr_solid((x + sign(hsp)), y) || scr_solid((x + image_xscale), y)) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + image_xscale), y, obj_destructibles))))  
        {  
            image_xscale *= -1  
            fmod_event_one_shot_3d("event:/sfx/pep/slipbump", x, y)  
            instance_create((x + -35 * image_xscale), y, obj_bangeffect)  
        }  
        scr_collide()  
        break  
    case mfstates.run:  
        hsp = flee_speed * image_xscale  
        if (sprite_index != spr_mango_flee_bump)  
        {  
            if grounded  
                sprite_index = spr_mango_flee  
            else  
                sprite_index = spr_mango_flee_air  
        }  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_mango_flee_bump)  
                sprite_index = spr_mango_flee  
        }  
        var sitbox = -25  
        for (var i = 0; i < 3; i++)  
        {  
            if place_meeting((x + sitbox), y, obj_player1)  
            {  
                with (instance_place((x + sitbox), y, obj_player1))  
                {  
                    if (vsp > 2 && state != states.slipbanan)  
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
        var exc = (place_meeting((x + hsp), y, obj_destructibles) || place_meeting((x + hsp), y, obj_metalblock))  
        var coll = (scr_solid((x + image_xscale), y) || place_meeting((x + hsp), y, obj_hallway))  
        var slope = place_meeting((x + hsp), y, obj_slope)  
        if (coll && (!exc) && (!slope))  
        {  
            image_xscale *= -1  
            sprite_index = spr_mango_flee_bump  
            image_index = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            fmod_event_one_shot_3d("event:/sfx/pep/slipbump", x, y)  
            instance_create((x + -35 * image_xscale), y, obj_bangeffect)  
        }  
        if exc  
        {  
            instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
            instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
        }  
        toppins = instance_place(x, y, pizzakin)  
        if (toppins != noone)  
        {  
            with (obj_player)  
                other.toppins.force = 1  
        }  
        for (i = 0; i < array_length(collect); i++)  
        {  
            collectibles = instance_place(x, y, collect[i])  
            if (collectibles != noone)  
            {  
                with (obj_player)  
                {  
                    with (other.collectibles)  
                        event_perform(ev_collision, obj_player)  
                }  
            }  
        }  
        var banan = instance_place(x, y, obj_slipnslide)  
        if (banan != noone)  
        {  
            fmod_event_one_shot_3d("event:/sfx/pep/slip", x, y)  
            vsp = -11  
            state = mfstates.slip 
            launchforce = flee_speed + 4  
            launchbuffer = 5  
            sprite_index = spr_mango_slip  
            image_index = 0  
            instance_destroy(banan)  
            return;  
        }  
        scr_collide()  
        break  
}  
  
if (obj_player1.state == states.secretportal)  
{  
    instance_destroy()  
    instance_create(x, y, obj_genericpoofeffect)  
}  
if (state == mfstates.slip || state == mfstates.run)  
{  
    while scr_solid(x, y)  
    {  
        y--  
        if (!(scr_solid(x, y)))  
            break  
        else  
            continue  
    }  
}  
if (launchbuffer > 0)  
    launchbuffer--