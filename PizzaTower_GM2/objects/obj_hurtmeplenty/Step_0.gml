if victim != -1 {
	victim.force_hurt = true;
	scr_hurtplayer(victim)
	times--;
}
if times == 0 {
	instance_destroy()
}