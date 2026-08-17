function scr_character_spr_init(_hud = true) // starts only the necessary sprites for the characters
{  
    switch characterID  
    {  
        case characters.dos:  
			global.mach_color1 = make_colour_rgb(255, 0, 81); //water
			global.mach_color2 = make_colour_rgb(0, 255, 162); //melon
            scr_spr_dos()  
            break  
        case characters.wm:  
			global.mach_color1 = make_colour_rgb(37, 255, 227) //sunset
			global.mach_color2 = make_colour_rgb(255, 108, 251) //waves
            scr_spr_wm()  
            break  
        case characters.fdos:  
			global.mach_color1 = make_colour_rgb(255, 0, 81); //water
			global.mach_color2 = make_colour_rgb(0, 255, 162); //melon
            //scr_spr_fakedos()  
            break  
		case characters.noise:	
			global.mach_color1 = make_colour_rgb(96, 208, 72); //green
			global.mach_color2 = make_colour_rgb(248, 0, 0); //red
			scr_spr_noise()
			break
		case characters.pep:
			global.mach_color1 = make_colour_rgb(96, 208, 72); //green
			global.mach_color2 = make_colour_rgb(248, 0, 0); //red
			scr_spr_peppino()
			break
    }  
	
	if _hud
		scr_spr_HUD()
	
	if instance_exists(obj_palettedresser) {
		with (obj_palettedresser)
			characterID = obj_player1.characterID
	}
	
	trace(concat("r 1. ",colour_get_red(global.mach_color1),colour_get_blue(global.mach_color1),colour_get_green(global.mach_color1)))
	trace(concat("r 2. ",colour_get_red(global.mach_color2),colour_get_blue(global.mach_color2),colour_get_green(global.mach_color2)))
	trace(concat("ch. ", characterID, " ", object_get_name(object_index)))
}