#ifndef MOVE_HPP
#define MOVE_HPP

#include <SFML/System/Vector2.hpp>
#include "include/Tools/Tools.hpp"

const int PLACE_TOKEN = 1;
const int MOVE_EMPLACEMENT = 2;
const int MOVE_TOKEN = 3;

typedef struct{
    bool player;
    int moveType;
    sf::Vector2i tokenPos;
    std::pair<sf::Vector2i, CARDINAL> movingCase;
    bool multiMove;
}Move;

#endif
