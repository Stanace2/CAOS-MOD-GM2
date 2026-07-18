## obj_tv
### Step
~~~js
// This goes in the giant switch obj_tv has
// Additions to idle anims
// Inside state switch
case spr_tv_idleN:  // Inside sprite_index switch
	if (idleanim > 0)  
		idleanim--  
	if (sprite_index != idlespr)  
		sprite_index = idlespr  
	if (idleanim <= 0 && floor(image_index) == (image_number - 1))  
	{  
		sprite_index = choose(spr_tv_idleanim1, spr_tv_idleanim2, spr_tv_idleanim3, spr_tv_idleanim4)  
	if (!obj_player1.ispeppino)  
	{  
		if (sprite_index == spr_tv_idleanim3 || sprite_index == spr_tv_idleanim4)  
			sprite_index = spr_tv_idleanim1N  
		if (sprite_index == spr_tv_idleanim1)  
			sprite_index = spr_tv_idleanim1N  
		if (sprite_index == spr_tv_idleanim2)  
			sprite_index = spr_tv_idleanim2N  
	}  
	image_index = 0  
	}  
	break
case spr_tv_idleanim1:  
case spr_tv_idleanim2:  
case spr_tv_idleanim3:  
case spr_tv_idleanim4:

// Inside expression switch, the additional sprites go there
switch expressionsprite  
{  
	case spr_tv_exprhurt:  
	case spr_tv_exprhurted:  
	case spr_tv_exprhurtN:
		if (obj_player1.state != (107 << 0))  
		{  
			if (expressionbuffer > 0)  
				expressionbuffer--  
			else  
			{  
				state = (250 << 0)  
				expressionsprite = -4  
			}  
		}  
		break
	case spr_tv_exprcollect:  
	case spr_tv_exprcollect2:  
	case spr_tv_exprcheese:  
	case spr_tv_exprtomato:  
	case spr_tv_exprsausage:  
	case spr_tv_exprpinapple:  
	case spr_tv_exprshroom:  
	case spr_tv_exprcollectN:  
	case spr_tv_happyG:  
		if (expressionbuffer > 0)  
			expressionbuffer--  
		else  
		{  
			state = (250 << 0)  
			expressionsprite = -4  
		}  
		break
}
~~~