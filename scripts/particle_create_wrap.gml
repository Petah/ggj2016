//arg0 = origin x
//arg1 = origin y
//arg2 = particleType

// original location
part_particles_create(global.particle_system, argument0, argument1, argument2, 1);
// horizontal and vertical wrap
part_particles_create(global.particle_system, argument0 - room_width, argument1, argument2, 1);
part_particles_create(global.particle_system, argument0 + room_width, argument1, argument2, 1);
part_particles_create(global.particle_system, argument0, argument1 - room_height, argument2, 1);
part_particles_create(global.particle_system, argument0, argument1 + room_height, argument2, 1);
// diagonal wrap
part_particles_create(global.particle_system, argument0 - room_width, argument1 - room_height, argument2, 1);
part_particles_create(global.particle_system, argument0 - room_width, argument1 + room_height, argument2, 1);
part_particles_create(global.particle_system, argument0 + room_width, argument1 - room_height, argument2, 1);
part_particles_create(global.particle_system, argument0 + room_width, argument1 + room_height, argument2, 1);

