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
var socket = ds_map_find_value(async_load, "id");
var command = buffer_read(buffer, buffer_s32);

switch (command) {
    case CMD_DRAW: {
        // @todo ds_list_destory
        ds_list_clear(global.sprites);
        
        var ship_count = buffer_read(buffer, buffer_u8);
        for (i = 0; i < ship_count; i++) {
            var ship_id = buffer_read(buffer, buffer_s32);
            var score_array = ds_list_create();
            ds_list_add(score_array, buffer_read(buffer, buffer_u16));
            ds_list_add(score_array, buffer_read(buffer, buffer_string));
            ds_list_add(score_array, make_colour_rgb(buffer_read(buffer, buffer_u8), buffer_read(buffer, buffer_u8), buffer_read(buffer, buffer_u8)));
            
            ds_map_replace(obj_hud.ship_scores, ship_id, score_array);
        }
        
        var view_x = buffer_read(buffer, buffer_f32);
        var view_y = buffer_read(buffer, buffer_f32);
        
        view_xview[0] = view_x - (view_wview[0] / 2);
        view_yview[0] = view_y - (view_hview[0] / 2);
        
        var sprite_count = buffer_read(buffer, buffer_s32);
        // log("Draw frame " + string(sprite_count) + " sprites " + string(view_x) + "," + string(view_y));
        var i;
        for (i = 0; i < sprite_count; i++) {
            var data_array = ds_list_create();
            data_array[0] = buffer_read(buffer, buffer_s32); // sprite_index
            data_array[1] = buffer_read(buffer, buffer_f32); // x
            data_array[2] = buffer_read(buffer, buffer_f32); // y
            data_array[3] = buffer_read(buffer, buffer_f32); // image_angle
            data_array[4] = buffer_read(buffer, buffer_s32); // image_index
            // log("Store sprite " + string(data_array[0]) + " " + string(data_array[1]) + "," + string(data_array[2]) + " " + string(data_array[3]));
            ds_list_add(global.sprites, data_array);
        }
        
        obj_hud.ship_hp = buffer_read(buffer, buffer_f32);
        obj_hud.ship_max_hp = buffer_read(buffer, buffer_f32);
        log("HP " + string(obj_hud.ship_hp) + "/" + string(obj_hud.ship_max_hp));
        
        // Remove old sprites
        /*
        for (var j = ds_list_size(global.sprites) - 1;j >= i; j--) {
            ds_list_delete(global.sprites, j);
        }
        */
        break;
    }
    case CMD_PART_CREATE: {
        var part_type = buffer_read(buffer, buffer_s32);
        var part_x = buffer_read(buffer, buffer_f32);
        var part_y = buffer_read(buffer, buffer_f32);
        particle_create_wrap(part_x, part_y, part_type);
        break;
    }
    case CMD_PART_BURST: {
        log("CMD_PART_BURST");
        var part_type = buffer_read(buffer, buffer_s32);
        var part_x = buffer_read(buffer, buffer_f32);
        var part_y = buffer_read(buffer, buffer_f32);
        particle_burst_wrap(part_x, part_y, part_type);
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


#define server_player_connect
//var spawn_x = random_range(0, 500);
//var spawn_y = random_range(0, 500);
var spawn_x = random_range(0, room_width);
var spawn_y = random_range(0, room_height);
var ship;

if (global.next_player_id == global.host_player_id) {
    ship = instance_create(spawn_x, spawn_y, obj_player);
    global.ship_id = ship.id;
    log("Created player " + string(ship));
} else {
    ship = instance_create(spawn_x, spawn_y, obj_network_player);
    log("Created networked player " + string(ship));
}

//var ship = instance_create(spawn_x, spawn_y, obj_ship);
ship.socket = ds_map_find_value(async_load, "socket");
ship.ip = ds_map_find_value(async_load, "ip");
ship.player_id = global.next_player_id;
ship.ship_name = get_name();
ds_map_add(global.ships, ship.socket, ship);

log("Client connect " + string(ship) + " " + string(ship.player_id) + " " + string(ship.ip) + " " + string(ship.x) + "," + string(ship.y));

global.next_player_id += 1;


#define server_player_disconnect
var socket = ds_map_find_value(async_load, "socket");
log("Client disconnect " + string(socket));
// @todo fixme