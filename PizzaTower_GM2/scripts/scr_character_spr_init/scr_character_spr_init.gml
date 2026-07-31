function scr_character_spr_init() // starts only the necessary sprites for the characters
{  
    switch characterID  
    {  
        case characters.dos:  
			global.mach_color1 = make_colour_rgb(255, 0, 81); //water
			global.mach_color2 = make_colour_rgb(0, 255, 162); //melon
            scr_spr_dos()  
            break  
        case characters.wm:  
            //scr_spr_wm()  
            break  
        case characters.fdos:  
            //scr_spr_fakedos()  
            break  
		case characters.noise:	
			break
		case characters.pep:
			global.mach_color1 = make_colour_rgb(0, 214, 7); //green
			global.mach_color2 = make_colour_rgb(230, 14, 14); //red
			scr_spr_peppino()
			break
		default:
			characterID = characters.pep
			scr_character_spr_init()
			return;
    }  
	
	scr_spr_HUD()
	
	if instance_exists(obj_palettedresser) {
		with (obj_palettedresser)
			characterID = obj_player1.characterID
	}
}