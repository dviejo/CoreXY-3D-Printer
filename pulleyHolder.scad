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

//uncomment for printing
//translate([-2,0,0]) rotate([0, -90, 0]) pulleyHolder(h=20+12.65+6+0.5);
//translate([2,0,0]) rotate([0, 90, 0]) mirror([1,0,0]) pulleyHolder(h=20+12.65+6+0.5);

module pulleyHolder(h = holderHeight)
translate([0, -holderLength, 0])
difference()
{
    union()
    {
        cube([holderWidth, holderLength, h]);
        translate([0, holderLength-5, 20.15]) cube([holderWidth, 20+5, 5]);
        translate([0, holderLength, 20.15]) cube([20,20, h-20.15]);
    }
    
    //cutout
    translate([-1, holderLength-5, -1]) rotate([45,0,0]) 
        translate([0, -holderLength, 0])
            cube([holderWidth+2, holderLength+2, holderHeight*2]);
    translate([5, -5, -5]) cube([holderWidth, holderLength, holderHeight]);
        translate([-1, holderLength-1, h+1+6])rotate([-45, 0, 0]) cube([22,30, h-20.15]);
    
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
    translate([10, holderLength-28, 20]) 
        cylinder(d=3.75, h=holderHeight);
    translate([10+pulleyDiam+beltWidth, holderLength-28+pulleyDiam, 20]) 
        cylinder(d=3.75, h=holderHeight);
    translate([10, holderLength-28, holderHeight-8.5]) 
        cylinder(d=8.4, h=5, $fn=6);
    translate([10+pulleyDiam+beltWidth, holderLength-28+pulleyDiam, holderHeight-15]) 
        cylinder(d=8.4, h=15-3.5, $fn=6);
        
    //spacer holes
    translate([10, holderLength-28, h-6]) rotate(90)
    {
        translate([8, 0, 0]) cylinder(d=3.3, h=20, $fn=20);
        translate([-8, 0, 0]) cylinder(d=3.3, h=20, $fn=20);
    }
    translate([10+pulleyDiam+beltWidth, holderLength-29+pulleyDiam, h-6]) rotate(90)
    {
        translate([8, 0, 0]) cylinder(d=3.3, h=20, $fn=20);
        translate([-8, 0, 0]) cylinder(d=3.3, h=20, $fn=20);
    }
}
