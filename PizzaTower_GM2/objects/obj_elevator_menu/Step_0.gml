if ( menu_state != "done" ) obj_player1.state = states.victory;

if (input_delay > 0)
{
    input_delay--;
    exit;
}
if (instance_exists(obj_fadeout))
{
    exit;
}

switch (menu_state)
{
    case "menu":
        if (keyboard_check_pressed(vk_down))
            selected_index = min(selected_index + 1, array_length(floors) - 1);
        if (keyboard_check_pressed(vk_up))
            selected_index = max(selected_index - 1, 0);

        if (keyboard_check_pressed(vk_enter))
        {
            target_room = floors[selected_index].room;
            fmod_event_one_shot_3d("event:/sfx/misc/elevatorstart", x, y);
            menu_state = "shaking";
            shake_timer = 60;
        }

        if (keyboard_check_pressed(ord("P")))
        {
            target_room = global.elevator_return_room;
            fmod_event_one_shot_3d("event:/sfx/misc/elevatorstart", x, y);
            menu_state = "shaking";
            shake_timer = 60;
        }
        break;

    case "shaking":
        shake_timer--;
        if (shake_timer <= 0)
        {
            fmod_event_one_shot_3d("event:/sfx/misc/keyunlock", x, y);
			
			global.elevator_transition = true;
            obj_player1.visible      = true;
            obj_player1.sprite_index = obj_player1.spr_lookdoor;
            obj_player1.image_index  = 0;
            obj_player1.targetRoom   = target_room;
            obj_player1.targetDoor   = "ELEV";
            obj_player1.state        = states.door;
            instance_create(x, y, obj_fadeout);

            menu_state = "done";
        }
        break;
}