#define server_networking
var event_id = ds_map_find_value(async_load, "id");
var type = ds_map_find_value(async_load, "type");

// log("Network event " + string(event_id) + " type " + string(type));

if (global.server == event_id) {
    // log("Server data " + string(event_id));
    switch (type) {
        case network_type_connect: {
            server_player_connect();
            break;
        }
        case network_type_disconnect: {
            server_player_disconnect();
            break;
        }
    }
} else if (event_id == global.client) {
    // log("Client data " + string(event_id));
    switch (type) {
        case network_type_data: {   
            client_data();
            break;
        }
    }
} else {
    // log("Event data " + string(event_id));
    switch (type) {
        case network_type_data: {      
            server_data();
            break;
        }
    }
}


#define client_data
// Get the buffer the data resides in
var buffer = ds_map_find_value(async_load, "buffer");

// Read the command 
var command = buffer_read(buffer, buffer_s32);

// Get the socket ID - this is the CLIENT socket ID. We can use this as a "key" for this client
var socket = ds_map_find_value(async_load, "id");

switch (command) {
    case CMD_PLAYER_INIT: {
        global.player_id = buffer_read(buffer, buffer_s32);
        var spawn_x = buffer_read(buffer, buffer_f32);
        var spawn_y = buffer_read(buffer, buffer_f32);
        log("Client player init " + string(global.player_id) + " " + string(spawn_x) + "," + string(spawn_y));
        global.player = instance_create(spawn_x, spawn_y, obj_player);
        break;
    }
    case CMD_PLAYER_JOIN: {
        var player_id = buffer_read(buffer, buffer_s32);
        var spawn_x = buffer_read(buffer, buffer_f32);
        var spawn_y = buffer_read(buffer, buffer_f32);
        log("New player join " + string(player_id) + " " + string(spawn_x) + "," + string(spawn_y));
        var network_player = instance_create(spawn_x, spawn_y, obj_network_player);
        ds_map_add(global.network_players, player_id, network_player);
        break;
    }
    case CMD_SYNC_FRAME: {
        var ship_count = buffer_read(buffer, buffer_s32);
        
        log("Client sync frame for " + string(ship_count) + " clients. Player " + string(global.player_id) + " " + string(global.player));
        
        for (var i = 0; i < ship_count; i++) {
            var network_player_id = buffer_read(buffer, buffer_s32);
            var ship_x = buffer_read(buffer, buffer_f32);
            var ship_y = buffer_read(buffer, buffer_f32);
            var ship_direction = buffer_read(buffer, buffer_f32);
            var ship_speed = buffer_read(buffer, buffer_f32);
            
            var instance;
            if (network_player_id == global.player_id) {
                instance = global.player;
            } else {
                instance = ds_map_find_value(global.network_players, network_player_id);
            }
            
            instance.x = ship_x;
            instance.y = ship_y;
            instance.direction = ship_direction;
            instance.speed = ship_speed;
            
            log("Ship " + string(network_player_id) + " " + string(instance) + " " + string(ship_x) + "," + string(ship_y) + " " + string(ship_direction) + " " + string(ship_speed));
        }
        break;
    }
    case CMD_DRAW: {
        var sprite_count = buffer_read(buffer, buffer_s32);
        log("Draw frame " + string(sprite_count) + " sprites");
        var i;
        for (i = 0; i < sprite_count; i++) {
            var data_array;
            data_array[0] = buffer_read(buffer, buffer_s32); // sprite_index
            data_array[1] = buffer_read(buffer, buffer_f32); // x
            data_array[2] = buffer_read(buffer, buffer_f32); // y
            data_array[3] = buffer_read(buffer, buffer_f32); // image_angle
            ds_list_replace(global.sprites, i, data_array);
        }
        
        // Remove old sprites
        for (var j = ds_list_size(global.sprites) - 1;j >= i; j--) {
            ds_list_delete(global.sprites, j);
        }
    }
    case CMD_ACCELERATE:
    case CMD_BREAK:
    case CMD_TURN_RIGHT:
    case CMD_TURN_LEFT: {
        var player_id = buffer_read(buffer, buffer_s32);
        var network_player = ds_map_find_value(global.network_players, player_id);
        // log("Received command " + string(command) + " from " + string(player_id) + " ship " + string(network_player));
        process_command(command, network_player);
        break;
    }
    default: {
        log("Client unknown command " + string(command));
        break;
    }
}


#define server_data
// Get the buffer the data resides in
var buffer = ds_map_find_value(async_load, "buffer");

// Read the command 
var command = buffer_read(buffer, buffer_s32);

// Get the socket ID - this is the CLIENT socket ID. We can use this as a "key" for this client
var socket = ds_map_find_value(async_load, "id");

var player_id = ds_map_find_value(global.clients, socket);

broadcast_command(command, player_id);

/*
// log("Event data command " + string(command));

switch (command) {
    case CMD_ACCELERATE: {
        instance.speed += 1;
        break;
    }
    case CMD_BREAK: {
        instance.speed -= 1;
        break;
    }
    case CMD_TURN_RIGHT: {
        instance.direction -= 10;
        break;
    }
    case CMD_TURN_LEFT: {
        instance.direction += 10;
        break;
    }
}
*/

#define server_player_connect
// log("Client connect " + string(new_socket) + " type " + ip);

var spawn_x = random_range(0, room_width);
var spawn_y = random_range(0, room_height);
var ship = instance_create(spawn_x, spawn_y, obj_ship);
ship.socket = ds_map_find_value(async_load, "socket");
ship.ip = ds_map_find_value(async_load, "ip");
ship.player_id = global.next_player_id;
ds_map_add(global.ships, global.next_player_id, ship);

//send_player_init(global.next_player_id, spawn_x, spawn_y, new_socket);
//send_player_join(global.next_player_id, spawn_x, spawn_y);

// ds_map_add(global.clients, new_socket, global.next_player_id);

global.next_player_id += 1;


#define server_player_disconnect
var socket = ds_map_find_value(async_load, "socket");
log("Client disconnect " + string(socket));
// @todo fix me
var client_ship = ds_map_find_value(global.clients, socket);
with (client_ship) {
    instance_destroy();
}
ds_map_delete(global.clients, socket);


#define send_player_join
// argument0: player id
// argument1: spawn x
// argument2: spawn y

log("Join " + string(argument0) + " at " + string(argument1) + "," + string(argument2));

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_JOIN);
buffer_write(global.server_buffer, buffer_s32, global.next_player_id);
buffer_write(global.server_buffer, buffer_f32, argument1);
buffer_write(global.server_buffer, buffer_f32, argument2);

broadcast_buffer(global.server_buffer, argument0);


#define send_player_init
// argument0: player id
// argument1: spawn x
// argument2: spawn y
// argument3: client socket

log("Init " + string(argument0) + " at " + string(argument1) + "," + string(argument2));

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_INIT);
buffer_write(global.server_buffer, buffer_s32, argument0);
buffer_write(global.server_buffer, buffer_f32, argument1);
buffer_write(global.server_buffer, buffer_f32, argument2);
network_send_packet(argument3, global.server_buffer, buffer_tell(global.server_buffer));
   
// Send all existing players to new client
if (global.host && global.player != noone) {
    log("Sending host player " + string(global.player_id) + " " + string(global.player) + " join to " + string(argument0) + " " + string(global.player.x) + "," + string(global.player.y));
    buffer_seek(global.server_buffer, buffer_seek_start, 0);
    buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_JOIN);
    buffer_write(global.server_buffer, buffer_s32, global.player_id);
    buffer_write(global.server_buffer, buffer_f32, global.player.x);
    buffer_write(global.server_buffer, buffer_f32, global.player.y);
    network_send_packet(argument3, global.server_buffer, buffer_tell(global.server_buffer));
    
    var player_id = ds_map_find_first(global.network_players);
    for (var i = 0; i < ds_map_size(global.network_players); i++) {
        var network_player = ds_map_find_value(global.network_players, player_id);
        
        log("Sending network player " + string(player_id) + " " + string(network_player) + " join to " + string(argument0) + " " + string(network_player.x) + "," + string(network_player.y));
        
        buffer_seek(global.server_buffer, buffer_seek_start, 0);
        buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_JOIN);
        buffer_write(global.server_buffer, buffer_s32, player_id);
        buffer_write(global.server_buffer, buffer_f32, network_player.x);
        buffer_write(global.server_buffer, buffer_f32, network_player.y);
        network_send_packet(argument3, global.server_buffer, buffer_tell(global.server_buffer));
        
        player_id = ds_map_find_next(global.network_players, player_id);
    }
}

