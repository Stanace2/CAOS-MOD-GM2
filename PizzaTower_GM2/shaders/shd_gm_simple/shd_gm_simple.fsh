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

    vec4 tail = vec4(tailR, tailG, tailB, 255.0) / 255.0;
    vec4 nose = vec4(noseR, noseG, noseB, 255.0) / 255.0;

    tail.a = source.a;
    nose.a = source.a;

    if (length(source.rgb) <= 0.001)
        gl_FragColor = tail;
    else
        gl_FragColor = nose;

    if (source.a <= 0.004)
        gl_FragColor = source;
}