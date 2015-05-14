#include "include/Jeu.hpp"

Jeu::Jeu() :
    m_window()
{
}

void Jeu::launch()
{
    m_window.create(sf::VideoMode(1024, 780, 32), "IA41-Puissance3");
    m_window.setVerticalSyncEnabled(true);

    InputManager& t_Input = InputManager::Get();
    t_Input.SetWindow(m_window);
    m_manager.PushState(new StateInGame);

    bool t_bIsOpen = true;

    sf::Clock t_Clock;
    sf::Int64 t_iLag = 0;

    while(t_bIsOpen)
    {
        sf::Int64 t_iElapsed = t_Clock.restart().asMicroseconds();
        t_iLag += t_iElapsed;

        sf::Event t_event;
        while(m_window.pollEvent(t_event))
        {
            switch (t_event.type) {
                case sf::Event::Closed:
                {
                    t_bIsOpen = false;
                    break;
                }
                case sf::Event::GainedFocus:
                {
                    m_manager.GetState()->UnPause();
                    break;
                }
                case sf::Event::LostFocus:
                {
                    m_manager.GetState()->Pause();
                    break;
                }
                case sf::Event::Resized:
                {
                    sf::View t_newView = m_window.getView();
                    t_newView.setSize(t_event.size.width, t_event.size.height);
                    t_newView.setViewport(sf::FloatRect(0, 0, 1, 1));
                    m_window.setView(t_newView);
                }
                default:
                {
                    t_Input.SetEvent(t_event);
                    m_manager.GetState()->Event();
                    break;
                }
            }
        }

        while(t_iLag >= MS_PER_UPDATE){
            m_manager.GetState()->Update();
            t_iLag -= MS_PER_UPDATE;
        }

        m_window.clear();
        m_manager.GetState()->Draw(m_window);
        m_window.display();
    }
}
