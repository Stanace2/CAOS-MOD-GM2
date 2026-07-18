Changes done directly to previous code
## scr_player_Sjump()

~~~js
// Change the superjump acceleration
    if (sjumpvsp <= -4)
    {
        if (ispeppino && dos)
            sjumpvsp -= 0.3
        else
            sjumpvsp -= 0.1
    }
~~~
## scr_player_machslide()

~~~js
// Added below the state controller, so Donisha can do Snapjumps whilesliding
    if (sprite_index == spr_mach3boost || sprite_index == spr_machslideboost)
        doSnapjump()
~~~
## scr_player_crouch()

~~~js
// Added at the end, Donisha Shenanigans
    doSnapjump()
~~~
## scr_player_jump()
### state_player_jump()

~~~js
// Added at the end
doSnapjump()
~~~
## scr_player_normal()
### state_player_normal()
==At this point its easier to make a scr_normal for Donisha==
~~~js
// Changes to Donisha idle sprite
var idlespr = spr_idle
var movespr = spr_move
if (global.leveltosave == "freezer" && (!global.noisejetpack))        
	idlespr = spr_player_freezeridle
// H e r e
if ((global.leveltosave == "kidsparty" || instance_exists(obj_fakepepboss) || instance_exists(obj_pizzafaceboss_p2)) && (!global.noisejetpack))
    idlespr = spr_donisha_scared
// Venganse look at Noise
if (distance_to_object(obj_noisevengeful) < 250)
{
    xscale = 1
    idlespr = spr_player_judge
}
// Changed the idle sprite manager, to add the snapnailit
if ((!machslideAnim) && (!landAnim) && (!shotgunAnim))
{
    if (idle < 400 && breakdance_pressed < breakdance_max)
        idle++
    if (idle >= 150 && (!global.panic) && global.combo < 25 && breakdance_pressed < breakdance_max)
    {
        if (sprite_index != idlespr && floor(image_index) == (image_number - 1))
        {
            facehurt = 0
            idle = 0
        }
        // spr_player_snapnailit added here
        if (((!global.pistol) || (!ispeppino)) && sprite_index != spr_player_snapnailit && sprite_index != spr_player_judge && sprite_index != spr_player_freezeridle && sprite_index != spr_donisha_scared && (!shotgunAnim) && sprite_index != spr_idle1 && sprite_index != spr_idle2 && sprite_index != spr_idle3 && sprite_index != spr_idle4 && sprite_index != spr_idle5 && sprite_index != spr_idle6)
        {
            idleanim = random_range(0, 100)
            if (irandom(100) <= 25)
                fmod_event_one_shot_3d("event:/sfx/voice/myea", x, y)
            image_index = 0
            if (idleanim <= 16)
                sprite_index = spr_idle1
            else if (idleanim > 16 && idleanim <= 32)
                sprite_index = spr_idle2
            else if (idleanim > 32 && idleanim <= 48)
                sprite_index = spr_idle3
            else if (idleanim > 48 && idleanim <= 64)
                sprite_index = spr_idle4
            else if (idleanim > 64 && idleanim <= 80)
                sprite_index = spr_idle5
            else
                sprite_index = spr_idle6
        }
    }
    else if (!facehurt)
    {
        if (windingAnim < 1800 || angry || global.playerhealth == 1 || shoot)
        {
            start_running = 1
            movespeed = 0
            if (sprite_index == spr_player_snapnailit)
            {
            }
            else if shoot
                sprite_index = spr_player_pistolidle
            else if mort
                sprite_index = spr_player_mortidle
            else if (breakdance_pressed >= breakdance_max)
                sprite_index = spr_breakdance
            else if ((global.fill <= 0 && (!instance_exists(obj_ghostcollectibles))) || instance_exists(obj_kidspartybg))
                sprite_index = spr_hurtidle
            else if (global.panic && (!instance_exists(obj_ghostcollectibles)))
                sprite_index = spr_panic
            else if ((global.combo >= 25 && global.combo < 50) || (instance_exists(obj_pepperman) && (!instance_exists(obj_pizzaface_thunderdark))) || instance_exists(obj_pizzafaceboss) || (global.noisejetpack && (ispeppino || noisepizzapepper)))
                sprite_index = spr_3hpidle
            else if (global.combo >= 50 || (ispeppino && instance_exists(obj_pizzaface_thunderdark)))
                sprite_index = spr_rageidle
            else
                sprite_index = idlespr
        }
        else
        {
            idle = 0
            windingAnim--
            sprite_index = spr_winding
            if (breakdance_pressed >= breakdance_max)
                sprite_index = spr_breakdance
        }
    }
    else
    {
        windingAnim = 0
        sprite_index = spr_facehurt
        if (breakdance_pressed >= breakdance_max)
            sprite_index = spr_breakdance
    }
}
// In the end animation section, snapnailit added
if (floor(image_index) == (image_number - 1))
{
    switch sprite_index
    {
	    // H e r e
        case spr_player_snapnailit:
            image_index = 0
            sprite_index = idlespr
            if shotgunAnim
                sprite_index = spr_shotgunidle
            break
        case spr_machslideend:
            machslideAnim = 0
            sprite_index = idlespr
            if shotgunAnim
                sprite_index = spr_shotgunidle
            break
        case 3368:
            sprite_index = idlespr
            break
        case spr_shotgunshoot:
            sprite_index = spr_shotgunidle
            break
        case spr_pistolshot:
            sprite_index = idlespr
            break
    }
}
// Added at the end
doSnapjump()
~~~
## scr_player_handstandjump()
#states
~~~js
// Added at the start of the function
// Chaos
if flamedash
{
    scr_doni_flamedash()
    return;
}
// Fightmode
if (fightmode && dos && (!instance_exists(obj_pizzaface_thunderdark)))
{
    if (!grounded)
    {
        state = (80 << 0)
        flash = 1
        fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)
        sprite_index = choose(spr_player_kungfuair1, spr_player_kungfuair2, spr_player_kungfuair3)
		image_index = 0  
		movespeed = 13  
	}  
	else  
	{  
		state = (80 << 0)  
		flash = 1  
		fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
		sprite_index = choose(spr_player_kungfu1, spr_player_kungfu2, spr_player_kungfu3)
        image_index = 0
        movespeed = 13
    }
    return;
}
else
{
    if (shoot == 1)
        var attackdash = spr_player_pistolshot
    else
        attackdash = spr_suplexdash
    var airattackdash = spr_suplexdashjump
    var airattackdashstart = spr_suplexdashjumpstart
}
// Changed the grab acceleration
if (global.attackstyle != 3)
{
    if (movespeed < 10)
    {
        if ((sprite_index == spr_player_pistolshot || sprite_index == spr_shotgun_shot) && movespeed < 8)
            movespeed += 0.25
        else if (sprite_index == spr_player_lunge && movespeed < 12)
            movespeed += 0.8
        else if (movespeed < 10)
        {
	        // H e r e
            if ((!dos) || global.noisejetpack || instance_exists(obj_pizzaface_thunderdark))
                movespeed += 0.5
            else
                movespeed += 0.1
        }
    }
}
else
{
    if (movespeed < 10)
    {
        if ((sprite_index == spr_player_pistolshot || sprite_index == spr_shotgun_shot) && movespeed < 8)
            movespeed += 0.25
        else if (movespeed < 10)
        {
	        // H e r e
            if (global.noisejetpack || (ispeppino && (!dos)) || (!ispeppino) || instance_exists(obj_pizzaface_thunderdark))
                movespeed += 0.5
        }
    }
    if (global.pummeltest && (!instance_exists(lungeattackID)))
    {
        with (instance_create(x, y, obj_lungehitbox))
        {
            playerid = other.id
            other.lungeattackID = id
        }
    }
}
// Right on top of the revived crouchslip
doSnapjump()
~~~
## scr_player_mach2

~~~js
// Donisha has a slower acceleration in mach2
var accel = 0.1
if (dos && ispeppino && (!global.noisejetpack))
    accel = 0.05
// Right below taunt function
doSnapjump()
~~~
## scr_player_ladder

~~~js
// Added at the end
doSnapjump()
~~~