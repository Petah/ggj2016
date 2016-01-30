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
var buffer = ds_map_find_value(async_load, "buffer");
var command = buffer_read(buffer, buffer_s32);
var socket = ds_map_find_value(async_load, "id");

switch (command) {
    case CMD_DRAW: {
        // @todo ds_list_destory
        ds_list_clear(global.sprites);
        var sprite_count = buffer_read(buffer, buffer_s32);
        // log("Draw frame " + string(sprite_count) + " sprites");
        var i;
        for (i = 0; i < sprite_count; i++) {
            var data_array = ds_list_create();
            data_array[0] = buffer_read(buffer, buffer_s32); // sprite_index
            data_array[1] = buffer_read(buffer, buffer_f32); // x
            data_array[2] = buffer_read(buffer, buffer_f32); // y
            data_array[3] = buffer_read(buffer, buffer_f32); // image_angle
            // log("Store sprite " + string(data_array[0]) + " " + string(data_array[1]) + "," + string(data_array[2]) + " " + string(data_array[3]));
            ds_list_add(global.sprites, data_array);
        }
        
        view_xview[0] = buffer_read(buffer, buffer_f32) - (view_wview[0] / 2);
        view_yview[0] = buffer_read(buffer, buffer_f32) - (view_hview[0] / 2);
        
        // Remove old sprites
        /*
        for (var j = ds_list_size(global.sprites) - 1;j >= i; j--) {
            ds_list_delete(global.sprites, j);
        }
        */
        break;
    }
    default: {
        log("Client unknown command " + string(command));
        break;
    }
}


#define server_data
var buffer = ds_map_find_value(async_load, "buffer");
var socket = ds_map_find_value(async_load, "id");
var command = buffer_read(buffer, buffer_s32);
var ship = ds_map_find_value(global.ships, socket);
// log("Server command " + string(command) + " " + string(ship));
process_command(command, ship);
// broadcast_command(command, player_id);

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
var spawn_x = random_range(0, 500);
var spawn_y = random_range(0, 500);
// var spawn_x = random_range(0, room_width);
// var spawn_y = random_range(0, room_height);
var ship;

if (global.next_player_id == global.host_player_id) {
    ship = instance_create(spawn_x, spawn_y, obj_player);
    log("Created player " + string(ship));
} else {
    ship = instance_create(spawn_x, spawn_y, obj_network_player);
    log("Created networked player " + string(ship));
}

//var ship = instance_create(spawn_x, spawn_y, obj_ship);
ship.socket = ds_map_find_value(async_load, "socket");
ship.ip = ds_map_find_value(async_load, "ip");
ship.player_id = global.next_player_id;
ds_map_add(global.ships, ship.socket, ship);

log("Client connect " + string(ship) + " " + string(ship.player_id) + " " + string(ship.ip) + " " + string(ship.x) + "," + string(ship.y));

global.next_player_id += 1;


#define server_player_disconnect
var socket = ds_map_find_value(async_load, "socket");
log("Client disconnect " + string(socket));
// @todo fixme
