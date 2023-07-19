#version 150
#extension GL_ARB_explicit_attrib_location : enable

uniform sampler2D colortex0;

// Get the screen width and height
uniform float screenWidth;
uniform float screenHeight;

in vec2 texcoord;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
	// Put screen resolution in a vector
	vec2 resolution = vec2(screenWidth, screenHeight);

	// Normalized pixel coordinates:
	vec2 uv = texcoord / resolution.xy;
	// Put origin in the center
	uv -= .5;
	// Normalize
	uv.x *= resolution.x / resolution.y;

	vec3 color = texture(colortex0, texcoord).rgb;

	//vec3 color = vec3(texcoord.x, texcoord.y, 0);

	colortex0Out = vec4(color, 1.0);
}