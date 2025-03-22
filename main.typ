#import "config.typ": *

#show: template

= Introduction <intro>

#lorem(50)

#definition[Title][
    This is a definition
]<def:ref>

#theorem[Title][
    Theorem
][Oops this is a footer]<thm:ref>

#proof[Title][
    This is a proof
]<prf:ref>

#example[Title][
    This is an example
]<exm:ref>

#proposition[Title][
    This is a proposition
]<prop:ref>

#corollary[Title][
    This is a corollary
]<cor:ref>

#lemma[Title][
    This is a lemma
]<lem:ref> 

#remark(breakable: false)[Title][
    This is a remark
]<rem:ref> 

#notation[Title][
    This is a notation
]<not:ref> 

#warning[Title][
    This is a warning
]<warn:ref> 

= New section

#warning(breakable: false, color: gray, icon: emoji.firecracker)[This is a new Warning][Content]

I can refer to the definition like this: @def:ref


#bibliography("./bibliography.bib", full: true)
