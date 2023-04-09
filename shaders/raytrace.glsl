////////////////////////////////////////////////////////////////////////////////
/// delete for use in shadertoy
////////////////////////////////////////////////////////////////////////////////

#version 150

out vec4 fragColor;

uniform vec2 iResolution;
uniform float iTime;
uniform float iTimeDelta;
uniform int iFrame;
uniform vec4 iMouse;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
uniform vec4 iDate;
uniform float iSampleRate;

void mainImage(out vec4, in vec2);
void main(void) { mainImage(fragColor,gl_FragCoord.xy); }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const int MAX_STEPS = 255;
const float MIN_DIST = 0.0001f;
const float MAX_DIST = 100.0f;
const float EPSILON = 0.0001f;

vec2 toClip(in vec2 fragCoord) {
    return 2.0f * (fragCoord/iResolution.xy) - 1.0f;
}

vec2 fixAspectRatio(in vec2 clipCoord) {
    float aspectRatio = iResolution.x / iResolution.y;
    clipCoord.y /= aspectRatio;
    return clipCoord;
}

// Signed Distance Function
float sphereSdf(vec3 point, vec3 center, float radius) {
    return length(point - center) - radius;
}

vec3 sphereNormalApproximation(vec3 p, vec3 center, float radius) {
    vec3 right   = vec3(EPSILON,    0.0f,    0.0f);
    vec3 up      = vec3(   0.0f, EPSILON,    0.0f);
    vec3 forward = vec3(   0.0f,    0.0f, EPSILON);

    return normalize(vec3(
        sphereSdf(p + right,   center, radius) - sphereSdf(p - right,   center, radius),
        sphereSdf(p + up,      center, radius) - sphereSdf(p - up,      center, radius),
        sphereSdf(p + forward, center, radius) - sphereSdf(p - forward, center, radius)
    ));
}

struct HitInfo
{
    float hit;
    vec3 hitPos;
    vec3 color;
    vec3 normal;
};

HitInfo scene(vec3 p) {
    HitInfo result;
    result.hit = MAX_DIST;
    
    float hit;
    
    hit = sphereSdf(p, vec3(0.0f, 0.0f, 5.0f), 1.0f);
    if(result.hit > hit)
    {
        result.hit = hit;
        result.color = vec3(1.0f, 0.0f, 0.0f);
        result.normal = sphereNormalApproximation(p, vec3(0.0f, 0.0f, 5.0f), 1.0f);
    }
    
    return result;
}

HitInfo raycast(vec3 rayBegin, vec3 rayDir) {
    HitInfo result;

    float depth = 0.0f;
    vec3 hitPos = vec3(0.0f);
    for (int i = 0; i < MAX_STEPS; ++i) {
        result = scene(hitPos = rayBegin + depth * rayDir);
        if (result.hit < EPSILON) {
            result.hit = 1.0f;
            result.hitPos = hitPos;
            return result;
        }
        
        depth += result.hit;
    
        if (depth > MAX_DIST - EPSILON) {
            result.hit = 0.0f;
            return result;
        }
    }
    
    result.hit = 0.0f;
    return result;
}

vec3 lambert(HitInfo info, vec3 lightPos) {    
    vec3 lightVector = normalize(lightPos - info.hitPos);
    return info.color * max(0.0, dot(info.normal, lightVector));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 clip = toClip(fragCoord);
    
    vec3 rayBegin = vec3(0.0f, 0.0f, 0.0f);
    vec3 rayTarget = vec3(fixAspectRatio(clip), 1.0f);
    vec3 rayDir = normalize(rayTarget - rayBegin);
    
    HitInfo info = raycast(rayBegin, rayDir);

    fragColor = info.hit * vec4(lambert(info, vec3(5.0f, 0.0f, 0.0f)), 1.0f);
}
