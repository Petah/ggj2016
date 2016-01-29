draw_text_colour(0, 20, 'Console:', c_white, c_white, c_white, c_white, 1);
for (var i = 0; i < ds_list_size(global.console_log); i++) {
    draw_text_colour(0, 50 + (i * 20), ds_list_find_value(global.console_log, i), c_white, c_white, c_white, c_white, 1);
}


