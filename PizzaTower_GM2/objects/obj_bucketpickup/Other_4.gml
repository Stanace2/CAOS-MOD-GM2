if (ds_list_find_index(global.saveroom, id) != -1)
{
	instance_destroy();
}
if (obj_player1.ispeppino && obj_player1.characterID != characters.noise && !global.swapmode)
{
	instance_destroy();
}
