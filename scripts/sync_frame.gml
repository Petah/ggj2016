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
            
            write_score_buffer(ship);
        
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
                
                with (obj_bullet) { count += write_sprite_buffer(ship); }
                with (obj_asteroid) { count += write_sprite_buffer(ship); }
                with (obj_coin_1) { count += write_sprite_buffer(ship); }
                with (obj_powerup) { count += write_sprite_buffer(ship); }
                with (obj_ship) { count += write_sprite_buffer(ship); }
                with (obj_blackhole) { count += write_sprite_buffer(ship); }
                with (obj_explosion) { count += write_sprite_buffer(ship); }
                
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
if (abs(get_distance_torus(argument0.x, argument0.y, x, y, room_width, room_height)) < view_hview[0]) {
    buffer_write(global.server_buffer, buffer_s32, sprite_index);
    buffer_write(global.server_buffer, buffer_f32, x);
    buffer_write(global.server_buffer, buffer_f32, y);
    buffer_write(global.server_buffer, buffer_f32, image_angle);
    buffer_write(global.server_buffer, buffer_s32, image_index);
    return 1;
}
return 0;


#define write_score_buffer
buffer_write(global.server_buffer, buffer_u8, ds_map_size(global.ships));
    
var socket = ds_map_find_first(global.ships);
for (var i = 0; i < ds_map_size(global.ships); i++) {
    var ship = ds_map_find_value(global.ships, socket);
    buffer_write(global.server_buffer, buffer_s32, ship.id);
    buffer_write(global.server_buffer, buffer_u16, ship.ship_score);
    buffer_write(global.server_buffer, buffer_string, ship.ship_name);
    if (argument0.id == ship.id) {
        buffer_write(global.server_buffer, buffer_u8, 53);
        buffer_write(global.server_buffer, buffer_u8, 186);
        buffer_write(global.server_buffer, buffer_u8, 243);
    } else {
        buffer_write(global.server_buffer, buffer_u8, 255);
        buffer_write(global.server_buffer, buffer_u8, 255);
        buffer_write(global.server_buffer, buffer_u8, 255);
    }
    
    socket = ds_map_find_next(global.ships, socket);
}