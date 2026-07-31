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

    float gray = dot(source.rgb, vec3(0.299, 0.587, 0.114));

    vec3 color = mix(tail, nose, gray);

    gl_FragColor = vec4(color, source.a);

    if (source.a <= 0.004)
        gl_FragColor = source;
}
