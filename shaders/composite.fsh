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
	vec3 color = texture(colortex0, texcoord).rgb;

	colortex0Out = vec4(color, 1.0);
}