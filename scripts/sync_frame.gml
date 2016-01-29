/*
if (global.host) {
    // log("Sync frame " + string(ds_map_size(global.clients)));
    
    buffer_seek(global.server_buffer, buffer_seek_start, 0);
    
    buffer_write(global.server_buffer, buffer_s32, CMD_SYNC_FRAME);
    buffer_write(global.server_buffer, buffer_s32, ds_map_size(global.clients));
    
    // Get ship positions
    var socket = ds_map_find_first(global.clients);
    for (var i = 0; i < ds_map_size(global.clients); i++) {
        var instance = ds_map_find_value(global.clients, socket);
        with (instance) {
            buffer_write(global.server_buffer, buffer_s32, x);
            buffer_write(global.server_buffer, buffer_s32, y);
            buffer_write(global.server_buffer, buffer_s32, direction);
        }
        socket = ds_map_find_next(global.clients, socket);
    }
    
    broadcast(global.server_buffer);
}
*/
