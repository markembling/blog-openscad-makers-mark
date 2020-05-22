/*
 * Import a pre-existing STL file and stamps a sample logo into the sides of it.
 *
 * In this example we're using a face shield headband but this could be any
 * model you wish to stamp your mark into before printing.
 *
 * If you use a third-party STL like this, do remember to check that the
 * license allows you to modify/remix and use for your intended purpose 
 * before doing this.
 *
 * Attribution:
 * Prusa Face Shield by Prusa Research
 * Downloaded from https://www.prusaprinters.org/prints/25857-prusa-face-shield
 * Licensed under Creative Commons (4.0 International License) Attribution-NonCommercial
 * Shared here for example purposes - this remix is not intended for use.
 * Please see the above URL for the current/latest version of this model.
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
    
    // Import the existing STL model file
    import("covid19_headband_rc3.stl", convexity=3);
    
    // How deep we want to 'press' the logo into the model.
    // We'll go for 1mm but this could be anything. This value
    // is used below when making the logo and when positioning it.
    logo_depth = 1;

    // Rotate and move the logo into the right place to intersect with
    // the model in the appropriate place. These values will depend on
    // the model and its location. There's probably a smarter way to find
    // the correct location but I just eyeball and hard-code the position.
    translate([79.8-logo_depth, -48.5, -8.7]) {
        rotate([90,0,90]) {
            // Make the logo (15mm wide)
            make_logo(15, logo_depth);
        }
    }
    
    // Do the same thing again but for the other side of the model
    translate([-95.3+logo_depth, -48.5+15, -8.7]) {
        rotate([90,0,-90]) {
            // Make the logo (15mm wide)
            make_logo(15, logo_depth);
        }
    }
    
}
