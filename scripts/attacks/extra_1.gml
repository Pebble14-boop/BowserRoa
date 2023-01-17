set_attack_value(AT_EXTRA_1, AG_MUNO_ATTACK_NAME, "the funny yell (taunt)");

set_attack_value(AT_EXTRA_1, AG_SPRITE, sprite_get("taunt_forward"));
set_attack_value(AT_EXTRA_1, AG_NUM_WINDOWS, 3);
set_attack_value(AT_EXTRA_1, AG_OFF_LEDGE, 1);
set_attack_value(AT_EXTRA_1, AG_HURTBOX_SPRITE, asset_get("bowser_hurtbox"));


set_window_value(AT_EXTRA_1, 1, AG_WINDOW_LENGTH, 17);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_SFX_FRAME, 14);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_SFX, sound_get("bowser_laugh"));


set_window_value(AT_EXTRA_1, 2, AG_WINDOW_LENGTH, 60);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_ANIM_FRAMES, 12);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_ANIM_FRAME_START, 5);

set_window_value(AT_EXTRA_1, 3, AG_WINDOW_LENGTH, 14);
set_window_value(AT_EXTRA_1, 3, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_EXTRA_1, 3, AG_WINDOW_ANIM_FRAME_START, 16);
