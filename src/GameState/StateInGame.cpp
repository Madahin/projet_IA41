#include "include/GameState/StateInGame.hpp"

StateInGame::StateInGame() :
    m_input(InputManager::Get())
{
}

void StateInGame::Init()
{
}

void StateInGame::Free()
{
}

void StateInGame::Draw(sf::RenderWindow &a_window)
{
}

void StateInGame::Event()
{
    if(m_input.CanGetEvent()){
        switch (m_input.KeyPressed()) {
            case sf::Keyboard::Up:
            {
                break;
            }
        }
        switch (m_input.KeyReleased()) {
            case sf::Keyboard::Up:
            {
                break;
            }
        }
    }
}

void StateInGame::Update()
{

}

void StateInGame::Pause()
{
}

void StateInGame::UnPause()
{
}
