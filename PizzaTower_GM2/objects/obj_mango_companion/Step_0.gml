switch state  
{  
	
    case mstates.follower:  
        if (playerid.state == states.victory || playerid.state == states.door || playerid.state == states.gottreasure)  
        {  
            instance_destroy()  
            playerid.brick = 1  
        }  
        if (playerid.state == states.backbreaker && state != mstates.taunt)  
        {  
            savedstate = state  
            savedsubstate = substate  
            savedsprite = sprite_index  
            savedin = image_index  
            state = mstates.taunt
        }  
        if (relativestate == states.ladder)  
            substate = states.ladder  
        if (relativestate == states.hurt)  
            substate = states.hurt  
        var _states = (obj_player1.state != states.normal && obj_player1.state != states.machslide && obj_player1.state != states.jump && obj_player1.state != states.mach3 && obj_player1.state != states.backtohub)  
        if (_states || (room == tower_soundtest && obj_soundtest.play) || obj_player1.sprite_index == obj_player1.spr_breakdance || (obj_player1.state == states.mach2 && sprite_index == spr_wethamwalljump))  
        {  
            wait = 1  
            if (obj_player1.movespeed < 16 && abs(obj_player1.hsp) < 16)  
                alarm[0] = 50  
            depth = obj_player1.depth + 1  
            comeback = 0  
            interp = 0.5  
        }  
        if (obj_player1.movespeed >= 16 && abs(obj_player1.hsp) >= 16)  
            alarm[0] = -1  
        if (comeback == 1)  
        {  
            var direx = point_direction(x, y, playerid.x, playerid.y)  
            x += lengthdir_x(cbspeed, direx)  
            y += lengthdir_y(cbspeed, direx)  
            cbspeed = Approach(cbspeed, 30, 1)  
        }  
        if (obj_player1.state == states.bump || obj_player1.state == states.climbwall || obj_player1.state == states.freefall)  
        {  
            xoffset = 0  
            yoffset = 0  
        }  
        else if (obj_player1.state == states.ladder)  
        {  
            xoffset = 0  
            yoffset = Approach(yoffset, -20, 50)  
        }  
        else  
        {  
            xoffset = Approach(xoffset, 80, 10)  
            yoffset = Approach(yoffset, 0, 10)  
        }  
        if (substate != states.normal)  
            relinterp = 1  
        else  
            relinterp = 0.2  
        if (obj_player1.breakdance_speed > 0.5)  
            sprite_index = spr_mango_bd  
        else if (room == tower_soundtest && obj_soundtest.play)  
            sprite_index = spr_mango_bd  
        else  
            scr_mangostates()  
        break  
    case mstates.taunt:  
        if (sprite_index != spr_lonemango_taunt)  
        {  
            sprite_index = spr_lonemango_taunt  
            image_index = irandom(sprite_get_number(sprite_index) - 1)  
            tauntID = instance_create(x, y, obj_baddietaunteffect)  
        }  
        if (sprite_index == spr_lonemango_taunt && playerid.state != states.backbreaker)  
        {  
            instance_destroy(tauntID)  
            state = savedstate  
            substate = savedsubstate  
            sprite_index = savedsprite  
            image_index = savedin  
        }  
        break  
    case mstates.comeback:  
        sprite_index = spr_lonebrick_roll  
        break  
    case mstates.flykick:  
        if (floor(image_index) == (image_number - 1))  
        {  
            if (sprite_index == spr_m_flykick)  
            {  
                with (instance_create(x, y, obj_mangocomeback))  
                {  
                    sprite_index = spr_m_flykicked  
                    comeback = 1  
                    comebackaccel = 2  
                }  
                poof = 0  
                instance_destroy()  
            }  
        }  
        scr_collide()  
        break  
}  
  
image_yscale = playerid.yscale * image_yscale  
visible = playerid.visible