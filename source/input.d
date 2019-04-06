import deimos.ncurses;
import game : Direction, Coordinate;

// Initialize ncurses
void initInput() {
    initscr();
    cbreak();
    noecho();
    keypad(stdscr, true);
    timeout(1000);
}

Direction getKey() {
    int key = getch();
    Direction dir;
    switch (key) {
        case Keys.DOWN:
            dir = Direction.DOWN;
            break;
        case Keys.UP:
            dir = Direction.UP;
            break;
        case Keys.LEFT:
            dir = Direction.LEFT;
            break;
        case Keys.RIGHT:
            dir = Direction.RIGHT;
            break;
        default:
            dir = Direction.NONE;
            break;
    }
    return dir;
}

enum Keys : int {
    DOWN = 258,
    UP = 259,
    LEFT = 260,
    RIGHT = 261
}
