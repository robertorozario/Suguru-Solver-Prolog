:- use_module(library(clpfd)).

%Recebe uma matriz e um número N e retorna a linha N dessa Matriz
linha(M, N, Row) :- nth1(N, M, Row).


%Recebe a matriz de áreas e preenche cada linha com os valores possíveis
%de 1 até o tamanho da linha
preencher(M, 0).
preencher(M, C) :- linha(M, C, R), length(R, N), R ins 1..N, label(R), P is C-1, preencher(M, P).  

%Recebe duas linhas e pega todo o conjunto de 4 posições adjacentes, fazendo
%adicionando a regra de distinção entre os valores adjacentes

quartetos([P1,P2], [P3,P4]) :- all_distinct([P1,P2,P3,P4]).
quartetos([P1,P2|TL1], [P3,P4|TL2]) :- all_distinct([P1,P2,P3,P4]), quartetos([P2|TL1], [P4|TL2]).

%Recebe a matriz e seu tamanho
%busca de duas em duas linhas e passa para a função quarteto até que o contador
%atinja o minímo possível
arredores(M, 1).
arredores(M, C) :-  K is C-1, linha(M, C, L1), linha(M, K, L2), quartetos(L1, L2),arredores(M, K).


%Recebe uma matriz e printa cada linha separadamente
mostrar_resultado([]).
mostrar_resultado([H|T]) :- write(H), nl, mostrar_resultado(T).


%Recebe a matriz e resolve o suguru utilizando a matriz área
%fazendo com que todos os elementos da área sejam diferentes
%depois chamando a função arredores para garantir que as posições adjacentes também 
%tenham valores diferentes e, por fim, preenchendo os valores possíveis
suguru(Np, Matriz) :- 
    problema(Np, Matriz),
    length(Matriz, T),
    arredores(Matriz, T),
    matriz_area(Np, Matriz, Matriz_area),
    maplist(all_distinct, Matriz_area),
    length(Matriz_area, L),
    preencher(Matriz_area, L).

%Define um problema
problema(56,P) :- 
    P = [[_,2,_,3,2,3,_,1],
        [5,_,1,_,_,_,2,_],
        [_,_,5,_,1,_,_,5],
        [_,3,_,6,_,_,2,_],
        [4,_,_,_,5,_,_,_],
        [_,_,_,_,_,1,_,2],
        [_,_,_,_,_,6,_,1],
        [3,_,1,2,_,_,_,2]].        


%recebe a matriz do problema e retorna a matriz de áreas relacionada
matriz_area(56, [
            [A1, A2, A3, A4, A5, A6, A7, A8],
            [B1, B2, B3, B4, B5, B6, B7, B8],
            [C1, C2, C3, C4, C5, C6, C7, C8],
            [D1, D2, D3, D4, D5, D6, D7, D8],
            [E1, E2, E3, E4, E5, E6, E7, E8],
            [F1, F2, F3, F4, F5, F6, F7, F8],
            [G1, G2, G3, G4, G5, G6, G7, G8],
            [H1, H2, H3, H4, H5, H6, H7, H8]
        ], M):-
    M = [[A1,A2,A3,A4],
    [A5,A6,B3,B4,B5,B6],
    [A7,A8,B7,B8],
    [B1,B2,C1,C2,D1],
    [C3,D2,D3,E1,E2,F1],
    [C4,D4,E3,E4,F2,F3],
    [C5,C6,D5,D6,E5],
    [C7,C8,D7,D8,E6,E7],
    [F4,F5,F6],
    [E8,F7,F8,G5,G6,G7],
    [G1,G2,H1,H2],
    [G3,G4,H3,H4],
    [H5,H6,H7,H8,G8]].


matriz_area(21, [
            [A1, A2, A3, A4, A5, A6],
            [B1, B2, B3, B4, B5, B6],
            [C1, C2, C3, C4, C5, C6],
            [D1, D2, D3, D4, D5, D6],
            [E1, E2, E3, E4, E5, E6],
            [F1, F2, F3, F4, F5, F6]
        ] , M):-
    M = [[A1,A2,A3,A4],
    [A5,A6,B5,B6],
    [B1,B2,C1,C2,D1],
    [B3,B4,C4,C5,D5],
    [C6,D6,E6,F6],
    [C3,D3,E3,D4,E4],
    [D2,E1,E2,F1],
    [F2,F3,F4,F5,E5]].
    
problema(21,P) :- 
    P = [[_, _, _, 2, _, _],
[_, 2, _, _, 1, _],
[1, _, _, 5, _, 4],
[_, _, 4, _, _, _],
[_, _, 5, _, 4, _],
[_, _, _, 3, _, 1]]. 

matriz_area(104, [
            [A1, A2, A3, A4, A5, A6, A7],
            [B1, B2, B3, B4, B5, B6, B7],
            [C1, C2, C3, C4, C5, C6, C7],
            [D1, D2, D3, D4, D5, D6, D7],
            [E1, E2, E3, E4, E5, E6, E7],
            [F1, F2, F3, F4, F5, F6, F7],
            [G1, G2, G3, G4, G5, G6, G7]
        ], M):-
    M = [[A1,A2,A3],[A4,A5,A6,A7],[B2,B3,B4,B5,C2,C3],[B6,B7,C6,C7],[B1,C1,D1,E1,E2,F2],[F1,G1,G2],[D2,D3,E3],[C4,C5,D4,D5,E5],[D6,D7,E7,F7],[E4,F3,F4,G3,G4,G5],[E6,F5,F6,G6,G7]].

problema(104,P) :- 
    P = [[2, _, _, _, _, _, 1],
 [_, 4, _, 5, _, 4, _],
 [3, 6, _, 4, _, _, 1],
 [_, _, _, _, _, _, _],
 [5, 6, _, _, _, 5, 3],
 [_, _, _, 2, _, _, 1],
 [1, 2, 1, 3, _, 3, 2]]. 
