/*


  Définition de l'IA du joueur artificiel de Rasende Roboter


*/


:- module( decision, [
	init/1,
	move/2
] ).


/*init(_).*/
init(_):-nb_setval(openList,[]), nb_setval(closedList,[]),
	nb_setval(lWall,[]), nb_setval(color,0),
	nb_setval(r1,[]), nb_setval(r2,[]), nb_setval(r3,[]).


/*
  move( +L, -ActionId )
*/
	
move([TL,TR,BL,BR,TargetId,XB,YB,XG,YG,XY,YY,XR,YR],Path):-
	init(_),
	target(TL,TR,BL,BR,TargetId,TPos,Co),
	nb_setval(color,Co),
	field(TL,TR,BL,BR,LWall),
	nb_setval(lWall,LWall),
	selectRobot([XB,YB],[XG,YG],[XY,YY],[XR,YR],RPos),
	manhattan(RPos,TPos,D),
	a_star([RPos,0,D,-1],[TPos,_,0,_],Path),!.

move(_,[]).

/*
	target(+TL,+TR,+BL,+BR,+TargetId,-TPos,-TColor).
*/

target(0,0,0,0, 0,[7,5],-1).
target(0,0,0,0, 1,[6,1],0).
target(0,0,0,0, 2,[9,10],0).
target(0,0,0,0, 3,[13,5],0).
target(0,0,0,0, 4,[6,13],0).
target(0,0,0,0, 5,[11,2],1).
target(0,0,0,0, 6,[5,4],1).
target(0,0,0,0, 7,[1,10],1).
target(0,0,0,0, 8,[14,13],1).
target(0,0,0,0, 9,[4,9],2).
target(0,0,0,0,10,[9,1],2).
target(0,0,0,0,11,[9,14],2).
target(0,0,0,0,12,[1,3],2).
target(0,0,0,0,13,[12,9],3).
target(0,0,0,0,14,[2,14],3).
target(0,0,0,0,15,[2,5],3).
target(0,0,0,0,16,[10,7],3).

target(0,0,0,1,0,[7,5],-1).
target(0,0,0,1,1,[6,1],0).
target(0,0,0,1,2,[12,9],0).
target(0,0,0,1,3,[13,5],0).
target(0,0,0,1,4,[6,13],0).
target(0,0,0,1,5,[11,2],1).
target(0,0,0,1,6,[5,4],1).
target(0,0,0,1,7,[1,10],1).
target(0,0,0,1,8,[14,13],1).
target(0,0,0,1,9,[4,9],2).
target(0,0,0,1,10,[9,1],2).
target(0,0,0,1,11,[9,12],2).
target(0,0,0,1,12,[1,3],2).
target(0,0,0,1,13,[11,14],3).
target(0,0,0,1,14,[2,14],3).
target(0,0,0,1,15,[2,5],3).
target(0,0,0,1,16,[10,7],3).


/*
	field(+TL,+TR,+BL,+BR,-LWall).
*/

field(0,0,0,0,[[[4,0],[11,0],[6,1],[10,1],[12,2],[2,3],[5,4],[3,5],[8,5],[13,5],[8,7],[10,7],[11,7],[8,8],[10,8],[4,9],[13,9],[2,10],[9,10],[6,13],[15,13],[3,14],[9,14],[4,15],[11,15]],[[9,1],[6,2],[1,3],[11,3],[0,4],[5,4],[15,4],[2,6],[7,6],[13,6],[0,7],[7,7],[8,7],[10,7],[7,9],[8,9],[13,9],[1,10],[4,10],[15,10],[9,11],[6,13],[9,14],[14,14],[2,15]]]).
field(0,0,0,1,[[[4,0],[11,0],[6,1],[10,1],[12,2],[2,3],[5,4],[3,5],[8,5],[13,5],[8,7],[10,7],[11,7],[8,8],[10,8],[4,9],[13,9],[2,10],[9,12],[6,13],[14,13],[3,14],[12,14],[4,15],[14,15]],[[9,1],[6,2],[15,2],[1,3],[11,3],[0,4],[5,4],[15,4],[2,6],[7,6],[13,6],[0,7],[7,7],[8,7],[10,7],[7,9],[8,9],[12,9],[10,1],[9,12],[6,13],[14,14],[2,15],[11,15]]]).

/*
	selectRobot(+RBPos,+RGPos,+RYPos,+RRPos,-RPos).
*/

selectRobot(RB,RG,RY,RR,RB):- nb_getval(color,0),!,nb_setval(r1,RG),nb_setval(r2,RY),nb_setval(r3,RR).
selectRobot(RB,RG,RY,RR,RG):- nb_getval(color,1),!,nb_setval(r1,RB),nb_setval(r2,RY),nb_setval(r3,RR).
selectRobot(RB,RG,RY,RR,RY):- nb_getval(color,2),!,nb_setval(r1,RB),nb_setval(r2,RG),nb_setval(r3,RR).
selectRobot(RB,RG,RY,RR,RR):- nb_getval(color,3),!,nb_setval(r1,RB),nb_setval(r2,RG),nb_setval(r3,RY).

/*
	manhattan(+RPos,+TPos,-Distance).
*/

manhattan([XR,YR],[XT,YT],D):-D is (abs(XR-XT)+abs(YR-YT)).

/*
	a_star(+EtatInitial,+EtatFinal,-Path).
*/

a_star([TPos,0,0,-1],[TPos,_,0,_],[]).
a_star(EtatInit,EtatFinal,Path):-
	nb_getval(openList,[]),
	!,
	nb_setval(openList,[EtatInit]),
	a_star(EtatFinal,Path).

/*
	a_star(+EtatFinal,-Path).
*/

a_star([TPos,_,0,_],Path):-getBestNodeFromOpenList([TPos,_,0,_]),!,buildPath(Path).
a_star(FinalState,Path):- extractBestNodeFromOpenList(Node),
				addToClosedList(Node),
				getAccessibleStates(Node,AccessibleStatesList),
				insertAllStatesInOpenList(Node,FinalState,AccessibleStatesList),
				a_star(FinalState,Path).

/*
	extractBestNodeFromOpenList(-Node).
*/

extractBestNodeFromOpenList(Node):-nb_getval(openList,[Node|R]),nb_setval(openList,R).
						
/*
	getBestNodeFromOpenList(-Node).
*/

getBestNodeFromOpenList(Node):-nb_getval(openList,[Node|_]).						

/*
	addToClosedList(+Node).
*/

addToClosedList(Node):-nb_getval(closedList,Closed),append([Node],Closed,NewClosed),nb_setval(closedList,NewClosed).

/*
	getAccessibleStates(+EtatActuel,-ListeDesEtatsAccessibles).
*/

getAccessibleStates([RPos,G,_,_],AccessibleStatesList):-
			deplacement(RPos,h,ResH),
			deplacement(RPos,b,ResB),
			deplacement(RPos,l,ResL),
			deplacement(RPos,r,ResR),
			G1 is G+1,
			checkRes([ResH,ResB,ResL,ResR],G1,RPos,AccessibleStatesList).
		
/*
	insertAllStatesInOpenList(+EtatEnCours,+EtatFinal,+ListeDesEtatsAccessibles).
*/

insertAllStatesInOpenList(_,_,[]).
insertAllStatesInOpenList([PosPere,G,_,_],[PosT,_,0,_],[Pos|R]):-
		manhattan(Pos,PosT,D), 
		G1 is G+1, 
		nb_getval(openList,Open), 		
		insertTri([Pos,G1,D,PosPere],Open,NewOpen),
		nb_setval(openList,NewOpen),
		insertAllStatesInOpenList([PosPere,G,_,_],[PosT,_,0,_],R).
		
/*
	deplacement(+PositionInitiale,+Direction,-PositionFinale).
*/

deplacement(RPos, Dir, RPos):-blocked(RPos, Dir),!.
deplacement([X,Y],  h, RPosEnd):-Y1 is Y-1, deplacement([X,Y1], h, RPosEnd),!.
deplacement([X,Y],  b, RPosEnd):-Y1 is Y+1, deplacement([X,Y1], b, RPosEnd),!.
deplacement([X,Y],  l, RPosEnd):-X1 is X-1, deplacement([X1,Y], l, RPosEnd),!.
deplacement([X,Y],  r, RPosEnd):-X1 is X+1, deplacement([X1,Y], r, RPosEnd),!.
				
/*
	blocked(+Position, +Direction).
*/

blocked([ _,  0], h):-!.
blocked([ _, 15], b):-!.
blocked([15,  _], r):-!.
blocked([ 0,  _], l):-!.

blocked([X,Y],h):-Y1 is Y-1, nb_getval(r1,[X,Y1]),!.
blocked([X,Y],h):-Y1 is Y-1, nb_getval(r2,[X,Y1]),!.
blocked([X,Y],h):-Y1 is Y-1, nb_getval(r3,[X,Y1]),!.

blocked([X,Y],b):-Y1 is Y+1, nb_getval(r1,[X,Y1]),!.
blocked([X,Y],b):-Y1 is Y+1, nb_getval(r2,[X,Y1]),!.
blocked([X,Y],b):-Y1 is Y+1, nb_getval(r3,[X,Y1]),!.

blocked([X,Y],l):-X1 is X-1, nb_getval(r1,[X1,Y]),!.
blocked([X,Y],l):-X1 is X-1, nb_getval(r2,[X1,Y]),!.
blocked([X,Y],l):-X1 is X-1, nb_getval(r3,[X1,Y]),!.

blocked([X,Y],r):-X1 is X+1, nb_getval(r1,[X1,Y]),!.
blocked([X,Y],r):-X1 is X+1, nb_getval(r2,[X1,Y]),!.
blocked([X,Y],r):-X1 is X+1, nb_getval(r3,[X1,Y]),!.

blocked(Pos,Dir):-nb_getval(lWall,LWall),blocked(Pos,Dir,LWall).

/*
	blocked(+Position,+Direction,+ListeDesMurs).
*/

blocked(Pos,h,[_,[Pos|_]]):-!.
blocked(Pos,h,[A,[_|R]]):-blocked(Pos,h,[A,R]),!.

blocked([X,Y],b,[_,[[X,Y1]|_]]):-Y1 is Y+1,!.
blocked(Pos,b,[A,[_|R]]):-blocked(Pos,b,[A,R]),!.

blocked(Pos,l,[[Pos|_],_]):-!.
blocked(Pos,l,[[_|R],A]):-blocked(Pos,l,[R,A]),!.

blocked([X,Y],r,[[[X1,Y]|_],_]):- X1 is X+1,!.
blocked(Pos,r,[[_|R],A]):-blocked(Pos,r,[R,A]),!.
		
/*
	checkRes(+ListeDesPossibilités,+Coût du père,+PositionDuPère,-ListeDesEtatsAccessibles).
*/
			
checkRes([],_,_,[]).

checkRes([A|R],G,P,L):-
		nb_getval(openList,Open),
		member([A,GP,H,_],Open),!,
		majOpen(A,GP,G,H,P),!,
		checkRes(R,G,P,L).
		
checkRes([A|R],G,P,L):-
		nb_getval(closedList,Closed),
		member([A,GP,_,_],Closed),!,
		majClosed(A,GP,G,P),!,
		checkRes(R,G,P,L).
		
checkRes([A|R],G,P,L):-
		append([A],L1,L),
		checkRes(R,G,P,L1).

/*
	insertTri(+Element,+Liste,-Resultat).
*/
		
insertTri(A,[],[A]):-!. 
insertTri([[X1,Y1],G1,H1,P1],[[[X2,Y2],G2,H2,P2]|L],[[[X1,Y1],G1,H1,P1],[[X2,Y2],G2,H2,P2]|L]):- H1+G1 =< H2+G2, !. 
insertTri([[X1,Y1],G1,H1,P1],[[[X2,Y2],G2,H2,P2]|L],[[[X2,Y2],G2,H2,P2]|L1]):- G1+H1>G2+H2, insertTri([[X1,Y1],G1,H1,P1],L,L1), !. 
		
/*
	deleteFrom(+PositionASupprimer,+Liste,-ListeResultat).
*/
		
deleteFrom(_,[],[]).
deleteFrom(A,[[A,_,_,_]|R],R):-!.
deleteFrom(A,[B|R],[B|R1]):-deleteFrom(A,R,R1).
		
/*
	majOpen(+PositionAMettreAJour,+CoûtDuPrécédant,+CoûtDuNouveau,+Distance,+PèreDuNouveau).
*/

majOpen(A,GP,G,H,P):-
		G < GP,!,
		nb_getval(openList,Open),
		deleteFrom(A,Open,NewOpen),
		insertTri([A,G,H,P],NewOpen, NNewOpen),
		nb_setval(openList,NNewOpen).

majOpen(_,_,_,_,_).

/*
	majClosed(+PositionAMettreAJour,+CoûtDuPrécédant,+CoûtDuNouveau,+PèreDuNouveau).
*/
		
majClosed(A,GP,G,P):-
		G < GP,!,
		nb_getval(closedList,Closed),
		majClosed(A,G,P,Closed,NewClosed),
		nb_setval(closedList,NewClosed).

majClosed(_,_,_,_).
/*
	majClosed(+PositionAMettreAJour,+Coût,+Père,+ListeClosed,-ListeResultat).
*/

majClosed(_,_,_,[],[]).

majClosed(A,G,P,[[A,_,H,_]|R],L):-
		append([[A,G,H,P]],L1,L),
		majClosed(A,G,P,R,L1),!.

majClosed(A,G,P,[B|R],L):-
		append([B],L1,L),
		majClosed(A,G,P,R,L1).

/*
	buildPath(-Path).
*/

buildPath(Path):-
	getBestNodeFromOpenList([Pos,_,_,P]), 
	buildPath(Pos,P,Mouv),
	nb_getval(color,C),
	listeFinale(Mouv,C,Path).

/*
	buildPath(+PositionFinale,+Père,-ListeMouvement).
*/
	
buildPath(_,-1,[]).	
	
buildPath(Pos,P1,Path):-
	direction(Pos,P1,D),
	append(Temp,[D],Path),
	nb_getval(closedList,Closed),
	member([P1,_,_,P2],Closed),
	buildPath(P1,P2,Temp).
	
/*
	direction(+PositionPère,+PositionFils,Direction).
*/

direction([X1,_],[X2,_],R) :- X1>X2 , R is 1,!.
direction([_,Y1],[_,Y2],R) :- Y1<Y2 , R is 2,!.
direction([X1,_],[X2,_],R) :- X1<X2 , R is 3,!.
direction([_,Y1],[_,Y2],R) :- Y1>Y2 , R is 4,!.
	
/*
	ListeFinale(+ListeMouvements,+Couleur,-Resultat).
*/

listeFinale([],_,[]).
listeFinale([X|R],Y,L):-append([[Y,X],L1],L),listeFinale(R,Y,L1),!.	