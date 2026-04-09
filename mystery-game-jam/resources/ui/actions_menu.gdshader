shader_type canvas_item;

uniform sampler2D noise_texture;
uniform vec4 grain_color : source_color = vec4(1.0);
uniform float grain_strength : hint_range(0.0,1.0) = 0.08;
uniform float grain_speed : hint_range(0.0,10.0) = 1.5;

void fragment() {
    vec2 uv = UV;

    vec2 uv1 = fract(uv + TIME * grain_speed * 0.7);
    vec2 uv2 = fract(uv + vec2(0.37, 0.83) + TIME * grain_speed * 1.3);

    float noise1 = texture(noise_texture, uv1).r;
    float noise2 = texture(noise_texture, uv2).r;

    float noise = (noise1 + noise2 - 1.0) * grain_strength;

    vec4 base_color = texture(TEXTURE, uv);
    base_color.rgb += noise * grain_color.rgb;

    COLOR = base_color;
}