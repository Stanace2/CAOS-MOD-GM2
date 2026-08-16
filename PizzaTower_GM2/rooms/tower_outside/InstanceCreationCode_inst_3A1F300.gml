targetRoom = tower_entrancehall;
targetDoor = "C";
if ((!obj_player1.ispeppino || obj_player1.characterID == characters.noise) && !global.swapmode)
{
	ini_open_from_string(obj_savesystem.ini_str);
	if (ini_read_string("Game", "finalrank", "none") != "none")
	{
		targetRoom = tower_peppinohouse;
		instance_create(0, 0, obj_puff_house);
	}
	ini_close();
}
