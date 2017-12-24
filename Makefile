PDF2LATEX = pdflatex
XELATEX = xelatex
SHOWPDF = open
PDF2PS = pdf2ps
PS2PDF = ps2pdf

default: pdf

pdf:
	@echo "This Makefile generates pdf for *.tex"
	@$(XELATEX) slides.tex
	@$(SHOWPDF) slides.pdf

clean:
	rm -v -f *~ *.aux *.ps *.log *.dvi *.idx *.ilg *.ind *.toc *.nlo *.nls *.out *.backup

compress:
	@echo "Compressing pdf"
	@$(PDF2PS) slides.pdf slides.ps
	@$(PS2PDF) slides.ps slides.pdf
