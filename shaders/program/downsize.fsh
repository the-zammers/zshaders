#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;
in vec2 oneTexel;

uniform vec2 InSize;
uniform vec2 RescaleFactor;

out vec4 fragColor;

vec3 getAverageColor(vec2 start) {
    float r = 0;
    float g = 0;
    float b = 0;
    int n   = 0;
    
    for(int x = 0; x < RescaleFactor.x; x++) {
        for(int y = 0; y < RescaleFactor.y; y++) {
            vec3 curr = texture(DiffuseSampler, start + vec2(x, y) * oneTexel).rgb;
            r += curr.r * curr.r;
            g += curr.g * curr.g;
            b += curr.b * curr.b;
            n++;
        }
    }

    return vec3(sqrt(r/n), sqrt(g/n), sqrt(b/n));
}

void main() {
    vec2 rescaledInSize = InSize / RescaleFactor;
    vec2 rescaledTexCoord = floor(texCoord * rescaledInSize) / rescaledInSize;
    vec3 color = getAverageColor(rescaledTexCoord);
    fragColor = vec4(color, 1.0);
}
