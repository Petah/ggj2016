show_debug_message('LOG ' + argument0);
ds_list_add(global.console_log, argument0);
while (ds_list_size(global.console_log) > 20) {
    ds_list_delete(global.console_log, 0);
}

