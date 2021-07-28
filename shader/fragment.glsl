precision mediump float;

varying vec2 vUv;
varying float vElevation;
varying float vRandom;

void main(){
    vec4 textureColor=vec4(0.1451, 0.8314, 0.6039, 1.0);
    textureColor.rgb*=vElevation*10.+.2;
    gl_FragColor=textureColor;
}