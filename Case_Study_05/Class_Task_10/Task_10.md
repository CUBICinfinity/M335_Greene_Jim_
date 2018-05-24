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

Showing a table of returns for DJIA

```r
dart$month_end <- gsub("Dec.", "December", dart$month_end)
dart$month_end <- gsub("Decembermber", "December", dart$month_end)
dart$month_end <- gsub("Febuary", "February", dart$month_end)

filter(dart, variable == "DJIA") %>% 
  spread(key = year_end, value = value) %>% 
  select(-variable) %>% 
  pander()
```


----------------------------------------------------------------------------
 month_end   1990    1991   1992   1993   1994   1995   1996   1997   1998  
----------- ------- ------ ------ ------ ------ ------ ------ ------ -------
   April      NA     16.2   10.6   5.8    0.5    12.8   14.8   15.3   22.5  

  August     -2.3    4.4    -0.3   7.3    1.5    15.3   0.6    8.3    -13.1 

 December    -9.3    6.6    0.2     8     3.6    9.3    15.5   -0.7    NA   

 February     NA      11    8.6    2.5    5.5    3.2    15.6   20.1   10.7  

  January     NA     -0.8   6.5    -0.8   11.2   1.8     15    19.6   -0.3  

   July      11.5    7.6    4.2    3.7    -5.3   19.6   1.3    20.8    7.1  

   June       2.5    17.7   3.6    7.7    -6.2    16    10.2   16.2    15   

   March      NA     15.8   7.2     9     1.6    7.3    18.4   9.6     7.6  

    May       NA     17.3   17.6   6.7    1.3    19.5    9     13.3   10.6  

 November    -12.8   -3.3   -2.8   4.9    -0.3   13.1   15.1   3.8     NA   

  October    -8.5    4.4     -5    5.7    6.9    8.2    7.2     3      NA   

 September   -9.2    3.4    -0.1   5.2    4.4     14    5.8    20.2   -11.8 
----------------------------------------------------------------------------
This is a nice way to prepare the data for a human to view. February and December appear with various spellings, so I needed to fix them. There must be a more elegant way to do so. I haven't bothered to rearrange the months, but that is something I should practice.

</br>

When experimenting with spread I discovered that tidyr::spread has a problem with duplicate values because it tries to condense rows as much as possible. One work around is group_by(column_with_duplicates) %>% do(tibble::rowid_to_column(.)) %>% .
