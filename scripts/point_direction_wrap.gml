var _xval, _yval;
_xval = argument2-argument0;
if abs((argument2+room_width)-argument0)
 < abs(_xval) {
        _xval = (argument2+room_width)-argument0;
}
if abs((argument2-room_width)-argument0)
 < abs(_xval) {
        _xval = (argument2-room_width)-argument0;
}

_yval = argument3-argument1;
if abs((argument3+room_height)-argument1)
 < abs(_yval) {
        _yval = (argument3+room_height)-argument1;
}
if abs((argument3-room_height)-argument1)
 < abs(_yval) {
        _yval = (argument3-room_height)-argument1;
}

return (180-radtodeg(arctan2(-_yval, -_xval))) mod 360;
