function scr_player_freefallland()
{
	switch characterID
    {
        case characters.dos:
        case characters.fdos:
            if !global.manners
            {
                scr_dos_freefallland()
                return;
            }
            break

        case characters.wm:
            scr_wmp_freefallland()
            return;
    }
	
	mach2 = 0;
	jumpAnim = true;
	dashAnim = true;
	landAnim = false;
	moveAnim = true;
	stopAnim = true;
	crouchslideAnim = true;
	crouchAnim = false;
	machhitAnim = false;
	movespeed = 0;
	facehurt = true;
	start_running = true;
	alarm[4] = 14;
	vsp = 0;
	hsp = 0;
	if (ANIMATION_END)
	{
		facehurt = true;
		sprite_index = spr_facehurtup;
		image_index = 0;
		state = states.normal;
		jumpstop = true;
	}
	image_speed = 0.35;
}
