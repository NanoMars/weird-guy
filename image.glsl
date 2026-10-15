float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 4113758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    uv.x /= 1000.0;
    uv.y /= 1.0;

    // Random value per pixel, re-rolled every frame
    float r = rand(uv + iTime * 0.9);
    

    vec3 col = vec3(1.0, 1.0, 1.0);
    col *= smoothstep(vec3(r, r ,r));   // blend in some static

    fragColor = vec4(col, 0.0);
}