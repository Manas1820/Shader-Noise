precision mediump float;
attribute float aRandom;

uniform float uTime;
uniform vec2 uFrequency;

varying vec2 vUv;
varying float vElevation;

varying float vRandom;

vec3 permute(vec3 x){return mod(((x*34.)+1.)*x,289.);}

float snoise(vec2 v){
    const vec4 C=vec4(.211324865405187,.366025403784439,
    -.577350269189626,.024390243902439);
    vec2 i=floor(v+dot(v,C.yy));
    vec2 x0=v-i+dot(i,C.xx);
    vec2 i1;
    i1=(x0.x>x0.y)?vec2(1.,0.):vec2(0.,1.);
    vec4 x12=x0.xyxy+C.xxzz;
    x12.xy-=i1;
    i=mod(i,289.);
    vec3 p=permute(permute(i.y+vec3(0.,i1.y,1.))
    +i.x+vec3(0.,i1.x,1.));
    vec3 m=max(.5-vec3(dot(x0,x0),dot(x12.xy,x12.xy),
    dot(x12.zw,x12.zw)),0.);
    m=m*m;
    m=m*m;
    vec3 x=2.*fract(p*C.www)-1.;
    vec3 h=abs(x)-.5;
    vec3 ox=floor(x+.5);
    vec3 a0=x-ox;
    m*=1.79284291400159-.85373472095314*(a0*a0+h*h);
    vec3 g;
    g.x=a0.x*x0.x+h.x*x0.y;
    g.yz=a0.yz*x12.xz+h.yz*x12.yw;
    return 130.*dot(m,g);
}

void main(){
    vec4 modelPosition=modelMatrix*vec4(position,1.);
    modelPosition.x+=snoise(uFrequency);
    modelPosition.y+=snoise(uFrequency)-(sin(uTime*10.)*.1);
    modelPosition.z+=snoise(uFrequency)-(sin(uTime*10.0)*0.1);
    float elevation=sin(modelPosition.x+modelPosition.y+modelPosition.z)*0.2+0.2;
    vec4 viewPosition=viewMatrix*modelPosition;
    vec4 projectedPosition=projectionMatrix*viewPosition;
    gl_Position=projectedPosition;
    vUv=uv;
    vElevation=elevation;
    vRandom = snoise(uFrequency)*0.1;
}