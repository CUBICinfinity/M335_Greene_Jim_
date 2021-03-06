```{r}
library(tidyverse)
library(stringr)
library(plyr)
```

read_lines("https://byuistats.github.io/M335/data/randomletters.txt") %>% 
  read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt") %>%
  
  ```{r}
nth_char <- function(string, start, distance){
  strsplit(string, split = "")[[1]][seq(start, nchar(string), by = distance)]
}

# if we have to be more specific: strsplit(text, split = "")[[1]][c(1, seq(0, 58000, by = 1700))]

# Example code:
# read_lines("https://byuistats.github.io/M335/data/randomletters.txt") %>% nth_char(0, 1700)
```

```{r}
# I think it would be good to add an if statement that allows for objects other than vectors; also perhaps make it so that we aren't just replacing individual characters

extract_replace <- function(string, extract, old_values = c(), new_values = c()) {
  extract <- paste(extract, collapse = "")
  if (length(new_values) == 0 || length(old_values) == 0) {
    extract <- paste("[", extract, "]{1,}", sep = "")
    str_extract_all(string, extract) %>% 
      unlist()
  } else {
    extract <- paste("[", extract, "]+", sep = "")
    str_extract_all(string, extract) %>% 
      unlist() %>% 
      plyr::mapvalues(., from = old_values, to = new_values)
  }
  
}

# Example code:
read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt") %>%
  extract_and_replace(c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9"), 1:26, LETTERS)

# Another example that doesn't work yet:
# extract_and_replace("favorite guy plaza 21 432 543 21", c("3", "a", "v", "2"))
```

```{r}
remove_chars <- function(string, char_vector){
  char_string <- paste(char_vector, collapse = "")
  char_string <- paste("[", char_string, "]", sep = "")
  gsub(char_string, '', string)
}

# example usage:
# remove_chars("abracadabra", c("a", "b"))
```

```{r}
longest_string <- function(vector, desc = T){
  vector[order(nchar(vector), vector, decreasing = desc)][1]
}

read_lines("https://byuistats.github.io/M335/data/randomletters.txt") %>% 
  remove_chars(c(" ", ".")) %>% 
  extract_replace(c("a", "e", "i", "o", "u")) %>% 
  longest_string()
```


```{r, eval = F}
vowel_chains <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt") %>% 
  str_extract_all('[a-zA-Z]{1,}') %>% 
  paste(collapse = "") %>% 
  str_extract_all('[aeiou]{1,}') %>% 
  unlist()
```

