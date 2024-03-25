:- use_module(library(lists)).
:- use_module(library(clpfd)).



% повертає матрицю, яка буде після ходу з прорахуванням двох ходів наперед
%
% do_minimax_move(++Matrix, ++Item,--ResMatrix)
do_minimax_move(Matrix, Item, ResMatrix):-
    get_move_minimax(Matrix, Item, [X,Y]),
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, ResMatrix).


% Знаходжння ходу, який буде найкращим з прорахуванням двох ходів наперед
%
% get_move_minimax(++Matrix, ++Item, --[X,Y])
get_move_minimax(Matrix, Item, [X,Y]):-
     get_all_possible_move_indexes_for_item_list([H|Rest], Matrix,Item),
    get_move_minimax(Matrix, Item, H, [H|Rest], 0,[X,Y]).

% знаходження такого ходу для гравця з перебором усіх можливих ходів і обранням найкращого
get_move_minimax(_, _, [X,Y], [], _,[X,Y]).

get_move_minimax(Matrix, Item, _, [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, Matrix1),
    OtherItem is Item*(-1),
	not(get_all_possible_move_indexes_for_item(_, Matrix1, OtherItem)),
    get_general_score_for_matrix( Matrix1, Item, ScoreSum),
    ScoreSum>BestScore,
	get_move_minimax(Matrix, Item, [X,Y], Rest, ScoreSum,Res),
    !.

get_move_minimax(Matrix, Item, [BestX,BestY], [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, Matrix1),
    OtherItem is Item*(-1),
	not(get_all_possible_move_indexes_for_item(_, Matrix1, OtherItem)),
    get_general_score_for_matrix( Matrix1, Item, ScoreSum),
    ScoreSum=<BestScore,
     get_move_minimax(Matrix, Item, [BestX,BestY], Rest, BestScore,Res),
	!.

get_move_minimax(Matrix, Item, _, [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, Matrix1),
    OtherItem is Item*(-1),
    do_optimal_move(Matrix1, OtherItem, MatrixOther1),
    not(get_all_possible_move_indexes_for_item(_, MatrixOther1, Item)),
    get_general_score_for_matrix( Matrix1, Item, ScoreSum),
    ScoreSum>BestScore,
    get_move_minimax(Matrix, Item, [X,Y], Rest, ScoreSum,Res),
	!.
get_move_minimax(Matrix, Item, [BestX,BestY], [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, Matrix1),
    OtherItem is Item*(-1),
    do_optimal_move(Matrix1, OtherItem, MatrixOther1),
    not(get_all_possible_move_indexes_for_item(_, MatrixOther1, Item)),
    get_general_score_for_matrix( Matrix1, Item, ScoreSum),
    ScoreSum=<BestScore,
     get_move_minimax(Matrix, Item, [BestX,BestY], Rest, BestScore,Res),
	!.


get_move_minimax(Matrix, Item, _, [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, Matrix1),
    OtherItem is Item*(-1),
    do_optimal_move(Matrix1, OtherItem, MatrixOther1),
    do_optimal_move(MatrixOther1, Item, MatrixFinal),
    get_general_score_for_matrix( MatrixFinal, Item, ScoreSum),
    ScoreSum>BestScore,
    get_move_minimax(Matrix, Item, [X,Y], Rest, ScoreSum,Res),
	!.

get_move_minimax(Matrix, Item, [BestX,BestY], [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, Matrix1),
    OtherItem is Item*(-1),
    do_optimal_move(Matrix1, OtherItem, MatrixOther1),
    do_optimal_move(MatrixOther1, Item, MatrixFinal),
    get_general_score_for_matrix( MatrixFinal, Item, ScoreSum),
    ScoreSum=<BestScore,
    get_move_minimax(Matrix, Item, [BestX,BestY], Rest, BestScore,Res),
	!.


% повертає матрицю, яка буде після оптимального ходу
%
% do_optimal_move(++Matrix, ++Item,--ResMatrix)
do_optimal_move(Matrix, Item,ResMatrix):-
    get_optimal_move(Matrix, Item, [X,Y]),
    get_all_moves_indexes([X,Y], Matrix,Item,List),
	change_matrix(Matrix,[[X,Y]|List],Item, ResMatrix).

% знаходження оптимального ходу для гравця
%
% get_optimal_move(++Matrix, ++Item, --[X,Y])

get_optimal_move(Matrix, Item, [X,Y]):-
    get_all_possible_move_indexes_for_item_list([H|Rest], Matrix,Item),
    get_optimal_move(Matrix, Item, H, [H|Rest], 0,[X,Y]),!
    .

% знаходження оптимального ходу для гравця з перебором усіх можливих ходів і обранням найкращого
get_optimal_move(_, _, [X,Y], [], _,[X,Y]).

get_optimal_move(Matrix, Item, _, [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
    change_matrix(Matrix,[[X,Y]|List],Item, ResMatrix),
    get_general_score_for_matrix( ResMatrix, Item, ScoreSum),
    ScoreSum>BestScore,
    get_optimal_move(Matrix, Item, [X,Y], Rest, ScoreSum,Res),
	!.
get_optimal_move(Matrix, Item, [BestX,BestY], [[X,Y]|Rest], BestScore,Res):-
    get_all_moves_indexes([X,Y], Matrix,Item,List),
    change_matrix(Matrix,[[X,Y]|List],Item, ResMatrix),
    get_general_score_for_matrix( ResMatrix, Item, ScoreSum),
    ScoreSum =< BestScore,
    get_optimal_move(Matrix, Item, [BestX,BestY], Rest, BestScore,Res),
	!.

% отримання загальної оцінки матриці
%
% get_general_score_for_matrix( ++Matrix, ++Item, -ScoreSum)
get_general_score_for_matrix( [Row1|Rest], Item, ScoreSum):-
    findall(Score, get_score_for_matrix([Row1|Rest], Item, Score),ScoreList),
    sumlist(ScoreList, ScoreSum).

% обрахунок балів для усіх клітинок матриці, які мають задане значення
%
% get_score_for_matrix( ++Matrix, ++Item, -ScoreSum)
get_score_for_matrix( [Row1|Rest], Item, Score):-
    Matrix = [Row1|Rest],
    length(Matrix,Len_X),
    length(Row1,Len_Y),
    num_to_max(X,Len_X),
    num_to_max(Y,Len_Y),
    get_element_from_matrix([X,Y], Matrix, Item),
    get_score([X,Y], Matrix, Score)
    .

% обрахунок балів для задної клітинки
%
% get_score(++[X,Y], ++Matrix, --Score)
get_score([X,Y], Matrix, Score):-
    closed_from_left([X,Y], Matrix, LeftScore),
    closed_from_right([X,Y], Matrix, RightScore),
    closed_from_top([X,Y], Matrix, TopScore),
    closed_from_bottom([X,Y], Matrix, BottomScore),
    Score is LeftScore+RightScore+TopScore+BottomScore.

closed_from_left([_,0], _,10):-!.
closed_from_left([X,Y], Matrix,10):-
	Y>0,
    Prev is Y-1,
    get_element_from_matrix([X,Prev], Matrix, 2),!.

closed_from_left(_, _,1).

closed_from_right([_,Y], [Row1|_],10):-
    length(Row1,Len_Y),
    Y is Len_Y-1,
    !.
closed_from_right([X,Y], [Row1|Rest],10):-
	length(Row1,Len_Y),
    Y < (Len_Y-1),
    Next is Y+1,
    get_element_from_matrix([X,Next], [Row1|Rest], 2),!.

closed_from_right(_, _,1).

closed_from_top([0,_], _,10):-!.
closed_from_top([X,Y], Matrix,10):-
	X>0,
    Prev is X-1,
    get_element_from_matrix([Prev,Y], Matrix, 2),!.

closed_from_top(_, _,1).

closed_from_bottom([X,_], Matrix,10):-
    length(Matrix,Len_X),
    X is Len_X-1,
    !.
closed_from_bottom([X,Y], Matrix,10):-
	length(Matrix,Len_X),
    X < (Len_X-1),
    Next is X+1,
    get_element_from_matrix([Next,Y], Matrix, 2),!.

closed_from_bottom(_, _,1).


matrix_to_json(Matrix, Json) :-
    with_output_to(string(Json), write_term(Matrix, [json(true)])),
    format('~s', [Json]).

% знаходить список координат усіх клітинок, в які можна зробити хід для гравця (поле Item)
%
% get_all_possible_move_indexes_for_item_list(-List, ++Matrix, ++Item)

get_all_possible_move_indexes_for_item_list(List, [Row1|Rest],Item):-
    findall(X,get_all_possible_move_indexes_for_item(X, [Row1|Rest],Item),List),!.

% знаходить усі координати таких клітинок, в які можна зробити хід для гравця
%
% get_all_possible_move_indexes_for_item(-[X,Y], ++Matrix, ++Item)

get_all_possible_move_indexes_for_item([X,Y], [Row1|Rest],Item):-
    Matrix = [Row1|Rest],
    length(Matrix,Len_X),
    length(Row1,Len_Y),
    num_to_max(X,Len_X),
    num_to_max(Y,Len_Y),
    get_element_from_matrix([X,Y], Matrix, 0), % предикат, який повертає значення елемента матриці за координатами
    get_all_moves_indexes([X,Y], [Row1|Rest], Item, [_|_]). % предикат дорівнює true, якщо після ходу на данну клітинку
															% хоч одна фішка зміниться на фішку поточного гравця


% знаходить індекси всіх клітинок, фішки на яких зміняться на фішки поточного гравця при ході на клітинку з координатами X,Y
%
% get_all_moves_indexes(+[X,Y],  ++Matrix, ++Item, -All_Moves)

get_all_moves_indexes([X,Y], [Row1|Rest], Item, All_Moves):-
    Matrix = [Row1|Rest],
    length(Matrix,Len_X),
    length(Row1,Len_Y),
    num_to_max(X,Len_X),
    num_to_max(Y,Len_Y),
    below([X,Y], Matrix, Below),
    below_left([X,Y], Matrix, Below_Left),
    below_right([X,Y], Matrix, Below_Right),
	above([X,Y], Matrix, Above),
    above_left([X,Y], Matrix, Above_Left),
    above_right([X,Y], Matrix, Above_Right),
    right([X,Y], Matrix, Right),
    left([X,Y], Matrix, Left),
    get_valid_move(Below,Item, Matrix, Below_Moves),
    get_valid_move(Below_Left,Item, Matrix, Below_Left_Moves),
    get_valid_move(Below_Right,Item, Matrix, Below_Right_Moves),
    get_valid_move(Above,Item, Matrix, Above_Moves),
    get_valid_move(Above_Left,Item, Matrix, Above_Left_Moves),
    get_valid_move(Above_Right,Item, Matrix, Above_Right_Moves),
    get_valid_move(Right,Item, Matrix, Right_Moves),
    get_valid_move(Left,Item, Matrix, Left_Moves),
    append(Below_Moves,Below_Left_Moves,A),
    append(A,Below_Right_Moves,B),
    append(B,Above_Moves,C),
    append(C,Above_Left_Moves,D),
    append(D,Above_Right_Moves,E),
    append(E,Right_Moves,F),
    append(F,Left_Moves,All_Moves),
    !.




% Змінює усі елемент в матриці з заданими координатами на нове значення
% List - список координат
% change_matrix(++Matrix, ++List, ++NewValue, -NewMatrix)

change_matrix(Matrix,[], _, Matrix).
change_matrix(Matrix,[H|T], NewElem, ResultMatrix):-
	replace_element(Matrix, H, NewElem, NewMatrix),
	change_matrix(NewMatrix,T, NewElem, ResultMatrix),!.


% Змінює елемент в матриці з заданими координатами на нове значення
%
% replace_element(++Matrix, ++[X,Y], ++NewValue, -NewMatrix)

replace_element(Matrix, [X,Y], NewValue, NewMatrix) :-
    nth0(X, Matrix, Row),
    replace_in_list(Row, Y, NewValue, NewRow),
    replace_in_list(Matrix, X, NewRow, NewMatrix).

% Змінює елемент за заданим індексом на нове значення
%
% replace_in_list(++List, ++Index, ++NewValue, -ResList)

replace_in_list([_|T], 0, NewValue, [NewValue|T]):-!.
replace_in_list([H|T], Index, NewValue, [H|R]) :-
    Index > 0,
    NextIndex is Index - 1,
    replace_in_list(T, NextIndex, NewValue, R).


% Змінює заданий список координат клітинок в будь-який бік від клітинки, в яку зробили хід, таким чином, що він стає списком координат тих клітинок, які зміняться при ході
%
% get_valid_move(++Move_List,++Init_item, ++Matrix, --Final_Moves)
get_valid_move([],_, _, []):-!.
get_valid_move(Move_List,Init_item, Matrix, Final_Moves):-
    get_valid_move_help(Move_List, Init_item, Matrix, [], Final_Moves).

get_valid_move_help([],_, _,_, []):-!.
get_valid_move_help([[X,Y]|_], _, Matrix, _, Final_Moves):-
    get_element_from_matrix([X,Y], Matrix, Item),
    (Item==0;
    Item==2),
    Final_Moves=[],!.

get_valid_move_help([[X,Y]|_], Init_Item, Matrix, Current_Moves, Final_Moves):-
    get_element_from_matrix([X,Y], Matrix, Item),
    Item==Init_Item,
    Final_Moves=Current_Moves,!.

get_valid_move_help([[X,Y]|Rest_Moves], Init_Item, Matrix, Current_Moves, Final_Moves):-
    append(Current_Moves, [[X,Y]], New_Current_Moves),
    get_valid_move_help(Rest_Moves, Init_Item, Matrix, New_Current_Moves, Final_Moves).




% за координатами отримуємо елемент матриці
%
% get_element_from_matrix(++[X,Y], ++Matrix, -Item)
get_element_from_matrix([X,Y], Matrix, Item):-
    nth0(X, Matrix, Row),
    nth0(Y, Row, Item).


% елементи нижче по вертикалі
%
% below(++[X,Y], ++Matrix, -ResList)
below([X,Y], Matrix, ResList) :-
    below_help([X,Y], Matrix, [], ResList).

below_help([X,_], Matrix, MiddleRes, Res):-
    length(Matrix,Len),
    X1 is X+1,
    X1>=Len,
    Res = MiddleRes,!.
below_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X+1,
    get_element_from_matrix([X1,Y], Matrix, Item),
    (Item==0;
    Item==2),
    Res = MiddleRes,!.

below_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X+1,
    append(MiddleRes, [[X1,Y]], Res2),
    below_help([X1,Y], Matrix, Res2, Res).


% елементи нижче по вертикалі і лівіше по горизонталі
%
% below_left(++[X,Y], ++Matrix, -ResList)
below_left([X,Y], Matrix, ResList) :-
    below_left_help([X,Y], Matrix, [], ResList).

below_left_help([X,Y], Matrix, MiddleRes, Res):-
    length(Matrix,Len),
    X1 is X+1,
    Y1 is Y-1,
    (Y1<0;
    X1>=Len),
    Res = MiddleRes,!.

below_left_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X+1,
    Y1 is Y-1,
    get_element_from_matrix([X1,Y1], Matrix, Item),
    (Item==0;
    Item==2),
    Res = MiddleRes,!.


below_left_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X+1,
    Y1 is Y-1,
    append(MiddleRes, [[X1,Y1]], Res2),
    below_left_help([X1,Y1], Matrix, Res2, Res).

% елементи нижче по вертикалі і правіше по горизонталі
%
% below_right(++[X,Y], ++Matrix, -ResList)
below_right([X,Y], Matrix, ResList) :-
    below_right_help([X,Y], Matrix, [], ResList).

below_right_help([X,Y], [Row1|Rest], MiddleRes, Res):-
    length([Row1|Rest],Len),
    X1 is X+1,
    length(Row1,Len2),
    Y1 is Y+1,
    (Y1>=Len2;
    X1>=Len),
    Res = MiddleRes,!.

below_right_help([X,Y], [Row1|Rest], MiddleRes, Res):-
    X1 is X+1,
    get_element_from_matrix([X1,Y1], [Row1|Rest], Item),
    Y1 is Y+1,
    (Item==0;
    Item==2),
    Res = MiddleRes,!.



below_right_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X+1,
    Y1 is Y+1,
    append(MiddleRes, [[X1,Y1]], Res2),
    below_right_help([X1,Y1], Matrix, Res2, Res).







% елементи вище по вертикалі
%
% above(++[X,Y], ++Matrix, -ResList)
above([X,Y], Matrix, ResList) :-
    above_help([X,Y], Matrix, [], ResList).

above_help([X,_], _, MiddleRes, Res):-
    X1 is X-1,
    X1<0,
    Res = MiddleRes,!.

above_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X-1,
    get_element_from_matrix([X1,Y], Matrix, Item),
    (Item==0;
    Item==2),
    Res = MiddleRes,!.

above_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X-1,
    append(MiddleRes, [[X1,Y]], Res2),
    above_help([X1,Y], Matrix, Res2, Res).


% елементи вище по вертикалі і лівіше по горизонталі
%
% above_left(++[X,Y], ++Matrix, -ResList)
above_left([X,Y], Matrix, ResList) :-
    above_left_help([X,Y], Matrix, [], ResList).

above_left_help([X,Y], _, MiddleRes, Res):-
    X1 is X-1,
    Y1 is Y-1,
    (Y1<0;
    X1<0),
    Res = MiddleRes,!.
above_left_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X-1,
    Y1 is Y-1,
    get_element_from_matrix([X1,Y1], Matrix, Item),
    (Item==0;
    Item==2),
    Res = MiddleRes,!.

above_left_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X-1,
    Y1 is Y-1,
    append(MiddleRes, [[X1,Y1]], Res2),
    above_left_help([X1,Y1], Matrix, Res2, Res).

% елементи вище по вертикалі і правіше по горизонталі
%
% above_right(++[X,Y], ++Matrix, -ResList)
above_right([X,Y], Matrix, ResList) :-
    above_right_help([X,Y], Matrix, [], ResList).

above_right_help([X,Y], [Row1|_], MiddleRes, Res):-
    X1 is X-1,
    length(Row1,Len),
    Y1 is Y+1,
    (Y1>=Len;
    X1<0),
    Res = MiddleRes,!.

above_right_help([X,Y], [Row1|Rest], MiddleRes, Res):-
    X1 is X-1,
    Y1 is Y+1,
    get_element_from_matrix([X1,Y1], [Row1|Rest], Item),
    (Item==0;
    Item==2),
    Res = MiddleRes,!.

above_right_help([X,Y], Matrix, MiddleRes, Res):-
    X1 is X-1,
    Y1 is Y+1,
    append(MiddleRes, [[X1,Y1]], Res2),
    above_right_help([X1,Y1], Matrix, Res2, Res).




% елементи лівіше по горизонталі
%
% left(++[X,Y], ++Matrix, -ResList)
left([X,Y], Matrix, ResList) :-
    left_help([X,Y], Matrix, [], ResList).

left_help([_,Y], _, MiddleRes, Res):-
    Y1 is Y-1,
    Y1<0,
    Res = MiddleRes,!.

left_help([X,Y], Matrix, MiddleRes, Res):-
    Y1 is Y-1,
    get_element_from_matrix([X,Y1], Matrix, Item),
    (Item==0;
    Item==2),
    Res = MiddleRes,!.


left_help([X,Y], Matrix, MiddleRes, Res):-
    Y1 is Y-1,
    append(MiddleRes, [[X,Y1]], Res2),
    left_help([X,Y1], Matrix, Res2, Res).


% елементи правіше по горизонталі
%
% right(++[X,Y], ++Matrix, -ResList)
right([X,Y], Matrix, ResList) :-
    right_help([X,Y], Matrix, [], ResList).

right_help([_,Y],[Row1|_], MiddleRes, Res):-
    length(Row1,Len),
    Y1 is Y+1,
    Y1>=Len,
    Res = MiddleRes,!.

right_help([X,Y],[Row1|Rest], MiddleRes, Res):-
    Y1 is Y+1,
    get_element_from_matrix([X,Y1], [Row1|Rest], Item),
    (Item==0;
    Item==2),
    Res = MiddleRes,!.

right_help([X,Y], Matrix, MiddleRes, Res):-
    Y1 is Y+1,
    append(MiddleRes, [[X,Y1]], Res2),
    right_help([X,Y1], Matrix, Res2, Res).

num_to_max(0, _).
num_to_max(Q, Max):- Max>1, NewMax is Max-1, num_to_max(Y, NewMax), Q is Y+1.

