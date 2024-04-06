.PHONY: main svg # To make the svg and main compile no matter what
pdf:
	- typst compile main.typ

svg:
	- typst compile  --format svg main.typ svg/main-{n}.svg
	- rsvg-convert -f pdf -o mainsvg.pdf svg/*
