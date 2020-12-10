library(devtools)

child <- ourworldindata::child_mortality

filter(child, year > 1995 & continent == 'Africa') %>%
  #group_by(continent) %>%
  ggplot() +
  geom_point(mapping = aes(year, child_mort, size = population, color = "blue")) +
  geom_line(mapping = aes(year, child_mort, color = "blue", group = country)) +
  geom_line(mapping = aes(year, health_exp/4, color = "red", group = country, size = 2)) + 
  theme(legend.position="none")

#+   facet_wrap( ~ country)


#+ geom_line(mapping = aes(year, health_exp, color = "blue", group = country))




filter(child, year > 1995 & continent != 'NA') %>%
  group_by(year, continent) %>% 
  mutate(wm = weighted.mean(child_mort, population)) %>%
  ggplot() +
  theme_bw() +
  geom_point(mapping = aes(x= year, y= wm, size = population, color = continent)) +
  geom_line(mapping = aes(x= year, y= wm, color = continent))

  #facet_wrap( ~ continent)
  
#
#   #+ geom_line(mapping = aes(year, health_exp, color = "blue", group = coun


# filter(child, year > 1995) %>%
#   group_by(year, continent) %>% 
#   mutate(wm = weighted.mean(child_mort, population)) %>%
#   ggplot() +
#   theme_bw() +

# filter(gapminder, country != "Kuwait") %>%
#   ggplot() +
#   theme_bw() +
#   geom_point(mapping = aes(x = year, y = gdpPercap, color = continent, size = pop/1000000)) +
#   facet_wrap( ~ continent, nrow = 1) +
#   geom_line(mapping = aes(x = year, y = gdpPercap, color = continent, group = country)) +
#   ylim(0,50000) + 
#   labs(x = "Year", y = "GDP Per Capita", color = "Continent", size = "Population (Millions)") +
#   geom_point(data = gapminder2, mapping = aes(x = year, y = wm, size = pop/1000000)) + 
#   geom_line(data = gapminder2, mapping = aes(x = year, y = wm))
