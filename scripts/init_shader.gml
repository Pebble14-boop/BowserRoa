var alt_cur = "alt_fix" in self ? get_player_color(alt_fix) : get_player_color(player);

if(alt_cur == 0){
	set_character_color_slot (7,236, 207, 101);

}


//sorry metal sonic creator I kinda copy pasted your method please forgive me
if (object_index == asset_get("draw_result_screen"))
{
	set_victory_portrait(sprite_get("portrait"));
}



if(alt_cur == 15){
set_victory_portrait(sprite_get("_dry_portrait"));
}


if(alt_cur == 18){
if(get_color_profile_slot_r(18, 0) == 0 && get_color_profile_slot_g(18, 0) == 255 && get_color_profile_slot_b(18, 0) < 255){
    set_color_profile_slot( 18, 0, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
    set_color_profile_slot( 18, 1, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
    set_color_profile_slot( 18, 2, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
    set_color_profile_slot( 18, 3, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
    set_color_profile_slot( 18, 4, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
    set_color_profile_slot( 18, 5, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
    set_color_profile_slot( 18, 6, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
    set_color_profile_slot( 18, 7, 0, 255, get_color_profile_slot_b(18, 0) + 5 );
}else if(get_color_profile_slot_r(18, 0) == 0 && get_color_profile_slot_g(18, 0) > 0 && get_color_profile_slot_b(18, 0) == 255){
    set_color_profile_slot( 18, 0, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
    set_color_profile_slot( 18, 1, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
    set_color_profile_slot( 18, 2, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
    set_color_profile_slot( 18, 3, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
    set_color_profile_slot( 18, 4, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
    set_color_profile_slot( 18, 5, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
    set_color_profile_slot( 18, 6, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
    set_color_profile_slot( 18, 7, 0, get_color_profile_slot_g(18, 0) - 5, 255 );
}else if(get_color_profile_slot_r(18,0) < 255 && get_color_profile_slot_g(18, 0) == 0 && get_color_profile_slot_b(18, 0) == 255){
    set_color_profile_slot( 18, 0, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
    set_color_profile_slot( 18, 1, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
    set_color_profile_slot( 18, 2, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
    set_color_profile_slot( 18, 3, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
    set_color_profile_slot( 18, 4, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
    set_color_profile_slot( 18, 5, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
    set_color_profile_slot( 18, 6, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
    set_color_profile_slot( 18, 7, get_color_profile_slot_r(18, 0) + 5, 0, 255 );
}else if(get_color_profile_slot_r(18,0) == 255 && get_color_profile_slot_g(18, 0) == 0 && get_color_profile_slot_b(18, 0) > 0){
    set_color_profile_slot( 18, 0, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
    set_color_profile_slot( 18, 1, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
    set_color_profile_slot( 18, 2, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
    set_color_profile_slot( 18, 3, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
    set_color_profile_slot( 18, 4, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
    set_color_profile_slot( 18, 5, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
    set_color_profile_slot( 18, 6, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
    set_color_profile_slot( 18, 7, 255, 0, get_color_profile_slot_b(18, 0) - 5 );
}else if(get_color_profile_slot_r(18,0) == 255 && get_color_profile_slot_g(18, 0) < 255 && get_color_profile_slot_b(18, 0) == 0){
    set_color_profile_slot( 18, 0, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
    set_color_profile_slot( 18, 1, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
    set_color_profile_slot( 18, 2, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
    set_color_profile_slot( 18, 3, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
    set_color_profile_slot( 18, 4, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
    set_color_profile_slot( 18, 5, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
    set_color_profile_slot( 18, 6, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
    set_color_profile_slot( 18, 7, 255, get_color_profile_slot_g(18, 0) + 5, 0 );
}else if(get_color_profile_slot_r(18,0) > 0 && get_color_profile_slot_g(18, 0) == 255 && get_color_profile_slot_b(18, 0) == 0){
    set_color_profile_slot( 18, 0, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
    set_color_profile_slot( 18, 1, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
    set_color_profile_slot( 18, 2, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
    set_color_profile_slot( 18, 3, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
    set_color_profile_slot( 18, 4, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
    set_color_profile_slot( 18, 5, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
    set_color_profile_slot( 18, 6, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
    set_color_profile_slot( 18, 7, get_color_profile_slot_r(18, 0) - 5, 255, 0 );
}


}