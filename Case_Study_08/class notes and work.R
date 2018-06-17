library(tidyverse)
library(plyr)
library(lubridate)
x <- ymd_hms("2009-07-01 2:01:59.23", tz = "America/Denver")

x <- with_tz(x, tzone = "America/Denver")

floor_date(x, "quarter")

quarter(x)

#################

y <- read_csv("https://byuistats.github.io/M335/data/Walmart_store_openings.csv")

y$OPENDATE <- mdy(y$OPENDATE)

y$date_super <- mdy(y$date_super)

############

regions <- tibble(state.region, state.abb)

y <- y %>% mutate(year = year(OPENDATE))

y <- y %>% left_join(regions, c("state" = "state.abb"))

y <- y %>% mutate(state.region = revalue(state.region, c("North Central" = "Midwest", "Northeast" = "Northern")))

y <- y %>% mutate(state = as.factor(state))

y %>% 
  mutate(state = fct_reorder(state, year, min, .desc = T)) %>% 
  ggplot(aes(year, fill = state.region)) +
  theme_minimal() +
  geom_bar() +
  annotate("segment", y = 0, yend = 0, x = -Inf, xend = Inf, color = "grey90", linetype = "dashed", 
           size = .2) + 
  facet_grid(state ~ .) +
  scale_y_continuous(breaks = c()) +
  scale_x_continuous(breaks = c(1962, 1970, 1980, 1990, 2000, 2006)) +
  theme(legend.position = c(0.1,0.975), legend.background = element_rect(fill = "white", color = NA), panel.grid = element_blank(), strip.text.y = element_text(angle = 0, hjust = 1), text = element_text(color = "gray40")) +
  labs(y = "", x = "Year", fill = "", title = "The Growth of Walmart: Store Openings by Year and State") +
  scale_fill_manual(values = c("#d85022", "#18b020", "#f0c020", "#3080d7"))

