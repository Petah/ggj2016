// arg1 = x
// arg2 = y

var mine_particle = part_type_create();
part_type_sprite(mine_particle, spr_particle_green, false, false, false);
part_type_life(mine_particle, room_speed * 0.25, room_speed * .55);
part_type_speed(mine_particle, 2, 5, -0.175,0);
part_type_direction(mine_particle,0,360,0,0)

part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0, argument0 , argument1, argument1, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);

part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 -room_width, argument0 -room_width , argument1, argument1, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 +room_width, argument0 +room_width, argument1, argument1, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0, argument0 , argument1 -room_height, argument1-room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0, argument0 , argument1 +room_height, argument1 +room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);

part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 -room_width, argument0 -room_width, argument1 -room_height, argument1 -room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 -room_width, argument0 -room_width, argument1 +room_height, argument1 +room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 +room_width, argument0 +room_width, argument1 -room_height, argument1 -room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 +room_width, argument0 +room_width, argument1 +room_height, argument1 +room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, mine_particle, 15);

