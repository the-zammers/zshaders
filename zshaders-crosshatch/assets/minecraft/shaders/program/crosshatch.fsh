#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;
in vec2 positionnew;
in vec2 oneTexel;

uniform vec2 InSize;
uniform vec2 OutSize;

out vec4 fragColor;

// Based on the Crosshatching GLSL Filter by JEGX

const float lum_threshold_1 = 1.0;
const float lum_threshold_2 = 0.7;
const float lum_threshold_3 = 0.5;
const float lum_threshold_4 = 0.3;
const int hatchSize = 10;
const int hatch_y_offset = 5;

#define WHITE vec3(1.)
#define BLACK vec3(0.)

void main() { 
  ivec2 uv = ivec2(floor(texCoord / oneTexel - 0.4 * InSize));
  
    vec3 color = texture(DiffuseSampler, texCoord).rgb;
    float lum = length(color);
    vec3 tc = WHITE;
  
  
    if (lum < lum_threshold_1) { // tl to br
      if (mod(uv.x + uv.y, hatchSize) < 1) tc = BLACK;
    }  
  
    if (lum < lum_threshold_2) { // tr to bl
      if (mod(uv.x - uv.y, hatchSize) < 1) tc = BLACK;
    }  
    
    if (lum < lum_threshold_3) { // tl to br, offset
      if (mod(uv.x + uv.y - hatch_y_offset, hatchSize) < 1) tc = BLACK;
    }  
  
    if (lum < lum_threshold_4) { // tr to bl, offset
      if (mod(uv.x - uv.y - hatch_y_offset, hatchSize) < 1) tc = BLACK;
    }
    
  
  fragColor = vec4(tc, 1.0);
}