Template to take notes, summarize class or scientific report.

This template is based from Thomas'Nifty Template on Typst's Discord server.
This is a template for Scientifique Report and class resume at ULB.

# Dependencies:

You will need to install rsvg-convert. You can install it using this command.

- sudo apt install librsvg2-bin

# Usage:

Right now all the emoji's are not rendered on pdf so you can compile the file in svg then
convert it to pdf
You can use the commande in the Makefile

```sh
make svg
```

> Note that you cannot select text inside the converted pdf or follow linkds.
> This should be used to print out the pdf.

# Advanced :

If you want to have a coherent preview of the file with emoji's while you are writting and staying with the pdf extension,
you can make a command to watch the file with svg format then open the converted version on your pdfviewer.

Don't know if it will work. It's just a theory.
