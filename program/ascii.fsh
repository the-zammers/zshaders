#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D textData;

in vec2 texCoord;

uniform vec2 InSize;

out vec4 fragColor;


// Shader printing code by @kishimisu on Shadertoy and YouTube
// https://www.shadertoy.com/view/43t3WX
#define FONT_TEXTURE textData
#define FONT_SPACING 2.

// ======  please let us use moj_import D: ======
// Special characters
#define __    32,
#define _EX   33, // " ! "
#define _DBQ  34, // " " "
#define _NUM  35, // " # "
#define _DOL  36, // " $ "
#define _PER  37, // " % "
#define _AMP  38, // " & "
#define _QT   39, // " ' "
#define _LPR  40, // " ( "
#define _RPR  41, // " ) "
#define _MUL  42, // " * "
#define _ADD  43, // " + "
#define _COM  44, // " , "
#define _SUB  45, // " - "
#define _DOT  46, // " . "
#define _DIV  47, // " / "
#define _COL  58, // " : "
#define _SEM  59, // " ; "
#define _LES  60, // " < "
#define _EQ   61, // " = "
#define _GE   62, // " > "
#define _QUE  63, // " ? "
#define _AT   64, // " @ "
#define _LBR  91, // " [ "
#define _ANTI 92, // " \ "
#define _RBR  93, // " ] "
#define _UN   95, // " _ "

// Digits
#define _0 48,
#define _1 49,
#define _2 50,
#define _3 51,
#define _4 52,
#define _5 53,
#define _6 54,
#define _7 55,
#define _8 56,
#define _9 57,
// Uppercase
#define _A 65,
#define _B 66,
#define _C 67,
#define _D 68,
#define _E 69,
#define _F 70,
#define _G 71,
#define _H 72,
#define _I 73,
#define _J 74,
#define _K 75,
#define _L 76,
#define _M 77,
#define _N 78,
#define _O 79,
#define _P 80,
#define _Q 81,
#define _R 82,
#define _S 83,
#define _T 84,
#define _U 85,
#define _V 86,
#define _W 87,
#define _X 88,
#define _Y 89,
#define _Z 90,
// Lowercase
#define _a 97,
#define _b 98,
#define _c 99,
#define _d 100,
#define _e 101,
#define _f 102,
#define _g 103,
#define _h 104,
#define _i 105,
#define _j 106,
#define _k 107,
#define _l 108,
#define _m 109,
#define _n 110,
#define _o 111,
#define _p 112,
#define _q 113,
#define _r 114,
#define _s 115,
#define _t 116,
#define _u 117,
#define _v 118,
#define _w 119,
#define _x 120,
#define _y 121,
#define _z 122,

#define print_char(i) \
    texture(FONT_TEXTURE, u + vec2(float(i)-float(x)/FONT_SPACING + FONT_SPACING/8., 15-(i)/16) / 16.).r

#define makeStr(func_name)                               \
    float func_name(vec2 u) {                            \
        if (u.x < 0. || abs(u.y - .03) > .03) return 0.; \
        const int[] str = int[](                         \

#define _end  0);                                        \
    int x = int(u.x * 16. * FONT_SPACING);               \
    if (x >= str.length()-1) return 0.;                  \
    return print_char(str[x]);                           \
}
// ======  end  ======


makeStr(line0) _T _h _e __ _F _i _t _n _e _s _s _G _r _a _m __ _P _a _c _e _r __ _T _e _s _t __ _i _s __ _a __ _m _u _l _t _i _s _t _a _g _e __ _end
makeStr(line1) _a _e _r _o _b _i _c __ _c _a _p _a _c _i _t _y __ _t _e _s _t __ _t _h _a _t __ _p _r _o _g _r _e _s _s _i _v _e _l _y __ _g _e _t _s __ _end
makeStr(line2) _m _o _r _e __ _d _i _f _f _i _c _u _l _t __ _a _s __ _i _t __ _c _o _n _t _i _n _u _e _s _DOT __ _T _h _e __ _2 _0 __ _m _e _t _e _r __ _end
makeStr(line3) _p _a _c _e _r __ _t _e _s _t __ _w _i _l _l __ _b _e _g _i _n __ _i _n __ _3 _0 __ _s _e _c _o _n _d _s _DOT __ _L _i _n _e __ _u _p __ _end
makeStr(line4) _a _t __ _t _h _e __ _s _t _a _r _t _DOT __ _T _h _e __ _r _u _n _n _i _n _g __ _s _p _e _e _d __ _s _t _a _r _t _s __ _s _l _o _w _l _y _COM __ _end
makeStr(line5) _b _u _t __ _g _e _t _s __ _f _a _s _t _e _r __ _e _a _c _h __ _m _i _n _u _t _e __ _a _f _t _e _r __ _y _o _u __ _h _e _a _r __ _end
makeStr(line6) _t _h _i _s __ _s _i _g _n _a _l _DOT __ _LBR _b _e _e _p _RBR __ _A __ _s _i _n _g _l _e __ _l _a _p __ _s _h _o _u _l _d __ _b _e __ _end
makeStr(line7) _c _o _m _p _l _e _t _e _d __ _e _a _c _h __ _t _i _m _e __ _y _o _u __ _h _e _a _r __ _t _h _i _s __ _s _o _u _n _d _DOT _LBR _d _i _n _g _RBR __ _end
makeStr(line8) _R _e _m _e _m _b _e _r __ _t _o __ _r _u _n __ _i _n __ _a __ _s _t _r _a _i _g _h _t __ _l _i _n _e _COM __ _a _n _d __ _r _u _n __ _a _s __ _end
makeStr(line9) _l _o _n _g __ _a _s __ _p _o _s _s _i _b _l _e _DOT __ _T _h _e __ _s _e _c _o _n _d __ _t _i _m _e __ _y _o _u __ _f _a _i _l __ _t _o __ _end
makeStr(lineA) _c _o _m _p _l _e _t _e __ _a __ _l _a _p __ _b _e _f _o _r _e __ _t _h _e __ _s _o _u _n _d _COM __ _y _o _u _r __ _t _e _s _t __ _i _s __ _end
/*_o _v _e _r _DOT __ _T _h _e __ _t _e _s _t __ _w _i _l _l __ _b _e _g _i _n __ _o _n __ _t _h _e __ _w _o _r _d __ _s _t _a _r _t _DOT __ _O _n __ _y _o _u _r __ _m _a _r _k _COM __ _g _e _t __ _r _e _a _d _y _COM __ _s _t _a _r _t _DOT _end
*/

void main() {
    vec3 col = vec3(0);
    vec2 uv = texCoord;

    uv.y -= .9;
    uv = uv * .8 - vec2(.02, .0);

    col += vec3( 1,.3,.4) * line0(uv);
    col += vec3(.5, 1, 1) * line1(uv + vec2(0, 0.07));
    col += vec3( 1, 1,.4) * line2(uv + vec2(0, 0.14));
    col += vec3( 1,.3,.4) * line3(uv + vec2(0, 0.21));
    col += vec3(.5, 1, 1) * line4(uv + vec2(0, 0.28));
    col += vec3( 1, 1,.4) * line5(uv + vec2(0, 0.35));
    col += vec3( 1,.3,.4) * line6(uv + vec2(0, 0.42));
    col += vec3(.5, 1, 1) * line7(uv + vec2(0, 0.49));
    col += vec3( 1, 1,.4) * line8(uv + vec2(0, 0.56));
    col += vec3( 1,.3,.4) * line9(uv + vec2(0, 0.63));
    col += vec3(.5, 1, 1) * lineA(uv + vec2(0, 0.70));

    fragColor = vec4(col, 1.0);
}