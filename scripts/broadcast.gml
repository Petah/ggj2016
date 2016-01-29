// argument0: buffer

var socket = ds_map_find_first(global.clients);
for (var i = 0; i < ds_map_size(global.clients); i++) {
    network_send_packet(socket, argument0, buffer_tell(argument0));
    socket = ds_map_find_next(global.clients, socket);
}

