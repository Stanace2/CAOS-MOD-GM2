## draw_player()
Heavily modified function for drawing the player
Related:
- Glowpalette | [[GP - Related drawing methods#scr_drawcontroller]]
~~~js
function draw_player() //gml_Script_draw_player  
{  
    if instance_exists(obj_swapgusfightball)  
    {  
        var _use_dark = other.use_dark  
        with (obj_swapgusfightball)  
        {  
            b = get_dark(image_blend, _use_dark)  
            var _info = [[sprite_index, get_pep_palette_info()], [1753, get_noise_palette_info()]]  
            for (i = 0; i < array_length(_info); i++)  
            {  
                var sprite = _info[i][0]  
                var pal = _info[i][1]  
                pattern_set(global.Base_Pattern_Color, sprite, image_index, image_xscale, image_yscale, pal.patterntexture)  
                pal_swap_set(pal.spr_palette, pal.paletteselect, 0)  
                draw_sprite_ext(sprite, image_index, x, y, image_xscale, image_yscale, image_angle, b, image_alpha)  
            }  
            pattern_reset()  
        }  
        return;  
    }  
    if ((!ispeppino) && state == (209 << 0))  
        return;  
    b = get_dark(image_blend, other.use_dark)  
    var pattern = global.palettetexture  
    var ps = paletteselect  
    var spr = spr_palette  
    var _sprite_index = sprite_index  
    var _image_index = image_index  
    if (pistolanim != -4)  
    {  
        _sprite_index = pistolanim  
        _image_index = pistolindex  
    }  
    if (ispeppino && room == boss_noise && (sprite_index == spr_playerN_doiseintro1 || sprite_index == spr_playerN_doiseintro2 || sprite_index == spr_playerN_doiseintro3))  
    {  
        var info = get_noise_palette_info()  
        pattern = info.patterntexture  
        ps = info.paletteselect  
        spr = info.spr_palette  
    }  
    if isgustavo  
        spr = spr_ratmountpalette  
    if ((!ispeppino) && instance_exists(obj_pizzaface_thunderdark))  
        spr = spr_noisepalette_rage  
    // CHAOS POWERUP OUTLINE
    if instance_exists(obj_chaosangel)  
    {  
        shader_set(shd_color_afterimage)  
        shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), global.khaosr)  
        shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), global.khaosg)  
        shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), global.khaosb)  
        draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs * 1.1), (yscale * scale_ys * 1.1), angle, c_white, image_alpha)  
        shader_reset()  
    }  
    // WETHAM DODGE OUTLINE
    if (iwalpha > 0)  
        scr_outline_sprite(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, iwalpha, 0, 242, 255)  
    // MANGO PATTERNS
    if scr_checkMT(ps)  
    {  
        var mangoPattern = scr_searchMT(ps)  
        shader_set(global.Pal_Shader)  
        pattern_set([9, 10], _sprite_index, _image_index, (xscale * scale_xs), (yscale * scale_ys), mangoPattern)  
        pal_swap_set(spr, ps, 0)  
        draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, b, image_alpha)  
        shader_reset()  
        pattern_reset()  
    }  
    // DRAWING THE PLAYER
    shader_set(global.Pal_Shader)  
    if (object_index == obj_player1)  
        pattern_set(global.Base_Pattern_Color, _sprite_index, _image_index, (xscale * scale_xs), (yscale * scale_ys), pattern)  
    pal_swap_set(spr, ps, 0)  
    draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, b, image_alpha)  
    shader_reset()  
    pattern_reset()  
    // PIZZA PEPPER (HAS TO BE FIXED)
    if (global.noisejetpack && (ispeppino || noisepizzapepper))  
    {  
        pal_swap_set(spr_palette, 2, 0)  
        draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, b, image_alpha)  
    }  
    // GLOW PALETTE
    if ((object_index == obj_player1 || object_index == obj_player2) && (obj_player1.sprite_index == spr_player_walkfront || other.use_dark) && false)  
    {  
        shader_set(global.Pal_Shader)  
        pal_swap_set(spr_glowpalette, ps, 0)  
        draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, c_white, image_alpha)  
        shader_reset()  
    }  
    // POWER UP VISUALIZER
    if instance_exists(obj_chaosangel)  
    {  
        shader_set(global.Pal_Shader)  
        pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
        pal_swap_set(spr_blankpalette, 1, 0)  
        draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, global.khaoshex, image_alpha)  
        shader_reset()  
        pattern_reset()  
    }  
    // IFRAME VISUALIZER
    if (ikalpha > 0)  
    {  
        shader_set(global.Pal_Shader)  
        pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
        pal_swap_set(spr_ifpalette, (chaoscolor + 1), 0)  
        draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, c_white, ikalpha)  
        shader_reset()  
        pattern_reset()  
    }  
    draw_superslam_enemy()  
    if global.pistol  
    {  
        pal_swap_set(spr_peppalette, 0, 0)  
        if (pistolcharge >= 4)  
            draw_sprite(spr_revolvercharge, pistolcharge, x, (y - 70))  
    }  
}
~~~


