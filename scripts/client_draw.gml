var length = ds_list_size(global.sprites);
// log("Sprites " + string(length));
for (var i = 0; i < length; i++) {
    var data_array = ds_list_find_value(global.sprites, i);
    // log("Draw sprite " + string(data_array[0]) + " " + string(data_array[1]) + "," + string(data_array[2]) + " " + string(data_array[3]));
    draw_wrap_sprite(data_array[0], 0, data_array[1], data_array[2], 1, 1, data_array[3], c_white, 1);    
}

