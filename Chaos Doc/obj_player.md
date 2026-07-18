## Create

~~~js
if (instance_number(object_index) > 1)
{
    instance_destroy()
    return;
}
global.current_level = -4
resetdoisecount = 0
global.resetdoise = 0
global.swap_boss_damage = 0
global.throwarc = 1
global.hidetiles = 0
global.leveltosave = -4
global.leveltorestart = -4
global.leveltorestart = -4
global.hub_bgsprite = -4
global.offload_tex = -4
global.bossplayerhurt = 0
global.boss_invincible = 0
global.highest_combo = 0
global.player_damage = 0
global.swap_damage[0] = 0
global.swap_damage[1] = 0
global.peppino_damage = 0
global.gustavo_damage = 0
global.enemykilled = 0
global.johnresurrection = 0
global.startgate = 0
global.bossintro = 0
global.palettetexture = -4
global.palettesurface = -4
global.palettesurfaceclip = -4
global.levelattempts = 0
global.exitrank = 0
global.playerhit = 0
global.swapmode = 0
global.door_sprite = 4484
global.door_index = 0
global.pistol = 0
global.bombs = 0
global.friendShip = 0
global.caoschase = 0
global.chaoscolors = [make_colour_rgb(255, 160, 64), make_colour_rgb(248, 255, 21), make_colour_rgb(21, 255, 81), make_colour_rgb(234, 21, 255)]
chaoskolors = [[204, 20, 42, 81], [[0.9607843137254902, 0.12941176470588237, 1], [1, 0.5333333333333333, 0], [1, 0.9803921568627451, 0.34901960784313724], [0.6078431372549019, 1, 0]]]
global.khaoshex = 16777215
global.khaosr = 1
global.khaosg = 1
global.khaosb = 1
global.khaosactives = [0, 0, 0, 0]
global.kpanic = 0
global.kbells = 1
global.kpowerups = 1
global.ikframes = 1
global.kpm = 1
global.ktoppins = 1
global.k3lap = 0
global.ktoppingoal = 0
global.iexception = 0
global.gothkills = 0
global.gothunlocked = 0
global.chaosexception = 0
kolorhexr = 0
kolorhexg = 0
kolorhexb = 0
currentkolors = []
currentkolorindex = 0
kolorindex = -1
kolortimer = 0
chaoscolor = 0
kickcc = 0
displaykeys = 0
displaydata = 0
ratpoison = 0
infijump = 0
flamedash = 0
flamedashbuffer = 0
flamedashkick = 22
flameheat = 0
flamejumped = 0
dragonsnap = 0
dragonbuffer = 0
killbuffer = 0
snaphold = 0
wallclimbbuffer = 0
ikcurrent = 0
ikalpha = 0
iwalpha = 0
kickiw = 0
fightmode = 0
snapjumps = 0
drillexitspd = 0
machhold = 1
mach5 = 0
machengineprev = -1
mach5buffer = 0
input_buffer_chaos = 0
canrollsnd = 0
poundbuffer = 0
fightball_buffer1 = 0
fightball_buffer2 = 0
fightball_snd_buffer = 0
input_taunt_p2 = 0
supernoisefademax = 4
supernoisefade = supernoisefademax * 20 / 2
supernoisetimer = 0
supernoisefx = 0
bombreadybuffer = 0
savedmove = 0
noisepeppermissile = 0
noisepizzapepper = 0
noisejetpackbuffer = 0
ignore_grind = 0
noisemachcancel = 0
move_h = 0
move_v = 0
steppybuffer = 0
noisecrusher = 0
noisemachcancelbuffer = 0
noisewalljump = 0
noisedoublejump = 0
lastroom_soundtest = room
lastroom_secretportalID = -4
dropboost = 0
uncrouch = 0
parryID = -4
bodyslam_notif = 0
swingdingthrow = 0
sjumptimer = 0
can_jump = 0
coyote_time = 0
invtime = 0
parry_lethal = 0
usepalette = 1
jetpackeffect = 0
superchargebuffer = 0
fireasseffect = 0
pistolanim = -4
pistolindex = 0
pistolcooldown = 0
pistolchargesound = 0
policetaxi = 0
collision_flags = 0
breakdance_pressed = 0
restartbuffer = 0
jetpackdash = 0
flamecloud_buffer = 0
rankpos_x = x
rankpos_y = y
transformationlives = 0
punch_afterimage = 0
superchargecombo_buffer = -1
superattackstate = (0 << 0)
afterimagedebris_buffer = 0
scale_xs = 1
scale_ys = 1
verticalbuffer = 0
verticalstate = (0 << 0)
webID = -4
float = 0
boxxedpepjump = 10
boxxedpepjumpmax = 10
icemovespeed = 0
prevmove = 0
prevhsp = 0
prevstate = (0 << 0)
prevxscale = 1
prevsprite = sprite_index
move = 0
prevmovespeed = 0
previcemovespeed = 0
icedir = 1
icemomentum = 0
savedicedir = 1
ispeppino = 1
isgustavo = 0
jumped = 1
grav = 0.5
hsp = 0
vsp = 0
target_vsp = 0
target_hsp = 0
vsp_carry = 0
hsp_carry = 0
rocketvsp = 0
sticking = 0
platformid = -4
xscale = 1
yscale = 1
facehurt = 0
steppy = 0
steppybuffer = 0
depth = -7
movespeed = 19
jumpstop = 0
ramp = 0
ramp_points = 0
bombup_dir = 1
knightmomentum = 0
grabbingenemy = 0
blur_effect = 0
firemouth_dir = 1
firemouth_max = 10
firemouth_buffer = firemouth_max
firemouth_afterimage = 0
cow_buffer = 0
balloonbuffer = 0
shoot_buffer = 0
shoot_max = 20
dynamite_inst = -4
golfid = -4
bombgrabID = -4
barrelslope = 0
barrel_maxmovespeed = 16
barrel_maxfootspeed = 10
barrel_rollspeed_threshold = 10
barrel_accel = 1
barrel_deccel = 1
barrel_slopeaccel = 0.25
barrel_slopedeccel = 0.5
barrelroll_slopeaccel = 0.5
barrelroll_slopedeccel = 0.35
hurt_buffer = -1
hurt_max = 120
invhurt_buffer = 0
invhurt_max = 30
ratmount_movespeed = 8
ratmount_fallingspeed = 0
ratgrabbedID = -4
ratpowerup = -4
ratshootbuffer = 0
rateaten = 0
gustavodash = 0
brick = 0
brickskinbuffer = 0
ratmountpunchtimer = 25
gustavokicktimer = 5
cheesepep_buffer = 0
cheesepep_max = 10
pepperman_accel = 0.25
pepperman_deccel = 0.5
pepperman_accel_air = 0.15
pepperman_deccel_air = 0.25
pepperman_maxhsp_normal = 6
pepperman_jumpspeed = 11
pepperman_grabID = -4
shoulderbash_mspeed_start = 12
shoulderbash_mspeed_loop = 10
shoulderbash_jumpspeed = 11
visible = 1
state = (18 << 0)
jumpAnim = 1
landAnim = 0
machslideAnim = 0
moveAnim = 1
stopAnim = 1
crouchslideAnim = 1
crouchAnim = 1
machhitAnim = 0
stompAnim = 0
inv_frames = 0
hurted = 0
autodash = 0
mach2 = 0
stop_buffer = 8
slope_buffer = 8
stop_max = 16
parry = 0
parry_inst = -4
taunt_to_parry_max = 8
parrytimer = 0
parry_count = 0
parry_max = 8
is_firing = 0
input_buffer_jump = 0
input_buffer_down = 0
input_buffer_mach = 0
input_buffer_jump_negative = 0
input_buffer_shoot = 0
input_buffer_secondjump = 8
input_buffer_highjump = 8
input_buffer_walljump = 0
input_buffer_slap = 0
input_attack_buffer = 0
input_finisher_buffer = 0
input_up_buffer = 0
input_down_buffer = 0
hit_connected = 0
player_x = x
player_y = y
targetRoom = 0
targetDoor = "A"
scr_init_input()
flash = 0
key_particles = 0
barrel = 0
bounce = 0
a = 0
idle = 0
attacking = 0
slamming = 0
superslam = 0
grounded = 1
grinding = 0
machpunchAnim = 0
punch = 0
machfreefall = 0
shoot = 0
instakillmove = 0
stunmove = 0
windingAnim = 0
facestompAnim = 0
ladderbuffer = 0
toomuchalarm1 = 0
toomuchalarm2 = 0
idleanim = 0
momemtum = 0
cutscene = 0
grabbing = 0
dir = xscale
shotgunAnim = 0
goingdownslope = 0
goingupslope = 0
fallinganimation = 0
bombpeptimer = 100
suplexmove = 0
suplexhavetomash = 0
anger = 0
angry = 0
baddiegrabbedID = 0
spr_palette = 767
characterID = 1
character = "P"
scr_characterspr()
paletteselect = 1
player_paletteselect[0] = 1
player_patterntexture[0] = -4
player_paletteselect[1] = 1
player_patterntexture[1] = -4
player_paletteindex = 0
player_index = 0
swap_taunt = 0
colorchange = 0
treasure_x = 0
treasure_y = 0
treasure_room = 0
wallspeed = 0
tauntstoredstate = (0 << 0)
tauntstoredmovespeed = 6
tauntstoredsprite = 1029
taunttimer = 20
tauntstoredvsp = 0
tauntstoredhsp = 0
tauntstoredisgustavo = 0
tube_id = -1
backtohubstartx = x
backtohubstarty = y
backtohubroom = 0
slapcharge = 0
slaphand = 1
slapbuffer = 8
slapflash = 0
freefallsmash = 0
costumercutscenetimer = 0
heavy = 0
lastroom_x = 0
lastroom_y = 0
lastroom = 0
lastTargetoor = "A"
hallway = 0
savedhallway = 0
hallwaydirection = 0
savedhallwaydirection = 0
vhallwaydirection = 0
savedvhallwaydirection = 0
verticalhallway = 0
savedverticalhallway = 0
vertical_x = x
verticalhall_vsp = 0
box = 0
roomstartx = 0
roomstarty = 0
swingdingbuffer = 0
swingdingdash = 0
lastmove = 0
backupweapon = 0
stickpressed = 0
spotlight = 1
macheffect = 0
chargeeffectid = 804
dashcloudid = 804
crazyruneffectid = 804
fightball = 0
superslameffectid = 804
speedlineseffectid = 804
angryeffectid = 804
thrown = 0
transformationsnd = 0
mach1snd = -1
mach2snd = -1
mach3snd = -1
machenginesnd = fmod_event_create_instance("event:/chaos-sfx/donisha/machEngine")
fmod_event_instance_set_parameter(machenginesnd, "state", 0, 1)
wmcopter = fmod_event_create_instance("event:/chaos-sfx/wm/wmcopter")
fmod_event_instance_set_parameter(wmcopter, "speed", 0, 1)
mach5snd = fmod_event_create_instance("event:/chaos-sfx/donisha/mach5sup")
machsnd = fmod_event_create_instance("event:/sfx/pep/mach")
fmod_event_instance_set_parameter(machsnd, "state", 0, 1)
mangospinsnd = fmod_event_create_instance("event:/chaos-sfx/wm/mango/mspin")
mangospinceilingsnd = fmod_event_create_instance("event:/chaos-sfx/wm/mango/mspinceiling")
snd_wethamkick = fmod_event_create_instance("event:/chaos-sfx/wm/wmbrickkick")
fmod_event_instance_set_parameter(snd_wethamkick, "state", 0, 1)
wethamkick = 0
jumpsnd = fmod_event_create_instance("event:/sfx/pep/jump")
machrollsnd = fmod_event_create_instance("event:/sfx/pep/machroll")
weeniebumpsnd = fmod_event_create_instance("event:/sfx/weenie/bump")
knightslidesnd = fmod_event_create_instance("event:/sfx/knight/slide")
gravecorpsesnd = fmod_event_create_instance("event:/sfx/pep/gravecorpse")
barrelslidesnd = fmod_event_create_instance("event:/sfx/barrel/slide")
barrelbumpsnd = fmod_event_create_instance("event:/sfx/barrel/bump")
waterslidesnd = fmod_event_create_instance("event:/sfx/misc/waterslide")
mrpinchsnd = fmod_event_create_instance("event:/sfx/misc/mrpinch")
hamkuffsnd = fmod_event_create_instance("event:/sfx/misc/hamkuff")
ratmountmachsnd = fmod_event_create_instance("event:/sfx/ratmount/mach")
ratmountballsnd = fmod_event_create_instance("event:/sfx/ratmount/ball")
ratmountgroundpoundsnd = fmod_event_create_instance("event:/sfx/ratmount/groundpound")
ratmountpunchsnd = fmod_event_create_instance("event:/sfx/ratmount/punch")
ratmountgallopsnd = fmod_event_create_instance("event:/sfx/ratmount/gallop")
cheeseballsnd = fmod_event_create_instance("event:/sfx/cheese/ball")
boxxedspinsnd = fmod_event_create_instance("event:/sfx/boxxed/spin")
pizzapeppersnd = fmod_event_create_instance("event:/sfx/pep/pizzapepper")
ratdeflatesnd = fmod_event_create_instance("event:/sfx/rat/deflate")
ghostspeedsnd = fmod_event_create_instance("event:/sfx/pep/ghostspeed")
freefallsnd = fmod_event_create_instance("event:/sfx/pep/freefall")
rollgetupsnd = fmod_event_create_instance("event:/sfx/pep/rollgetup")
knightslide = -1
bombpep1snd = -1
mach4snd = -1
tumble2snd = -1
tumble1snd = -1
tumble3snd = -1
tumblesnd = fmod_event_create_instance("event:/sfx/pep/tumble")
snd_uppercut = fmod_event_create_instance("event:/sfx/pep/uppercut")
snd_dive = fmod_event_create_instance("event:/sfx/pep/dive")
snd_crouchslide = fmod_event_create_instance("event:/sfx/pep/crouchslide")
tumbleintro = 0
rocketsnd = -1
hamkuffID = -4
snd_voiceok = fmod_event_create_instance("event:/sfx/voice/ok")
snd_voicetransfo = fmod_event_create_instance("event:/sfx/voice/transfo")
snd_voiceouttransfo = fmod_event_create_instance("event:/sfx/voice/outtransfo")
snd_voicehurt = fmod_event_create_instance("event:/sfx/voice/hurt")
snd_dashpad = fmod_event_create_instance("event:/sfx/misc/dashpad")
animatronicsnd = fmod_event_create_instance("event:/sfx/pep/animatronic")
burpsnd = fmod_event_create_instance("event:/sfx/enemies/burp")
snd_wallbounce = fmod_event_create_instance("event:/sfx/playerN/wallbounce")
snd_divebomb = fmod_event_create_instance("event:/sfx/playerN/divebomb")
snd_airspin = fmod_event_create_instance("event:/sfx/playerN/airspin")
snd_noisemach = fmod_event_create_instance("event:/sfx/playerN/machN")
snd_noiseSjump = fmod_event_create_instance("event:/sfx/playerN/superjump")
snd_noiseSjumprelease = fmod_event_create_instance("event:/sfx/playerN/superjumprelease")
snd_noisedoublejump = fmod_event_create_instance("event:/sfx/playerN/doublejump")
snd_noisepunch = fmod_event_create_instance("event:/sfx/playerN/punch")
snd_minijetpack = fmod_event_create_instance("event:/sfx/playerN/minijetpack")
snd_noisefiremouth = fmod_event_create_instance("event:/sfx/playerN/firemouthjump")
snd_rushdown = fmod_event_create_instance("event:/sfx/playerN/rushdownloop")
snd_rushdownhit = fmod_event_create_instance("event:/sfx/playerN/rushdownhit")
snd_minigun = fmod_event_create_instance("event:/sfx/playerN/minigunloop")
snd_ghostdash = fmod_event_create_instance("event:/sfx/playerN/ghostdash")
snd_bossdeathN = fmod_event_create_instance("event:/sfx/playerN/bossdeath")
snd_noiseanimatronic = fmod_event_create_instance("event:/Sfx/playerN/animatronic")
global.snd_escaperumble = fmod_event_create_instance("event:/sfx/misc/escaperumble")
global.snd_johndead = fmod_event_create_instance("event:/sfx/enemies/johndead")
global.snd_spaceship = fmod_event_create_instance("event:/sfx/misc/spaceship")
global.snd_fakesanta = fmod_event_create_instance("event:/sfx/enemies/fakesanta")
global.snd_rankup = fmod_event_create_instance("event:/sfx/ui/rankup")
global.snd_pizzafacemoving = fmod_event_create_instance("event:/sfx/pizzaface/moving")
global.snd_rankdown = fmod_event_create_instance("event:/sfx/ui/rankdown")
global.snd_rank = fmod_event_create_instance("event:/music/rank")
global.snd_parry = fmod_event_create_instance("event:/sfx/pep/parry")
global.snd_fireass = fmod_event_create_instance("event:/sfx/pep/fireass")
global.snd_breakblock = fmod_event_create_instance("event:/sfx/misc/breakblock")
global.snd_collect = fmod_event_create_instance("event:/sfx/misc/collect")
global.snd_bellcollect = fmod_event_create_instance("event:/sfx/misc/bellcollect")
global.snd_cardflip = fmod_event_create_instance("event:/sfx/misc/cardflip")
global.snd_explosion = fmod_event_create_instance("event:/sfx/misc/explosion")
global.snd_cheesejump = fmod_event_create_instance("event:/sfx/pep/cheesejump")
global.snd_ventilator = fmod_event_create_instance("event:/sfx/misc/ventilator")
global.snd_trashjump1 = fmod_event_create_instance("event:/sfx/misc/trashjump1")
global.snd_thunder = fmod_event_create_instance("event:/sfx/knight/thunder")
global.snd_captaingoblinshoot = fmod_event_create_instance("event:/sfx/misc/captaingoblinshoot")
global.snd_golfjingle = fmod_event_create_instance("event:/sfx/misc/golfjingle")
global.snd_mrstickhat = fmod_event_create_instance("event:/sfx/misc/mrstickhat")
global.snd_alarm = fmod_event_create_instance("event:/sfx/enemies/alarm")
global.snd_alarm_baddieID = -4
global.snd_slidersfx = fmod_event_create_instance("event:/sfx/ui/slidersfx")
global.snd_slidermusic = fmod_event_create_instance("event:/sfx/ui/slidermusic")
global.snd_slidermaster = fmod_event_create_instance("event:/sfx/ui/slidersfxmaster")
global.snd_bossbeaten = fmod_event_create_instance("event:/sfx/misc/bossbeaten")
superjumpholdsnd = -1
superjumpprepsnd = -1
superjumpsnd = fmod_event_create_instance("event:/sfx/pep/superjump")
suplexdashsnd = fmod_event_create_instance("event:/sfx/pep/suplexdash")
pogospeed = 2
pogocharge = 100
pogochargeactive = 0
wallclingcooldown = 10
bombcharge = 0
flashflicker = 0
flashflickertime = 0
kickbomb = 0
doublejump = 0
pogospeedprev = 0
fightballadvantage = 0
coopdelay = 0
supercharged = 0
superchargedeffectid = 804
used_supercharge = 0
pizzashield = 0
pizzashieldid = 804
pizzapepper = 0
transformation[0] = (51 << 0)
transformation[1] = (47 << 0)
transformation[2] = (38 << 0)
transformation[3] = (33 << 0)
transformation[4] = (21 << 0)
transformation[5] = (24 << 0)
transformation[6] = (25 << 0)
transformation[7] = (30 << 0)
transformation[8] = (29 << 0)
transformation[9] = (10 << 0)
transformation[10] = (9 << 0)
transformation[11] = (59 << 0)
transformation[12] = (31 << 0)
transformation[13] = (89 << 0)
transformation[14] = (112 << 0)
transformation[15] = (16 << 0)
transformation[16] = (17 << 0)
transformation[17] = (11 << 0)
transformation[18] = (150 << 0)
transformation[19] = (146 << 0)
transformation[20] = (184 << 0)
transformation[21] = (186 << 0)
transformation[22] = (52 << 0)
transformation[23] = (53 << 0)
transformation[24] = (54 << 0)
transformation[25] = (116 << 0)
transformation[26] = (114 << 0)
transformation[27] = (113 << 0)
transformation[28] = (22 << 0)
transformation[29] = (32 << 0)
transformation[30] = (49 << 0)
transformation[31] = (48 << 0)
transformation[32] = (13 << 0)
transformation[33] = (14 << 0)
transformation[34] = (12 << 0)
transformation[35] = (35 << 0)
transformation[36] = (34 << 0)
transformation[37] = (185 << 0)
transformation[38] = (26 << 0)
transformation[39] = (31 << 0)
transformation[40] = (115 << 0)
keysound = 0
c = 0
stallblock = 0
breakdance = 50
skateboarding = 0
hitX = x
hitY = y
hithsp = 0
hitvsp = 0
hitstunned = 0
hitxscale = 1
stunned = 0
hitLag = 25
supercharge = 0
mort = 0
sjumpvsp = -12
freefallvsp = 15
hitlist = ds_list_create()
animlist = ds_list_create()
lungeattackID = -4
lunge_hits = 0
lunge_hit_buffer = 0
lunge_buffer = 0
finisher = 0
finisher_buffer = 0
finisher_hits = 0
uplaunch = 0
downlaunch = 0
dash_doubletap = 0
finishingblow = 0
launch = 0
launched = 1
launch_buffer = 0
jetpackfuel = 0
jetpackmax = 200
walljumpbuffer = 0
farmerpos = 0
clowntimer = 0
knightmiddairstop = 0
knightmove = -1
if (!variable_global_exists("saveroom"))
{
    global.wetham = 0
    global.combodropped = 0
    global.saveroom = ds_list_create()
    global.escaperoom = ds_list_create()
    global.lap = 0
    global.laps = 0
    global.playerhealth = 100
    global.instancelist = ds_list_create()
    global.followerlist = ds_list_create()
    global.maxrailspeed = 2
    global.railspeed = global.maxrailspeed
    global.levelreset = 0
    global.temperature = 0
    global.temperature_spd = 0.01
    global.temp_thresholdnumber = 5
    global.use_temperature = 0
    global.timedgatetimer = 0
    global.timedgatetime = 0
    global.timedgateid = -4
    global.timedgatetimemax = 0
    global.key_inv = 0
    global.shroomfollow = 0
    global.cheesefollow = 0
    global.tomatofollow = 0
    global.sausagefollow = 0
    global.pineapplefollow = 0
    global.pepanimatronic = 0
    global.keyget = 0
    global.collect = 0
    global.lastcollect = 0
    global.collectN = 0
    global.collect_player[0] = 0
    global.collect_player[1] = 0
    global.hats = 0
    global.extrahats = 0
    global.treasure = 0
    global.combo = 0
    global.previouscombo = 0
    global.combotime = 0
    global.combotimepause = 0
    global.prank_enemykilled = 0
    global.prank_cankillenemy = 1
    global.tauntcount = 0
    global.comboscore = 0
    global.savedcomboscore = 0
    global.savedcombo = 0
    global.heattime = 0
    global.pizzacoin = 0
    global.toppintotal = 1
    global.hit = 0
    global.baddieroom = ds_list_create()
    global.hp = 2
    global.gotshotgun = 0
    global.showgnomelist = 1
    global.panic = 0
    global.snickchallenge = 0
    global.golfhit = 0
    global.style = -1
    global.secretfound = 0
    global.shotgunammo = 0
    global.monsterspeed = 0
    global.monsterlives = 3
    global.giantkey = 0
    global.coop = 0
    global.baddiespeed = 1
    global.baddiepowerup = 0
    global.baddierage = 0
    global.style = 0
    global.stylethreshold = 0
    global.pizzadelivery = 0
    global.failcutscene = 0
    global.pizzasdelivered = 0
    global.spaceblockswitch = 1
    global.gerome = 0
    global.pigtotal_add = 0
    global.bullet = 0
    global.fuel = 3
    global.bigfont = font_add_sprite_ext(spr_font, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡¿?.1234567890:ÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜÇ", 1, 0)
    global.smallfont = font_add_sprite_ext(spr_smallerfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡.:?¿1234567890ÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜÇ", 1, 0)
    global.tutorialfont = font_add_sprite_ext(spr_tutorialfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz!¡,.:0123456789'?¿-áäãàâæéèêëíîïóöõôúùûüÿŸÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜÇç", 1, 2)
    global.creditsfont = font_add_sprite_ext(spr_creditsfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz.:!0123456789?'\"ÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜáäãàâéèêëíîïóöõôúùûüÇç_-[]▼()&#风雨廊桥전태양*яиБжидГзвбнль", 1, 2)
    global.moneyfont = font_add_sprite_ext(spr_stickmoney_font, "0123456789$-", 1, 0)
    global.font_map = ds_map_create()
    ds_map_set(global.font_map, "bigfont_en", global.bigfont)
    ds_map_set(global.font_map, "smallfont_en", global.smallfont)
    ds_map_set(global.font_map, "tutorialfont_en", global.tutorialfont)
    ds_map_set(global.font_map, "creditsfont_en", global.creditsfont)
    ds_map_set(global.font_map, "captionfont_en", 0)
    font_add_enable_aa(0)
    var key = ds_map_find_first(global.lang_map)
    for (var i = 0; i < ds_map_size(global.lang_map); i++)
    {
        var lang = ds_map_find_value(global.lang_map, key)
        if ds_map_find_value(lang, "custom_fonts")
        {
            ds_map_set(global.font_map, concat("tutorialfont_", key), lang_get_custom_font("tutorialfont", lang))
            ds_map_set(global.font_map, concat("creditsfont_", key), lang_get_custom_font("creditsfont", lang))
            ds_map_set(global.font_map, concat("bigfont_", key), lang_get_custom_font("bigfont", lang))
            ds_map_set(global.font_map, concat("smallfont_", key), lang_get_custom_font("smallfont", lang))
            ds_map_set(global.font_map, concat("captionfont_", key), lang_get_custom_font("captionfont", lang))
        }
        key = ds_map_find_next(global.lang_map, key)
    }
    global.collectfont = font_add_sprite_ext(spr_font_collect, "0123456789", 1, 0)
    global.combofont = font_add_sprite_ext(spr_font_combo, "0123456789/:", 1, 0)
    global.combofont2 = font_add_sprite_ext(spr_tv_combobubbletext, "0123456789", 1, 0)
    global.combofontchaosless = font_add_sprite_ext(spr_tv_combobubbletext_chaosless, "0123456789", 1, 0)
    global.wartimerfont1 = font_add_sprite_ext(spr_wartimer_font1, "1234567890", 1, 0)
    global.wartimerfont2 = font_add_sprite_ext(spr_wartimer_font2, "1234567890", 1, 0)
    global.ammorefill = 0
    global.ammoalt = 1
    global.mort = 0
    global.stylelock = 0
    global.attackstyle = 0
    global.pummeltest = 1
    global.horse = 0
    global.checkpoint_room = -4
    global.checkpoint_door = "A"
    global.kungfu = 0
    global.graffiticount = 0
    global.graffitimax = 20
    global.noisejetpack = 0
    global.hasfarmer = array_create(3, 0)
    global.savedattackstyle = -4
    global.throw_frame = 0
    global.throw_frame[720] = 11
    global.throw_frame[722] = 13
    global.throw_frame[721] = 18
    global.throw_frame[716] = 6
    global.throw_frame[737] = 2
    global.throw_frame[374] = 7
    global.throw_frame[40] = 2
    global.throw_frame[739] = 2
    global.throw_frame[718] = 2
    global.throw_frame[719] = 8
    global.throw_frame[125] = 8
    global.throw_frame[726] = 6
    global.throw_frame[731] = 3
    global.throw_frame[1090] = 8
    global.throw_frame[729] = 15
    global.throw_frame[728] = 10
    global.throw_frame[727] = 2
    global.throw_frame[416] = 6
    global.throw_frame[708] = 9
    global.throw_frame[709] = 9
    global.throw_frame[684] = 9
    global.throw_frame[420] = 13
    global.throw_frame[748] = 3
    global.throw_frame[1128] = 7
    global.throw_frame[528] = 11
    global.throw_frame[34] = 13
    global.throw_frame[339] = 13
    global.throw_sprite = 0
    global.throw_sprite[720] = 157
    global.throw_sprite[722] = 189
    global.throw_sprite[721] = 569
    global.throw_sprite[716] = 316
    global.throw_sprite[737] = 540
    global.throw_sprite[374] = 593
    global.throw_sprite[40] = 349
    global.throw_sprite[739] = 402
    global.throw_sprite[718] = 318
    global.throw_sprite[719] = 435
    global.throw_sprite[125] = 435
    global.throw_sprite[726] = 463
    global.throw_sprite[731] = 328
    global.throw_sprite[1090] = 1765
    global.throw_sprite[729] = 483
    global.throw_sprite[728] = 395
    global.throw_sprite[727] = 557
    global.throw_sprite[416] = 593
    global.throw_sprite[708] = 645
    global.throw_sprite[709] = 645
    global.throw_sprite[684] = 645
    global.throw_sprite[420] = 2514
    global.throw_sprite[748] = 4342
    global.throw_sprite[1128] = 28
    global.throw_sprite[528] = 3534
    global.throw_sprite[34] = 3356
    global.throw_sprite[339] = 948
    global.reset_timer = 0
    global.reset_timer[720] = 200
    global.reset_timer[722] = 200
    global.reset_timer[721] = 200
    global.reset_timer[716] = 200
    global.reset_timer[737] = 100
    global.reset_timer[374] = 400
    global.reset_timer[40] = 100
    global.reset_timer[739] = 100
    global.reset_timer[718] = 150
    global.reset_timer[719] = 200
    global.reset_timer[125] = 200
    global.reset_timer[726] = 100
    global.reset_timer[731] = 200
    global.reset_timer[1090] = 200
    global.reset_timer[729] = 200
    global.reset_timer[728] = 100
    global.reset_timer[727] = 200
    global.reset_timer[416] = 100
    global.reset_timer[708] = 60
    global.reset_timer[709] = 60
    global.reset_timer[684] = 60
    global.reset_timer[420] = 10
    global.reset_timer[748] = 100
    global.reset_timer[1128] = 100
    global.reset_timer[528] = 100
    global.reset_timer[34] = 100
    global.reset_timer[339] = 100
}
dos = 1
quickroll = 0
ninjablock = 1
ballspeed = 14
tornadospeed = -16
allowjawsfly = 1
jawsbuffer = 0
jawsup = 0
hoverspin = 5
mkickbuffer = 0
slashstored = 1
wrollbuffer = 0
wcrouchbuffer = 0
wallclingbuffer = 0
wallclingpulse = 0
wallstick = 0
wmlongjumpbuffer = 0
katanatype = 0
katanatypebuffer = katanatype
katanawallexit = 0
kpulsebuffer = 0
allowkpulse = 1
fakehsp = 0
katanaxscale = 0
wsndroll = 0
callstored = 0
brickcallbuffer = 0
clingboost = 0
mangocall = 0
clingexitspeed = 0
wethamcombo = [0, 0, 0, 0, 0]
bombdivesmash = 0
jawsfriction = 0
global.wdodge_color1 = [109, 255, 243]
global.wdodge_color2 = [47, 52, 255]
katanawalloutbuffer = 0
ballvertical = 0
wm = 1
angle = 0
mach4mode = 0
railmomentum = 0
railmovespeed = 0
raildir = 1
boxxed = 0
boxxeddash = 0
boxxeddashbuffer = 0
cheesepeptimer = -1
cheeseballbounce = 0
slopejump = 0
slopejumpx = 0
hooked = 0
swingdingendcooldown = 0
crouchslipbuffer = 0
breakdance_speed = 0.25
notecreate = 50
jetpackbounce = 0
firemouthflames = 0
ghostdash = 0
ghostdashcooldown = 0
ghostdashmovespeed = 0
ghostpepper = 0
ghosteffect = 0
ghostbump = 1
ghostbumpbuffer = -1
dashcloudtimer = 0
grabclimbbuffer = 0
gustavohitwall = 0
gusdashpadbuffer = 0
holycross = 0
knightdowncloud = 0
piledrivereffect = 0
fireasslock = 0
pistolcharge = 0
pistolcharged = 0
pistolchargebuffer = 0
pistolchargedelay = 5
pistolchargeshooting = 0
pistolchargeshot = 8
pistolchargeeffect = 0
gravesurfingjumpbuffer = 0
spinsndbuffer = 5
boxxedspinbuffer = 0
noisebossscream = 0
gallopingsnd = fmod_event_create_instance("event:/sfx/misc/galloping")
tornadolandanim = 0
bombthrow = 0
fakeceilingrun = 0
ceilinded = 0
~~~
## BeginStep

~~~js
// This needs a REBUILD
if (global.caoschase && global.ikframes && (!global.iexception) && ((sprite_index == spr_player_ratmountwalljump && hoverspin < 10) || sprite_index == spr_player_mangodive || sprite_index == spr_player_mangoboostend || sprite_index == spr_player_mangoboostfly || sprite_index == spr_player_mangoboost || sprite_index == spr_player_poundcancel || sprite_index == spr_player_Sjump || sprite_index == spr_player_rolljump || sprite_index == spr_player_crazyrun || sprite_index == spr_player_poundcancelstart || sprite_index == spr_player_poundcancelstart || sprite_index == spr_player_poundcanceldive || sprite_index == spr_wethamdivel || sprite_index == spr_wethamroll || sprite_index == spr_player_snapjumpstart || sprite_index == spr_player_Sjumpcancel || sprite_index == spr_player_snapjump || sprite_index == spr_player_snapjumpinter || sprite_index == spr_player_snaphighjump || sprite_index == spr_player_spinkf || string_copy(sprite_get_name(sprite_index), 1, 16) == "spr_m_lastbreath" || sprite_index == spr_m_call || sprite_index == spr_dos_unhingedrun))
{
    ikalpha = 1
    ikcurrent = 1
    with (scr_chaosafterimage(x, y, sprite_index, image_index, 1, chaoscolor))
    {
        image_xscale = other.xscale
        playerid = other.id
    }
}
else
{
    ikcurrent = 0
    ikalpha = Approach(ikalpha, 0, 0.075)
}
if (global.caoschase || instance_exists(obj_chaosangel))
{
    kickcc++
    if (kickcc >= 3)
    {
        kickcc = 0
        chaoscolor++
        if (chaoscolor > 3)
            chaoscolor = 0
    }
}
if ((!((global.caoschase && global.ikframes && (!global.iexception)))) && (string_copy(sprite_get_name(sprite_index), 1, 16) == "spr_m_lastbreath" || sprite_index == spr_w_spinkick || sprite_index == spr_wethamroll || sprite_index == spr_lonewetham_tumble))
{
    kickiw++
    iwalpha = 0.66
    with (scr_windafterimage(x, y, sprite_index, image_index, xscale))
        playerid = other.id
}
else
{
    kickiw = 0
    iwalpha = Approach(iwalpha, 0, 0.075)
}

~~~
## EndStep

~~~js
// Vainilla stuff
player_index = swap_is_player2()
var pal = player_index
if (global.swapmode && obj_savesystem.ispeppino)
    pal = (!pal)
paletteselect = player_paletteselect[pal]
global.palettetexture = player_patterntexture[pal]
player_paletteindex = pal
if (global.collect != global.lastcollect)
{
    var diff = global.collect - global.lastcollect
    global.lastcollect = global.collect
    if global.swapmode
        global.collect_player[player_index] += diff
}
// Cool Stuff
fightmode = (instance_exists(obj_bosscontroller) && ispeppino && (!instance_exists(obj_pistolpickup)))
if ((global.noisejetpack || flamedash) && ispeppino && dos)
{
    with (obj_iceblock_breakable)
    {
        if (place_meeting((x - other.hsp), y, other) || place_meeting((x - other.xscale), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))
        {
            instance_destroy()
            GamepadSetVibration(0, 0.5, 0.5, 0.8)
        }
    }
}
if ratpoison
{
    with (collision_rectangle((x - 50), (y - 100), (x + 50), (y + 100), obj_ratblock, 0, 0))
    {
        instance_destroy()
        GamepadSetVibration(0, 0.5, 0.5, 0.8)
    }
    with (collision_rectangle((x - 50), (y - 100), (x + 50), (y + 100), obj_badrat, 0, 0))
    {
        instance_destroy()
        GamepadSetVibration(0, 0.5, 0.5, 0.8)
    }
}
if infijump
{
    var infiblock = (state != (150 << 0) && state != (265 << 0) && state != (146 << 0) && state != (146 << 0) && state != (93 << 0))
    if (infiblock && visible)
    {
        if (key_jump && state != (306 << 0))
        {
            fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
            input_buffer_jump = 0
            snapjumps += 1
            if (snapjumps > 1 || movespeed >= 12)
            {
                instance_create(x, y, obj_noiseeffect)
                repeat (5)
                    instance_create(x, y, obj_firemouthflame)
            }
            else
                instance_create(x, (y + 30), obj_bumpeffect)
            if (movespeed >= 9 && movespeed <= 20)
                movespeed += 4
            sprite_index = spr_player_snaphighjump
            image_index = 0
            vsp = -22
            jumpstop = 0
            state = (306 << 0)
            return;
        }
    }
}
var flamelock = (state != (265 << 0) && state != (146 << 0) && state != (296 << 0) && state != (150 << 0) && state != (9 << 0) && state != (8 << 0) && state != (84 << 0) && state != (107 << 0) && state != (97 << 0) && state != (165 << 0) && state != (108 << 0) && state != (165 << 0) && state != (111 << 0) && state != (101 << 0) && state != (95 << 0) && state != (106 << 0) && state != (147 << 0) && state != (105 << 0))
if flamedash
{
    if (key_slap && flamelock && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))
        scr_doni_flamedash()
    if (flameheat > 0)
        flameheat--
    if (flameheat < 0)
        flameheat = 0
}
if dragonsnap
{
    var _dsc = collision_line(x, (y + 1), x, (y + 10), obj_solid, 0, 1)
    if (dragonbuffer == 0 && flamelock && key_shoot2 && point_in_camera(x, y, view_camera[0]) && visible && (!instance_exists(obj_dragonsnap_effect)) && _dsc == -4)
    {
        dragonbuffer = 20
        var ass1 = x - camera_get_view_x(view_camera[0])
        var ass2 = y - camera_get_view_y(view_camera[0])
        with (instance_create(x, y, obj_dragoncursor))
            targetplayer = other.id
        with (instance_create(x, y, obj_dragonsnap_effect))
            player = [ass1, ass2, other.xscale]
    }
    if (dragonbuffer > 0)
        dragonbuffer--
    if (dragonsnap && (sprite_index == spr_dos_dragonsnap || abs(other.hsp) > 16))
    {
        with (obj_asteroid)
        {
            if (place_meeting((x - other.hsp), y, other) || place_meeting((x - 1), y, other) || place_meeting((x + 1), y, other) || place_meeting(x, (y + other.vsp), other) || place_meeting(x, (y + 1), other) || place_meeting(x, (y - 1), other))
            {
                instance_destroy()
                GamepadSetVibration(0, 0.5, 0.5, 0.8)
            }
        }
    }
}
if (paletteselect == 23 && ispeppino)
{
    if (vsp < 0 && (floor(image_index) % 2) == 0)
        create_debris(x, (y + 43), 4602)
    if (hsp != 0 && (floor(image_index) % 4) == 0)
        create_debris(x, (y + 43), 4602)
}
if (state == (61 << 0))
    killbuffer = 50
if (killbuffer > 0)
    killbuffer--
if (grounded || (sprite_index != spr_player_rolljump && sprite_index != spr_dive))
    canrollsnd = 0
if (sprite_index != spr_player_snapjumpstart && sprite_index != spr_player_snapjumpstart && state != (306 << 0))
    snapjumps = 0
if (isgustavo || characterID == 1)
{
    if (!flash)
        wmlongjumpbuffer = 0
    if (state == (296 << 0) || state == (146 << 0))
    {
        clingexitspeed = 0
        if instance_exists(obj_wethamtornado)
        {
            with (obj_wethamtornado)
            {
                if (state == (1 << 0))
                    instance_destroy()
            }
            with (obj_wetham_R)
                instance_destroy()
            brick = 1
        }
    }
    if (sprite_index == spr_wethamroll && (!wsndroll))
    {
        wsndroll = 1
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/roll", x, y)
    }
    if (brickcallbuffer > 0)
        brickcallbuffer--
    if (key_shoot2 && instance_exists(obj_mango_brickball) && state != (3 << 0) && state != (23 << 0) && flamelock)
    {
        if (distance_to_point(obj_mango_brickball.x, obj_mango_brickball.y) <= obj_mango_brickball.recover_distance)
        {
            state = (23 << 0)
            sprite_index = spr_w_megaslash
            image_index = 0
            fmod_event_one_shot_3d("event:/sfx/misc/comboend", x, y)
            fmod_event_one_shot_3d("event:/sfx/misc/toppingot", x, y)
            with (obj_mango_brickball)
            {
                state = (3 << 0)
                sprite_index = spr_m_call
                instance_create(x, y, obj_wm_note)
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/call", x, y)
            }
        }
        else if key_shoot2
            fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)
    }
    if (state != (3 << 0))
        angle = 0
    if (mkickbuffer > 0)
        mkickbuffer--
    if (key_shoot2 && brickcallbuffer == 0)
        brickcallbuffer = 13
    if brick
        callstored = 0
    if (sprite_index != spr_wm_djump && sprite_index != spr_player_mangoboostfly && sprite_index != spr_wm_ball_doublejumpl)
        hoverspin = 5
    if (sprite_index != spr_wethamroll)
        wsndroll = 0
    if (grounded || abs(hsp) < 12)
        ninjablock = 1
    if ((!isgustavo) || state != (191 << 0) || key_attack)
        ratdance_speed = 0.25
    if (kpulsebuffer > 0)
    {
        movespeed = fakehsp + kpulsebuffer
        kpulsebuffer -= 0.5
        if (grounded || xscale != katanaxscale)
            kpulsebuffer -= 0.5
        if (state == (37 << 0))
            kpulsebuffer = 0
    }
    else
        kpulsebuffer = 0
    if (brick != brickskinbuffer)
    {
        scr_wm_skinswitch()
        brickskinbuffer = brick
    }
    if ((!brick) && (instance_exists(obj_mango_companion) || instance_exists(obj_brickcomeback)))
    {
        if (state == (296 << 0))
        {
            brick = 1
            instance_destroy(obj_mango_companion)
            instance_destroy(obj_brickcomeback)
        }
    }
    if ((!instance_exists(obj_mango_companion)) && brick)
    {
        if ((state == (5 << 0) && sprite_index != spr_wm_pounce_dive && sprite_index != spr_wm_pounce_slide) || (state == (37 << 0) && string_copy(sprite_get_name(sprite_index), 1, 11) != "spr_wm_wall") || state == (2 << 0) || state == (106 << 0) || state == (100 << 0) || state == (101 << 0) || state == (108 << 0) || (state == (104 << 0) && sprite_index == spr_wethamwalljump) || state == (290 << 0))
        {
            instance_create(x, y, obj_mango_companion)
            brick = 0
        }
    }
    if (state != (97 << 0))
        mangocall = 0
    if ((grounded && vsp > -0.5) || state == (37 << 0) || state == (198 << 0))
    {
        wethamcombo[0] = 0
        wethamcombo[1] = 0
        wethamcombo[2] = 0
        wethamcombo[3] = 0
    }
    if ((grounded && vsp > -0.5) || state == (37 << 0))
        wethamcombo[4] = 0
    if (grounded || state == (37 << 0))
    {
        allowkpulse = 1
        allowjawsfly = 1
    }
    if (state != (198 << 0))
        ballvertical = 0
    if (state == (0 << 0))
        katanatype = 0
    if (state != (198 << 0) && state != (37 << 0) && state != (23 << 0) && state != (80 << 0))
        jawsup = 0
    if (state != (2 << 0) && grounded)
        slashstored = 0
    if (state == (165 << 0))
    {
        if brick
        {
            brick = 0
            with (instance_create(x, y, obj_mango_flee))
            {
                image_xscale = other.xscale
                launchforce = abs(other.hsp) + 4
            }
        }
        else if instance_exists(obj_mango_companion)
        {
            with (instance_create(obj_mango_companion.x, obj_mango_companion.y, obj_mango_flee))
            {
                image_xscale = other.xscale
                launchforce = abs(other.hsp) + 4
            }
            with (obj_mango_companion)
                instance_destroy()
        }
    }
    if (katanatypebuffer != katanatype && (!brick))
    {
        switch katanatype
        {
            case 0:
                spr_mach4 = 1165
                spr_mach3jump = 3546
                break
            case 1:
                spr_mach4 = 4911
                spr_mach3jump = 4913
                break
            case 2:
                spr_mach4 = 4910
                spr_mach3jump = 3546
                break
        }

        scr_arc_wmspr()
        katanatypebuffer = katanatype
    }
    if (sprite_index != spr_wm_djump)
        fmod_event_instance_stop(wmcopter, 1)
}
if (characterID == 10)
{
    if place_meeting(x, (y - 1), obj_solid)
        ceilinded = 1
    else
    {
        ceilinded = 0
        fakeceilingrun = 0
    }
}
if (state != (306 << 0) && ispeppino)
    snaphold = 0
if (global.caoschase || instance_exists(obj_chaosangel))
    scr_chaoskolorshift()
if (key_shoot2 && (!ispeppino))
    instance_create(x, y, obj_canonexplosion)
if (keyboard_check_pressed(vk_f4) && (!instance_exists(obj_chaosangel)))
{
    with (instance_create(x, y, obj_chaosangel))
    {
        playerid = obj_player1.id
        type = 0
        if instance_exists(obj_chaosUI)
            array_push(obj_chaosUI.angelqueue, id)
    }
}
if keyboard_check_pressed(vk_f7)
    displaykeys = (!displaykeys)
if keyboard_check_pressed(vk_f6)
    displaydata = (!displaydata)
if keyboard_check(ord("1"))
{
    characterID = 0
    scr_character_spr_init()
}
if keyboard_check(ord("2"))
{
    characterID = 1
    scr_character_spr_init()
}
if keyboard_check(ord("9"))
{
    characterID = 10
    scr_character_spr_init()
}
if (keyboard_check(ord("0")) && (!instance_exists(obj_fakedonisha)))
    instance_create(x, y, obj_fakedonisha)
if keyboard_check_pressed(ord("P"))
    instance_create(x, (y - 200), obj_slipnslide)
if (movespeed < 21)
{
    if mach5
        alarm[11] = 350
    mach5 = 0
}
if (key_shoot2 || input_buffer_chaos > 0)
    input_buffer_chaos++
else
    input_buffer_chaos = 0
if ((!key_shoot) || input_buffer_chaos == -1)
    input_buffer_chaos = 0
~~~
## RoomStart

~~~js
if (sprite_index == spr_m_call)  
{  
    move = key_left + key_right  
    mangocall = 0  
    brick = 1  
    flash = 1  
    if (move != 0)  
        xscale = move  
    input_buffer_jump = 0  
    particle_set_scale((4 << 0), xscale, 1)  
    create_particle(x, y, (4 << 0), 0)  
    ratmount_movespeed = abs(16)  
    movespeed = ratmount_movespeed * xscale  
    hsp = movespeed  
    sprite_index = spr_player_ratmountdashjump  
    image_index = 0  
    jumpAnim = 1  
    state = (192 << 0)  
    vsp = 0  
    jumpstop = 0  
}  
if (sprite_index == spr_wm_balltochomp)  
{  
    state = (108 << 0)  
    scr_wm_dobombdive(true)  
}  
flameheat = 0  
with (obj_player1)  
{  
    if (paletteselect == 18 && ispeppino)  
    {  
        spr_suplexdash = 4707  
        spr_suplexdashjumpstart = 4705  
        spr_suplexdashjump = 4704  
        spr_longjump = 4703  
        spr_longjumpend = 4706  
    }  
}  
if (room == timesuproom)  
{  
    scale_xs = 1  
    scale_ys = 1  
    xscale = 1  
    visible = 1  
}  
savedhallwaydirection = hallwaydirection  
savedhallway = hallway  
savedvhallwaydirection = vhallwaydirection  
savedverticalhallway = verticalhallway  
if (room != boss_noise)  
{  
    global.resetdoise = 0  
    resetdoisecount = 0  
}  
if global.swapmode  
    instance_create_unique(x, y, 298)  
with (obj_secretportal)  
{  
    if secret  
    {  
        if (room != tower_soundtestlevel && (!instance_exists(obj_ghostcollectibles)))  
        {  
            if (!instance_exists(obj_randomsecret))  
            {  
                global.secretfound++  
                var val = global.secretfound  
                if (val >= 3)  
                    val = 3  
                if (val == 1)  
                    var txt = lang_get_value("secret_text1")  
                else  
                    txt = lang_get_value("secret_text2")  
                txt = embed_value_string(txt, [val])  
                create_transformation_tip(txt)  
            }  
            instance_create(0, 0, obj_ghostcollectibles)  
            trace(instance_number(obj_ghostcollectibles))  
        }  
    }  
}  
if (!is_bossroom())  
    hitstunned = 0  
if global.levelreset  
{  
    scr_playerreset()  
    global.levelreset = 0  
    instance_destroy(obj_comboend)  
    instance_destroy(obj_combotitle)  
    global.combodropped = 0  
}  
if (room == tower_finalhallway && targetDoor == "C" && state == (95 << 0))  
    state = (0 << 0)  
if global.levelcomplete  
{  
    global.levelcomplete = 0  
    global.leveltorestart = -4  
    global.leveltosave = -4  
    global.startgate = 0  
}  
if (state == (95 << 0) && global.coop == 1 && (!(place_meeting(x, y, obj_exitgate))))  
{  
    if (object_index == obj_player1 && obj_player1.spotlight == 0)  
        visible = 0  
    if (object_index == obj_player2 && obj_player1.spotlight == 1)  
        visible = 0  
}  
if (global.coop == 1)  
{  
    scr_changetoppings()  
    if (!instance_exists(obj_cooppointer))  
        instance_create(x, y, obj_cooppointer)  
    if (!instance_exists(obj_coopflag))  
        instance_create(x, y, obj_coopflag)  
}  
if (state == (79 << 0))  
    state = (0 << 0)  
if (place_meeting(x, y, obj_boxofpizza) || place_meeting(x, (y - 1), obj_boxofpizza))  
{  
    box = 1  
    hallway = 0  
    state = (100 << 0)  
}  
if (object_index != obj_player2 || global.coop == 1)  
{  
    if (targetDoor == "A" && instance_exists(obj_doorA))  
    {  
        if (hallway == 1)  
            x = obj_doorA.x + hallwaydirection * 100  
        else if (box == 1)  
            x = obj_doorA.x + 32  
        else  
            x = obj_doorA.x + 16  
        y = obj_doorA.y - 14  
    }  
    if (targetDoor == "B" && instance_exists(obj_doorB))  
    {  
        if (hallway == 1)  
            x = obj_doorB.x + hallwaydirection * 100  
        else if (box == 1)  
            x = obj_doorB.x + 32  
        else  
            x = obj_doorB.x + 16  
        y = obj_doorB.y - 14  
    }  
    if (targetDoor == "C" && instance_exists(obj_doorC))  
    {  
        if (hallway == 1)  
            x = obj_doorC.x + hallwaydirection * 100  
        else if (box == 1)  
            x = obj_doorC.x + 32  
        else  
            x = obj_doorC.x + 16  
        y = obj_doorC.y - 14  
    }  
    if (targetDoor == "D" && instance_exists(obj_doorD))  
    {  
        if (hallway == 1)  
            x = obj_doorD.x + hallwaydirection * 100  
        else if (box == 1)  
            x = obj_doorD.x + 32  
        else  
            x = obj_doorD.x + 16  
        y = obj_doorD.y - 14  
    }  
    if (targetDoor == "E" && instance_exists(obj_doorE))  
    {  
        if (hallway == 1)  
            x = obj_doorE.x + hallwaydirection * 100  
        else if (box == 1)  
            x = obj_doorE.x + 32  
        else  
            x = obj_doorE.x + 16  
        y = obj_doorE.y - 14  
    }  
    if (targetDoor == "F" && instance_exists(obj_doorF))  
    {  
        if (hallway == 1)  
            x = obj_doorF.x + hallwaydirection * 100  
        else if (box == 1)  
            x = obj_doorF.x + 32  
        else  
            x = obj_doorF.x + 16  
        y = obj_doorF.y - 14  
    }  
    if (targetDoor == "G" && instance_exists(obj_doorG))  
    {  
        if (hallway == 1)  
            x = obj_doorG.x + hallwaydirection * 100  
        else if (box == 1)  
            x = obj_doorG.x + 32  
        else  
            x = obj_doorG.x + 16  
        y = obj_doorG.y - 14  
    }  
}  
if verticalhallway  
{  
    verticalbuffer = 2  
    var _vinst = noone  
    with (obj_verticalhallway)  
    {  
        event_perform(ev_step, ev_step_normal)  
        if (targetDoor == other.targetDoor)  
            _vinst = id  
    }  
    if (_vinst != noone)  
    {  
        x = _vinst.x + _vinst.sprite_width * vertical_x  
        var bbox_size = abs(bbox_right - bbox_left)  
        x = clamp(x, (_vinst.x + bbox_size), (_vinst.bbox_right - bbox_size))  
        trace(x, _vinst.x)  
        if (vhallwaydirection > 0)  
            y = _vinst.bbox_bottom + 32  
        else  
            y = _vinst.bbox_top - 78  
        if (verticalstate == (37 << 0))  
            state = (37 << 0)  
        if (state == (37 << 0))  
        {  
            x = round(x)  
            var i = 0  
            while (!(scr_solid((x + xscale), y)))  
            {  
                x += xscale  
                trace(x)  
                i++  
                if (i > room_width)  
                    break  
                else  
                    continue  
            }  
        }  
        y += verticalhall_vsp  
        vsp = verticalhall_vsp  
    }  
    y += (vhallwaydirection * 20)  
    y = floor(y)  
    verticalstate = (0 << 0)  
}  
if (character == "M" && place_meeting(x, y, obj_boxofpizza))  
{  
    while place_meeting(x, y, obj_boxofpizza)  
    {  
        var _inst = instance_place(x, y, obj_boxofpizza)  
        y -= _inst.image_yscale  
    }  
}  
if (state == (119 << 0))  
{  
    x = obj_stopsign.x  
    y = obj_stopsign.y  
}  
if (state == (292 << 0))  
{  
    x = obj_spaceshuttlestop.x  
    y = obj_spaceshuttlestop.y  
}  
hallway = 0  
verticalhallway = 0  
box = 0  
if (isgustavo || characterID == 1)  
{  
    brick = 1  
    brickskinbuffer = 1  
    scr_wm_skinswitch()  
}  
if place_meeting(x, y, obj_exitgate)  
{  
    global.prank_cankillenemy = 1  
    with (instance_place(x, y, obj_exitgate))  
        other.x = x  
}  
if (room == rank_room)  
{  
    x = rankpos_x  
    y = rankpos_y  
}  
x = floor(x)  
y = floor(y)  
roomstartx = x  
roomstarty = y  
with (obj_roomposoverride)  
{  
    if (targetDoor == other.targetDoor)  
    {  
        other.roomstartx = x  
        other.roomstarty = y  
    }  
}  
if (state == (61 << 0))  
{  
    hitX = x  
    hitY = y  
    hitLag = 0  
}  
with (obj_camera)  
    state = (0 << 0)
~~~
## DrawGUI

~~~js
scr_displaykeys(16776960, displaykeys)  
scr_displaydata(displaydata)
~~~
