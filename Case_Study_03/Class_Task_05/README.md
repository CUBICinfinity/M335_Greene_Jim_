Chapter 28 notes

*
Lots about labeling
Positioning, wrapping, legends
coloring
sizing
*

annotate()
arrow()
look up facet


You create lots of stuff you undrerstand and a little that other will easily understand (but takes work to make)

++++++
CHUNK:
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )
++++++

use quote() in labs() for math output
?plotmath

use
geom_text(aes(label = model), data = best_in_class)
or
geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5)
nudge is important.
better option to avoid overlap:
+
  ggrepel::geom_label_repel(aes(label = model), data = best_in_class)
  
refer back for more detail.

REMOVING LEGEND!
theme(legend.position = "none")

----------

data = holds many values

---

SCALING

scale_y_continuous(breaks = seq(15, 40, by = 5))
  
scale_x_continuous(labels = NULL)

cool:
geom_segment(aes(xend = end, yend = id)) +
    scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y")
    
there's also a date_breaks()

----

see guides() for legends

---




scale_x_log10() is better than aes(log10(carat), for labeling

----

USE colorbrewer!

+
  scale_colour_brewer(palette = "Set1")

shaping differently can help with future printing in bw.

 scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))
 
 more:
 scale_colour_gradient()
 scale_fill_gradient()
 scale_colour_gradient2()
 
 scale_colour_viridis()

----
 
geom_bin2d() does pixel points
+
  geom_hex()
  is hexagonal
  
----

solution to problem 28.4.4: 

ggplot(diamonds, aes(carat, price)) +
+     geom_point(aes(colour = cut), alpha = 1/20) + guides(color = guide_legend(override.aes = list(alpha=1)))

----

coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))

pack limits together.

zooming is often better than filtering or subsetting.

----

https://github.com/jrnold/ggthemes

---

see fig sizing

resource:
see book:
ggplot2: Elegant graphics for data analysis
source: 
https://github.com/hadley/ggplot2-book

http://www.ggplot2-exts.org/
---

