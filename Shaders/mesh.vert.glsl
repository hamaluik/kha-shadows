#version 450

in vec3 position;
in vec3 normal;

uniform mat4 MVP;
uniform mat4 M;

out vec3 pos;
out vec3 norm;

void main() {
    pos = (M * vec4(position, 1.0)).xyz;
    norm = (M * vec4(normal, 0.0)).xyz;
    gl_Position = MVP * vec4(position, 1.0);
}