/*
* Desc: Second pass fragment shader.
* 	- Responsibilities:
* 		- Tone Curve
*/

#version 150
#extension GL_ARB_explicit_attrib_location : enable

// Common
#include "/lib/common.glsl"

// Uniforms
uniform sampler2D colortex0;

// Macros
#define TONECURVE       // Turn tone curve on or off

// Inputs
in vec2 texCoord;

void main() {
    // Assign screen space coordinates to colortex0
    vec3 color = texture2D(colortex0, texCoord).rgb;

    #ifdef TONECURVE
        // ACES tonemap the color
        color.r = ACESFilm(color.r);
        color.g = ACESFilm(color.g);
        color.b = ACESFilm(color.b);
    #endif

    gl_FragData[0] = vec4(color, 1);
}

/*
* Written by Gavin Castaneda © 2023 MIT License (see LICENSE file)
*/