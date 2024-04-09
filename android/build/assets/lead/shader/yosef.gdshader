shader_type canvas_item;

// Uniform que controla la intensidad del desenfoque
uniform float blur_strength : hint_range(0.0, 5.0) = 1.0;

// Agrega la declaración del uniform SCREEN_TEXTURE
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


void fragment() {
    // Coordenadas UV del fragmento
    vec2 uv = SCREEN_UV;

    // Desplazamiento del fragmento para aplicar el desenfoque
    vec2 offset = vec2(0.009, 0.007) * blur_strength;

    // Sumar el desplazamiento para cada muestra de desenfoque
    vec4 result = textureLod(SCREEN_TEXTURE, uv - 4.0 * offset, 0.0) * 0.05;
    result += textureLod(SCREEN_TEXTURE, uv - 3.0 * offset, 0.0) * 0.09;
    result += textureLod(SCREEN_TEXTURE, uv - 2.0 * offset, 0.0) * 0.12;
    result += textureLod(SCREEN_TEXTURE, uv - offset, 0.0) * 0.15;
    result += textureLod(SCREEN_TEXTURE, uv, 0.0) * 0.16;
    result += textureLod(SCREEN_TEXTURE, uv + offset, 0.0) * 0.15;
    result += textureLod(SCREEN_TEXTURE, uv + 2.0 * offset, 0.0) * 0.12;
    result += textureLod(SCREEN_TEXTURE, uv + 3.0 * offset, 0.0) * 0.09;
    result += textureLod(SCREEN_TEXTURE, uv + 4.0 * offset, 0.0) * 0.05;

    // Asignar el color final al fragmento
    COLOR = result;
}
