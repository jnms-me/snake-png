import std.stdio;
import deimos.ncurses;
import imageformats;
import colors;
import game;

void main() {
    // Initialize ncurses
    initscr();
    cbreak();
    noecho();
    keypad(stdscr, true);
    timeout(1000);

    IFImage img = read_image("background.png", 0);
    write_png("out.png", img.w, img.h, img.pixels);
    auto snake = new Snake(Coordinate(0, 0), Direction.RIGHT);
    auto fruit = new Fruit(img.w, img.h);

    while (true) {
        int key = getch();
        if (key != -1) {
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
                    break;
            }
            snake.changeDir(dir);
        }


        if (snake.getHead == fruit.location) {
            fruit.respawn();
            snake.move(true);
        } else {
            snake.move(false);
        }

        img = read_image("background.png", 0);
        foreach (coordinate; snake.getParts()) {
            setPixel(img, coordinate.x, coordinate.y, Colors.snake);
        }
        setPixel(img, fruit.location.x, fruit.location.y, Colors.fruit);

        write_png("out.png", img.w, img.h, img.pixels);
    }
}

void setPixel(IFImage img, int x, int y, RGB color) {

    if (x >= img.w || y >= img.h) {
        throw new OutOfBoundsException("Coordinates are out of bounds.");
    }

    int location = ((y * img.w) + x) * 3;
    img.pixels[location] = color.red;
    img.pixels[location + 1] = color.green;
    img.pixels[location + 2] = color.blue;

    return;
}

enum Keys : int {
    DOWN = 258,
    UP = 259,
    LEFT = 260,
    RIGHT = 261
}

class OutOfBoundsException : Exception
{
    this(string msg, string file = __FILE__, size_t line = __LINE__) {
        super(msg, file, line);
    }
}
