shader_type canvas_item;

uniform bool active = false;
const float freq = 5.0;

void fragment() {
	// Called for every pixel the material is visible on.
	if(COLOR != vec4(0, 0, 0, 0) ) {
		if(active) {
			float phase = 2.0 * PI * freq * TIME;
			float wave = sin(phase);
			
			if (wave > 0.0) {
				COLOR = vec4(COLOR.r, COLOR.g, COLOR.b, COLOR.a * 0.7);
			}
			else {
				COLOR = vec4(COLOR.r, COLOR.g, COLOR.b, COLOR.a * 0.8);
			}
		}
	}
}
