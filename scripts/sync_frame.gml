if (global.host) {
    // log("Sending draw frame, " + string(ds_map_size(global.ships)) + " ship(s)");
    
    buffer_seek(global.server_buffer, buffer_seek_start, 0);
    
    buffer_write(global.server_buffer, buffer_s32, CMD_DRAW);
    buffer_write(global.server_buffer, buffer_s32, ds_map_size(global.ships));
    
    // Ships
    var socket = ds_map_find_first(global.ships);
    for (var i = 0; i < ds_map_size(global.ships); i++) {
        var ship = ds_map_find_value(global.ships, socket);
        
        // buffer_write(global.server_buffer, buffer_s32, ship.player_id);
        buffer_write(global.server_buffer, buffer_s32, ship.sprite_index);
        buffer_write(global.server_buffer, buffer_f32, ship.x);
        buffer_write(global.server_buffer, buffer_f32, ship.y);
        buffer_write(global.server_buffer, buffer_f32, ship.image_angle);
        
        // log("Sending sprite " + string(ship.sprite_index) + " " + string(ship.x) + "," + string(ship.y) + " " + string(ship.image_angle))
        // buffer_write(global.server_buffer, buffer_f32, ship.direction);
        // buffer_write(global.server_buffer, buffer_f32, ship.speed);
        
        socket = ds_map_find_next(global.ships, socket);
    }
    
    // Send data
    var socket = ds_map_find_first(global.ships);
    for (var i = 0; i < ds_map_size(global.ships); i++) {
        // Set camera follow
        var ship = ds_map_find_value(global.ships, socket);
        if (i > 0) {
            buffer_seek(global.server_buffer, buffer_seek_relative, -8);
        }
        buffer_write(global.server_buffer, buffer_f32, ship.x);
        buffer_write(global.server_buffer, buffer_f32, ship.y);
        // log("Buffer length " + string(buffer_tell(global.server_buffer)));
        
        if (global.host_player_id != ship.player_id) {
            // log("Sending buffer to " + string(ship.player_id) + " from " + string(global.host_player_id));
            network_send_packet(socket, global.server_buffer, buffer_tell(global.server_buffer));
        }
        socket = ds_map_find_next(global.ships, socket);
    }
    
}

