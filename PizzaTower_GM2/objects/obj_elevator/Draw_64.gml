if ( state == ELEVATOR.DOOR_CLOSING ) 
{
	if ( elevator_door_frame >= 6 )
	{
		draw_sprite( spr_elevator_interior, elevator_interior_frame, 0, 0 );
	}
	
	draw_sprite( spr_elevator_door_anim, elevator_door_frame, 0, 0 );
}

if ( state == ELEVATOR.DOOR_OPENING ) 
{
	if ( elevator_door_frame <= 4 )
	{
		draw_sprite( spr_elevator_interior, elevator_interior_frame, 0, 0 );
	}
	
	draw_sprite( spr_elevator_door_anim, elevator_door_frame, 0, 0 );
}

if ( state == ELEVATOR.ARRIVING ) 
{
	if ( elevator_door_frame <= 4 )
	{
		draw_sprite( spr_elevator_interior, elevator_interior_frame, 0, 0 );
	}
	
	draw_sprite( spr_elevator_door_anim, elevator_door_frame, 0, 0 );
}

if ( state == ELEVATOR.OCCUPIED )
{
	draw_sprite( spr_elevator_interior, elevator_interior_frame, 0, 0 );
	draw_set_halign( fa_center );
	
	var x_pos = display_get_gui_width() / 2;
	var y_pos = display_get_gui_height() / 5;
	
	for ( i = 0; i < array_length( floors ); i++ )
	{
		var s_floor = floors[i];
		var selected = ( selected_floor == s_floor );
		
		if ( selected ) draw_text_color( x_pos, y_pos, s_floor.label, c_yellow, c_yellow, c_yellow, c_yellow, 1 )
		else draw_text_color( x_pos, y_pos, s_floor.label, c_white, c_white, c_white, c_white, 1 )
		
		y_pos += 40;
	}
}

if ( state == ELEVATOR.MOVING )
{
	draw_sprite( spr_elevator_interior, elevator_interior_frame, 0 + x_shake, 0 + y_shake );
}