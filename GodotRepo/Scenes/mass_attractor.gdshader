shader_type particles;

void start() {
	// Place start code here.
}

uniform vec2 attractor_pos; // The position of the attractor in the view
uniform float attractor_strength = 100.0; // The strength of the attraction
uniform vec2 start_pos;

void process() {

    COLOR = vec4(0.7, 0.2, 0.8, 1.0); // RGB for purple and alpha for opacity
      // Emit particles in a straight line on the X axis with a fixed velocity
    VELOCITY = vec3(100.0, 0.0, 0.0);
    
}
