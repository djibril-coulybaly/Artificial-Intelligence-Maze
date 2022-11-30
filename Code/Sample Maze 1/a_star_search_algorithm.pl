/*
Student Name: Djibril Coulybaly
Student Number: C18423664
File Name: a_star_search_algorithm.pl
File Description: This file contains the code to implement an A* search alogrithm on 
                  Sample Maze 1 as indicated in the file description
*/
/* Step 1 - Defining maze. 
   
   The maze will look like this:

    +---+---+---+---+---+
    | E |   |   |   |   |
    +---+---+---+---+---+
    |   | x | x | x |   |
    +---+---+---+---+---+
    |   | x | S | x |   |
    +---+---+---+---+---+
    |   | x |   |   |   |
    +---+---+---+---+---+
    |   |   |   |   |   |
    +---+---+---+---+---+

    Where:
        X = Blocked wall
        S = Starting position
        E = End position


    The position of each grid is defined as:
        position(X, Y)

    where:
        X = Row
        Y = Column
    
    with each row and column starting at 1

*/
maze_row(5).
maze_column(5).
blocked_wall(position(2,2)).
blocked_wall(position(3,2)).
blocked_wall(position(4,2)).
blocked_wall(position(4,3)).
blocked_wall(position(4,4)).
blocked_wall(position(3,4)).
starting_position(position(3,3)).
end_position(position(5,1)).

/* Step 2 - Checking to see what direction we can move into. 

    The function takes in 2 parameters:
        1. The direction which were searching
        2. The position we are currently in using Row and Column

*/
can_move(up, position(Row, Col)) :-
    not(maze_row(Row)),
    NewRowPos is Row + 1,
    not(blocked_wall(position(NewRowPos, Col))).

can_move(down, position(Row, Col)) :-
    Row > 1,
    NewRowPos is Row - 1,
    not(blocked_wall(position(NewRowPos, Col))).

can_move(left, position(Row, Col)) :-
    Col > 1,
    NewColPos is Col - 1,
    not(blocked_wall(position(Row, NewColPos))).

can_move(right, position(Row, Col)) :-
    not(maze_row(Col)),
    NewColPos is Col + 1,
    not(blocked_wall(position(Row, NewColPos))).

/* Step 3 - Moving to the selected direction. 

    The function takes in 3 parameters:

    1. The direction which we want to take
    2. The position we are currently in with the row position and column position
    2. The position which we want to be in with the row position and column position
*/
move_direction(up, position(Row, Col), position(Up, Col)) :-
    Up is Row + 1.

move_direction(down, position(Row, Col), position(Down, Col)) :-
    Down is Row - 1.

move_direction(left, position(Row, Col), position(Row, Left)) :-
    Left is Col - 1.

move_direction(right, position(Row, Col), position(Row, Right)) :-
    Right is Col + 1.


/* Step 4 - Running the algorithm

    We will performing the following actions to obtain the solution to the maze:

    1. Obtaining the heuristic value of the algorithm by calculating the Manhattan distance
    2. Generating the children of a node/position & checking all the move directions allowed in that node/position.   
    3. Using the calculated cost function, the node/position is added to the list of already generated children
       and the algorithm is recursively called again 
    4. The final solution is then displayed 


    The result of the algorithm should be as follows:

    +---+---+---+---+---+
    | E |   |   |   |   |
    +---+---+---+---+---+
    | * | x | x | x |   |
    +---+---+---+---+---+
    | * | x | S | x |   |
    +---+---+---+---+---+
    | * | x | * |   |   |
    +---+---+---+---+---+
    | * | * | * |   |   |
    +---+---+---+---+---+

    Where:
        X = Blocked wall
        S = Starting position
        E = End position
        * = Direction

        Direction path = down,down,left,left,up,up,up,up
*/
manhattanHeuristic(position(RowA, ColA), position(RowB, ColB), Distance):-
    Distance is abs(RowA - RowB) + abs(ColA - ColB).

solveMaze :-
    aStarSearchAlgorithm.

aStarSearchAlgorithm :-
    starting_position(Node),
    end_position(F),
    manhattanHeuristic(Node, F, H),
    useAlgorithm([ [[], Node, H] ], [], ReverseSolution),
    reverse(ReverseSolution, Solution),
    write("The solution for this maze is: "),write(Solution).

useAlgorithm([[A, NodePos, _] | _], _, A) :- 
    end_position(NodePos). 
useAlgorithm([Node | Tail], ClosedSet, Solution) :-
    expand(Node, ClosedSet, ExpandedNodes),
    subtract(ClosedSet, ExpandedNodes, NewClosedSet),
    add(ExpandedNodes, Tail, OrderedList),
    not(length(OrderedList, 0)),
    useAlgorithm(OrderedList, [Node | NewClosedSet], Solution).

expand([A, NodePos, FN], ClosedSet, ExpandedNodes):-
    end_position(F),
    g([A, NodePos, FN], G),
    findall([[Direction | A], NewPosition, FNew], 
        (
            can_move(Direction, NodePos), 
            move_direction(Direction, NodePos, NewPosition), 
            manhattanHeuristic(NewPosition, F, H), 
            cost(NodePos, NewPosition, Cost), 
            FNew is G + Cost + H, 
            (
                not(member([_, NewPosition, _], ClosedSet)); 
                (member([_, NewPosition, E], ClosedSet), FNew < E)
            )
        ),
         ExpandedNodes).
    
add(ExpandedNodes, OldNodes, Sorted):-
    append(ExpandedNodes, OldNodes, AlreadyInList),
    predsort(comparator, AlreadyInList, Sorted).

g([_, NodePos, FN], G):-
    end_position(F),
    manhattanHeuristic(NodePos, F, H),
    G is FN - H.

comparator(<, [_, _, A1], [_, _, A2]):- A1 < A2.
comparator(>, _, _).

cost(_, _, 1).

