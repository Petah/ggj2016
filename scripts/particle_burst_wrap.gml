// arg0 = x
// arg1 = y
// arg2 = part type

part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0, argument0, argument1, argument1, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);

part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 - room_width, argument0 - room_width , argument1, argument1, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 + room_width, argument0 + room_width, argument1, argument1, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0, argument0 , argument1 - room_height, argument1 - room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0, argument0 , argument1 + room_height, argument1 + room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);

part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 - room_width, argument0 - room_width, argument1 - room_height, argument1 - room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 - room_width, argument0 - room_width, argument1 + room_height, argument1 + room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 + room_width, argument0 + room_width, argument1 - room_height, argument1 - room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);
part_emitter_region(global.particle_system_explosion, global.burst_emitter, argument0 + room_width, argument0 + room_width, argument1 + room_height, argument1 + room_height, ps_shape_ellipse, ps_distr_linear);
part_emitter_burst(global.particle_system_explosion, global.burst_emitter, argument2, 15);

