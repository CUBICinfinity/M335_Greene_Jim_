


----------

CHAPTR 12

----------

Tidy Data is similar to normal forms in a database

count(var, wt = var)  wt is the weight to use

----------

GATHER

table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
  
back ticks are needed around the numbers

left_join(tidy4a, tidy4b)

----------

SPREAD

spread(table2, key = type, value = count)

----------

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)
  
  
# A tibble: 4 x 3
   year  half return
  <dbl> <dbl>  <dbl>
1 2015.    1.  1.88 
2 2015.    2.  0.590
3 2016.    1.  0.920
4 2016.    2.  0.170


# A tibble: 2 x 3
   half `2015` `2016`
  <dbl>  <dbl>  <dbl>
1    1.  1.88   0.920
2    2.  0.590  0.170


# A tibble: 4 x 3
   half year  return
  <dbl> <chr>  <dbl>
1    1. 2015   1.88 
2    2. 2015   0.590
3    1. 2016   0.920
4    2. 2016   0.170

----------

SEPARATE and UNITE

table3 %>% 
  separate(rate, into = c("cases", "population"))
  
to be explicit: into = c("cases", "population"), sep = "/")

, convert = TRUE) automatically fixes the types (ex. chr to int)

you can hav a vetor of numbers:
separate(year, into = c("century", "year"), sep = 2)

~~~

table5 %>% 
  unite(new, century, year, sep = "")

see ?separate

----------

Make missing values implicit:

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

Make them explicit:

stocks %>% 
  complete(year, qtr) #pretty simple
  
----------

Here NA is used as dittos:

treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

treatment %>% 
  fill(person) #will fix that.
  
fill(data, ..., .direction = c("down", "up"))

----------

challenge: who

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)
  
===~~~+++===~~~+++===~~~+++===
Old version of code: useful for the future
"Spreading the data (if I needed to)
```{r}
dart %>%
  group_by(value) %>% 
  do(tibble::rowid_to_column(.)) %>% 
  spread(key = year_end, value = month_end) %>% 
  select(-rowid)
```
Aparently tidyr::spread has a problem with duplicate values because it tries to condense rows as much as possible. The value column (Which I would rather call "return" and not "value". I could have used colnames(dart)[4] <- "return" to do that.) has just a couple duplicates. My code was the best solution I found based on reading about the problem online."
