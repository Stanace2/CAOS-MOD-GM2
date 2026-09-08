if (instance_exists(other.baddieID) && other.baddieID.invtime == 0 && other.baddieID.state != states.grabbed && (!other.baddieID.invincible) && other.baddieID.instantkillable)  
{  
    var _player = obj_player1  
    if (player_id == 2)  
        _player = obj_player2  
    var _solid = collision_line(_player.x, _player.y, other.baddieID.x, other.baddieID.y, obj_solid, 0, 1)  
    var _destructible = collision_line(_player.x, _player.y, other.baddieID.x, other.baddieID.y, obj_destructibles, 0, 1)  
    if (_solid == -4 || _destructible != -4)  
    {  
        if (room == boss_pizzaface && (other.baddieID.object_index == obj_pepperman || other.baddieID.object_index == obj_vigilanteboss || other.baddieID.object_index == obj_noiseboss || other.baddieID.object_index == obj_fakepepboss || other.baddieID.object_index == obj_pizzafaceboss_p3))  
        {  
            baddiegrabbedID = other.baddieID  
            with (other.baddieID)  
            {  
                grabbedby = 1  
                scr_boss_grabbed()  
            }  
        }  
        else  
        {  
            other.baddieID.invtime = 15  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/slash", x, y)  
            var mcqueen = _player.movespeed  
            if (_player.kpulsebuffer > 0)  
                mcqueen = _player.fakehsp  
            if (mcqueen < 18)  
                _player.movespeed = mcqueen + 3  
            else  
                _player.movespeed = mcqueen + 1.5  
            if (_player.movespeed < 12)  
                _player.movespeed = 12  
            _player.kpulsebuffer = 0  
            _player.hsp = _player.xscale * _player.movespeed  
            with (instance_create((x + 50 * _player.xscale + _player.hsp), y, obj_wethamtornado))  
            {  
                state = states.normal
                image_xscale = _player.xscale  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_windpulse  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/speedboost", x, y)  
            if (!other.baddieID.important)  
            {  
                global.style += (5 + global.combo)  
                global.combotime = 60  
                global.heattime = 60  
            }  
            var lag = 2  
            other.baddieID.hitLag = lag  
            other.baddieID.hitX = other.baddieID.x  
            other.baddieID.hitY = other.baddieID.y  
            other.baddieID.mach3destroy = 1  
            other.baddieID.hp -= 1  
            instance_create(other.baddieID.x, other.baddieID.y, obj_parryeffect)  
            other.baddieID.alarm[3] = 3  
            other.baddieID.state = states.hit
            if (other.baddieID.x != x)  
                other.baddieID.image_xscale = sign(x - other.baddieID.x)  
            else  
                other.baddieID.image_xscale = (-image_xscale)  
            instance_create(x, y, obj_slapstar)  
            instance_create(x, y, obj_slapstar)  
            instance_create(x, y, obj_slapstar)  
            instance_create(x, y, obj_baddiegibs)  
            instance_create(x, y, obj_baddiegibs)  
            instance_create(x, y, obj_baddiegibs)  
            with (obj_camera)  
            {  
                shake_mag = 3  
                shake_mag_acc = 3 / room_speed  
            }  
            other.baddieID.invtime = 30  
            other.baddieID.hitvsp = -4  
            other.baddieID.hithsp = (-other.baddieID.image_xscale) * 22  
        }  
    }  
}