PDF2LATEX = pdflatex
XELATEX = xelatex
SHOWPDF = open
PDF2PS = pdf2ps
PS2PDF = ps2pdf
CHKTEX = chktex
LACHECK = lacheck

default: lint pdf open

pdf:
	@echo "This Makefile generates pdf for *.tex"
	@$(XELATEX) slides.tex

open:
	@$(SHOWPDF) slides.pdf

clean:
	rm -v -f *~ *.aux *.ps *.log *.dvi *.idx *.ilg *.ind *.toc *.nlo *.nls \
		*.out *.backup *.xdv *.snm  *.nav *.fls *.bbl *.blg *.fdb_latexmk

compress:
	@echo "Compressing pdf"
	@$(PDF2PS) slides.pdf slides.ps
	@$(PS2PDF) slides.ps slides.pdf

lint:
	@$(CHKTEX) slides.tex
