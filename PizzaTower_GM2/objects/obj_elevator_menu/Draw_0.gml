draw_set_halign( fa_center );
draw_set_valign( fa_middle );

if ( menu_state == "menu" )
{
    for ( var i = 0; i < array_length( floors ); i++ )
    {
        draw_set_color( ( i == selected_index ) ? c_yellow : c_white );
        draw_text_transformed(x, y - 120 + ( i * 70 ), floors[i].name, 1, 1, 0);
    }
}
else if (menu_state == "shaking")
{
    var sx = choose( -6, -3, 0, 3, 6 );
    var sy = choose( -6, -3, 0, 3, 6 );
    draw_set_color( c_white );
    draw_text_transformed( x + sx, y + sy, "MOVING...", 1, 1, 0 );
}

draw_set_halign( fa_left );
draw_set_valign( fa_top );
draw_set_color( c_white );