/*
* Desc: First pass fragment shader.
* 	- Responsibilities:
* 		- Grayscale (and gs color balance)
*       - Film Grain
*       - Letterbox Effect
*/

#version 150
#extension GL_ARB_explicit_attrib_location : enable

uniform sampler2D colortex0;

// Get the screen width and height
uniform float viewWidth;
uniform float viewHeight;
uniform float frameTimeCounter;

// Macros
#define FILMGRAIN 0.075   	// Film grain levels [0 0.025 0.05 0.075 0.1 0.125 0.15 1]
#define LETTERBOX			// Turn letterboxing on or off
#define RED 0.1				// Values for grayscale color filter [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1]
#define GREEN 0.35			// [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1]
#define BLUE 0.6 			// [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1]

in vec2 texCoord;

void main() {
	// Put screen resolution in a vector
	vec2 resolution = vec2(viewWidth, viewHeight);

	// Letterbox ratio:
	float ratioX = 21;
	float ratioY = 9;
	// Pixel height of letterbox
	float letterBoxHeight = ((resolution.x / ratioX) * ratioY) - resolution.y;
	// Normalize letterBoxHeight
	if (letterBoxHeight > 1) {
		// For screens wider than 21:9
		letterBoxHeight = 0;
	}
	else {
		letterBoxHeight = abs(letterBoxHeight / resolution.y);
	}

	// Assign screen space coordinates to colortex0
	vec4 color = texture2D(colortex0, texCoord.xy);

	// * Film Grain
	float toRadians = 3.14159 / 180;
	float amount = FILMGRAIN;
	float randomIntensity = fract(10000 * sin(((texCoord.x + texCoord.y) * (frameTimeCounter * 100)) * toRadians));
	amount *= randomIntensity;
	color += amount;


	// * Letterboxing
	#ifdef LETTERBOX
		// if the y value is farther away from the center than 1 - letterBoxHeight 
		// (divided by two because there are two letterboxes)
		if (abs(texCoord.y - .5) > (1 - letterBoxHeight) / 2) {
			color = vec4(0, 0, 0, 1);
		}
	#endif
	
	// * Grayscale
	// The values in the vec3 essentially apply a color filter.
	// Hardcoded for now
	float grayScale = dot(color.rgb, vec3(RED, GREEN, BLUE));

	color = vec4(grayScale, grayScale, grayScale, color.a);

	gl_FragData[0] = color;
}

/*
* Written by Gavin Castaneda © 2023 MIT License (see LICENSE file)
*/