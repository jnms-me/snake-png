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
    RIGHT = Coordinate(1, 0)
}

class Snake {
    private Coordinate[] parts;
    private Direction direction;

    this(Coordinate start, Direction dir) {
        parts ~= start;
        direction = dir;
    }

    void changeDir(Direction dir) {
        direction = dir;
    }

    void move(bool grow) {
        Coordinate moveTo = Coordinate(parts[0].x + direction.x, parts[0].y + direction.y);
        if (!grow) {
            parts = parts[0 .. $-1]; // Slice 2nd to last
        }
        parts = moveTo ~ parts;
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
