if (global.host) {
    // log("Sending draw frame, " + string(ds_map_size(global.ships)) + " ship(s)");
    
    buffer_seek(global.server_buffer, buffer_seek_start, 0);
    
    buffer_write(global.server_buffer, buffer_s32, CMD_DRAW);
    buffer_write(global.server_buffer, buffer_s32, instance_number(obj_network_base));
    
    with (obj_network_base) {
        buffer_write(global.server_buffer, buffer_s32, sprite_index);
        buffer_write(global.server_buffer, buffer_f32, x);
        buffer_write(global.server_buffer, buffer_f32, y);
        buffer_write(global.server_buffer, buffer_f32, image_angle);
    }
    
    // Send data
    var socket = ds_map_find_first(global.ships);
    for (var i = 0; i < ds_map_size(global.ships); i++) {
        // Set camera follow
        var ship = ds_map_find_value(global.ships, socket);
        if (i > 0) {
            buffer_seek(global.server_buffer, buffer_seek_relative, -8);
        }
        if (ship.dead) {
            buffer_write(global.server_buffer, buffer_f32, room_width / 2);
            buffer_write(global.server_buffer, buffer_f32, room_height / 2);
        } else {
            buffer_write(global.server_buffer, buffer_f32, ship.x);
            buffer_write(global.server_buffer, buffer_f32, ship.y);
        }
        // log("Buffer length " + string(buffer_tell(global.server_buffer)));
        
        if (global.host_player_id != ship.player_id) {
            // log("Sending buffer to " + string(ship.player_id) + " from " + string(global.host_player_id));
            network_send_packet(socket, global.server_buffer, buffer_tell(global.server_buffer));
        }
        socket = ds_map_find_next(global.ships, socket);
    }
    
}

