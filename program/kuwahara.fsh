#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

uniform vec2 InSize;

out vec4 fragColor;

#define RADIUS 5
#define MIN(a,b) ((a) < (b) ? (a) : (b))
vec2 texelSize = vec2(1.0 / InSize.x, 1.0 / InSize.y);

float luminance(vec3 color) {
    return max(0.00001, dot(color, vec3(0.2127, 0.7152, 0.0722)));
}

vec4 getQuadrant(int minx, int maxx, int miny, int maxy, float n) {
    float luminanceSum = 0.0;
    float luminanceSum2 = 0.0;
    vec3 colSum = vec3(0.0);

    for(int x = minx; x <= maxx; x++) {
        for(int y = miny; y <= maxy; y++) {
            vec3 c = texture(DiffuseSampler, texCoord + vec2(texelSize.x * x, texelSize.y * y)).rgb;
            float l = luminance(c);
            luminanceSum += l;
            luminanceSum2 += l * l;
            colSum += c;
        }
    }

    float mean = luminanceSum / n;
    float std = abs(luminanceSum2 / n - mean*mean);
    return vec4(colSum / n, std);
}

void main() {
    int numSamples = (RADIUS + 1) * (RADIUS + 1);

    vec4 qs[4];
    qs[0] = getQuadrant(-RADIUS, 0, -RADIUS, 0, numSamples);
    qs[1] = getQuadrant(0, RADIUS, -RADIUS, 0, numSamples);
    qs[2] = getQuadrant(0, RADIUS, 0, RADIUS, numSamples);
    qs[3] = getQuadrant(-RADIUS, 0, 0, RADIUS, numSamples);

    float lowestStd = qs[0].a;
    vec3 color = qs[0].rgb;
    for(int i=1; i<4; i++) {
        if(qs[i].a < lowestStd) {
            lowestStd = qs[i].a;
            color = qs[i].rgb;
        }
    }
    fragColor = vec4(color, 1.0);
}