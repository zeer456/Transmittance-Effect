#version 330
out vec4 FragColor;

in vec3 normal;
in vec3 position;

uniform float etaR;
uniform float etaG;
uniform float etaB;
uniform float fPower;
float F = ((1.0-etaG) * (1.0-etaG)) / ((1.0+etaG) * (1.0+etaG));

uniform mat4 view;
uniform samplerCube skybox;

void main(){
    vec3 reflection = reflect(normalize(position), normalize(normal));
    
    float ratio = F + (1.0 - F) * pow((1.0 - dot(-normalize(position), normalize(normal))), fPower);

    vec3 refractionR = refract(normalize(position), normalize(normal), etaR);
    vec3 refractionG = refract(normalize(position), normalize(normal), etaG);
    vec3 refractionB = refract(normalize(position), normalize(normal), etaB);
    
    vec3 refraction;
    refraction.r = vec3(texture(skybox, refractionR)).r;
    refraction.g = vec3(texture(skybox, refractionG)).g;
    refraction.b = vec3(texture(skybox, refractionB)).b;

    vec3 reflectionTexture = vec3(texture(skybox, reflection));

    FragColor = vec4(mix(refraction, reflectionTexture, ratio), 1);
}