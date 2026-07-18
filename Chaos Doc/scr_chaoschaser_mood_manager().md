#states
I wont bother explaining whats happening here
~~~js
function scr_chaoschaser_mood_manager() //gml_Script_scr_chaoschaser_mood_manager  
{  
    var relpatience = 0  
    var relrage = ragebuffer  
    with (targetplayer)  
    {  
        var transfo = ((state == (47 << 0) && sprite_index == spr_knightpepstart) || (state == (10 << 0) && sprite_index == spr_firemouthintro) || (instance_exists(obj_sausageman_dead) && obj_sausageman_dead.sprite_index == spr_dead) || state == (214 << 0))  
        if ((state == (119 << 0) || transfo || state == (296 << 0) || state == (297 << 0) || state == (249 << 0) || state == (146 << 0) || state == (150 << 0) || state == (98 << 0) || state == (90 << 0) || state == (46 << 0) || state == (112 << 0) || state == (292 << 0)) && other.state != (8 << 0))  
            other.awake = 0  
        if (image_alpha >= 1 && (!global.panic) && global.kpm != 0 && (state == (52 << 0) || (state == (97 << 0) && sprite_index == spr_player_Sjumpcancelstart) || state == (99 << 0) || state == (24 << 0) || state == (25 << 0) || state == (26 << 0) || state == (101 << 0) || state == (100 << 0) || state == (106 << 0)))  
        {  
            if (other.patience == 0 && other.lock == 0)  
            {  
                other.lock = 1  
                switch state  
                {  
                    case (106 << 0):  
                        relpatience = 100  
                        break  
                    case (99 << 0):  
                        relpatience = 5  
                        break  
                    case (100 << 0):  
                    case (101 << 0):  
                        relpatience = 22  
                        break  
                    case (97 << 0):  
                        relpatience = 5  
                        break  
                    case (52 << 0):  
                        relpatience = 49  
                        break  
                    case (24 << 0):  
                    case (25 << 0):  
                    case (26 << 0):  
                        relpatience = 1000  
                        break  
                }  
  
                other.patience = floor(relpatience * global.kpm * (1 - relrage / 100))  
                other.ragebuffer = 3 + relrage * 4  
            }  
        }  
        else  
        {  
            other.lock = 0  
            other.patience = 0  
        }  
        if (state == (0 << 0) && abs(hsp) > 0 && move != 0)  
            other.patience--  
        var flamelazy = (flamedash && flamedashkick < 18 && state == (265 << 0))  
        if (other.patience == 0 && (other.verticalz || other.horizontalz || flamelazy))  
            other.slakin = 1  
        else  
            other.slakin = 0  
        if (abs(hsp) < 9.5 && abs(vsp) < 11 && other.state == (1 << 0))  
            other.slackfury = 1  
        else  
            other.slackfury = 0  
    }  
}
~~~