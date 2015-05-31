#ifndef TOOLS
#define TOOLS

#include <vector>
#include <random>
#include <SFML/Graphics.hpp>

#include <iostream>

enum CARDINAL { EAST=1, WEST=-1, SOUTH=-2, NORD=2 };

namespace Tools {

template<typename T>
T& GetElem(std::vector<T> &vec, int sizeX, int x, int y)
{
    return vec[sizeX * y + x];
}

template<typename T>
void SetElem(std::vector<T> &vec, const T &elem, int sizeX, int x, int y)
{
    vec[sizeX * y + x] = elem;
}

int Rand(int min, int max);
unsigned int Rand(unsigned int N);
float Rand();

int Distance(const sf::IntRect &rect1, const sf::IntRect &rect2);

bool CanDraw(const sf::RenderWindow &w, const sf::Sprite & s);

static const sf::Vector2i Cardinal[] = {sf::Vector2i(-1, 0), sf::Vector2i(1, 0), sf::Vector2i(0, -1), sf::Vector2i(0, 1)};
static const sf::Vector2i Diagonal[] = {sf::Vector2i(-1, 0), sf::Vector2i(1, 0), sf::Vector2i(0, -1), sf::Vector2i(0, 1),
                                       sf::Vector2i(1, 1),sf::Vector2i(-1, -1),sf::Vector2i(-1, 1),sf::Vector2i(1, -1)};

const int TILE_SIZE = 32;

}
#endif
