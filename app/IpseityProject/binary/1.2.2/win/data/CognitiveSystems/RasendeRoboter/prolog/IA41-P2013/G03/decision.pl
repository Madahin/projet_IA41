:- module( decision, [
	init/1,
	move/2
] ).

:-dynamic obstacle/2.

/*
  Définition de l'IA du joueur artificiel de Rasende Roboter
*/


init(_).

/*
  Définition du prédicat move( +L, -ActionId ), l'objectif de ce projet.
  move([TL,TR,BL,BR, TargetId, BlueRobotPosition, GreenRobotPosition,YellowRobotPosition, RedRobotPosition], [liste de codes robot(0 1 2 3)-mvt (1,2,3,4)]).
*/
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R):- T>=1, T=<4, target(T,Xt,Yt), ajouterObstacle(Xg,Yg), ajouterObstacle(Xy,Yy), ajouterObstacle(Xr,Yr), rechercheChemin([Xt,Yt],[[[Xb,Yb],0]],[],0,Chemin), traitementChemin(Chemin, 0, R),!.
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R):- T>=5, T=<8, target(T,Xt,Yt), ajouterObstacle(Xb,Yb), ajouterObstacle(Xy,Yy), ajouterObstacle(Xr,Yr), rechercheChemin([Xt,Yt],[[[Xg,Yg],0]],[],0,Chemin), traitementChemin(Chemin, 1, R),!.
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R):- T>=9, T=<12,target(T,Xt,Yt), ajouterObstacle(Xb,Yb), ajouterObstacle(Xg,Yg), ajouterObstacle(Xr,Yr), rechercheChemin([Xt,Yt],[[[Xy,Yy],0]],[],0,Chemin), traitementChemin(Chemin, 2, R),!.
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R):- T>=13,T=<16,target(T,Xt,Yt), ajouterObstacle(Xb,Yb), ajouterObstacle(Xg,Yg), ajouterObstacle(Xy,Yy), rechercheChemin([Xt,Yt],[[[Xr,Yr],0]],[],0,Chemin), traitementChemin(Chemin, 3, R),!.

/* Un traitement spécial est prévu pour le cas de la cible 0 */
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R1):-T=:=0,target(T,Xt,Yt), ajouterObstacle(Xg,Yg), ajouterObstacle(Xy,Yy), ajouterObstacle(Xr,Yr), rechercheChemin([Xt,Yt],[[[Xb,Yb],0]],[],0,Chemin1), traitementChemin(Chemin1, 0, R1).
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R2):-T=:=0,target(T,Xt,Yt), ajouterObstacle(Xb,Yb), ajouterObstacle(Xy,Yy), ajouterObstacle(Xr,Yr), rechercheChemin([Xt,Yt],[[[Xg,Yg],0]],[],0,Chemin2), traitementChemin(Chemin2, 1, R2).
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R3):-T=:=0,target(T,Xt,Yt), ajouterObstacle(Xb,Yb), ajouterObstacle(Xg,Yg), ajouterObstacle(Xr,Yr), rechercheChemin([Xt,Yt],[[[Xy,Yy],0]],[],0,Chemin3), traitementChemin(Chemin3, 2, R3).
move([0,0,0,0, T, Xb,Yb, Xg,Yg, Xy,Yy, Xr,Yr],R4):-T=:=0,target(T,Xt,Yt), ajouterObstacle(Xb,Yb), ajouterObstacle(Xg,Yg), ajouterObstacle(Xy,Yy), rechercheChemin([Xt,Yt],[[[Xr,Yr],0]],[],0,Chemin4), traitementChemin(Chemin4, 3, R4),!.

move([_,_,_,_, _, _,_, _,_, _,_, _,_],[]):-write("On a pas encore de solution pour celle là").


/** definition du prédicat traitementChemin(+Chemin, +IndicatifRobot, -CheminFinal) qui renvoie les mouvements du robot **/
traitementChemin(Chemin, IndicatifRobot, CheminFinal):-triChemin(Chemin, CheminTrie),listeInverse(CheminTrie, CheminInverse), conversionChemin(CheminInverse, IndicatifRobot, CheminFinal).


/*** definition du prédicat conversionChemin(+Chemin, +IndicatifRobot, -CheminFinal) qui renvoie les mouvements du robot convertis d'une suite de positions en mouvements ***/
conversionChemin([[[X1,Y1],_]], IndicatifRobot,[]).
conversionChemin([[[X1,Y1],_],[[X2,Y2],_]|R], IndicatifRobot, [IndicatifRobot,IndicatifDirection | CheminFinal]):-
	conversionChemin([[[X2,Y2],_]|R], IndicatifRobot, CheminFinal),
	definirDirection(X1,Y1,X2,Y2,IndicatifDirection).

/**** definition du prédicat definirDirection(+X1,+Y1,+X2,+Y2,-IndicatifDirection) qui renvoie l'indicatif de direction
   1 : droite, 2 : haut, 3 : gauche, 4 : bas ****/
definirDirection(X1,Y1,X2,Y2,1):- Y1 =:= Y2, X1 =< X2.
definirDirection(X1,Y1,X2,Y2,2):- X1 =:= X2, Y1 >= Y2.
definirDirection(X1,Y1,X2,Y2,3):- Y1 =:= Y2, X1 >= X2.
definirDirection(X1,Y1,X2,Y2,4):- X1 =:= X2, Y1 =< Y2.


/*** Définition du prédicat listeInverse(+L1, -L2) qui inverse les élements de la liste ***/
listeInverse([],[]):-!.
listeInverse([T|R],L2):-ajout_fin(T,L3,L2), listeInverse(R,L3).


/*** Definition du prédicat triChemin(Chemin, CheminTrie), qui selectionne un passage (suite de voisins) dans les élements visités de chemin ***/
triChemin([T1,T2],[T1,T2]):-!.
triChemin([T1,T2,T3|Reste1],[T1|Reste2]):-estVoisin(T2,T1),not(estVoisin(T3,T1)),!,triChemin([T2,T3|Reste1], Reste2).
triChemin([T1,T2|Reste1],[T1|Reste2]):-triChemin([T1|Reste1],[T1|Reste2]).


/**** Définition du prédicat estVoisin(X,Y), renvoie true ou false selon si les deux élements sont voisins ****/
estVoisin([[X1,Y1],_],[[X2,Y2],_]):-noeudVoisinDroit([[X1,Y1],_],[[X3,Y3],_]),X2=X3,Y2=Y3,!.
estVoisin([[X1,Y1],_],[[X2,Y2],_]):-noeudVoisinHaut([[X1,Y1],_],[[X3,Y3],_]),X2=X3,Y2=Y3,!.
estVoisin([[X1,Y1],_],[[X2,Y2],_]):-noeudVoisinGauche([[X1,Y1],_],[[X3,Y3],_]),X2=X3,Y2=Y3,!.
estVoisin([[X1,Y1],_],[[X2,Y2],_]):-noeudVoisinBas([[X1,Y1],_],[[X3,Y3],_]),X2=X3,Y2=Y3.


/***** Définition du prédicat noeudVoisinDroit(+EtatActuel,-NoeudVoisinDroit) *****/
noeudVoisinDroit([[X,Y],_],[[X,Y],_]).
noeudVoisinDroit([[X,Y],_],NoeudVoisinDroit):-X1 is X+1,not(obstacle([X,Y],[X1,Y])),!,noeudVoisinDroit([[X1,Y],_],NoeudVoisinDroit).


/***** Définition du prédicat noeudVoisinHaut(+EtatActuel,-NoeudVoisinHaut() *****/
noeudVoisinHaut([[X,Y],_],[[X,Y],_]).
noeudVoisinHaut([[X,Y],_],NoeudVoisinHaut):-Y1 is Y+1,not(obstacle([X,Y],[X,Y1])),!,noeudVoisinHaut([[X,Y1],_],NoeudVoisinHaut).



/***** Définition du prédicat noeudVoisinGauche(+EtatActuel,-NoeudVoisinGauche) *****/
noeudVoisinGauche([[X,Y],_],[[X,Y],_]).
noeudVoisinGauche([[X,Y],_],NoeudVoisinGauche):-X1 is X-1,not(obstacle([X1,Y],[X,Y])),!,noeudVoisinGauche([[X1,Y],_],NoeudVoisinGauche).



/***** Définition du prédicat noeudVoisinBas(+EtatActuel,-NoeudVoisinBas) ****/
noeudVoisinBas([[X,Y],_],[[X,Y],_]).
noeudVoisinBas([[X,Y],_],NoeudVoisinBas):-Y1 is Y-1,not(obstacle([X,Y1],[X,Y])),!,noeudVoisinBas([[X,Y1],_],NoeudVoisinBas).

	

/** Definition du prédicat rechercheChemin(+EtatFinal, +OpenList, +ClosedList, +CoutCheminInitial, -Chemin), qui essaie de trouver une liste de points voisins entre l'etat initial et l'état final **/
rechercheChemin([Xf,Yf], OpenList, ClosedList, CoutChemin, Chemin):-
	appartient([[Xf,Yf],_], OpenList),
	ajout_fin([[Xf,Yf],CoutChemin],[],Chemin),!.
rechercheChemin([Xf,Yf], OpenList, ClosedList, CoutChemin, Chemin):-
	longueurListe(OpenList,Long),
	meilleurNoeudOpenList(OpenList,Long, Resultat),
	miseAJourOpenListEtClosedList(Resultat,OpenList,ClosedList,NewOpen,NewClosedList),
	CoutCheminActuel is CoutChemin +2,
	miseAJourDeOpenList(Resultat,[Xf,Yf], CoutCheminActuel, NewClosedList, NewOpen, NewOpenList),
	ajout_fin(Resultat, CheminActuel, Chemin),
	rechercheChemin([Xf,Yf],NewOpenList, NewClosedList, CoutCheminActuel, CheminActuel).
	

/*** Définition du prédicat appartient(+[X,Y],+L) avec X,Y deux expressions et L une liste, définit (true ou false) si les atomes composent un élement de la liste ***/
appartient(X,[X|R]):-!.
appartient(X,[T|R]):-dif(X,T),appartient(X,R).


/*** Définition du prédicat ajout_debut(+X,+L,?R) avec X une expression, L et R des listes, ajoute l'atome au début de la liste et renvoie R ***/
ajout_debut(X,L,[X|L]).


/*** Définition du prédicat ajout_fin(+X,+L,?R) avec X une expression, L et R des listes, R étant L plus un dernier élement : X ***/
ajout_fin(X,[],[X]).
ajout_fin(X,[T|R1],[T|R2]):-ajout_fin(X,R1,R2).

/*** Définition du prédicat longueurListe(L,N) où L est une liste et N est un entier représentant le nb d'élements dans la liste ***/
longueurListe([],0):-!.
longueurListe([T|R],N):-longueurListe(R,N1), N is N1 + 1 .
	
	
/*** Définition du prédicat meilleurNoeudOpenList(+OpenList, +Longueur, -MeilleurNoeud) qui permet de définir le noeud ayant une evaluation minimum ***/
meilleurNoeudOpenList([ [[X,Y],R] ], Longueur, [[X,Y],R]):-!.
meilleurNoeudOpenList([ [[X,Y],R] | Reste], Longueur, [[X,Y],R]):-meilleurNoeudOpenList(Reste, Longueur, [[Xs,Ys],R1]),R =< R1,!.
meilleurNoeudOpenList([ [[X,Y],R] | Reste], Longueur, Resultat):-meilleurNoeudOpenList(Reste, Longueur, Resultat).


/*** Définition du prédicat miseAJourOpenListEtClosedList(+EtatChoisi, +OpenList, +ClosedLis, -NewOpenList, -NewClosedList) ***/
miseAJourOpenListEtClosedList([[Xm,Ym],X], OpenList, ClosedList, NewOpenList, NewClosedList):-enlever([[Xm,Ym],X],OpenList,NewOpenList),ajout_fin([[Xm,Ym],X],ClosedList,NewClosedList),!.


/**** prédiact enlever(+X,+L1,-L2) ou L2 est L1 sans aucune occurence de X. ****/
enlever(_,[],[]).
enlever(X,[X|Y],R):-enlever(X,Y,R).
enlever(X,[T|Y],[T|R]):-dif(X,T),enlever(X,Y,R).


/* Définition du prédicat miseAJourNoeudVoisin(+S,+F,+ClosedList,+OpenList,-NewOpenList) avec S une liste représentant les coordonnées de l'etat actuel, F celles de l'objectif et OpenList une liste représentant
 les différents accessibles, ClosedList une liste représentant les noeuds déjà abordés et NewOpenList une liste représentant la liste OpenList mise à jour après la recherche du 
 nouveau voisin */
miseAJourDeOpenList([[X,Y],_],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NewOpenList):-
	recherchenoeudvoisindroit([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin1),
	recherchenoeudvoisinhaut([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin2),
	recherchenoeudvoisingauche([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin3),
	recherchenoeudvoisinbas([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin4),
	concat(NoeudVoisin1,NoeudVoisin2,L1),
	concat(NoeudVoisin3,NoeudVoisin4,L2),
	concat(L1,L2,L3),
	concat(L3,OpenList,NewOpenList).
	
	
/* Définition du prédicat recherchenoeudvoisindroit(+S,+OpenList,+ClosedList,-NewOpenList) avec S une liste représentant les coordonnées de l'etat actuel et OpenList une liste représentant
 les différents accessibles, ClosedList une liste représentant les noeuds déjà abordés et NewOpenList une liste représentant la liste OpenList mise à jour après la recherche du 
 nouveau voisin */
recherchenoeudvoisindroit([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin):-X1 is X+1,not(obstacle([X,Y],[X1,Y])),!,recherchenoeudvoisindroit([X1,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).
recherchenoeudvoisindroit([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,[[[X,Y],R]]):-not(appartient([[X,Y],_],ClosedList)),not(appartient([[X,Y],_],OpenList)),fonctionEval([X,Y],[Xf,Yf],CoutCheminActuel,R),!.
recherchenoeudvoisindroit([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).


/* Définition du prédicat recherchenoeudvoisingauche(+S,+OpenList,+ClosedList,-NewOpenList) avec S une liste représentant les coordonnées de l'etat actuel et OpenList une liste représentant
 les différents accessibles, ClosedList une liste représentant les noeuds déjà abordés et NewOpenList une liste représentant la liste OpenList mise à jour après la recherche du 
 nouveau voisin */
recherchenoeudvoisingauche([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin):-X1 is X-1,not(obstacle([X1,Y],[X,Y])),!,recherchenoeudvoisingauche([X1,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).
recherchenoeudvoisingauche([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,[[[X,Y],R]]):-not(appartient([[X,Y],_],ClosedList)),not(appartient([[X,Y],_],OpenList)),fonctionEval([X,Y],[Xf,Yf],CoutCheminActuel,R),!.
recherchenoeudvoisingauche([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).


/* Définition du prédicat recherchenoeudvoisinhaut(+S,+OpenList,+ClosedList,-NewOpenList) avec S une liste représentant les coordonnées de l'etat actuel et OpenList une liste représentant
 les différents accessibles, ClosedList une liste représentant les noeuds déjà abordés et NewOpenList une liste représentant la liste OpenList mise à jour après la recherche du 
 nouveau voisin */
recherchenoeudvoisinhaut([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin):-Y1 is Y+1,not(obstacle([X,Y],[X,Y1])),!,recherchenoeudvoisinhaut([X,Y1],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).
recherchenoeudvoisinhaut([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,[[[X,Y],R]]):-not(appartient([[X,Y],_],ClosedList)),not(appartient([[X,Y],_],OpenList)),fonctionEval([X,Y],[Xf,Yf],CoutCheminActuel,R),!.
recherchenoeudvoisinhaut([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).


/* Définition du prédicat recherchenoeudvoisinbas(+S,+OpenList,+ClosedList,-NewOpenList) avec S une liste représentant les coordonnées de l'etat actuel et OpenList une liste représentant
 les différents accessibles, ClosedList une liste représentant les noeuds déjà abordés et NewOpenList une liste représentant la liste OpenList mise à jour après la recherche du 
 nouveau voisin */
recherchenoeudvoisinbas([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin):-Y1 is Y-1,not(obstacle([X,Y1],[X,Y])),!,recherchenoeudvoisinbas([X,Y1],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).
recherchenoeudvoisinbas([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,[[[X,Y],R]]):-not(appartient([[X,Y],_],ClosedList)),not(appartient([[X,Y],_],OpenList)),!,fonctionEval([X,Y],[Xf,Yf],CoutCheminActuel,R),!.
recherchenoeudvoisinbas([X,Y],[Xf,Yf],CoutCheminActuel,ClosedList,OpenList,NoeudVoisin).


/* Définition du prédicat FonctionEval(+EtatSuivant, +EtatFinal, +CoutCheminActuel, +ResultatFonction) permet d'évaluer le cout du chemin choisi */
fonctionEval([Xs,Ys],[Xf,Yf],CoutCheminActuel,R):-distanceManhattan([Xs,Ys],[Xf,Yf],Distance), Cout is CoutCheminActuel+2,R is Distance+Cout.


/* Définition du prédicat distanceManhattan(+Etatsuivant,+EtatFinal,-Distance) qui calcule la distance de manhatan entre un point et le point final (objectif)*/
distanceManhattan([X1,Y1],[X2,Y2],D):-D1 is abs(X1-X2), D2 is abs(Y1-Y2), D is D1 + D2.

	
/* Définition du prédicat concat(+L1,+L2,?L3) avec L1,L2 et L3 (composé de tous les éléments de L1 puis de L2) des listes */
concat([],L,L):-!.
concat([T|R1],L2,[T|R3]):-concat(R1,L2,R3).	
	
	
	
/* predicat obstacle, qui répond si un obsacle(existe entre les coordonées
	au début, map fixe) 
	
 Les autres robots sont des obstacles :
 ajouterObstacle(+Coordonées X, coordonée Y) ou X et Y les coordonnées d'un point ou le robot ne peut pas se rendre (obstacle), ici utilisé pour les autres robots.*/
ajouterObstacle(X,Y):- Y1 is Y+1, X1 is X+1, Y2 is Y-2, X2 is X-2, assertz( obstacle([X,Y],[X,Y1]) ), assertz( obstacle([X,Y],[X1,Y]) ), assertz( obstacle([X,Y2],[X,Y1]) ), assertz( obstacle([X2,Y],[X,Y1]) ).

/* Ensuite on comptabilise les obstacles sur le plateau*/
% coté haut gauche 0,0 à 7,7
			obstacle( [5,1], [6,1] ). 
			obstacle( [6,1], [6,2] ).
			obstacle( [1,2], [1,3] ).
			obstacle( [1,3], [2,3] ).
			obstacle( [5,3], [5,4] ).
			obstacle( [4,4], [5,4] ).
			obstacle( [2,5], [3,5] ).
			obstacle( [2,5], [2,6] ).
			obstacle( [7,5], [8,5] ).
			obstacle( [7,5], [7,6] ).
			obstacle( [0,6], [0,7] ).
			obstacle( [6,7], [7,7] ).
			obstacle( [7,6], [7,7] ).
% coté haut droite 7,0 à 15,7			
			obstacle( [10,0], [11,0] ).
			obstacle( [15,3], [15,4] ).
			obstacle( [9,0],  [9,1] ).
			obstacle( [9,1], [10,1] ).
			obstacle( [11,2], [12,2] ).
			obstacle( [11,2], [11,3] ).
			obstacle( [12,5], [13,5] ).
			obstacle( [13,5], [13,6] ).
			obstacle( [9,7], [10,7] ).
			obstacle( [10,6], [10,7] ).
			obstacle( [8,7], [9,7] ).
			obstacle( [8,6], [8,7] ).	
% coté bas gauche 0,7 à 7,15	
			obstacle( [6,8], [7,8] ).
			obstacle( [7,8], [7,9] ).
			obstacle( [3,9], [4,9] ).
			obstacle( [4,9], [4,10] ).
			obstacle( [1,9], [1,10] ).
			obstacle( [1,10], [2,10] ).
			obstacle( [5,13], [6,13] ).
			obstacle( [6,12], [6,13] ).
			obstacle( [2,14], [3,14] ).
			obstacle( [2,14], [2,15] ).
			obstacle( [0,3], [0,4] ).
			obstacle( [3,15], [4,15] ).
% coté bas droite 7,7 à 15,15
			obstacle( [8,8], [9,8] ).
			obstacle( [8,8], [8,9] ).
			obstacle( [15,9], [15,10] ).
			obstacle( [10,15], [11,15] ).
			obstacle( [12,8], [12,9] ).
			obstacle( [12,9], [13,9] ).
			obstacle( [8,10], [9,10] ).
			obstacle( [9,10], [9,11] ).
			obstacle( [14,13], [15,13] ).
			obstacle( [14,13], [14,14] ).
			obstacle( [8,14], [9,14] ).
			obstacle( [9,13], [9,14] ).	

% On comptabilise les murs autour du plateau en tant quobstacles
			obstacle( [-1,0], [0,0] ).	
			obstacle( [-1,1], [0,1] ).	
			obstacle( [-1,2], [0,2] ).	
			obstacle( [-1,3], [0,3] ).	
			obstacle( [-1,4], [0,4] ).	
			obstacle( [-1,5], [0,5] ).	
			obstacle( [-1,6], [0,6] ).	
			obstacle( [-1,7], [0,7] ).	
			obstacle( [-1,8], [0,8] ).	
			obstacle( [-1,9], [0,9] ).	
			obstacle( [-1,10], [0,10] ).	
			obstacle( [-1,11], [0,11] ).	
			obstacle( [-1,12], [0,12] ).	
			obstacle( [-1,13], [0,13] ).	
			obstacle( [-1,14], [0,14] ).	
			obstacle( [-1,15], [0,15] ).	
			
			obstacle( [15,0], [16,0] ).	
			obstacle( [15,1], [16,1] ).	
			obstacle( [15,2], [16,2] ).	
			obstacle( [15,3], [16,3] ).	
			obstacle( [15,4], [16,4] ).	
			obstacle( [15,5], [16,5] ).	
			obstacle( [15,6], [16,6] ).	
			obstacle( [15,7], [16,7] ).	
			obstacle( [15,8], [16,8] ).	
			obstacle( [15,9], [16,9] ).	
			obstacle( [15,10], [16,10] ).	
			obstacle( [15,11], [16,11] ).	
			obstacle( [15,12], [16,12] ).	
			obstacle( [15,13], [16,13] ).	
			obstacle( [15,14], [16,14] ).
			obstacle( [15,15], [16,15] ).				
			
			obstacle( [0,-1], [0,0] ).	
			obstacle( [1,-1], [1,0] ).	
			obstacle( [2,-1], [2,0] ).	
			obstacle( [3,-1], [3,0] ).	
			obstacle( [4,-1], [4,0] ).	
			obstacle( [5,-1], [5,0] ).	
			obstacle( [6,-1], [6,0] ).	
			obstacle( [7,-1], [7,0] ).	
			obstacle( [8,-1], [8,0] ).	
			obstacle( [9,-1], [9,0] ).	
			obstacle( [10,-1], [10,0] ).	
			obstacle( [11,-1], [11,0] ).	
			obstacle( [12,-1], [12,0] ).	
			obstacle( [13,-1], [13,0] ).	
			obstacle( [14,-1], [14,0] ).	
			obstacle( [15,-1], [15,0] ).	
				
			
			obstacle( [0,15], [0,16] ).	
			obstacle( [1,15], [1,16] ).	
			obstacle( [2,15], [2,16] ).			
			obstacle( [3,15], [3,16] ).	
			obstacle( [4,15], [4,16] ).	
			obstacle( [5,15], [5,16] ).	
			obstacle( [6,15], [6,16] ).	
			obstacle( [7,15], [7,16] ).	
			obstacle( [8,15], [8,16] ).	
			obstacle( [9,15], [9,16] ).	
			obstacle( [10,15], [10,16] ).	
			obstacle( [11,15], [11,16] ).	
			obstacle( [12,15], [12,16] ).	
			obstacle( [13,15], [13,16] ).	
			obstacle( [14,15], [14,16] ).	
			obstacle( [15,15], [15,16] ).	
	
	
	
/* Prédicat Target(+IdTarget, -CoordXTarget, -CoordYTarget) qui réussit si Id de la cible du robot s'unifie avec ces coordonées	*/
% liste des cibles
			target(0, 7,5).
			target(1, 6,1).
			target(2, 9,10).
			target(3, 13,5).
			target(4, 6,13).
			target(5, 11,2).
			target(6, 5,4).
			target(7, 1,10).
			target(8, 14,13).
			target(9, 4,9).
			target(10, 9,1).
			target(11, 9,14).
			target(12, 1,3).
			target(13, 12,9).
			target(14, 2,14).
			target(15, 2,5).
			target(16, 10,7).	
	
