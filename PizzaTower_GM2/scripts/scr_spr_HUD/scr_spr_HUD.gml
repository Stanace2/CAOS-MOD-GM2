function scr_spr_HUD() {
	switch characterID {
		case characters.dos:
			if object_index != obj_tv {
				// Technical Difficulties
				spr_td1 = spr_technicaldifficulty1
				spr_td2 = spr_technicaldifficulty2
				spr_td3 = spr_technicaldifficulty3
			}
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
		case characters.pep:
			if object_index != obj_tv {
				// Technical Difficulties
				spr_td1 = spr_technicaldifficulty1
				spr_td2 = spr_technicaldifficulty2
				spr_td3 = spr_technicaldifficulty3
			}
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
	
	if object_index != obj_tv {
		with (obj_tv) {
			characterID = other.characterID
			scr_spr_HUD()
		}
	}
}