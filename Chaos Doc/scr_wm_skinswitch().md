Switch the skin of WM, depending on the *brick* variable
This is referenced in:
- [[obj_player#EndStep]]
- [[obj_player#RoomStart]]
- ==Also in Gustavo Switch sign, should rebuild this as well==
~~~js
function scr_wm_skinswitch() //gml_Script_scr_wm_skinswitch  
{  
    var spr_next = -4  
    for (var i = 0; i < array_length(spr_arr_wm); i++)  
    {  
        if (sprite_index == spr_arr_wm[i])  
            spr_next = i  
    }  
    if brick  
    {  
        spr_idle = spr_player_ratmountidle  
        spr_move = spr_player_ratmountmove  
        spr_land2 = spr_player_ratmountland  
        spr_3hpwalk = spr_wm_anger_walk  
        spr_3hpidle = spr_wm_anger  
        spr_rageidle = spr_wm_mad  
        spr_ragemove = spr_wm_mad_walk  
        spr_hurtidle = spr_wm_terror  
        spr_hurtwalk = spr_wm_terror_walk  
        spr_panic = spr_wm_panic  
        spr_hurt = spr_player_ratmounthurt  
        spr_hurtjump = spr_wm_backhurt  
        spr_jump = spr_player_ratmountjump  
        spr_fall = spr_player_ratmountfall  
        spr_land = spr_player_ratmountland  
        spr_facestomp = spr_player_facestomp  
        spr_freefall = spr_player_freefall  
        spr_stompprep = spr_player_ratmountmushroombounce  
        spr_stomp = spr_wm_stomp_end  
        spr_mach = spr_player_ratmountattack  
        spr_mach4 = spr_player_ratmountmach3  
        spr_mach3jump = spr_player_ratmountdashjump  
        spr_hitwall = spr_player_ratmountbump  
        spr_taunt = spr_player_ratmounttaunt  
        spr_mach3hit = spr_player_mach3hit  
        spr_lookdoor = spr_ratmount_enterdoor  
        spr_walkfront = spr_ratmount_exitdoor  
        spr_downpizzabox = spr_wm_downpizzabox  
        spr_uppizzabox = spr_wm_uppizzabox  
    }  
    else  
    {  
        spr_idle = spr_lonegustavo_idle  
        spr_move = spr_lonegustavo_walk  
        spr_land2 = spr_wetham_landwalk  
        spr_3hpwalk = spr_lonegustavo_walk  
        spr_3hpidle = spr_lonegustavo_idle  
        spr_rageidle = spr_wetham_idle_distressed  
        spr_ragemove = spr_wetham_walk_distressed  
        spr_hurtidle = spr_wetham_idle_distressed  
        spr_hurtwalk = spr_wetham_walk_distressed  
        spr_panic = spr_wetham_idle_distressed  
        spr_hurt = spr_lonegustavo_hurt  
        spr_hurtjump = spr_wm_backhurt  
        spr_jump = spr_player_ratmountgroundpound  
        spr_fall = spr_player_ratmountgroundpoundfall  
        spr_land = spr_wetham_land  
        spr_facestomp = spr_player_facestomp  
        spr_freefall = spr_player_freefall  
        spr_stompprep = spr_lonegustavo_jumpstart  
        spr_stomp = spr_lonegustavo_jump  
        spr_mach = spr_lonegustavo_dash  
        spr_mach4 = spr_lonegustavo_mach3  
        spr_mach3jump = spr_lonegustavo_dashjump  
        spr_hitwall = spr_lonegustavo_bump  
        spr_taunt = spr_lonewetham_taunt  
        spr_mach3hit = spr_player_mach3hit  
        spr_lookdoor = spr_wethamenter  
        spr_walkfront = spr_ratmount_exitdoor  
        spr_downpizzabox = spr_w_downpizzabox  
        spr_uppizzabox = spr_w_uppizzabox  
    }  
    scr_arc_wmspr()  
    if (spr_next != -4)  
        sprite_index = spr_arr_wm[spr_next]  
}
~~~