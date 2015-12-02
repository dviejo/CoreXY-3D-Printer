/**
 * washer.scad
 * 
 * Created by Diego Viejo
 * 
 * 02/Dec/2015
 * 
 */

innerDiam = 4.15;
outerDiam = 6;
washerHeight = 0.5;

module washer(height = washerHeight)
difference()
{
    cylinder(d=outerDiam, h=height, $fn=25);
    translate([0, 0, -1]) cylinder(d=innerDiam, h=height+2, $fn=25);
}

for(i=[-1:1])
    translate([i*(outerDiam+1.5), 0, 0])
        washer();