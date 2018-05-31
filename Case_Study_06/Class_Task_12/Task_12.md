---
title: "TASK 12"
author: "Jim Greene"
date: "May 31, 2018"
output: 
  html_document:
    theme: default
    keep_md: true
    code_folding: hide
---







```r
text <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt")
strsplit(text, split = "")[[1]][seq(0, 58000, by = 1700)]
```

```
##  [1] "h" "e" " " "p" "l" "u" "r" "a" "l" " " "o" "f" " " "a" "n" "e" "c"
## [18] "d" "o" "t" "e" " " "i" "s" " " "n" "o" "t" " " "d" "a" "t" "a" "."
```



