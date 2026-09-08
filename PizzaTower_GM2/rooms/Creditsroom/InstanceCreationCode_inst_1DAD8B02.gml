state = 2;
instance_destroy(obj_introprop);
whitefade = 0;
spawn_buffer = 90;
if (!obj_player1.ispeppino || obj_player1.characterID == characters.noise || global.swapmode)
{
	instance_create(0, 0, obj_noisecreditmanager);
}
