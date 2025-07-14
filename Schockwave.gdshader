shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec2 center = vec2(0.5,0.5);
uniform float size = 1.0;
uniform float force = 1.0;
uniform float thickness = 1.0;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x/ SCREEN_PIXEL_SIZE.y;
	vec2 scaleUV = (SCREEN_UV - vec2(0.5,0.0))/ vec2(ratio, 1.0) + vec2(0.5,0.0);
	float mask = (1.0 - smoothstep(size-0.1, size, length(scaleUV - center))) * smoothstep(size-thickness-0.1, size-thickness, length(scaleUV - center));
	vec2 disp = normalize(scaleUV - center) * force * mask;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp);

}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}