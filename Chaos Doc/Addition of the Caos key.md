How to re-add the deleted "Shoot key" back to the game.
***
## gml_GlobalScript_scr_getinput

The "key_shoot" variables must be initialized

~~~js 
function scr_getinput() {
	if ((!global.swapmode) || _dvc == -1)  
	{
		key_shoot = (tdp_input_get("player_shoot").held || tdp_input_get("player_shootC").held)  
		key_shoot2 = (tdp_input_get("player_shoot").pressed || tdp_input_get("player_shootC").pressed)
	}
}
~~~

Below the conditional where the input variables must be added, theres two lines that have to be deleted in order for this to work properly, being the following:

~~~js 
key_shoot = false  
key_shoot2 = false
~~~

***
## gml_GlobalScript_scr_initinput
#states
This script initializes the input values, this is used to assign the default values of the keys as well.
What's relevant:
~~~js
tdp_input_ini_read("player_shoot", [tdp_action((0 << 0), 68)])
tdp_input_ini_read("player_shootC", [tdp_action((1 << 0), 32770)])
global.key_shoot = ini_read_string("ControlsKeys", "shoot", 68)
global.key_shootC = ini_read_string("ControllerButton", "shoot", 32770)
~~~
[^1]: *THIS CODE ISN'T EDITABLE IN UTMT, BE CAREFUL*

The values entered in ==**tdp_action()**== are the following
- type of action, it's really not aparent un UTMT
	- (0 << 0) seems to be keyboard gameplay
	- (1 << 0) seems to be controller gameplay
	- (2 << 0) seems to refer to menu inputs no matter the periferal
- vk values (this are expressed in literal numbers in UTMT)
	- 68 : ord("D") - D key
	- 32770 : gp_face3 - Right controler button

***
## Icons and customization

When adding the new caos key icon, theres some points to take in mind before doing this ==(It could break the game)==

**gml_Object_obj_keyconfig_Create_0**
- The array of inputs has to be modified
~~~js
input = [["player_up"], ["player_down"], ["player_right"], ["player_left"], ["player_jump"], ["player_slap"], ["player_attack"], ["player_taunt"], ["player_shoot"], ["menu_start"], ["player_superjump"], ["player_groundpound"], ["menu_up", "control_menu_up"], ["menu_down", "control_menu_down"], ["menu_right", "control_menu_right"], ["menu_left", "control_menu_left"], ["menu_select", "control_menu_confirm"], ["menu_back", "control_menu_back"], ["menu_quit", "control_menu_quit"], ["menu_delete", "control_menu_delete"]]
~~~
- The option of \["player_shoot"] was added after the taunt bind
- It has to have the same name as defined in [[#gml_GlobalScript_scr_initinput]]
- It also has to have the same position in the addition of the sprite **spr_controlicons**
*Position 8 in array, the same in sprite*
![[controlIcons.png]]
