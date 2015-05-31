#include "include/GameState/StateMenu.hpp"

StateMenu::StateMenu()
{
    m_BoardTexture = ResourcesSingleton::Get().GetTexture("Ressources/Texture/board.png");
    m_BoardSprite.setTexture(m_BoardTexture);

    m_input.SignInDelegat(m_gui);

    std::vector<std::string> buttonString = {"Joueur VS Joueur", "Joueur VS IA", "IA VS IA"};
    for(unsigned int i=0; i < buttonString.size(); ++i)
    {
        std::shared_ptr<Widget> button(new WGButton(sf::FloatRect(156, 150 + 150*i, 456, 122), buttonString[i], "Ressources/Texture/ButtonUP.png"));
        button->AddOnClickUpBehavior([this,i](int id){
            Board::Get().SetGameType(i);
            if(i == 1){
                m_manager->PushState(new StateMenuColor);
            }else{
                m_manager->PushState(new StateInGame);
            }
        });
        m_gui.AddWidget(button);
    }
}

void StateMenu::Init()
{
}

void StateMenu::Free()
{
}

void StateMenu::Draw(sf::RenderWindow &a_window)
{
    a_window.draw(m_BoardSprite);


    m_gui.DrawGUI(a_window);
}

void StateMenu::Event()
{
}

void StateMenu::Update()
{

}

void StateMenu::Pause()
{
    m_gui.Toggle(false);
}

void StateMenu::UnPause()
{
    m_gui.Toggle(true);
}
