Template to take notes, summarize class or scientific report. You can directly click on the button "Use this template" as it will create a repo.

This template is based from Thomas'Nifty Template on Typst's Discord server.
This is a template for Scientifique Report and class resume at ULB.

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

If you want to split the document in multiple files you can use the `#include` directive in the `main.typ` file.

```typst
#include "introduction.typ"
```

and make sure to add the `#import "config.typ": *` in the new file.


# Issues:

- The captions of figures are not rendered inside a box.
- The ref of a figure of a section is not well written e.g fig 3.1 is ref as Fig1.
- Tables of figures not working anymore

# TODO:

- Fix issues
- Remove i-figured dependency, maybe use rich-counter
- Maybe add equate library for maths equations 
- Maybe add wrap-it library to easily wrap text around figures
- Make the box kinds state
- Make colorfull headings using colors, forms, special positions, fonts, etc...
- Make a better preface by adding colors, image of ulb's building
- Add preamble
- Make page numbers colorfulls (add forms, colors)
- Make better headers and footer, cleaner
- Add a way to rapidly create code, graphs, automaton
- clean code
- Make it a local package
- Add support for english (box, months, figures)

# Pull from the template

- `git remote add template "https://github.com/JustRayCB/ULBTemplate"`
- `git fetch template`
- `git merge template/master --allow-unrelated-histories`
