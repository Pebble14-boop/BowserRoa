/*
 * The stats below are taken from Zetterburn, replacing Sandbert's overpowered
 * movement stats. The commented-out numbers are the range of values the RoA
 * base cast has - e.g. it lists the slowest and fastest run speeds.
 * 
 * Replace Zetter's stats with whatever strengths/weaknesses your char should
 * have, e.g. change dash_speed to 8 or so if you want a fast character.
 *
 * Explanation of each stat:
 * https://rivalsofaether.com/player-variables/
 * 
 * Base Cast Frame Data:
 * docs.google.com/spreadsheets/d/19UtK7xG2c-ehxdlhCFKMpM4_IHSG-EXFgXLJaunE79I
 * 
 * Base Cast Stats:
 * docs.google.com/spreadsheets/d/14JIjL_5t81JHqnJmU6BSsRosTe2JO8sFGUysM_9tDoU
 */

// STAT NAME		VALUE       BASECAST RANGE   NOTES

// Physical size
char_height         = 77;       //                  not zetterburn's. this is just cosmetic anyway
knockback_adj       = 0.9;		// 0.9  -  1.2



// Ground movement
walk_speed          = 2.80;		// 3    -  4.5
walk_accel          = 0.2;		// 0.2  -  0.5
walk_turn_time      = 6;		// 6
initial_dash_time   = 8;		// 8    -  16       zetterburn's is 14
initial_dash_speed  = 6;		// 4    -  9
dash_speed          = 5.50;		// 5    -  9
dash_turn_time      = 11;		// 8    -  20
dash_turn_accel     = 0.5;		// 0.1  -  2
dash_stop_time      = 6;		// 4    -  6        zetterburn's is 4
dash_stop_percent   = 0.35;		// 0.25 -  0.5
ground_friction     = 0.5;		// 0.3  -  1
moonwalk_accel      = 1.3;		// 1.2  -  1.4
    
// Air movement
leave_ground_max    = 6;		// 4    -  8
max_jump_hsp        = 6;		// 4    -  8
air_max_speed       = 4;  		// 3    -  7
jump_change         = 3;		// 3
air_accel           = 0.25;		// 0.2  -  0.4
prat_fall_accel     = 0.85;		// 0.25 -  1.5
air_friction        = 0.04;		// 0.02 -  0.07
max_fall            = 10;		// 6    -  11
fast_fall           = 14;		// 11   -  16
gravity_speed       = 0.5;		// 0.3  -  0.6
hitstun_grav        = 0.5;		// 0.45 -  0.53

// Jumps
jump_start_time     = 5;		// 5                this stat is automatically decreased by 1 after init.gml (dan moment), so its "real value" is 4. if you change this during a match, 4 is the value you should reset it to
jump_speed          = 10.5;		// 7.6  -  12       okay, zetter's is actually 10.99 but... come on
short_hop_speed     = 6;		// 4    -  7.4
djump_speed         = 9;		// 6    -  12       absa's is -1 because of her floaty djump
djump_accel         = 0;		// -1.4 -  0        absa's is -1.4, all other chars are 0. only works if the   djump_accel_end_time   variable is also set. floaty djumps should be adjusted by feel based on your char's gravity
djump_accel_end_time= 0;		//                  the amount of time that   djump_accel   is applied for
max_djumps          = 1;		// 0    -  3        the 0 is elliana because she has hover instead
walljump_hsp        = 7;		// 4    -  7
walljump_vsp        = 8;		// 7    -  10
land_time           = 6;		// 4    -  6
prat_land_time      = 10;		// 3    -  24       zetterburn's is 3, but that's ONLY because his uspecial is so slow. safer up b (or other move) = longer pratland time to compensate

// Shield-button actions
wave_friction       = 0.10;		// 0    -  0.15
roll_forward_max    = 9;		// 9    -  11
roll_backward_max   = 9;		// 9    -  11       always the same as forward
wave_land_time      = 8;		// 6    -  12
wave_land_adj       = 1.25;		// 1.2  -  1.5      idk what zetterburn's is
air_dodge_speed     = 7.5;		// 7.5  -  8
techroll_speed      = 10;		// 8    -  11



// Character-specific assets init
breath = 0;

//JOHNNY (YURRIE) IS AWESOME, AND COOL.
fb_size = 0;

dash_sound = noone;

//nspecial
fire_charge = 0;
fireball = noone;
fireball_num = 3;

//Sprites
spr_nspecial_proj = sprite_get("nspecial_proj");
spr_example = sprite_get("example"); // sprites/example_stripX.png

// SFX
sfx_dbfz_kame_charge = sound_get("ARC_BTL_GKN_Kamehame_Chrg");
sfx_dbfz_kame_fire = sound_get("ARC_BTL_GKN_Kamehame_Fire");
sfx_dbfz_hit_weak = sound_get("ARC_BTL_CMN_Hit_Small-A");
sfx_dbfz_hit_broken = sound_get("ARC_BTL_CMN_Hit_XLarge");


// VFX
vfx_ftilt_destroy = hit_fx_create(sprite_get("vfx_ftilt_destroy"), 12); // actually for nspecial, not ftilt
vfx_nspecial_fire = hit_fx_create(sprite_get("vfx_nspecial_fire"), 16);
dust = hit_fx_create (sprite_get("dust"), 12);

//compatibility stuff
arena_title = "King of the Koopas";

pkmn_stadium_back_img = sprite_get("Bowser_PS_Back");
pkmn_stadium_front_img = sprite_get("Bowser_PS_Front");

TCG_Kirby_Copy = 1;

tcoart = sprite_get("bowsertcoart");

battle_text = "* The King snarls at you.";

boxing_title = "Dark Star 
Destroyer";

//Snake interigations

sna_interrogated_line_01 = "Hey, watch the tail!";
sna_interrogated_line_02 = "I'm gonna set that box of yours on fire for this!";
sna_interrogated_line_03 = "I only steal princesses, pal, not metal whatevers.";

//Henry Stickmin fail

has_fail = true;
fail_text = "Uh oh!";

//unregistered HyperCam quotes

uhc_victory_quote = "Leked bow wow xx peath pics!";
uhc_victory_quote = "Mao ann louis inner ta le :0 rom!@!!!!";

//Wall-E Taunt

walle_taunt_sound = sound_get("Showtime_Theme")
walle_taunt_type = 1

//Chaos emeralds buddy
super_form_transform_sound = sound_get("Chaos_Bowser")
super_form_music = sound_get("Chaos_bowser_theme");

//Cover by GaMetal

// Green flower hill zone

gfzsignspr = sprite_get("BowserBoard")

gfzsignsfx = sound_get("gfz_sound")

//wily castle
 wily_robotmaster_img = sprite_get("Bowser_Megaman");
 
 //Last Resort

 resort_portrait = sprite_get("Bowserjr")
 
//steve-compatiblity

steve_death_message = "Steve was sent to another castle."

//Hikaru title

Hikaru_Title = "King"; 

//Pacman sprite 

Namco_Taunt = sprite_get("pacman_samus_sprite_test")
Namco_Taunt_Sound = sound_get("pacman_metroid_nes_effect")

//Amber
plushForAmber = sprite_get("Bowser_Plush")

//Trial grounds

guiltySprite = sprite_get("Bowser_Trial")

//Miiverse

miiverse_post = sprite_get("miiverse_post")

//ttyd stage

ttyd_audience_sprite = sprite_get("Bowser-jr-ppmttyd")
//po and Gumbo
pot_compat_variable = sprite_get("Bowser_food");
pot_compat_text = "Chili Cheese Boo-Dog"

//so sorry support

//sorry_art = sprite_get("sorryart_[samus_card]");

//loadent

//ltweet = sprite_get( "ltweet" );



//Toon link

//toonlink_photo = sprite_get("Samus_Toon_link");
//toonlink_photo2 = 1

//Feri

feri_costume = sprite_get("Feri_Bowser");

//Otto bobblehead

otto_bobblehead_sprite = sprite_get("otto_bobblehead");

otto_bobblehead_body_sprite = sprite_get("otto_bobblehead_body");

//Dracula support
dracula_portrait = sprite_get("Bowser1");
dracula_portrait2 = sprite_get("Bowser2");
dracula_portrait3 = sprite_get("Bowser3");
dracula_portrait4 = sprite_get("Bowser4");
dracula_portrait5 = sprite_get("Bowser5");
dracula_portrait6 = sprite_get("Bowser6");
var page = 0;

//Page 0
dracula_speaker[0] = 1;
dracula_text[0] = "Ugh, I hate the color of these walls. Luckily, it’s nothing a little demolition can’t fix.";
page++;

//Page 1
dracula_speaker[1] = 0;
dracula_text[1] = "...";
page++;

//page 2

dracula_speaker[2] = 3;
dracula_text[2] = "Oh yeah, once I get some busts of my beautiful mug in here, it’s gonna look great!";
page++;

//Page 3
dracula_speaker[3] = 0;
dracula_text[3] = "Excuse me.";
page++;

//Page 4
dracula_speaker[4] = 1;
dracula_text[4] = "Though the pillars are gonna have to have way more spikes.";
page++;

//Page 5
dracula_speaker[5] = 0;
dracula_text[5] = "Why have you-";
page++;

//Page 6
dracula_speaker[6] = 2;
dracula_text[6] = "Gonna have to dig a trench for the lava pits. Junior would probably-";
page++;

//Page 7
dracula_speaker[7] = 0;
dracula_text[7] = "[shake]HOW DARE YOU IGNORE ME, REPTILE!";
page++;

//Page 8
dracula_speaker[8] = 3;
dracula_text[8] = "Sorry gramps, was just imagining what this dump will look like after I'm done beating the snot out of you.";
page++;

//Page 9
dracula_speaker[9] = 0;
dracula_text[9] = "Bah, your ego is obvious. What business do you have with me, Koopa?";
page++;

//Page 10
dracula_speaker[10] = 2;
dracula_text[10] = "Oh, nothing much, it's just-";
page++;

//Page 11
dracula_speaker[11] = 4;
dracula_text[11] = "[shake]YOU KIDNAPPED PEACH, BAT FOR BRAINS!";
page++;

//Page 12
dracula_speaker[12] = 6;
dracula_text[12] = "KIDNAPPING PEACH IS MY THING, PAL, NOT YOURS!";
page++;

//Page 13
dracula_speaker[13] = 0;
dracula_text[13] = "I only desire the wench's magic. Perhaps you may have her body once I am done feasting on her soul.";
page++;

//Page 14
dracula_speaker[14] = 5;
dracula_text[14] = "Ugh, gross. You're a real freak, aren’t you, gramps?";
page++;

//Page 15
dracula_speaker[15] = 0;
dracula_text[15] = "[shake]ENOUGH! If you want the wench, then come and take her!";
page++;

//Page 16
dracula_speaker[16] = 6;
dracula_text[16] = "I was hoping you’d say that!";
page++;

//Page 17
dracula_speaker[17] = 0;
dracula_text[17] = "Excellent. [glass] Tonight I dine on turtle soup!";
page++;

//Page 18
dracula_speaker[18] = 6;
dracula_text[18] = "Sorry, but tonight's special is fried bat!";
page++;

//Page 19
dracula_speaker[19] = 3;
dracula_text[19] = "It's showtime!!!";
page++;


// Animation Info

// Misc. animation speeds
idle_anim_speed     = 0.12;
crouch_anim_speed   = 0.1;
walk_anim_speed     = 0.175;
dash_anim_speed     = 0.2;
pratfall_anim_speed = 0.25;


// Jumps
double_jump_time    = 24;		// 24   -  40
walljump_time       = 18;		// 18   -  32
wall_frames         = 2;		// may or may not actually work... dan pls


// Parry
dodge_startup_frames    = 1;
dodge_active_frames     = 2;
dodge_recovery_frames   = 3;

// Tech
tech_active_frames      = 3;
tech_recovery_frames    = 1;

// Tech roll
techroll_startup_frames     = 1;
techroll_active_frames      = 4;
techroll_recovery_frames    = 2;

// Airdodge
air_dodge_startup_frames    = 2;
air_dodge_active_frames     = 2;
air_dodge_recovery_frames   = 2;

// Roll
roll_forward_startup_frames     = 1;
roll_forward_active_frames      = 3;
roll_forward_recovery_frames    = 4;
roll_back_startup_frames        = 1;
roll_back_active_frames         = 3;
roll_back_recovery_frames       = 4;

// Crouch
crouch_startup_frames   = 3;
crouch_active_frames    = 4;
crouch_recovery_frames  = 1;

/*

Muno's Words of Wisdom: Due to a Certified Dan Moment, you must duplicate the
last frame of your crouch animation. So like, if your animation has 10 frames
total, add an 11th that's the copy of the 10th. You do NOT include this 11th
frame in the crouch_recovery_frames or etc; configure these values AS IF there
were only 10 frames.

The reason for this is that otherwise, the crouch just glitches out at the end
of the standing-up animation. Dan Moment

*/



// Hurtbox sprites
hurtbox_spr         = sprite_get("bowser_hurtbox");
crouchbox_spr       = sprite_get("crouch_hurtbox");
air_hurtbox_spr     = -1; // -1 = use hurtbox_spr
hitstun_hurtbox_spr = -1; // -1 = use hurtbox_spr

//intro animation 
introTimer = -4;
//setting it to -4 should prevent the first few frames of the animation from being blocked by the screen opening. If it's slightly off, feel free to mess with it.
introTimer2 = 0;

// Victory
set_victory_bg(sprite_get("victory_background")); // victory_background.png
set_victory_theme(sound_get("victory_theme")); // victory_theme.ogg

// Movement SFX
land_sound          = sound_get("bowser_land");
landing_lag_sound   = asset_get("sfx_land_heavy");
waveland_sound      = asset_get("sfx_waveland_zet"); // recommended to try out all 14 base cast wavedash sfx (see sfx page in roa manual)
jump_sound          = sound_get("bowser_jump");
djump_sound         = sound_get("bowser_jump");
air_dodge_sound     = asset_get("sfx_quick_dodge");

// Visual offsets for when you're in Ranno's bubble
bubble_x = 0;
bubble_y = 8;


//Command Grab stuff
grabbed_player_obj = noone;    //the player object currently being grabbed.
grabbed_player_relative_x = 0; //the relative x and y position of the grabbed player, at the point they were grabbed.
grabbed_player_relative_y = 0;   //we store this coordinate to smoothly reposition the grabbed player later.
