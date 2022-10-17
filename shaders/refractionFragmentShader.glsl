#version 330
out vec4 FragColor;

in vec3 normal;
in vec3 position;

uniform mat4 view;
uniform float ratioDenom;
uniform samplerCube skybox;

void main(){
    float ratio = 1.0/1.52;
    vec3 R = refract(normalize(position), normalize(normal), ratio);
    R = vec3(inverse(view) * vec4(R, 0.0));

	FragColor = texture(skybox, R);
}