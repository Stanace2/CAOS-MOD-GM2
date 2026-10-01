global.roommessage = "GARRY IN THE PIZZA TOWER";
global.gameframe_caption_text = "A familiar place...";
global.leveltorestart = room;
obj_player1.backtohubroom = tower_entrancehall;
obj_player1.backtohubstartx = 352;
obj_player1.backtohubstarty = 690;
if (!obj_secretmanager.init)
{
	obj_secretmanager.init = true;
	secret_add(function()
	{
		touchedtriggers = 0;
	}, function()
	{
		if (touchedtriggers >= 6)
		{
			secret_open_portal(0);
		}
	});
	secret_add(noone, function()
	{
		secret_open_portal(1);
	});
	secret_add(noone, function()
	{
		if (secret_check_trigger(2))
		{
			secret_open_portal(2);
		}
	});
}