baseUri = http://example.org/bib/
target = aksw.bib

.INTERMEDIATE : bibtex2rdf.jar

translation: $(basename $(target)).bib bibtex2rdf.jar
	cp $(basename $(target)).bib _$(basename $(target)).bib
ifeq ($(basename $(target)).bib, aksw.bib)
	sed -i -e 's/Rech, J., Decker, B., Ras, E./Rech, J. and Decker, B. and Ras, E./g' _$(basename $(target)).bib
	sed -i -e 's/Lule Ahmedi, Lavdim Halilaj, Gezim Sejdiu, Labinot Bajraktari/Lule Ahmedi and Lavdim Halilaj and Gezim Sejdiu and Labinot Bajraktari/g' _$(basename $(target)).bib
	sed -i -e 's/Magnus Knuth, Jens Lehmann, Dimitris Kontokostas, Thomas Steiner and Harald Sack/Magnus Knuth and Jens Lehmann and Dimitris Kontokostas and Thomas Steiner and Harald Sack/g' _$(basename $(target)).bib
	sed -i -e 's/H.Herre, R.Hoehndorf, J.Kelso, S.Schulz/H.Herre and R.Hoehndorf and J.Kelso and S.Schulz/g' _$(basename $(target)).bib
	sed -i -e 's/Chiara Ghidini, Axel-Cyrille Ngonga Ngomo, Stefanie N. Lindstaedt, Tassilo Pellegrini/Chiara Ghidini and Axel-Cyrille Ngonga Ngomo and Stefanie N. Lindstaedt and Tassilo Pellegrini/g' _$(basename $(target)).bib
endif
	java -jar bibtex2rdf.jar -schema schema.map -baseuri $(baseUri) -enc UTF-8 _$(basename $(target)).bib $(basename $(target)).rdf
	rapper -i rdfxml -o turtle $(basename $(target)).rdf > $(basename $(target)).ttl
	rm _$(basename $(target)).bib
	rm $(basename $(target)).rdf
	rm bibtex2rdf.log

bibtex2rdf.jar:
	wget https://www.l3s.de/~siberski/bibtex2rdf/bibtex2rdf.jar