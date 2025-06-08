shader_type canvas_item;

const float freq = 5.0;

void fragment() {
	// Called for every pixel the material is visible on.
		bool active = (abs(UV.x - UV.y * 1.05) <= 0.015) || ((UV.x + UV.y * 1.05 >= 0.88) && (UV.x + UV.y * 1.05 <= 0.93));
		if(active)  {
			float phase = 2.0 * PI * freq * TIME;
			float wave = sin(phase);

			if (wave > 0.0) {
				COLOR = vec4(1.0, 0.0, 0.0, 1.0);
			}
			else {
				COLOR = vec4(0.6, 0.0, 0.0, 1.0);
			}
		}
}
