Variables used to manage specific fmod sounds
***
## create | obj_player
Variables that interact with game code or that loop [[obj_player#Create]]
~~~js
//Donisha mach levels when using the machsplit
machenginesnd = fmod_event_create_instance("event:/chaos-sfx/donisha/machEngine")
fmod_event_instance_set_parameter(machenginesnd, "state", 0, 1)
//Doublejump spin soundeffect
wmcopter = fmod_event_create_instance("event:/chaos-sfx/wm/wmcopter")
fmod_event_instance_set_parameter(wmcopter, "speed", 0, 1)
//Mach5 horn
mach5snd = fmod_event_create_instance("event:/chaos-sfx/donisha/mach5sup")
//WM superjump spin soundeffect
mangospinsnd = fmod_event_create_instance("event:/chaos-sfx/wm/mango/mspin")
//WM superjump ceiling soundeffect
mangospinceilingsnd = fmod_event_create_instance("event:/chaos-sfx/wm/mango/mspinceiling")
//Wetham kicking Mango soundeffect
snd_wethamkick = fmod_event_create_instance("event:/chaos-sfx/wm/wmbrickkick")
fmod_event_instance_set_parameter(snd_wethamkick, "state", 0, 1)
~~~
