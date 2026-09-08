if (prem == 0)  
{  
    with (instance_create(x, y, obj_mangocomeback))  
    {  
        vsp = 0  
        fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
        sprite_index = spr_m_brokenneck 
        image_index = 0  
        stunned = 1  
        alarm[2] = 50  
    }  
    with (obj_camera)  
    {  
        shake_mag = 10  
        shake_mag_acc = 30 / room_speed  
    }  
    repeat (3)  
    {  
        with (create_debris(x, y, spr_slapstar))  
        {  
            hsp = random_range(-5, 5)  
            vsp = random_range(-10, 10)  
        }  
    }  
    instance_create(x, y, obj_bangeffect)  
    create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
}  
else  
{  
    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
    instance_create(x, y, obj_mangocomeback)  
}