/*
* Desc: Second pass fragment shader.
* 	- Responsibilities:
* 		- Tone Curve
*/

#version 150
#extension GL_ARB_explicit_attrib_location : enable

uniform sampler2D colortex0;

in vec2 texCoord;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 colortex0Out;

void main() {
    vec3 color = texture2D(colortex0, texCoord).rgb;
    colortex0Out = vec4(color, 1);
}

/*
* Written by Gavin Castaneda © 2023 MIT License (see LICENSE file)
*/