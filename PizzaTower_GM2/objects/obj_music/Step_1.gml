if (instance_exists(obj_player1))
{
	/*
	if (obj_player1.ispeppino || room == Mainmenu)
	{
		fmod_set_parameter("isnoise", 0, true);
	}
	else
	{
		fmod_set_parameter("isnoise", 1, true);
	}
	*/
	with (obj_player1) {
		switch characterID {
			case characters.dos:
				fmod_set_parameter("characterID", 0, true);
				break
			case characters.pep:
				fmod_set_parameter("characterID", 11, true);
				break
			case characters.noise:
				fmod_set_parameter("characterID", 12, true);
				break
		}
	}
}
fmod_set_parameter("swapmode", global.swapmode ? 1 : 0, true);
