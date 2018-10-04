#version 450

in vec3 pos;
in vec3 norm;

uniform vec3 lightDirection;
uniform vec3 albedoColour;
uniform vec3 ambientColour;

out vec4 fragColour;

void main() {
	float dLight0 = clamp(dot(norm, lightDirection), 0.0, 1.0);
    vec3 light = dLight0 + ambientColour;

    fragColour = vec4(1.0, 0.0, 0.0, 1.0);//vec4(albedoColour * light, 1.0);
}