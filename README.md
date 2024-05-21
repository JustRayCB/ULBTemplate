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

If you want to split the document in multiple files you can use the `#import` directive.

```typst
#include "introduction.typ"
```

and make sure to add the `#import "config.typ": *` in the new file.

# Makefile usage:

Right now all the emoji's are not rendered on pdf so you can compile the file in png then
convert it to pdf
You can use the commande in the Makefile

```sh
make png
```

> Note that you cannot select text inside the converted pdf or follow linkds.
> This should be used to print out the pdf.

On the other hand, if you have typst svg-emoji installed locally, you could just add these two line
in you `main.typ`:

```typ
/*  Only if you have it installed locally */
#import "@local/svg-emoji:0.1.0": setup-emoji, github
#show: setup-emoji
```

# Issues:

- The emojis are not rendered on the pdf file.
- The captions of figures are not rendered inside a box.
- The ref of a figure of a section is not well written e.g fig 3.1 is ref as Fig1.

# TODO:

- Fix issues
- Remove i-figured dependency
- Make the box kinds state
