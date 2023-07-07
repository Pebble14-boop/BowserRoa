//B - Reversals
switch(attack){
	case AT_FSPECIAL:
	case AT_DSPECIAL:
	case AT_USPECIAL:
	case AT_NSPECIAL:
		trigger_b_reverse();
		break;
}


		if attack =AT_TAUNT && (down_down) {
			set_attack(AT_TAUNT_2);
		}

		if attack =AT_TAUNT && (up_down) {
			set_attack(AT_EXTRA_1);
		}
		
		


// per-attack logic

switch(attack){
	
	case AT_USPECIAL:
    can_wall_jump = true;
if (window == 1){
    vsp = vsp/1.2;
}
break;
	case AT_USPECIAL_2:

if (!free){
    can_move = false;
    set_window_value(AT_USPECIAL_2, 2, AG_WINDOW_VSPEED_TYPE, 0);
    set_window_value(AT_USPECIAL_2, 2, AG_WINDOW_VSPEED, 0);
    set_window_value(AT_USPECIAL_2, 3, AG_WINDOW_VSPEED_TYPE, 0);
    set_window_value(AT_USPECIAL_2, 3, AG_WINDOW_VSPEED, 0);
    set_window_value(AT_USPECIAL_2, 4, AG_WINDOW_TYPE, 1);
    hsp = clamp(hsp, -5, 5);
    if (window > 1 && window < 4){
        if (left_down)
            hsp -= 1;
        if (right_down)
            hsp += 1;
    }
}
else{
    set_window_value(AT_USPECIAL_2, 2, AG_WINDOW_VSPEED_TYPE, 1);
    set_window_value(AT_USPECIAL_2, 2, AG_WINDOW_VSPEED, -5);
    set_window_value(AT_USPECIAL_2, 3, AG_WINDOW_VSPEED_TYPE, 1);
    set_window_value(AT_USPECIAL_2, 3, AG_WINDOW_VSPEED, -5);
    set_window_value(AT_USPECIAL_2, 4, AG_WINDOW_TYPE, 7);
}

break;
	

	case AT_EXTRA_1:
if (window == 2){
	can_jump = true;
    can_move = true;
}

	case AT_TAUNT_2:
if (window == 2){
	can_jump = true;
    can_move = true;
}
break;

	case AT_TAUNT:
if (window == 2){
	can_jump = true;
    can_move = true;
}
break;
	
		case AT_TAUNT:

		if  (window = 2 && window_timer = 12 && !hitpause){
			shake_camera (6,6)
		}

		break;

	case AT_FSPECIAL: {
		can_move = false;
		move_cooldown[AT_FSPECIAL] = 9999;
		can_wall_jump = true;
		}
		if window == 2 && has_hit = true {
		window = 4 
		}
    	break;
	
		break;
		
	case AT_DATTACK:
	if (window == 2 && window_timer = 3 && has_hit = true){
	destroy_hitboxes();
	}
	break;

	case AT_DSPECIAL: {
if (free){
		can_move = false
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_HSPEED, 1);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_HSPEED_TYPE, 2);

set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HSPEED, 1);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HSPEED_TYPE, 2);
	


}
}
if (!free){
	set_window_value(AT_DSPECIAL, 1, AG_WINDOW_HSPEED, 1);
    set_window_value(AT_DSPECIAL, 1, AG_WINDOW_HSPEED_TYPE, 2);
	
	set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HSPEED, 1);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HSPEED_TYPE, 0);

}
break;

	case AT_DSPECIAL_2: {
if (free){
	can_move = false
set_window_value(AT_DSPECIAL_2, 1, AG_WINDOW_HSPEED, 1);
set_window_value(AT_DSPECIAL_2, 1, AG_WINDOW_HSPEED_TYPE, 2);

set_window_value(AT_DSPECIAL_2, 2, AG_WINDOW_VSPEED, 1);
set_window_value(AT_DSPECIAL_2, 2, AG_WINDOW_VSPEED_TYPE, 2);
	


}
}
if (!free){
	set_window_value(AT_DSPECIAL_2, 1, AG_WINDOW_HSPEED, 1);
    set_window_value(AT_DSPECIAL_2, 1, AG_WINDOW_HSPEED_TYPE, 2);
	
	set_window_value(AT_DSPECIAL_2, 2, AG_WINDOW_VSPEED, 1);
    set_window_value(AT_DSPECIAL_2, 2, AG_WINDOW_VSPEED_TYPE, 0);

}
break;

case AT_NSPECIAL:
if (window == 2){
	can_jump = true;
	fb_size = 1
	fire_charge++;
	if(window_timer >= 5 && !special_down) || fire_charge >= 20{
		window = 3;
		window_timer = 0;
		if(fire_charge >= 20){
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_TYPE, 2);
		set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW, 3);
		set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 8);
		set_hitbox_value(AT_NSPECIAL, 1, HG_LIFETIME, 45);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_X, 71);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_Y, -35);
		set_hitbox_value(AT_NSPECIAL, 1, HG_SHAPE, 0);
		set_hitbox_value(AT_NSPECIAL, 1, HG_WIDTH, 110);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HEIGHT, 50);
		set_hitbox_value(AT_NSPECIAL, 1, HG_PRIORITY, 1);
		set_hitbox_value(AT_NSPECIAL, 1, HG_DAMAGE, 10); 
		set_hitbox_value(AT_NSPECIAL, 1, HG_BASE_KNOCKBACK, 8);
		set_hitbox_value(AT_NSPECIAL, 1, HG_KNOCKBACK_SCALING, .75); 
		set_hitbox_value(AT_NSPECIAL, 1, HG_ANGLE, 60);
		set_hitbox_value(AT_NSPECIAL, 1, HG_BASE_HITPAUSE, 10);
		set_hitbox_value(AT_NSPECIAL, 1, HG_VISUAL_EFFECT_Y_OFFSET, -16);
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_SPRITE, sprite_get("nspecial_proj_big"));
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_MASK, -1);
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_ANIM_SPEED, .2);
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_HSPEED, 8.5);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITSTUN_MULTIPLIER, 0.5);
        set_hitbox_value(AT_NSPECIAL, 1, HG_VISUAL_EFFECT, 148);
        
		}else{
		fb_size = 0
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_TYPE, 2);
		set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW, 3);
		set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 8);
		set_hitbox_value(AT_NSPECIAL, 1, HG_LIFETIME, 35);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_X, 75);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_Y, -25);
		set_hitbox_value(AT_NSPECIAL, 1, HG_SHAPE, 0);
		set_hitbox_value(AT_NSPECIAL, 1, HG_WIDTH, 86);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HEIGHT, 34);
		set_hitbox_value(AT_NSPECIAL, 1, HG_PRIORITY, 10);
		set_hitbox_value(AT_NSPECIAL, 1, HG_DAMAGE, 7);
		set_hitbox_value(AT_NSPECIAL, 1, HG_BASE_KNOCKBACK, 6);
		set_hitbox_value(AT_NSPECIAL, 1, HG_KNOCKBACK_SCALING, .5);
		set_hitbox_value(AT_NSPECIAL, 1, HG_ANGLE, 90);
		set_hitbox_value(AT_NSPECIAL, 1, HG_BASE_HITPAUSE, 6);
		set_hitbox_value(AT_NSPECIAL, 1, HG_VISUAL_EFFECT_Y_OFFSET, -16);
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_SPRITE, sprite_get("nspecial_proj_small"));
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_MASK, -1);
		
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_ANIM_SPEED, .2);
		set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_HSPEED, 12);
		set_hitbox_value(AT_NSPECIAL, 1, HG_HITSTUN_MULTIPLIER, 0.5);
        set_hitbox_value(AT_NSPECIAL, 1, HG_VISUAL_EFFECT, 3);
		}
		
	}
}
break;
}




//Zard was here working on command grab shenanigans

//thank you zard

//Switch Grab Depending on direction

if attack == AT_DSPECIAL_2{
	if window == 1{
		if window_timer == 1{

			set_window_value(AT_DSPECIAL_2, 1, AG_WINDOW_GOTO, 2);
			set_attack_value(AT_DSPECIAL_2, AG_NUM_WINDOWS, 7);
		}

		if (spr_dir == 1 && left_down == true) || (spr_dir == -1 && right_down == true){
			set_window_value(AT_DSPECIAL_2, 1, AG_WINDOW_GOTO, 5);
		}
		
		else{

			set_window_value(AT_DSPECIAL_2, 1, AG_WINDOW_GOTO, 2);
		}
	}
	
	if window == 2{

		set_attack_value(AT_DSPECIAL_2, AG_NUM_WINDOWS, 4);
	}
	
	if window == 5{

		set_attack_value(AT_DSPECIAL_2, AG_NUM_WINDOWS, 7);
	}
	
}


//attack_update.gml
if (attack == AT_DSPECIAL) {
	//reset 'grabbed_player' variables on the first frame when performing a grab.
    if (window == 1 && window_timer == 1) { 
    	grabbed_player_obj = noone; 
    	grabbed_player_relative_x = 0;
    	grabbed_player_relative_y = 0;
    }
}

if (attack == AT_DSPECIAL_2 && instance_exists(grabbed_player_obj)) {
	
	//first, drop the grabbed player if this is the last window of the attack, or if they somehow escaped hitstun.
	if (window >= get_attack_value(attack, AG_NUM_WINDOWS)) { grabbed_player_obj = noone; }
	else if (grabbed_player_obj.state != PS_HITSTUN && grabbed_player_obj.state != PS_HITSTUN_LAND) { grabbed_player_obj = noone; }

	else {
		//keep the grabbed player in hitstop until the grab is complete.
		grabbed_player_obj.hitstop = 2;
		grabbed_player_obj.hitpause = true;
		
		//if this is the first frame of a window, store the grabbed player's relative position.
		if (window_timer <= 1) {
			grabbed_player_relative_x = grabbed_player_obj.x - x;
			grabbed_player_relative_y = grabbed_player_obj.y - y;
		}
		 
		//Neutral Grab
		if image_index == 4 || image_index == 5 { 
			grabbed_player_obj.x = x+48*spr_dir;
			grabbed_player_obj.y = y;
		}
		
		//Back Throw
		if image_index == 8 { 
			grabbed_player_obj.x = x+48*spr_dir;
			grabbed_player_obj.y = y-24;
		}
		if image_index == 9 { 
			grabbed_player_obj.x = x+24*spr_dir;
			grabbed_player_obj.y = y-48;
		}
		if image_index == 10 || image_index == 11 { 
			grabbed_player_obj.x = x-48*spr_dir;
			grabbed_player_obj.y = y;
		}
		
		//Forward Throw
		if image_index >= 14{
			grabbed_player_obj.x = x+48*spr_dir;
			grabbed_player_obj.y = y-16;
		}
		
		//the above block can be copied for as many windows as necessary.
		//e.g. for an attack like Clairen's back throw, you might have an additional window where the grabbed player is pulled behind.
	}
}

	


if (attack == AT_FSPECIAL && !free && window == 1 && window_timer == 14){
 spawn_hit_fx (x,y, dust);	
}

//voices test
if (attack == AT_DSPECIAL) {
    if (window == 1 && window_timer == 1) { 
       sound_play(sound_get("bowser_hrm"));
    }
}


if (attack == AT_TAUNT) {
    if (window == 2 && window_timer == 5) { 
       sound_play(sound_get("bowser_land"));
    }
}

if (attack == AT_USTRONG) {
    if (window == 2 && window_timer == 3) { 
       sound_play(sound_get("bowser_HA"));
    }
}

//YURRIE IS COOL

if (attack == AT_NSPECIAL) {
    if (fb_size == 0) && (get_player_color(player) == 0) { 
       set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_SPRITE, sprite_get("nspecial_proj_small_corrected"));
    }
}

#define spawn_base_dust // written by supersonic
/// @param x
/// @param y
/// @param name
/// @param dir=0
/// spawn_base_dust(x, y, name, dir = 0)
///spawn_base_dust(x, y, name, ?dir)
//This function spawns base cast dusts. Names can be found below.
var dlen; //dust_length value
var dfx; //dust_fx value
var dfg; //fg_sprite value
var dfa = 0; //draw_angle value
var dust_color = 0;
var x = argument[0], y = argument[1], name = argument[2];
var dir = argument_count > 3 ? argument[3] : 0;

switch (name) {
	default: 
	case "dash_start":dlen = 21; dfx = 3; dfg = 2626; break;
	case "dash": dlen = 16; dfx = 4; dfg = 2656; break;
	case "jump": dlen = 12; dfx = 11; dfg = 2646; break;
	case "doublejump": 
	case "djump": dlen = 21; dfx = 2; dfg = 2624; break;
	case "walk": dlen = 12; dfx = 5; dfg = 2628; break;
	case "land": dlen = 24; dfx = 0; dfg = 2620; break;
	case "walljump": dlen = 24; dfx = 0; dfg = 2629; dfa = dir != 0 ? -90*dir : -90*spr_dir; break;
	case "n_wavedash": dlen = 24; dfx = 0; dfg = 2620; dust_color = 1; break;
	case "wavedash": dlen = 16; dfx = 4; dfg = 2656; dust_color = 1; break;
}
var newdust = spawn_dust_fx(x,y,asset_get("empty_sprite"),dlen);
if newdust == noone return noone;
newdust.dust_fx = dfx; //set the fx id
if dfg != -1 newdust.fg_sprite = dfg; //set the foreground sprite
newdust.dust_color = dust_color; //set the dust color
if dir != 0 newdust.spr_dir = dir; //set the spr_dir
newdust.draw_angle = dfa;
return newdust;


