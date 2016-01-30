#define sync_frame
if (global.host) {
    // log("Sending draw frame, " + string(ds_map_size(global.ships)) + " ship(s)");
    
    // Send data
    var socket = ds_map_find_first(global.ships);
    for (var i = 0; i < ds_map_size(global.ships); i++) {
        // Set camera follow
        var ship = ds_map_find_value(global.ships, socket);
        
        if (global.host_player_id != ship.player_id) {
            buffer_seek(global.server_buffer, buffer_seek_start, 0);
            buffer_write(global.server_buffer, buffer_s32, CMD_DRAW);
        
            // Camera 
            if (ship.dead) {
                buffer_write(global.server_buffer, buffer_f32, room_width / 2);
                buffer_write(global.server_buffer, buffer_f32, room_height / 2);
                
                // Dont send sprites
                buffer_write(global.server_buffer, buffer_s32, 0);
            } else {
                buffer_write(global.server_buffer, buffer_f32, ship.x);
                buffer_write(global.server_buffer, buffer_f32, ship.y);
                
                var count_position = buffer_tell(global.server_buffer);
                buffer_write(global.server_buffer, buffer_s32, 0);
                
                var count = 0;
                
                with (obj_bullet) {
                    if (abs(get_distance_torus(ship.x, ship.y, x, y, room_width, room_height)) < view_hview[0]) {
                        write_sprite_buffer();
                        count += 1;
                    }
                }
                
                with (obj_asteroid) {
                    if (abs(get_distance_torus(ship.x, ship.y, x, y, room_width, room_height)) < view_hview[0]) {
                        write_sprite_buffer();
                        count += 1;
                    }
                }
                
                with (obj_ship) {
                    if (abs(get_distance_torus(ship.x, ship.y, x, y, room_width, room_height)) < view_hview[0]) {
                        write_sprite_buffer();
                        count += 1;
                    }
                }
                
                with (obj_explosion) {
                    if (abs(get_distance_torus(ship.x, ship.y, x, y, room_width, room_height)) < view_hview[0]) {
                        write_sprite_buffer();
                        count += 1;
                    }
                }
                
                var end_position = buffer_tell(global.server_buffer);
                buffer_seek(global.server_buffer, buffer_seek_start, count_position);
                buffer_write(global.server_buffer, buffer_s32, count);
                buffer_seek(global.server_buffer, buffer_seek_start, end_position);
                
                buffer_write(global.server_buffer, buffer_f32, ship.ship_hp);
                buffer_write(global.server_buffer, buffer_f32, ship.ship_max_hp);
            }
            
            // log("Buffer length " + string(buffer_tell(global.server_buffer)));
            
            if (global.host_player_id != ship.player_id) {
                // log("Sending buffer to " + string(ship.player_id) + " from " + string(global.host_player_id));
                network_send_packet(socket, global.server_buffer, buffer_tell(global.server_buffer));
            }
        }
        socket = ds_map_find_next(global.ships, socket);
    }
    
}


#define write_sprite_buffer
buffer_write(global.server_buffer, buffer_s32, sprite_index);
buffer_write(global.server_buffer, buffer_f32, x);
buffer_write(global.server_buffer, buffer_f32, y);
buffer_write(global.server_buffer, buffer_f32, image_angle);
buffer_write(global.server_buffer, buffer_s32, image_index);

