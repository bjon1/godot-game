shader_type canvas_item;

uniform float glow_intensity : hint_range(0.0, 1.0) = 0.6;
uniform float shimmer_speed : hint_range(0.0, 5.0) = 1.5;
uniform float radius : hint_range(0.0, 0.5) = 0.4; // Radius of the blue circle
uniform float border_thickness : hint_range(0.0, 0.2) = 0.1; // Thickness of the transparent border
uniform vec4 blue_color : source_color = vec4(0.0, 0.5, 1.0, 1.0); // Blue background color

void fragment() {
    // UV coordinates and distance from center
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    vec2 centered_uv = (UV - vec2(0.5));
    float distance = length(centered_uv);
    
    // Determine where the blue circle and border should be
    float inner_edge = radius;
    float outer_edge = radius + border_thickness;

    // Shimmer and glow effect
    float glow = glow_intensity / (distance * distance + 0.1);
    float shimmer = abs(sin(TIME * shimmer_speed + distance * 15.0)) * glow_intensity;

    // Color calculations
    vec4 base_color = blue_color; // Default to blue for the circle area
    base_color.rgb += vec3(glow + shimmer); // Add shimmer
    
    // Apply alpha based on distance for the transparent border
    if (distance > inner_edge && distance <= outer_edge) {
        float alpha_factor = smoothstep(outer_edge, inner_edge, distance);
        base_color.a = alpha_factor; // Smooth fade-out on the border
    } else if (distance > outer_edge) {
        discard; // Outside the border is fully transparent
    }
    
    COLOR = base_color;
}
