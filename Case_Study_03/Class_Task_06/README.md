 chpt 6
 
 ctrl/cmd + shft+ N makes r script
 
 ctrl + ENTER does run
 
 ctrl+shft+S = run all
 
when sharing include libraries, bt not
settings

get used to shortcuts


ctrl+sft+A formats automatically


chpt 11

read_csv("a,b,c
1,2,3
4,5,6") creates a tibble manually

", skip = 3)" is useful

first row is treat as headings unless col_names = FALSE

use \n or enter for new line (row)

define what is read as na: na = ""

+++++++++
data.table::fread()
could be used
+++++++++

read_csv() pretty much always better than read.csv()

I don't see what the issue is with
read_csv("a,b\n1,2\na,b")

+++++
parsing:

parse_double("1,23", locale = locale(decimal_mark = ","))

parse_number("123.456.789", locale = locale(grouping_mark = "."))


parse_character(x1, locale = locale(encoding = "Latin1"))
#> [1] "El Niño was particularly bad this year"
parse_character(x2, locale = locale(encoding = "Shift-JIS"))
#> [1] "こんにちは"

guess_encoding(charToRaw(x1))

++
time

library(hms)
parse_time("01:10 am")
#> 01:10:00
parse_time("20:10:01")
#> 20:10:01

11.3.4 has list of elements

parse_date("01/02/15", "%d/%m/%y")
#> [1] "2015-02-01"

parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))
#> [1] "2015-01-01"

++
search "To fix the call" to see how to fix difficult datasets

it's best to always supply col_types

use n_max when testing probs if it's big.

++
write:

write_csv(challenge, "challenge.csv")

write_rds(challenge, "challenge.rds")

#WORKS ACROSS PROGRAMMING LANGUAGES:
library(feather)
write_feather(challenge, "challenge.feather")
read_feather("challenge.feather")




