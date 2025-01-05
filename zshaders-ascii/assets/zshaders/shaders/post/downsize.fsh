#version 150

uniform sampler2D InSampler;

in vec2 texCoord;

uniform vec2 InSize;
uniform vec2 RescaleFactor;

out vec4 fragColor;

vec2 oneTexel = 1.0 / InSize;

vec3 getAverageColor(vec2 start) {
    vec3 acc = vec3(0);
    int n   = 0;
    
    for(int x = 0; x < RescaleFactor.x; x++) {
        for(int y = 0; y < RescaleFactor.y; y++) {
            vec3 curr = texture(InSampler, start + vec2(x, y) * oneTexel).rgb;
            acc += curr * curr;
            n++;
        }
    }

    return sqrt(acc / n);
}

void main() {
    vec2 rescaledInSize = InSize / RescaleFactor;
    vec2 rescaledTexCoord = floor(texCoord * rescaledInSize) / rescaledInSize;
    vec3 color = getAverageColor(rescaledTexCoord);
    fragColor = vec4(color, 1.0);
}
