import 'dart:math';

class MineSweeper {
  static int row = 10;
  static int col = 10;
  static int mineCount = 10;
  int cells = row * col;
  int remainCells = row * col;
  int remainMine = 0;
  bool gameOver = false;
  bool gameWin = false;
  List<Cell> gameMap = [];

  List<List<dynamic>> map = List.generate(
    row,
    (x) => List.generate(
      col,
      (y) => Cell(x, y, "", false),
    ),
  );

  // Generae Map
  void generateMap() {
    placeMine(mineCount);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        gameMap.add(map[i][j]);
      }
    }
  }

  // Create Mine
  void placeMine(int mineNumber) {
    Random random = Random();
    for (int i = 0; i < mineNumber; i++) {
      int mineRow = random.nextInt(row);
      int mineCol = random.nextInt(col);
      if (map[mineRow][mineCol].content != "X") {
        map[mineRow][mineCol] = Cell(mineRow, mineCol, "X", false);
        remainMine++;
      } else {
        i--;
      }
    }
  }

  // Reset Game
  void resetGame() {
    map = List.generate(
      row,
      (x) => List.generate(
        col,
        (y) => Cell(x, y, "", false),
      ),
    );
    gameMap.clear();
    gameWin = false;
    remainCells = row * col;
    generateMap();
  }

  // Show Mines
  void showMine() {
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        if (map[i][j].content == "X") {
          map[i][j].reveal = true;
        }
      }
    }
  }

  // Action Place Flag
  void placeFlag(Cell cell) {
    // not clicked on mine
    if (cell.content != "X") {
      showMine();
      gameOver = true;
    } else {
      // place flag
      cell.content = "O";
      cell.reveal = true;
      remainCells--;
      remainMine--;
    }

    // check for win
    if (remainCells <= 0 || remainMine <= 0) {
      gameWin = true;
    }
  }

  // Action Click Cell
  void clickCell(Cell cell) {
    // clicked on mine
    if (cell.content == "X") {
      showMine();
      gameOver = true;
    } else {
      //calculate the near mine
      int mineCount = 0;
      remainCells--;

      for (int i = max(cell.row - 1, 0); i <= min(cell.row + 1, row - 1); i++) {
        // cell araund
        for (int j = max(cell.col - 1, 0);
            j <= min(cell.col + 1, col - 1);
            j++) {
          // col araound
          if (map[i][j].content == "X") {
            mineCount++;
          }
        }
      }
      cell.content = mineCount;
      cell.reveal = true;
      if (mineCount == 0) {
        for (int i = max(cell.row - 1, 0);
            i <= min(cell.row + 1, row - 1);
            i++) {
          // cell araund
          for (int j = max(cell.col - 1, 0);
              j <= min(cell.col + 1, col - 1);
              j++) {
            // col araound
            if (map[i][j].content == "") {
              clickCell(map[i][j]);
            }
          }
        }
      }
    }

    // check for win
    if (remainCells <= 0) {
      gameWin = true;
    }
  }
}

class Cell {
  int row;
  int col;
  dynamic content;
  bool reveal = false;

  Cell(
    this.row,
    this.col,
    this.content,
    this.reveal,
  );
}
