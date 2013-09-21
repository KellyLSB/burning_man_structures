foot   = 12; // Inches
height = 8 * foot; // Feet
square = 20 * foot; // Feet

module 2_by_4(length, axis = "z") {
	if(axis == "x") cube([length - .1, 2 - .1, 4 - .1]) child(0);
	if(axis == "y") cube([2 - .1, length - .1, 4 - .1]) child(0);
	if(axis == "z") cube([2 - .1, 4 - .1, length - .1]) child(0);
}

module two_by_four(translation, length, rot = [0, 0, 0], mir = [0, 0, 0]) {
	second = [translation[0] - 2, translation[1], translation[2]];

	mirror(mir) rotate(rot) {
		translate(translation) 2_by_4(length) child(0);
		translate(second) 2_by_4(length) child(0);
	}
}

// Corner Supports
two_by_four([square / 2, square / 2, 0], height); // NorthEast
two_by_four([square / 2, -square / 2, 0], height); // SouthEast
two_by_four([-square / 2, -square / 2, 0], height); // SouthWest
two_by_four([-square / 2, square / 2, 0], height); // North West

// Center Supports
two_by_four([square / 2 + 2, -2, 0], height, [0,0,90]); // North
two_by_four([-square / 2 + 2, -2, 0], height, [0,0,90]); // South
two_by_four([square / 2, -2, 0], height); // East
two_by_four([-square / 2, -2, 0], height); // West
//two_by_four([0, -2, 0], height); // Center Post

// Cross Beams
cross_beam_length = floor(sqrt(pow(square, 2) + pow(height, 2)));
cross_beam_angle = atan(height / square);

// Side 1
translate([-square/2 + 2, -square/2 - 1, 0])
	mirror([0, 1, -1])
	rotate([-cross_beam_angle + 3, 0, 0])
	2_by_4(cross_beam_length);
translate([-square/2 - 4, square/2 + 6, 3])
	mirror([0, 1, 1])
	rotate([cross_beam_angle - 3, 0, 0])
	2_by_4(cross_beam_length);

// Side 2
translate([square/2 - 4, -square/2 - 1, 0])
	mirror([0, 1, -1])
	rotate([-cross_beam_angle + 3, 0, 0])
	2_by_4(cross_beam_length);
translate([square/2 + 2, square/2 + 6, 3])
	mirror([0, 1, 1])
	rotate([cross_beam_angle - 3, 0, 0])
	2_by_4(cross_beam_length);

// Inner Beams
long_inner_beam = square + 4;
short_inner_beam = square - 12;

for(i = [1:2]) { // West Inner Double Beam
	translate([-square / 2 + (2 * i), -square / 2, height - 4])
	color("Red")
	2_by_4(long_inner_beam, "y");
}

for(i = [1:2]) { // East Inner Double Beam
	translate([square / 2 - 2 - (i * 2), -square / 2, height - 4])
	color("Red")
	2_by_4(long_inner_beam, "y");
}

for(i = [1:2]) { // North Inner Double Beam
	translate([-square / 2 + 6, square / 2 - (i * 2), height - 4])
	color("Green")
	2_by_4(short_inner_beam, "x");
}

for(i = [1:2]) { // South Inner Double Beam
	translate([-square / 2 + 6, -square / 2 + 2 + (i * 2), height - 4])
	color("Green")
	2_by_4(short_inner_beam, "x");
}

// Outer Beams
long_outer_beam = square + 8;
short_outer_beam = square + 4;

// West Outer Single Beam
translate([-square / 2 - 4, -square / 2 - 2, height - 4])
color("Purple")
2_by_4(long_outer_beam, "y");

// East Outer Single Beam
translate([square/2 + 2, -square/2 - 2, height - 4])
color("Purple")
2_by_4(long_outer_beam, "y");

// North Outer Single Beam
translate([-square/2 - 2, square/2 + 4, height - 4])
color("Blue")
2_by_4(short_outer_beam, "x");

// South Outer Single Beam
translate([-square/2 - 2, -square/2 - 2, height - 4])
color("Blue")
2_by_4(short_outer_beam, "x");


// Side 3 / 4 Angled Reinforcements
//reinforcement_length = floor(sqrt(pow(square / 4, 2) + pow(height / 2, 2)));
//reinforcement_angle = atan((square / 4) / (height / 2));

//translate([-square / 2 - 2, -square/2 - 2, height - (height / 2)])
//	mirror([0, 0, 0])
//	rotate([reinforcement_angle, 0, 90])
//	cube([2, 4, reinforcement_length]);
