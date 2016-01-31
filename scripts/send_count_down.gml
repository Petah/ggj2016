// argument0: particle type
// argument1: x
// argument2: y 

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, CMD_COUNT_DOWN);

var socket = ds_map_find_first(global.ships);
for (var i = 0; i < ds_map_size(global.ships); i++) {
    var ship = ds_map_find_value(global.ships, socket);
    if (ship.id == id) {
        network_send_packet(socket, global.server_buffer, buffer_tell(global.server_buffer));
    }
    socket = ds_map_find_next(global.ships, socket);
}

