/*
* Desc: Commonly used defines, variables, and functions
* 	- Responsibilities:
*       - Functions
* 		    - ACESFilm function
*/

// From: https://knarkowicz.wordpress.com/2016/01/06/aces-filmic-tone-mapping-curve/
float ACESFilm(float x) {
    float a = 2.51;
    float b = 0.03;
    float c = 2.43;
    float d = 0.59;
    float e = 0.14;
    float rv = (x*(a*x+b))/(x*(c*x+d)+e);
    return clamp(rv, 0.0, 1.0);
}

/*
* Written by Gavin Castaneda, unless otherwise specified © 2023 MIT License (see LICENSE file)
*/