//show_debug_overlay(true);
show_debug_message('game_init');
log_init();
randomize();

audio_play_sound(msc_bg, 0, true);

global.names = ds_list_create();
ds_list_add(global.names, "Pork Chop");
ds_list_add(global.names, "Spatula");
ds_list_add(global.names, "Meat Ball");
ds_list_add(global.names, "Luncheon");
ds_list_add(global.names, "Sausage");
ds_list_add(global.names, "Gravy");
ds_list_add(global.names, "Sauce");
ds_list_add(global.names, "Fork");
ds_list_add(global.names, "Mint Peas");
ds_list_add(global.names, "Bread");
ds_list_add(global.names, "Chocolate Brownie");
ds_list_add(global.names, "Raspberry");
ds_list_add(global.names, "Pie");
ds_list_add(global.names, "Egg Timer");
ds_list_add(global.names, "Lemon");
ds_list_add(global.names, "Cabbage");
ds_list_shuffle(global.names);

