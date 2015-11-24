/**
 * separador.scad
 * 
 * Created by Diego Viejo
 * 24/Nov/2015
 * 
 */

for(i=[0:1]) translate([i*20, 0, 0])
    spacer();
for(i=[0:1]) translate([i*20, 20, 0])
    spacer(id=3);

module spacer(od=16, id=4, height=11.6)
{
    difference()
    {
        cylinder(d=od, h=height);
        translate([0, 0, -1]) cylinder(d=id*1.15, h=height+2, $fn=25);
    }
}