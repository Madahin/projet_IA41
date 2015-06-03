#ifndef BOARD_HPP
#define BOARD_HPP

#include <array>
#include "include/Tools/Tools.hpp"
#include "include/Case.hpp"
#include "include/BoardState.hpp"
#include <cstdarg>
#include <memory>

class Board
{
public:
    static Board& Get();

    bool Empty();

    void SetGameType(int type);
    int GetGameType();

    bool IsPlayerIA(bool player);

    BoardState& GetCurrentState();

    void InverseOrder();

private:
    static Board* m_instance;
    Board();
    BoardState m_CurrentState;
    int m_gameType;
    bool m_isPlayer1IA;
    bool m_isPlayer2IA;
};



#endif // BOARD_HPP
