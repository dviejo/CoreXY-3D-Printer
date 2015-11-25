/*
 * pulleyHolder.scad
 * 
 * Created by Diego Viejo
 * 25/Nov/2015
 * 
 */

holderWidth = 60;
holderLength = 40;
holderHeight = 40;

pulleyDiam = 12.2;
beltWidth = 0.7;

module pulleyHolder(h = holderHeight)
translate([0, -holderLength, 0])
difference()
{
    union()
    {
        cube([holderWidth, holderLength, h]);
        translate([0, holderLength-5, 20.15]) cube([holderWidth, 20+5, 5]);
    }
    
    //cutout
    translate([-1, holderLength-5, -1]) rotate([45,0,0]) 
        translate([0, -holderLength, 0])
            cube([holderWidth+2, holderLength+2, holderHeight*2]);
    translate([5, -5, -5]) cube([holderWidth, holderLength, holderHeight]);
    
    //attaching holes
    translate([holderWidth-10, -1, 20/2]) rotate([-90,0 ,0])
        cylinder(d=5.5, h=holderLength+2);
    translate([20+7, -1, 20/2]) rotate([-90,0 ,0])
        cylinder(d=5.5, h=holderLength+2);
    translate([holderWidth-10, holderLength+20/2, -1]) 
        cylinder(d=5.5, h=holderHeight+2);
    translate([20+7, holderLength+20/2, -1])
        cylinder(d=5.5, h=holderHeight+2);
        
    //pulleys' hole
    #translate([10, holderLength-30, 20]) 
        cylinder(d=3.75, h=holderHeight);
    #translate([10+pulleyDiam+beltWidth, holderLength-20+pulleyDiam, 20]) 
        cylinder(d=3.75, h=holderHeight);
    translate([10, holderLength-30, holderHeight-8.5]) 
        cylinder(d=8.4, h=5, $fn=6);
    translate([10+pulleyDiam+beltWidth, holderLength-20+pulleyDiam, holderHeight-15]) 
        cylinder(d=8.4, h=15-3.5, $fn=6);
}
