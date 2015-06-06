#include "include/GameState/StateInGame.hpp"

StateInGame::StateInGame() :
    m_EvenPhase(true),
    m_hasClicked(false),
    m_ignoreFirstClick(false),
    m_hasWinner(false)
{
    m_ColorClicked = Color::EMPTY;
    m_TokenTileset = ResourcesSingleton::Get().GetTexture("Ressources/Texture/Token.png");
    m_BoardTexture = ResourcesSingleton::Get().GetTexture("Ressources/Texture/board.png");
    m_BoardSprite.setTexture(m_BoardTexture);

    BoardState& b = Board::Get().GetCurrentState();

    sf::Image moveTex;
    moveTex.create(232, 232, sf::Color(143, 245, 111, 128));
    m_moveTex.loadFromImage(moveTex);

    for(int x=0; x < 3; ++x){
        for(int y=0; y < 3; ++y){
            if(b.getCase(x, y).hasEmplacement){
                sf::Sprite emplacement;
                emplacement.setTexture(m_TokenTileset);
                emplacement.setTextureRect(sf::IntRect(0, 0, 232, 232));
                emplacement.setPosition(36 + x*232, 36 + y*232);
                m_EmplacementSprite.push_back(emplacement);
            }
            sf::Sprite move;
            move.setTexture(m_moveTex);
            move.setPosition(36 + x*232, 36 + y*232);
            m_AvaibleMove[3 * y + x] = move;
            m_ShowAvaibleMove[3*y+x] = false;
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

    m_WinnerText.setString("Win");
    m_WinnerText.setFont(ResourcesSingleton::Get().GetFont("Ressources/Fonts/default.ttf"));
    m_WinnerText.setColor(sf::Color::Black);
    m_WinnerText.setPosition(290, 404);
    m_WinnerText.setCharacterSize(128);
    m_winnerSprite.setTexture(m_TokenTileset);
    m_winnerSprite.setScale(1.5f, 1.5f);
    m_winnerSprite.setPosition(210, 100);
    m_whosPlaying.setTexture(m_TokenTileset);
    m_whosPlaying.setTextureRect(sf::IntRect(232, 0, 232, 232));
    m_whosPlaying.setScale(0.12f, 0.12f);
    m_whosPlaying.setPosition(370, 1);
}

StateInGame::~StateInGame()
{
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

    for(unsigned int i=0; i < m_ShowAvaibleMove.size() ; ++i){
        if(m_ShowAvaibleMove[i]){
            a_window.draw(m_AvaibleMove[i]);
        }
    }

    if(m_hasWinner){
        a_window.draw(m_winnerSprite);
        a_window.draw(m_WinnerText);
    }

    a_window.draw(m_whosPlaying);
}

void StateInGame::Event()
{
    if(m_hasWinner){
        if(m_input.CanGetEvent()){
            if(m_input.GetMousePhase() == InputManager::MOUSE_PHASE::UP){
                // TODO : return to main screen
            }
        }
        return;
    }
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

                std::cout << "click : " << caseTouch.x << ", " << caseTouch.y << std::endl;

                Case c = Board::Get().GetCurrentState().getCase(caseTouch.x, caseTouch.y);

                std::cout << "caseTouch : (" << c.position.x << ", " << c.position.y << ")" << std::endl;
                if(!c.hasEmplacement){
                    if(!m_hasClicked)return;
                }

                if(!m_hasClicked){
                    m_CurrentPlayerMove.player = m_EvenPhase;
                    m_CurrentPlayerMove.tokenPos = caseTouch;
                    m_hasClicked = true;
                    m_CurrentPlayerMove.moveType = PLACE_TOKEN;
                    m_ColorClicked = c.tokenColor;
                    ComputePlayableMove();
                }else{
                    if(m_CurrentPlayerMove.tokenPos == caseTouch && c.tokenColor != Color::EMPTY){
                        m_hasClicked = false;
                        ComputePlayableMove();
                        return;
                    }
                    if(!(m_CurrentPlayerMove.tokenPos == caseTouch)){
                        sf::Vector2i deltaPos = m_CurrentPlayerMove.tokenPos - caseTouch;
                        std::cout << "delta : " << deltaPos.x << ", " << deltaPos.y << std::endl;
                        if(!c.hasEmplacement){
                            if(deltaPos.x > 0 && deltaPos.y == 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(caseTouch, CARDINAL::EAST);
                                if(deltaPos.x == 2)m_CurrentPlayerMove.multiMove = true;
                            }else if(deltaPos.x < 0 && deltaPos.y == 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(caseTouch, CARDINAL::WEST);
                                if(deltaPos.x == -2)m_CurrentPlayerMove.multiMove = true;
                            }else if(deltaPos.x == 0 && deltaPos.y > 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(caseTouch, CARDINAL::SOUTH);
                                if(deltaPos.y == 2)m_CurrentPlayerMove.multiMove = true;
                            }else if(deltaPos.x == 0 && deltaPos.y < 0){
                                m_CurrentPlayerMove.movingCase = std::make_pair(caseTouch, CARDINAL::NORD);
                                if(deltaPos.y == -2)m_CurrentPlayerMove.multiMove = true;
                            }else{
                                m_hasClicked = false;
                                ComputePlayableMove();
                                return;
                            }
                            m_CurrentPlayerMove.moveType = MOVE_EMPLACEMENT;
                        }else{
                            if((c.tokenColor != Color::EMPTY) || (m_ColorClicked != ((m_EvenPhase)?Color::WHITE:Color::BLACK))){
                                m_hasClicked = false;
                                ComputePlayableMove();
                                m_ColorClicked = Color::EMPTY;
                                return;
                            }else{
                                if(deltaPos.x == 1 && deltaPos.y == 0){
                                    m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::WEST);
                                }else if(deltaPos.x == -1 && deltaPos.y == 0){
                                    m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::EAST);
                                }else if(deltaPos.x == 0 && deltaPos.y == 1){
                                    m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::NORD);
                                }else if(deltaPos.x == 0 && deltaPos.y == -1){
                                    m_CurrentPlayerMove.movingCase = std::make_pair(m_CurrentPlayerMove.tokenPos, CARDINAL::SOUTH);
                                }else{
                                    m_hasClicked = false;
                                    ComputePlayableMove();
                                    m_ColorClicked = Color::EMPTY;
                                    return;
                                }
                            }
                            m_CurrentPlayerMove.moveType = MOVE_TOKEN;
                            ComputePlayableMove();
                        }
                    }
                    PlayMove(m_CurrentPlayerMove);
                    m_hasClicked = false;
                    ComputePlayableMove();
                    m_ColorClicked = Color::EMPTY;
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

    if(m_hasWinner)return;

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
        PrintMove(m);
    }
}

void StateInGame::PrintMove(const Move &m)
{
    if(m.moveType == PLACE_TOKEN){
        std::cout << "Place token " << ((m.player)?"white" : "black") << "in position (" << m.tokenPos.x << ", " << m.tokenPos.y << ")" << std::endl;
    }else{
        std::string coord = "";
        switch(m.movingCase.second)
        {
            case CARDINAL::EAST:
                coord = "east";
                break;
            case CARDINAL::WEST:
                coord = "west";
                break;
            case CARDINAL::NORD:
                coord = "nord";
                break;
            case CARDINAL::SOUTH:
                coord = "south";
                break;
            default:
                coord = std::to_string(m.movingCase.second);
        }
        if(m.moveType == MOVE_EMPLACEMENT){
            std::cout << "Move Emplacement (" << m.movingCase.first.x << ", " << m.movingCase.first.y << ") to " << coord << ((m.multiMove)?" double":" single") << std::endl;
        }else if(m.moveType == MOVE_TOKEN){
            std::cout << "Move Token (" << m.movingCase.first.x << ", " << m.movingCase.first.y << ") to " << coord << std::endl;
        }
    }
}

/**
  * Move StateInGame::IAMovement()
  * @Return Move: Meilleur mouvement de type [Move] (Le mouvement que l'IA devra effectuer)
**/
Move StateInGame::IAMovement()
{

    /**
     * @brief player : variable qui gère le boolean pour savoir quel joueur doit jouer
     */
    bool player = m_EvenPhase;

    /**
     * @brief state : copy of actual state
     * +initialisation
     */
    BoardState state;
    state = Board::Get().GetCurrentState();

    /**
     * @brief finalMove : Variable destinée à être retournée
     * (Meilleur mouvement à effectuer par l'IA en fonction des paramètres)
     */
    Move finalMove;

    /**
     * @brief maxDepth : profondeur maximale de l'arbre
     * permet de choisir la difficulté de l'IA
     * (en choisissant combien de coup est-ce que l'IA peut 'prévoir')
     */
     int maxDepth = 6;

    /**
     * @brief infinite : valeur maximum d'un integer (simuler l'infini pour l'algorithme)
     */
    int infinite = std::numeric_limits<int>::max();

    /**
     * @brief alpha et beta pour l'algorithme "Etalage AlphaBeta"
     * + Initialisation en fonction de maxVal
     */
    int alpha, beta;
    alpha = -infinite;
    beta = infinite;

    // Pour tous les mouvements possibles de l'état actuel
    std::vector<Move> possibleMoves;
    possibleMoves = state.GetPossibleMove(player);
    // on parcours tous les mouvements possibles en exécutant l'algorithme
    for ( unsigned int i = 0; i < possibleMoves.size(); i++ ) {
        int val = StateInGame::minimax(state.SimulateMove(possibleMoves.at(i)), maxDepth, alpha, beta, true, player);
        if (val > alpha) { // Si la solution a été trouvée
            alpha = val;
            finalMove = possibleMoves.at(i);
            std::cout << "solution trouve" << std::endl;
        }
    }

    return finalMove; // renvoie le meilleur coup possible

    //sécurité: si l'algorithme ne trouve rien, donc qu'il ne fonctionne pas, l'IA jouera le premier coup qu'il trouve dans son tableau de possibilitées
    std::cout << "Attention: l'algorithme n'as pas fonctionné. (si la cause n'est pas directement au dessus de la ligne, l'erreur est inconnue)" << std::endl;
    return  Board::Get().GetCurrentState().GetPossibleMove(m_EvenPhase).at(0);
}

/**
 * int StateInGame::minimax(BoardState state, int depth, int a, int b, bool max)
 * @brief StateInGame::minimax renvoie la valeur de l'algorithme minimax avec étalage alpha-beta
 * @param state : BoardState actuel
 * @param depth : profondeur a appliquer pour la recherche de la solution
 * @param a : alpha (minimum value, -infini)
 * @param b : beta (maximum value, +infini)
 * @param max : boolean du joueur
 * @return  valeur de l'algorithme minimax avec étalage alpha-beta
 */
int StateInGame::minimax(BoardState state, int depth, int a, int b, bool max, bool player)
{
    // Si l'état de victoire est atteint, on renvoie directement l'information (c'est le meilleur coup)
    // ou si la profondeur à atteint son maximum, l'IA ne vois pas encore d'issues possible
    if (state.IsEndOfGame(player) || depth == 0) {
        return state.EvaluateFor(player); // random value test
    }
    // On récupère tout les mouvements possible de l'état actuel pour le joueur
    std::vector<Move> possibleMoves;
    possibleMoves = state.GetPossibleMove(player);
    if (max) {
        // Si on est dans le cas Max de l'algorithme, on parcours tous les mouvements possibles
        for (Move &move : possibleMoves) {
            // On applique le min entre alpha et le retour de la foncton minimax
            a = std::max(a, minimax(state.SimulateMove(move), depth - 1, a, b, false, !player));
            if (b <= a) return b; //  beta stop car beta est inférieur à alpha (règle)
        }
        return a;
    } else {
        // si on est dans le cas Min de l'algorithme, on parcours tous les mouvements possibles
        for (Move &move : possibleMoves) {
            // On applique le min entre beta et le retour de la foncton minimax
            b = std::min(b, minimax(state.SimulateMove(move), depth - 1, a, b, true, !player));
            if (b <= a) return a; // beta stop car beta est inférieur à alpha (règle)
        }
        return b;
    }
}

void StateInGame::PlayMove(Move m)
{
    PrintMove(m);
    if(!Board::Get().GetCurrentState().PlayMove(m))return;
    std::cout << ((m_EvenPhase)?"White":"Black") << " : ";

    std::cout << "score : "  << Board::Get().GetCurrentState().EvaluateFor(m_EvenPhase) << std::endl;
    int score = Board::Get().GetCurrentState().EvaluateFor(m_EvenPhase);
    bool winner = Board::Get().GetCurrentState().IsEndOfGame(m_EvenPhase);
    bool whiteWin = false;
    if(score >= 600){
        if(m_EvenPhase){
            whiteWin = true;
        }else{
            whiteWin = false;
        }
    }else if(score <= -600){
        if(m_EvenPhase){
            whiteWin = false;
        }else{
            whiteWin = true;
        }
    }
    if(winner){
        std::cout << "player " << ((whiteWin)?"White":"Black") << " Win !!!" << std::endl;
        m_winnerSprite.setTextureRect(sf::IntRect(232 * ((whiteWin)?1:2), 0, 232, 232));
        m_WinnerText.setColor(sf::Color(0, 178, 5));
        m_hasWinner = true;
        return;
    }
    m_EvenPhase = !m_EvenPhase;
    m_whosPlaying.setTextureRect(sf::IntRect(232*((m_EvenPhase)?1:2), 0, 232, 232));
    //PrintPossibleMove(Board::Get().GetCurrentState().GetPossibleMove(m_EvenPhase));
    std::cout << "--------------------------" << std::endl;
}

void StateInGame::ComputePlayableMove()
{
    if(!m_hasClicked){
        for(bool &b : m_ShowAvaibleMove){
            b = false;
        }
        return;
    }

    BoardState cs = Board::Get().GetCurrentState();

    Case c = cs.getCase(m_CurrentPlayerMove.tokenPos.x, m_CurrentPlayerMove.tokenPos.y);

    if(m_CurrentPlayerMove.moveType == PLACE_TOKEN && c.tokenColor == Color::EMPTY && cs.GetPlacedToken(m_EvenPhase) > 0){
        m_ShowAvaibleMove[3 * m_CurrentPlayerMove.tokenPos.y + m_CurrentPlayerMove.tokenPos.x] = true;
    }

    for(int x=0; x < 3; ++x){
        for(int y=0; y < 3; ++y){
            Case c = Board::Get().GetCurrentState().getCase(x, y);
            if(!c.hasEmplacement){
                if((m_CurrentPlayerMove.tokenPos.x == x) ||
                        (m_CurrentPlayerMove.tokenPos.y == y)){
                    m_ShowAvaibleMove[3 * y + x] = true;
                }
            }
        }
    }
    if(m_ColorClicked != ((m_EvenPhase)?Color::WHITE:Color::BLACK))return;
    static const int cardi[][2] = {{-1, 0}, {1, 0}, {0, 1}, {0, -1}};
    for(auto i : cardi){
            sf::Vector2i pos(m_CurrentPlayerMove.tokenPos.x + i[0], m_CurrentPlayerMove.tokenPos.y + i[1]);
            std::cout << "pos : " << pos.x << " ; " << pos.y << std::endl;
            if(pos.x < 0 || pos.y < 0 || pos.x > 2 || pos.y > 2)continue;
            Case c = Board::Get().GetCurrentState().getCase(pos.x, pos.y);
            if(c.hasEmplacement && c.tokenColor == Color::EMPTY){
                m_ShowAvaibleMove[3 * pos.y + pos.x] = true;
            }

    }
}
