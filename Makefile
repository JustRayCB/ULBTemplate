main: 
	typst compile main.typ

watch:
	typst watch --open evince main.typ main.pdf

