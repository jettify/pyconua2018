# Slides Template

LaTeX template for my presentations, using Beamer with Metropolis theme.


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
