import imageformats;
import game;
import colors;

class Graphics {
    private Snake snake;
    private Fruit fruit;

    this(Snake snake, Fruit fruit) {
        this.snake = snake;
        this.fruit = fruit;
    }

    void draw() {
        IFImage img = read_image("background.png", 0);
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

class OutOfBoundsException : Exception
{
    this(string msg, string file = __FILE__, size_t line = __LINE__) {
        super(msg, file, line);
    }
}

