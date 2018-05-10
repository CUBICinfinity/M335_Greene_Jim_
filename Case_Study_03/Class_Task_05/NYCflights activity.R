#install.packages("nycflights13")
library(nycflights13)

fl_bp <- flights %>%
  ggplot(aes(x = carrier, y = dep_delay))
fl_sc <- flights %>%
  filter(dep_time > 800, dep_time < 900) %>%
  ggplot(aes(x = dep_time, y = dep_delay))

fl_bp + geom_boxplot() +
  coord_cartesian(ylim = c(50, 100)) +
  scale_y_continuous(breaks = seq(50, 110, by = 15)) +
  labs(x = "Airline", y = "Departure Delay")


fl_sc + geom_point() +
  theme_bw() +
  theme(legend.position = "bottom") +
  coord_cartesian(ylim = c(50, 100)) +
  scale_y_continuous(breaks = seq(50, 110, by = 15)) +
  geom_point(aes(color = carrier)) +
  labs(x = "Carrier", y = "Departure Delay")
#+ scale_color_discrete(palette = "Set3")


# 
# fl_bp <- flights %>%
#   ggplot(aes(x = carrier, y = dep_delay))
# fl_sc <- flights %>%
#   filter(dep_time > 800, dep_time < 900) %>%
#   ggplot(aes(x = dep_time, y = dep_delay))
# 
# fl_bp + geom_boxplot()
# fl_sc + geom_point()