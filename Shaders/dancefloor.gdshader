//GODOT HATES ME: THE SHADER
//when enabled, makes tiles of the battle grid light up like a dance floor
shader_type canvas_item;
render_mode world_vertex_coords;

uniform float bpm = 200;
uniform vec2 corners[45]; //calculated and set by parent (BattleGrid)
const vec2 testcorners[45] = vec2[](
	vec2(310.0, 280.0),
	vec2(462.0, 280.0),
	vec2(614.0, 280.0),
	vec2(766.0, 280.0),
	vec2(918.0, 280.0),
	vec2(1070.0, 280.0),
	vec2(1222.0, 280.0),
	vec2(1374.0, 280.0),
	vec2(1526.0, 280.0),
	vec2(251.0937, 365.7091),
	vec2(403.0937, 365.7091),
	vec2(555.0937, 365.7091),
	vec2(707.0937, 365.7091),
	vec2(859.0937, 365.7091),
	vec2(1011.094, 365.7091),
	vec2(1163.094, 365.7091),
	vec2(1315.094, 365.7091),
	vec2(1467.094, 365.7091),
	vec2(192.1874, 451.4182),
	vec2(344.1874, 451.4182),
	vec2(496.1874, 451.4182),
	vec2(648.1874, 451.4182),
	vec2(800.1874, 451.4182),
	vec2(952.1874, 451.4182),
	vec2(1104.188, 451.4182),
	vec2(1256.188, 451.4182),
	vec2(1408.187, 451.4182),
	vec2(133.2811, 537.1273),
	vec2(285.2811, 537.1273),
	vec2(437.2811, 537.1273),
	vec2(589.2811, 537.1273),
	vec2(741.2811, 537.1273),
	vec2(893.2811, 537.1273),
	vec2(1045.281, 537.1273),
	vec2(1197.281, 537.1273),
	vec2(1349.281, 537.1273),
	vec2(74.37484, 622.8364),
	vec2(226.3748, 622.8364),
	vec2(378.3748, 622.8364),
	vec2(530.3749, 622.8364),
	vec2(682.3749, 622.8364),
	vec2(834.3749, 622.8364),
	vec2(986.3749, 622.8364),
	vec2(1138.375, 622.8364),
	vec2(1290.375, 622.8364));
uniform bool dancefloor = true; //determines if shader is even active at all
uniform bool dancestep = false; //toggled by parent to alternate which tiles are affected

varying vec2 world_coords;

float tri_area(vec2 a, vec2 b, vec2 c) {
	// takes 3 points
	// calculates the area of the triangle formed by points
	float len1 = distance(a, b);
	float len2 = distance(a, c);
	float len3 = distance(b, c);
	
	float semi = (len1 + len2 + len3) / 2.0;
	
	return sqrt(semi * (semi - len1) * (semi - len2) * (semi - len3));
}

ivec2 grid_pos(vec2 pos) {
	// takes world coordinates of pixel
	// returns map coordinates for the tile the pixel is part of
	// very messy but godot is really bad about support for shaders that each affect individual tiles
	// so yeah i improvised
	ivec2 output = ivec2(-1, -1);
	float smallest = 1.0 / 0.00000000000001; //SHOULD be effectively infinite. Probably.
	for(int y = 0; y < 4; y++) {
		for(int x = 0; x < 8; x++) {
			int topleft = x + (9 * y);
			vec2 corner1 = testcorners[topleft];
			vec2 corner2 = testcorners[topleft+1];
			vec2 corner3 = testcorners[topleft+9];
			vec2 corner4 = testcorners[topleft+10];
			
			float tri1 = tri_area(corner1, corner2, pos);
			float tri2 = tri_area(corner2, corner3, pos);
			float tri3 = tri_area(corner3, corner4, pos);
			float tri4 = tri_area(corner1, corner4, pos);
			
			float tri_total = tri1 + tri2 + tri3 + tri4;
			
			if(tri_total < smallest) {
				output = ivec2(x, y);
				smallest = tri_total;
			}
		}
	}
	return output;
}

void vertex() {
    world_coords = VERTEX;
}

void fragment() {
	//if enabled, AND the pixel isnt transparent, AND the pixel isnt the color of the tile border...
	//then check if grid pos is valid for dancestep's current state. if its valid, THEN apply.
	if(dancefloor) {
		if(COLOR.a > 0.0) {
			if (distance(COLOR, vec4(88.0/225.0, 88.0/225.0, 88.0/225.0, COLOR.a)) > 0.1) {
				ivec2 grid = grid_pos(world_coords);
				int increment = (grid.x + grid.y) % 2;
				if ((increment == 0 && !dancestep) || (increment == 1 && dancestep)) {
					if(dancestep) {
						COLOR = vec4(0.5, 0.5, 0.8, COLOR.a);
					}
					else {
						COLOR = vec4(0.5, 0.6, 0.5, COLOR.a);
					}
				}
			}
		}
	}
}