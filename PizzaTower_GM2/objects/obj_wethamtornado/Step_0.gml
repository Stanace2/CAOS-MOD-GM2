switch state  
{  
	// Wind, if windboost, follows the player a lil while
    case states.normal:  
        if (sprite_index == spr_w_windpulse && floor(image_index) < 6)  
        {  
            x = obj_player1.x - 70 * obj_player1.xscale  
            y = obj_player1.y  
        }  
        if (floor(image_index) == (image_number - 1))  
            instance_destroy()  
        break  
    // Superjump tornado
    case states.Sjump:  
        x = obj_player1.x  
        y = obj_player1.y  
        break  
}  
  
if (obj_player1.state != states.Sjump && state == states.Sjump)  
    instance_destroy()