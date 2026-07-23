function scr_character_spr_init() // starts only the necessary sprites for the characters
{  
    switch characterID  
    {  
        case 0:  
            scr_spr_dos()  
            break  
        case 1:  
            //scr_spr_wm()  
            break  
        case 10:  
            //scr_spr_fakedos()  
            break  
		case 11:
			scr_spr_peppino()
			break
		case 12:	
			break
    }  
}