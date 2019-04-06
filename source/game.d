import std.random;
import colors;

struct Coordinate {
    int x;
    int y;
}

enum Direction : Coordinate {
    DOWN = Coordinate(0, 1),
    UP = Coordinate(0, -1),
    LEFT = Coordinate(-1, 0),
    RIGHT = Coordinate(1, 0),
    NONE = Coordinate(0, 0)
}

class Snake {
    private int x_max;
    private int y_max;

    private Coordinate[] parts;
    public Direction direction;

    this(int x_max, int y_max, Coordinate start, Direction dir) {
        this.x_max = x_max;
        this.y_max = y_max;
        parts ~= start;
        direction = dir;
    }

    void changeDir(Direction dir) {
        if (dir != Direction.NONE) {
            direction = dir;
        }
    }

    void move(bool grow) {
        Coordinate moveTo = Coordinate(parts[0].x + direction.x, parts[0].y + direction.y);
        if (!grow) {
            parts = parts[0 .. $-1];
        }
        parts = moveTo ~ parts;
    }

    bool checkGameOver() {
        bool gameOver = false;

        // Out of bounds
        if (getHead().x > x_max || getHead.x < 0) {
            gameOver = true;
        } else if (getHead().y > y_max || getHead.y < 0) {
            gameOver = true;
        } else {
            // Collision with self
            foreach (i, firstPart; getParts()) {
                foreach (j, secondPart; getParts()) {
                    if (i != j && firstPart == secondPart) {
                        gameOver = true;
                    }
                }
            }
        }
        return gameOver;
    }

    Coordinate getHead() {
        return parts[0];
    }

    Coordinate[] getParts() {
        return parts;
    }
}

class Fruit {
    private int x_max;
    private int y_max;
    public Coordinate location;

    this(int x_max, int y_max) {
        this.x_max = x_max;
        this.y_max = y_max;
        respawn();
    }

    void respawn() {
        auto rnd = Random(unpredictableSeed);
        int x = uniform(0, x_max - 1, rnd);
        int y = uniform(0, y_max - 1, rnd);
        location = Coordinate(x, y);
    }
}
