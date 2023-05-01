import 'dart:math';

class MineSweeper {
  static int row = 6;
  static int col = 6;
  static int cells = row * col;
  int remaningMine = 10;
  bool gameOver = false;
  List<Cell> gameMap = [];

  static List<List<dynamic>> map = List.generate(
    row,
    (x) => List.generate(
      col,
      (y) => Cell(x, y, "", false),
    ),
  );

  // Generae Map
  void generateMap() {
    placeMine(10);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        gameMap.add(map[i][j]);
      }
    }
  }

  // Create Mine
  static void placeMine(int mineNumber) {
    Random random = Random();
    for (int i = 0; i < mineNumber; i++) {
      int mineRow = random.nextInt(row);
      int mineCol = random.nextInt(col);
      map[mineRow][mineCol] = Cell(mineRow, mineCol, "X", false);
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

  // Action Click Cell
  void clickCell(Cell cell) {
    // clicked on mine
    if (cell.content == "X") {
      showMine();
      gameOver = true;
    } else {
      //calculate the near mine
      int mineCount = 0;

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
