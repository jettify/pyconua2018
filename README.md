# Verification of Concurrent and Distributed Systems

Building correct concurrent and distributed systems is hard and very challenging task also high complexity of such software increases the probability of human error in design and architecture. On practice standard verification techniques in industry are necessary but not sufficient. In my talk we will discuss formal specification and verification language that helps engineers design, specify, reason about and verify complex, real-life algorithms and software systems.


## Usage

Copy contents of repository to the separate folder, edit `slides.tex` then
compile it with `xlatex` using command:

```bash
$ make lint
$ make pdf
```

## Source code highlighting

Slides use `minted` package for source code highlighting, it depends on
`pygments`, TLA+ requires one more package.

```bash
$ mkvirtualenv slides
$ pip install pygments
$ pip install https://github.com/hwayne/tla-pygments/archive/master.zip
```
