#ifndef MATHF
#define MATHF

#include <cmath>

namespace Mathf
{
    const float PI = 3.14159265359f;
    const float DEG2RAD = PI / 180.f;
    const float RAD2DEG = 180 / PI;

    bool Approx(float a_First, float a_Second);
    float PingPong(float a_Value, float a_Length);
    float Lerp(float a_First, float a_Second, float a_Delta);
}

#endif
