set_attack_value(AT_DAIR, AG_CATEGORY, 1);
set_attack_value(AT_DAIR, AG_SPRITE, sprite_get("dair"));
set_attack_value(AT_DAIR, AG_NUM_WINDOWS, 4);
set_attack_value(AT_DAIR, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_DAIR, AG_LANDING_LAG, 5);
set_attack_value(AT_DAIR, AG_HURTBOX_SPRITE, sprite_get("dair_hurt"));

//startup 
set_window_value(AT_DAIR, 1, AG_WINDOW_LENGTH, 12);
set_window_value(AT_DAIR, 1, AG_WINDOW_ANIM_FRAMES, 5);
set_window_value(AT_DAIR, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_DAIR, 1, AG_WINDOW_VSPEED_TYPE, 0);
set_window_value(AT_DAIR, 1, AG_WINDOW_VSPEED, -1);
set_window_value(AT_DAIR, 1, AG_WINDOW_SFX, asset_get("sfx_swipe_heavy2"));
set_window_value(AT_DAIR, 1, AG_WINDOW_SFX_FRAME, 9);

//active
set_window_value(AT_DAIR, 2, AG_WINDOW_LENGTH, 13);
set_window_value(AT_DAIR, 2, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_DAIR, 2, AG_WINDOW_ANIM_FRAME_START, 5);

set_window_value(AT_DAIR, 3, AG_WINDOW_LENGTH, 13);
set_window_value(AT_DAIR, 3, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_DAIR, 3, AG_WINDOW_ANIM_FRAME_START, 5);


//endlang
set_window_value(AT_DAIR, 4, AG_WINDOW_LENGTH, 11);
set_window_value(AT_DAIR, 4, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_DAIR, 4, AG_WINDOW_ANIM_FRAME_START, 9);
set_window_value(AT_DAIR, 4, AG_WINDOW_HAS_WHIFFLAG, 1);




set_num_hitboxes(AT_DAIR, 8);

//multhi 1
set_hitbox_value(AT_DAIR, 1, HG_HITBOX_GROUP, 1);
set_hitbox_value(AT_DAIR, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 1, HG_WINDOW, 2);
set_hitbox_value(AT_DAIR, 1, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 1, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 1, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 1, HG_WIDTH, 62);
set_hitbox_value(AT_DAIR, 1, HG_HEIGHT, 52);
set_hitbox_value(AT_DAIR, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_DAIR, 1, HG_DAMAGE, 2);
set_hitbox_value(AT_DAIR, 1, HG_ANGLE, 270);
set_hitbox_value(AT_DAIR, 1, HG_BASE_KNOCKBACK, 7);
set_hitbox_value(AT_DAIR, 1, HG_BASE_HITPAUSE, 5);
set_hitbox_value(AT_DAIR, 1, HG_VISUAL_EFFECT, 197);
set_hitbox_value(AT_DAIR, 1, HG_HIT_SFX, asset_get("sfx_blow_heavy2"));

//multihit 2
set_hitbox_value(AT_DAIR, 2, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 2, HG_WINDOW, 2);
set_hitbox_value(AT_DAIR, 2, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 2, HG_WINDOW_CREATION_FRAME, 3);
set_hitbox_value(AT_DAIR, 2, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 2, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 2, HG_HITBOX_GROUP, 2);


//multihit 3
set_hitbox_value(AT_DAIR, 3, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 3, HG_WINDOW, 2);
set_hitbox_value(AT_DAIR, 3, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 3, HG_WINDOW_CREATION_FRAME, 6);
set_hitbox_value(AT_DAIR, 3, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 3, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 3, HG_HITBOX_GROUP, 3);

//multhit 4

set_hitbox_value(AT_DAIR, 4, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 4, HG_WINDOW, 2);
set_hitbox_value(AT_DAIR, 4, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 4, HG_WINDOW_CREATION_FRAME, 9);
set_hitbox_value(AT_DAIR, 4, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 4, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 4, HG_HITBOX_GROUP, 4);



set_hitbox_value(AT_DAIR, 5, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 5, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 5, HG_WINDOW, 3);
set_hitbox_value(AT_DAIR, 5, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 5, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 5, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 5, HG_HITBOX_GROUP, 5);


set_hitbox_value(AT_DAIR, 6, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 6, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 6, HG_WINDOW, 3);
set_hitbox_value(AT_DAIR, 6, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 6, HG_WINDOW_CREATION_FRAME, 3);
set_hitbox_value(AT_DAIR, 6, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 6, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 6, HG_HITBOX_GROUP, 6);



set_hitbox_value(AT_DAIR, 7, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 7, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 7, HG_WINDOW, 3);
set_hitbox_value(AT_DAIR, 7, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 7, HG_WINDOW_CREATION_FRAME, 6);
set_hitbox_value(AT_DAIR, 7, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 7, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 7, HG_HITBOX_GROUP, 7);

set_hitbox_value(AT_DAIR, 8, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 8, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 8, HG_WINDOW, 3);
set_hitbox_value(AT_DAIR, 8, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 8, HG_WINDOW_CREATION_FRAME, 9);
set_hitbox_value(AT_DAIR, 8, HG_HITBOX_X, -7);
set_hitbox_value(AT_DAIR, 8, HG_HITBOX_Y, -11);
set_hitbox_value(AT_DAIR, 8, HG_HITBOX_GROUP, 8);
