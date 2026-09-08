if (obj_player1.state == states.gottreasure)
	visible = false;
else
	visible = true;
if (instance_exists(obj_doornexthub)) {
	with (obj_doornexthub) {
		if (!key)
			key = true;
	}
}