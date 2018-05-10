library(devtools)

child <- ourworldindata::child_mortality

# filter(child, year > 1995 & continent == 'Africa') %>%
#   #group_by(continent) %>%
#   ggplot() +
#   geom_point(mapping = aes(year, child_mort, size = population, color = "blue")) +
#   geom_line(mapping = aes(year, child_mort, color = "blue", group = country)) +
#   geom_line(mapping = aes(year, health_exp/4, color = "red", group = country, size = 2)) + 
#   theme(legend.position="none") +
#   labs(x = "Year", y = "Child Mortality")
# 
# # blue is the healthcare expenses per capita

filter(child, year > 1995 & continent != 'NA') %>%
  group_by(continent) %>%
  ggplot() +
  geom_point(mapping = aes(child_mort, health_exp, color = continent, size = population/1000000)) +
  labs(title = "Relationship between healthcare expenses and child mortaity", x = "Child Mortality Per 1,000", y = "Health Expenses Per Capita", size = "Country Population in Millions", color = "Continent")
#+  theme(legend.position = "bottom")

