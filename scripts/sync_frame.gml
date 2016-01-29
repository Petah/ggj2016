if (global.host) {
    log("Sending draw frame, " + string(ds_map_size(global.clients)) + " client(s)");
    
    buffer_seek(global.server_buffer, buffer_seek_start, 0);
    
    buffer_write(global.server_buffer, buffer_s32, CMD_DRAW);
    buffer_write(global.server_buffer, buffer_s32, ds_map_size(global.clients));
    
    // Host player
    // buffer_write(global.server_buffer, buffer_s32, global.player_id);
    // buffer_write(global.server_buffer, buffer_s32, global.player.sprite_index);
    // buffer_write(global.server_buffer, buffer_f32, global.player.x);
    // buffer_write(global.server_buffer, buffer_f32, global.player.y);
    // buffer_write(global.server_buffer, buffer_f32, global.player.image_angle);
    // buffer_write(global.server_buffer, buffer_f32, global.player.direction);
    // buffer_write(global.server_buffer, buffer_f32, global.player.speed);
    
    // Network players
    var player_id = ds_map_find_first(global.ships);
    for (var i = 0; i < ds_map_size(global.ships); i++) {
        var ship = ds_map_find_value(global.ships, player_id);
        
        buffer_write(global.server_buffer, buffer_s32, ship.player_id);
        buffer_write(global.server_buffer, buffer_s32, ship.sprite_index);
        buffer_write(global.server_buffer, buffer_f32, ship.x);
        buffer_write(global.server_buffer, buffer_f32, ship.y);
        buffer_write(global.server_buffer, buffer_f32, ship.image_angle);
        // buffer_write(global.server_buffer, buffer_f32, ship.direction);
        // buffer_write(global.server_buffer, buffer_f32, ship.speed);
        
        player_id = ds_map_find_next(global.ships, player_id);
    }
    /*
    
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
    */
    
    broadcast_buffer(global.server_buffer, global.player_id);
}

