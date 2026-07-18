## scr_playersounds()
A list of changes made to the global script name "scr_playersounds()"

All of these sounds are described in [[Fmod sound variables]]
### Mach 5 horn
#states
~~~js
//Mach 5
if (ispeppino && visible && dos && sprite_index == spr_dos_unhingedrun)  
{  
	if (!fmod_event_instance_is_playing(mach5snd))  
		fmod_event_instance_play(mach5snd)  
	fmod_event_instance_set_3d_attributes(mach5snd, x, y)  
}  
else  
	fmod_event_instance_stop(mach5snd, 1)

//Some changes to the normal mach sounds
if ((ispeppino && (state == (104 << 0) || state == (121 << 0) || state == (37 << 0))) || (state == (184 << 0) && sprite_index != spr_rocketstart))  
{  
	fmod_event_instance_set_paused(machsnd, 0)  
	if (!fmod_event_instance_is_playing(machsnd))  
		fmod_event_instance_play(machsnd)  
	var s = 0  
	if (state == (104 << 0) && sprite_index == spr_mach1 && grounded)  
		s = 1  
	else if ((state == (104 << 0) && sprite_index == spr_mach) || state == (37 << 0))  
		s = 2  
	else if (state == (121 << 0) && sprite_index != spr_crazyrun && sprite_index != spr_dos_unhingedrun)  
		s = 3  
	else if (sprite_index == spr_crazyrun || sprite_index == spr_dos_unhingedrun)  
		s = 4  
	if (state == (184 << 0))  
		s = 4  
	if ((sprite_index == spr_player_poundcancel || sprite_index == spr_player_rolljump) && abs(hsp) > 15)  
		s = 4  
	fmod_event_instance_set_3d_attributes(machsnd, x, y)  
	fmod_event_instance_set_parameter(machsnd, "state", s, 1)  
}  
else  
	fmod_event_instance_stop(machsnd, 1)
~~~

### Wetham and Mango related sounds
#states
~~~js
//Basically adds the characterID checker
if (visible && (isgustavo || characterID == 1) && (sprite_index == spr_player_ratmountattack || sprite_index == spr_player_mangoboost || sprite_index == spr_player_mangoboostend || sprite_index == spr_player_mangoboostfly || sprite_index == spr_player_ratmountmach3 || sprite_index == spr_player_ratmountdashjump || sprite_index == spr_lonegustavo_dash || sprite_index == spr_lonegustavo_mach3 || sprite_index == spr_lonegustavo_dashjump))  
{  
	if (!fmod_event_instance_is_playing(ratmountmachsnd))  
		fmod_event_instance_play(ratmountmachsnd)  
	s = 0  
	if (sprite_index == spr_player_ratmountmach3 || sprite_index == spr_player_mangoboost || sprite_index == spr_player_mangoboostend || sprite_index == spr_lonegustavo_mach3 || sprite_index == spr_player_ratmountdashjump || sprite_index == spr_lonegustavo_dashjump)  
		s = 1  
	fmod_event_instance_set_parameter(ratmountmachsnd, "state", s, 1)  
	if grounded  
		fmod_event_instance_set_parameter(ratmountmachsnd, "ground", 1, 1)  
	else  
		fmod_event_instance_set_parameter(ratmountmachsnd, "ground", 0, 1)  
	fmod_event_instance_set_3d_attributes(ratmountmachsnd, (x + hsp), (y + vsp))  
}  
else  
	fmod_event_instance_stop(ratmountmachsnd, 1)  

//This sound is not available in the new FMOD project, so i had to add it
if ((isgustavo || characterID == 1) && visible && (sprite_index == spr_player_ratmountattack || sprite_index == spr_lonegustavo_dash) && abs(hsp) > 6)  
{  
	if (!fmod_event_instance_is_playing(ratmountgallopsnd))  
		fmod_event_instance_play(ratmountgallopsnd)  
	fmod_event_instance_set_3d_attributes(ratmountgallopsnd, (x + hsp), (y + vsp))  
}  
else  
	fmod_event_instance_stop(ratmountgallopsnd, 1)  

//WM superjump management
if ((isgustavo || characterID == 1) && visible && (sprite_index == spr_m_lastbreath || sprite_index == spr_m_lastbreath_ceiling))  
{  
	if (sprite_index == spr_m_lastbreath)  
	{  
		if (!fmod_event_instance_is_playing(mangospinsnd))  
			fmod_event_instance_play(mangospinsnd)  
		fmod_event_instance_set_3d_attributes(mangospinsnd, x, y)  
	}  
	else  
		fmod_event_instance_stop(mangospinsnd, 1)  
	if (sprite_index == spr_m_lastbreath_ceiling)  
	{  
		if (!fmod_event_instance_is_playing(mangospinceilingsnd))  
			fmod_event_instance_play(mangospinceilingsnd)  
		fmod_event_instance_set_3d_attributes(mangospinceilingsnd, x, y)  
	}  
	else  
		fmod_event_instance_stop(mangospinceilingsnd, 1)  
}  
else  
{  
	fmod_event_instance_stop(mangospinsnd, 1)  
	fmod_event_instance_stop(mangospinceilingsnd, 1)  
}

//This one replaces the brickball sounds
if ((characterID == 1 && (brick || instance_exists(obj_mango_companion))) || instance_exists(obj_mango_brickball))  
{  
	if (instance_exists(obj_mango_brickball) && obj_mango_brickball.state == (0 << 0) && obj_mango_brickball.grounded)  
	{  
		if (!fmod_event_instance_is_playing(ratmountballsnd))  
			fmod_event_instance_play(ratmountballsnd)  
		fmod_event_instance_set_3d_attributes(ratmountballsnd, (obj_mango_brickball.x + obj_mango_brickball.hsp), (obj_mango_brickball.y + obj_mango_brickball.vsp))  
	}  
	else if (brick && grounded && ((state == (121 << 0) && movespeed >= 12) || state == (80 << 0) || sprite_index == spr_wm_pounce_slide))  
	{  
		if (!fmod_event_instance_is_playing(ratmountballsnd))  
			fmod_event_instance_play(ratmountballsnd)  
		fmod_event_instance_set_3d_attributes(ratmountballsnd, x, y)  
	}  
	else if (instance_exists(obj_mango_companion) && obj_mango_companion.grounded && obj_mango_companion.substate == (121 << 0))  
	{  
		if (!fmod_event_instance_is_playing(ratmountballsnd))  
			fmod_event_instance_play(ratmountballsnd)  
		fmod_event_instance_set_3d_attributes(ratmountballsnd, obj_mango_companion.x, obj_mango_companion.y)  
	}  
	else  
	fmod_event_instance_stop(ratmountballsnd, 1)  
}  
else  
	fmod_event_instance_stop(ratmountballsnd, 1)  

//Wetham kicking Mango management
if (state == (23 << 0) && (sprite_index == spr_lonegustavo_kick || sprite_index == spr_wetham_machmango_kick))  
{  
	if (!wethamkick)  
	{  
		fmod_event_instance_set_paused(snd_wethamkick, 0)  
		if (!fmod_event_instance_is_playing(snd_wethamkick))  
			fmod_event_instance_play(snd_wethamkick)  
		wethamkick = 1  
	}  
	fmod_event_instance_set_3d_attributes(snd_wethamkick, x, y)  
	s = 0  
	if (sprite_index == spr_wetham_machmango_kick)  
		s = 1  
	fmod_event_instance_set_parameter(snd_wethamkick, "state", s, 1)  
}  
else  
	wethamkick = 0
~~~

### Noise changes (add spin sounds to Donisha)
#states
==(Subject to change)==
~~~js
//Big conditional checking for noise, some sprite exceptions got added
if ((!ispeppino) || sprite_index == spr_player_poundcanceldive || sprite_index == spr_m_lastbreath_ceiling || sprite_index == spr_m_lastbreath || (sprite_index == spr_player_poundcancelstart && floor(image_index) > 2) || sprite_index == spr_player_poundcancel || (sprite_index == spr_player_rolljump && (!grounded)) || (sprite_index == spr_dive && canrollsnd))  
{  
	//Bounce of wall by dive sound addition and a variable canrollsnd (Pretty sure this can be acomplished more easily)
	if (state == (306 << 0) || (sprite_index == spr_player_rolljump && canrollsnd) || (sprite_index == spr_dive && canrollsnd) || (state == (61 << 0) && tauntstoredstate == (306 << 0)))  
	{  
		if (sprite_index != spr_playerN_divebomb && sprite_index != spr_playerN_divebombfall && sprite_index != spr_playerN_divebombland)  
		{  
			if fmod_event_instance_is_playing(snd_divebomb)  
				fmod_event_instance_stop(snd_divebomb, 1)  
			if ((!fmod_event_instance_is_playing(snd_wallbounce)) && (!fmod_event_instance_get_paused(snd_wallbounce)))  
				fmod_event_instance_play(snd_wallbounce)  
			if fmod_event_instance_get_paused(snd_wallbounce)  
				fmod_event_instance_set_paused(snd_wallbounce, 0)  
			fmod_event_instance_set_3d_attributes(snd_wallbounce, x, y)  
		}  
		else  
		{  
			if fmod_event_instance_is_playing(snd_wallbounce)  
				fmod_event_instance_stop(snd_wallbounce, 1)  
			if (!fmod_event_instance_is_playing(snd_divebomb))  
				fmod_event_instance_play(snd_divebomb)  
			fmod_event_instance_set_3d_attributes(snd_divebomb, x, y)  
			if (!grounded)  
				fmod_event_instance_set_parameter(snd_divebomb, "state", 0, 1)  
			else  
				fmod_event_instance_set_parameter(snd_divebomb, "state", 1, 1)  
		}  
	}  
	else  
	{  
	if (state == (84 << 0) && tauntstoredstate == (306 << 0))  
		fmod_event_instance_set_paused(snd_wallbounce, 1)  
	else if fmod_event_instance_is_playing(snd_wallbounce)  
		fmod_event_instance_stop(snd_wallbounce, 1)  
	if fmod_event_instance_is_playing(snd_divebomb)  
		fmod_event_instance_stop(snd_divebomb, 1)  
	}  
      
	//Same here, spin after machsplit
	if ((sprite_index == spr_playerN_sidewayspin || (sprite_index == spr_player_poundcancelstart && floor(image_index) > 2) || sprite_index == spr_player_poundcanceldive || sprite_index == spr_m_lastbreath_ceiling || sprite_index == spr_m_lastbreath || sprite_index == spr_player_poundcancel || (sprite_index == spr_player_poundcancelstart && floor(image_index) > 2) || sprite_index == spr_playerN_sidewayspinend) && (state == (104 << 0) || state == (108 << 0) || state == (121 << 0) || ((tauntstoredstate == (104 << 0) || tauntstoredstate == (121 << 0)) && state == (61 << 0))))  
	{  
		if (!fmod_event_instance_is_playing(snd_airspin))  
			fmod_event_instance_play(snd_airspin)  
		fmod_event_instance_set_3d_attributes(snd_airspin, x, y)  
	}  
	else if fmod_event_instance_is_playing(snd_airspin)  
	{  
	if (sprite_index == spr_mach || sprite_index == spr_mach4 || sprite_index == spr_crazyrun)  
		fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)  
	fmod_event_instance_stop(snd_airspin, 1)  
	}  
}
~~~