/*
Student Name: Djibril Coulybaly
Student Number: C18423664
File Name: depth_first_search_algorithm.pl
File Description: This file contains the code to implement a depth first 
                  search alogrithm on Sample Maze 1 as indicated in the 
                  file description
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

    1. Selecting a direction to move from the current position
    2. Moving in the selected direction from the current position
    3. Checking to see if the newly selected direction has been visited before 
        - If it has been visited before, then this command is skipped
    4. The newly selected direction is added to the final solutions list and 
       the algorithm is recursively called again 
    5. The final solution is then displayed 

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
solveMaze :-
    depthFirstSearchAlgorithm(Solution).

depthFirstSearchAlgorithm(Solution) :-
    starting_position(Node),
    useAlgorithm(Node, Solution, [Node]),
    write("The solution for this maze is: "),write(Solution).

useAlgorithm(NodePos, _, _) :- end_position(NodePos), !.
useAlgorithm(NodePos, [Direction|Path], Node ) :-
    can_move(Direction, NodePos),
    move_direction(Direction, NodePos, NewPosition),
    not(member(NewPosition, Node)),
    useAlgorithm(NewPosition, Path, [NewPosition|Node]).