enum ELEVATOR
{
	IDLE,
	DOOR_CLOSING,
	DOOR_OPENING,
	OCCUPIED,
	MOVING,
	ARRIVING
}

floors = 
[
	{
		"label": "Floor 1",
		"floor": tower_entrancehall
	},
	{
		"label": "Floor 2",
		"floor": tower_2
	},
	{
		"label": "Floor 3",
		"floor": tower_3
	},
	{
		"label": "Floor 4",
		"floor": tower_4
	},
	{
		"label": "Floor 5",
		"floor": tower_5
	},
]

index = 0;
current_floor_index = 0;

x_shake = 0;
y_shake = 0;
shake_timer = 0;

selected_floor = floors[index];

uparrowID = scr_create_uparrowhitbox();
depth = 50;
image_speed = 0;

state = ELEVATOR.IDLE;

// DOOR OP | CLOSE ANIM
elevator_door = spr_elevator_door_anim;
elevator_door_frames = sprite_get_number( elevator_door )
elevator_door_speed = 0;
elevator_door_frame = 0;

// INTERIOR
elevator_interior = spr_elevator_interior;
elevator_interior_frames = sprite_get_number( elevator_interior );
elevator_interior_speed = 0;
elevator_interior_frame = 0;

