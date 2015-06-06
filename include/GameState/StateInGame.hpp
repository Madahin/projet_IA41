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
    virtual ~StateInGame();

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
    int MinMax(BoardState &state, int depth, bool maxPlayer);
    int minimax(BoardState state, int depth, int a, int b, bool max);
    void ComputePlayableMove();
    void PlayMove(Move m);
    void PrintPossibleMove(const std::vector<Move> &possibleMoves);
    void PrintMove(const Move &m);
    sf::Texture m_moveTex;
    autoTexture m_BoardTexture;
    autoTexture m_TokenTileset;
    sf::Sprite m_BoardSprite;
    sf::Sprite m_winnerSprite;
    sf::Sprite m_whosPlaying;
    sf::Text m_WinnerText;
    std::vector<sf::Sprite> m_EmplacementSprite;
    std::array<sf::Sprite, 6> m_TokenSprite;
    std::array<sf::Sprite, 9> m_AvaibleMove;
    std::array<bool, 9> m_ShowAvaibleMove;
    bool m_EvenPhase;
    sf::Clock m_IAClock;
    Move m_CurrentPlayerMove;
    bool m_hasClicked;
    bool m_ignoreFirstClick;
    bool m_hasWinner;
    Color m_ColorClicked;

    static const unsigned int MAX_DEPTH = 5;
};

#endif // STATEINGAME_HPP
