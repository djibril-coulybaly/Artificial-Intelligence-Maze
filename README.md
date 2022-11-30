<div align="center">
  <h1>Artificial Intelligence Maze Pathfinder</h1>
</div>

<!-- Table of Contents -->

## :notebook_with_decorative_cover: Table of Contents

- [Introduction](#introduction)
- [Getting Started](#toolbox-getting-started)
- [System Design](#triangular_ruler-system-design)
  - [Maze](#one-maze)
  - [Depth First Search](#two-depth-first-search)
  - [Iterative Deepening Search](#three-iterative-deepening-search)
  - [A Star Search](#four-a-star-search)
- [Directory Structure](#file_folder-directory-structure)

---

<!-- Features -->

## Introduction

Implemented and evaluated three different search algorithms for finding a path in a maze using Prolog. The algorithms used were:

1. Depth-first search
2. Iterative-deepening search
3. A\*

---

<!-- Getting Started -->

## :toolbox: Getting Started

To run the search alogrithms:

1. Open SWI-Prolog
2. Go to "File" --> "Consult" and choose the search algorithm you wish to run
3. To **run the search algorithm**, type the following command:
   ```prolog
   solveMaze.
   ```
4. To **view the peformance time** of the search algorithm, type the following command:

   ```bash
   time((solveMaze)).
   ```

---

<!-- System Design -->

## :triangular_ruler: System Design

### :one: Maze

To evaluate the search algorithms, the following mazes were used and implemented in Prolog:

|                         Sample Maze 1                          |                          Sample Maze 2                          |
| :------------------------------------------------------------: | :-------------------------------------------------------------: |
| <img src="Sample Maze 1.png" alt="Sample Maze 1" width="300"/> | <img src="Sample Maze 2.png" alt="Sample Maze 2" width="300" /> |

### :two: Depth First Search

We will performing the following actions to obtain the solution to the maze:

    1. Selecting a direction to move from the current position
    2. Moving in the selected direction from the current position
    3. Checking to see if the newly selected direction has been visited before
        - If it has been visited before, then this command is skipped
    4. The newly selected direction is added to the final solutions list and the algorithm is recursively called again
    5. The final solution is then displayed

### :three: Iterative Deepening Search

We will performing the following actions to obtain the solution to the maze:

    1. Obtaining the max depth of the maze by multiplying the maze row by the maze column
    2. Selecting a direction to move from the current position
    3. Moving in the selected direction from the current position
    4. Checking to see if the newly selected direction has been visited before
        - If it has been visited before, then this command is skipped
    5. Increasing the depth by 1
    6. The newly selected direction is added to the final solutions list and the algorithm is recursively called again
    7. The final solution is then displayed

### :four: A Star

We will performing the following actions to obtain the solution to the maze:

    1. Obtaining the heuristic value of the algorithm by calculating the Manhattan distance
    2. Generating the children of a node/position & checking all the move directions allowed in that node/position.
    3. Using the calculated cost function, the node/position is added to the list of already generated children and the algorithm is recursively called again
    4. The final solution is then displayed

---

<!-- Directory Structure -->

## :file_folder: Directory Structure

```
|-- Code
|   |-- Sample Maze 1
|   |   |-- a_star_search_algorithm.pl
|   |   |-- depth_first_search_algorithm.pl
|   |   '-- iterative_deep_search_algorithm.pl
|   |-- Sample Maze 2
|   |   |-- a_star_search_algorithm.pl
|   |   |-- depth_first_search_algorithm.pl
|   |   '-- iterative_deep_search_algorithm.pl
```
