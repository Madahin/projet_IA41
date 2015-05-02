/*
  Définition de l'IA du joueur artificiel de Rasende Roboter
*/

:- module( decision, [
	init/1,
	move/2
] ).

init(_):-
	nb_setval(nbGJ, 0),
	nb_setval(nbTOTAL, 0),
	writef('### init ###\n').

% targets(+Scenario, -Targets)
% Liste des coordonnées des cibles selon le scénario
targets([0,0,0,0], [[7,5],[6,1],[9,10],[13,5],[6,13],[11,2],[5,4],[1,10],[14,13],[4,9],[9,1],[9,14],[1,3],[12,9],[2,14],[2,5],[10,7]]).
targets([0,0,0,1], [[7,5],[6,1],[12,9],[13,5],[6,13],[11,2],[5,4],[1,10],[14,13],[4,9],[9,1],[9,12],[1,3],[11,14],[2,14],[2,5],[10,7]]).
targets([0,0,1,0], [[7,5],[6,1],[9,10],[13,5],[3,9],[11,2],[5,4],[6,14],[14,13],[1,13],[9,1],[9,14],[1,3],[12,9],[5,11],[2,5],[10,7]]).
targets([0,0,1,1], [[7,5],[6,1],[12,9],[13,5],[3,9],[11,2],[5,4],[6,14],[14,13],[1,13],[9,1],[9,12],[1,3],[11,14],[5,11],[2,5],[10,7]]).
targets([0,1,0,0], [[7,5],[6,1],[9,10],[11,2],[6,13],[13,6],[5,4],[1,10],[14,13],[4,9],[10,7],[9,14],[1,3],[12,9],[2,14],[2,5],[14,1]]).
targets([0,1,0,1], [[7,5],[6,1],[12,9],[11,2],[6,13],[13,6],[5,4],[1,10],[14,13],[4,9],[10,7],[9,12],[1,3],[11,14],[2,14],[2,5],[14,1]]).
targets([0,1,1,0], [[7,5],[6,1],[9,10],[11,2],[3,9],[13,6],[5,4],[6,14],[14,13],[1,13],[10,7],[9,14],[1,3],[12,9],[5,11],[2,5],[14,1]]).
targets([0,1,1,1], [[7,5],[6,1],[12,9],[11,2],[3,9],[13,6],[5,4],[6,14],[14,13],[1,13],[10,7],[9,12],[1,3],[11,14],[5,11],[2,5],[14,1]]).
targets([1,0,0,0], [[3,7],[5,6],[9,10],[13,5],[6,13],[11,2],[1,3],[1,10],[14,13],[4,9],[9,1],[9,14],[6,4],[12,9],[2,14],[2,1],[10,7]]).
targets([1,0,0,1], [[3,7],[5,6],[12,9],[13,5],[6,13],[11,2],[1,3],[1,10],[14,13],[4,9],[9,1],[9,12],[6,4],[11,14],[2,14],[2,1],[10,7]]).
targets([1,0,1,0], [[3,7],[5,6],[9,10],[13,5],[3,9],[11,2],[1,3],[6,14],[14,13],[1,13],[9,1],[9,14],[6,4],[12,9],[5,11],[2,1],[10,7]]).
targets([1,0,1,1], [[3,7],[5,6],[12,9],[13,5],[3,9],[11,2],[1,3],[6,14],[14,13],[1,13],[9,1],[9,12],[6,4],[11,14],[5,11],[2,1],[10,7]]).
targets([1,1,0,0], [[3,7],[5,6],[9,10],[11,2],[6,13],[13,6],[1,3],[1,10],[14,13],[4,9],[10,7],[9,14],[6,4],[12,9],[2,14],[2,1],[14,1]]).
targets([1,1,0,1], [[3,7],[5,6],[12,9],[11,2],[6,13],[13,6],[1,3],[1,10],[14,13],[4,9],[10,7],[9,12],[6,4],[11,14],[2,14],[2,1],[14,1]]).
targets([1,1,1,0], [[3,7],[5,6],[9,10],[11,2],[3,9],[13,6],[1,3],[6,14],[14,13],[1,13],[10,7],[9,14],[6,4],[12,9],[5,11],[2,1],[14,1]]).
targets([1,1,1,1], [[3,7],[5,6],[12,9],[11,2],[3,9],[13,6],[1,3],[6,14],[14,13],[1,13],[10,7],[9,12],[6,4],[11,14],[5,11],[2,1],[14,1]]).



%  verticalObstacles(+Scenario, -Obstacles)
%  Liste des coordonnées des obstacles verticaux selon le scénario
verticalObstacles([0,0,0,0], [[3,0],[10,0],[9,1],[5,1],[11,2],[1,3],[2,5],[4,4],[7,5],[12,5],[12,9],[9,7],[6,7],[6,8],[8,7],[8,8],[8,10],[3,9],[1,10],[2,14],[3,15],[5,13],[8,14],[10,15],[14,13]]).
verticalObstacles([0,0,0,1], [[3,0],[5,1],[9,1],[10,0],[11,2],[1,3],[4,4],[12,5],[7,5],[2,5],[6,7],[6,8],[8,7],[8,8],[9,7],[12,9],[3,9],[1,10],[5,13],[2,14],[3,15],[8,12],[11,14],[13,13],[13,15]]).
verticalObstacles([0,0,1,0], [[3,0],[5,1],[9,1],[10,0],[11,2],[1,3],[4,4],[2,5],[12,5],[9,7],[8,7],[8,8],[6,7],[6,8],[3,9],[4,11],[0,13],[4,15],[6,14],[8,14],[10,15],[8,10],[12,9],[14,13],[7,5]]).
verticalObstacles([0,0,1,1], [[3,0],[10,0],[9,1],[5,1],[1,3],[4,4],[2,5],[7,5],[11,2],[12,5],[9,7],[8,7],[8,8],[6,7],[6,8],[12,9],[3,9],[4,11],[0,13],[4,15],[6,14],[8,12],[13,13],[13,15],[11,14]]).
verticalObstacles([0,1,0,0], [[3,0],[9,0],[13,1],[10,2],[5,1],[1,3],[4,4],[2,5],[7,5],[10,7],[13,6],[8,7],[8,8],[6,7],[6,8],[3,9],[1,10],[2,14],[3,15],[5,13],[8,14],[10,15],[8,10],[14,13],[12,9]]).
verticalObstacles([0,1,0,1], [[3,0],[9,0],[13,1],[10,2],[5,1],[1,3],[4,4],[2,5],[7,5],[6,7],[6,8],[8,7],[8,8],[10,7],[13,6],[12,9],[13,13],[13,15],[11,14],[8,12],[5,13],[3,15],[2,14],[1,10],[3,9]]).
verticalObstacles([0,1,1,0], [[3,0],[5,1],[9,0],[10,2],[13,1],[1,3],[2,5],[4,4],[7,5],[6,7],[6,8],[8,7],[8,8],[10,7],[13,6],[12,9],[8,10],[3,9],[4,11],[0,13],[6,14],[8,14],[14,13],[4,15],[10,15]]).
verticalObstacles([0,1,1,1], [[3,0],[5,1],[9,0],[10,2],[13,1],[13,6],[10,7],[12,9],[8,7],[8,8],[6,7],[6,8],[7,5],[4,4],[1,3],[2,5],[3,9],[4,11],[0,13],[6,14],[8,12],[11,14],[13,13],[13,15],[4,15]]).
verticalObstacles([1,0,0,0], [[4,0],[10,0],[11,2],[12,5],[5,4],[2,1],[0,3],[6,7],[6,8],[5,6],[8,7],[8,8],[3,7],[3,9],[1,10],[2,14],[3,15],[5,13],[10,15],[8,14],[14,13],[12,9],[8,10],[9,7],[9,1]]).
verticalObstacles([1,0,0,1], [[4,0],[2,1],[0,3],[5,4],[5,6],[3,7],[3,9],[1,10],[2,14],[3,15],[5,13],[8,12],[6,8],[6,7],[8,7],[8,8],[9,7],[9,1],[10,0],[11,2],[12,5],[12,9],[13,13],[13,15],[11,14]]).
verticalObstacles([1,0,1,0], [[4,0],[10,0],[9,1],[11,2],[12,5],[5,4],[2,1],[0,3],[3,7],[5,6],[6,7],[6,8],[8,7],[8,8],[9,7],[12,9],[8,10],[4,11],[3,9],[0,13],[4,15],[6,14],[8,14],[10,15],[14,13]]).
verticalObstacles([1,0,1,1], [[4,0],[10,0],[9,1],[11,2],[12,5],[5,4],[5,6],[0,3],[3,7],[3,9],[0,13],[4,11],[6,14],[8,12],[13,13],[13,15],[11,14],[12,9],[9,7],[8,7],[8,8],[6,7],[6,8],[4,15],[2,1]]).
verticalObstacles([1,1,0,0], [[4,0],[9,0],[10,2],[13,1],[13,6],[10,7],[8,7],[8,8],[6,7],[6,8],[5,6],[5,4],[0,3],[3,7],[3,9],[1,10],[2,14],[3,15],[5,13],[8,14],[10,15],[14,13],[12,9],[8,10],[2,1]]).
verticalObstacles([1,1,0,1], [[4,0],[9,0],[10,2],[13,1],[13,6],[10,7],[5,4],[0,3],[5,6],[3,7],[3,9],[1,10],[2,14],[3,15],[5,13],[8,12],[11,14],[13,15],[13,13],[12,9],[6,7],[6,8],[8,7],[8,8],[2,1]]).
verticalObstacles([1,1,1,0], [[4,0],[2,1],[0,3],[5,4],[5,6],[3,7],[3,9],[0,13],[4,15],[6,14],[4,11],[8,10],[8,14],[10,15],[14,13],[12,9],[10,7],[13,6],[13,1],[10,2],[9,0],[6,7],[6,8],[8,7],[8,8]]).
verticalObstacles([1,1,1,1], [[2,1],[4,0],[0,3],[5,4],[5,6],[9,0],[10,2],[13,1],[13,6],[10,7],[12,9],[13,13],[13,15],[11,14],[8,12],[6,14],[4,15],[4,11],[3,9],[0,13],[3,7],[6,7],[6,8],[8,7],[8,8]]).



% horizontalObstacles(+Scenario, -Obstacles)
% Liste des coordonnées des obstacles horizontaux selon le scénario
horizontalObstacles([0,0,0,0], [[0,3],[0,6],[1,2],[6,1],[9,0],[11,2],[15,3],[13,5],[15,9],[10,6],[12,8],[7,5],[5,3],[2,5],[4,9],[9,10],[14,13],[9,13],[6,12],[2,14],[1,9],[7,6],[8,6],[7,8],[8,8]]).
horizontalObstacles([0,0,0,1], [[9,0],[15,1],[6,1],[11,2],[15,3],[5,3],[0,3],[1,2],[2,5],[7,5],[13,5],[10,6],[8,6],[7,6],[0,6],[7,8],[8,8],[12,8],[4,9],[1,9],[2,14],[6,12],[9,11],[11,14],[14,13]]).
horizontalObstacles([0,0,1,0], [[6,1],[9,0],[11,2],[15,3],[13,5],[7,5],[5,3],[1,2],[0,2],[2,5],[0,6],[7,6],[8,6],[7,8],[8,8],[9,10],[15,9],[12,8],[10,6],[14,13],[9,13],[6,13],[5,10],[3,9],[1,13]]).
horizontalObstacles([0,0,1,1], [[6,1],[9,0],[11,2],[15,1],[15,3],[5,3],[1,2],[0,2],[0,6],[2,5],[7,5],[13,5],[10,6],[8,6],[7,6],[7,8],[8,8],[12,8],[9,11],[5,10],[3,9],[14,13],[11,14],[6,13],[1,13]]).
horizontalObstacles([0,1,0,0], [[6,1],[11,2],[14,0],[15,3],[7,5],[5,3],[1,2],[0,3],[0,6],[2,5],[4,9],[1,9],[7,6],[8,6],[7,8],[8,8],[10,6],[12,8],[15,9],[13,6],[14,13],[9,10],[9,13],[6,12],[2,14]]).
horizontalObstacles([0,1,0,1], [[6,1],[14,0],[15,1],[15,3],[11,2],[13,6],[10,6],[8,6],[7,6],[7,8],[8,8],[7,5],[5,3],[2,5],[1,2],[0,3],[0,6],[4,9],[1,9],[2,14],[6,12],[9,11],[11,14],[14,13],[12,8]]).
horizontalObstacles([0,1,1,0], [[0,2],[1,2],[6,1],[11,2],[14,0],[15,3],[10,6],[13,6],[7,5],[5,3],[2,5],[0,6],[7,6],[8,6],[7,8],[8,8],[9,10],[3,9],[5,10],[1,13],[6,13],[9,13],[15,9],[12,8],[14,13]]).
horizontalObstacles([0,1,1,1], [[0,2],[1,2],[6,1],[5,3],[11,2],[15,1],[15,3],[14,0],[13,6],[10,6],[8,6],[7,6],[7,5],[7,8],[8,8],[12,8],[14,13],[11,14],[9,11],[5,10],[6,13],[1,13],[3,9],[0,6],[2,5]]).
horizontalObstacles([1,0,0,0], [[0,3],[1,3],[0,4],[2,1],[6,3],[9,0],[11,2],[15,3],[13,5],[12,8],[15,9],[10,6],[8,6],[7,6],[7,8],[8,8],[9,10],[4,9],[5,5],[3,7],[1,9],[2,14],[6,12],[9,13],[14,13]]).
horizontalObstacles([1,0,0,1], [[2,1],[0,3],[1,3],[0,4],[6,3],[9,0],[15,1],[15,3],[11,2],[13,5],[10,6],[12,8],[7,6],[8,6],[7,8],[8,8],[5,5],[4,9],[3,7],[1,9],[2,14],[6,12],[9,11],[14,13],[11,14]]).
horizontalObstacles([1,0,1,0], [[0,2],[1,3],[2,1],[6,3],[9,0],[11,2],[15,3],[13,5],[15,9],[12,8],[10,6],[8,6],[7,6],[7,8],[8,8],[5,5],[0,4],[3,7],[3,9],[5,10],[1,13],[6,13],[9,13],[9,10],[14,13]]).
horizontalObstacles([1,0,1,1], [[2,1],[0,2],[1,3],[0,4],[6,3],[5,5],[3,7],[3,9],[1,13],[5,10],[6,13],[9,11],[11,14],[14,13],[12,8],[10,6],[13,5],[15,3],[15,1],[11,2],[9,0],[8,6],[7,6],[7,8],[8,8]]).
horizontalObstacles([1,1,0,0], [[2,1],[0,3],[1,3],[0,4],[6,3],[5,5],[7,6],[8,6],[7,8],[8,8],[10,6],[13,6],[15,3],[14,0],[11,2],[15,9],[12,8],[9,10],[14,13],[9,13],[6,12],[4,9],[2,14],[1,9],[3,7]]).
horizontalObstacles([1,1,0,1], [[0,3],[1,3],[0,4],[2,1],[6,3],[11,2],[15,1],[15,3],[14,0],[13,6],[10,6],[12,8],[14,13],[11,14],[9,11],[6,12],[4,9],[1,9],[2,14],[3,7],[5,5],[7,6],[8,6],[7,8],[8,8]]).
horizontalObstacles([1,1,1,0], [[7,8],[8,8],[7,6],[8,6],[2,1],[0,2],[1,3],[0,4],[6,3],[11,2],[14,0],[15,3],[15,9],[12,8],[13,6],[10,6],[14,13],[9,13],[9,10],[6,13],[5,10],[1,13],[3,7],[3,9],[5,5]]).
horizontalObstacles([1,1,1,1], [[0,2],[1,3],[2,1],[6,3],[0,4],[3,7],[5,5],[3,9],[5,10],[1,13],[6,13],[9,11],[11,14],[14,13],[12,8],[10,6],[13,6],[15,3],[15,1],[14,0],[11,2],[7,6],[8,6],[7,8],[8,8]]).

% ############################# manhatan
% manhatan(+A, +B, -Distance)
% Calcule la distance de manhatan entre les coordonnées du point A et B
manhatan([X1, Y1], [X2, Y2], Z) :- Z is abs(X1-X2) + abs(Y1-Y2).

% ############################# arrivee
% arrivee(+Pos, +Coord, +Dir, -Arr)
% Renvois les coordonnées d'arrivée du robot se trouvant aux coordonnées Pos 
% en fonction des coordonnées des obstacles verticaux et horizontaux listés dans les variables globales verticalObstacles et horizontalObstacles
% et en fonction des coordonnées des autres robots listées dans Coord
% dans la direction Dir

% Ex : direction droite => verticalObstacle (la liste des obstacles verticaux donne les coordonnées des cases ayant un mur à droite )
% pour commencer on teste si l’on n’est pas déjà contre un mur dans ce cas la position de départ est la même que celle d’arrivée.
arrivee(POS, COORD, DIR, POS) :- contreUnMur(POS, COORD, DIR), !.

% puis, on avance de 1 en 1 dans la direction jusqu’a être contre un mur
% DROITE
arrivee([X, Y], COORD, 1, [X1, Y]) :- X1 is X + 1, contreUnMur([X1, Y], COORD, 1), !.
arrivee([X, Y], COORD, 1, POS) :- X1 is X + 1, arrivee([X1, Y], COORD, 1, POS),! .
% HAUT
arrivee([X, Y], COORD, 2, [X, Y1]) :- Y1 is Y - 1, contreUnMur([X, Y1], COORD, 2), !.
arrivee([X, Y], COORD, 2, POS) :- Y1 is Y - 1, arrivee([X, Y1],  COORD, 2, POS), !.
% GAUCHE
arrivee([X, Y], COORD, 3, [X1, Y]) :- X1 is X - 1, contreUnMur([X1, Y],  COORD,3), !.
arrivee([X, Y], COORD, 3, POS) :- X1 is X - 1, arrivee([X1, Y],  COORD,3, POS), !.
% BAS
arrivee([X, Y], COORD, 4, [X, Y1]) :- Y1 is Y + 1, contreUnMur([X, Y1], COORD, 4), !.
arrivee([X, Y], COORD, 4, POS) :- Y1 is Y + 1, arrivee([X, Y1], COORD, 4, POS), !.

% ############################# Contre un mur
% contreUnMur(+Pos, +Coord, +Dir)
% Est vrais si le robot de coordonnées Pos se trouve directement contre un obstacles ou un autre robot dans la direction Dir
% La liste des obstacles verticaux et horizontaux se trouvent dans les variables globales verticalObstacles et horizontalObstacles
% La liste des coordonnées des autres robots utilisée est Coord

% DIRECTION : DROITE
% si l’on est contre un bord de l’écran
contreUnMur([15,_],_, 1) :- !.
% si l’on est contre un robot
contreUnMur([X,Y],C,1) :- 
    X1 is X+1,
    member([X1,Y],C),
    !.
% on teste s’il l’on se trouve sur une case avec un mur vertical à droite
contreUnMur(P,_, 1) :- nb_getval(verticalObstacles, OBS), member(P, OBS),!.

% DIRECTION : GAUCHE
% si l’on est contre un bord de l’écran
contreUnMur([0,_],_, 3) :- !.
% si l’on est contre un robot
contreUnMur([X,Y],C,3) :- 
    X1 is X-1,
    member([X1,Y],C),
    !.
% on teste s’il l’on se trouve à droite d’une case avec un mur vertical à droite (car on veut aller à gauche)
contreUnMur([X, Y],_, 3) :- X1 is X-1, nb_getval(verticalObstacles, OBS), member([X1, Y], OBS),!.

% DIRECTION : HAUT
% si l’on est contre un bord de l’écran
contreUnMur([_,0],_, 2) :- !.
% si l’on est contre un robot
contreUnMur([X,Y],C,2) :- 
    Y1 is Y-1,
    member([X,Y1],C),
    !.
% on teste s’il l’on se trouve en dessous d’une case avec un mur horizontal en bas.
contreUnMur([X, Y],_, 2) :- Y1 is Y-1, nb_getval(horizontalObstacles, OBS), member([X,Y1] , OBS),!.

% DIRECTION : BAS
% si l’on est contre un bord de l’écran
contreUnMur([_,15],_, 4) :- !.
% si l’on est contre un robot
contreUnMur([X,Y],C,4) :- 
    Y1 is Y+1,
    member([X,Y1],C),
    !.
% on teste s’il l’on se trouve sur une case avec un mur horizontal en bas.
contreUnMur(P,_, 4) :-  nb_getval(horizontalObstacles, OBS), member(P, OBS),!.

% ############################# INIT
% initialisation(+GM)
% Initialisation des variables globales en fonction de la configuration donnée par le prédicat move/2
initialisation([S1, S2, S3, S4, NumCible, BX, BY, GX, GY, YX, YY, RX, RY]) :-
    % id scénario
    nb_setval(scenario, [S1,S2,S3,S4]),
    % target
    targets([S1,S2,S3,S4], Targets),
    nth0(NumCible, Targets, TargetC),
    nb_setval(target, TargetC),
    % robot id
    RobotID is floor((NumCible - 1) / 4),
    nb_setval(robotId, 0),
	setRobotsToMove(RobotID),
    % obstacles
    verticalObstacles([S1,S2,S3,S4], VObs),
    nb_setval(verticalObstacles, VObs),
    horizontalObstacles([S1,S2,S3,S4], HObs),
    nb_setval(horizontalObstacles, HObs),
    % liste ouverte
    nb_setval(listeOuverte, [[[[BX, BY],[GX, GY],[YX, YY],[RX, RY]],0,-1,-1,-1,[]] ]),
    % liste fermee
    nb_setval(listeFermee, []),
	% ##DEBUG
	nb_getval(nbTOTAL, TOTAL),
	TOTAL1 is TOTAL +1,
	nb_setval(nbTOTAL, TOTAL1),
	writef('\n[%d %d %d %d] ',[S1,S2,S3,S4]),
	write(TargetC),
	writef(' %d --\n',[RobotID]).
	
% ############################# SET ROBOTS TO MOVE
% setRobotsToMove(+IdRobot)
% Crée la variable globale robotsToMove en fonctiond de l'index du robot qui doit bouger
% l'index -1 est appelé lorsque la cible multicolore est demandée

setRobotsToMove(-1):-
    nb_setval(robotsToMove, [1,1,1,1]).
setRobotsToMove(0):-
    nb_setval(robotsToMove, [1,0,0,0]).
setRobotsToMove(1):-
    nb_setval(robotsToMove, [0,1,0,0]).
setRobotsToMove(2):-
    nb_setval(robotsToMove, [0,0,1,0]).
setRobotsToMove(3):-
    nb_setval(robotsToMove, [0,0,0,1]).


% ############################# RECUPERER ELEMENT LISTE OUVERTE
% recupererPremierListeOuverte(-E)
% renvois le premier element de la liste ouverte si possible
recupererPremierListeOuverte(X) :- 
    nb_getval(listeOuverte, [X|R]), 
    nb_setval(listeOuverte, R).

% ############################# INSERER ELEMENT LISTE OUVERTE
% insererElementListeOuverte(+E)
% insere l'element E en ordre croissant en fonction de son F
insererElementListeOuverte(X) :-
    nb_getval(listeOuverte, LO),
    insererElementListeOuverte(X, LO, RESULT),
    nb_setval(listeOuverte, RESULT).
insererElementListeOuverte(X, [], [X]) :- 
    !.
insererElementListeOuverte([C0,G0,F0,I0,D0,P0], 
                           [[C1,G1,F1,I1,D1,P1]|R], 
                           [[C0,G0,F0,I0,D0,P0],[C1,G1,F1,I1,D1,P1]|R]) :- 
    F0 < F1, 
    !.
insererElementListeOuverte(X0, [X1|R1], [X1|R2]) :-
    insererElementListeOuverte(X0, R1, R2).

% ############################# INSERER ELEMENT LISTE FERMEE
% insererElementListeFermee(+E)
% insere l'element E dans la liste fermée
insererElementListeFermee(X) :-
    nb_getval(listeFermee, LF),
    append([X], LF, NewLF),
    nb_setval(listeFermee, NewLF).
	
% ############################# TESTER ELEMENT LISTE FERMEE
% testerElementListeFermee(+E)
% Est faux si l'élément ne si trouve pas
% Si l'élement si trouve et que celui qui si trouve est meilleur que E, le prédicat est vrai
% Si l'élement si trouve et que E est meilleur, on met E à la place et le prédicat est vrai
testerElementListeFermee(X) :- 
    nb_getval(listeFermee, LF),
    testerElementListeFermee(X, LF, NewLF), 
    nb_setval(listeFermee, NewLF).

% la liste est vide (l’élement ne s’y trouve pas)
testerElementListeFermee(_, [], _) :- !, fail.

% l’élement si trouve et le nouvel est meilleur
testerElementListeFermee([C1, D1, F1,I1,Dir1, P1], [[C2,_,F2,_,_,_]|R], [[C1,D1,F1,I1,Dir1,P1]|R]) :- 
    =(C1,C2), 
    F1 < F2, 
    !. 
% l’élement s’y trouve et l’ancien est meilleur
testerElementListeFermee([C1, _, F1,_,_, _], [[C2,D2,F2,I2,Dir2,P2]|R], [[C2,D2,F2,I2,Dir2,P2]|R]) :- 
    =(C1,C2), 
    F1 >= F2, 
    !.
% on parcour la liste
testerElementListeFermee(X, [X1|R1], [X1|R2]) :- 
    testerElementListeFermee(X, R1, R2).
	
% ############################# TESTER ELEMENT LISTE OUVERTE
% testerElementListeOuverte(+E)
% Si l'element ne si trouve pas le prédicat est faux
% SI l'element si trouve et que celui qui si trouve est meilleur que E, le prédicat est vrai
% Si l'element si trouve et que E est meilleur, on supprime l'element de la liste ouverte et le prédicat est faux
testerElementListeOuverte(X) :- 
    nb_getval(listeOuverte, LO),
    testerElementListeOuverte(X, LO, NewLO, Fail), 
    nb_setval(listeOuverte, NewLO),
    Fail =\= 1. % si Fail == 1 on revois false

% la liste est vide (l’élement ne s’y trouve pas)
testerElementListeOuverte(_, [], _, _) :- !, fail.

% l’élement si trouve et l’ancien est meilleur
testerElementListeOuverte([C1, _, F1,_,_, _], [[C2,D2,F2,I2,Dir2,P2]|R], [[C2,D2,F2,I2,Dir2,P2]|R], 0) :- 
    =(C1,C2), 
    F1 >= F2, 
    !.

% l’élement si trouve et le nouvel est meilleur
testerElementListeOuverte([C1, _, F1,_,_, _], [[C2,_,F2,_,_,_]|R], R, 1) :- 
    =(C1,C2), 
    F1 < F2, 
    !. 

% on parcour la liste
testerElementListeOuverte(X, [X1|R1], [X1|R2], Fail) :- 
    testerElementListeOuverte(X, R1, R2, Fail).
	
% ############################# ETENDRE ETAT
% etendreEtat(+Etat, -Fini, -EtatFinal)
% on ajoute une fois Etat dans la liste fermée et on étend dans toutes les directions.
etendreEtat(Etat,Fini,EtatFinal):-
    insererElementListeFermee(Etat),
    etendreEtat(Etat,1, Fini,  EtatFinal),!.

etendreEtat(Etat,Fini,EtatFinal):-
    etendreEtat(Etat,2, Fini, EtatFinal),!.

etendreEtat(Etat,Fini,EtatFinal):-
    etendreEtat(Etat,3, Fini, EtatFinal),!.

etendreEtat(Etat,Fini,EtatFinal):-
    etendreEtat(Etat,4, Fini, EtatFinal),!.
	
% Si etendreEtat reussi nous avons trouvé un chemin
etendreEtat([Coord,Dist,_,ID,Dir,Parent], Direction,1, NewEtat):-
    % on construit l’état suivant
    nb_getval(robotId, RobotID),
    nth0(RobotID, Coord,CoordRobot),
    not(contreUnMur(CoordRobot,Coord,Direction)),
    arrivee(CoordRobot,Coord,Direction, Arrivee),
    remplacer(Coord,CoordRobot,Arrivee,NewCoord),
    nb_getval(target,Target),
    manhatan(Arrivee, Target, Heurist),
    NewDist is Dist +1,
    NewF is NewDist + Heurist,
    NewEtat = [NewCoord,NewDist,NewF,RobotID,Direction,[ID,Dir,Parent]],
    % tester liste fermée
    not(testerElementListeFermee(NewEtat)),
    %tester liste ouverte
    not(testerElementListeOuverte(NewEtat)),
    % ajout dans la liste ouverte
    insererElementListeOuverte(NewEtat),
    % on teste l’état final
    Heurist =:= 0.
	
% ############################# REMPLACER	
% remplacer(+L1, +A, +B, -L2) # equivalent de select
% remplacer le premier element A par l'element B dans la liste L1 donne la liste L2
remplacer([],_,_,[]):-!.
remplacer([A|R],A,B,[B|R]):-!.
remplacer([X|R],A,B,[X|R1]):- remplacer(R,A,B,R1).

	
% ############################# A ETOILE PREP
% aEtoilePrep(-M, +RobotsToMove)
% Parcour de la liste RobotsToMove, appel d'un A* pour chaque booléen à 1
aEtoilePrep(M, [1|R]):-
    writef('A*'),
    aEtoile(M),
	!.

aEtoilePrep(M, [_|R]):-
    nb_getval(robotId, ID),
    RobotID is ID +1,
    nb_setval(robotId, RobotID),
	writef('Le robot %d va tenter\n', [ID]),
	aEtoilePrep(M, R).
	
aEtoilePrep([],[]).

% ############################## A ETOILE
% aEtoile(-M)
% appel de A* , création de la liste des mouvements à partir de l'état final
aEtoile(Mouvements):-
   aEtoileBoucle(Etat),
   trouverMouvements(Etat,RMouvements),
   reverse(RMouvements, Mouvements).

% ############################## A ETOILE BOUCLE
% aEtoileBoucle(-EF)
% etend les premiers état se trouvant dans la liste ouverte jusqu'a avoir trouver un état final ou que la liste ouverte soit vide
aEtoileBoucle(EtatFinal):-
   repeat,
   aEtoileRepeat(EtatFinal, Fini),
   Fini =:= 1,
   !.

% ############################## A ETOILE REPEAT
% aEtoileRepeat(-EF, -F)
% si la liste ouverte est vide renvois l'état final [] et arrete le repeat avec F à 1
% sinon étend le premier etat de la liste ouverte
aEtoileRepeat([],1):-
    nb_getval(listeOuverte,[]),
	writef('\n_________________________PAS TROUVE DE SOLUTION.________________________________'),
    !.

aEtoileRepeat(EtatFinal,Fini):-
   recupererPremierListeOuverte(Etat),
   etendreEtat(Etat,Fini,EtatFinal).

   
% ############################## TROUVER MOUVEMENTS
% trouverMouvements(+EF, -M)
% créer la liste des mouvements attendu par move (à l'envers)
trouverMouvements([_,_,[]], []):-!.
trouverMouvements([Id,Dir,P], [Dir,Id|R]):- trouverMouvements(P,R),!.
trouverMouvements([_,_,_,Id,Dir,P], [Dir,Id|R]):- trouverMouvements(P,R),!.

% ############################## MOVE
% move(+GM, -M)
% prédicat appelé par ipseity
% nous donne la configuration du jeu, attend les mouvements en conséquence
move(GM, M):-
    initialisation(GM),
	nb_getval(robotsToMove, RobotsToMove),
    aEtoilePrep(M,RobotsToMove),
	nb_getval(nbGJ,NB),
	nb_getval(nbTOTAL,TOTAL),
	write(M),
	ignore(
	(
	    not(=(M,[])),
	    NB1 is NB + 1,
		nb_setval(nbGJ,NB1),
		writef(' nbGJ %d/%d \n',[NB1,TOTAL])
	)
	),
	ignore(
	(
	    =(M,[]),
	   writef(' nbGJ %d/%d \n',[NB,TOTAL])
	)
	)	.
