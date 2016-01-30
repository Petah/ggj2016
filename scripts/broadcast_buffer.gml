// argument0: buffer

var socket = ds_map_find_first(global.ships);
for (var i = 0; i < ds_map_size(global.ships); i++) {
    var ship = ds_map_find_value(global.ships, socket);
    if (global.host_player_id != ship.player_id) {
        // log("Sending buffer to " + string(ship.player_id) + " from " + string(global.host_player_id));
        network_send_packet(socket, argument0, buffer_tell(argument0));
    }
    socket = ds_map_find_next(global.ships, socket);
}

