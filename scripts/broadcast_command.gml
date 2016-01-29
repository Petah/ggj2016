// argument0: command
// argument1: player id

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, argument0);
buffer_write(global.server_buffer, buffer_s32, argument1);

var socket = ds_map_find_first(global.clients);
for (var i = 0; i < ds_map_size(global.clients); i++) {
    var player_id = ds_map_find_value(global.clients, socket);
    if (argument1 != player_id) {
        network_send_packet(socket, global.server_buffer, buffer_tell(global.server_buffer));
    }
    socket = ds_map_find_next(global.clients, socket);
}

