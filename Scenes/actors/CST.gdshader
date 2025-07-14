shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float curvature = 7.0;
uniform float res = 180;
uniform float vignette_mult = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;
	vec2 uv_offset = centered_uv.yx / curvature;
	vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;
	vec3 cutoff = vec3(step(abs(warped_uv.x), 1.0) * step(abs(warped_uv.y), 1.0));
	vec3 scanlines = vec3(sin(2.0 * warped_uv.y * res) * 0.2 + 0.7);
	vec3 vignette = vec3(length(pow(abs(centered_uv), vec2(4.0)) / 3.0));
	
	vec3 screen_color = textureLod(SCREEN_TEXTURE, (warped_uv + 1.0) / 2.0, 0.3).rgb * cutoff * scanlines;
	screen_color -= vignette * vignette_mult;
	
	COLOR = vec4(screen_color,1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
