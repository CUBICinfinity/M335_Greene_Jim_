 hms pack can be used for time only.
 r doesn't by default do that. only date-time and simply date
 
 today()
 
 now()
 
lubridate parsing functions are really straightforward: 
mdy_hm("01/31/2017 08:01")
#> [1] "2017-01-31 08:01:00 UTC"


flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))
  
use modulus arithmetic to fix unusual formats:

make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

we got
as_datetime() and as_date()

--------
really nice:

year(), month(), mday() (day of the month), yday() (day of the year), wday() (day of the week), hour(), minute(), and second().


label = T/F (spell out the name), abbr = T/F (abbreviate the name)


floor_date(), round_date(), and ceiling_date()

see also
update()
-------

duraritons and periods

as.duration() and dseconds(), dweeks(), etc


duration is affected by time zones and leaps in an absolute way:

one_pm
#> [1] "2016-03-12 13:00:00 EST"
one_pm + ddays(1)
#> [1] "2016-03-13 14:00:00 EDT"

instead, try
one_pm
#> [1] "2016-03-12 13:00:00 EST"
one_pm + days(1)
#> [1] "2016-03-13 13:00:00 EDT"

you can add and multiply periods as with durations.
--------

years(1) / days(1)
#> estimate only: convert to intervals for accuracy
#> [1] 365

with interval:
next_year <- today() + years(1)
(today() %--% next_year) / ddays(1)
#> [1] 365
or:
(today() %--% next_year) %/% days(1) #integer division
#> Note: method with signature 'Timespan#Timespan' chosen for function '%/%',
#>  target signature 'Interval#Period'.
#>  "Interval#ANY", "ANY#Period" would also be valid
#> [1] 365

intervals are for spans in human units.

-------

r takes in "America/Detroit" and “Pacific/Auckland”

OlsonNames()

Sys.timezone()

see http://www.iana.org/time-zones to read stories




