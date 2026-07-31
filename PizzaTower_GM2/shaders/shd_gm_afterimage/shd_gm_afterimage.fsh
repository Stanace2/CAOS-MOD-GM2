//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float tailR;
uniform float tailG;
uniform float tailB;

uniform float noseR;
uniform float noseG;
uniform float noseB;

void main()
{
    vec4 source = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

    vec3 tail = vec3(tailR, tailG, tailB) / 255.0;
    vec3 nose = vec3(noseR, noseG, noseB) / 255.0;

    vec3 monoBlack = vec3(0.0, 0.0, 0.0) / 255.0;
    vec3 monoWhite = vec3(255.0, 255.0, 255.0) / 255.0;

    float gray = dot(source.rgb, vec3(0.299, 0.587, 0.114));

    vec3 monochrome = mix(monoBlack, monoWhite, gray);

    float gray2 = dot(monochrome, vec3(0.299, 0.587, 0.114));

    vec3 finalColor = mix(tail, nose, gray2);

    gl_FragColor = vec4(finalColor, source.a);

    if (source.a <= 0.004)
        gl_FragColor = source;
}
