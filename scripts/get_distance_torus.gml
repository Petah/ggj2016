// get_distance_torus(x1, y1, x2, y2, width, height)
// Returns distance between two points on a 2D torus with size: width x height.
// assumes given points are also within the torus (0 <= x1 & x2 < width) and (0 <= y1 & y2 < height)
xx = abs(argument2 - argument0); xx = min(xx, argument4 - xx);
yy = abs(argument3 - argument1); yy = min(yy, argument5 - yy);
return sqrt(sqr(xx) + sqr(yy));
