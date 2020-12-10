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
strsplit(text, split = "")[[1]][c(1, seq(0, 58000, by = 1700))]
```

```
##  [1] "t" "h" "e" " " "p" "l" "u" "r" "a" "l" " " "o" "f" " " "a" "n" "e"
## [18] "c" "d" "o" "t" "e" " " "i" "s" " " "n" "o" "t" " " "d" "a" "t" "a"
## [35] "."
```



```r
read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt") %>%
  str_extract_all('[0123456789]+') %>% 
  unlist() %>% 
  plyr::mapvalues(., from = 1:26, to = letters)
```

```
## The following `from` values were not present in `x`: 2, 3, 9, 11, 12, 17, 22, 23, 25, 26
```

```
##  [1] "e" "x" "p" "e" "r" "t" "s" "o" "f" "t" "e" "n" "p" "o" "s" "s" "e"
## [18] "s" "s" "m" "o" "r" "e" "d" "a" "t" "a" "t" "h" "a" "n" "j" "u" "d"
## [35] "g" "m" "e" "n" "t"
```


```r
vowel_chains <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt") %>% 
  str_extract_all('[a-zA-Z]{1,}') %>% 
  paste(collapse = "") %>% 
  str_extract_all('[aeiou]{1,}') %>% 
  unlist()

lengths <- c(rep(0,length(vowel_chains)))
i <-  0
for (string in vowel_chains) {
  i <- i + 1
  lengths[i] <- nchar(string)
}
tibble(vowel_chains, lengths) %>% 
  arrange(desc(lengths))
```

```
## # A tibble: 10,266 x 2
##    vowel_chains lengths
##    <chr>          <dbl>
##  1 oaaoooo           7.
##  2 iieuai            6.
##  3 iuiuie            6.
##  4 auouia            6.
##  5 eaeui             5.
##  6 ouuea             5.
##  7 uaeii             5.
##  8 eueo              4.
##  9 oouo              4.
## 10 aiae              4.
## # ... with 10,256 more rows
```

