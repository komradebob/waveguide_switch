
//////////////////////////////////////////////////////////
//							//
// WR42 Waveguide Switch				//
//							//
// 29 May, 2017	rmb	Created				//
//							//
//////////////////////////////////////////////////////////

//
// This is a first slice at a WR42 waveguide switch. It 
// is the mechanical bits only. To make electronic, it 
// will have to be connected to a solenoid or servo.
//
// All three components, the switch body, the switch core, 
// and the top are in this one file. You probably want to 
// CNC each part individually. Comment out the other two
// and remove the translates from the bottom of the file.
//


$fn=150;			// Variables and the like

wgw=10.668;			// Wavguide Width
wgh=4.318;			// Waveguide height
rc=25.6;			// Bend radius
swx=rc+wgw;			// Size of the main switch body
swh=wgw+5;			// Height of the main switch body
ro=rc+(.5*wgh);			// Outer bend radius
ri=rc-(.5*wgh);			// Inner bend radius
outerr=1.5*25.6;		//
extra=0.01;			// just a >.< more. Makes openSCAD behave a bit better.
axle=26.6/16;			// Axle diameter - 1/8"
size6=.1065*25.6/2;		// Size of hole to drill for #6 screw tap
clear6=0.1440*25.6/2;		// Radius of clearance hole for #6 screw
clear8=0.1695*25.6/2;		// Radius of clearance hole for #8 screw
size8=.1360*25.6/2;		// Size of hole to drill for #8 screw tap
base=5;				// base thickness
top_thick=.25*25.6;		// top thickness 0.25"
flange_hole_depth=.25*25.6;	// depth to drill holes for flanges

//rc=rc+extra;


module circleguide(xo,yo,zo){	// A 360 waveguide bend to remove from the switch core.
	translate([xo,yo,zo]){
		difference(){
			cylinder(wgw,ro,ro,true);
			cylinder(wgw+extra,ri,ri,true);
		}
	}
}

module switch_body(){		// The main body of the switch. Block with a cylindrical hole 
				// in the center and waveguide sized holes in the sides.

	difference(){
		translate([0,0,-base]){				// The main block offset to account for the base.
			cube([2*rc+wgw,2*rc+wgw,wgw+2*base],true);
		}
		cylinder(wgh+10+0.3*extra,rc,rc,true);		// remove the cylindrical core
		cube([wgh,100,wgw],true);			// remove x waveguide exit
		cube([100,wgh,wgw],true);			// remove y waveguide exit
		cylinder(50,axle,axle,true);			// axle
		translate([rc,rc,0])				// corner hole
			cylinder(50,size6,size6,true);
		translate([-rc,rc,0])				// corner hole
			cylinder(50,size6,size6,true);
		translate([rc,-rc,0])				// corner hole
			cylinder(50,size6,size6,true);
		translate([-rc,-rc,0])				// corner hole
			cylinder(50,size6,size6,true);
		translate([rc/2,-rc/2,0])			//index hole for screw/spring/ball bearing
			cylinder(100,size6,size6,true);

									// flange holes
		rotate([90,0,0])
			translate([8.51,-8.13,-rc-.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
		rotate([90,0,0])
			translate([8.51,-8.13,rc+.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
		rotate([90,0,0])
			translate([-8.51,-8.13,-rc-.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
		rotate([90,0,0])
			translate([-8.51,-8.13,rc+.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
		rotate([90,0,90])
			translate([8.51,-8.13,-rc-.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
		rotate([90,0,90])
			translate([8.51,-8.13,rc+.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
		rotate([90,0,90])
			translate([-8.51,-8.13,-rc-.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
		rotate([90,0,90])
			translate([-8.51,-8.13,rc+.5*wgw])
				cylinder(flange_hole_depth,size6,size6,true);
	}
}

module switch_core(){						// The cylindrical core of the switch
	difference(){
		translate([0,0,-base-extra+0.5*base]){
		cylinder(wgw+base+extra,rc,rc,true);		// core of the switch
		}
		circleguide(rc,rc,0);				// waveguide path 1
		circleguide(-rc,-rc,0);				// waveguide path 2
		cylinder(100,axle,axle,true);

		rotate([90,0,45])				// hole for grub screw
			translate([0,0,rc/2])
				cylinder(rc+extra,size8,size8,true);
		translate([rc/2,-rc/2,-wgw/2-base])			//index indent.
			cylinder(flange_hole_depth,size6/2,size6/2,true);
		translate([rc/2,rc/2,-wgw/2-base])			//index indent.
			cylinder(flange_hole_depth,size6/2,size6/2,true);
	}


}

module switch_top(){						// Plate at the top

difference(){
	translate([0,0,top_thick/2+wgw/2]) {
		difference(){
			cube([2*rc+wgw,2*rc+wgw,top_thick],true);
			cylinder(50,axle,axle,true);		// axle
			translate([rc,rc,0])				// corner hole
				cylinder(50,clear6,clear6,true);	// Use clear6 because screw passes through plate.
			translate([-rc,rc,0])				// corner hole
				cylinder(50,clear6,clear6,true);
			translate([rc,-rc,0])				// corner hole
				cylinder(50,clear6,clear6,true);
			translate([-rc,-rc,0])				// corner hole
				cylinder(50,clear6,clear6,true);
		}
	}
										// Flange holes

	rotate([90,0,0])
		translate([8.51,8.13,extra-((2*rc+wgw)/2)+flange_hole_depth/2-2*extra])
			cylinder(flange_hole_depth,size6,size6,true);
	rotate([90,0,0])
		translate([8.51,8.13,((2*rc+wgw)/2)-flange_hole_depth/2+extra])
			cylinder(flange_hole_depth+extra,size6,size6,true);
	rotate([90,0,0])
		translate([-8.51,8.13,-((2*rc+wgw)/2)+flange_hole_depth/2-extra])
			cylinder(flange_hole_depth,size6,size6,true);
	rotate([90,0,0])
		translate([-8.51,8.13,((2*rc+wgw)/2)-flange_hole_depth/2+extra])
			cylinder(flange_hole_depth+extra,size6,size6,true);

	rotate([90,0,90])
		translate([8.51,8.13,extra-((2*rc+wgw)/2)+flange_hole_depth/2-2*extra])
			cylinder(flange_hole_depth,size6,size6,true);
	rotate([90,0,90])
		translate([8.51,8.13,((2*rc+wgw)/2)-flange_hole_depth/2+extra])
			cylinder(flange_hole_depth+extra,size6,size6,true);
	rotate([90,0,90])
		translate([-8.51,8.13,-((2*rc+wgw)/2)+flange_hole_depth/2-extra])
			cylinder(flange_hole_depth,size6,size6,true);
	rotate([90,0,90])
		translate([-8.51,8.13,((2*rc+wgw)/2)-flange_hole_depth/2+extra])
			cylinder(flange_hole_depth+extra,size6,size6,true);
	}
}


//////////////////////////////////////////////////////////
// 							//
//	Put it all together for display purposes	//
//							//
//////////////////////////////////////////////////////////

switch_body();								// body

translate([0,0,40])							// core
	switch_core();

translate([0,0,60])							// top
	switch_top();
