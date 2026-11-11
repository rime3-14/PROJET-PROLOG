# Connect Four in Prolog

A terminal Connect Four implementation for the fourth-year ALIA course at INSA Lyon. The board uses Prolog variables for empty slots. Predicates update the board, alternate players and detect wins in columns, rows and diagonals.

## Run a game

Use SWI-Prolog with its standard packages. From the repository root:

```bash
swipl -q -s src/main.pl -g init -t halt
```

The terminal prints a full game between two random-move players. `src/minimax.pl` also provides a depth-limited move search. Its unit tests exercise both evaluation and move selection.

## Tests

```bash
swipl -q -s run_tests.pl
```

Team project with Mariabenaouf, sylvanie85, hdnys and rime3-14. Rime Chihab-Eddine contributed tests for the board, rules and win detection.
