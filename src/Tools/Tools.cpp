#include "include/Tools/Tools.hpp"

int Tools::Rand(int min, int max)
{
    if(min > max){
        return 0;
    }
    float num = Rand();
    return static_cast<int>(num * (max-min) + min);
}

unsigned int Tools::Rand(unsigned int N)
{
    return static_cast<unsigned int>(Rand(0, N));
}

float Tools::Rand()
{
    static std::random_device rd;
    static std::mt19937 gen(rd());
    static std::uniform_real_distribution<> dis(0, 1);
    return dis(gen);
}

int Tools::Distance(const sf::IntRect &rect1, const sf::IntRect &rect2)
{
    int dist1;
    int dist2;

    if(rect1.left < rect2.left){
        dist1 = rect2.left - (rect1.left + rect1.width);
    }else{
        dist1 = rect1.left - (rect2.left + rect2.width);
    }

    if(rect1.top < rect2.top){
        dist2 = rect2.top - (rect1.top + rect1.height);
    }else{
        dist2 = rect1.top - (rect2.top + rect2.height);
    }

    return std::max(dist1, dist2);
}

bool Tools::CanDraw(const sf::RenderWindow &w, const sf::Sprite & s)
{
    sf::View v = w.getView();
    sf::Vector2f size = v.getSize();
    sf::Vector2f center = v.getCenter();
    sf::IntRect screen(center.x - size.x * 0.5f - 2 * TILE_SIZE, center.y - size.y * 0.5f - 2 * TILE_SIZE, size.x + 4 * TILE_SIZE, size.y + 4 * TILE_SIZE);
    return screen.contains(static_cast<sf::Vector2i>(s.getPosition()));
}
