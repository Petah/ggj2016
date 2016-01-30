var ip;
var port = 6510;

audio_falloff_set_model(audio_falloff_inverse_distance_clamped);

global.server = noone;
global.player_id = noone;
global.player = noone;
global.host_player_id = 1000; 
global.next_player_id = 1000; 
global.network_players = ds_map_create();

global.sprites = ds_list_create();

if (global.host) {
    log('Starting server on ' + string(port));
    global.server = network_create_server(network_socket_tcp, port, 32);
    ip = '127.0.0.1';
    global.server_buffer = buffer_create(256, buffer_grow, 1);
    global.ships = ds_map_create();
} else {
    ip = '10.50.19.239';
    instance_create(0, 0, obj_client);
}

// log('Connecting to server ' + string(ip) + ':' + string(port));
global.client = network_create_socket(network_socket_tcp);
network_connect(global.client, ip, port);

global.client_buffer = buffer_create(256, buffer_grow, 1);

for (var i = 0; i < 40; i++) {
    instance_create(random_range(0, room_width), random_range(0, room_height), obj_asteroid);
}
alarm[0] = room_speed * 3;

