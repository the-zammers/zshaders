#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D TextData;

in vec2 texCoord;

uniform vec2 InSize;
uniform vec2 RescaleFactor;

out vec4 fragColor;

float luminance(vec3 color) {
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

// SPACE . ; c o P O ? @ BLOCK, indexed by row then column
const ivec2 symbolLocations[10] = ivec2[](ivec2(0,0), ivec2(2, 14), ivec2(3, 11), ivec2(6, 3), ivec2(6, 15), ivec2(5,0), ivec2(4,15), ivec2(3,15), ivec2(4,0), ivec2(13,11));

void main() {
    vec2 rescaledInSize = InSize / RescaleFactor;
    vec2 rescaledTexCoord = floor(texCoord * rescaledInSize) / rescaledInSize;
    vec2 fractOffset = fract(texCoord * rescaledInSize) * RescaleFactor;
    vec2 metapixelOffset = vec2(fractOffset.x / 8., 1. - fractOffset.y / 8.);

    vec4 color = texture(DiffuseSampler, rescaledTexCoord) * 1.4;

    float relativeBrightness = luminance(color.rgb);
    int symbolIndex = max(0, min(9, int(relativeBrightness * 10)));
    vec2 symbolLocation = vec2(symbolLocations[symbolIndex].yx);
    vec4 symbol = texture(TextData, (symbolLocation + metapixelOffset) / vec2(16.));

    fragColor = vec4(symbol.a * color.rgb, 1.0);
}