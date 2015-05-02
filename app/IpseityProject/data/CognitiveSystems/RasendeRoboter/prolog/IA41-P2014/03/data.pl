:- module( data,[	element/7,	obstacle/8] ).

% element(IdElement,X,Y,TL,TR,BL,BR).
% TL1
element(1,6,1,0,_,_,_).
element(12,1,3,0,_,_,_).
element(6,5,4,0,_,_,_).
element(15,2,5,0,_,_,_).
element(0,7,5,0,_,_,_).
% TL2
element(1,6,11,1,_,_,_).
element(12,1,3,1,_,_,_).
element(6,6,4,1,_,_,_).
element(15,5,6,1,_,_,_).
element(0,3,7,1,_,_,_).
% TR1
element(10,9,1,_,0,_,_).
element(7,11,2,_,0,_,_).
element(4,13,5,_,0,_,_).
element(14,10,7,_,0,_,_).
% TR2
element(10,9,1,_,1,_,_).
element(7,13,5,_,1,_,_).
element(4,11,2,_,1,_,_).
element(14,14,1,_,1,_,_).
% BL1
element(9,4,9,_,_,0,_).
element(7,1,10,_,_,0,_).
element(4,6,13,_,_,0,_).
element(14,2,14,_,_,0,_).
% BL2
element(9,1,13,_,_,1,_).
element(7,2,14,_,_,1,_).
element(4,3,9,_,_,1,_).
element(14,1,10,_,_,1,_).
% BR1
element(13,12,9,_,_,_,0).
element(2,9,10,_,_,_,0).
element(8,14,13,_,_,_,0).
element(11,9,14,_,_,_,0).
% BR2
element(13,11,14,_,_,_,1).
element(2,12,9,_,_,_,1).
element(8,14,13,_,_,_,1).
element(11,9,12,_,_,_,1).

% obstacle(X1,Y1,X2,Y2,TL:0ou1,TR:0ou1,BL:0ou1,BR:0ou1).
% Contour de la carte:
obstacle(_,-1,_,0,_,_,_,_).
obstacle(-1,_,0,_,_,_,_,_).
obstacle(_,15,_,16,_,_,_,_).
obstacle(15,_,16,_,_,_,_,_).

% TL1
obstacle(3,0,4,0,0,_,_,_).
obstacle(5,1,6,1,0,_,_,_).
obstacle(6,1,6,2,0,_,_,_).
obstacle(1,2,1,3,0,_,_,_).
obstacle(1,3,2,3,0,_,_,_).
obstacle(5,3,5,4,0,_,_,_).
obstacle(4,4,5,4,0,_,_,_).
obstacle(2,5,3,5,0,_,_,_).
obstacle(2,5,2,6,0,_,_,_).
obstacle(7,5,8,5,0,_,_,_).
obstacle(7,5,7,6,0,_,_,_).
obstacle(0,6,0,7,0,_,_,_).
obstacle(6,7,7,7,0,_,_,_).
obstacle(7,6,7,7,0,_,_,_).

% TL2
obstacle(4,0,5,0,1,_,_,_).
obstacle(2,1,3,1,1,_,_,_).
obstacle(2,1,2,2,1,_,_,_).
obstacle(0,3,1,3,1,_,_,_).
obstacle(1,3,1,4,1,_,_,_).
obstacle(6,3,6,4,1,_,_,_).
obstacle(0,4,0,5,1,_,_,_).
obstacle(5,4,6,4,1,_,_,_).
obstacle(5,5,5,6,1,_,_,_).
obstacle(5,6,6,6,1,_,_,_).
obstacle(3,7,4,7,1,_,_,_).
obstacle(3,7,3,8,1,_,_,_).
obstacle(6,7,7,7,1,_,_,_).
obstacle(7,6,7,7,1,_,_,_).

% TR1
obstacle(10,0,11,0,_,0,_,_).
obstacle(15,3,15,4,_,0,_,_).
obstacle(9,0,9,1,_,0,_,_).
obstacle(9,1,10,1,_,0,_,_).
obstacle(11,2,12,2,_,0,_,_).
obstacle(11,2,11,3,_,0,_,_).
obstacle(12,5,13,5,_,0,_,_).
obstacle(13,5,13,6,_,0,_,_).
obstacle(9,7,10,7,_,0,_,_).
obstacle(10,6,10,7,_,0,_,_).
obstacle(8,7,9,7,_,0,_,_).
obstacle(8,6,8,7,_,0,_,_).

% TR2
obstacle(9,0,10,0,_,1,_,_).
obstacle(15,3,15,4 ,_,1,_,_).
obstacle(13,1,14,1 ,_,1,_,_).
obstacle(14,0,14,1 ,_,1,_,_).
obstacle(10,2,11,2 ,_,1,_,_).
obstacle(11,2,11,3 ,_,1,_,_).
obstacle(13,6,14,6 ,_,1,_,_).
obstacle(13,6,13,7 ,_,1,_,_).
obstacle(10,6,10,7 ,_,1,_,_).
obstacle(10,7,11,7 ,_,1,_,_).
obstacle(8,7,9,7,_,1,_,_).
obstacle(8,6,8,7,_,1,_,_).

% BL1
obstacle(6,8,7,8,_,_,0,_).
obstacle(7,8,7,9,_,_,0,_).
obstacle(3,9,4,9,_,_,0,_).
obstacle(4,9,4,10,_,_,0,_).
obstacle(1,9,1,10,_,_,0,_).
obstacle(1,10,2,10,_,_,0,_).
obstacle(5,13,6,13,_,_,0,_).
obstacle(6,12,6,13,_,_,0,_).
obstacle(2,14,3,14,_,_,0,_).
obstacle(2,14,2,15,_,_,0,_).
obstacle(0,3,0,4,_,_,0,_).
obstacle(3,15,4,15,_,_,0,_).

% BL2
obstacle(6,8,7,8,_,_,1,_).
obstacle(7,8,7,9,_,_,1,_).
obstacle(3,9,4,9,_,_,1,_).
obstacle(3,9,3,10,_,_,1,_).
obstacle(5,10,5,11,_,_,1,_).
obstacle(4,11,5,11,_,_,1,_).
obstacle(0,13,1,13,_,_,1,_).
obstacle(1,13,1,14,_,_,1,_).
obstacle(6,13,6,14,_,_,1,_).
obstacle(6,14,7,14,_,_,1,_).
obstacle(0,2,0,3,_,_,1,_).
obstacle(4,15,5,15,_,_,1,_).

% BR1
obstacle(8,8,9,8,_,_,_,0).
obstacle(8,8,8,9,_,_,_,0).
obstacle(15,9,15,10,_,_,_,0).
obstacle(10,15,11,15,_,_,_,0).
obstacle(12,8,12,9,_,_,_,0).
obstacle(12,9,13,9,_,_,_,0).
obstacle(8,10,9,10,_,_,_,0).
obstacle(9,10,9,11,_,_,_,0).
obstacle(14,13,15,13,_,_,_,0).
obstacle(14,13,14,14,_,_,_,0).
obstacle(8,14,9,14,_,_,_,0).
obstacle(9,13,9,14,_,_,_,0).

% BR2
obstacle(8,8,9,8,_,_,_,1).
obstacle(8,8,8,9,_,_,_,1).
obstacle(15,1,15,2,_,_,_,1).
obstacle(13,15,14,15,_,_,_,1).
obstacle(12,8,12,9,_,_,_,1).
obstacle(12,9,13,9,_,_,_,1).
obstacle(9,11,9,12,_,_,_,1).
obstacle(8,12,9,12,_,_,_,1).
obstacle(13,13,14,13,_,_,_,1).
obstacle(14,13,14,14,_,_,_,1).
obstacle(11,14,12,14,_,_,_,1).
obstacle(11,14,11,15,_,_,_,1).
