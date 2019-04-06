import std.stdio : writeln;
import std.net.curl;
import imageformats;

void sendImage(string host) {
    IFImage img = read_image("out.png");
    auto data = write_png_to_mem(img.w, img.h, img.pixels);
    auto client = HTTP();
    client.addRequestHeader("Content-Type", "image/png");
    writeln(post("http://" ~ host, data, client));
}
