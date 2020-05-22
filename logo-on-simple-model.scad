/*
 * Contains a simple model and stamps a sample logo into the side of it.
 *
 * This model isn't particularly useful as it's just a cylinder, but it
 * illustrates the general idea and approach.
 */


// First we'll define a module which provides our logo at a specified size.
// The module expects to be given a width for a logo and a depth.
module make_logo(width, depth) {
    // Resize the extruded logo to the X dimension (width) provided, auto-set
    // the Y dimension to maintain aspect ratio, and leave Z as it is.
    resize([width,0,0], auto=[true,true,false]) {
        // Extrude the logo to the required depth plus a tiny bit extra
        linear_extrude(depth + 0.1) {
            // Import the logo
            import("logo.svg");
        }
    }
}


// Use difference to subtract the logo instances from the model itself.
difference() {
    
    radius = 20;
    height = 35;
    
    // This is where we build our object
    union() {
        cylinder(r=radius, h=height, $fn=90);
        
        translate([0,5,height]) {
            linear_extrude(2) {
                translate()
                    text("Test", size=6, halign="center");
                
                translate([0,-8,0])
                    text("object", size=6, halign="center");
            }
        }
    }
    
    // How deep we want to 'press' the logo into the model.
    // We'll go for 1mm but this could be anything. This value
    // is used below when making the logo and when positioning it.
    // Also define the width of the logo ahead of time. This means
    // we can use this value when positioning it too.
    logo_depth = 1;
    logo_width = 12;

    // Rotate and move the logo into the right place to intersect with
    // the model in the appropriate place. These values will depend on
    // the model and its location. There's probably a smarter way to find
    // the correct location but I just eyeball and hard-code the position.
    translate([-logo_width/2, -17, height-logo_depth]) {
        rotate([0,0,0]) {
            // Make the logo
            make_logo(logo_width, logo_depth);
        }
    }
    
}
