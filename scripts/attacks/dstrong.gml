set_attack_value(AT_DSTRONG, AG_SPRITE, sprite_get("dstrong"));
set_attack_value(AT_DSTRONG, AG_NUM_WINDOWS, 5);
set_attack_value(AT_DSTRONG, AG_STRONG_CHARGE_WINDOW, 1);
set_attack_value(AT_DSTRONG, AG_HURTBOX_SPRITE, sprite_get("dstrong_hurt"));

set_window_value(AT_DSTRONG, 1, AG_WINDOW_LENGTH, 7);
set_window_value(AT_DSTRONG, 1, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_DSTRONG, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_DSTRONG, 1, AG_WINDOW_SFX, asset_get("sfx_forsburn_cape_swipe"));

set_window_value(AT_DSTRONG, 2, AG_WINDOW_LENGTH, 9);
set_window_value(AT_DSTRONG, 2, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_DSTRONG, 2, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_DSTRONG, 2, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_DSTRONG, 2, AG_WINDOW_SFX, asset_get("sfx_swipe_heavy1"));

set_window_value(AT_DSTRONG, 3, AG_WINDOW_LENGTH, 22);
set_window_value(AT_DSTRONG, 3, AG_WINDOW_ANIM_FRAMES, 8);
set_window_value(AT_DSTRONG, 3, AG_WINDOW_ANIM_FRAME_START, 5);

set_window_value(AT_DSTRONG, 4, AG_WINDOW_LENGTH, 10);
set_window_value(AT_DSTRONG, 4, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_DSTRONG, 4, AG_WINDOW_ANIM_FRAME_START, 8);

set_window_value(AT_DSTRONG, 5, AG_WINDOW_LENGTH, 18);
set_window_value(AT_DSTRONG, 5, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_DSTRONG, 5, AG_WINDOW_ANIM_FRAME_START, 13);
set_window_value(AT_DSTRONG, 5, AG_WINDOW_HAS_WHIFFLAG, 1);

set_num_hitboxes(AT_DSTRONG, 7);

set_hitbox_value(AT_DSTRONG, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSTRONG, 1, HG_HITBOX_GROUP, 1);
set_hitbox_value(AT_DSTRONG, 1, HG_WINDOW, 3);
set_hitbox_value(AT_DSTRONG, 1, HG_LIFETIME, 3);
set_hitbox_value(AT_DSTRONG, 1, HG_HITBOX_X, -4);
set_hitbox_value(AT_DSTRONG, 1, HG_HITBOX_Y, -34);
set_hitbox_value(AT_DSTRONG, 1, HG_WIDTH, 119);
set_hitbox_value(AT_DSTRONG, 1, HG_HEIGHT, 64);
set_hitbox_value(AT_DSTRONG, 1, HG_SHAPE, 1);
set_hitbox_value(AT_DSTRONG, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_DSTRONG, 1, HG_DAMAGE, 2);
set_hitbox_value(AT_DSTRONG, 1, HG_ANGLE, 80);
set_hitbox_value(AT_DSTRONG, 1, HG_BASE_KNOCKBACK, 3);
set_hitbox_value(AT_DSTRONG, 1, HG_BASE_HITPAUSE, 3);
set_hitbox_value(AT_DSTRONG, 1, HG_ANGLE_FLIPPER, 10);
set_hitbox_value(AT_DSTRONG, 1, HG_HITPAUSE_SCALING, .2);
set_hitbox_value(AT_DSTRONG, 1, HG_VISUAL_EFFECT, 304);
set_hitbox_value(AT_DSTRONG, 1, HG_HIT_SFX, asset_get("sfx_blow_heavy1"));
set_hitbox_value(AT_DSTRONG, 1, HG_ANGLE_FLIPPER, 6);


set_hitbox_value(AT_DSTRONG, 2, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DSTRONG, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSTRONG, 2, HG_WINDOW, 3);
set_hitbox_value(AT_DSTRONG, 2, HG_LIFETIME, 3);
set_hitbox_value(AT_DSTRONG, 2, HG_WINDOW_CREATION_FRAME, 4);
set_hitbox_value(AT_DSTRONG, 2, HG_HITBOX_X, -4);
set_hitbox_value(AT_DSTRONG, 2, HG_HITBOX_Y, -34);
set_hitbox_value(AT_DSTRONG, 2, HG_HITBOX_GROUP, 2);


set_hitbox_value(AT_DSTRONG, 3, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DSTRONG, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSTRONG, 3, HG_WINDOW, 3);
set_hitbox_value(AT_DSTRONG, 3, HG_LIFETIME, 3);
set_hitbox_value(AT_DSTRONG, 3, HG_WINDOW_CREATION_FRAME, 7);
set_hitbox_value(AT_DSTRONG, 3, HG_HITBOX_X, -4);
set_hitbox_value(AT_DSTRONG, 3, HG_HITBOX_Y, -34);
set_hitbox_value(AT_DSTRONG, 3, HG_HITBOX_GROUP, 3);

set_hitbox_value(AT_DSTRONG, 4, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DSTRONG, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSTRONG, 4, HG_WINDOW, 3);
set_hitbox_value(AT_DSTRONG, 4, HG_LIFETIME, 5);
set_hitbox_value(AT_DSTRONG, 4, HG_WINDOW_CREATION_FRAME, 11);
set_hitbox_value(AT_DSTRONG, 4, HG_HITBOX_X, -4);
set_hitbox_value(AT_DSTRONG, 4, HG_HITBOX_Y, -34);
set_hitbox_value(AT_DSTRONG, 4, HG_HITBOX_GROUP, 4);

set_hitbox_value(AT_DSTRONG, 5, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DSTRONG, 5, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSTRONG, 5, HG_WINDOW, 3);
set_hitbox_value(AT_DSTRONG, 5, HG_LIFETIME, 3);
set_hitbox_value(AT_DSTRONG, 5, HG_WINDOW_CREATION_FRAME, 19);
set_hitbox_value(AT_DSTRONG, 5, HG_HITBOX_X, -4);
set_hitbox_value(AT_DSTRONG, 5, HG_HITBOX_Y, -34);
set_hitbox_value(AT_DSTRONG, 5, HG_HITBOX_GROUP, 5);

set_hitbox_value(AT_DSTRONG, 6, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DSTRONG, 6, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSTRONG, 6, HG_WINDOW, 4);
set_hitbox_value(AT_DSTRONG, 6, HG_LIFETIME, 5);
set_hitbox_value(AT_DSTRONG, 6, HG_HITBOX_X, -4);
set_hitbox_value(AT_DSTRONG, 6, HG_HITBOX_Y, -34);
set_hitbox_value(AT_DSTRONG, 6, HG_HITBOX_GROUP, 6);

set_hitbox_value(AT_DSTRONG, 7, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSTRONG, 7, HG_HITBOX_GROUP, 7);
set_hitbox_value(AT_DSTRONG, 7, HG_WINDOW, 4);
set_hitbox_value(AT_DSTRONG, 7, HG_LIFETIME, 5);
set_hitbox_value(AT_DSTRONG, 7, HG_WINDOW_CREATION_FRAME, 5);
set_hitbox_value(AT_DSTRONG, 7, HG_HITBOX_X, -4);
set_hitbox_value(AT_DSTRONG, 7, HG_HITBOX_Y, -34);
set_hitbox_value(AT_DSTRONG, 7, HG_WIDTH, 119);
set_hitbox_value(AT_DSTRONG, 7, HG_HEIGHT, 64);
set_hitbox_value(AT_DSTRONG, 7, HG_SHAPE, 1);
set_hitbox_value(AT_DSTRONG, 7, HG_PRIORITY, 1);
set_hitbox_value(AT_DSTRONG, 7, HG_DAMAGE, 2);
set_hitbox_value(AT_DSTRONG, 7, HG_ANGLE, 80);
set_hitbox_value(AT_DSTRONG, 7, HG_BASE_KNOCKBACK, 10);
set_hitbox_value(AT_DSTRONG, 7, HG_KNOCKBACK_SCALING, .6);
set_hitbox_value(AT_DSTRONG, 7, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_DSTRONG, 7, HG_ANGLE_FLIPPER, 10);
set_hitbox_value(AT_DSTRONG, 7, HG_HITPAUSE_SCALING, .6);
set_hitbox_value(AT_DSTRONG, 7, HG_VISUAL_EFFECT, 304);
set_hitbox_value(AT_DSTRONG, 7, HG_HIT_SFX, asset_get("sfx_blow_heavy1"));
set_hitbox_value(AT_DSTRONG, 7, HG_ANGLE_FLIPPER, 6);

//make the hitboxes align with each frame of the animation, see if it works
