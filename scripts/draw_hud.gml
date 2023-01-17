// prevents draw_hud from running a frame too early and spitting an error
if "phone" not in self exit;


//debug utility
//draw_debug_text( 200, 10, "state : " + get_state_name(state));
//draw_debug_text( 200, 25, "state timer : " + string(state_timer));
//draw_debug_text( 200, 40, "attack : " + string(attack));
//draw_debug_text( 200, 55, "window : " + string(window));
//draw_debug_text( 200, 70, "window timer : " + string(window_timer));
//draw_debug_text(  15, 10, "hsp: " + string(hsp));
//draw_debug_text(  15, 25, "vsp: " + string(vsp));
//draw_debug_text(  15, 40, "img ind: " + string(image_index));
//draw_debug_text(  15, 55, "spr_dir: " + string(spr_dir));
//draw_debug_text(  15, 70, "x: " + string(x));
//draw_debug_text(  15, 85, "y: " + string(y));
//draw_debug_text(  15, 100, "free: " + string(free));
//draw_debug_text(  15, 115, "attack pressed : " + string(attack_pressed));
//draw_debug_text(  15, 130, "attack down : " + string(attack_down));
//draw_debug_text(  15, 145, "joy_dir : " + string(joy_dir));
//draw_debug_text( 600, 10, "FPS : " + string(fps_real));
//*/


// MunoPhone Touch code - don't touch
// should be at BOTTOM of file, but above any #define lines
muno_event_type = 5;
user_event(14);