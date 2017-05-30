
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
		translate([0,0,-5]){
			cube([2*rc+wgw,2*rc+wgw,wgw+10],true);
		}
		cylinder(wgh+10+0.3*extra,rc,rc,true);
		cube([wgh,100,wgw],true);			// x waveguide exit
		cube([100,wgh,wgw],true);			// y waveguide exit
		cylinder(50,axle,axle,true);		// axle
		translate([rc,rc,0])				// corner holes
			cylinder(50,size6,size6,true);
		translate([-rc,rc,0])				// corner holes
			cylinder(50,size6,size6,true);
		translate([rc,-rc,0])				// corner holes
			cylinder(50,size6,size6,true);
		translate([-rc,-rc,0])				// corner holes
			cylinder(50,size6,size6,true);
		translate([rc/2,-rc/2,0])			//index hole
			cylinder(100,size6,size6,true);
	}
}

module switch_core(){
	difference(){
		translate([0,0,-wgh+2.5-2*extra]){
		cylinder(wgh+10+extra,rc,rc,true);
		}
		circleguide(rc,rc,0);
		circleguide(-rc,-rc,0);
		cylinder(100,axle,axle,true);
		rotate([90,0,15])
			cylinder(100,size8,size8,true);
		translate([rc/2,-rc/2,0])			//index hole
			cylinder(100,size6/2,size6/2,true);
	}
}

module switch_top(){
	difference(){
		cube([2*rc+wgw,2*rc+wgw,.25*25.6],true);
		cylinder(50,axle,axle,true);		// axle
		translate([rc,rc,0])				// corner holes
			cylinder(50,size6,size6,true);
		translate([-rc,rc,0])				// corner holes
			cylinder(50,size6,size6,true);
		translate([rc,-rc,0])				// corner holes
			cylinder(50,size6,size6,true);
		translate([-rc,-rc,0])				// corner holes
			cylinder(50,size6,size6,true);
	}
}

switch_body();								// body

translate([rc,rc,30])							// core
	switch_core();

translate([2*rc,2*rc,55])							// top
	switch_top();


translate([2.5*rc,2.5*rc,60])
	cylinder(.25*25.6+wgh+10+extra+20,true);		// axle