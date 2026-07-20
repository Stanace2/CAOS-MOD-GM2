function scr_chaos_varinit() {
	// Mort friendship
	global.friendShip = 0 // Used in obj_mort_Collision_obj_player
	// Goth palette
	global.gothkills = 0  
	global.gothunlocked = 0  
	// Debug options, used in drawGUI | obj_player, set on EndStep | obj_player
	displaykeys = 0  
	displaydata = 0
	input_buffer_chaos = 0
	// 0 Donisha 1 WM 2 Stefano 3 Cezar 4 Cleo 5 Acexby 9 fakeDonisha
	// For playable pep and noise 10 Pep 12 Noise
	characterID = 0
	
	// ==========Donisha's variables==========
	snaphold = 0  
	wallclimbbuffer = 0
	fightmode = 0  
	snapjumps = 0  
	drillexitspd = 0  
	mach5 = 0  
	machengineprev = -1  
	mach5buffer = 0
	//canrollsnd = 0  // Have to check this one to optimize it
	poundbuffer = 0
	quickroll = 0
	// Italian manners
	dos = 1 // Going to be replaced for a more global option
	
	// ==========W&M's variables==========
	global.wdodge_color1 = [109, 255, 243]
	global.wdodge_color2 = [47, 52, 255]
	// Pep gustavo switch Probably be obsolete later on
	global.wetham = 0
	// Mango's
	ballspeed = 14
	allowjawsfly = 1 // jawsHover
	jawsbuffer = 0
	jawsup = 0
	hoverspin = 5
	mkickbuffer = 0
	wallstick = 0 // Obsolete, but referenced
	callstored = 0
	brickcallbuffer = 0
	mangocall = 0
	bombdivesmash = 0
	jawsfriction = 0
	ballvertical = 0
	// Wetham's
	ninjablock = 1 // variable used for old wetham divel, not really used in current dev build
	tornadospeed = -16 // Used for movement for the superjump
	slashstored = 1
	wrollbuffer = 0
	wcrouchbuffer = 0
	wallclingbuffer = 0
	wallclingpulse = 0
	wmlongjumpbuffer = 0
	katanatype = 0
	katanatypebuffer = katanatype
	katanawallexit = 0
	kpulsebuffer = 0
	allowkpulse = 1 // Katanapulse
	fakehsp = 0 // Katanapulse
	katanaxscale = 0 // Katanapulse
	wsndroll = 0
	clingboost = 0
	clingexitspeed = 0
	wethamcombo = [0, 0, 0, 0, 0]
	katanawalloutbuffer = 0
	kickiw = 0 // Dodge kick afterimages
	iwalpha = 0 // Dodge afterimages
	// Italian manners variable, obsolete
	wm = 1
	// Vainilla is brick
	brickskinbuffer = 1 // Used for the skinswitcher for these guys
	
	// ==========Caos challenge==========
	// Boolean for caos challenge
	global.caoschase = 0  
	// Color shifting
	global.chaoscolors = [make_colour_rgb(255, 160, 64), make_colour_rgb(248, 255, 21), make_colour_rgb(21, 255, 81), make_colour_rgb(234, 21, 255)]  
	global.khaoshex = c_white
	global.khaosr = 1  
	global.khaosg = 1  
	global.khaosb = 1  
	global.khaosactives = [0, 0, 0, 0]  
	// Customization
	global.manners = 0
	global.kpanic = 0  
	global.kbells = 1  
	global.kpowerups = 1  
	global.ikframes = 1  
	global.kpm = 1  
	global.ktoppins = 1  
	global.k3lap = 0  
	global.ktoppingoal = 0  
	global.iexception = 0 
	// When caos challenge should be deactivated for a especific level
	// Used in obj_startgate_Collision_obj_player
	global.chaosexception = 0
	// For powerups colorshifting
	chaoskolors = [[204, 20, 42, 81], [[0.9607843137254902, 0.12941176470588237, 1], [1, 0.5333333333333333, 0], [1, 0.9803921568627451, 0.34901960784313724], [0.6078431372549019, 1, 0]]]
	kolorhexr = 0  
	kolorhexg = 0  
	kolorhexb = 0  
	currentkolors = []  
	currentkolorindex = 0  
	kolorindex = -1  
	kolortimer = 0  
	chaoscolor = 0  
	kickcc = 0  
	// Iframes management
	ikcurrent = 0  
	ikalpha = 0  
	// Power ups
	ratpoison = 0  
	infijump = 0  
	flamedash = 0  
	flamedashbuffer = 0  
	flamedashkick = 22  
	flameheat = 0  
	flamejumped = 0  
	killbuffer = 0
	dragonsnap = 0  
	dragonbuffer = 0
}