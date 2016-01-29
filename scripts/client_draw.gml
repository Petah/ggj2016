var length = ds_list_size(global.sprites);
for (var i = 0; i < length; i++) {
    var data_array = ds_list_find_value(global.sprites, i);
    draw_sprite_ext(data_array[0], 0, data_array[1], data_array[2], 1, 1, data_array[3], c_white, 1);
}

