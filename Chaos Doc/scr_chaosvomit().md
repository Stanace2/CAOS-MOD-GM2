Tummy hurts
~~~js
function scr_chaosvomit() //gml_Script_scr_chaosvomit  
{  
    var relstate = (108 << 0)  
    if (trstored == (47 << 0) || trstored == (38 << 0) || trstored == (49 << 0))  
        relstate = (47 << 0)  
    if (trstored == (10 << 0))  
        relstate = (10 << 0)  
    if (trstored == (16 << 0))  
        relstate = (16 << 0)  
    if (trstored == (113 << 0) || trstored == (114 << 0) || trstored == (115 << 0) || trstored == (116 << 0))  
        relstate = (114 << 0)  
    if (trstored == (33 << 0) || trstored == (34 << 0) || trstored == (35 << 0))  
        relstate = (35 << 0)  
    with (targetplayer)  
    {  
        sprite_index = spr_rockethitwall  
        if (relstate == (47 << 0))  
            sprite_index = spr_knightpepfall  
        if (relstate == (10 << 0))  
            sprite_index = spr_firemouthspin  
        if (relstate == (16 << 0))  
            sprite_index = spr_ghostidle  
        if (relstate == (114 << 0))  
            sprite_index = spr_barrelfall  
        if (relstate == (35 << 0))  
            sprite_index = spr_boxxedpepair  
        if isgustavo  
        {  
            sprite_index = spr_lonegustavo_jumpstart  
            relstate = (192 << 0)  
        }  
        vsp = 10  
        visible = 1  
        state = relstate  
    }  
}
~~~