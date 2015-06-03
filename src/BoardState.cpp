#include "include/BoardState.hpp"

BoardState::BoardState() :
    m_blackTokens(3),
    m_whiteTokens(3),
    m_isFirstMove(true)
{
    for(int y=0; y < 3; ++y){
        for(int x=0; x < 3; ++x){
            Case c;
            c.hasEmplacement = (!(x==1 && y==1));
            c.position = sf::Vector2i(x, y);
            c.tokenColor = Color::EMPTY;
            m_Board[3 * y + x] = c;
        }
    }
}

BoardState::BoardState(const BoardState &s) :
    m_blackTokens(s.m_blackTokens),
    m_whiteTokens(s.m_whiteTokens),
    m_isFirstMove(s.m_isFirstMove)
{
    m_Board = s.m_Board;
    m_lastMove = s.m_lastMove;
}

std::vector<Move> BoardState::GetPossibleMove(bool player)
{
    std::vector<Move> possibleMove;
    int tokens = (player)?(m_whiteTokens):(m_blackTokens);
    if(tokens > 0){
        for(const Case &c : m_Board){
            if(c.hasEmplacement){
                if(c.tokenColor == Color::EMPTY){
                    Move m;
                    m.moveType = PLACE_TOKEN;
                    m.player = player;
                    m.tokenPos = c.position;
                    possibleMove.push_back(m);
                }
            }
        }
    }

    Case middle = getCase(1, 1);
    if(!middle.hasEmplacement){
        for(int i: {CARDINAL::NORD, CARDINAL::SOUTH, CARDINAL::EAST, CARDINAL::WEST}){
            Move m;
            m.moveType = MOVE_EMPLACEMENT;
            m.movingCase = std::make_pair(sf::Vector2i(1, 1), static_cast<CARDINAL>(i));
            m.multiMove = false;
            m.tokenPos = sf::Vector2i(1, 1);
            possibleMove.push_back(m);
        }
    }

    for(int y=0; y < 3; ++y){
        for(int x=0; x < 3; ++x){
            if(x==1 && y==1)continue;

            Case c = getCase(x, y);
            if(c.hasEmplacement)continue;

            //Move m = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::NORD), false};
            //m.moveType = MOVE_EMPLACEMENT;
            //m.movingCase = std::make_pair(sf::Vector2i(x, y), CARDINAL::NORD);
            //m.tokenPos = sf::Vector2i(x, y);

            //m.multiMove = false;

            if(x == 0 && y != 1){
                Move m = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::WEST), false};
                possibleMove.push_back(m);
                Move m2 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::WEST), true};
                possibleMove.push_back(m2);
            }

            if(x == 2 && y != 1){
                Move m = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::EAST), false};
                possibleMove.push_back(m);
                Move m2 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::EAST), true};
                possibleMove.push_back(m2);
            }

            if(x != 1 && y == 0){
                Move m = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::SOUTH), false};
                possibleMove.push_back(m);
                Move m2 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::SOUTH), true};
                possibleMove.push_back(m2);
            }

            if(x != 1 && y == 2){
                Move m = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::NORD), false};
                possibleMove.push_back(m);
                Move m2 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::NORD), true};
                possibleMove.push_back(m2);
            }

            if(y == 1){
                Move m = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::SOUTH), false};
                possibleMove.push_back(m);
                Move m2 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::NORD), false};
                possibleMove.push_back(m2);
                if(x == 0){
                    Move m3 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::EAST), false};
                    possibleMove.push_back(m3);
                    Move m4 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::EAST), true};
                    possibleMove.push_back(m4);
                }else if(x == 2){
                    Move m3 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::WEST), false};
                    possibleMove.push_back(m3);
                    Move m4 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::WEST), true};
                    possibleMove.push_back(m4);
                }
            }

            if(x == 1){
                Move m = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::WEST), false};
                possibleMove.push_back(m);
                Move m2 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::EAST), false};
                possibleMove.push_back(m2);
                if(y == 0){
                    Move m3 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::SOUTH), false};
                    possibleMove.push_back(m3);
                    Move m4 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::SOUTH), true};
                    possibleMove.push_back(m4);
                }else if(y == 2){
                    Move m3 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::NORD), false};
                    possibleMove.push_back(m3);
                    Move m4 = {player, MOVE_EMPLACEMENT, sf::Vector2i(x, y), std::make_pair(sf::Vector2i(x, y), CARDINAL::NORD), true};
                    possibleMove.push_back(m4);
                }
            }
        }
    }

    if(!m_isFirstMove){
        int index = -1;
        unsigned int i = 0;
        for(const Move &m : possibleMove){
            if((m.moveType == MOVE_EMPLACEMENT) && (m.movingCase.second + m_lastMove.movingCase.second == 0) && (m.multiMove == m_lastMove.multiMove)){
                index = i;
                break;
            }
            i++;
        }
        if(index >= 0)possibleMove.erase(possibleMove.begin() + i);
    }

    return possibleMove;
}

bool BoardState::PlayMove(const Move& move)
{
    if(move.moveType == PLACE_TOKEN){
        if(move.player && m_whiteTokens == 0)return false;
        if(!move.player && m_blackTokens == 0)return false;
        Case c = getCase(move.tokenPos.x, move.tokenPos.y);
        c.tokenColor = (move.player) ? Color::WHITE : Color::BLACK;
        SetCase(move.tokenPos.x, move.tokenPos.y, c);
        (move.player) ? m_whiteTokens-- : m_blackTokens--;
    }else if(move.moveType == MOVE_EMPLACEMENT){
        if(!m_isFirstMove && (move.movingCase.second + m_lastMove.movingCase.second == 0) && (move.multiMove == m_lastMove.multiMove))return false;
        sf::Vector2i posCase = move.movingCase.first;
        Case c1 = getCase(posCase.x, posCase.y);
        switch (move.movingCase.second) {
            case CARDINAL::NORD:
            {
                Case c2 = getCase(posCase.x, posCase.y - 1);
                c1.position = sf::Vector2i(posCase.x, posCase.y - 1);
                c2.position = sf::Vector2i(posCase.x, posCase.y);
                SetCase(posCase.x, posCase.y - 1, c1);
                SetCase(posCase.x, posCase.y, c2);
                if(move.multiMove){
                    Case c3 = getCase(posCase.x, posCase.y - 2);
                    c1.position = sf::Vector2i(posCase.x, posCase.y - 2);
                    c3.position = sf::Vector2i(posCase.x, posCase.y - 1);
                    SetCase(posCase.x, posCase.y - 2, c1);
                    SetCase(posCase.x, posCase.y - 1, c3);
                }
                break;
            }
            case CARDINAL::SOUTH:
            {
                Case c2 = getCase(posCase.x, posCase.y + 1);
                c1.position = sf::Vector2i(posCase.x, posCase.y + 1);
                c2.position = sf::Vector2i(posCase.x, posCase.y);
                SetCase(posCase.x, posCase.y + 1, c1);
                SetCase(posCase.x, posCase.y, c2);
                if(move.multiMove){
                    Case c3 = getCase(posCase.x, posCase.y + 2);
                    c1.position = sf::Vector2i(posCase.x, posCase.y + 2);
                    c3.position = sf::Vector2i(posCase.x, posCase.y + 1);
                    SetCase(posCase.x, posCase.y + 2, c1);
                    SetCase(posCase.x, posCase.y + 1, c3);
                }
                break;
            }
            case CARDINAL::EAST:
            {
                Case c2 = getCase(posCase.x - 1, posCase.y);
                c1.position = sf::Vector2i(posCase.x - 1, posCase.y);
                c2.position = sf::Vector2i(posCase.x, posCase.y);
                SetCase(posCase.x - 1, posCase.y, c1);
                SetCase(posCase.x, posCase.y, c2);
                if(move.multiMove){
                    Case c3 = getCase(posCase.x - 2, posCase.y);
                    c1.position = sf::Vector2i(posCase.x - 2, posCase.y);
                    c3.position = sf::Vector2i(posCase.x - 1, posCase.y);
                    SetCase(posCase.x - 2, posCase.y, c1);
                    SetCase(posCase.x - 1, posCase.y, c3);
                }
                break;
            }
            case CARDINAL::WEST:
            {
                Case c2 = getCase(posCase.x + 1, posCase.y);
                c1.position = sf::Vector2i(posCase.x + 1, posCase.y);
                c2.position = sf::Vector2i(posCase.x, posCase.y);
                SetCase(posCase.x + 1, posCase.y, c1);
                SetCase(posCase.x, posCase.y, c2);
                if(move.multiMove){
                    Case c3 = getCase(posCase.x + 2, posCase.y);
                    c1.position = sf::Vector2i(posCase.x + 2, posCase.y);
                    c3.position = sf::Vector2i(posCase.x + 1, posCase.y);
                    SetCase(posCase.x + 2, posCase.y, c1);
                    SetCase(posCase.x + 1, posCase.y, c3);
                }
                break;
            }
            default:
                break;
        }
    }
    if(m_isFirstMove)m_isFirstMove = false;
    m_lastMove = move;
    return true;
}

const BoardState BoardState::SimulateMove(const Move& move)
{
    BoardState tmp(*this);
    tmp.PlayMove(move);
    return tmp;
}

const Case& BoardState::getCase(int x, int y)
{
    return m_Board[3 * y + x];
}

void BoardState::SetCase(int x, int y, Case &c)
{
    m_Board[3 * y + x] = c;
}

bool BoardState::Empty()
{
    for(const auto &c : m_Board)
    {
        if(c.tokenColor != Color::EMPTY) return false;
    }
    return true;
}

int BoardState::EvaluateFor(bool player)
{
    int boardScore = 0;
    // Colone
    boardScore += EvaluateLine(0, 0, 0, 1, 0, 2, player);
    boardScore += EvaluateLine(1, 0, 1, 1, 1, 2, player);
    boardScore += EvaluateLine(2, 0, 2, 1, 2, 2, player);
    // Line
    boardScore += EvaluateLine(0, 0, 1, 0, 2, 0, player);
    boardScore += EvaluateLine(0, 1, 1, 1, 2, 1, player);
    boardScore += EvaluateLine(0, 2, 1, 2, 2, 2, player);
    // Diag
    boardScore += EvaluateLine(0, 0, 1, 1, 2, 2, player);
    boardScore += EvaluateLine(2, 0, 1, 1, 0, 2, player);

    return boardScore;
}

int BoardState::EvaluateLine(int x1, int y1, int x2, int y2, int x3, int y3, bool player)
{
    std::array<Case, 3> c = {getCase(x1, y1), getCase(x2, y2), getCase(x3, y3)};

    Color playerColor = ((player)?Color::WHITE : Color::BLACK);
    Color OpPlayer = ((!player)?Color::WHITE : Color::BLACK);

    if((c[0].tokenColor == playerColor) && (c[0].tokenColor == c[1].tokenColor) && (c[1].tokenColor == c[2].tokenColor)){
        return 1000;
    }

    if((c[0].tokenColor == OpPlayer) && (c[0].tokenColor == c[1].tokenColor) && (c[1].tokenColor == c[2].tokenColor)){
        return -1000;
    }

    int score = 0;
    for(const Case &ca : c){
        if(ca.tokenColor == playerColor)score++;
        else if(ca.tokenColor == OpPlayer)score--;
    }

    return score;
}

short BoardState::GetPlacedToken(bool player)
{
    if(player){
        return m_whiteTokens;
    }else{
        return m_blackTokens;
    }
}
