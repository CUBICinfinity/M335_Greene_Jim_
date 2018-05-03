Bits of Chapter 5:
=====
fly <- nycflights13::flights
=============

dpylr override: use full names:
stats::filter()
stats::lag()

=============

int - stands for integers.

dbl - stands for doubles, or real numbers.

chr - stands for character vectors, or strings.

dttm - stands for date-times (a date + a time).

lgl - stands for logical, vectors that contain only TRUE or FALSE.

fctr - stands for factors, which R uses to represent categorical variables with fixed possible values.

date - stands for dates.

=============

near(value, value)

=============
use
%in%
=======
base R has &&, ||
=======
NA tends to be treated as an unknown number
but not always
======
NA is always at the end in sorting
=====
the ':' selects the range as it appear in the data
=====
do ?select
everything() is nice

 This is how you use one_of()
vars <- select(fly, one_of(c("year", "month", "day", "dep_delay", "arr_delay")))
=====
rename(data, new_name = column)
=======
contains() is not case sensitive by default
=====
mutate(data, new_col = stuff) make new col
transmute() replaces
=====
see 5.5.1:

/ float divide
%/% int divide
%% modulus

log() is base e
log2() is 2, so on

(x <- 1:10)
lead(x, 3)

=====
min_rank(), etc:

https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html
======
## important:
summarise(data, extra_stuff) quick nice

use group_by()
====
pipe (see 5.6.1):
%>%

also, + in ggplot
===
, na.rm = T) removes na values
====
transpose and compare data in new ways to see things more clearly or differently.
====
 Cmd/Ctrl + Shift + P
 send last chunk to console

send with ctrl+enter
====
mad() = median absolute deviation
also, there is an IQR()

quantile(x, <percent>) percentile
====
sum(!is.na(x))
n_distinct(x)  
===
THIS IS COOL
daily <- group_by(fly, year, month, day)
(per_day   <- summarise(daily, fly = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

you can ungroup()
===

sort(x, count= )
===
vignette("window-functions")
===


