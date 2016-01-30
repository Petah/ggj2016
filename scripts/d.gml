var input, low, high;
input = argument0;
low = argument1;
high = argument2;

input = ( input - low ) mod ( high - low );

if( input > 0 ) return input + low;
else return input + high;

