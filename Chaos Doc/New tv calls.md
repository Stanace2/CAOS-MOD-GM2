## scr_hurtplayer

~~~js
// This is found in a really weird expression in scr_hurtplayer, youll have to do ctrl f
if (!_swap)  
{  
	if (!isgustavo)  
		// Calling the new hurt sprite
		tv_do_expression(choose(spr_tv_exprhurt, spr_tv_exprhurted))  
	else  
		tv_do_expression(spr_tv_hurtG)
}
~~~
## obj_pizzakinparent
### Create

~~~js
depth = 50  
event_inherited()  
// This is changed to only display normally with noise or gustavo, prob obsolete for the future
if (obj_player.isgustavo || (!obj_player.ispeppino))  
    tv_do_expression(spr_tv_exprcollect, 1)  
image_speed = 0.35  
yoffset = 0  
hsp = 0  
vsp = 0  
grav = 0.23  
movespeed = 3  
panic = 0  
playerid = 587  
state = (0 << 0)  
spr_intro = sprite_index  
spr_run = sprite_index  
spr_idle = sprite_index  
spr_panic = sprite_index  
spr_taunt = sprite_index  
spr_intro_strongcold = sprite_index  
spr_run_strongcold = sprite_index  
spr_idle_strongcold = sprite_index  
xprev = x  
yprev = y  
// Sum to the total of toppins gathered, works for the UI to tell if you have them all
if global.caoschase  
    obj_chaoschaser.toppins++
~~~
## obj_pizzakin(child)
### Create

~~~js
event_inherited()  
// This is an specific call of every child of obj_pizzakinparent
// This case is for mushroom, same for the others with respective toppin
if (obj_player.ispeppino && (!obj_player.isgustavo))  
    tv_do_expression(spr_tv_exprshroom, 1)  
spr_intro = spr_toppinshroom_intro  
spr_idle = spr_toppinshroom  
spr_run = spr_toppinshroom_run  
spr_panic = spr_toppinshroom_panic  
spr_taunt = spr_toppinshroom_taunt  
spr_intro_strongcold = spr_xmasshroomtoppin_intro  
spr_idle_strongcold = spr_xmasshroomtoppin_idle  
spr_run_strongcold = spr_xmasshroomtoppin_walk
~~~