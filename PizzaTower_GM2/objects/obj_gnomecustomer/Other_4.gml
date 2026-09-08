if ((!obj_player1.ispeppino || obj_player1.characterID == characters.noise) && ds_list_find_index(global.saveroom, id) != -1)
{
	instance_destroy();
}
