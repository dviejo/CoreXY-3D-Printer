/*
 * clip.scad
 * 
 * created by Diego Viejo
 * 24/Nov/2015
 * 
 * For aligning: the belt passes at 4mm. from the attaching hole.
 * Difference between attaching holes is 18-3.5-3.5 = 11mm.
 */

beltHeight = 10;
diffHeight = 12.65-7.6+1.5;

totalWidth = 18;
totalHeight = 22;

smoothDiam = 10;

//GT2
belt_tooth_distance = 2;
belt_tooth_ratio = 0.675;

clipMain();

translate([30, 0, 0])
clip();

translate([-20, 0, 0])
free();

translate([0, 30, 0])
{
    clipMain(extraHeight=12);

    translate([30, 0, 0])
    clip();
    translate([-20, 0, 0])
    free(extraHeight=12);
}



module free(extraHeight = 0)
difference()
{
    union()
    {
        cube([7, 8, totalHeight+extraHeight]);
        translate([7/2, 8, 0]) scale([7/5, 1, 1]) 
            cylinder(d=5, h=totalHeight+extraHeight);
    }
    
    translate([7/2, 8/2, -1]) 
        cylinder(d=3.3, h=totalHeight+extraHeight+2, $fn=15);
}

module clipMain(extraHeight=0)
difference()
{
    union()
    {
        cube([totalWidth, 10, totalHeight+extraHeight]);
        translate([totalWidth/2, 10, 0]) scale([totalWidth/smoothDiam,1,1])cylinder(d=smoothDiam, h=totalHeight+extraHeight, $fn=25);
    }
    #translate([totalWidth, -10, diffHeight+extraHeight]) cube([2, 30, beltHeight]);
    
    //attaching
    translate([3.5, 3.2, -1]) cylinder(d=3.3, h=totalHeight+extraHeight+2, $fn=15);
    translate([totalWidth-3.5, 3.2, -1]) cylinder(d=3.3, h=totalHeight+extraHeight+2, $fn=15);
    translate([3.5, 3.2, 12]) cylinder(d=6.35, h=totalHeight+2, $fn=26);
    translate([totalWidth-3.5, 3.2, 12]) cylinder(d=6.35, h=totalHeight+2, $fn=26);
    
    //belt grip
    translate([-1, 10-1.5-0.5, diffHeight+extraHeight-1.5-1.5]) rotate([0, 90, 0]) 
        cylinder(d=3.3, h=totalWidth+2, $fn=15);
    translate([-1, 10-1.5-0.5, diffHeight+beltHeight+extraHeight+1.5+1.5]) rotate([0, 90, 0]) 
        cylinder(d=3.3, h=totalWidth+2, $fn=15);
    
    //tension system
    translate([(totalWidth)/2, -1, diffHeight+extraHeight+(beltHeight)/2])
        rotate([-90,0,0]) cylinder(d=3.3, h=10+smoothDiam+1, $fn=25);
    translate([(totalWidth)/2, 10+smoothDiam/2-4, diffHeight+extraHeight+(beltHeight)/2])
        rotate([-90,0,0]) cylinder(d=6.4, h=10+smoothDiam+1, $fn=6);
}

module clip()
difference()
{
    cube([totalHeight, 7, 10]);
    
    translate([diffHeight-1.5-1.5, 7/2, -1]) cylinder(d=3.3, h=10+2, $fn=15);
    translate([diffHeight+beltHeight+1.5+1.5, 7/2, -1]) cylinder(d=3.3, h=10+2, $fn=15);
    
    translate([diffHeight, -1, 10-0.8]) cube([beltHeight, 7+2, 2]);
    for(i=[-5:5])
        translate([diffHeight, i*belt_tooth_distance-1, 10-1.5]) 
            cube([beltHeight, belt_tooth_distance-belt_tooth_ratio, 2.5]); 
    
}