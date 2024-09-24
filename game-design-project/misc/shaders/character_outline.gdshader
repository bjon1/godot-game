shader_type canvas_item;

/*
To use this script:
1. Add a material to a node that has the material property
2. Select "new shader material"
3. Click shader, and the load this script

After these steps, the variables needed to impact character outline will be
shown so you can edit it through the inspector.

You can edit these variables via script as well
*/
uniform vec4 line_color : source_color = vec4(1.0);
uniform float line_thickness : hint_range(0, 10) = 1.0;
uniform bool outline_enabled = true;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1),
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	if(outline_enabled == true){
		vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
		float outline = 0.0;

		for (int i = 0; i < OFFSETS.length(); i++) {
			outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
		}
		outline = min(outline, 1.0);

		vec4 color = texture(TEXTURE, UV);
		COLOR = mix(color, line_color, outline - color.a);
	}
}