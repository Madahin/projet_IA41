#ifndef JEU
#define JEU

#include <SFML/Graphics.hpp>
#include "include/Manager/InputManager.hpp"
#include "include/Manager/StateManager.hpp"
#include "include/GameState/StateMenu.hpp"

class Jeu
{
public:
    Jeu();

    void launch();

private:
    sf::RenderWindow m_window;
    StateManager m_manager;

    const sf::Int64 MS_PER_UPDATE = static_cast<sf::Int64>((1.0 / 180.0) * 1000000);
};

#endif
