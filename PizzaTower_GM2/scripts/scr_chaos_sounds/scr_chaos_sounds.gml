function scr_chaos_sounds() {
	// Donisha
	// Mach 5
	if (visible && sprite_index == spr_unhingedrun)
    {
        if (!fmod_event_instance_is_playing(mach5snd))
            fmod_event_instance_play(mach5snd)
        fmod_event_instance_set_3d_attributes(mach5snd, x, y)
    }
    else
        fmod_event_instance_stop(mach5snd, 1)
	// RollJump
	if (visible && sprite_index == spr_rolljump)
    {
        if (!fmod_event_instance_is_playing(rolljumpsnd))
            fmod_event_instance_play(rolljumpsnd)
        fmod_event_instance_set_3d_attributes(rolljumpsnd, x, y)
    }
    else
        fmod_event_instance_stop(rolljumpsnd, 1)
	// Spinning split shenanigans
	if (visible && ((sprite_index == spr_machsplit && floor(image_index) > 2) || sprite_index == spr_machdrill || sprite_index == spr_machsplit_loop))
    {
        if (!fmod_event_instance_is_playing(dosspinsnd))
            fmod_event_instance_play(dosspinsnd)
        fmod_event_instance_set_3d_attributes(dosspinsnd, x, y)
    }
    else
        fmod_event_instance_stop(dosspinsnd, 1)
		
	// WM
	// MangoKicking
	if (state == states.slap && (sprite_index == spr_w_kick || sprite_index == spr_wetham_machmango_kick))
    {
        if (!wethamkick)
        {
            fmod_event_instance_set_paused(snd_wethamkick, 0)
            if (!fmod_event_instance_is_playing(snd_wethamkick))
                fmod_event_instance_play(snd_wethamkick)
            wethamkick = 1
        }
        fmod_event_instance_set_3d_attributes(snd_wethamkick, x, y)
        var s = 0
        if (sprite_index == spr_wetham_machmango_kick)
            s = 1
        fmod_event_instance_set_parameter(snd_wethamkick, "state", s, 1)
    }
    else
        wethamkick = 0
	// Mach2
	if (characterID == 1 && visible && (sprite_index == spr_wm_attack || sprite_index == spr_w_dash) && abs(hsp) > 6)
    {
        if (!fmod_event_instance_is_playing(ratmountgallopsnd))
            fmod_event_instance_play(ratmountgallopsnd)
        fmod_event_instance_set_3d_attributes(ratmountgallopsnd, (x + hsp), (y + vsp))
    }
    else
        fmod_event_instance_stop(ratmountgallopsnd, 1)
	// Superjump
	if (characterID == 1 && visible && (sprite_index == spr_m_lastbreath || sprite_index == spr_m_lastbreath_ceiling))
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
	// Groundpound
	if (state == states.ratmountbounce && sprite_index == spr_wm_bombdive)
	{
		if (!fmod_event_instance_is_playing(wm_groundpoundsnd))
			fmod_event_instance_play(wm_groundpoundsnd);
	}
	else
		fmod_event_instance_stop(wm_groundpoundsnd, true);
	// Mango Rollerskates
	if (grounded && (state == states.punch || (state == states.tumble && sprite_index == spr_wm_pounce_slide) || state == states.mach3))
	{
		if (!fmod_event_instance_is_playing(m_rollingsound))
			fmod_event_instance_play(m_rollingsound);
		fmod_event_instance_set_3d_attributes(m_rollingsound, x, y)
	}
	else
		fmod_event_instance_stop(m_rollingsound, true);
}