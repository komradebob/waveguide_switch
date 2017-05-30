
$fn=150;

wgw=10.668;
wgh=4.318;
rc=25.6;
swx=35;
swh=wgw+5;
ro=rc+(.5*wgh);
ri=rc-(.5*wgh);
outerr=1.5*25.6;
extra=0.01;
axle=26.6/16;
size6=.1065*25.6/2;
size8=.1360*25.6/2;
base=5;
top_thick=.25*25.6;
flange_hole_depth=.25*25.6;

//rc=rc+extra;


module circleguide(xo,yo,zo){
	translate([xo,yo,zo]){
		difference(){
			cylinder(wgw,ro,ro,true);
			cylinder(wgw+extra,ri,ri,true);
		}
	}
}

module switch_body(){

	difference(){
		translate([0,0,-base]){
			cube([2*rc+wgw,2*rc+wgw,wgw+2*base],true);
		}
		cylinder(wgh+10+0.3*extra,rc,rc,true);
		cube([wgh,100,wgw],true);			// x waveguide exit
		cube([100,wgh,wgw],true);			// y waveguide exit
		cylinder(50,axle,axle,true);		// axle
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

module switch_core(){
	difference(){
		translate([0,0,-base-extra+0.5*base]){
		cylinder(wgw+base+extra,rc,rc,true);	// core of the switch
		}
		circleguide(rc,rc,0);				// waveguide path 1
		circleguide(-rc,-rc,0);			// waveguide path 2
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

module switch_top(){

difference(){
	translate([0,0,top_thick/2+wgw/2]) {
		difference(){
			cube([2*rc+wgw,2*rc+wgw,top_thick],true);
			cylinder(50,axle,axle,true);		// axle
			translate([rc,rc,0])				// corner hole
				cylinder(50,size6,size6,true);
			translate([-rc,rc,0])				// corner hole
				cylinder(50,size6,size6,true);
			translate([rc,-rc,0])				// corner hole
				cylinder(50,size6,size6,true);
			translate([-rc,-rc,0])				// corner hole
				cylinder(50,size6,size6,true);
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

switch_body();								// body

translate([0,0,40])							// core
	switch_core();

translate([0,0,60])							// top
	switch_top();


//translate([2.5*rc,2.5*rc,60])
//	cylinder(.25*25.6+wgh+10+extra+20,true);		// axle