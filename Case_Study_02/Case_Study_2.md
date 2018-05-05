---
title: "Case Study 2: Wealth and Life Expectancy (Gapminder)"
author: "Jim Greene"
date: "May 4, 2018"
output: 
  html_document:
    theme: default
    keep_md: true
    code_folding: hide
---



# Background

The Gapminder dataset was used by Hans Rosling in his 2006 [TED talk](https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen). I used it to recreate the plots below. Making animations will have to wait. This project allowed me to better understand the tidyverse functions, including group_by(), summarize(), and piping or joining functions to others. The most important thing I learned is how much easier ggplot is than base R and how much I can produce as I get used to it.

# Plots


```r
ggplot(data = filter(gapminder, country != "Kuwait")) +
  theme_bw() +
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap, color = continent, size = pop/1000000)) +
  scale_y_continuous(trans = "sqrt") +
  facet_wrap( ~ year, nrow = 1) +
  labs(x = "Life Expectancy", y = "GDP Per Capita", color = "Continent", size = "Population (Millions)")
```
![](images/LifeExpectancy.png)



```r
gapminder2 <- filter(gapminder, country != "Kuwait") %>%
  group_by(year, continent) %>% 
  mutate(wm = weighted.mean(gdpPercap, pop))

filter(gapminder, country != "Kuwait") %>%
  ggplot() +
  theme_bw() +
  geom_point(mapping = aes(x = year, y = gdpPercap, color = continent, size = pop/1000000)) +
  facet_wrap( ~ continent, nrow = 1) +
  geom_line(mapping = aes(x = year, y = gdpPercap, color = continent, group = country)) +
  ylim(0,50000) + 
  labs(x = "Year", y = "GDP Per Capita", color = "Continent", size = "Population (Millions)") +
  geom_point(data = gapminder2, mapping = aes(x = year, y = wm, size = pop/1000000)) + 
  geom_line(data = gapminder2, mapping = aes(x = year, y = wm))
```
![](images/ContinentGDP.png)
