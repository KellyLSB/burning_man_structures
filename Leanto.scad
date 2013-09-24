foot   = 12; // Inches
height = 8 * foot; // Feet
center_height = height * 2; // Feet
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
two_by_four([square / 2, square / 2, 0], center_height); // NorthEast
two_by_four([-square / 2, square / 2, 0], center_height); // North West
two_by_four([square / 2, -square / 2, 0], height + (1 * foot)); // SouthEast
two_by_four([-square / 2, -square / 2, 0], height + (1 * foot)); // SouthWest

// Center Supports
two_by_four([0, -2, 0], center_height); // Center Post
two_by_four([square / 2, -2, 0], center_height); // East
two_by_four([-square / 2, -2, 0], center_height); // West
two_by_four([square / 2 + 2, -2, 0], center_height, [0,0,90]); // North
two_by_four([-square / 2 + 2, -2, 0], height + (1 * foot), [0,0,90]); // South

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
//translate([-square/2 - 2, -square/2 - 2, height - 4])
//color("Blue")
//2_by_4(short_outer_beam, "x");

//
//
// Vestibule
//
//

vestibule_width = square / 2 + (2 * foot);
vestibule_support_beam_length = floor(sqrt(pow(square / 2 + vestibule_width, 2) + pow(center_height, 2)));
vestibule_support_beam_angle = asin(center_height / vestibule_support_beam_length) - 1;

// West Center Support Beam
translate([2, -square / 2 - vestibule_width,0])
rotate([vestibule_support_beam_angle, 0, 0])
color("Orange")
2_by_4(vestibule_support_beam_length, "y");

// East Center Support Beam
translate([-4, -square / 2 - vestibule_width,0])
rotate([vestibule_support_beam_angle, 0, 0])
color("Orange")
2_by_4(vestibule_support_beam_length, "y");

// West Support Beam
translate([-square / 2 + 2, -square / 2 - vestibule_width,0])
rotate([vestibule_support_beam_angle, 0, 0])
color("Orange")
2_by_4(vestibule_support_beam_length, "y");

// East Support Beam
translate([square / 2 - 4, -square / 2 - vestibule_width,0])
rotate([vestibule_support_beam_angle, 0, 0])
color("Orange")
2_by_4(vestibule_support_beam_length, "y");


//
//
// Roof
//
//

// Center Y-Axis Roof Supports
translate([-4, 0, center_height - 10])
color("Orange")
2_by_4(square / 2 + 4, "y");

translate([2, 0, center_height - 10])
color("Orange")
2_by_4(square / 2 + 4, "y");

// West Y-Axis Roof Supports
translate([-square / 2 + 2, 0, center_height - 10])
color("Orange")
2_by_4(square / 2 + 4, "y");

translate([-square / 2 - 4, 0, center_height - 10])
color("Orange")
2_by_4(square / 2 + 4, "y");

// East Y-Axis Roof Supports
translate([square / 2 + 2, 0, center_height - 10])
color("Orange")
2_by_4(square / 2 + 4, "y");

translate([square / 2 - 4, 0, center_height - 10])
color("Orange")
2_by_4(square / 2 + 4, "y");

// Vestibule Roof
translate([-square / 2, -square / 2 - vestibule_width, 4])
rotate([vestibule_support_beam_angle, 0, 0])
color("Purple")
cube([square, vestibule_support_beam_length, 1]);

// Main Roof
translate([-square / 2, 0, center_height - 7])
color("Purple")
cube([square, square / 2 - 2, 1]);

// West Lower Side Wall
translate([0,0,0])
color("Yellow")
polyhedron(
points = [
	[-square / 2 + 2, -square / 2 - vestibule_width - 4, 0],
	[-square / 2 + 2, -square / 2 - 0.1, 0],
	[-square / 2 + 2, -square / 2 - 0.1, height + (0.7 * foot) - 0.1],
],
triangles = [
	[2, 1, 0],
]
);

//difference() {
// Make a difference
	// East Lower Side Wall
	translate([0,0,0])
	color("Yellow")
	polyhedron(
	points = [
		[square / 2 - 2, -square / 2 - vestibule_width - 4, 0],
		[square / 2 - 2, -square / 2 - 0.1, 0],
		[square / 2 - 2, -square / 2 - 0.1, height + (0.7 * foot) - 0.1],
	],
	triangles = [
		[2, 1, 0],
	]
	);

	// Door in the lower side wall
	//translate([square / 2 - 3, -square / 2 - vestibule_width / 2, 0.1])
	//color("Orange")
	//cube([5, 3 * foot, 4 * foot]);
//}

//difference() {
// Interior Walls for Sleeping Space
translate([-square / 2, -square / 2 + 4, 0])
color("Yellow")
cube([square, 1, height - 4]);

// Door in the lower interior wall
//translate([square / 4, -square / 2 + 2, 0.1])
//color("Orange")
//cube([3 * foot, 5, 4 * foot]);
//}

// Side 3 / 4 Angled Reinforcements
//reinforcement_length = floor(sqrt(pow(square / 4, 2) + pow(height / 2, 2)));
//reinforcement_angle = atan((square / 4) / (height / 2));

//translate([-square / 2 - 2, -square/2 - 2, height - (height / 2)])
//  mirror([0, 0, 0])
//  rotate([reinforcement_angle, 0, 90])
//  cube([2, 4, reinforcement_length]);
