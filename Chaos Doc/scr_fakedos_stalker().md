This needs some touch ups, using player states wont be as confusing when using the pt decomp
~~~js
function scr_fakedos_stalker() //gml_Script_scr_fakedos_stalker  
{  
    var dud = 1  
    if (!dud)  
    {  
        if (sightbuffer < 1 && chasedistance < 500 && grounded)  
        {  
            state = (1 << 0)  
            return;  
        }  
    }  
    grounded = scr_solid(x, (y + 1))  
    if (startbuffer < 1 && array_length(nodes) > 2)  
    {  
        if (array_length(nodes) > 0)  
        {  
            philly = nodes[0]  
            array_delete(nodes, 0, 1)  
            x = philly[0]  
            y = philly[1]  
            image_xscale = philly[2]  
            vsp = philly[3]  
            hsp = philly[4]  
            nodestate = philly[6]  
        }  
    }  
    var relstate = 0  
    switch nodestate  
    {  
        case (0 << 0):  
        case (92 << 0):  
            relstate = 0  
            break  
        case (104 << 0):  
            relstate = 1  
            break  
        case (121 << 0):  
            relstate = 2  
            break  
        case (306 << 0):  
            relstate = 3  
            break  
        case (42 << 0):  
            relstate = 4  
            break  
        case (99 << 0):  
        case (97 << 0):  
            relstate = 5  
            break  
        case (108 << 0):  
            relstate = 6  
            break  
        case (37 << 0):  
            relstate = 7  
            break  
        case (106 << 0):  
        case (92 << 0):  
            relstate = 8  
            break  
        case (105 << 0):  
            relstate = 9  
            break  
        case (5 << 0):  
        case (100 << 0):  
        case (101 << 0):  
            relstate = 10  
            break  
        case (93 << 0):  
            relstate = 11  
            break  
    }  
  
    switch substate  
    {  
        case (0 << 0):  
            if (relstate == 3)  
            {  
                sprite_index = spr_player_snapjumpinter  
                image_index = 0  
                substate = (3 << 0)  
                return;  
            }  
            if (sprite_index != spr_fd_jump && sprite_index != spr_fd_fall)  
            {  
                if (sprite_index != spr_fd_land)  
                {  
                    if (x != xprevious)  
                        sprite_index = spr_fd_move  
                    else  
                        sprite_index = spr_fd_idle  
                }  
                else if (floor(image_index) == (image_number - 1))  
                    sprite_index = spr_fd_idle  
                if (sprite_index == spr_fd_move)  
                {  
                    if ((!steppy) && (floor(image_index) == 2 || floor(image_index) == 7))  
                    {  
                        steppy = 1  
                        create_particle(x, (y + 38), (1 << 0), 0)  
                    }  
                    if (steppy && floor(image_index) != 2 && floor(image_index) != 7)  
                        steppy = 0  
                }  
                if (!grounded)  
                {  
                    if (vsp < 0)  
                    {  
                        with (instance_create(x, y, obj_highjumpcloud1))  
                        {  
                            if scr_solid(x, (y + 64))  
                            {  
                                while (!(scr_solid(x, (y + 1))))  
                                    y++  
                            }  
                        }  
                        sprite_index = spr_fd_jump  
                        image_index = 0  
                    }  
                    else  
                    {  
                        sprite_index = spr_fd_fall  
                        image_index = 0  
                    }  
                }  
            }  
            else  
            {  
                if (floor(image_index) == (image_number - 1))  
                {  
                    if (sprite_index == spr_fd_jump)  
                        sprite_index = spr_fd_fall  
                }  
                if grounded  
                {  
                    create_particle(x, y, (12 << 0), 0)  
                    sprite_index = spr_fd_land  
                    image_index = 0  
                }  
            }  
            break  
        case (1 << 0):  
            break  
        case (2 << 0):  
            break  
        case (3 << 0):  
            if grounded  
            {  
                sprite_index = spr_fd_land  
                image_index = 0  
                substate = (0 << 0)  
                return;  
            }  
            break  
        case (4 << 0):  
            break  
        case (5 << 0):  
            break  
        case (6 << 0):  
            break  
        case (7 << 0):  
            break  
        case (9 << 0):  
            break  
        case (10 << 0):  
            break  
        case (11 << 0):  
            break  
    }  
  
}
~~~