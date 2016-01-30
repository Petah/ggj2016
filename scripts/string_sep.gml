// string_sep(str,sep,dis)
var str,sep,dis,p;
str=string(argument0)
sep=argument1
dis=argument2
p=string_length(str)-dis+1
 
while (p>1) {
    str=string_insert(sep,str,p)
    p-=dis
}
 
return str
