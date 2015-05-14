#ifndef INPUTMANAGER
#define INPUTMANAGER

#include <iostream>
#include <memory>
#include <vector>
#include <functional>
#include <SFML/Window/Event.hpp>
#include <SFML/Window/Window.hpp>

#include "include/GUI/GUI.hpp"

class GUI;

class InputManager
{
public:
    enum MOUSE_PHASE { NO_PHASE, DOWN, UP};
    static InputManager& Get();
    void SetEvent(sf::Event& a_Event);
    void Reset();
    void SetWindow(sf::RenderWindow& a_Window);
    void MoveView(int x, int y);
    void CenterView(int x, int y);

    bool CanGetEvent();

    void ComputeInputPhase();
    void ComputeMousePos();

    void SignalDelegat();

    void SignInDelegat(GUI &a_Obj);
    void SignOutDelegat(GUI &a_Obj);

    sf::Uint32 TextEntered();
    int KeyPressed();
    int KeyReleased();
    int MouseWheelMoved();
    bool MouseButtonPressed(short a_Button);
    bool MouseButtonReleased(short a_Button);
    bool LostFocus();
    bool GainedFocus();
    sf::Vector2i GetMousePos();
    MOUSE_PHASE GetMousePhase();

private:
    InputManager();
    ~InputManager();

private:
    bool m_bUsable;
    sf::RenderWindow* m_Window;
    sf::Event m_Event;
    MOUSE_PHASE m_MousePhase;
    sf::Vector2i m_MousePos;
    std::vector<std::pair<GUI, std::function<bool(sf::Vector2i)>>> m_RegistredApp;

    unsigned int m_IDTrack;
};

#endif
