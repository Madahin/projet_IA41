#ifndef STATEINGAME_HPP
#define STATEINGAME_HPP

#include "include/GameState/State.hpp"
#include "include/Tools/auto_Texture.hpp"
#include "include/Board.hpp"
#include "include/BoardState.hpp"
#include <SFML/Graphics.hpp>
#include <vector>
#include <array>
#include <memory>
#include <utility>
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

    sf::Vector2i GetCaseClicked(sf::Vector2i mousePos);

private:
    Move IAMovement();
    void PlayMove(Move m);
    void PrintPossibleMove(const std::vector<Move> &possibleMoves);
    autoTexture m_BoardTexture;
    autoTexture m_TokenTileset;
    sf::Sprite m_BoardSprite;
    std::vector<sf::Sprite> m_EmplacementSprite;
    std::array<sf::Sprite, 6> m_TokenSprite;
    bool m_EvenPhase;
    sf::Clock m_IAClock;
    Move m_CurrentPlayerMove;
    bool m_hasClicked;
    bool m_ignoreFirstClick;

};

#endif // STATEINGAME_HPP
