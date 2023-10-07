#version 150

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

in vec2 vaUV0;
in vec3 vaPosition;

out vec2 texCoord;

void main() {
    gl_Position = projectionMatrix * (modelViewMatrix * vec4(vaPosition, 1.0));
    texCoord = vaUV0;
}