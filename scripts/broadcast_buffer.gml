// argument0: buffer
// argument1: player id

var socket = ds_map_find_first(global.clients);
for (var i = 0; i < ds_map_size(global.clients); i++) {
    var player_id = ds_map_find_value(global.clients, socket);
    if (argument1 != player_id) {
        network_send_packet(socket, argument0, buffer_tell(argument0));
    }
    socket = ds_map_find_next(global.clients, socket);
}

