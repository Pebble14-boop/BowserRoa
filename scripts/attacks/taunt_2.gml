set_attack_value(AT_TAUNT_2, AG_MUNO_ATTACK_NAME, "the funny yell (taunt)");

set_attack_value(AT_TAUNT_2, AG_SPRITE, sprite_get("taunt_down"));
set_attack_value(AT_TAUNT_2, AG_NUM_WINDOWS, 3);
set_attack_value(AT_TAUNT_2, AG_OFF_LEDGE, 1);
set_attack_value(AT_TAUNT_2, AG_HURTBOX_SPRITE, asset_get("bowser_hurtbox"));


set_window_value(AT_TAUNT_2, 1, AG_WINDOW_LENGTH, 17);
set_window_value(AT_TAUNT_2, 1, AG_WINDOW_ANIM_FRAMES, 6);
set_window_value(AT_TAUNT_2, 1, AG_WINDOW_SFX_FRAME, 19);

set_window_value(AT_TAUNT_2, 2, AG_WINDOW_LENGTH, 30);
set_window_value(AT_TAUNT_2, 2, AG_WINDOW_ANIM_FRAMES, 7);
set_window_value(AT_TAUNT_2, 2, AG_WINDOW_HAS_SFX, 1);

set_window_value(AT_TAUNT_2, 2, AG_WINDOW_SFX, sound_get("bowser_taunt_2"));
set_window_value(AT_TAUNT_2, 2, AG_WINDOW_ANIM_FRAME_START, 7);

set_window_value(AT_TAUNT_2, 3, AG_WINDOW_LENGTH, 14);
set_window_value(AT_TAUNT_2, 3, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_TAUNT_2, 3, AG_WINDOW_ANIM_FRAME_START, 15);
