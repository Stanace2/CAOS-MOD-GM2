function c_Findcommand(_command_id) {
	for (var i = 0; i < ds_list_size(command_list); i++)
	{
		var b = ds_list_find_value(command_list, i);
		if (b.command_name == _command_id)
		{
			return b;
		}
	}
	return undefined;
}

function c_Firecommand(_command)
{
	if array_length(_command) > 0 {
		if (array_length(_command) > 7) {
			create_record("Error: Too many parameters","error")
			exit;
		}
		var c = c_Findcommand(_command[0])
		if c != undefined {
			array_delete(_command, 0, 1)
			c.Invoke(_command)
		} else {
			create_record("Error: Invalid command","error")
		}
	}
}

function c_Debugcommand(_id,_func,_params = "",_lists = undefined) constructor {
	command_name = _id;
	func = _func;
	Invoke = function(_id)
	{
		if (_id != undefined)
		{
			function_overload(_id, func);
		}
		else
		{
			func();
		}
	};
	params = _params;
	lists = _lists;
}

function c_Createcommands() {
	command_list = ds_list_create();
	
	PANIC = new c_Debugcommand("panic", function(_seconds) {
		if (_seconds != undefined && _seconds != "") {
			if get_number_string(_seconds) == "" {
				create_record("Error: Wrong parameter type","error")
				exit;
			}
		}
		
		if (_seconds != undefined && _seconds != "") {
			if (get_number_string(_seconds) < 0) {
				create_record("Error: Parameter can't be less than zero","error")
				exit;
			}
		}
		global.sv_cheats = true;
		if ((!global.panic && (_seconds == undefined || _seconds == "")) || _seconds == undefined || _seconds == "") {
			global.panic = !global.panic;
			create_record("Panic toggled","normal");
		} else {
			if (!global.panic)
				global.panic = !global.panic;
			create_record(concat("Panic set to ",_seconds," seconds"),"normal");
		}
		if (_seconds != undefined && _seconds != "")
		{
			_seconds = get_number_string(_seconds);
		}
		else
		{
			_seconds = 333;
		}
		global.fill = ceil(_seconds * 12);
		if (global.panic)
		{
			obj_camera.alarm[1] = 60;
		}
		obj_tv.chunkmax = global.fill;
	},
	"[seconds]");
	
	NOCLIP = new c_Debugcommand("noclip", function() {
		global.sv_cheats = true;
		with (obj_player1) {
			if state != states.debugstate {
				obj_CHAOSdevconsole.noclip_arguments = [sprite_index, state];
				state = states.debugstate;
				create_record("noclip ON","normal");
			}
			else {
				sprite_index = obj_CHAOSdevconsole.noclip_arguments[0];
				state = obj_CHAOSdevconsole.noclip_arguments[1];
				landAnim = true;
				create_record("noclip OFF","normal");
			}
		}
	});
	
	GOD = new c_Debugcommand("godmode", function() {
		global.sv_cheats = true;
		with (obj_player1) {
			if global.godmode
				create_record("godmode OFF","normal");
			else
				create_record("godmode ON","normal");
			global.boss_invincible = !global.boss_invincible;
			global.godmode = !global.godmode;
		}
	});
	
	LOCKCAMERA = new c_Debugcommand("camlock", function() {
		with (obj_camera) {
			lock = !lock;
			if lock
				create_record("Camera locked","normal");
			else
				create_record("Camera unlocked","normal");
		}
	});
	
	SHOW_HUD = new c_Debugcommand("showhud", function(_bool) {
		var _msg = ""
		if (_bool == undefined || _bool == "")
		{
			if obj_CHAOSdevconsole.showhud
				_bool = false;
			else
				_bool = true;
			_msg = "HUD visibility toggled";
		}
		if (typeof(_bool) == "string")
			_bool = get_bool(_bool);
		show_debug_message(!_bool);
		if (_bool != undefined && _bool != "")
		{
			if (_msg == "") {
				_msg = "HUD visibility";
				if (_bool)
					_msg += " ON"
				else
					_msg += " OFF"
			}
			obj_CHAOSdevconsole.showhud = _bool;
			global.option_hud = _bool;
			create_record(_msg,"normal");
		} else 
			create_record("Error: Invalid parameter","error");
	},
	"[bool]");
	
	P_RANK = new c_Debugcommand("p_rank", function() {
		global.sv_cheats = true;
		create_record("Impulse 1","normal")
		global.collect = global.srank + 5000;
		global.lap = true;
		global.treasure = true;
		global.secretfound = 3;
		global.combodropped = false;
		global.prank_enemykilled = true;
		global.combotime = 60;
		global.combo = 99;
		global.panic = true;
	});
	
	HIDETILES = new c_Debugcommand("hidetiles", function(_bool)
	{
		if (_bool != undefined && get_bool(_bool) == undefined) {
			create_record("Error: Invalid parameter","error");
			exit;
		}
		_bool = get_bool(_bool);
		if (_bool == undefined || _bool == "")
		{
			create_record("Tiles visibility toggled","normal")
			global.hidetiles = !global.hidetiles;
		}
		else
		{
			var _end = " OFF"
			if _bool
				_end = " ON"
			create_record(concat("Tiles visibility", _end),"normal")
			global.hidetiles = _bool;
		}
		layer_set_visible("Tiles_BG", !global.hidetiles);
		layer_set_visible("Tiles_BG2", !global.hidetiles);
		layer_set_visible("Tiles_BG3", !global.hidetiles);
		layer_set_visible("Tiles_1", !global.hidetiles);
		layer_set_visible("Tiles_2", !global.hidetiles);
		layer_set_visible("Tiles_3", !global.hidetiles);
		layer_set_visible("Tiles_4", !global.hidetiles);
		layer_set_visible("Tiles_Foreground1", !global.hidetiles);
		layer_set_visible("Tiles_Foreground2", !global.hidetiles);
		layer_set_visible("Tiles_Foreground3", !global.hidetiles);
	}, 
	"[bool]");
	
	ROOM = new c_Debugcommand("room", function(_room, _door) {
		if (_room == undefined || _room == "")
		{
			create_record("Error: Missing room parameter","error");
			exit;
		}
		if asset_get_type(_room) != asset_room {
			if (asset_get_index(_room) == -1)
				create_record("Error: Room does not exists","error");
			else 
				create_record("Error: Given asset name is not a room","error");
			exit;
		}
		if (_door == undefined || _door == "")
		{
			create_record("Error: Missing door parameter","error");
			exit;
		}
		if (get_number_string(_door) != "")
		{
			create_record("Error: Invalid parameter type 'Door'","error");
			exit;
		}
		if (string_length(_door) > 1) {
			create_record("Error: Incorrect parameter format 'Door'","error");
			exit;
		}
		if (_door != string_upper(_door)) {
			create_record("Error: Incorrect parameter format 'Door'","error");
			exit;
		}
		global.sv_cheats = true;
		_room = asset_get_index(_room);
		create_record(concat("Room set to: ",room_get_name(_room)," at door ", _door),"normal");
		with (obj_player)
		{
			targetRoom = _room;
			targetDoor = _door;
		}
		if obj_player1.targetRoom == room
			scr_room_goto(obj_player1.targetRoom)
		else
			instance_create(x, y, obj_fadeout);
	}, 
	"<room name>,<target door>",[0,rooms]);
	
	HURT = new c_Debugcommand("hurt",function(_obj,_amount) {
		if (_amount == undefined || _amount == "")
			_amount = 1;
		else if (get_number_string(_amount) == "") {
			create_record("Error: Incorrect parameter type 'Amount'","error");
			exit;
		}
		else 
			_amount = get_number_string(_amount)
			
		if (_amount <= 0) {
			create_record("Error: Amount can't be negative or zero","error");
			exit;
		}

		if (_obj == undefined || _obj == "" || _obj == "me") {
			obj_player1.force_hurt = true;
			with (instance_create_unique(0, 0, obj_hurtmeplenty)) {
				victim = obj_player1;
				times = _amount;
			}
			if _amount < 2
				create_record(concat("Hurting the player for ",_amount," times"),"normal");
			else
				create_record("Hurting the player","normal");
			exit;
		} 
		else if (asset_get_index(_obj) != -1) 
		{
			var _victim = asset_get_index(_obj)
			if (!object_exists(_victim)) { 
				create_record("Error: Given asset is not an object","error");
				exit;
			}
			if instance_exists(_victim) {
				// Animatronics
				if (_victim == obj_pineapplemonster || object_get_parent(_victim) == obj_monster || object_get_parent(_victim) == obj_robotmonster) {
					_victim = instance_nearest(obj_player1.x,obj_player1.y,_victim)
					instance_destroy(_victim)
					global.sv_cheats = true;
					if (_amount < 2)
						create_record(concat("Hurting baddie for ",_amount," times"),"normal");
					else
						create_record("Hurting baddie","normal");
					exit;
				}
				// Enemies and bosses
				if (object_get_parent(_victim) == obj_baddie) {
					_victim = instance_nearest(obj_player1.x,obj_player1.y,_victim)
					if _victim.elite {
						repeat (_amount) {
							_victim.elitehit--;
						}
					}
					else {
						baddieID = _victim;
						with (obj_player1) {
							Instakill();
						}
					}
					global.sv_cheats = true;
					if (_amount < 2)
						create_record(concat("Hurting baddie for ",_amount," times"),"normal");
					else
						create_record("Hurting baddie","normal");
					exit;
				}
				create_record(concat("Error: Given instance doesn't have health"),"error");
			}
			create_record(concat("Error: No instance ", _victim, " in the room"),"error");
		}
		else {
			create_record("Error: No asset under that name","error")
		}
		
	},
	"[object name],[amount]");
	
	OBJ_FIRE = new c_Debugcommand("obj_fire", function(_obj,_var,_val,_delay) {
		if (_obj == undefined || _obj == "") {
			create_record("Error: No asset provided","error");
			exit;
		}
		
		if (_var == undefined || _var == "") {
			create_record("Error: No variable name provided","error");
			exit;
		}
		
		if (_val == undefined || _val == "") {
			create_record("Error: No value provided","error");
			exit;
		}
		
		if (_val == "true")
			_val = 1;
		
		if (_val == "false")
			_val = 0;
		
		if (_obj == "obj_CHAOSdevconsole" || _obj == "obj_debugcontroller") {
			create_record("Error: GET OUT","error");
			exit;
		}
		
		if (_obj == "me")
			_obj = "obj_player1";
		
		if (asset_get_index(_obj) != -1) 
		{
			var _target = asset_get_index(_obj)
			if (!object_exists(_target)) {
				create_record("Error: Given asset is not an object","error");
				exit;
			}
			
			if (!instance_exists(_target)) {
				create_record(concat("Error: No instance ",object_get_name(_target), " in the room"),"error");
				exit;
			}
			
			_target = instance_nearest(obj_player1.x,obj_player1.y,_target)
			
			if (get_number_string(_var) != "") {
				create_record("Error: Incorrect variable format","error");
				exit;
			}
			
			if (variable_instance_exists(_target, _var)) {
				if (string_lettersdigits(_val) == "") {
					create_record("Error: Invalid value 'Value'","error");
					exit;
				}
				_val = embedded_variable(_val);
				if (_val == undefined) {
					create_record("Error: Embedded variable not found","error");
					exit;
				}
				if (get_number_string(_val) != "")
					_val = get_number_string(_val);
				fire_obj = _target;
				fire_var = _var;
				fire_val = _val;
				if (_delay == undefined)
					_delay = 1;
				if (get_number_string(_delay) == "") {
					create_record("Error: Invalid value 'Delay'","error");
					exit;
				}
				_delay = get_number_string(_delay);
				if (_delay < 0) {
					create_record("Error: Delay must be bigger than 0","error");
					exit;
				}
				if (_delay == 0)
					_delay = 1;
				global.sv_cheats = true;
				alarm[1] = _delay;
				if (_delay > 1)
					create_record(concat("Variable ",_var," from ",object_get_name(_target.object_index)," set to: ",_val, " in ",_delay," miliseconds from now"),"normal");
				else
					create_record(concat("Variable ",_var," from ",object_get_name(_target.object_index)," set to: ",_val),"normal");
			} else
				create_record("Error: Object variable doesn't exist","error");
		}
		else
			create_record("Error: No asset under that name","error");
	},
	"<object name>,<variable>,<value>,[delay - miliseconds]");
	
	RELOAD = new c_Debugcommand("reload", function() {
		with (obj_pause) {
			if (room == Endingroom || room == Creditsroom || room == Johnresurrectionroom)
			{
				exit;
			}
			pause_unpause_music();
			stop_music();
			scr_pause_stop_sounds();
			instance_destroy(obj_option);
			instance_destroy(obj_keyconfig);
			fmod_event_instance_stop(global.snd_bossbeaten, true);
			fmod_event_instance_stop(pausemusicID, true);
			obj_music.music = noone;
			var sl = ds_list_create();
			var il = ds_list_create();
			var arr = noone;
			ds_list_copy(sl, sound_list);
			ds_list_copy(il, instance_list);
			hub = false;
			arr = ["menugroup"];
			with (obj_player1)
			{
				character = "P";
				ispeppino = true;
				scr_characterspr();
			}
			offload_arr = arr;
			offload_textures = true;
			ds_list_add(il, id);
	
			obj_player1.targetRoom = Realtitlescreen;
			obj_player2.targetRoom = Realtitlescreen;
			room = Realtitlescreen;
			with (obj_player1)
			{
				character = "P";
				scr_characterspr();
			}
			global.leveltosave = noone;
			global.leveltorestart = noone;
			scr_playerreset();
			alarm[0] = 2;
			obj_player1.state = states.titlescreen;
			obj_player2.state = states.titlescreen;
			obj_player1.targetDoor = "A";
			if (instance_exists(obj_player2))
			{
				obj_player2.targetDoor = "A";
			}
			global.cowboyhat = false;
			global.coop = false;
			
			scr_pause_activate_objects();
			instance_destroy(obj_option);
			instance_destroy(obj_keyconfig);
			pause = false;
	
			ds_list_destroy(sl);
			ds_list_destroy(il);
		}
		game_restart();
	});
	
	FORCE_SAVE = new c_Debugcommand("force_save", function() {
		gamesave_async_save();
		gamesave_async_save_options();
	});
	
	PLACE = new c_Debugcommand("place", function(_obj,_x,_y,_arguments) {
		if (_obj == undefined || _obj == "") {
			create_record("Error: No asset provided","error");
			exit;
		}
		var _create = asset_get_index(_obj)
		if (_create == -1) {
			create_record("Error: No asset under that name","error");
			exit;
		}
		if (!object_exists(_create)) {
			create_record("Error: Given asset is not an object","error");
			exit;
		}
		
		if (_x == undefined || _x == "") {
			create_record("Error: No x coordinate provided","error");
			exit;
		}
		if (string_pos("~", _x) == 0) {
			_x = get_number_string(_x)
			if (_x == "") {
				create_record("Error: Invalid coordinate 'x'","error");
				exit;
			}
		} else {
			if (get_number_string(_x) == "")
				_x = obj_player1.x;
			else
				_x = obj_player1.x + get_number_string(_x);
		}
		
		if (_y == undefined || _y == "") {
			create_record("Error: No y coordinate provided","error");
			exit;
		}
		if (string_pos("~", _y) == 0) {
			_y = get_number_string(_y)
			if (_y == "") {
				create_record("Error: Invalid coordinate 'x'","error");
				exit;
			}
		} else {
			if (get_number_string(_y) == "")
				_y = obj_player1.y;
			else
				_y = obj_player1.y + get_number_string(_y);
		}
		
		var _error = false;
		var _json = undefined;
		if (_arguments != undefined && _arguments != "") {
			var _raw = _arguments;
			var _offset = 0;
			var _arrex = false;
			if (string_starts_with(_arguments,"{") && string_ends_with(_arguments,"}")) {
				for (var i = 1; i <= string_length(_arguments); i++) {
					if (string_char_at(_arguments, i) == "]")
						_arrex = false;
					if (string_char_at(_arguments, i) == "[" || _arrex) {
						_arrex = true;
						continue;
					}
					if (string_char_at(_arguments, i) == "{" || string_char_at(_arguments, i) == ",") {
						_raw = string_insert("\"", _raw, i + 1 + _offset);
						_offset++;
					}
					if (string_char_at(_arguments, i) == ":") {
						_raw = string_insert("\"", _raw, i + _offset);
						_offset++;
					}
				}
				
				try 
				{
					trace(_raw);
					_json = json_parse(_raw);
				}
				catch ( _exception)
				{
					create_record("Error: Malformed JSON","error");
					_error = true;
				}
	
			} else {
				create_record("Error: Malformed JSON","error");
				exit;
			}
		}
		
		if (!_error) {
			global.sv_cheats = true;
			with (instance_create(_x,_y,_create)) {
				if (is_struct(_json)) {
					var _arr = variable_struct_get_names(_json);
					if array_length(_arr) > 0 {
						for (var i = 0; i < array_length(_arr); i++)
							variable_instance_set(self, _arr[i], variable_struct_get(_json,_arr[i]));
					}
				} 
			}
			create_record(concat("Spawned ",object_get_name(_create)," at ",_x," ",_y),"normal");
		}
	},
	"<object name>,<x coordiante>,<y coordiante>,[{arguments}]");
	
	RESTART = new c_Debugcommand("restart", function() {
		
		if (room == rm_elevator_interior || 
			room == Realtitlescreen || 
			room == Longintro || 
			room == Mainmenu || 
			room == rank_room || 
			room == rm_levelselect || 
			room == timesuproom || 
			room == boss_room1 || 
			room == characterselect || 
			room == hub_loadingscreen
		)
		{
			create_record("Error: Invalid level to restart","error");
			exit;
		}
		
		var rm = global.leveltorestart;
		if ((string_copy(room_get_name(room), 1, 5) == "tower" && global.leveltorestart != tower_finalhallway) || global.leveltorestart == noone)
			rm = tower_entrancehall;
		
		create_record("Level reset","normal");
		
		audio_stop_all();
		stop_music();
		//instance_destroy(obj_chaosUI)
		scr_pause_stop_sounds();
		global.levelattempts++;
		ds_list_clear(global.saveroom);
		ds_list_clear(global.baddieroom);
		ds_list_clear(global.debris_list);
		ds_list_clear(global.collect_list);
		obj_music.music = -4;
		instance_destroy(obj_fadeout);
		global.levelreset = false;
		scr_playerreset();
		global.levelreset = true;
		obj_player1.targetRoom = rm;
		obj_player2.targetRoom = rm;
		scr_room_goto(rm);
		var _d = "A";
		if (rm == boss_pizzaface)
		    _d = "B";
		obj_player1.targetDoor = _d;
		obj_player1.restartbuffer = 15;
		obj_player2.restartbuffer = 15;
		if instance_exists(obj_player2)
		    obj_player2.targetDoor = _d;
		if (rm == boss_pizzaface || rm == boss_noise || rm == boss_pepperman || rm == boss_fakepep || rm == boss_vigilante)
		    global.bossintro = true;
	});
	
	TRANSFO = new c_Debugcommand("transfo", function(_sufix) {
		if (_sufix == undefined || _sufix == "") {
			create_record("Error: No trasformation sufix provided","error");
			exit;
		}
		
		var _found = false;
		for (var i = 0; i < ds_list_size(ID_transfos); i++)
		{
			if (ds_list_find_value(ID_transfos, i) == _sufix)
				_found = true;
		}

		if (!_found) {
			create_record("Error: Transformation not found","error");
			exit;
		}
		
		var _res = string_split(_sufix,":")[1];
		
		with (obj_player1) {
			if (PLAYER_LOCK) {
				create_record("Error: Player is not in a valid state","error");
				exit;
			}
			global.sv_cheats = true;
			switch (_res) {
				case "knight":
					fmod_event_one_shot_3d("event:/sfx/knight/start", x, y);
					momentum = false;
					movespeed = 0;
					image_index = 0;
					image_speed = 0.35;
					sprite_index = spr_knightpepstart;
					state = states.knightpep;
					hsp = 0;
					vsp = 0;
					notification_push(notifications.knight_obtained, [room]);
					create_transformation_tip(lang_get_value("knighttip"), "knight");
					break
				case "ball":
					state = states.tumble;
					movespeed = 10;
					vsp = 0;
					sprite_index = spr_tumble;
					break
				case "fireass":
					var _pindex = (object_index == obj_player1) ? 0 : 1;
					GamepadSetVibration(_pindex, 1, 1, 0.85);
					notification_push(notifications.touched_lava, [room]);
					state = states.fireass;
					vsp = -20;
					fireasslock = false;
					sprite_index = spr_fireass;
					image_index = 0;
					movespeed = hsp;
					fmod_event_one_shot_3d("event:/sfx/pep/burn", x, y);
					if (!fmod_event_instance_is_playing(global.snd_fireass))
					{
						fmod_event_instance_play(global.snd_fireass);
					}
					break
				case "firemouth":
					fmod_event_one_shot_3d("event:/sfx/firemouth/start", x, y);
					create_transformation_tip(lang_get_value("firemouthtip"), "firemouth");
					firemouthflames = false;
					is_firing = false;
					hsp = 0;
					movespeed = 0;
					state = states.firemouth;
					image_index = 0;
					sprite_index = spr_firemouthintro;
					bombpeptimer = 3;
					break
				case "ghost":
					if (characterID != characters.noise)
						create_transformation_tip(lang_get_value("ghosttip"), "ghost");
					else
						create_transformation_tip(lang_get_value("ghosttipN"), "ghostN");
					fmod_event_one_shot("event:/sfx/pep/ghostintro");
					grav = grav / 2;
					state = states.ghost;
					movespeed = hsp;
					ghostdash = false;
					ghostdashbuffer = 0;
					ghostpepper = 0;
					ghostangle = 0;
					ghosttimer = 0;
					sprite_index = spr_ghostidle;
					with (instance_create(x, y, obj_sausageman_dead))
					{
						hsp = other.image_xscale * 3;
						image_xscale = -other.image_xscale;
						sprite_index = other.spr_dead;
						spr_palette = other.spr_palette;
						paletteselect = other.paletteselect;
						oldpalettetexture = global.palettetexture;
					}
					break
				case "mort":
					repeat (6)
						create_debris(x, y, spr_feather);
					mort = true;
					movespeed = hsp;
					state = states.mort;
					fmod_event_one_shot_3d("event:/sfx/mort/mortpickup", x, y);
					create_transformation_tip(lang_get_value("morttip"), "morttip");
					break
				case "bitten":
					fmod_event_one_shot("event:/sfx/misc/watersplash");
					sprite_index = spr_scaredjump1;
					image_index = 0;
					image_speed = 0.35;
					state = states.fireass;
					movespeed = hsp;
					vsp = -14;
					instance_create(x, y + 20, obj_piranneapplewater);
					with (instance_create(x, y, obj_superdashcloud))
						sprite_index = spr_watereffect;
					break
				case "barrel":
					instance_create(x, y, obj_genericpoofeffect);
					movespeed = hsp;
					state = states.barrel;
					image_index = 0;
					create_transformation_tip(lang_get_value("barreltip"), "barrel");
					break
				case "rocket":
					xscale = other.image_xscale;
					state = states.rocket;
					if (obj_player1.characterID != characters.noise)
						create_transformation_tip(lang_get_value("rockettip"), "rocket");
					else
						create_transformation_tip(lang_get_value("rockettipN"), "rocketN");
					sprite_index = spr_rocketstart;
					image_index = 0;
					if (movespeed < 8)
						movespeed = 8;
					break
				case "cheeseball":
					hsp = 8 * xscale;
					movespeed = 8;
					state = states.cheeseball;
					stop_buffer = stop_max;
					repeat (8)
					{
						with (create_debris(x, y, spr_slimedebris))
						{
							vsp = random_range(-5, 0);
							hsp = random_range(-3, 3);
						}
					}
					break
				case "sticky_cheese":
					cheeseballbounce = 0;
					slopejump = false;
					fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
					image_index = 0;
					movespeed = 0;
					cheesepeptimer = 2;
					state = states.cheesepepjump;
					create_transformation_tip(lang_get_value("cheesedtip"), "cheesed");
					state = states.cheesepepstick;
					sprite_index = spr_cheesepepstickside;
					hsp = 0;
					vsp = 0;
					repeat (3)
						create_debris(x + (xscale * 30), y + random_range(-8, 8), spr_cheesechunk);
					movespeed = 0;
					break
				case "boxed":
					GamepadSetVibration(0, 1, 1, 0.65);
					fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
					if (state != states.boxxedpep)
						create_transformation_tip(lang_get_value((obj_player1.ispeppino && obj_player1.characterID != characters.noise) ? "boxxedtip" : "boxxedtipN"), (obj_player1.ispeppino && obj_player1.characterID != characters.noise) ? "boxxed" : "boxxedN");
					boxxed = true;
					movespeed = 0;
					state = states.boxxedpep;
					if (sprite_index != spr_boxxedpepintro)
						sprite_index = spr_boxxedpepintro;
					image_index = 0;
					hsp = 0;
					vsp = 0;
					break
				case "animatronic":
					state = states.animatronic;
					global.combotime = 0;
					break
				case "gusnbrick":
					characterID = characters.pep
					scr_character_spr_init()
					ratmount_movespeed = 8;
					gustavodash = 0;
					isgustavo = true;
					visible = true;
					state = states.ratmount;
					sprite_index = spr_player_ratmountidle;
					jumpAnim = false;
					brick = true;
					fmod_event_instance_release(snd_voiceok);
					snd_voiceok = fmod_event_create_instance("event:/sfx/voice/gusok");
					break
			}
		}
	},
	"<transfo sufix>",[0,ID_transfos]);
	
	ZOOMCAMERA = new c_Debugcommand("camzoom", function(_percent = 100) {
		if (_percent == "") {
			create_record("Error: Percent not given","error");
			exit;
		}
		
		if (get_number_string(_percent) == "")
		{
			create_record("Error: Invalid parameter type","error");
			exit;
		}
		
		_percent = get_number_string(_percent);
		
		if (_percent < 1)
			_percent = 1;
			
		if (_percent > 100)
			global.sv_cheats = true;
		
		with (obj_camera) {
			camzoom =(_percent / 100);
			camera_set_view_size(view_camera[0], SCREEN_WIDTH * camzoom, SCREEN_HEIGHT * camzoom);
		}
		create_record(concat("Camera zoom set to ",_percent,"%"),"normal");
	},
	"<percent>");
	
	GIVE = new c_Debugcommand("give", function(_item, _param) {
		if (_item == undefined || _item == "") {
			create_record("Error: Not item id given","error");
			exit;
		}
		
		var _found = false;
		for (var i = 0; i < ds_list_size(ID_items); i++)
		{
			if (ds_list_find_value(ID_items, i) == _item)
				_found = true;
		}
		
		if (!_found) {
			create_record("Error: Item not found","error");
			exit;
		}
		
		var _res = string_split(_item,":")[1];
		
		with (obj_player1) {
			if (PLAYER_LOCK) {
				create_record("Error: Player is not in a valid state","error");
				exit;
			}
		}
		
		global.sv_cheats = true;
		switch (_res) {
			case "level_key":
				with (obj_player1) {
					goblinkey = false;
					global.key_inv = true;
					key_particles = true;
					alarm[7] = 30;
					fmod_event_one_shot("event:/sfx/misc/collecttoppin");
					state = states.keyget;
					image_index = 0;
					keysound = false;
					global.combotime = 60;
				}
				create_record("Given level key","normal");
				break
			case "boss_key":
				with (instance_create(obj_player1.x,obj_player1.y,obj_giantkey)) {
					pickable = true;
				}
				instance_create(obj_player1.x,obj_player1.y,obj_giantkeyfollow);
				create_record("Given boss key","normal");
				break
			case "toppin":
				if (_param == undefined || _param == "") {
					create_record("Error: No toppin id given","error");
					exit;
				}
				if (get_number_string(_param) == "") {
					create_record("Error: Invalid parameter type 'toppin_id'","error");
					exit;
				}
				_param = get_number_string(_param);
				if (_param < 0 || _param > 4) {
					create_record("Error: Invalid toppin id","error");
					exit;
				}
				switch (_param) {
					case 0:
						_param = obj_pizzakinshroom;
						create_record("Given Shroom toppin","normal");
						break
					case 1:
						_param = obj_pizzakincheese;
						create_record("Given Cheese toppin","normal");
						break
					case 2:
						_param = obj_pizzakintomato;
						create_record("Given Tomato toppin","normal");
						break
					case 3:
						_param = obj_pizzakinsausage;
						create_record("Given Sausage toppin","normal");
						break
					case 4:
						_param = obj_pizzakinpineapple;
						create_record("Given Pineapple toppin","normal");
						break
				}
				with (instance_create(obj_player1.x,obj_player1.y,obj_pizzaboxunopen)) {
					content = _param;
				}
				break
			case "money":
				if (_param == undefined || _param == "") {
					create_record("Error: No money amount given","error");
					exit;
				}
				if (get_number_string(_param) == "") {
					create_record("Error: Invalid parameter type 'money_amount'","error");
					exit;
				}
				global.pigtotal += _param;
				create_record(concat("Given ",_param," dollars"),"normal");
				break
			case "pepper_pizza":
				instance_create(obj_player1.x,obj_player1.y,obj_noisejetpack)
				create_record("Given pepper pizza","normal");
				break
			case "level_treasure":
				instance_create(obj_player1.x,obj_player1.y,obj_treasure)
				create_record("Given level treasure","normal");
				break
			case "bomb":
				with (instance_create(obj_player1.x,obj_player1.y,obj_pizzagoblinbomb)) {
					with (obj_player1) {
						state = states.bombgrab;
						image_index = 0;
						sprite_index = spr_haulingstart;
						other.defused = true;
						bombgrabID = other.id;
						with (instance_create(x + (xscale * 25), y, obj_parryeffect))
						{
							sprite_index = spr_grabeffect;
							image_xscale = other.xscale;
							image_speed = 0.35;
						}
						with (other)
						{
							state = states.grabbed;
							playerid = other.id;
						}
					}
				}
				create_record("Given bomb","normal");
				break
			case "points":
				if (_param == undefined || _param == "") {
					create_record("Error: No points amount given","error");
					exit;
				}
				if (get_number_string(_param) == "") {
					create_record("Error: Invalid parameter type 'points'","error");
					exit;
				}
				
				global.collect += _param;
				create_record(concat("Given ",_param," points"),"normal");
				break
			case "revolver":
				with (obj_player1) {
					state = states.animation;
					sprite_index = spr_pistolintro;
					image_index = 0;
					image_speed = 0.35;
					tauntstoredstate = states.normal;
					fmod_event_one_shot("event:/sfx/pep/pistolstart");
					global.pistol = true;
					global.heattime = 60;
				}
				create_record("Given revolver","normal");
				break
			case "shotgun":
				with (obj_player1) {
					image_index = 0;
					sprite_index = spr_shotgunpullout;
					fmod_event_one_shot_3d("event:/sfx/pep/shotgunload", x, y);
					shotgunAnim = true;
					state = states.shotgun;
					global.heattime = 60;
				}
				create_record("Given shotgun","normal");
				break
		}
	},
	"<item id>,[parameters]",[0,ID_items]);
	
	RETRY = new c_Debugcommand("retry", function() {
		global.sv_cheats = true;
		instance_create_unique(0,0,obj_static);
	});
	
	GLOBAL = new c_Debugcommand("global", function(_name,_value) {
		if (_name == undefined || _name == "") {
			create_record("Error: No global variable given","error");
			exit;
		}
		if (_value == undefined || _value == "") {
			create_record("Error: No value given","error");
			exit;
		}
		
		if (_name == "sv_cheats") {
			create_record("Error: Nuh uh uh, dirty cheater","error");
			exit;
		}
		
		if (variable_global_exists(_name)) {
			global.sv_cheats = true;
			create_record(concat("Global variable ",_name," set to ",_value),"normal");
		}
		else
			create_record("Error: No global variable under that name","error");
	},
	"<global variable name>,<value>")
	
	ds_list_add(command_list, 
		PANIC,
		NOCLIP,
		GOD,
		LOCKCAMERA,
		SHOW_HUD,
		P_RANK,
		HIDETILES,
		ROOM,
		HURT,
		OBJ_FIRE,
		RELOAD,
		FORCE_SAVE,
		PLACE,
		RESTART,
		TRANSFO,
		ZOOMCAMERA,
		GIVE,
		RETRY,
		GLOBAL
	)
	
	function GetDouble(_doublestr)
	{
		var n = string_digits(_doublestr);
		if (n != undefined && n != "")
		{
			n = real(_doublestr);
			return n;
		}
		return undefined;
	}
	function get_bool(_boolstr)
	{
		if (_boolstr == undefined)
			return undefined;
		if (_boolstr == "true")
		{
			_boolstr = true;
			return _boolstr;
		}
		else if (_boolstr == "false")
		{
			_boolstr = false;
			return _boolstr;
		} 
		else if (string_digits(_boolstr) == "")
		{
			return undefined;
		}
		else if (is_real(real(string_digits(_boolstr))))
		{
			_boolstr = bool(real(string_digits(_boolstr)));
			return _boolstr;
		}
		return undefined;
	}
	function get_number_string(_numberstr)
	{
		var n = _numberstr;
		if (n == undefined || n == "")
			return n;
		if (is_string(_numberstr) && string_digits(_numberstr) != "")
		{
			n = real(string_digits(_numberstr));
			if (string_char_at(_numberstr, 1) == "-" || string_pos("-", _numberstr) != 0)
			{
				n = -real(string_digits(_numberstr));
			}
		} else {
			n = string_digits(_numberstr);
		}
		return n;
	}
}

function create_record(_msg,_status) {
	obj_CHAOSdevconsole.tick_records = true;
	ds_list_add(obj_CHAOSdevconsole.records, [_msg,_status,400])
}

function embedded_variable(_string) {
	if (array_length(string_split(_string,".")) > 1 && array_length(string_split(_string,".")) < 3) {
		var _raw = string_split(_string,".");
		if (asset_get_index(_raw[0]) != -1) 
		{
			var _target = asset_get_index(_raw[0])
			if (!object_exists(_target))
				return undefined;
			
			if (!instance_exists(_target))
				return undefined;
			
			_target = instance_nearest(obj_player1.x,obj_player1.y,_target)
			if variable_instance_exists(_target, _raw[1])
				return variable_instance_get(_target, _raw[1]);
			else
				return undefined;
		}
	}
	return _string;
}

function create_commandlists() {
	ID_transfos = ds_list_create();
	ID_chars = ds_list_create();
	ID_items = ds_list_create();
	
	var _trlist = [[0,"knight"],
					[0,"ball"],
					[0,"fireass"],
					[0,"firemouth"],
					[0,"ghost"],
					[0,"mort"],
					[0,"bitten"],
					[0,"barrel"],
					[0,"rocket"],
					[0,"cheeseball"],
					[0,"sticky_cheese"],
					[0,"boxed"],
					[0,"animatronic"],
					[0,"gusnbrick"]];
	
	var _trchar = [[1,"dos"],
					[1,"wm"],
					[0,"pep"],
					[0,"noise"]];
					
	var _tritems = [[0,"level_key"],
					[0,"boss_key"],
					[0,"toppin"],
					[0,"money"],
					[0,"pepper_pizza"],
					[0,"level_treasure"],
					[0,"bomb"],
					[0,"points"],
					[0,"revolver"],
					[0,"shotgun"]];
					
	var _sufix = "pizzatower:";
	
	for (var i = 0; i < array_length(_tritems); i++) {
		if (_tritems[i][0])
			_sufix = "caosmod:";
		else
			_sufix = "pizzatower:";
		ds_list_add(ID_items,concat(_sufix,_tritems[i][1]));
	}
	
	for (var i = 0; i < array_length(_trchar); i++) {
		if (_trchar[i][0])
			_sufix = "caosmod:";
		else
			_sufix = "pizzatower:";
		ds_list_add(ID_chars,concat(_sufix,_trchar[i][1]));
	}
	
	for (var i = 0; i < array_length(_trlist); i++) {
		if (_trlist[i][0])
			_sufix = "caosmod:";
		else
			_sufix = "pizzatower:";
		ds_list_add(ID_transfos,concat(_sufix,_trlist[i][1]));
	}
}

function filter_searchlist() {
	if (command != "") {
		var _phrase = command;
		if (array_length(string_split(command, " ")) > 1) {
			var _arr = string_split(command, " ");
			_phrase = _arr[array_length(_arr) - 1]
		}
		while (ds_list_size(search_list) > 0)
			ds_list_delete(search_list, 0);
		for (var i = 0; i < ds_list_size(search_abs_list); i++) {
			if string_starts_with(ds_list_find_value(search_abs_list, i), _phrase)
				ds_list_add(search_list, ds_list_find_value(search_abs_list, i));
		}
	} else
		ds_list_copy(search_list, search_abs_list);
	search_cursor = 0;
}