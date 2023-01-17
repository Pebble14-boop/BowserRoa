set_attack_value(AT_TAUNT, AG_MUNO_ATTACK_NAME, "the funny yell (taunt)");

set_attack_value(AT_TAUNT, AG_SPRITE, sprite_get("taunt"));
set_attack_value(AT_TAUNT, AG_NUM_WINDOWS, 3);
set_attack_value(AT_TAUNT, AG_OFF_LEDGE, 1);
set_attack_value(AT_TAUNT, AG_HURTBOX_SPRITE, asset_get("bowser_hurtbox"));


set_window_value(AT_TAUNT, 1, AG_WINDOW_LENGTH, 20);
set_window_value(AT_TAUNT, 1, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_TAUNT, 1, AG_WINDOW_SFX_FRAME, 19);


set_window_value(AT_TAUNT, 2, AG_WINDOW_LENGTH, 18);
set_window_value(AT_TAUNT, 2, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_TAUNT, 2, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_TAUNT, 2, AG_WINDOW_SFX_FRAME, 5);
set_window_value(AT_TAUNT, 2, AG_WINDOW_SFX, sound_get("bowser_taunt"));
set_window_value(AT_TAUNT, 2, AG_WINDOW_ANIM_FRAME_START, 4);


set_window_value(AT_TAUNT, 3, AG_WINDOW_LENGTH, 30);
set_window_value(AT_TAUNT, 3, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_TAUNT, 3, AG_WINDOW_ANIM_FRAME_START, 8);



