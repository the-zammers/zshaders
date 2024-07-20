#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;
in vec2 sampleStep;

uniform vec2 InSize;
uniform float Radius;
uniform float RadiusMultiplier;

out vec4 fragColor;

#define RADIUS 5
#define MIN(a,b) ((a) < (b) ? (a) : (b))
vec2 texelSize = vec2(1.0 / InSize.x, 1.0 / InSize.y);


int getOctant(int x, int y) {
	if(0 <= y && y <= x) return 0;
	else if(0 <=  x &&  x <=  y) return 1;
	else if(0 <= -x && -x <=  y) return 2;
	else if(0 <=  y &&  y <= -x) return 3;
	else if(0 <= -y && -y <= -x) return 4;
	else if(0 <= -x && -x <= -y) return 5;
	else if(0 <=  x &&  x <= -y) return 6;
	else if(0 <= -y && -y <=  x) return 7;
}

vec3 getOctantMean(int octant) {
	vec3 acc = vec3(0);
	int samples = 0;
	for(int y = -RADIUS; y<=RADIUS; y++) {
		for(int x = -RADIUS; x<=RADIUS; x++) {
			vec3 curr = texture(DiffuseSampler, texCoord + vec2(texelSize.x * x, texelSize.y * y)).rgb;
			if(getOctant(x,y) == octant && x*x + y*y <= RADIUS*RADIUS) {
				samples++;
				acc += curr;
			}
		}
	}
	return acc / float(samples);
}

float getOctantStd(int octant, vec3 mean) {
	vec3 acc = vec3(0);
	int samples = 0;
	for(int y = -RADIUS; y<=RADIUS; y++) {
		for(int x = -RADIUS; x<=RADIUS; x++) {
			vec3 curr = texture(DiffuseSampler, texCoord + vec2(texelSize.x * x, texelSize.y * y)).rgb;
			if(getOctant(x,y) == octant && x*x + y*y <= RADIUS*RADIUS) {
				samples++;
				acc += (curr - mean) * (curr - mean);
			}
		}
	}
	acc = sqrt(acc/float(samples));
	return acc.r * acc.g * acc.b;
}

// This shader relies on GL_LINEAR sampling to reduce the amount of texture samples in half.
// Instead of sampling each pixel position with a step of 1 we sample between pixels with a step of 2.
// In the end we sample the last pixel with a half weight, since the amount of pixels to sample is always odd (actualRadius * 2 + 1).
void main() {
    float minStd = 10000000000.0;
	vec3 col = vec3(0);
	vec3 currMean;
	float currStd;
	for(int i=0; i<8; i++) {
		currMean = getOctantMean(i);
		currStd = getOctantStd(i, currMean);
		if(currStd<minStd) {
			minStd = currStd;
			col = currMean;
		}
	}
	
	fragColor = vec4(col.rgb, 1.0);
}
