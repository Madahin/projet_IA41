#include "include/GameState/StateInGame.hpp"

StateInGame::StateInGame() :
    m_EvenPhase(true),
    m_hasClicked(false),
    m_ignoreFirstClick(false)
{
    m_TokenTileset = ResourcesSingleton::Get().GetTexture("Ressources/Texture/Token.png");
    m_BoardTexture = ResourcesSingleton::Get().GetTexture("Ressources/Texture/board.png");
    m_BoardSprite.setTexture(m_BoardTexture);

    BoardState& b = Board::Get().GetCurrentState();

    for(int x=0; x < 3; ++x){
        for(int y=0; y < 3; ++y){
            if(b.getCase(x, y).hasEmplacement){
                sf::Sprite emplacement;
                emplacement.setTexture(m_TokenTileset);
                emplacement.setTextureRect(sf::IntRect(0, 0, 232, 232));
                emplacement.setPosition(36 + x*232, 36 + y*232);
                m_EmplacementSprite.push_back(emplacement);
            }
        }
    }

    for(int i=0; i < 6; ++i){
        sf::Sprite s;
        s.setTexture(m_TokenTileset);
        if(i < 3){
            s.setTextureRect(sf::IntRect(232, 0, 232, 232));
        }else{
            s.setTextureRect(sf::IntRect(232*2, 0, 232, 232));
        }
        s.setPosition(-1000, -1000);
        m_TokenSprite[i] = s;
    }
}

void StateInGame::Init()
{
}

void StateInGame::Free()
{
}

void StateInGame::Draw(sf::RenderWindow &a_window)
{
    a_window.draw(m_BoardSprite);

    for(auto &s : m_EmplacementSprite){
        a_window.draw(s);
    }

    for(auto &s : m_TokenSprite){
        a_window.draw(s);
    }
}

void StateInGame::Event()
{
    if(Board::Get().GetGameType() == 2 || Board::Get().IsPlayerIA(m_EvenPhase))return;
    if(m_input.CanGetEvent()){
        switch(m_input.GetMousePhase())
        {
            case InputManager::MOUSE_PHASE::UP:
            {
                if(!m_ignoreFirstClick){
                    m_ignoreFirstClick = true;
                    return;
                }
                sf::Vector2i mousePos = m_input.GetMousePos();
                auto caseTouch = GetCaseClicked(mousePos);
                if(caseTouch.x == -1)return;

                std::cout << "caseTouch : " << caseTouch.x << ", " << caseTouch.y << std::endl;

                Case c = Board::Get().GetCurrentState().getCase(caseTouch.x, caseTouch.y);

                if(!c.hasEmplacement){
                    if(!m_hasClicked)return;
                }

                if(!m_hasClicked){
                    m_CurrentPlayerMove.player = m_EvenPhase;
                    m_CurrentPlayerMove.tokenPos = caseTouch;
                    m_hasClicked = true;
                }else{
                    if(m_CurrentPlayerMove.tokenPos == caseTouch && c.tokenColor == Color::EMPTY){
                        m_CurrentPlayerMove.moveType = PLACE_TOKEN;
                    }else{
                        if(!c.hasEmplacement){
                            sf::Vector2i deltaPos = m_CurrentPlayerMove.tokenPos - caseTouch;//sf::Vector2i(caseTouch.x - c.position.x, caseTouch.y - c.position.y);
                            std::cout << "delta : " << deltaPos.x << ", " << deltaPos.y << std::endl;
                            if(deltaPos.x > 0 && deltaPos.y == 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::EAST);
                                if(deltaPos.x == 2)m_CurrentPlayerMove.multiMove = true;
                            }else if(deltaPos.x < 0 && deltaPos.y == 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::WEST);
                                if(deltaPos.x == -2)m_CurrentPlayerMove.multiMove = true;
                            }else if(deltaPos.x == 0 && deltaPos.y > 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::NORD);
                                if(deltaPos.y == 2)m_CurrentPlayerMove.multiMove = true;
                            }else if(deltaPos.x == 0 && deltaPos.y < 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::SOUTH);
                                if(deltaPos.y == -2)m_CurrentPlayerMove.multiMove = true;
                            }else{
                                m_hasClicked = false;
                                return;
                            }
                            m_CurrentPlayerMove.moveType = MOVE_EMPLACEMENT;
                        }else{
                            m_hasClicked = false;
                            return;
                        }
                    }
                    PlayMove(m_CurrentPlayerMove);
                    m_hasClicked = false;
                    m_CurrentPlayerMove.multiMove = false;
                    m_IAClock.restart();
                }
                break;
            }
            default:
            {
                break;
            }
        }
    }
}

void StateInGame::Update()
{
    BoardState currentState = Board::Get().GetCurrentState();
    int nbEmplacement = 0;
    int nbTokenWhite = 0;
    int nbTokenBlack = 3;
    for(int x=0; x < 3; ++x){
        for(int y=0; y < 3; ++y){
            Case c = currentState.getCase(x, y);
            if(c.hasEmplacement){
                m_EmplacementSprite[nbEmplacement].setPosition(36 + x*232, 36 + y*232);
                nbEmplacement++;
            }
            if(c.tokenColor != Color::EMPTY){
                if(c.tokenColor == Color::WHITE){
                    m_TokenSprite[nbTokenWhite].setPosition(36 + x*232, 36 + y*232);
                    nbTokenWhite++;
                }else{
                    m_TokenSprite[nbTokenBlack].setPosition(36 + x*232, 36 + y*232);
                    nbTokenBlack++;
                }
            }
        }
    }

    if(Board::Get().IsPlayerIA(m_EvenPhase) && m_IAClock.getElapsedTime().asMilliseconds() > 1000){
        Move IAMove = IAMovement();
        PlayMove(IAMove);
        m_IAClock.restart();
    }
}

void StateInGame::Pause()
{
}

void StateInGame::UnPause()
{
}

sf::Vector2i StateInGame::GetCaseClicked(sf::Vector2i mousePos)
{
    if(mousePos.x < 36 || mousePos.y < 36 || mousePos.x > 732 || mousePos.y > 732){
        return sf::Vector2i(-1, -1);
    }
    mousePos.x -= 36;
    mousePos.y -= 36;
    return sf::Vector2i(mousePos.x / 232, mousePos.y / 232);
}

void StateInGame::PrintPossibleMove(const std::vector<Move> &possibleMoves)
{
    for(const Move &m : possibleMoves){
        if(m.moveType == PLACE_TOKEN){
            std::cout << "Place token " << ((m.player)?"white" : "black") << "in position (" << m.tokenPos.x << ", " << m.tokenPos.y << ")" << std::endl;
        }else{
            std::cout << "Move Emplacement (" << m.movingCase.first.x << ", " << m.movingCase.first.y << ") to " << m.movingCase.second << ((m.multiMove)?" double":" single") << std::endl;
        }
    }
}

Move StateInGame::IAMovement()
{
    return Board::Get().GetCurrentState().GetPossibleMove(m_EvenPhase).at(0);
}

void StateInGame::PlayMove(Move m)
{
    Board::Get().GetCurrentState().PlayMove(m);
    std::cout << "score : "  << Board::Get().GetCurrentState().EvaluateFor(m_EvenPhase) << std::endl;
    if(Board::Get().GetCurrentState().EvaluateFor(m_EvenPhase) > 500){
        std::cout << "player " << ((m_EvenPhase)?"White":"Black") << " Win !!!" << std::endl;
    }else if(Board::Get().GetCurrentState().EvaluateFor(m_EvenPhase) < -500){
        std::cout << "player " << ((!m_EvenPhase)?"White":"Black") << " Win !!!" << std::endl;
    }
    m_EvenPhase = !m_EvenPhase;
}
