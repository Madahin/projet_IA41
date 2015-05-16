#include "include/Power3State.hpp"

Power3State::Power3State()
{

}

Power3State& Power3State::get()
{
    static Power3State instance;
    return instance;
}
