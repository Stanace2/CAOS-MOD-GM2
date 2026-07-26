if ( place_meeting (x, y, obj_player1 ) && obj_player1.key_up && obj_player1.grounded
    && (obj_player1.state == states.normal || obj_player1.state == states.mach1
        || obj_player1.state == states.mach2 || obj_player1.state == states.mach3
        || obj_player1.state == states.pogo )
    && !instance_exists( obj_jumpscare ) && !instance_exists( obj_fadeout ) )
{
	global.elevator_transition = true;
    global.elevator_return_room = room;

    obj_player1.lastroom = room;
    fmod_event_one_shot( "event:/sfx/misc/door" );
    obj_player1.sprite_index = obj_player1.spr_lookdoor;
    obj_player1.image_index = 0;
    obj_player1.state = states.door;
    obj_player1.targetRoom = rm_elevator_interior;
    obj_player1.targetDoor = "ELEV";
    instance_create( x, y, obj_fadeout );
}