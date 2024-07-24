#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;
in vec2 oneTexel;

uniform vec2 InSize;

#define TWOPI 6.28318530718
#define RADIUS_A 4

out vec4 fragColor;

float luminance(vec3 color) {
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

float gaussianCoefficient(float sigma, vec2 offset) {
    return 1.0 / (TWOPI * sigma * sigma) * exp(-float(offset.x * offset.x + offset.y * offset.y) / (2.0 * sigma * sigma));
}

float gaussianBlur(vec2 pos) {
    vec2 blur = vec2(0.);
    vec2 count = vec2(0.);

    for(int x = -RADIUS_A; x <= RADIUS_A; x++) {
        for(int y = -RADIUS_A; y <= RADIUS_A; y++) {
            vec3 curr = texture(DiffuseSampler, pos + vec2(x,y) * oneTexel).rgb;
            float coefficientA = gaussianCoefficient(5., vec2(x,y) / RADIUS_A);
            float coefficientB = gaussianCoefficient(2.5, vec2(x,y) / RADIUS_A);
            blur += vec2(luminance(curr)) * vec2(coefficientA, coefficientB);
            count += vec2(coefficientA, coefficientB);
        }
    }

    blur *= 500. / count;
    float final = blur.y - blur.x;
    return final > .2 ? 4. * final : 0.;
}

vec2 sobel() {
    float c  = gaussianBlur(texCoord + vec2( 0,  0) * oneTexel);
    float w  = gaussianBlur(texCoord + vec2(-1,  0) * oneTexel);
    float e  = gaussianBlur(texCoord + vec2( 1,  0) * oneTexel);
    float n  = gaussianBlur(texCoord + vec2( 0, -1) * oneTexel);
    float s  = gaussianBlur(texCoord + vec2( 0,  1) * oneTexel);
    float nw = gaussianBlur(texCoord + vec2(-1, -1) * oneTexel);
    float sw = gaussianBlur(texCoord + vec2( 1, -1) * oneTexel);
    float ne = gaussianBlur(texCoord + vec2(-1,  1) * oneTexel);
    float se = gaussianBlur(texCoord + vec2( 1,  1) * oneTexel);

    float gx = nw * -1. + n * 0. + ne * 1. + w * -2. + c * 0. + e * 2. + sw * -1. + s * 0. + se * 1.;
    float gy = nw * -1. + n * -2. + ne * -1. + w * 0. + c * 0. + e * 0. + sw * 1. + s * 2. + se * 1.;

    return vec2(gx, gy);
}


void main() {
    //if(gaussianBlur() != 0.0) fragColor = vec4(1., 0., 0., 1.);
    //else fragColor = vec4(0., 1., 0., 1.);
    //fragColor = vec4(vec3(gaussianBlur()), 1.0);
    fragColor = vec4(sobel().length() > 0. ? vec3(abs(sobel()).x / 2., 0., abs(sobel()).y) : vec3(0.), 1.);
}
