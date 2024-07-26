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

float intensity(vec3 color){
	return sqrt(dot(color, color));
}

float getIntensity(vec2 offset) {
    return intensity(texture(DiffuseSampler, texCoord + offset * oneTexel).rgb);
}

void main(){
    // samples
    float tleft  = getIntensity(vec2(-1., -1.));
    float left   = getIntensity(vec2(-1.,  0.));
    float bleft  = getIntensity(vec2(-1.,  1.));
    float top    = getIntensity(vec2( 0., -1.));
    float bottom = getIntensity(vec2( 0.,  1.));
    float tright = getIntensity(vec2( 1., -1.));
    float right  = getIntensity(vec2( 1.,  0.));
    float bright = getIntensity(vec2( 1.,  1.));

    #if OPERATOR==0
    float x = tleft + 2.*left + bleft - tright - 2.*right - bright;
    float y = -tleft - 2.*top - tright + bleft + 2. * bottom + bright;
    #elif OPERATOR==1
    float x = 3.*tleft + 10.*left + 3.*bleft - 3.*tright - 10.*right - 3.*bright;
    float y = 3.*tleft + 10.*top + 3.*tright - 3.*bleft - 10. * bottom - 3.*bright;
    #endif

    float transparency = sqrt(x * x + y * y);

    #if COLOR==0
    vec3 color = vec3(1.);
    #elif COLOR==1
    vec3 color = texture(DiffuseSampler, texCoord).rgb;
    #endif
    
    fragColor = vec4(color * transparency, 1.0);
}
