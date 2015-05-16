#ifndef CASE_HPP
#define CASE_HPP

#include <SFML/System/Vector2.hpp>

enum Color {EMPTY, WHITE, BLACK};

typedef struct {
    Color tokenColor;
    bool hasEmplacement;
    sf::Vector2i position;
}Case;

#endif // CASE_HPP
