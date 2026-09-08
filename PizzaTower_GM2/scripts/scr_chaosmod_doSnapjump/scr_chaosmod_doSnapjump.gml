function doSnapjump()
{
	var _dsc = collision_line( x, (y + 1), x, (y + 10), obj_solid, 0, 1 )
	if ( _dsc != -4 && state != states.climbwall )
        return 0;
	var exec = sprite_index == spr_machsplit
	
	if 
	(
		(key_shoot2 || (input_buffer_chaos < 15 && input_buffer_chaos > 0 && state != states.climbwall)) && 
		ispeppino && 
		(characterID == characters.dos || characterID == characters.fdos) && 
		!global.manners && (!isgustavo) && state != states.freefall && (!exec)
	)
    {
        input_buffer_chaos = -1
        if (state == states.climbwall)
        {
            input_buffer_down = 0
            input_buffer_slap = 0
            poundbuffer = 15
            if (movespeed >= 12)
            {
                repeat (5)
                    instance_create(x, y, obj_firemouthflame)
            }
            fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
            if global.noisejetpack
                snapjumps += 1
            sprite_index = spr_snapjumpinter
            jumpstop = 1
            fmod_event_one_shot_3d("event:/sfx/pep/jump", x, y)
            image_index = 0
            vsp = -5
            movespeed = abs(wallspeed)
            hsp = 10 * xscale
            walljumpbuffer = 4
            state = states.machcancel
            return 1;
        }
        else if grounded
        {
            poundbuffer = 15
            input_buffer_slap = 0
            if (movespeed >= 12)
            {
                repeat (5)
                    instance_create(x, y, obj_firemouthflame)
            }
            fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
            if global.noisejetpack
                snapjumps += 1
            sprite_index = spr_snapjumpstart
            vsp = -9
            jumpstop = 1
            image_index = 0
            state = states.machcancel
            return 1;
        }
        else
        {
            poundbuffer = 15
            input_buffer_slap = 0
            if (movespeed >= 12)
            {
                repeat (5)
                    instance_create(x, y, obj_firemouthflame)
            }
            fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
            if global.noisejetpack
                snapjumps += 1
            if key_down
            {
                vsp = 0
                if (sprite_index == spr_rolljump || sprite_index == spr_spinkf)
                    vsp = -5
            }
            else
                vsp = -11
            sprite_index = spr_snapjumpinter
            jumpstop = 1
            image_index = 0
            state = states.machcancel
            return 1;
        }
    }
    return 0;
}