class GameOfLifeTest extends GroovyTestCase {

    void testOneCellDies() {
        def game = new GameOfLife()
        game << new Cell(0, 0)
        game.tick()
        assert !game.isAlive(0, 0)
    }

    void testOneCellLives() {
        def game = new GameOfLife()
        game << new Cell(0, 0) <<
            new Cell(0, 1) <<
            new Cell(1, 0)
        game.tick()
        assert game.isAlive(0, 0)
    }

    void testDistantNeighbors() {
        def game = new GameOfLife()
        game << new Cell(0, 0) <<
        new Cell(0, 5) <<
        new Cell(5, 0)
        game.tick()
        assert !game.isAlive(0, 0)
    }

}
