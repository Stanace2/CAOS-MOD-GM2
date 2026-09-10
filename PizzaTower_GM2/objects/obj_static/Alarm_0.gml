with (obj_player1) {
	x = roomstartx;
	y = roomstarty;
	landAnim = false;
	if (!isgustavo)
		state = states.normal;
	else
		state = states.ratmount;
	hsp = 0;
	vsp = 0;
	movespeed = 0;
	clingexitspeed = 0;
	ratmount_movespeed = 0;
}
static_dir = -1;
fmod_event_one_shot("event:/sfx/ui/tvswitchback");
