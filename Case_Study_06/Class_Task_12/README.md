notes

stringr not in tidyverse

single and double quotes both work.

use writeLines() to print as text formatted

ay character with "\\u####"

str_length() obvious

str_c("x", "y") returns one string : "xy"
see more arguments: sep = "inbetween stuff"

str_replace_na(vector) use it to replace NAs with "NA""

collaspe = "stuff" collapses vectors

str_sub(x, -3, -1)

str_to_lower()
str_to_upper() can combine with locale =
str_to_title()

str_sort() also locales
str_order()

paste() and paste0()

----

str_view is a search. add , ".a." (must use \\. for .) matching literal \\ requires \\\\\\\\
^ matches start $ for end
power -> money

\\b is for word boundaries


match any whitespace: \\s
match any digit: \\d
match any [letters]
match any but [^letters]
match or |
str_view(c("grey", "gray"), "gr(e|a)y")

?: 0 or 1
+: 1 or more
*: 0 or more
colou?r
bana(na)+
{n}: exactly n
{n,}: n or more
{,m}: at most m
{n,m}: between n and m *Uses the longest sting possible. if you add ? after the } you get the shortest selections.

\\n backreference:
str_view(fruit, "(..)\\1", match = TRUE)

----

x <- c("apple", "banana", "pear")
str_detect(x, "e")
#> [1]  TRUE FALSE  TRUE
# can combine there with sum or mean etc
use ! to reverse
str_count() gives the number in each string rather than T/F

str_extract() returns the matching test rather than just finding it. Extremely useful

str_replace() and str_replace_all()


crazy combinations can be done:
sentences %>% 
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% 
  head(5)
  
str_split()
you can use simplify = TRUE to return a matrix:
fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)

, boundary("") takes word, sentence, line, character

str_sub()
str_locate()

ignore_case = TRUE
multiline = TRUE # makes ^ and $ be for lines

comments = TRUE #you can use # to add commente

see rest in chapter 14