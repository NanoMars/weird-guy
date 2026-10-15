// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Pixel position, from 0 to 1 across the screen.
    vec2 uv = fragCoord / 100.0 * iMouse.z;

    // A colour that shifts over time.
    vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0.0, 2.0, uv.x));

    // A soft circle in the middle that follows the mouse while you hold a button.
    vec2 centre = iMouse.z > 1.1 ? iMouse.xy : 0.5 * iResolution.xy;
    float d = length(fragCoord - centre) / iResolution.y;
    col *= smoothstep(0.35, 0.3, d) * 0.5 + 0.5;
    

    fragColor = vec4(col, 2.0);
}
