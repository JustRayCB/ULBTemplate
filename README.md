# ULB Typst Template
> This template is based from Thomas'Nifty Template on Typst's Discord server. 
> Cover and back ground pages where modified from this template #[silky-report-insa](https://typst.app/universe/package/silky-report-insa) 
One Typst template for ULB students who want to write:

- course summaries and lecture notes
- standard reports
- project or capstone reports with a back cover

The template is designed around a simple workflow:

1. Edit `config.typ`
2. Write your content in `main.typ`
3. Compile the document

## Repository Layout

- `config.typ`: main configuration file for everyday use
- `main.typ`: default document entrypoint
- `ulb/template.typ`: internal template implementation
- `ulb/layout.typ`: cover, header, footer, and page layout logic
- `ulb/boxes.typ`: theorem / definition / remark box rendering
- `examples/report.typ`: standalone report example
- `examples/project.typ`: standalone project example

## Quick Start

The default entrypoint is:

```typst
#import "config.typ": *

#show: template

= Introduction

#lorem(50)
```

Compile with Typst:

```bash
typst compile main.typ
```

Or use the provided `Makefile`:

```bash
make main
make watch
```

`make watch` runs:

```bash
typst watch --open evince main.typ main.pdf
```

## Basic Workflow

For most users, only two files matter:

### 1. Edit `config.typ`

Set the document metadata and layout options:

```typst
#let document-type = "summary"
#let language = "en"
#let title = "Ray's Template"
#let subtitle = "Course summary"
#let authors = ("Ray",)
#let course-code = "INFO-F530"
#let course-name = "Advanced topics in machine learning"
```

### 2. Write your content in `main.typ`

```typst
#import "config.typ": *

#show: template

= Introduction

This is my summary.
```

## Document Types

Set `document-type` in `config.typ`:

- `"summary"`: lecture notes or a course summary
- `"report"`: a standard academic report
- `"project"`: a project / capstone / PFE-style document

The template changes the cover, header, footer labeling, and default back-cover behavior based on this value.

## Configuration Guide

### Main fields

These are the fields most users should edit first:

- `document-type`
- `language`
- `title`
- `subtitle`
- `authors`
- `date`

### Course fields

Useful for summaries and reports:

- `course-code`
- `course-name`
- `teachers`

### Structure fields

- `show-outline`: show the table of contents
- `show-figure-outline`: show lists of figures / tables / custom boxes
- `pagebreak-before-level-1-headings`: start each level-1 section on a new page
- `first-line-indent`: first-line paragraph indentation

Default in `config.typ`:

```typst
#let pagebreak-before-level-1-headings = document-type == "summary"
```

This means summaries start each top-level section on a new page by default, but reports and projects do not.

### Project-only fields

These matter mainly for `document-type: "project"`:

- `department`
- `organization`
- `organization-logo`
- `supervisors`
- `summary-left`
- `summary-right`
- `show-back-cover`

`summary-left` and `summary-right` are used on the back cover layout.

### Advanced layout fields

- `cover-design`
- `custom-header`
- `custom-footer`

Supported `cover-design` values:

- `auto`
- `standard`
- `highlighted`
- `project`
- `classic`

Behavior of `cover-design: auto`:

- `summary` -> `standard`
- `report` -> `standard`
- `project` -> `project`

## Header and Footer

### Header

The running header is generated automatically:

- `summary`: ULB square logo on the left, current section on the right
- `report` / `project`: short document title on the left, current section on the right

You can override it:

```typst
#let custom-header = [My Custom Header]
```

Or disable it:

```typst
#let custom-header = none
```

### Footer

By default, the footer uses:

- left: short identifier
- center: empty
- right: ULB page badge

Default left footer content:

- `summary`: `course-code`
- `report` / `project`: `title`

You can override it:

```typst
#let custom-footer = [Confidential Draft]
```

Or remove the left footer content while keeping the page badge:

```typst
#let custom-footer = none
```

## Boxes

The template provides preconfigured box macros:

- `#definition`
- `#theorem`
- `#proof`
- `#example`
- `#proposition`
- `#corollary`
- `#lemma`
- `#remark`
- `#notation`
- `#warning`

### Basic usage

```typst
#definition[Compactness][
  A set is compact if every open cover admits a finite subcover.
]<def:compact>

See @def:compact.
```

### Without a title

```typst
#remark[
  This is an untitled remark.
]<rem:short>
```

### With extra styling options

```typst
#warning(breakable: false, color: gray, icon: emoji.firecracker)[Careful][
  This warning uses a custom color and icon.
]
```

### Boxes with footers

Some box kinds based on `popup` accept a third content block:

```typst
#theorem[Pythagoras][
  In a right triangle, $a^2 + b^2 = c^2$.
][Used constantly in geometry.]<thm:pythagoras>
```

## Box Colors and Presets

The default box palette is configured in `config.typ`:

```typst
#let box-colors = (
  definition: teal,
  theorem: blue,
  proof: color.eastern,
  example: orange,
  proposition: maroon,
  corollary: yellow,
  lemma: aqua,
  remark: lime,
  notation: purple,
  warning: red,
)
```

If you want a different visual style, change these color values in `config.typ`.

## Extra Helper Macros from `config.typ`

The config file also provides a few small helpers:

### `#indent()`

```typst
#indent()
This manually adds one paragraph indent width.
```

### `#noindent()`

```typst
#noindent()
This cancels one paragraph indent width.
```

### `#unnumbered[...]`

```typst
#unnumbered[
  = Acknowledgements
]
```

Use this when you want a heading without numbering.

## Figures, Tables, and Equations

The template already configures:

- numbered headings
- section-based figure numbering
- section-based equation numbering
- bold references for internal links and labels

Example:

```typst
= Results

#figure(
  rect(width: 70%, height: 3cm, fill: luma(235)),
  caption: [Illustrative result placeholder],
)<fig:result>

See @fig:result.
```

## Bibliography

The default `main.typ` already includes:

```typst
#bibliography("./bibliography.bib", full: true)
```

So if you want references, add entries to `bibliography.bib` and cite them normally in Typst.

## Example Configurations

### Example 1: Summary

Use the default `config.typ` style:

```typst
#let document-type = "summary"
#let language = "en"
#let title = "Calculus Summary"
#let subtitle = "2025-2026"
#let authors = ("Alice",)
#let course-code = "MATH-F-101"
#let course-name = "Calculus"
#let teachers = ("Prof. Example",)
#let show-outline = true
#let pagebreak-before-level-1-headings = true
```

### Example 2: Report

Standalone version:

```typst
#import "ulb/template.typ": Template

#show: Template.with(
  document-type: "report",
  language: "en",
  title: "Lab Report",
  subtitle: "Optics experiment",
  authors: ("Jane Doe", "John Doe"),
  date: datetime.today(),
  course-code: "PHYS-F-101",
  course-name: "Experimental Physics",
  teachers: ("Prof. Example",),
  show-outline: true,
)
```

There is a full working file in `examples/report.typ`.

### Example 3: Project

```typst
#import "ulb/template.typ": Template

#show: Template.with(
  document-type: "project",
  language: "en",
  title: "ULB Capstone Project",
  subtitle: "Applied machine learning",
  authors: ("Jane Doe",),
  date: datetime.today(),
  department: "Computer science engineering",
  organization: "Universite Libre de Bruxelles",
  organization-logo: image("ulb/assets/logos/logo-square.png", width: 2.4cm),
  supervisors: ("Prof. Example", "Dr. Sample"),
  show-outline: true,
  summary-left: [
    = Executive Summary
    #lorem(90)
  ],
  summary-right: [
    = Abstract
    #lorem(90)
  ],
)
```

There is a full working file in `examples/project.typ`.

## Compiling the Examples

From the repository root:

```bash
typst compile --root . examples/report.typ
typst compile --root . examples/project.typ
```

## Customization Checklist

If you want to adapt the template quickly, these are the main knobs:

1. Change `document-type`
2. Fill `title`, `authors`, and `date`
3. Set `course-code` / `course-name` or project metadata
4. Turn `show-outline` on or off
5. Decide whether `pagebreak-before-level-1-headings` should be `true` or `false`
6. Choose a `cover-design` if `auto` is not what you want
7. Adjust `box-colors` if you want a different palette

## Migration Notes

The public configuration was simplified around labeled fields in `config.typ`.

Old names to new names:

- `ue` -> `course-code`
- `subject` -> `course-name`
- `toc` -> `show-outline`
- `fig_toc` -> `show-figure-outline`

The box call style was intentionally kept simple.

## Notes

- `ulb-report/` is kept in the repository as reference material, but the main template does not depend on it at runtime.
- Remaining Typst warnings currently come from upstream packages such as `codly` and `octique`, not from the main template code.
