sheet_thickness = 3/4;

// "standard" inch measurements

foot = 12;
feet = 12;
left = -1;
right = 1;

// full
mattress_width = 54;
mattress_length = 75;

// twin
mattress_width = 39;
mattress_length = 75;

// queen
mattress_width = 60;
mattress_length = 80;

mattress_thickness = 6;

// widths are frame opening, not drawer
drawer_width  = [39 + 3/8, 29 + 1/2, 19 + 5/8]; // large, medium, small
drawer_depth = 22 + 7/8;
drawer_height = 6 + 1/4;
drawer_spacing = 2;

bed_height = 24;

num_drawers = (bed_height+drawer_spacing)/(drawer_height+drawer_spacing);
height_remain = bed_height - (floor(num_drawers)*(drawer_height+drawer_spacing) - drawer_spacing);
echo(num_drawers, " high, ", height_remain, "in left over");

center_support_length = mattress_length;
center_support_width = 4;

module drawer(size=0) {
  cube([drawer_width[size],drawer_depth,drawer_height],center=true);
}

% translate([0,0,mattress_thickness/2])
  cube([mattress_length,mattress_width,mattress_thickness],center=true);

// center support (for wider beds)
translate([0,0,-sheet_thickness/2])
  cube([center_support_length,center_support_width,sheet_thickness],center=true);

// headboard, footboard
for(end=[left,right]) {
  translate([(mattress_length/2+sheet_thickness/2)*end,0,-bed_height/2+mattress_thickness/4])
    cube([sheet_thickness,mattress_width+sheet_thickness*2,bed_height+mattress_thickness/2],center=true);
}

// side rails
side_rail_height = 4 + mattress_thickness/2;
for(side=[left,right]) {
  translate([0,(mattress_width/2+sheet_thickness/2)*side,-side_rail_height/2+mattress_thickness/2])
    cube([mattress_length+sheet_thickness*2,sheet_thickness,side_rail_height],center=true);
}

/*
translate([-mattress_length/2,0,0]) {
  translate([drawer_width[1]/2,0,0]) {
    for(side=[left,right]) {
      for(i=[0:num_drawers-1]) {
        translate([0,(mattress_width/2-drawer_depth/2)*side,-height_remain-i*(drawer_height+drawer_spacing)-drawer_height/2]) {
          % drawer(1);
        }
      }
    }
    for(side=[left,right]) {
      translate([(drawer_width[1]/2+sheet_thickness/2)*side,0,-bed_height/2])
        cube([sheet_thickness,mattress_width+sheet_thickness*2,bed_height],center=true);
    }
  }
}

translate([-mattress_length/2,0,0]) {
  translate([drawer_width[1]+sheet_thickness+drawer_width[1]/2,0,0]) {
    for(side=[left,right]) {
      translate([(drawer_width[1]/2+sheet_thickness/2)*side,0,-bed_height/2])
        cube([sheet_thickness,mattress_width+sheet_thickness*2,bed_height],center=true);
    }
  }
}
*/

side_brace_width = 6;
for(side=[left,right]) {
  translate([0,(mattress_width/2-side_brace_width/2+sheet_thickness)*side,-bed_height+sheet_thickness/2]) {
    cube([mattress_length+sheet_thickness*2,side_brace_width,sheet_thickness],center=true);
  }
}
