shader_type spatial;

uniform float cval = 0.0;
uniform vec4 shade : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float shade_radius = 0.5;

void fragment() {
    vec2 uv = UV;

    float dist_center = distance(uv, vec2(0.5, 0.5));
    float dist_shade = distance(uv, vec2(cval, 0.5));

    float moon = smoothstep(shade_radius, shade_radius - 0.01, dist_center);
    float shadow = smoothstep(shade_radius, shade_radius - 0.01, dist_shade);

    vec3 base_color = vec3(0.8); // moon gray

    base_color *= moon;
    base_color = mix(base_color, shade.rgb, shadow);

    ALBEDO = base_color;
    ALPHA = moon;
}