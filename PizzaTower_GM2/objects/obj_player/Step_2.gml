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
if ((global.noisejetpack /*|| flamedash*/) && characterID == characters.dos && !global.manners)
{
    with (obj_iceblock_breakable)
    {
        if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))
        {
            instance_destroy()
            GamepadSetVibration(0, 0.5, 0.5, 0.8)
        }
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
if instance_exists(obj_debugcontroller) && obj_debugcontroller.DEBUG {
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
	if keyboard_check(ord("3")) && key_attack
	{
	    characterID = characters.noise
	    scr_character_spr_init()
	}
	if key_shoot2 && characterID == characters.noise {
		instance_create(x,y, obj_canonexplosion)
	}
}
if (key_shoot2 || input_buffer_chaos > 0)  
    input_buffer_chaos++  
else  
    input_buffer_chaos = 0  
if ((!key_shoot) || input_buffer_chaos == -1)  
    input_buffer_chaos = 0