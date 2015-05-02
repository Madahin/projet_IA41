/*
  Définition de l'IA du joueur artificiel de Rasende Roboter
*/
:- module( decision, [
	init/1,
	move/2
] ).

:- use_module(data).

%f_score <=> distance estimée de node départ à l'arrivée en passant par node courant
:- dynamic(f_score/2).
%g_score <=> distance réelle calculé jusqu'à node étudiée
:- dynamic(g_score/2).
%previous <=> stocke les nodes retenues puis sert à générer le parcours final
:- dynamic(previous/2).
%open_list <=> liste des noeuds courants étudiés
:- dynamic(open_list/1).
%close_list <=> liste des noeuds déjà étudiés
:- dynamic(close_list/1).
:- dynamic(saved_node/7).

init( _ ).


/* 
  * wallAll( Xposition, Yposition)
  * cette fonction sert à emmurer la case de coordonnées (X,Y)
  * et met à jour les toutes nodes en conséquences
  * (on ne peut plus traverser la case)
  * elle est utilisée pour mettre à jour les nodes en fonction
  * de la position des robots sur le plateau
*/  
wallAll( X, Y ) :- wallUp( X, Y ).
wallAll( X, Y ) :- wallRight( X, Y ).
wallAll( X, Y ) :- wallDown( X, Y ).
wallAll( X, Y ) :- wallLeft( X, Y).
wallAll( X, Y ) :- node(ID, X, Y, UID, RID, DID, LID), 
						 save(ID, X, Y, UID, RID, DID, LID), 
						 retract(node(ID,_,_,_,_,_,_)), 
						 asserta(node(ID,X,Y, 0,0,0,0))
						 .
/*	
 *		wallXXXX( Xposition, Yposition)
 *		on cherche l'id du node à la position X/Y
 *		on cherche les composantes des nodes sur la même ligne/colonne
 *		bas et droite : oid > id  => un seul côté du mur
 *		haut et gauche: oid < id  => un seul côté du mur
 *		destination traverse robot
 *		on est pas contre un mur
 *		case d'avant ou après le robot pour s'arrêter
 *		on teste si on est contre le robot ou pas 
 *		on enlève l'ancien node
 *		on ajoute le nouveau node
*/
wallUp( X, Y )    :- node(ID, X, Y, _, _, _, _), 
							node(OID, X, Y2, UID, RID, DID, LID), 
							OID<ID, 
							DID >= ID, 
							NDID is ID-16 , 
							NDID\=OID  , 
						   save(OID, X, Y2, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X,Y2, UID, RID, NDID, LID))
							.

wallUp( X, Y )    :- node(ID, X, Y, _, _, _, _), 
							node(OID, X, Y2, UID, RID, DID, LID), 
							OID<ID, 
							DID >= ID, 
							NDID is ID-16 , 
							NDID=:=OID , 
						   save(OID, X, Y2, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X,Y2, UID, RID, 0, LID))
							.

wallRight( X, Y ) :- node(ID, X, Y, _, _, _, _), 
							node(OID, X2, Y, UID, RID, DID, LID), 
							OID>ID, 
							LID =< ID, 
							LID\=0, 
							NLID is ID+1  , 
							NLID\=OID  , 
						   save(OID, X2, Y, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X2,Y, UID, RID, DID, NLID))
							.

wallRight( X, Y ) :- node(ID, X, Y, _, _, _, _), 
							node(OID, X2, Y, UID, RID, DID, LID), 
							OID>ID, 
							LID =< ID, 
							LID\=0, 
							NLID is ID+1  , 
							NLID=:=OID , 
						   save(OID, X2, Y, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X2,Y, UID, RID, DID, 0))
							.

wallDown( X, Y )  :- node(ID, X, Y, _, _, _, _), 
							node(OID, X, Y2, UID, RID, DID, LID), 
							OID>ID, 
							UID =< ID, 
							UID\=0, 
							NUID is ID+16, 
							NUID\=OID ,
						   save(OID, X, Y2, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X,Y2, NUID, RID, DID, LID))
							.

wallDown( X, Y )  :- node(ID, X, Y, _, _, _, _), 
							node(OID, X, Y2, UID, RID, DID, LID), 
							OID>ID, 
							UID =< ID, 
							UID\=0, 
							NUID is ID+16 , 
							NUID=:=OID , 
						 	save(OID, X, Y2, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X,Y2, 0, RID, DID, LID))
							.

wallLeft( X, Y )  :- node(ID, X, Y, _, _, _, _), 
							node(OID, X2, Y, UID, RID, DID, LID), 
							OID<ID, 
							RID >= ID,
							NRID is ID-1  , 
							NRID\=OID  , 
						   save(OID, X2, Y, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X2,Y, UID, NRID, DID, LID))
							.
wallLeft( X, Y )  :- node(ID, X, Y, _, _, _, _), 
							node(OID, X2, Y, UID, RID, DID, LID), 
							OID<ID, 
							RID >= ID, 
							NRID is ID-1  , 
							NRID=:=OID , 
						   save(OID, X2, Y, UID, RID, DID, LID), 
							retract(node(OID,_,_,_,_,_,_)), 
							asserta(node(OID,X2,Y, UID, 0, DID, LID))
							.
/* 
 * dirFromNodeToNode( SourceID, TargetID, N)
 * on cherche la direction dans laquelle se déplacer pour aller de la node d'id SourceID en direction de la node d'id TargetID
 * récupérer le paramètre N nous donne l'information sur la direction telle qu'elle est conseillée dans l'énoncé :
 * N=1 <=> droite
 * N=2 <=> haut
 * N=3 <=> gauche
 * N=4 <=> bas
*/
dirFromNodeToNode(SID, TID, N) :- node(SID, _, _, TID, _, _, _), !, N is 2 .
dirFromNodeToNode(SID, TID, N) :- node(SID, _, _, _, TID, _, _), !, N is 1 .
dirFromNodeToNode(SID, TID, N) :- node(SID, _, _, _, _, TID, _), !, N is 4 .
dirFromNodeToNode(SID, TID, N) :- node(SID, _, _, _, _, _, TID), !, N is 3 .

% RobotColor : all=0, blue=1, green=2, yellow=3, red=4
wallBot(0, BPX, BPY, GPX, GPY, YPX, YPY, RPX, RPY, BPX, BPY) :- 
						wallAll(GPX, GPY), 
						wallAll(YPX, YPY), 
						wallAll(RPX, RPY)  % Dans un premier temps on choisis arbitrairement le bleu
						. 
wallBot(1, BPX, BPY, GPX, GPY, YPX, YPY, RPX, RPY, BPX, BPY) :- 
						wallAll(GPX, GPY), 
						wallAll(YPX, YPY), 
						wallAll(RPX, RPY)
						.
wallBot(2, BPX, BPY, GPX, GPY, YPX, YPY, RPX, RPY, GPX, GPY) :- 
						wallAll(BPX, BPY), 
						wallAll(YPX, YPY), 
						wallAll(RPX, RPY)
						.
wallBot(3, BPX, BPY, GPX, GPY, YPX, YPY, RPX, RPY, YPX, YPY) :- 
						wallAll(GPX, GPY), 
						wallAll(BPX, BPY), 
						wallAll(RPX, RPY)
						.
wallBot(4, BPX, BPY, GPX, GPY, YPX, YPY, RPX, RPY, RPX, RPY) :- 
						wallAll(GPX, GPY), 
						wallAll(YPX, YPY), 
						wallAll(BPX, BPY)
						.

move([1, 1, 1, 1, TID, BPX, BPY, GPX, GPY, YPX, YPY, RPX, RPY], DirList) :- 
					cleanAll(_), 
					target(TID, TX, TY, C), 
					wallBot(C, BPX, BPY, GPX, GPY, YPX, YPY, RPX, RPY, OX, OY), 
					resolution(OX, OY, TX, TY, DirList)
					.

/* 
 * resolution(Xsource, Ysource, Xtarget, Ytarget, SolList)
 * la fonction resolution crée un parcours pour aller de la case de coordonnées (Xsource,Ysource) vers la case de coordonnées (Xtarget,Ytarget)
 * elle fait appel à la fonction a_star pour resoudre le problème du déplacement et renvoie la solution obtenue dans la liste SolList.
*/
resolution(X, Y, X, Y, []) :- !.
resolution(OX, OY, TX, TY, DirList) :- 
					write('resolution'),nl,
					node(OID, OX, OY, _, _, _, _), 
					node(TID, TX, TY, _, _, _, _), 
					a_star(OID, TID, DirList), 
					cleanAll(_), !
					.
resolution(_, _, _, _, _) :- cleanAll(_).

%	 Liste var : openList :
% 					closeList :
% 		Etat initial : openList est constitue de la node de depart
% 			Iteration : tant que openList != []
% 				Node = Node avec le score le + bas dans openList
%						Si Node = Target
%							buildPath (vir comment)
%							exit
%						Fin Si
%						enlever Node de openList
%						ajouter Node à closeList
%						Pour chaque voisin de Node
%							Si voisin est dans closeList
%								ignorer voisin
%							Sinon
%								on tente d'aller vers voisin
%							   scoreVoisinTest = scoreNode + distance(node, voisin)
%
%								Si voisin n'est pas dans openListe ou scoreVoisinTest < scoreVoisin Alors
%									precedent(voisin) = Node
%									scoreVoisin = scoreVoisinTest
%									scoreVoisinCible = scoreVoisin + estimationVoisinCible(heuristique)
%									Si voisin n'est pas dans openListe
%										ajouter voisin à openListe
%
%								Fin Si
%							Fin Si
%						Fin Pour
%             fin tant que
%				echec.
%
%

/* 
 * add_open_list(ID)
 * ajoute l'id ID à la liste open_list
 * rappel : open_list <=> liste des noeuds courants étudiés
*/
add_open_list(ID) :- asserta(open_list(ID)).

/* 
 * remove_open_list(ID)
 * retire l'id ID de la liste open_list
*/
remove_open_list(ID) :- retract(open_list(ID)).
remove_open_list(_).

/* 
 * add_close_list(ID)
 * ajoute l'id ID à la liste close_list
 * rappel : close_list <=> liste des noeuds déjà étudiés
*/
add_close_list(ID) :- asserta(close_list(ID)).

/* 
 * remove_close_list(ID)
 * retire l'id ID de la liste close_list
*/
remove_close_list(ID) :- retract(close_list(ID)).

/* 
 * a_star(OriginID, TargetID, DirList)
 * resoud le problème de déplacement entre la case d'id OriginID et la case d'id TargetID en suivant l'algorithme du A*
 * la liste DirList retrournée représente la liste des déplacements à parcourir (haut/bas/gauche/droite)
*/
a_star(OID, TID, DirList) :- 
					write('a_star'),nl,  
					a_star_init(OID, TID, DirList)
					.
/* 
 * a_star_init(OID, TID, DirList)
 * initialisation de l'algorithme avec appel sur la première itération
*/
a_star_init(OID, TID, DirList) :-  
											write('a_star_init'), nl,
											asserta(g_score(OID, 0)),
											heuristic(OID, TID, N),
											asserta(f_score(OID, N)),
											asserta(open_list(OID)),
											a_star_iteration(TID, DirList),
											express(DirList)
											.
/* 
 * a_star_iteration(TID, DirList)
 * affichage des elements contenus dans les listes open_list et close_list
*/
a_star_iteration(TID, DirList) :-  nl, write('a_star_iteration'), nl, bagof(T, open_list(T), A), !,
											write('open list :    '),write(A), nl,
											findall(Z, close_list(Z), L),
											write('closed list :  '), write(L), nl,
											a_star_iteration2(TID, DirList)
											.
/* 
 * a_star_iteration2(TID, DirList)
 * iteration de l'algorithme du A*
 * mise à jour des open_list/close_list en fonction de l'élément courant
 * on étudie ensuite les 4 déplacements possibles à partir du node actuel
 * enfin on refait appel à a_star_iteration pour continuer d'étudier les nodes suivants
*/
a_star_iteration2(TID, DirList) :-
								write('a_star_iteration2'), nl,
								find_f_score_lowest_in_open_list(ID),
								write('ID : '), write(ID), nl,
								write('TID : '), write(TID), nl,
								ID\=TID, !,
								remove_open_list(ID),
								add_close_list(ID),
								node(ID, _, _, U, R, D, L),
								write('On etudie le noeud : '), write(U), nl,
								a_star_compute_neighbour(TID, ID, U),
								write('On etudie le noeud : '), write(R), nl,
								a_star_compute_neighbour(TID, ID, R),
								write('On etudie le noeud : '), write(D), nl,
								a_star_compute_neighbour(TID, ID, D),
								write('On etudie le noeud : '), write(L), nl,
								a_star_compute_neighbour(TID, ID, L),
								a_star_iteration(TID, DirList), !
								.
/* 
 * a_star_iteration2(TID, DirList)
 * ici, condition d'arrêt de l'algorithme
 * c'est-à-dire si la node à étudier se trouve en fait être la node target
*/
a_star_iteration2(TID, DirList) :- 
									write('finishing'), nl, 
									a_star_finish(TID, DirList)
									.
/* 
 * a_star_finish(TID, DirList)
 * fin de l'algorithme, donc création du parcours final à partir de la DirList créée
 * puis on efface toutes les variables crées pour pouvoir faire à nouveau appel à l'algorithme ultérieurement
*/
a_star_finish(TID, DirList) :- 
										write('a_star_finish'), nl,
										build_path(TID, DirList)
										.
/* 
 * a_star_compute_neighbour(TID, X, 0)
 * Si l'id de la destination = 0, on est alors contre un mur donc le déplacement est impossible
*/
a_star_compute_neighbour(_, _, 0) :- !.

/* 
 * a_star_compute_neighbour(TID, X, ID)
 * Si la node voisine a déjà été étudiée (<=> node appartient à la close_list)
 * alors on a pas besoin de l'étudier à nouveau
*/
a_star_compute_neighbour(_, _, ID) :- 
									write('a_star_compute_neighbour avec close list'),nl,
									close_list(ID), !
									.
/* 
 * a_star_compute_neighbour(TID, X, ID)
 * Si la node voisine n'a pas encore été étudiée, on étudie le cas où on passerait cette node voisine
*/
a_star_compute_neighbour(TID, Parent, ID) :- 
								write('a_star_compute_neighbour'),nl,
								g_score(Parent, PG), 
								GTentative is 1 + PG, 
								condition(ID, GTentative), !,
								a_star_compute_neighbour_2(TID, Parent, ID, GTentative)
								.

a_star_compute_neighbour(_, _, _).

/* 
 * a_star_compute_neighbour_2(TID, Parent, ID, GTentative)
 * si le g_score de la node ID a déjà été calculé, alors on le met à jour
 * puis on fait appel à a_star_compute_neighbour_3
*/
a_star_compute_neighbour_2(TID, Parent, ID, GTentative) :- 
												write('a_star_compute_neighbour2'),nl,
												g_score(ID, X), !,
												retract(g_score(ID, X)), 
												asserta(g_score(ID, GTentative)),
												a_star_compute_neighbour_3(TID, Parent, ID, GTentative)
												.

/* 
 * a_star_compute_neighbour_2(TID, Parent, ID, GTentative)
 * si le g_score de la node ID n'a pas encore été calculé, alors on l'écrit dans g_score
 * puis on fait appel à a_star_compute_neighbour_3
*/
a_star_compute_neighbour_2(TID, Parent, ID, GTentative) :- 
												write('a_star_compute_neighbour2'),nl,
												asserta(g_score(ID, GTentative)),
												a_star_compute_neighbour_3(TID, Parent, ID, GTentative).

/* 
 * a_star_compute_neighbour_3(TID, Parent, ID, GTentative)
 * si la node ID avait déjà un parent connu, alors on lui met à jour avec le nouveau parent
 * puis on fait appel à a_star_compute_neighbour_4
*/
a_star_compute_neighbour_3(TID, Parent, ID, GTentative) :- 
												write('a_star_compute_neighbour3'),nl,
												previous(ID, OldParent), !,
												retract(previous(ID, OldParent)), 
												asserta(previous(ID, Parent)),
												a_star_compute_neighbour_4(TID, Parent, ID, GTentative)
												.
/* 
 * a_star_compute_neighbour_3(TID, Parent, ID, GTentative)
 * si la node ID n'avait pas encore de parent connu, alors on lui affecte un parent dans previous
 * puis on fait appel à a_star_compute_neighbour_4
*/							
a_star_compute_neighbour_3(TID, Parent, ID, GTentative) :- 
												write('a_star_compute_neighbour3'),nl,
												asserta(previous(ID, Parent)),
												a_star_compute_neighbour_4(TID, Parent, ID, GTentative)
												.
/* 
 * update_f_score(ID, NewScore)
 * si la node ID avait déjà un f_score connu, alors on lui met à jour avec le NewScore obtenu
*/		
update_f_score(ID, NewScore) :- 
								f_score(ID, X), !,
								retract(f_score(ID, X)), 
								asserta(f_score(ID, NewScore))
								.					
/* 
 * update_f_score(ID, NewScore)
 * si la node ID n'avait pas encore de f_score connu, alors on lui affecte le NewScore directement
*/	
update_f_score(ID, NewScore) :- asserta(f_score(ID, NewScore)).

/* 
 * a_star_compute_neighbour_4(TID, Parent, ID, GTentative)
 * on fait appel à la fontion heuristic pour évaluer la distance restante entre la node ID et la node Target
 * on met à jour le f_score en fonction du résultat obtenu
 * puis on fait appel à a_star_compute_neighbour_5
*/	
a_star_compute_neighbour_4(TID, Parent, ID, GTentative) :- 
							write('a_star_compute_neighbour4'), nl, 
							write('On etudie le noeud : '), write(ID),nl,
							heuristic(ID, TID, Eval), 
							FScore is GTentative + Eval, 
							update_f_score(ID, FScore), 
							a_star_compute_neighbour_5(TID, Parent, ID, GTentative)
							.
/* 
 * a_star_compute_neighbour_5(TID, Parent, ID, GTentative)
 * si la node ID ne fait pas encore partie de la liste open_list, alors on l'ajoute à la liste
*/
a_star_compute_neighbour_5(_, _, ID, _) :- 
							write('a_star_compute_neighbour5'),nl,
							not(open_list(ID)), !, 
							asserta(open_list(ID))
							.
a_star_compute_neighbour_5(_, _, _, _).

condition(NID, _) :- 
							write('condition1'),nl,
							not(open_list(NID))       % On a pas encore vu le voisin
							.

condition(NID, GScore) :- 
							write('condition2'),nl,
							g_score(NID, Score), 
							GScore < Score 		% On trouve un meilleur chemin pour y aller
							.
/* 
 * find_f_score_lowest(ID)
 * récupère l'ID de la node ayant le plus petit f_score dans la liste des f_score
*/
find_f_score_lowest(ID) :- 
					findall(X, f_score(_, X), 
					[F_score_list_head|Tail]), 
					lowest_in_list(N,Tail,F_score_list_head), 
					f_score(ID, N)
					.

f_score_in_open_list(ID, Score) :- f_score(ID, Score), open_list(ID).

find_f_score_lowest_in_open_list(ID) :- findall(X, f_score_in_open_list(_, X), [H|T]), lowest_in_list(N, T, H), f_score_in_open_list(ID, N).

/* 
 * lowest_in_list(CurrentMin, [], CurrentMin)
 * condition d'arret de la recherche du minimum si la liste a étudier a été entierement parcourue
*/
lowest_in_list(CurrentMin, [], CurrentMin).

/* 
 * lowest_in_list(N, [H|T], CurrentMin)
 * Si la valeur H est plus petite que le miminum courant, alors on a trouvé un nouveau minimum
 * puis on continue d'étudier le reste de la liste
*/
lowest_in_list(N, [H|T], CurrentMin) :- 
										CurrentMin > H, !, 
										lowest_in_list(N, T, H)
										.
/* 
 * lowest_in_list(N, [_|T], CurrentMin)
 * Sinon on continue d'étudier le reste de la liste sans mettre à jour le minimum courant
*/
lowest_in_list(N, [_|T], CurrentMin) :- lowest_in_list(N, T, CurrentMin).

getColorFromTarget(TID, C) :- target(TID , _, _, C1), C1 > 0, !, C is C1.
getColorFromTarget(_, 1).

/*
 * buildPath( TargetID, [C, N|T])
 * génère la liste des mouvements (haut/bas/gauche/droite) à effectuer pour atteindre la case d'id TargetID
*/
build_path(TID, L) :- node(TID, X, Y, _, _, _, _), target(_, X, Y, C), C1 is C-1, build_path_rec(C1, TID, L1), invert_list(L1, L2), invert_element_2by2(L2, L).
build_path_rec(Color, Node, [C, D | T]) :- previous(Node, Prev), !, C is Color, dirFromNodeToNode(Prev, Node, D), build_path_rec(Color, Prev, T).
build_path_rec(_, _, []).

/*
 * heuristic(OriginID, TargetID, N)
 * heuristique utilisée pour évaluer la distance restante entre les cases d'id OriginID et TargetID
 * N retourne l'evalution obtenue
*/
heuristic(OID, TID, N) :- node(OID, OX, OY, _, _, _, _), node(TID, TX, TY, _, _, _, _), N is (OX-TX)*(OX-TX) + (OY-TY) * (OY-TY).

save(ID, X, Y, UID, RID, DID, LID) :- retract(saved_node(ID,_,_,_,_,_,_)), !, asserta(save_node(ID, X, Y, UID, RID, DID, LID)).
save(ID, X, Y, UID, RID, DID, LID) :- asserta(save_node(ID, X, Y, UID, RID, DID, LID)).

reload(_) :- saved_node(ID, X, Y, UID, RID, DID, LID), !, retract(node(ID,_,_,_,_,_,_)), asserta(node(ID, X, Y, UID, RID, DID, LID)), reload(_).
reload(_).

/*
 * cleanAll(_)
 * cette fonction permet de nettoyer les listes créées lors de la résolution à l'aide de l'algorithme du A*
*/
cleanAll(_) :-
					write('Clean de open_list, close_list, f_score, g_score et previous'), nl,
					retractall(f_score(_, _)),
					retractall(g_score(_, _)),
					retractall(open_list(_)),
					retractall(close_list(_)),
					retractall(previous(_, _)),
					reload(_), !
					.
cleanAll(_).



invert_element_2by2([], []).
invert_element_2by2([H1,H2|T1], [H2,H1|T2]) :- invert_element_2by2(T1, T2).

invert_list(L1, L2) :- invert_list(L1, [], L2).
invert_list([], Acc, Acc).
invert_list([H|T], Acc, Result) :-
	invert_list(T, [H|Acc], Result).


express([]).
express([0,1|T]) :- write('robot bleu      a droite') ,nl, express(T).
express([0,2|T]) :- write('robot bleu      en haut'), nl, express(T).
express([0,3|T]) :- write('robot bleu      a gauche'), nl, express(T).
express([0,4|T]) :- write('robot bleu      en bas'), nl, express(T).
express([1,1|T]) :- write('robot vert      a droite') ,nl, express(T).
express([1,2|T]) :- write('robot vert      en haut'), nl, express(T).
express([1,3|T]) :- write('robot vert      a gauche'), nl, express(T).
express([1,4|T]) :- write('robot vert      en bas'), nl, express(T).
express([2,1|T]) :- write('robot jaune     a droite') ,nl, express(T).
express([2,2|T]) :- write('robot jaune     en haut'), nl, express(T).
express([2,3|T]) :- write('robot jaune     a gauche'), nl, express(T).
express([2,4|T]) :- write('robot jaune     en bas'), nl, express(T).
express([3,1|T]) :- write('robot rouge     a droite') ,nl, express(T).
express([3,2|T]) :- write('robot rouge     en haut'), nl, express(T).
express([3,3|T]) :- write('robot rouge     a gauche'), nl, express(T).
express([3,4|T]) :- write('robot rouge     en bas'), nl, express(T).
