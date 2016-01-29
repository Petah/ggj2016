var event_id = ds_map_find_value(async_load, "id");
var type = ds_map_find_value(async_load, "type");
log("Network event " + string(event_id) + " type " + string(type));

if (type == 1) {
    var socket = ds_map_find_value(async_load, "socket");
    var ip = ds_map_find_value(async_load, "ip");
    log("Network socket " + string(socket) + " type " + ip);
    var client_ship = instance_create(0, 0, obj_network_player);
    client_ship.sprite_index = spr_ship_2;
    ds_map_add(clients, socket, client_ship);
} else if (type == 0) {
    var socket = ds_map_find_value(async_load, "socket");
    var client_ship = ds_map_find_value(clients, socket);
    with (client_ship) {
        instance_destroy();
    }
    ds_map_delete(clients, socket);
}

