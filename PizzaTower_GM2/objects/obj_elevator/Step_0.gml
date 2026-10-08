switch ( state )
{
	case ELEVATOR.IDLE:
		switch ( room )
		{
			case ( tower_entrancehall ):
				index = 0;
				current_floor_index = 0;
			break;
	
			case ( tower_2 ):
				index = 1;
				current_floor_index = 1;
			break;
	
			case ( tower_3 ):
				index = 2;
				current_floor_index = 2;
			break;
	
			case ( tower_4 ):
				index = 3;
				current_floor_index = 3;
			break;
	
			case ( tower_5 ):
				index = 4;
				current_floor_index = 4;
			break;
	
			default:
				index = 0;
				current_floor_index = 5;
			break;
		}
		if ( !place_meeting( x, y, obj_player ) && ANIMATION_END )
		{
			image_speed = -1;
		}

		if ( !place_meeting( x, y, obj_player ) && floor( image_index ) == 0 )
		{
			image_speed = 0;
			//fmod_event_one_shot_3d("event:/sfx/knight/lose", x, y);
		}
		
		if ( place_meeting( x, y, obj_player ) )
		{
			with ( obj_player1 )
			{
				if ( grounded )
				{
					if ( key_up )
					{
						state = states.door;
						image_index = 0;
						sprite_index = spr_lookdoor;
						image_speed = 0.35;
					}
					
					other.image_speed = 1;
				}
				
				if ( sprite_index == spr_lookdoor && image_index >= floor( image_number - 1 ) )
				{
					other.state = ELEVATOR.DOOR_CLOSING;
					other.elevator_door_frame = 0;
				}
			}
			
			if ( ANIMATION_END ) image_speed = 0;
		}
	
	break;
	
	case ELEVATOR.DOOR_CLOSING:
	
		elevator_door_speed += 0.35;
		elevator_door_frame = floor( elevator_door_speed );
		
		if ( elevator_door_frame >= 6 )
		{
			elevator_interior_speed += 0.35;
			elevator_interior_frame = floor( elevator_interior_speed );
		}
		
		if ( elevator_door_frame >= elevator_door_frames )
		{
			//fmod_event_one_shot_3d("event:/sfx/knight/lose", x, y);
			state = ELEVATOR.OCCUPIED;
			elevator_door_speed = 0;
		}
	
	break;
	
	case ELEVATOR.DOOR_OPENING:
		with ( obj_player1 ) 
		{ 
			sprite_index = spr_idle; 
			image_index = 0;
		}
		
		elevator_door_speed += 0.35;
		elevator_door_frame = floor( elevator_door_speed );
		
		elevator_interior_speed += 0.35;
		elevator_interior_frame = floor( elevator_interior_speed % elevator_interior_frames );
		
		if ( elevator_door_frame >= elevator_door_frames )
		{
			with ( obj_player1 ) { state = states.normal;}
			state = ELEVATOR.IDLE;
			elevator_door_speed = 0;
			elevator_interior_speed = 0;
		}
	
	break;
	
	case ELEVATOR.ARRIVING:
		with ( obj_player1 ) 
		{ 
			sprite_index = spr_idle; 
			image_index = 0;
		}
		
		elevator_door_speed += 0.35;
		elevator_door_frame = floor( elevator_door_speed );
		
		elevator_interior_speed += 0.35;
		elevator_interior_frame = floor( elevator_interior_speed % elevator_interior_frames );
		
		if ( elevator_door_frame >= 9 )
		{
			//fmod_event_one_shot_3d("event:/sfx/misc/elevatorstart", x, y);
			with ( obj_player1 ) { state = states.normal;}
			with ( obj_player )
			{
				targetRoom = other.selected_floor.floor;
				targetDoor = "ELEV";
				instance_create( x, y, obj_fadeout );
			}
			elevator_door_speed = 0;
			elevator_interior_speed = 0;
			state = ELEVATOR.IDLE;
		}
	
	break;
	
	case ELEVATOR.OCCUPIED:
		scr_menu_getinput()
		elevator_interior_speed += 0.35;
		elevator_interior_frame = floor( elevator_interior_speed % elevator_interior_frames );
		
		with ( obj_player1 )
		{
			if ( other.key_back || other.key_quit )
			{
				other.state = ELEVATOR.DOOR_OPENING;
				other.elevator_door_frame = 0;
				other.elevator_door_speed = 0;
			}
			
			if ( other.key_up2 )
			{
				other.index = ( other.index - 1 ) mod 5;
				if ( other.index < 0 ) other.index = 4;
			}
			
			if ( other.key_down2 )
			{
				other.index = ( other.index + 1 ) mod 5;
			}
			
			other.selected_floor = other.floors[ other.index ];
			
			if ( other.key_jump2 || other.key_start )
			{
				if ( other.index == other.current_floor_index )
				{
					other.state = ELEVATOR.DOOR_OPENING;
					other.elevator_door_frame = 0;
					other.elevator_door_speed = 0;
				}
				else
				{
					other.state = ELEVATOR.MOVING
					other.shake_timer = abs( other.index - other.current_floor_index ) * 0.3;
				}
			}
		}
	break;
	
	case ELEVATOR.MOVING:
		elevator_interior_speed += 0.35;
		elevator_interior_frame = floor( elevator_interior_speed % elevator_interior_frames );
		
		if ( shake_timer != 0 )
		{
			x_shake = random_range( -3, 3 );
			y_shake = random_range( -3, 3 );
			shake_timer = Approach( shake_timer, 0, 0.04 );
		}
		else
		{
			x_shake = 0;
			y_shake = 0;
		
			state = ELEVATOR.ARRIVING;
			elevator_door_frame = 0;
			elevator_door_speed = 0
		}
	break;
}