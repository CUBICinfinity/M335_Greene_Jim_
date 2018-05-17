---
title: "Firearms Data Sources"
author: "Jim Greene"
date: "May 17, 2018"
output: 
  html_document:
    theme: flatly
    keep_md: true
    code_folding: hide
---
<hr>




# {.tabset .tabset-fade}

## NICS Background Checks

#### Link: [BuzzFeed, NICS Background Checks](https://github.com/BuzzFeedNews/nics-firearm-background-checks)

Information on background checks with firearm purchases through NICS.</br>
This data set has limitations including that it is only the purchases through NICS and that the laws vary from one state to the other. It might still be useful because it includes details about the types of weapons purchased. I will want to split the date column into a month and a year column.

</br>

#### Using the data

I learned from Dallin that a quick way to read in a data frame from the internet is by putting the url to the raw file in the read_csv() function:</br>
nics <- read_csv("https://raw.githubusercontent.com/BuzzFeedNews/nics-firearm-background-checks/master/data/nics-firearm-background-checks.csv")

I want to create month and year columns:</br>

nics <- nics %>% 
  separate(month, c("m", "y"), "-")


```r
nics %>%
  group_by(state) %>% 
  ggplot(mapping = aes(as.factor(state), as.numeric(permit))) +
  geom_point()
```

```
## Warning: Removed 24 rows containing missing values (geom_point).
```

![](Firearms_Data_Sources_-_Task_8_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
nics %>%
  ggplot(mapping = aes(totals, multiple)) +
  geom_point()
```

![](Firearms_Data_Sources_-_Task_8_files/figure-html/unnamed-chunk-1-2.png)<!-- -->

</br>

## Guns Poll Quiz

#### Link: [FiveThirtyEight, Guns Poll Quiz](https://github.com/fivethirtyeight/data/tree/master/poll-quiz-guns)

This is an opinion poll that took place February-March 2018.</br>
It has a nice variety of questions and can provide useful background information. I don't particularly like polls however, because they are unlikely correctly represent the population. I wouldn't rely on the data for an analysis.

#### Using the data

poll <- read_csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/poll-quiz-guns/guns-polls.csv")

</br>

## 538's Report on Gun Deaths

#### Link: [data.world, 538's Report on Gun Deaths](https://data.world/azel/gun-deaths-in-america)

The details about race and age will be helpful because a part of the motivation of my project is to determine what firearm laws are recommendable. There is also a column indicating the location of the incident (home, street, etc.). These details would prompt me to putt in other data sets so that I can compare for example, the proportion of people in the US with bachelor's degrees.
This is the same data set that is used in Case Study 4, but I found it on my own. The source includes a lot of useful R scripts examples.

</br>

## List of Countries by Firearm-Related Death Rate

#### Link: [Wikipedia, List of Countries by Firearm-Related Death Rate](https://en.wikipedia.org/wiki/List_of_countries_by_firearm-related_death_rate)

Summaries pulled from Gunpolicy.org</br>
This one is really useful. It includes gun related death rates along with the number of guns people own which is exactly the kind of thing I am looking for.</br>
I found it through this project: https://data.world/pshaff/gun-ownership
