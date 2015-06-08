#ifndef BOARDSTATE_HPP
#define BOARDSTATE_HPP

#include <vector>
#include <array>
#include <utility>
#include "include/move.hpp"
#include "include/Case.hpp"

static constexpr short WinningShot = 8;
static constexpr short ThreeInARow[WinningShot][3][2] = {
    {{0, 0}, {1, 0}, {2, 0}},
    {{0, 1}, {1, 1}, {2, 1}},
    {{0, 2}, {1, 2}, {2, 2}},
    {{0, 0}, {0, 1}, {0, 2}},
    {{1, 0}, {1, 1}, {1, 2}},
    {{2, 0}, {2, 1}, {2, 2}},
    {{0, 0}, {1, 1}, {2, 2}},
    {{2, 0}, {1, 1}, {0, 2}}
};

class BoardState
{
public:
    BoardState();
    BoardState(const BoardState &s);
    std::vector<Move> GetPossibleMove(bool player);
    bool PlayMove(const Move& move);
    BoardState SimulateMove(Move& move);
    const Case& getCase(int x, int y);
    bool Empty();
    int EvaluateFor(bool player);
    short GetPlacedToken(bool player);
    short IsEndOfGame(bool player);

private:
    int EvaluateLine(int x1, int y1, int x2, int y2, int x3, int y3, bool player);
    void SetCase(int x, int y, Case& c);

    std::array<Case, 9> m_Board;
    short m_blackTokens;
    short m_whiteTokens;
    Move m_lastMove;
    bool m_isFirstMove;
};

#endif // BOARDSTATE_HPP
