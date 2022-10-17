#version 330
out vec4 FragColor;

in vec3 normal;
in vec3 position;

uniform mat4 view;
uniform samplerCube skybox;

void main(){
    vec3 R = reflect(normalize(position), normalize(normal));
	R = vec3(inverse(view) * vec4(R, 0.0));

	FragColor = texture(skybox, R);
}