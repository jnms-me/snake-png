# snake-png

A snake game that outputs a stream of png images for usage in a led matrix.

See [out.png](out.png) for an example.

Run using `dub` with either `feh out.png -R 1` runnning or `out.png` open in vscode to test locally.
Optionally takes a `host:port/path` as argument to send the images to via http `POST`.
