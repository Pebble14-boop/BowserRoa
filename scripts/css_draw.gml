if(alt_cur == 18){
    init_shader();
}

if(alt_cur == 15){
	draw_sprite_ext(sprite_get("dry_charselect"),0,x+8,y+8,2,2,0,-1,1)
	shader_end()}



//css names
var temp_x = x;
var temp_y = y;

alt_name = [
'Koopa King',
'Brick Block',
'Underground',
'Rolling in Coins',
'SSBU/4 Brown',
'SSBU/4 Yellow',
'SSBU/4 Red',
'SSBU/4 Blue',
'SSBU/4 Gray',
'Melee/Brawl Red',
'Melee/Brawl Blue',
'Melee/Brawl Black',
'Classic',
'Giga Bowser',
'Dark Bowser',
'Dry Bowser',
'64',
'Midbus',
'Ultimate Koopa',
'Fury Bowser',
'"Dark"Bowser',
'Sol Badguy',
'Justice',
'Godzilla',
"Im the coolest",
'Iron Tager',
'Susanoo',
'Broly',
'Bowletta',
'Kragg',
'VAE'
];

if(alt_cur != prev_alt){
    anim_timer = 0;
    alpha_alt = 6;
}
if alpha_alt > 0 {
    alpha_alt -= 0.05;
    anim_timer++;
}
prev_alt = alt_cur;

draw_sprite_part_ext(sprite_get((alt_cur == 15? "dry_": "") + "idle"), anim_timer*0.12, 38, 0, 98, 110, temp_x + 8, temp_y + 50, 1, 1, c_white, alpha_alt);
draw_set_halign(fa_left);
shader_end();
var col = [get_color_profile_slot_r(alt_cur, 0), get_color_profile_slot_g(alt_cur, 0), get_color_profile_slot_b(alt_cur, 0)];
textDraw(temp_x + 70, temp_y + 139, "fName", make_color_rgb(col[0], col[1], col[2]), 14, 400, 1, 1, alpha_alt, alt_name[alt_cur], ((col[0]+col[1]+col[2])/3 < 100? c_white: c_black));


#define textDraw(x, y, font, color, lineb, linew, scale, outline, alpha, string, outline_c)

draw_set_font(asset_get(argument[2]));

if argument[7]{ //outline. doesn't work lol //now it does, you're welcome
    draw_text_ext_transformed_color(argument[0] + argument[6]*2, argument[1], argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
    draw_text_ext_transformed_color(argument[0] + argument[6]*2, argument[1] + argument[6]*2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
    draw_text_ext_transformed_color(argument[0] + argument[6]*2, argument[1] - argument[6]*2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
    draw_text_ext_transformed_color(argument[0], argument[1] - argument[6]*2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
    draw_text_ext_transformed_color(argument[0] - argument[6]*2, argument[1] - argument[6]*2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
    draw_text_ext_transformed_color(argument[0] - argument[6]*2, argument[1], argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
    draw_text_ext_transformed_color(argument[0] - argument[6]*2, argument[1] + argument[6]*2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
    draw_text_ext_transformed_color(argument[0], argument[1] +  argument[6]*2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[10], argument[10], argument[10],argument[10], argument[8]);
}
draw_text_ext_transformed_color(argument[0], argument[1], argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[3], argument[3], argument[3], argument[3], argument[8]);