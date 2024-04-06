.PHONY: main png# To make the svg and main compile no matter what
pdf:
	- typst compile main.typ

png:
	- mkdir -p png
	- typst compile  --format png main.typ png/main-{n}.png
	- convert png/* mainpng.pdf
clean:
	- rm -rf png 
	- rm -f mainpng.pdf
