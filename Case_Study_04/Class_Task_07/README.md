 ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
  
  (graph)
  
diamonds %>% 
  count(cut_width(carat, 0.5))
  
  (computation)
  
ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)
  
  (to map two values in a histogram)
  
========
"The key to asking good follow-up questions will be to rely on your curiosity (What do you want to learn more about?) as well as your skepticism (How could this be misleading?)."
========

Which values are the most common? Why?

Which values are rare? Why? Does that match your expectations?

Can you see any unusual patterns? What might explain them?

=========

Replace unusual values with NA:

diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
  
===Learn more about the data set. NA could mean something specific.

Different charts treat nas differently.

=========

Density plots!

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)
  
======

more packages:

ggstance package, and create a horizontal boxplot instead of coord_flip()

letter value plot. Install the lvplot package, and try using geom_lv()

ggbeeswarm package provides a number of methods similar to geom_jitter()

======

ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))
  
  (categorical 2d plot Sized by count)
  

=====

diamonds %>% 
  count(color, cut) %>%   # makes a data table
  ggplot(mapping = aes(x = color, y = cut)) +
    geom_tile(mapping = aes(fill = n)) # this is easier to read than the sizing plot.
    
  
This sometimes helps (good for big datasets)

ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price))

 # install.packages("hexbin")
ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))

 # bin one var as categorical: nice:
 
 ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
  
  # variation: all bins have same number:
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))
  
======

 #  Demands more study: eliminates relationship of carat and price to compare cut and price
 
library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))
  
ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))
  
  
=====

devtools::install_github("r-lib/devtools")