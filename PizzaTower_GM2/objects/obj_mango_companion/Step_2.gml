// Playerfollower shenanigans
if (lock || (followid != noone && (!instance_exists(obj_player1))) || state != mstates.follower)  
{  
}  
else  
{  
    interp = Approach(interp, relinterp, 0.05)  
    playerid = obj_player1.id  
    if (playerid.state != states.ladder && playerid.state != states.door && playerid.state != states.comingoutdoor)  
    {  
        if (space < maxspace && dir == -1)  
            space += spaceaccel  
        if (space > (-maxspace) && dir == 1)  
            space -= spaceaccel  
    }  
    else  
        space = Approach(space, 0, spaceaccel)  
    if (dir != playerid.xscale)  
        dir = playerid.xscale  
    if (followid == noone && object_index != obj_swapmodefollow && instance_exists(obj_swapmodefollow))  
        followid = obj_swapmodefollow.id  
    if (followid != noone && (!instance_exists(followid)))  
        followid = noone  
    var tx = round(xoffset * space)  
    var xx = (followid == noone ? playerid.x : followid.x)  
    var yy = (followid == noone ? playerid.y : followid.y)  
    var msk = (followid == noone ? playerid.mask_index : followid.mask_index)  
    var ixs = (followid == noone ? playerid.xscale : followid.image_xscale)  
    var ss = playerid.state  
    ds_queue_enqueue(followqueue, (xx + tx))  
    ds_queue_enqueue(followqueue, (yy + yoffset))  
    ds_queue_enqueue(followqueue, msk)  
    ds_queue_enqueue(followqueue, ixs)  
    ds_queue_enqueue(followqueue, ss)  
    if (ds_queue_size(followqueue) > (LAG_STEPS * 2))  
    {  
        var _x = ds_queue_dequeue(followqueue)  
        var _y = ds_queue_dequeue(followqueue)  
        if (!use_collision)  
        {  
            if (!comeback)  
            {  
                if (interp < 1)  
                {  
                    x = lerp(x, _x, interp)  
                    y = lerp(y, _y, interp)  
                }  
                else  
                {  
                    x = _x  
                    y = _y  
                }  
            }  
        }  
        mask_index = ds_queue_dequeue(followqueue)  
        image_xscale = ds_queue_dequeue(followqueue)  
        relativestate = ds_queue_dequeue(followqueue)  
        lastplayerposx = _x  
        lastplayerposy = _y  
    }  
    image_xscale = playerid.xscale * playerid.scale_xs  
    image_yscale = playerid.yscale * playerid.scale_ys  
    following_moonwalk_fix()  
}  
// Grounded and flash manager
var off = 0  
if place_meeting(x, (y + 1), obj_solid)  
    off = 1  
if place_meeting(x, y, obj_solid)  
    off = 0  
if place_meeting(x, (y + 1), obj_slope)  
    off = 1  
if place_meeting(x, (y + 1), obj_platform)  
    off = 1  
grounded = off  
moving = x != xprev  
if (abs(x - xprev) <= 2 || abs(x + xprev) <= 2)  
    moving = 0  
else  
    moving = x != xprev  
xprev = x  
if (flash && alarm[1] == -1)  
    alarm[1] = 10