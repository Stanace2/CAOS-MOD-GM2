Assigns the toppin goal for the caos challenge
Used in:
- [[obj_exitgate#Create]]
## scr_ktoppingoal()

~~~js
function scr_settoppingoal() //gml_Script_scr_settoppingoal  
{  
    if (global.caoschase && global.ktoppins && global.ktoppingoal == 0)  
    {  
        switch room  
        {  
            case entrance_1:  
                global.ktoppingoal = 5  
                break  
            case medieval_1:  
                global.ktoppingoal = 5  
                break  
            case ruin_1:  
                global.ktoppingoal = 4  
                break  
            case dungeon_1:  
                global.ktoppingoal = 5  
                break  
            case badland_1:  
                global.ktoppingoal = 3  
                break  
            case graveyard_1:  
                global.ktoppingoal = 4  
                break  
            case farm_2:  
                global.ktoppingoal = 4  
                break  
            case saloon_1:  
                global.ktoppingoal = 5  
                break  
            case plage_entrance:  
                global.ktoppingoal = 4  
                break  
            case forest_1:  
                global.ktoppingoal = 4  
                break  
            case minigolf_1:  
                global.ktoppingoal = 4  
                break  
            case space_1:  
                global.ktoppingoal = 5  
                break  
            case street_intro:  
                global.ktoppingoal = 5  
                break  
            case industrial_1:  
                global.ktoppingoal = 4  
                break  
            case sewer_1:  
                global.ktoppingoal = 3  
                break  
            case freezer_1:  
                global.ktoppingoal = 5  
                break  
            case chateau_1:  
                global.ktoppingoal = 4  
                break  
            case kidsparty_1:  
                global.ktoppingoal = 4  
                break  
            case war_1:  
                global.ktoppingoal = 5  
                break  
        }  
  
    }  
}
~~~