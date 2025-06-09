import std.stdio;
import imageformats;
import game;
import graphics;
import input;
import network;

void main(string[] args) {
    initInput();

    // Needed to read image size
    IFImage img = read_image("background.png", 0);
    auto snake = new Snake(img.w, img.h, Coordinate(0, 0), Direction.RIGHT);
    auto fruit = new Fruit(img.w, img.h);
    destroy(img);

    auto graphics = new Graphics(snake, fruit);

    while (true) {
        snake.changeDir(getKey());

        if (snake.getHead == fruit.location) {
            fruit.respawn();
            snake.move(true);
        } else {
            snake.move(false);
        }

        if (snake.checkGameOver()) {
            writeln("Game over!");
            return;
        }

        graphics.draw();

        if (args.length == 2)
            sendImage(args[1]);
    }
}
