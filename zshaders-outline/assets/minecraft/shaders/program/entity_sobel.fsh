#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;
in vec2 oneTexel;

out vec4 fragColor;

// 0 - Sobel Operator, 1 - Scharr Operator
#define OPERATOR 0
// 0 - grayscale, 1 - color
#define COLOR 1

// Based on the work by Forceflow on Shadertoy

float getIntensityAt(vec2 offset) {
    return length(texture(DiffuseSampler, texCoord + offset * oneTexel).rgb);
}

void main(){
    // samples
    float tleft  = getIntensityAt(vec2(-1., -1.));
    float left   = getIntensityAt(vec2(-1.,  0.));
    float bleft  = getIntensityAt(vec2(-1.,  1.));
    float top    = getIntensityAt(vec2( 0., -1.));
    float bottom = getIntensityAt(vec2( 0.,  1.));
    float tright = getIntensityAt(vec2( 1., -1.));
    float right  = getIntensityAt(vec2( 1.,  0.));
    float bright = getIntensityAt(vec2( 1.,  1.));

    #if OPERATOR==0
    vec2 g = vec2( tleft + 2.*left + bleft  - tright - 2.*right  - bright,
                  -tleft - 2.*top  - tright + bleft  + 2.*bottom + bright);
    #elif OPERATOR==1
    vec2 g = vec2(3.*tleft + 10.*left + 3.*bleft  - 3.*tright - 10.*right  - 3.*bright,
                  3.*tleft + 10.*top  + 3.*tright - 3.*bleft  - 10.*bottom - 3.*bright);
    #endif

    #if COLOR==0
    vec3 color = vec3(1.);
    #elif COLOR==1
    vec3 color = texture(DiffuseSampler, texCoord).rgb;
    #endif
    
    fragColor = vec4(color * length(g), 1.0);
}
