#!/bin/sh

for i in 05 06 08 09 12 15 18 24 S05 S09 S10 S12 S15 S18 S24 L05 L09 L10 L12 L15 L18 L24; do
	echo "Generating lm78$i.sym"
	cp lm78xx.sym lm78$i.sym
	sed -i s/78xx/78$i/ lm78$i.sym
done

for i in 75 76; do
	echo "Generating lm25$i-1.sym"
	cp lm25xx-1.sym lm25$i-1.sym
	sed -i s/LM25xx/LM25$i/ lm25$i-1.sym

	echo "Generating lm25$i-2.sym"
	cp lm25xx-2.sym lm25$i-2.sym
	sed -i s/LM25xx/LM25$i/ lm25$i-2.sym
done
