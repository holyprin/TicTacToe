## TicTacToe Interview Project

In the 2x2 scenario where multiple 2x2's can be completed with a single move using up to 9 tiles in a 3x3 pattern, the code will return indexes for every condition, so technically if you fill a 3x3 and place the center tile last it will report a 3x3 as a win because you completed 4 2x2's at the same time. Finally the win length being completed by 2 separate chains with a single move to create a length longer than the configured compile time constant (default 4) is also a win. This is a only a possibility on board sizes larger than the configured win length.

Tests were included that test these scenarios plus all specified conditions

UI was built to handle any size grid to a reasonable amount as well as a win length constant set at compile time mentioned previously.

Every win condition returns the indexes of the tiles in question and highlights them on the board.
