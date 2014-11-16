import static java.lang.Math.abs

public class GameOfLife {

    List<Cell> cells = []

    GameOfLife leftShift(Cell cell) {
        cells << cell

        this
    }

    void tick() {
        def newCells = []

        cells.each {
            cell ->

            if (cells.grep { it != cell}
                     .grep { neighbor(cell, it)}
                     .size() > 1) {
                newCells << cell
            }
        }

        cells = newCells
    }

    boolean neighbor(Cell cell1, Cell cell2) {
        abs(cell1.x - cell2.x) <= 1 &&
        abs(cell1.y - cell2.y) <= 1
    }

    boolean isAlive(Integer x, Integer y) {
        cells.find { it.x == x && it.y == y } as boolean
    }
}
