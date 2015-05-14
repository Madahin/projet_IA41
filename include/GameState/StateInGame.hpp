#ifndef STATEINGAME_HPP
#define STATEINGAME_HPP

#include "include/Manager/InputManager.hpp"
#include "include/GameState/State.hpp"
#include <iostream>

class StateInGame : public State
{
public:
    StateInGame();

    void Init() override;
    void Free() override;
    void Draw(sf::RenderWindow &a_window) override;
    void Event() override;
    void Update() override;
    void Pause() override;
    void UnPause() override;

private:
    InputManager& m_input;
};

#endif // STATEINGAME_HPP
