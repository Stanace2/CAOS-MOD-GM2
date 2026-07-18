## Post Decomp
So lonely section
## Subject to change
spr_player_mangoboost | *72 116*
spr_player_mangodive | *72 106*
spr_player_mangoboostend | *72 66*
spr_player_mangoboostfly | *72 66*
spr_lonewetham_parry | *72 66*
spr_lonewetham_taunt | *72 66*
spr_wethamslash2 | *72 66*
spr_wethamslash | *72 66*
spr_wethamcling | *99 60*
spr_wethamroll | *72 66*
spr_wethamwalljump | *72 66*
spr_wethamslashhitbox | *72 66*
spr_wethamclash | *72 66*
spr_wethamdivel | *72 66*
spr_wethamenter | *72 66*
spr_wetham_bd | *72 66*
## scr_spr_wm()
List of sprites inside variables in scr_spr_dos()
Referenced in:
- [[Sprite initializer and changes]]
Scripts:
- [[scr_arc_wmspr()]]
~~~js
function scr_spr_wm() //gml_Script_scr_spr_wm  
{  
    spr_w_lonjump = spr_wetham_longjump  
    spr_w_lonjump_end = spr_wetham_longjump_loop  
    spr_wm_djump = spr_player_ratmountwalljump  
    spr_wm_roll = spr_wethamroll  
    spr_wm_cling = spr_wethamcling  
    spr_idle = spr_lonegustavo_idle  
    spr_move = spr_lonegustavo_walk  
    spr_land2 = spr_player_ratmountland  
    spr_3hpidle = spr_wm_anger  
    spr_3hpwalk = spr_wm_anger_walk  
    spr_rageidle = spr_wm_mad  
    spr_ragemove = spr_wm_mad_walk  
    spr_hurtidle = spr_wm_terror  
    spr_hurtwalk = spr_wm_terror_walk  
    spr_panic = spr_wm_panic  
    spr_idle1 = spr_player_ratmountidleanim  
    spr_idle2 = spr_wm_idleanim2  
    spr_idle3 = spr_wm_idleanim3  
    spr_idle4 = spr_wm_idleanim4  
    spr_idle5 = spr_wm_idleanim5  
    spr_idle6 = spr_wm_idleanim6  
    spr_winding = spr_player_winding  
    spr_crouch = spr_lonegustavo_crouch  
    spr_crouchjump = spr_lonegustavo_crouch  
    spr_crouchfall = spr_lonegustavo_crouchwalk  
    spr_couchstart = spr_wm_crouchstart  
    spr_crawl = spr_lonegustavo_crouchwalk  
    spr_hurt = spr_player_ratmounthurt  
    spr_hurtjump = spr_wm_backhurt  
    spr_jump = spr_player_ratmountgroundpound  
    spr_fall = spr_player_ratmountgroundpoundfall  
    spr_land = spr_player_ratmountland  
    spr_facestomp = spr_player_facestomp  
    spr_freefall = spr_player_freefall  
    spr_stompprep = spr_lonegustavo_jumpstart  
    spr_stomp = spr_lonegustavo_jump  
    spr_mach1 = spr_player_mach1  
    spr_mach = spr_lonegustavo_dash  
    spr_secondjump1 = spr_player_secondjump1  
    spr_secondjump2 = spr_player_secondjump2  
    spr_wallsplat = spr_lonewetham_wallsplat  
    spr_mach4 = spr_lonegustavo_mach3  
    spr_mach3jump = spr_lonegustavo_dashjump  
    spr_hitwall = spr_lonegustavo_bump  
    spr_mach3hit = spr_player_mach3hit  
    spr_dashpadmach = spr_player_dashpad  
    spr_crazyrun = spr_player_crazyrun  
    spr_machclimbwall = spr_player_climbwall  
    spr_climbwall = spr_player_climbwall  
    spr_walljumpstart = spr_wethamwalljump  
    spr_walljumpend = spr_player_walljumpend  
    spr_dive = spr_wethamdivel  
    spr_machroll = spr_player_machroll  
    spr_backslide = spr_lonewetham_tumble_end  
    spr_backslideland = spr_lonewetham_tumble  
    spr_rollgetup = spr_player_rollgetup  
    spr_mach3boostfall = spr_player_machslideboost3fall  
    spr_mach3boost = spr_ratmount_skid  
    spr_machslideboostfall = spr_player_machslideboostfall  
    spr_machslideboost = spr_player_machslideboost  
    spr_machslidestart = spr_player_machslidestart  
    spr_machslide = spr_player_machslide  
    spr_machslideend = spr_player_machslideend  
    spr_suplexdash = spr_player_suplexdash  
    spr_suplexdashjumpstart = spr_player_suplexgrabjumpstart  
    spr_suplexdashjump = spr_player_suplexgrabjump  
    spr_suplexbump = spr_player_suplexbump  
    spr_suplexcancel = spr_player_suplexcancel  
    spr_bump = spr_player_bump  
    spr_crouchslip = spr_player_crouchslip  
    spr_piledriver = spr_player_piledriver  
    spr_piledriverland = spr_player_piledriverland  
    spr_suplexland = spr_player_backflip  
    spr_swingding = spr_player_swingding  
    spr_swingdingend = spr_player_swingdingend  
    spr_haulingjump = spr_player_haulingjump  
    spr_haulingidle = spr_player_haulingidle  
    spr_haulingwalk = spr_player_haulingwalk  
    spr_haulingstart = spr_player_haulingstart  
    spr_haulingfall = spr_player_haulingfall  
    spr_haulingland = spr_player_haulingland  
    spr_breakdanceuppercut = spr_player_breakdanceuppercut  
    spr_breakdanceuppercutend = spr_player_breakdanceuppercutend  
    spr_uppercutfinishingblow = spr_player_uppercutfinishingblow  
    spr_finishingblow1 = spr_player_finishingblow1  
    spr_finishingblow2 = spr_player_finishingblow2  
    spr_finishingblow3 = spr_player_finishingblow3  
    spr_finishingblow4 = spr_player_finishingblow4  
    spr_finishingblow5 = spr_player_finishingblow5  
    spr_taunt = spr_lonewetham_taunt  
    spr_supertaunt1 = spr_player_ratmountsupertaunt  
    spr_supertaunt2 = spr_wm_supertaunt2  
    spr_supertaunt3 = spr_wm_supertaunt3  
    spr_supertaunt4 = spr_wm_supertaunt4  
    spr_parry1 = spr_player_ratmountspit  
    spr_parry2 = spr_player_parry2  
    spr_parry3 = spr_player_parry3  
    spr_breakdance = spr_wetham_bd  
    spr_gottreasure = spr_wm_treasureget  
    spr_keyget = spr_player_keyget  
    spr_suplexmash1 = spr_player_suplexmash1  
    spr_suplexmash2 = spr_player_suplexmash2  
    spr_suplexmash3 = spr_player_suplexmash3  
    spr_suplexmash4 = spr_player_suplexmash4  
    spr_punch = spr_player_punch  
    spr_superjumpprep = spr_player_superjumpprep  
    spr_superjump = spr_player_superjump  
    spr_superjumppreplight = spr_player_superjumppreplight  
    spr_superjumpright = spr_player_superjumpright  
    spr_superjumpleft = spr_player_superjumpleft  
    spr_superjumpland = spr_player_superjumpland  
    spr_machfreefall = spr_player_machfreefall  
    spr_bodyslamfall = spr_lonegustavo_groundpound  
    spr_bodyslamstart = spr_lonegustavo_groundpoundstart  
    spr_bodyslamland = spr_lonegustavo_groundpoundland  
    spr_facehurtup = spr_player_facehurtup  
    spr_facehurt = spr_player_facehurt  
    spr_entergate = spr_wm_entergate  
    spr_lookdoor = spr_ratmount_enterdoor  
    spr_walkfront = spr_ratmount_exitdoor  
    spr_downpizzabox = spr_wm_downpizzabox  
    spr_uppizzabox = spr_wm_uppizzabox  
    spr_levelstart = spr_wm_startgate  
    spr_grind = spr_player_grind  
    spr_mach2jump = spr_player_mach2jump  
    spr_superspringplayer = spr_player_presentbox  
    spr_victory = spr_wm_treasuredoor  
    spr_Ladder = spr_lonewetham_ladder_idle  
    spr_laddermove = spr_lonegustavo_ladder  
    spr_ladderdown = spr_lonegustavo_ladderdown  
    spr_longjump = spr_player_longjump  
    spr_longjumpend = spr_player_longjumpend  
    spr_mrpinch = spr_player_mrpinch  
    spr_rampjump = spr_player_rampjump  
    spr_catched = spr_player_catched  
    spr_slipbanan1 = spr_wetham_slip  
    spr_slipbanan2 = spr_wetham_crashland  
    spr_airdash2 = spr_player_airdash2  
    spr_Timesup = spr_player_ratmounttimesup  
    spr_deathend = spr_player_deathend  
    spr_dead = spr_player_deathend  
    spr_pistolshot = spr_player_pistolshot  
    spr_pistolwalk = spr_player_pistolwalk  
    spr_knightpepwalk = spr_knightpep_walk  
    spr_knightpepjump = spr_knightpep_jump  
    spr_knightpepfall = spr_knightpep_fall  
    spr_knightpepidle = spr_knightpep_idle  
    spr_knightpepjumpstart = spr_knightpep_jumpstart  
    spr_knightpepthunder = spr_knightpep_thunder  
    spr_knightpepland = spr_knightpep_land  
    spr_knightpepdownslope = spr_knightpep_downslope  
    spr_knightpepstart = spr_knightpep_start  
    spr_knightpepcharge = spr_knightpep_charge  
    spr_knightpepdoublejump = spr_knightpep_doublejump  
    spr_knightpepfly = spr_knightpep_fly  
    spr_knightpepdowntrust = spr_knightpep_downtrust  
    spr_knightpepupslope = spr_knightpep_upslope  
    spr_knightpepbump = spr_knightpep_bump  
    spr_jetpackstart2 = spr_player_jetpackstart2  
    spr_fireass = spr_player_fireass  
    spr_fireassground = spr_player_fireassground  
    spr_fireassend = spr_player_fireassend  
    spr_tumbleend = spr_player_tumbleend  
    spr_tumble = spr_player_tumble  
    spr_stunned = spr_player_stunned  
    spr_clown = spr_player_clown  
    spr_clownbump = spr_player_clownbump  
    spr_clowncrouch = spr_player_clowncrouch  
    spr_clownfall = spr_player_clownjump  
    spr_clownjump = spr_player_clownjump  
    spr_clownwallclimb = spr_player_clownwallclimb  
    spr_shotgunland = spr_shotgun_land  
    spr_shotgunshoot = spr_player_shotgun  
    spr_shotgunidle = spr_shotgun_idle  
    spr_shotgunwalk = spr_shotgun_walk  
    spr_shotgunfall = spr_shotgun_fall  
    spr_shotgunjump = spr_shotgun_jump  
    spr_shotgunjump1 = spr_player_shotgunjump1  
    spr_shotgunjump2 = spr_player_shotgunjump2  
    spr_shotgunjump3 = spr_player_shotgunjump3  
    spr_shotgunpullout = spr_shotgun_pullout  
    spr_shotgunduck = spr_shotgun_duck  
    spr_shotguncrawl = spr_shotgun_crawl  
    spr_shotgungoduck = spr_shotgun_goduck  
    spr_fightball = spr_player_fightball  
    spr_rideweenie = spr_player_weeniemount  
    spr_weenieturn = spr_player_weenieturn  
    spr_barrelidle = spr_player_barrelidle  
    spr_barreljump = spr_player_barreljump  
    spr_barrelroll = spr_player_barrelroll
    spr_barrelfall = spr_player_barrelfall  
    spr_barrelslipnslide = spr_player_barrelslipnslide  
    spr_barrelmove = spr_player_barrelmove  
    spr_barrelland = spr_player_barrelland  
    spr_firemouthintro = spr_player_firemouthintro  
    spr_firemouthend = spr_player_firemouthend  
    spr_firemouth = spr_player_firemouth  
    spr_firemouthspin = spr_player_firemouthspin  
    spr_firemouthdash = spr_player_firemouthdash  
    spr_firemouthidle = spr_player_firemouthidle  
    spr_ghostdash = spr_player_ghostdash  
    spr_ghostdashright = spr_player_ghostdashright  
    spr_ghostdashdown = spr_player_ghostdashdown  
    spr_ghostdashdownright = spr_player_ghostdashdownright  
    spr_ghostdashup = spr_player_ghostdashup  
    spr_ghostdashupright = spr_player_ghostdashupright  
    spr_ghostidle = spr_player_ghostidle  
    spr_ghostend = spr_player_ghostend  
    spr_ghostjump = spr_player_ghostjump  
    spr_playercorpsestart = spr_player_corpsestart  
    spr_playercorpsesurf = spr_player_corpsesurf  
    spr_mortdoublejumpstart = spr_player_mortdoublejump  
    spr_mortdoublejump = spr_player_mortjump  
    spr_playermortidle = spr_player_mortidle  
    spr_playermortjump = spr_player_mortjump  
    spr_playermortjumpstart = spr_player_mortjumpstart
    spr_playermortland = spr_player_mortland  
    spr_playermortwalk = spr_player_mortwalk  
    spr_mortattackfront = spr_player_mortattackfront  
    spr_scaredjump1 = spr_player_scaredjump1  
    spr_scaredjump2 = spr_player_scaredjump2  
    spr_currentplayer = spr_player_current  
    spr_golfidle = spr_player_golfidle  
    spr_golfswing = spr_player_golfswing  
    spr_cheeseballplayer = spr_player_cheeseball  
    spr_boxxedpepintro = spr_boxxedpep_intro  
    spr_boxxedpepidle = spr_boxxedpep_idle  
    spr_boxxedpepwalk = spr_boxxedpep_walk  
    spr_boxxedpepair = spr_boxxedpep_air  
    spr_boxxedpepdashstart = spr_boxxedpep_dashstart  
    spr_boxxedpepdashend = spr_boxxedpep_dashend  
    spr_boxxedpepdash = spr_boxxedpep_dash  
    spr_cheesepepintro = spr_cheesepep_intro  
    spr_cheesepepidle = spr_cheesepep_idle  
    spr_cheesepepwalk = spr_cheesepep_walk  
    spr_cheesepepjump = spr_cheesepep_jump  
    spr_cheesepepjumpstart = spr_cheesepep_jumpstart  
    spr_cheesepepfall = spr_cheesepep_fall  
    spr_cheesepepland = spr_cheesepep_land  
    spr_cheesepepstickside = spr_cheesepep_stickwall  
    spr_cheesepepstickceiling = spr_cheesepep_stickceilling  
    spr_cheesepepstickfloor = spr_cheesepep_stick  
    spr_rocketstart = spr_player_rocketstart  
    spr_rocket = spr_player_rocket  
    spr_rockethitwall = spr_wetham_stumble  
    spr_palette = spr_ratmountpalette  
    spr_lapportal_in = spr_wm_pizzaportalend  
    spr_lapportal_out = spr_wm_pizzaportal_out  
    scr_arc_wmspr()
~~~