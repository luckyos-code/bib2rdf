baseUri = http://example.org/bib/
target = target.bib

.INTERMEDIATE : bibtex2rdf.jar

translation: $(basename target).bib bibtex2rdf.jar
	java -jar bibtex2rdf.jar -schema schema.map -baseuri $(baseUri) -enc UTF-8 $(basename target).bib $(basename target).rdf
	rapper -i rdfxml -o turtle $(basename target).rdf > $(basename target).ttl
	rm $(basename target).rdf
	rm bibtex2rdf.log

bibtex2rdf.jar:
	wget https://www.l3s.de/~siberski/bibtex2rdf/bibtex2rdf.jar