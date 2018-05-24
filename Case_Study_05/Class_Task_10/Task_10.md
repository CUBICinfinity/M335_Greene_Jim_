---
title: "Task 10"
author: "Jim Greene"
date: "May 24, 2018"
output: 
  html_document:
    theme: readable
    keep_md: true
    code_folding: none
---


### Data Wrangling


</br>

Tidying the data

```r
dart <- filter(dart, contest_period != "Average") %>%
  separate(contest_period, into = c("junk", "period"), sep = "-") %>%
  select(-junk) %>% 
  separate(period, c("month_end", "year_end"), sep = -4) %>% 
  write_rds("darts.rds")

read_rds("darts.rds")
```

```
## # A tibble: 300 x 4
##    month_end year_end variable  value
##    <chr>     <chr>    <chr>     <dbl>
##  1 June      1990     PROS      12.7 
##  2 July      1990     PROS      26.4 
##  3 August    1990     PROS       2.50
##  4 September 1990     PROS     -20.0 
##  5 October   1990     PROS     -37.8 
##  6 November  1990     PROS     -33.3 
##  7 December  1990     PROS     -10.2 
##  8 January   1991     PROS     -20.3 
##  9 February  1991     PROS      38.9 
## 10 March     1991     PROS      20.2 
## # ... with 290 more rows
```
</br>There was an "Average" entry for contest_period for each variable (DARTS, DJIA, PROS). There is no useful place for those rows so I removed them. All the other rows have a hyphen before the usefull information, which made things easier.




</br>

Plotting by year

```r
dart %>% 
  ggplot(aes(year_end, value)) +
  geom_boxplot(fill = "#666666")
```

![](Task_10_files/figure-html/unnamed-chunk-3-1.png)<!-- -->
</br>This is a simple boxplot to show the returns by year. I didn't try to add more information than needed.

</br>

Spreading the data (if I needed to do that)

```r
dart %>%
  group_by(value) %>% 
  do(tibble::rowid_to_column(.)) %>% 
  spread(key = year_end, value = month_end) %>% 
  select(-rowid)
```

```
## # A tibble: 300 x 11
## # Groups:   value [223]
##    variable value `1990`  `1991` `1992` `1993` `1994` `1995` `1996` `1997`
##    <chr>    <dbl> <chr>   <chr>  <chr>  <chr>  <chr>  <chr>  <chr>  <chr> 
##  1 DARTS    -43.0 <NA>    <NA>   <NA>   July   <NA>   <NA>   <NA>   <NA>  
##  2 DARTS    -37.3 <NA>    Janua~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
##  3 DARTS    -34.2 <NA>    <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
##  4 DARTS    -27.4 Novemb~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
##  5 DARTS    -23.2 <NA>    Novem~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
##  6 DARTS    -22.5 Decemb~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
##  7 DARTS    -21.4 <NA>    <NA>   <NA>   Novem~ <NA>   <NA>   <NA>   <NA>  
##  8 DARTS    -20.4 <NA>    <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
##  9 DARTS    -17.7 <NA>    <NA>   <NA>   Septe~ <NA>   <NA>   <NA>   <NA>  
## 10 DARTS    -16.9 <NA>    <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   March 
## # ... with 290 more rows, and 1 more variable: `1998` <chr>
```
Aparently tidyr::spread has a problem with duplicate values because it tries to condense rows as much as possible. The value column (Which I would rather call "return" and not "value". I could have used colnames(dart)[4] <- "return" to do that.) has just a couple duplicates. My code was the best solution I found based on reading about the problem online.
