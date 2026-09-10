event_inherited();
walkspr = spr_noise_exitmove;
idlespr = spr_noise_exitidle;
image_speed = 0.35;
if (!obj_player1.ispeppino || obj_player1.characterID == characters.noise || global.swapmode)
{
	walkspr = spr_bucket;
	idlespr = spr_bucket;
	sprite_index = spr_bucket;
}
