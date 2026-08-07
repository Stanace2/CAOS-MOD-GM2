function scr_spr_HUD() {
	if object_index == obj_bossdoor
		return;
	
	// Title cards
	if object_index == obj_startgate {
		trace("Title cards choose")
		switch obj_player1.characterID {
			case characters.dos:
				titlecard_sprite = spr_titlecards_dos
				break
			case characters.pep:
				titlecard_sprite = spr_titlecards
				break
				
		}
		trace(concat("Title card selected: ", sprite_get_name(titlecard_sprite)))
		return;
	}
	
	// Ranks
	if object_index == obj_rank {
		switch obj_player1.characterID {
			case characters.dos:
				spr_rank_D = spr_rankD_dos
				spr_rank_C = spr_rankC_dos
				spr_rank_B = spr_rankB_dos
				spr_rank_A = spr_rankA_dos
				spr_rank_S = spr_rankS_dos
				spr_rank_P = spr_rankP_dos
				break
			case characters.pep:
				spr_rank_D = spr_rankD
				spr_rank_C = spr_rankC
				spr_rank_B = spr_rankB
				spr_rank_A = spr_rankA
				spr_rank_S = spr_rankS
				spr_rank_P = spr_rankP
				break
				
		}
		return;
	}
	
	switch characterID {
		case characters.dos:
			if object_index != obj_tv {
				// Technical Difficulties
				spr_td1 = spr_dos_technicaldifficulty1
				spr_td2 = spr_dos_technicaldifficulty2
				spr_td3 = spr_dos_technicaldifficulty3
			}
			// New Clothes
			spr_clothesnew = spr_newclothes
			// Tv HUD
			// - Normal
			spr_tvopen = spr_tv_open_dos
			spr_tvcollect = [spr_tv_exprcollect_dos, spr_tv_exprcollect2_dos]
			spr_tvhurt = [spr_tv_exprhurt_dos, spr_tv_exprhurted_dos]
			spr_tvidle = spr_tv_idle_dos
			spr_tvidle_expression = [spr_tv_idleanim1_dos, spr_tv_idleanim2_dos, spr_tv_idleanim3_dos, spr_tv_idleanim4_dos]
			spr_tvmach3 = spr_tv_exprmach3_dos
			spr_tvmach4 = spr_tv_exprmach4_dos
			spr_tvpizzatime = spr_tv_exprpanic_dos
			spr_tvcombo_low = spr_tv_exprcombo_dos
			spr_tvcombo_high = spr_tv_exprheat_dos
			// - youhavehurtpeppino
			spr_tvtorture1 = spr_tv_exprhurt1_dos
			spr_tvtorture2 = spr_tv_exprhurt2_dos
			spr_tvtorture3 = spr_tv_exprhurt3_dos
			spr_tvtorture4 = spr_tv_exprhurt4_dos
			spr_tvtorture5 = spr_tv_exprhurt5_dos
			spr_tvtorture6 = spr_tv_exprhurt6_dos
			spr_tvtorture7 = spr_tv_exprhurt7_dos
			spr_tvtorture8 = spr_tv_exprhurt8_dos
			spr_tvtorture9 = spr_tv_exprhurt9_dos
			spr_tvtorture10 = spr_tv_exprhurt10_dos
			// - Transfos
			spr_tvball = spr_tv_tumble_dos
			spr_tvbarrel = spr_tv_barrel_dos
			spr_tvbombo = spr_tv_bombpep_dos
			spr_tvcheeseball = spr_tv_cheeseball_dos
			spr_tvcheesepep = spr_tv_cheesepep_dos
			spr_tvfireass = spr_tv_fireass_dos
			spr_tvfiremouth = spr_tv_firemouth_dos
			spr_tvghost = spr_tv_ghost_dos
			spr_tvgolf = spr_tv_golf_dos
			spr_tvknight = spr_tv_knight_dos
			spr_tvmort = spr_tv_mort_dos
			spr_tvscaredjump = spr_tv_scaredjump_dos
			spr_tvboxxedpep = spr_tv_boxxedpep_dos
			spr_tvrocket = spr_tv_rocket_dos
			spr_tvshotgun = spr_tv_shotgun_dos
			spr_tvweenie = spr_tv_weenie_dos
			break
		case characters.pep:
			if object_index != obj_tv {
				// Technical Difficulties
				spr_td1 = spr_technicaldifficulty1
				spr_td2 = spr_technicaldifficulty2
				spr_td3 = spr_technicaldifficulty3
			}
			// New Clothes
			spr_clothesnew = spr_newclothes_dos
			// Tv HUD
			// - Normal
			spr_tvopen = spr_tv_open
			spr_tvcollect = [spr_tv_exprcollect]
			spr_tvhurt = [spr_tv_exprhurt]
			spr_tvidle = spr_tv_idle
			spr_tvidle_expression = [spr_tv_idleanim1, spr_tv_idleanim2]
			spr_tvmach3 = spr_tv_exprmach3
			spr_tvmach4 = spr_tv_exprmach4
			spr_tvpizzatime = spr_tv_exprpanic
			spr_tvcombo_low = spr_tv_exprcombo
			spr_tvcombo_high = spr_tv_exprheat
			// - youhavehurtpeppino
			spr_tvtorture1 = spr_tv_exprhurt1
			spr_tvtorture2 = spr_tv_exprhurt2
			spr_tvtorture3 = spr_tv_exprhurt3
			spr_tvtorture4 = spr_tv_exprhurt4
			spr_tvtorture5 = spr_tv_exprhurt5
			spr_tvtorture6 = spr_tv_exprhurt6
			spr_tvtorture7 = spr_tv_exprhurt7
			spr_tvtorture8 = spr_tv_exprhurt8
			spr_tvtorture9 = spr_tv_exprhurt9
			spr_tvtorture10 = spr_tv_exprhurt10
			// - Transfos
			spr_tvball = spr_tv_tumble
			spr_tvbarrel = spr_tv_barrel
			spr_tvbombo = spr_tv_bombpep
			spr_tvcheeseball = spr_tv_cheeseball
			spr_tvcheesepep = spr_tv_cheesepep
			spr_tvfireass = spr_tv_fireass
			spr_tvfiremouth = spr_tv_firemouth
			spr_tvghost = spr_tv_ghost
			spr_tvgolf = spr_tv_golf
			spr_tvknight = spr_tv_knight
			spr_tvmort = spr_tv_mort
			spr_tvscaredjump = spr_tv_scaredjump
			spr_tvboxxedpep = spr_tv_boxxedpep
			spr_tvrocket = spr_tv_rocket
			spr_tvshotgun = spr_tv_shotgun
			spr_tvweenie = spr_tv_weenie
			break
	
	}
	
	if instance_exists(obj_startgate) {
		with (obj_startgate) {
			scr_spr_HUD()
		}
	}
	
	if object_index != obj_tv {
		with (obj_tv) {
			characterID = obj_player1.characterID
			scr_spr_HUD()
			state = states.normal
			sprite_index = spr_tv_off
		}
	}
}