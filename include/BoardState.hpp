#ifndef BOARDSTATE_HPP
#define BOARDSTATE_HPP

#include <vector>
#include <array>
#include <utility>
#include "include/move.hpp"
#include "include/Case.hpp"

class BoardState
{
public:
    BoardState();
    BoardState(const std::array<Case, 9> &newBoard);
    std::vector<Move> GetPossibleMove(bool player);
    void PlayMove(const Move& move);
    const BoardState SimulateMove(const Move& move);
    const Case& getCase(int x, int y);
    bool Empty();
    int EvaluateFor(bool player);

private:
    int EvaluateLine(int x1, int y1, int x2, int y2, int x3, int y3, bool player);
    void SetCase(int x, int y, Case& c);

    std::array<Case, 9> m_Board;
    short m_blackTokens;
    short m_whiteTokens;
};

#endif // BOARDSTATE_HPP