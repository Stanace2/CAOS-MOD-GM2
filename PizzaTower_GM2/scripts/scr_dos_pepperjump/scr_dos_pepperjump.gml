function scr_dos_pepperjump() {
	landAnim = false;
	if (firemouth_afterimage > 0)
	{
		firemouth_afterimage--;
	}
	else if ((collision_flags & collisionflags.secret) == 0)
	{
		firemouth_afterimage = 8;
		with (create_firemouth_afterimage(x, y, sprite_index, image_index - 1, xscale))
		{
			playerid = other.id;
		}
	}
	move = key_left + key_right
	if move != 0 {
		xscale = move
		hsp = Approach(hsp, movespeed * xscale, 1)
	} else {
		if abs(hsp) < 12 
			hsp = Approach(hsp, 0, 1)
	}
	if vsp > 1 && key_jump2 {
		vsp = Approach(vsp, 4, 1)
	} else if key_down {
		vsp += 0.5
	}
	
	if ANIMATION_END && sprite_index == spr_pepperjump {
		sprite_index = spr_jetpackstart2
		fmod_event_instance_play(pizzapeppersnd);
		fmod_event_instance_set_parameter(pizzapeppersnd, "state", 0, true);
	}
	
	if (key_jump)
		scr_dopepperjump_chaos()
	
	if (input_buffer_slap > 0)
	{
		with (instance_create(x, y, obj_rocketdead))
		{
			sprite_index = spr_jetpackdebris;
		}
		input_buffer_slap = 0;
		particle_set_scale(particletypes.jumpdust, xscale, 1);
		create_particle(x, y, particletypes.jumpdust, 0);
		image_index = 0;
		sprite_index = spr_suplexdashjumpstart;
		flash = true;
		suplexmove = true;
		fmod_event_instance_play(suplexdashsnd);
		state = states.handstandjump;
		return;
	}
	if grounded && vsp >= 0.5 {
		if movespeed > 12 {
			flash = 1
			sprite_index = spr_mach4
			state = states.mach3
		} else if key_attack {
			flash = 1
			sprite_index = spr_mach
			state = states.mach2
		} else {
			sprite_index = spr_idle
			state = states.normal
		}
		return;
	} 
	doSnapjump()
	if sprite_index == spr_pepperjump
		image_speed = 0.45
	else
		image_speed = 0.35
	if (firemouth_afterimage > 0)
		firemouth_afterimage--;
	else
	{
		firemouth_afterimage = 8;
		with (create_firemouth_afterimage(x, y, sprite_index, image_index - 1, xscale))
		{
			playerid = other.id;
		}
	}
	with (obj_destructibles)
	{
		if (place_meeting(x - other.hsp, y, other) || place_meeting(x - other.xscale, y, other) || place_meeting(x, y - other.vsp, other) || place_meeting(x, y + 2, other))
		{
			instance_destroy();
			GamepadSetVibration(0, 0.4, 0.4, 0.8);
			if (other.vsp < 0)
			{
				other.vsp = -14;
			}
			else if (other.vsp > -11)
			{
				other.vsp = -11;
			}
			jumpstop = false;
		}
	}
	with (instance_place(x + xscale, y, obj_tntblock))
	{
		instance_destroy();
		if (other.vsp > -11)
		{
			other.vsp = -11;
		}
		jumpstop = false;
	}
	with (instance_place(x, y + 1, obj_tntblock))
	{
		instance_destroy();
		if (other.vsp > -11)
		{
			other.vsp = -11;
		}
		jumpstop = false;
	}
}