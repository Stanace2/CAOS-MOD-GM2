var _invex = obj_player1.characterID == characters.dos
if (state == states.ram && substate == states.ram)
{
	if (other.flash)
	{
		other.flash = false;
	}
	scr_hurtplayer(other);
}
else if ((other.instakillmove || other.state == states.handstandjump) && ((state == states.stun && savedthrown == thrown && !savedthrown) || ((!obj_player1.ispeppino || obj_player1.characterID == characters.noise || _invex) && state == states.ram && substate == states.land)) && elitehit == 1)
{
	scr_boss_do_hurt_phase2(other.id);
}
