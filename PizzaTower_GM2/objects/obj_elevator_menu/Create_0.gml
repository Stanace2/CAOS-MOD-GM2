x = room_width / 2;
y = room_height / 2;

input_delay = 12;
menu_state  = "menu";
shake_timer = 0;
target_room = noone;

floors = [
    { name: "Floor 1", room: tower_entrancehall },
    { name: "Floor 2", room: tower_2 },
    { name: "Floor 3", room: tower_3 },
    { name: "Floor 4", room: tower_4 },
    { name: "Floor 5", room: tower_5 },
];
selected_index = 0;

obj_player1.visible = false;
obj_player1.image_index = 0;
obj_player1.hsp = 0;
obj_player1.vsp = 0;