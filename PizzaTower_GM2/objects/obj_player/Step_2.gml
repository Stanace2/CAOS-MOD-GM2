player_index = swap_is_player2();
var pal = player_index;
if (global.swapmode && obj_savesystem.ispeppino)
{
	pal = !pal;
}
paletteselect = player_paletteselect[pal];
global.palettetexture = player_patterntexture[pal];
player_paletteindex = pal;
if (global.collect != global.lastcollect)
{
	var diff = global.collect - global.lastcollect;
	global.lastcollect = global.collect;
	if (global.swapmode)
	{
		global.collect_player[player_index] += diff;
	}
}
if characterID == characters.dos {
	fightmode = (instance_exists(obj_bosscontroller) && (!instance_exists(obj_pistolpickup)))
	if (sprite_index != spr_snapjumpstart && state != states.machcancel)  
	    snapjumps = 0
	if (state != states.machcancel)  
	    snaphold = 0
	if (movespeed < 21)  
	{  
	    if mach5  
	        alarm[11] = 350  
	    mach5 = 0  
	}
}
if keyboard_check(ord("1"))
{
    characterID = characters.dos
    scr_character_spr_init()
}
if keyboard_check(ord("1")) && key_attack
{
    characterID = characters.pep
    scr_character_spr_init()
}
if key_shoot2 && characterID == characters.noise {
	instance_create(x,y, obj_canonexplosion)
}
if keyboard_check_pressed(vk_f7)  
    displaykeys = (!displaykeys)  
if keyboard_check_pressed(vk_f6) { 
	debugmarkers = [0,0,0,0]
    displaydata = (!displaydata)
}
if (key_shoot2 || input_buffer_chaos > 0)  
    input_buffer_chaos++  
else  
    input_buffer_chaos = 0  
if ((!key_shoot) || input_buffer_chaos == -1)  
    input_buffer_chaos = 0