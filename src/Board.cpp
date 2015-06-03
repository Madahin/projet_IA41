#include "include/Board.hpp"

Board *Board::m_instance=nullptr;

Board::Board()
{
}

Board& Board::Get()
{
    if(m_instance == nullptr){
        m_instance = (new Board);
    }
    return *m_instance;
}

void Board::SetGameType(int type)
{
    m_gameType = type;
    switch(type)
    {
        case 0:
        {
            m_isPlayer1IA = false;
            m_isPlayer2IA = false;
            break;
        }
        case 1:
        {
            m_isPlayer1IA = false;
            m_isPlayer2IA = true;
            break;
        }
        case 2:
        {
            m_isPlayer1IA = true;
            m_isPlayer2IA = true;
            break;
        }
    }
}

int Board::GetGameType()
{
    return m_gameType;
}

bool Board::IsPlayerIA(bool player)
{
    return ((player)?m_isPlayer1IA : m_isPlayer2IA);
}

BoardState& Board::GetCurrentState()
{
    return m_CurrentState;
}

void Board::InverseOrder()
{
    bool tmp = m_isPlayer1IA;
    m_isPlayer1IA = m_isPlayer2IA;
    m_isPlayer2IA = tmp;
}
