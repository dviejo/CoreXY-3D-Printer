/**
 * montaje.scad
 * 
 * Created by Diego Viejo 
 * 18/Nov/2015
 * 
 * License: GNU GPL
 * 
 */

include <MCAD/stepper.scad>
include <pulleyHolder.scad>

//free pulley measurements
pulleyDiam = 12.2;
pulleyHoleDiam = 4;
pulleyHeight = 11.6;

beltWidth = 0.7;

//shaft guide measurements
shaftLength = 400;
shaftWidth = 11.3;
shaftHeight = 7.6;
guideLength = 48;
guideWidth = 27;
guideHeight = 12.65;

//aluminium shaft measurements
aluLength = 400;
aluHeight = 20;
aluWidth = 20;

//aluminum sheet
sheetLength = 90;
sheetWidth = 45;
sheetHeight = 6;

motorOffset = -20;
washerHeight = 0.5;

heightBelt1 = aluHeight+guideHeight+sheetHeight+washerHeight;
heightBelt2 = heightBelt1+pulleyHeight;

structureLenght = aluLength; //Y axis
structureWidth = aluLength;  //X axis

//pulleys placement
for(i=[-1,1])
{
    color("red")
    translate([(structureWidth-motorOffset)/2, i*(structureLenght/2+20+30), heightBelt1])
        pulley();
    color("blue")
    translate([-(structureWidth-motorOffset)/2, i*(structureLenght/2+20+30), heightBelt2])
        pulley();
}

color("red")
{
    translate([-(structureWidth-motorOffset)/2+pulleyDiam+beltWidth, -(structureLenght/2+20+20+9)+pulleyDiam, heightBelt1])
        pulley();
    translate([-(structureWidth-motorOffset)/2+pulleyDiam+beltWidth, -14.5, heightBelt1])
        pulley();
    translate([(structureWidth-motorOffset)/2-pulleyDiam-beltWidth, 14.5, heightBelt1])
        pulley();
}

color("blue")
{
    translate([(structureWidth-motorOffset)/2-pulleyDiam-beltWidth, -(structureLenght/2+20+20+9)+pulleyDiam, heightBelt2])
        pulley();
    translate([(structureWidth-motorOffset)/2-pulleyDiam-beltWidth, -14.5, heightBelt2])
        pulley();
    translate([-(structureWidth-motorOffset)/2+pulleyDiam+beltWidth, 14.5, heightBelt2])
        pulley();
}


//Motors
translate([(structureWidth-motorOffset)/2, (structureLenght/2+20+30), heightBelt1])
    rotate([180,0,0]) motor(Nema17);
translate([-(structureWidth-motorOffset)/2, (structureLenght/2+20+30), heightBelt1])
    rotate([180,0,0]) motor(Nema17);

//structure
color("black")
for(i=[1,-1]) for(j=[1,-1])
translate([i*(structureWidth+20)/2, j*(structureLenght+20)/2, 10])
    cube(20, center=true);
    
color("silver")
for(i=[-1,1])
{
    translate([0, i*(structureLenght+20)/2, aluHeight/2])
        aluAxle();
    translate([i*(structureWidth+20)/2, 0, aluHeight/2])
        rotate(90) aluAxle();
}


for(i=[-1,1])
{
    translate([i*(structureWidth+20)/2, 0, aluHeight])
        shaftAxle();
    translate([i*(structureWidth)/2, 10, aluHeight+guideHeight+sheetHeight/2])
        aluSheet();
}

translate([0, 0, 20+guideHeight+6+shaftHeight]) rotate(90) mirror([0, 0, 1]) shaftAxle();
translate([0, 0, aluHeight+guideHeight+sheetHeight/2])
        aluSheet();

        
translate([-aluLength/2-20, -aluLength/2-20, 0]) 
    pulleyHolder(h=heightBelt1);
translate([aluLength/2+20, -aluLength/2-20, 0]) 
    mirror([1,0,0]) pulleyHolder(h=heightBelt1);

module aluAxle(length = aluLength, width = 20)
{
    steps = floor(width/aluWidth);
    color("silver")
    difference()
    {
        cube([length, width, aluHeight], center = true);
    
        for(i=[-1,1])
        {
            translate([-1, i*(width)/2, 0])
                cube([length+2, 10+1, 5], center=true);
            for(j=[ceil(-steps/2):floor(steps/2)])
                translate([-1, j*aluWidth, i*(aluHeight-10)])
                    cube([length+2, 5, 10+1], center=true);
        }
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
            cylinder(d=16.05, h=1);
            translate([0, 0, pulleyHeight-1]) cylinder(d=pulleyDiam+3, h=1);
        }
        translate([0, 0, -1]) cylinder(d=pulleyHoleDiam, h=pulleyHeight+2);
    }
}

module aluSheet()
color("silver")
difference()
{
    cube([sheetWidth, sheetLength, sheetHeight], center = true);
}
