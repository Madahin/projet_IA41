#ifndef STATEMENU_HPP
#define STATEMENU_HPP

#include "include/GameState/State.hpp"
#include "include/GameState/StateMenuColor.hpp"
#include "include/GameState/StateInGame.hpp"
#include "include/GUI/GUI.hpp"
#include "include/GUI/Widget/WGButton.hpp"
#include "include/Tools/auto_Texture.hpp"
#include "include/Board.hpp"
#include <SFML/Graphics.hpp>
#include <vector>
#include <memory>
#include <iostream>

class StateMenu : public State
{
public:
    StateMenu();

    void Init() override;
    void Free() override;
    void Draw(sf::RenderWindow &a_window) override;
    void Event() override;
    void Update() override;
    void Pause() override;
    void UnPause() override;

private:
    GUI m_gui;
    std::vector<std::shared_ptr<WGButton>> m_Buttons;
    autoTexture m_BoardTexture;
    sf::Sprite m_BoardSprite;

};

#endif // STATEMENU_HPP
