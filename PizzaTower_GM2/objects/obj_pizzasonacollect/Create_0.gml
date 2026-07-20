idlespr = spr_pizzasona1;
throwspr = spr_pizzasona1throw;
transitionspr = spr_pizzasona1trans;
collectID = noone;
onebyoneID = noone;
index = 0;
showtext = false;
state = states.normal;
image_speed = 0.35;
depth = 0;
var r = -1;
var alt = "";  
while 1  
{  
    r = irandom_range(1, 55)  
    if (r == 8)  
        continue  
    else if (r == 1 || r == 2 || r == 3 || r == 19 || r == 21 || r == 33 || r == 41 || r == 39 || r == 55 || r == 34 || r == 13 || r == 45 || r == 28 || r == 5 || r == 9 || r == 20 || r == 38 || r == 51)  
        break  
    else  
        continue  
}  
//if (r == 51)  
//    alt = concat("_", irandom_range(1, 4))  
idlespr = asset_get_index(concat("spr_pizzasona", r, alt));
throwspr = asset_get_index(concat("spr_pizzasona", r, "throw"));
transitionspr = asset_get_index(concat("spr_pizzasona", r, "trans"));
