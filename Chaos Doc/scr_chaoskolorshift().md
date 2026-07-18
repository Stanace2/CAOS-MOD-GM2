Color shifting when using powerups
Executed in:
- [[obj_player#EndStep]]
~~~js
function scr_chaoskolorshift() //gml_Script_scr_chaoskolorshift  
{  
    if instance_exists(obj_chaosangel)  
    {  
        if (kolorindex == -1)  
        {  
            for (var i = 0; i < array_length(global.khaosactives); i++)  
            {  
                if (global.khaosactives[i] == 1 && kolorindex == -1)  
                {  
                    kolorindex = i  
                    kolortimer = 0  
                    kolorhexr = 255  
                    kolorhexg = 255  
                    kolorhexb = 255  
                }  
            }  
        }  
        else  
        {  
            var _hex = 4  
            var _rgb = 0.02  
            kolorhexr = Approach(kolorhexr, floor(chaoskolors[1][kolorindex][0] * 255), _hex)  
            kolorhexg = Approach(kolorhexg, floor(chaoskolors[1][kolorindex][1] * 255), _hex)  
            kolorhexb = Approach(kolorhexb, floor(chaoskolors[1][kolorindex][2] * 255), _hex)  
            global.khaoshex = make_colour_rgb(kolorhexr, kolorhexg, kolorhexb)  
            global.khaosr = Approach(global.khaosr, chaoskolors[1][kolorindex][0], _rgb)  
            global.khaosg = Approach(global.khaosg, chaoskolors[1][kolorindex][1], _rgb)  
            global.khaosb = Approach(global.khaosb, chaoskolors[1][kolorindex][2], _rgb)  
            if (kolortimer > 0)  
                kolortimer--  
            if (kolortimer < 1 && instance_number(obj_chaosangel) > 1)  
            {  
                kolortimer = 45  
                currentkolors = []  
                for (i = 0; i < array_length(global.khaosactives); i++)  
                {  
                    if (global.khaosactives[i] == 1)  
                        array_push(currentkolors, i)  
                }  
                currentkolorindex++  
                if (currentkolorindex > (array_length(currentkolors) - 1))  
                    currentkolorindex = 0  
                kolorindex = currentkolors[currentkolorindex]  
            }  
        }  
    }  
}
~~~