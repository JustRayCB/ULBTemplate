Template to take notes, summarize class or scientific report.

This template is based from Thomas'Nifty Template on Typst's Discord server.
This is a template for Scientifique Report and class resume at ULB.

# Dependencies:

You will need to install imagemagick to convert it to png then to pdf to be able to have the emojis.
You can install it using this command.

- sudo apt install imagemagick

# Getting Started:

To use this template juste start with a `main.typ` file with this basic configuration:

```typst
#import "config.typ": *

#show: template

= Introduction <intro>
#lorem(50)


// #bibliography("./bibliography.bib")
```

If you want to add new boxes or change the cover-page see the `config.typ` file

# Makefile usage:

Right now all the emoji's are not rendered on pdf so you can compile the file in png then
convert it to pdf
You can use the commande in the Makefile

```sh
make png
```

> Note that you cannot select text inside the converted pdf or follow linkds.
> This should be used to print out the pdf.

# TODO

- Fix annexes
- Supervisor only on first page
- Fix Numbering of maths equations
- Fix Numbering of figures
