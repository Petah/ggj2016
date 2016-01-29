#define server_networking
var event_id = ds_map_find_value(async_load, "id");
var type = ds_map_find_value(async_load, "type");

// log("Network event " + string(event_id) + " type " + string(type));

if (global.server == event_id) {
    // log("Server data " + string(event_id));
    switch (type) {
        case network_type_connect: {
            var socket = ds_map_find_value(async_load, "socket");
            var ip = ds_map_find_value(async_load, "ip");
            log("Client connect " + string(socket) + " type " + ip);
            
            player_init(socket, global.next_player_id);
            broadcast_command(CMD_PLAYER_JOIN, global.next_player_id);
            
            var socket = ds_map_find_first(global.clients);
            for (var i = 0; i < ds_map_size(global.clients); i++) {
                var player_id = ds_map_find_value(global.clients, socket);
                server_send_command(CMD_PLAYER_JOIN, socket, player_id);
                socket = ds_map_find_next(global.clients, socket);
            }
            
            ds_map_add(global.clients, socket, global.next_player_id);
            global.next_player_id += 1;
            break;
        }
        case network_type_disconnect: {
            var socket = ds_map_find_value(async_load, "socket");
            log("Client disconnect " + string(socket));
            // @todo fix me
            var client_ship = ds_map_find_value(global.clients, socket);
            with (client_ship) {
                instance_destroy();
            }
            ds_map_delete(global.clients, socket);
            break;
        }
        case network_type_data: {
            log("Data");
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
        log("Client player init " + string(global.player_id));
        var player = instance_create(200, 200, obj_player);
        break;
    }
    case CMD_PLAYER_JOIN: {
        var player_id = buffer_read(buffer, buffer_s32);
        log("New player join " + string(player_id));
        var network_player = instance_create(200, 200, obj_network_player);
        ds_map_add(global.network_players, player_id, network_player);
        break;
    }
    case CMD_SYNC_FRAME: {
        // log("Client sync frame " + string(socket));
        /*
        var ship_count = buffer_read(buffer, buffer_s32);
        
        for (var i = 0; i < ship_count; i++) {
            var ship_x = buffer_read(buffer, buffer_s32);
            var ship_y = buffer_read(buffer, buffer_s32);
            var ship_direction = buffer_read(buffer, buffer_s32);
        }
        */
        break;
    }
    case CMD_ACCELERATE:
    case CMD_BREAK:
    case CMD_TURN_RIGHT:
    case CMD_TURN_LEFT: {
        var player_id = buffer_read(buffer, buffer_s32);
        var network_player = ds_map_find_value(global.network_players, player_id);
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
