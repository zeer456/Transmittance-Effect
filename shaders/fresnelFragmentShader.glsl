#version 330
out vec4 FragColor;

in vec3 normal;
in vec3 position;

uniform float eta;
uniform float fPower = 2.0;
float F = ((1.0-eta) * (1.0-eta)) / ((1.0+eta) * (1.0+eta));

uniform mat4 view;
uniform samplerCube skybox;

void main(){
    vec3 reflection = reflect(normalize(position), normalize(normal));
    vec3 refraction = refract(normalize(position), normalize(normal), eta);

    vec3 reflectionTexture = vec3(texture(skybox, reflection));
    vec3 refractionTexture = vec3(texture(skybox, refraction));
    
    float ratio = F + (1.0 - F) * pow((1.0 - dot(-normalize(position), normalize(normal))), fPower);

    FragColor = vec4(mix(refractionTexture, reflectionTexture, ratio), 1);
}