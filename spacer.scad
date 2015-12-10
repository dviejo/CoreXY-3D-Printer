/**
 * separador.scad
 * 
 * Created by Diego Viejo
 * 24/Nov/2015
 * 
 */

*for(i=[0:1]) translate([i*20, 0, 0])
    spacer();
*for(i=[0:1]) translate([i*20, 20, 0])
    spacer(id=3);

spacer2();    

module spacer(od=16, id=4, height=11.6)
{
    difference()
    {
        cylinder(d=od, h=height);
        translate([0, 0, -1]) cylinder(d=id*1.15, h=height+2, $fn=25);
    }
}

length = 23;

module spacer2()
difference()
{
    union()
    {
        //cube([length,10, 6]);
        hull()
        {
            for(i=[-1,1])
            {
                translate([length/2+i*8, 5, 0]) cylinder(d=8.2, h=6, $fn=20);                
            }
        }
        translate([length/2, 5, 0]) cylinder(d=6.2, h=11.6, $fn=20);
        translate([length/2, 5, 0]) cylinder(d=10.6, h=10.6, $fn=25);
    }
    
    for(i=[-1,1])
    {
        translate([length/2+i*8, 5, -1]) cylinder(d=3.3, h=6+2, $fn=20);
        translate([length/2+i*8, 5, 6-3]) cylinder(d=6.4, h=4, $fn=6);
    }
        
    translate([length/2, 5, -1]) cylinder(d=8.6, h=8, $fn=6);
    translate([length/2, 5, 7+0.3]) cylinder(d=4, h=10, $fn=20);
}