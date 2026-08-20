function scr_wm_skinswitch() {
	var spr_next = -4
    for (var i = 0; i < array_length(spr_arr_wm); i++)
    {
        if (sprite_index == spr_arr_wm[i]) {
            spr_next = i
			break
		}
    }
    if brick
    {
        spr_idle = spr_wm_idle  
    	spr_move = spr_wm_move  
        spr_land2 = spr_wm_land
	    spr_3hpwalk = spr_wm_anger_walk
	    spr_3hpidle = spr_wm_anger 
	    spr_rageidle = spr_wm_mad
	    spr_ragemove = spr_wm_mad_walk
	    spr_hurtidle = spr_wm_terror
	    spr_hurtwalk = spr_wm_terror_walk 
	    spr_panic = spr_wm_panic
        spr_hurt = spr_wm_hurt
    	spr_hurtjump = spr_wm_backhurt
        spr_jump = spr_wm_jump
	    spr_fall = spr_wm_fall
	    spr_land = spr_wm_land
        spr_facestomp = spr_player_facestomp  
	    spr_freefall = spr_player_freefall  
	    spr_stompprep = spr_wm_mushroombounce
	    spr_stomp = spr_wm_stomp_end
        spr_mach = spr_wm_attack
        spr_mach4 = spr_wm_mach3
        spr_mach3jump = spr_wm_dashjump
        spr_hitwall = spr_wm_bump
        spr_taunt = spr_wm_taunt
        spr_lookdoor = spr_wm_enterdoor
        spr_walkfront = spr_wm_exitdoor
        spr_downpizzabox = spr_wm_downpizzabox
        spr_uppizzabox = spr_wm_uppizzabox
    }
    else
    {
        spr_idle = spr_w_idle
        spr_move = spr_w_walk
        spr_land2 = spr_wetham_landwalk
        spr_3hpwalk = spr_w_walk
        spr_3hpidle = spr_w_idle
        spr_rageidle = spr_wetham_idle_distressed
        spr_ragemove = spr_wetham_walk_distressed
        spr_hurtidle = spr_wetham_idle_distressed
        spr_hurtwalk = spr_wetham_walk_distressed
        spr_panic = spr_wetham_idle_distressed
        spr_hurt = spr_w_hurt
        spr_hurtjump = spr_w_hurt
        spr_jump = spr_w_jump
        spr_fall = spr_w_fall
        spr_land = spr_wetham_land
        spr_facestomp = spr_player_facestomp
        spr_freefall = spr_player_freefall
        spr_stompprep = spr_w_stomp
        spr_stomp = spr_w_stompend
        spr_mach = spr_w_dash
        spr_mach4 = spr_w_mach3
        spr_mach3jump = spr_w_dashjump
        spr_hitwall = spr_w_crash
        spr_taunt = spr_lonewetham_taunt
        spr_lookdoor = spr_wethamenter
        spr_walkfront = spr_ratmount_exitdoor
        spr_downpizzabox = spr_w_downpizzabox
        spr_uppizzabox = spr_w_uppizzabox
    }
    scr_arc_wmspr()
	if (spr_next != -4)
		sprite_index = spr_arr_wm[spr_next]
}