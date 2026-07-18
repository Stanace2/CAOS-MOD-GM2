Places where default game scripts are modified in other to suppor mutiple movesets without breaking or creating anything
==ALL OF THESE CONTROLLERS HAVE TO BE ADDED AT THE START OF EVERY FUNCTION==
## scr_player_tumble()

~~~js
scr_player_tumble() 
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 0:  
            case 10:  
                if dos  
                {  
                    scr_dos_tumble()  
                    return;  
                }  
                break  
            case 1:  
                scr_wmp_tumble()  
                return;  
        }  
  
    }
}
~~~
## scr_player_slap()

~~~js
function scr_player_slap() //gml_Script_scr_player_slap  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_attackprep()  
                return;  
        }  
  
    }
}
~~~
## scr_player_climbwall()

~~~js
function scr_player_climbwall() //gml_Script_scr_player_climbwall  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 0:  
                if dos  
                {  
                    scr_dos_climbwall()  
                    return;  
                }  
                break  
            case 1:  
                scr_wmp_cling()  
                return;  
            case 10:  
                scr_fdos_climbwall()  
                return;  
        }  
  
    }
}
~~~
## scr_player_Sjump()

~~~js
function scr_player_Sjump() //gml_Script_scr_player_Sjump  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_Sjump()  
                return;  
        }  
  
    }
}
~~~
## scr_player_freefall()

~~~js
function scr_player_freefall() //gml_Script_scr_player_freefall  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 0:  
            case 10:  
                if dos  
                {  
                    scr_dos_freefall()  
                    return;  
                }  
                break  
            case 1:  
                scr_wmp_freefall()  
                return;  
        }  
  
    }
}
~~~
## scr_player_freefallland()

~~~js
function scr_player_freefallland() //gml_Script_scr_player_freefallland  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 0:  
            case 10:  
                if dos  
                {  
                    scr_dos_freefallland()  
                    return;  
                }  
                break  
            case 1:  
                scr_wmp_freefallland()  
                return;  
        }  
  
    }
}
~~~
## scr_player_machslide()

~~~js
function scr_player_machslide() //gml_Script_scr_player_machslide  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_skid()  
                return;  
        }  
  
    }
}
~~~
## scr_player_mach3()

~~~js
function scr_player_mach3() //gml_Script_scr_player_mach3  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 0:  
                if dos  
                {  
                    scr_dos_mach3()  
                    return;  
                }  
                break  
            case 1:  
                scr_wmp_mach3()  
                return;  
            case 10:  
                scr_fdos_mach3()  
                return;  
        }  
  
    }
}
~~~
## scr_player_mach2()

~~~js
function scr_player_mach2() //gml_Script_scr_player_mach2  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_mach2()  
                return;  
        }  
  
    }
}
~~~
## scr_player_crouch()

~~~js
function scr_player_crouch() //gml_Script_scr_player_crouch  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_crouch()  
                return;  
        }  
  
    }
}
~~~
## scr_player_jump()

~~~js
function state_player_jump() //gml_Script_state_player_jump  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_jump()  
                return;  
        }  
  
    }
}
~~~
## scr_player_normal()
==Should add Donisha case==
~~~js
function state_player_normal() //gml_Script_state_player_normal  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_normal()  
                return;  
        }  
        
    }
}
~~~
## scr_player_boots()

~~~js
function scr_player_boots() //gml_Script_scr_player_boots  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_megadash()  
                return;  
        }  
  
    }
}
~~~
## scr_player_dynamite()

~~~js
function scr_player_dynamite() //gml_Script_scr_player_dynamite  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_katana()  
                return;  
        }  
  
    }
}
~~~
## scr_player_punch()

~~~js
function scr_player_punch() //gml_Script_scr_player_punch  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 1:  
                scr_wmp_jaws()  
                return;  
        }  
  
    }
}
~~~
## scr_playerN_machcancel()

~~~js
function scr_playerN_machcancel() //gml_Script_scr_playerN_machcancel  
{  
    if ispeppino  
    {  
        switch characterID  
        {  
            case 0:  
                if (dos && (!scr_doniSnapjump()))  
                    return;  
                break  
            case 10:  
                if (!scr_doniFakeSnapjump())  
                    return;  
                break  
        }  
  
    }
}
~~~
## scr_player_ratmountbounce()
Wetham mango controller for Ballmode
~~~js
if (characterID == 1)  
{  
	scr_wmp_ballmode()  
	return;  
}
~~~