function scr_climboutchecker(start_point, x_ini, y_ini) 
{  
    while (!(scr_solid((x + xscale), y)))  
    {  
        if (wallspeed >= 0)  
        {  
            start_point++  
            y++  
            if scr_solid((x + xscale), y)  
            {  
                y--  
                break  
            }  
            else if (start_point > 40)  
            {  
                x = x_ini  
                y = y_ini  
                break  
            }  
            else  
                continue  
        }  
        else  
        {  
            start_point++  
            y--  
            if scr_solid((x + xscale), y)  
            {  
                y += 10  
                break  
            }  
            else if (start_point > 40)  
            {  
                x = x_ini  
                y = y_ini  
                break  
            }  
            else  
                continue  
        }  
    }  
}