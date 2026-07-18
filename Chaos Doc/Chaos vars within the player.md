Variables initialized in create | obj_player, used by the player
## create | obj_player
[[obj_player#Create]]
### Universal Global
~~~js
// Caos challenge
// Boolean for caos challenge
global.caoschase = 0  
// Color shifting
global.chaoscolors = [make_colour_rgb(255, 160, 64), make_colour_rgb(248, 255, 21), make_colour_rgb(21, 255, 81), make_colour_rgb(234, 21, 255)]  
global.khaoshex = 16777215  
global.khaosr = 1  
global.khaosg = 1  
global.khaosb = 1  
global.khaosactives = [0, 0, 0, 0]  
// Customization
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
~~~
### Universal Local
~~~js
// For powerups colorshifting
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
~~~
#### Iframe effects
Managed kicks in:
- [[obj_player#BeginStep]]
Main Script:
- [[scr_chaoskolorshift()]]
