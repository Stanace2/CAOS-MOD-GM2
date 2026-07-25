function scr_character_spr_init() // starts only the necessary sprites for the characters
{  
    switch characterID  
    {  
        case characters.donisha:  
            scr_spr_dos()  
            break  
        case characters.wm:  
            //scr_spr_wm()  
            break  
        case characters.fdonisha:  
            //scr_spr_fakedos()  
            break  
		case characters.pep:
			scr_spr_peppino()
			break
		case characters.noise:	
			break
    }  
}