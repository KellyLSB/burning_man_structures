foot   = 12; // Inches
height = 10 * foot; // Feet
square = 20 * foot; // Feet

// Primary Supports

// Lower Side 1
translate([-square/2, square/2, 0])
	cube([2 - .1, 4 - .1, height]);
translate([-square/2 - 2, square/2, 0])
	cube([2 - .1, 4 - .1, height]);

translate([-square/2, -square/2, 0])
	cube([2 - .1, 4 - .1, height]);
translate([-square/2 - 2, -square/2, 0])
	cube([2 - .1, 4 - .1, height]);

// Lower Side 2
translate([square/2, square/2, 0])
	cube([2 - .1, 4 - .1, height]);
translate([square/2 - 2, square/2, 0])
	cube([2 - .1, 4 - .1, height]);

translate([square/2, -square/2, 0])
	cube([2 - .1, 4 - .1, height]);
translate([square/2 - 2, -square/2, 0])
	cube([2 - .1, 4 - .1, height]);

// Center Supports

// Side 1
translate([-square/2, - 2, 0])
	cube([2 - .1, 4 - .1, height]);
translate([-square/2 - 2, -2, 0])
	cube([2 - .1, 4 - .1, height]);

// Side 2
translate([square/2 - 2, - 2, 0])
	cube([2 - .1, 4 - .1, height]);
translate([square/2, -2, 0])
	cube([2 - .1, 4 - .1, height]);

// Cross Beams
cross_beam_length = floor(sqrt(pow(square, 2) + pow(height, 2)));
cross_beam_angle = atan(height / square);

// Side 1
translate([-square/2 + 2, -square/2 - 1, 0])
	mirror([0, 1, -1])
	rotate([-cross_beam_angle + 3, 0, 0])
	cube([2 - .1, 4 - .1, cross_beam_length]);
translate([-square/2 - 4, square/2 + 6, 3])
	mirror([0, 1, 1])
	rotate([cross_beam_angle - 3, 0, 0])
	cube([2 - .1, 4 - .1, cross_beam_length]);

// Side 2
translate([square/2 - 4, -square/2 - 1, 0])
	mirror([0, 1, -1])
	rotate([-cross_beam_angle + 3, 0, 0])
	cube([2 - .1, 4 - .1, cross_beam_length]);
translate([square/2 + 2, square/2 + 6, 3])
	mirror([0, 1, 1])
	rotate([cross_beam_angle - 3, 0, 0])
	cube([2 - .1, 4 - .1, cross_beam_length]);

// Top Beams
short_top_beam_length = square + 4;
long_short_top_beam_length = square + 12;

// Side 1
// Outer Long
translate([-square/2 - 4, -square/2 - 4, height - 4])
	mirror([0, 1, -1])
	cube([2 - .1, 4 - .1, long_short_top_beam_length]);

// Inner Long (Shorter)
translate([-square/2 + 2, -square/2, height - 4])
	mirror([0, 1, -1])
	cube([2 - .1, 4 - .1, short_top_beam_length]);

// Side 2
// Outer Long
translate([square/2 + 2, square/2 + 8, height])
	mirror([0, 1, 1])
	cube([2 - .1, 4 - .1, long_short_top_beam_length]);

// Inner Long (Shorter)
translate([square/2 - 4, square/2 + 4, height])
	mirror([0, 1, 1])
	cube([2 - .1, 4 - .1, short_top_beam_length]);

// Side 3
// Outer Long
translate([square/2 + 2, square/2 + 4, height - 4])
	mirror([1, 0, 1])
	rotate([0,0,90])
	cube([2 - .1, 4 - .1, short_top_beam_length]);
translate([square/2 + 2, square/2 + 6, height - 4])
	mirror([1, 0, 1])
	rotate([0,0,90])
	cube([2 - .1, 4 - .1, short_top_beam_length]);

// Side 4
// Outer Long
translate([square/2 + 2, -square/2 - 2, height - 4])
	mirror([1, 0, 1])
	rotate([0,0,90])
	cube([2 - .1, 4 - .1, short_top_beam_length]);
translate([square/2 + 2, -square/2 - 4, height - 4])
	mirror([1, 0, 1])
	rotate([0,0,90])
	cube([2 - .1, 4 - .1, short_top_beam_length]);

// Side 3 / 4 Angled Reinforcements
//reinforcement_length = floor(sqrt(pow(square / 4, 2) + pow(height / 2, 2)));
//reinforcement_angle = atan((square / 4) / (height / 2));

//translate([-square / 2 - 2, -square/2 - 2, height - (height / 2)])
//	mirror([0, 0, 0])
//	rotate([reinforcement_angle, 0, 90])
//	cube([2, 4, reinforcement_length]);
