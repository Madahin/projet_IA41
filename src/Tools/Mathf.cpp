#include "include/Tools/Mathf.hpp"

bool Mathf::Approx(float a_First, float a_Second)
{
    const long t_First = floorf(a_First * 10000);
    const long t_Second = floorf(a_Second * 10000);

    return (t_First == t_Second);
}

float Mathf::PingPong(float a_Value, float a_Length)
{
    if(a_Value < a_Length){
        return a_Value;
    }else{
        const int t_Indicator = floorf(a_Value / a_Length);
        if(t_Indicator % 2 == 0){
            return fmodf(a_Value, a_Length);
        }else{
            return a_Length - fmodf(a_Value, a_Length);
        }
    }
}

float Mathf::Lerp(float a_First, float a_Second, float a_Delta)
{
    if(a_Delta <= 0){
        return a_First;
    }else if(a_Delta >= 1){
        return a_Second;
    }else{
        return (a_First + (a_Second - a_First) * a_Delta);
    }
}
