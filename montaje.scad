/**
 * montaje.scad
 * 
 * Created by Diego Viejo 
 * 18/Nov/2015
 * 
 * License: GNU GPL
 * 
 */

//free pulley measurements
pulleyDiam = 12;
pulleyHoleDiam = 4;
pulleyHeight = 11.6;

beltWidth = 1.5;

//shaft guide axle measurements
shaftLength = 400;
shaftWidth = 11.3;
shaftHeight = 7.6;
guideLength = 48;
guideWidth = 27;
guideHeight = 12.65;

//aluminium shaft measurements
aluLength = 400;
aluHeight = 20;

//pulleys placement
for(i=[-1,1])
{
    color("red")
    translate([(aluLength+20)/2, i*(aluLength/2+20+20), aluHeight+guideHeight+6])
        pulley();
    color("blue")
    translate([-(aluLength+20)/2, i*(aluLength/2+20+20), aluHeight+guideHeight+6+pulleyHeight])
        pulley();
}

color("red")
{
    translate([-(aluLength+20)/2+pulleyDiam+beltWidth, -(aluLength/2+20+20)+pulleyDiam, aluHeight+guideHeight+6])
        pulley();
    translate([-(aluLength+20)/2+pulleyDiam+beltWidth, -15, aluHeight+guideHeight+6])
        pulley();
    translate([(aluLength+20)/2-pulleyDiam-beltWidth, 15, aluHeight+guideHeight+6])
        pulley();
}

color("blue")
{
    translate([(aluLength+20)/2-pulleyDiam-beltWidth, -(aluLength/2+20+20)+pulleyDiam, aluHeight+guideHeight+6+pulleyHeight])
        pulley();
    translate([(aluLength+20)/2-pulleyDiam-beltWidth, -15, aluHeight+guideHeight+6+pulleyHeight])
        pulley();
    translate([-(aluLength+20)/2+pulleyDiam+beltWidth, 15, aluHeight+guideHeight+6+pulleyHeight])
        pulley();
}


//structure
color("black")
for(i=[1,-1]) for(j=[1,-1])
translate([i*(200+10), j*(200+10), 10])
    cube(20, center=true);
    
color("silver")
for(i=[-1,1])
{
    translate([0, i*(aluLength+20)/2, aluHeight/2])
        aluAxle();
    translate([i*(aluLength+20)/2, 0, aluHeight/2])
        rotate(90) aluAxle();
}


for(i=[-1,1])
    translate([i*(400+20)/2, 0, 20])
        shaftAxle();

translate([0, 0, 20+guideHeight+6]) rotate(90) shaftAxle();



module aluAxle(width = 20)
color("silver")
difference()
{
    cube([aluLength, width, aluHeight], center = true);
    
    for(i=[-1,1])
    {
        translate([-1, i*(width-10), 5/2])
            cube([aluLength+2, 10+1, 5], center=true);
        translate([-1, 0, i*(aluHeight-10)])
            cube([aluLength+2, 5, 10+1], center=true);
    }
}

module shaftAxle()
{
    color("grey")
    translate([0, 0, shaftHeight/2])
        cube([shaftWidth, shaftLength, shaftHeight], center=true);

    color("red")
    translate([0, 0, guideHeight/2])
    difference()
    {
        cube([guideWidth, guideLength, guideHeight], center=true);
        for(i=[1,-1]) for(j=[-1,1])
            translate([i*10, j*10, -1]) 
                cylinder(d=3, h=guideHeight+2);
    }


}

module pulley()
{
    difference()
    {
        union()
        {
            cylinder(d=pulleyDiam, h=pulleyHeight);
            cylinder(d=pulleyDiam+3, h=1);
            translate([0, 0, pulleyHeight-1]) cylinder(d=pulleyDiam+3, h=1);
        }
        translate([0, 0, -1]) cylinder(d=pulleyHoleDiam, h=pulleyHeight+2);
    }
}
