image_xscale = 1;
image_speed = 0.5;
vsp = 10;
state = states.jump;
superslam = false;
pizzahead_x = 0;
pizzahead_front = false;
piledrivershot = false;
snd = fmod_event_create_instance("event:/sfx/pizzahead/finale");
if (room == boss_pizzafacefinale)
{
	image_speed = 2;
	vsp = -10;
	alarm[0] = 250;
	beatdown1_lay = layer_get_id("Backgrounds_sky4");
	beatdown2_lay = layer_get_id("Backgrounds_sky5");
	beatdown3_lay = layer_get_id("Backgrounds_sky3");
	layer_vspeed(beatdown3_lay, 1.9);
	layer_vspeed(beatdown2_lay, 1.7);
	layer_vspeed(beatdown1_lay, 1.8);
}
sprite_index = obj_player.spr_vspizzahead_beatdown1
spr_beatdown1 = sprite_index
spr_beatdown2 = obj_player.spr_vspizzahead_beatdown2
spr_beatdown3 = obj_player.spr_vspizzahead_beatdown3
spr_beatdown4 = obj_player.spr_vspizzahead_beatdown4
spr_beatdown5 = obj_player.spr_vspizzahead_beatdown5
spr_beatdown6 = obj_player.spr_vspizzahead_beatdown6
spr_beatdown7 = obj_player.spr_vspizzahead_beatdown7
spr_beatdown8 = obj_player.spr_vspizzahead_beatdown8
spr_beatdown9 = obj_player.spr_vspizzahead_beatdown9
spr_beatdown10 = obj_player.spr_vspizzahead_beatdown10
spr_beatdown11 = obj_player.spr_vspizzahead_beatdown11
spr_beatdown12 = obj_player.spr_vspizzahead_beatdown12
spr_beatdown13 = obj_player.spr_vspizzahead_beatdown13
spr_beatdown14 = obj_player.spr_vspizzahead_beatdown14
spr_beatdown15 = obj_player.spr_vspizzahead_beatdown15
spr_piledrive = obj_player.spr_vspizzahead_piledriver
spr_piledrive_closeup = obj_player.spr_vspizzahead_piledriver_closeup