#version 330

in vec3 vertex_position;

out vec3 textureCoords;

uniform mat4 view;
uniform mat4 proj;

void main() 
{
    textureCoords = vertex_position;
    gl_Position = proj * view * vec4(vertex_position, 1.0);
}