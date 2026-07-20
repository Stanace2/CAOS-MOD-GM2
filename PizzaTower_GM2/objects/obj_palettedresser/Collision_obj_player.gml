if (other.key_up2 && (!display) && other.ispeppino == ispeppino && other.state == states.normal)  
{  
    obj_camera.chargecamera = 0  
    usebuffer = 20  
    display = 1  
    // I hijacked this state to make a sort of "freeze" state
    other.state = states.transitioncutscene 
    other.sprite_index = other.spr_idle
    other.hsp = 0  
    other.movespeed = 0  
    other.vsp = 0  
    other.image_speed = 0.35  
    // Creation of dresser GUI Background
    instance_create(x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]), obj_dresserbg) 
    // This is unsued vvv 
    var _player = -2  
    // Defines which actor to spawn
    var pep = 0  
    if (!ispeppino)  
        pep = 1  
    var actors = actor_array[pep]  
    with (obj_player1)  
        var pal = (ispeppino ? get_pep_palette_info() : get_noise_palette_info())  
    var _relx = 0  
    var _rely = 0  
    for (var i = 0; i < array_length(actors); i++)  
    {  
        for (var j = 0; j < array_length(actors[i]); j++)  
        {  
	        // Create every actor
            with (instance_create((obj_player1.x - camera_get_view_x(view_camera[0]) + _relx), (obj_player1.y - camera_get_view_y(view_camera[0]) + _rely), obj_dresseractor))  
            {  
                sprite_index = choose(obj_player1.spr_idle, obj_player1.spr_3hpidle, obj_player1.spr_rageidle, obj_player1.spr_idle1, obj_player1.spr_idle2, obj_player1.spr_idle3, obj_player1.spr_idle4)  
                image_index = 0  
                if actors[i][j][1]  
                    unlocked = 1  
                palettespr = pal.spr_palette  
                paletteindex = actors[i][j][2]  
                if (array_length(actors[i][j]) > 3)  
                    palettetexture = actors[i][j][3]  
            }  
            // If the actor spawned has the same palette selected as the player, safe its position for later
            if ((actors[i][j][2] == obj_player1.paletteselect && array_length(actors[i][j]) <= 3) || (array_length(actors[i][j]) > 3 && actors[i][j][3] == global.palettetexture))  
            {  
                fmod_event_one_shot_3d("event:/sfx/misc/clotheswitch", x, y)  
                scolumn = i  
                srow = j  
            }  
            _rely += 100  
        }  
        _rely = 0  
        _relx += 100  
    }  
    // Move all actors to match the current player palette with the actor with the same palette
    with (obj_dresseractor)  
    {  
        relx -= (100 * other.scolumn)  
        rely -= (100 * other.srow)  
    }  
}