#include "include/GUI/Widget/WGButton.hpp"

WGButton::WGButton(const sf::FloatRect &a_Pos, const std::string& a_sName, const std::string& a_sTextureName="")
{
    m_Position = a_Pos;
    m_Texture = ResourcesSingleton::Get().GetTexture(a_sTextureName);
    m_Button.setTexture(m_Texture);
    SetRect(a_Pos.left, a_Pos.top, a_Pos.width, a_Pos.height);
    m_ButtonName.setString(a_sName);
    m_ButtonName.setFont(ResourcesSingleton::Get().GetFont("Ressources/Fonts/default.ttf"));
    CenterName();
}

WGButton::~WGButton()
{
}

void WGButton::Draw(sf::RenderWindow &a_Window)
{
    a_Window.draw(m_Button);
    a_Window.draw(m_ButtonName);
}

bool WGButton::Control(sf::Event &a_Event)
{
    return false;
}

#include <iostream>

bool WGButton::Clicked(sf::Vector2i a_MousePos)
{
    if(m_Position.contains(a_MousePos.x, a_MousePos.y)){
        //std::cout << m_Position.left << ", " << m_Position.top << ", " << m_Position.width << ", " << m_Position.height << std::endl;
        return true;
    }
    return false;
}

void WGButton::SetRect(float a_fLeft, float a_fTop, float a_fWidth, float a_fHeight)
{
    Widget::SetRect(a_fLeft, a_fTop, a_fWidth, a_fHeight);
    m_Button.setPosition(m_Position.left, m_Position.top);
    m_Button.setScale(m_Position.width / m_Button.getLocalBounds().width, m_Position.height / m_Button.getLocalBounds().height);
    CenterName();
}

void WGButton::SetTexRect(const sf::IntRect &texRect)
{
    m_Button.setTextureRect(texRect);
}

void WGButton::SetName(const std::string &a_sName)
{
    m_ButtonName.setString(a_sName);
    CenterName();
}

void WGButton::CenterName()
{
    sf::FloatRect t_Bound = m_ButtonName.getGlobalBounds();
    m_ButtonName.setPosition(m_Position.left + (m_Position.width - t_Bound.width) * 0.5f,
                             m_Position.top + (m_Position.height - t_Bound.height) * 0.5f);// - 12 * m_ButtonName.getScale().y);
}
