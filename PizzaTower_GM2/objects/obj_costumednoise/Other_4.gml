if (!obj_player1.ispeppino || obj_player1.characterID == characters.noise || global.swapmode)
{
	sprite_index = spr_playerN_animatronic;
	y += 50;
}
event_inherited();
