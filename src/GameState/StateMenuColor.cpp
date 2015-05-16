#include "include/GameState/StateMenuColor.hpp"

StateMenuColor::StateMenuColor()
{
    m_BoardTexture = ResourcesSingleton::Get().GetTexture("Ressources/Texture/board.png");
    m_BoardSprite.setTexture(m_BoardTexture);

    m_input.SignInDelegat(m_gui);

    for(int i=0; i < 2; ++i)
    {
        std::shared_ptr<Widget> Token(new WGButton(sf::FloatRect(118+300*i, 208, 696, 232), "", "Ressources/Texture/Token.png"));
        Token->AddOnClickUpBehavior([this, i](int id){if(i == 1)Board::Get().InverseOrder();m_manager->PushState(new StateInGame);});
        ((WGButton*)Token.get())->SetTexRect(sf::IntRect(232+232*i, 0, 232, 232));
        Token->SetRect(118+300*i, 208, 232, 232);
        m_gui.AddWidget(Token);
    }
}

void StateMenuColor::Init()
{
}

void StateMenuColor::Free()
{
}

void StateMenuColor::Draw(sf::RenderWindow &a_window)
{
    a_window.draw(m_BoardSprite);

    m_gui.DrawGUI(a_window);
}

void StateMenuColor::Event()
{
}

void StateMenuColor::Update()
{

}

void StateMenuColor::Pause()
{
    m_gui.Toggle(false);
}

void StateMenuColor::UnPause()
{
    m_gui.Toggle(true);
}
