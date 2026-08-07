function scr_chaos_sounds() {
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
}