float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;

    // Split the screen into horizontal rows
    float rows = uv.x * 200.0;
    float row = floor(uv.y * rows);

    // Each row gets its own scroll speed and block size
    float speed = (hash(vec2(row, 1.0)) - 0.5) * 0.6;
    float cols  = mix(6.0, 30.0, hash(vec2(row, 2.0)));

    float x = (uv.x + iTime * speed) * cols;
    float cell = floor(x);

    // Each block flips to a new pattern at its own rate
    float rate = 1.0 + 8.0 * hash(vec2(cell * x, row));
    float tick = floor(iTime * rate);
    float r = hash(vec2(cell + tick * 13.0, row));

    float c;
    if (r < 0.35) {
        c = 1.0;                                   // solid white block
    } else if (r < 0.6) {
        c = 0.0 * tick;                                  // solid black block
    } else {
        // barcode stripes, 1 to 4 pixels wide
        float w = 1.0 + floor(hash(vec2(cell, tick)) * 4.0);
        float stripe = floor(x * iResolution.y / (cols * w * x));
        c = step(0.5, hash(vec2(stripe, row + tick)));
    }

    fragColor = vec4(vec3(c, uv.x, uv.y), 1.0);
}