John pillar got some changes
## Create

~~~js
hp = 0  
image_speed = 0.35  
depth = 2  
// THIS HERE IS NEW
force = 0  // Prevents pizza time shenanigans to happen when destroyed. 0 = pizza time
if (room == rm_editor)  
{  
    if place_meeting(x, (y + 32), obj_solid)  
    {  
        while (!(place_meeting(x, (y + 1), obj_solid)))  
            y += 1  
    }  
}
~~~
## Destroy

~~~js
if (room == rm_editor)  
    return;  
if force  
    return;  
if (ds_list_find_index(global.saveroom, id) == -1 && global.snickchallenge == 0)  
{  
    if global.caoschase  
    {  
        with (obj_chaosUI)  
            event_perform(ev_other, ev_room_start)  
        with (obj_chaoschaser)  
            event_perform(ev_other, ev_room_start)  
        if (!global.kpanic)  
        {  
            with (obj_player)  
            {  
                hsp = 0  
                vsp = 0  
                global.noisejetpack = 0  
                global.startgate = 0  
                stop_music()  
                if (global.collect <= 0)  
                    global.collect = 10  
                scr_do_rank()  
            }  
            return;  
        }  
    }  
    if (room == tower_finalhallway)  
        global.leveltosave = "exit"  
    with (obj_baddie)  
    {  
        if (escape == 1)  
        {  
            visible = 1  
            instance_create(x, y, obj_genericpoofeffect)  
        }  
    }  
    fmod_event_instance_play(global.snd_johndead)  
    var combototal = 10 + (floor(global.combo * 0.5))  
    global.collect += combototal  
    global.comboscore += combototal  
    global.combo += 1  
    global.enemykilled += 1  
    global.combotime = 60  
    global.fill = 4000  
    notification_push((20 << 0), [room])  
    switch room  
    {  
        case entrance_10:  
            global.fill = 1860  
            break  
        case 53:  
            global.fill = 2040  
            break  
        case 69:  
            global.fill = 2160  
            break  
        case 88:  
            global.fill = 2460  
            break  
        case 725:  
            global.fill = 2556  
            break  
        case 131:  
            global.fill = 2640  
            break  
        case 152:  
            global.fill = 1920  
            break  
        case 694:  
            global.fill = 2100  
            break  
        case 712:  
            global.fill = 2220  
            break  
        case 700:  
            global.fill = 2520  
            break  
        case 365:  
            global.fill = 2220  
            break  
        case 237:  
            global.fill = 3240  
            break  
        case 682:  
            global.fill = 2280  
            break  
        case 381:  
            global.fill = 3300  
            var lay = layer_get_id("Backgrounds_scroll")  
            layer_set_visible(lay, 1)  
            break  
        case 827:  
            global.fill = 2760  
            break  
        case 456:  
            global.fill = 2640  
            break  
        case 257:  
            lay = layer_get_id("Backgrounds_stillH1")  
            layer_background_sprite(layer_background_get_id(lay), 3450)  
            global.fill = 2520  
            break  
        case 606:  
            global.fill = 2460  
            break  
        case 735:  
            global.fill = 4056  
            break  
    }  
  
    with (instance_create(x, y, obj_sausageman_dead))  
    {  
        var debris = id  
        sprite_index = spr_hungrypillar_dead  
        if (room == tower_finalhallway)  
            sprite_index = spr_protojohn  
    }  
    with (instance_create_unique(0, 0, 387))  
        debrisid = debris  
    with (obj_tv)  
        chunkmax = global.fill  
    with (obj_escapecollect)  
    {  
        gotowardsplayer = 0  
        movespeed = 5  
        image_alpha = 1  
    }  
    with (obj_escapecollectbig)  
        image_alpha = 1  
    fmod_event_instance_play(global.snd_escaperumble)  
    obj_camera.alarm[1] = 60  
    instance_create(x, y, obj_bangeffect)  
    instance_create(x, y, obj_slapstar)  
    instance_create(x, y, obj_slapstar)  
    instance_create(x, y, obj_slapstar)  
    instance_create(x, y, obj_baddiegibs)  
    instance_create(x, y, obj_baddiegibs)  
    instance_create(x, y, obj_baddiegibs)  
    if (global.coop == 1)  
    {  
        obj_player1.x = x  
        obj_player2.x = x  
        obj_player1.y = y  
        obj_player2.y = y  
    }  
    with (obj_camera)  
    {  
        shake_mag = 3  
        shake_mag_acc = 3 / room_speed  
    }  
    instance_destroy()  
    fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
    instance_create(x, (y + 600), obj_itspizzatime)  
    global.panic = 1  
    switch room  
    {  
        case entrance_10:  
            global.minutes = 2  
            global.seconds = 30  
            break  
        case 53:  
            global.minutes = 2  
            global.seconds = 15  
            break  
        case 69:  
            global.minutes = 2  
            global.seconds = 59  
            break  
        case 88:  
            global.minutes = 4  
            global.seconds = 30  
            break  
        case 253:  
            global.minutes = 3  
            global.seconds = 15  
            break  
        case 259:  
            global.minutes = 4  
            global.seconds = 0  
            break  
        case 90:  
            global.minutes = 0  
            global.seconds = 59  
            break  
        case 546:  
            global.minutes = 2  
            global.seconds = 30  
            break  
        case 131:  
            global.minutes = 3  
            global.seconds = 59  
            break  
        case 152:  
            global.minutes = 3  
            global.seconds = 59  
            break  
        case 227:  
            global.minutes = 3  
            global.seconds = 12  
            break  
        case 193:  
            global.minutes = 3  
            global.seconds = 30  
            break  
        case 199:  
            global.minutes = 3  
            global.seconds = 30  
            break  
        case 237:  
            global.minutes = 7  
            global.seconds = 30  
            break  
        case 365:  
            global.minutes = 5  
            global.seconds = 30  
            break  
        case 381:  
            global.minutes = 5  
            global.seconds = 30  
            break  
        case 397:  
            global.minutes = 5  
            global.seconds = 30  
            break  
        case 408:  
            global.minutes = 5  
            global.seconds = 30  
            break  
        case 430:  
            global.minutes = 6  
            global.seconds = 30  
            break  
        case 440:  
            global.minutes = 5  
            global.seconds = 30  
            break  
        case 523:  
            global.minutes = 6  
            global.seconds = 30  
            break  
        case 503:  
            global.minutes = 9  
            global.seconds = 59  
            break  
        case 496:  
            global.minutes = 3  
            global.seconds = 30  
            break  
        case 829:  
            global.minutes = 2  
            global.seconds = 15  
            break  
        default:  
            global.minutes = 5  
            global.seconds = 30  
            break  
    }  
  
    ds_list_add(global.saveroom, id)  
}
~~~
## RoomStart

~~~js
if (ds_list_find_index(global.saveroom, id) != -1)  
    instance_destroy()  
if (global.snickchallenge == 1)  
    instance_destroy()  
if (room == tower_finalhallway)  
    sprite_index = spr_protojohn  
// Chaos barrier spawner
if (global.caoschase && global.ktoppins && global.ktoppingoal != 0)  
{  
    if (obj_chaoschaser.toppins != global.ktoppingoal)  
    {  
        with (instance_create(x, y, obj_chaosbarrier))  
            image_xscale = other.image_xscale  
        force = 1  
        instance_destroy()  
    }  
}  
// I think there was a redundancy problem, so this is here to fix it
if global.panic  
{  
    force = 1  
    instance_destroy()  
}
~~~