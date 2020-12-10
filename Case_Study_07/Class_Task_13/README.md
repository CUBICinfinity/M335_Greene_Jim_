FACTOR STUFF

 month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)


x1 <- c("Dec", "Apr", "Jan", "Mar")

y1 <- factor(x1, levels = month_levels)

x2 <- c("Dec", "Apr", "Jam", "Mar")
y2 <- parse_factor(x2, levels = month_levels)
\# parse factor gives warnings: "Jam" is not good.

factor(x1) alphabetizes.

levels = unique(x) \# use order of appearance in dataset

-~-~-~-~-~-~-~-~

gss_cat %>% 
  count(race)
  

aes(age, fct_reorder(rincome, age)) \# you can have more that two arguments as well!

aes(age, fct_relevel(rincome, "Not applicable")) \# pull NA out front

\# fct_infreq() is easy to use:
gss_cat %>%
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(marital)) +
    geom_bar()
    
~-~-~-~-~-~-~-~-~-~-~-
use
fct_recode()

mutate(partyid = fct_recode(partyid,
    "Republican, strong"    = "Strong republican",
    "Republican, weak"      = "Not str republican",
    "Independent, near rep" = "Ind,near rep",
    "Independent, near dem" = "Ind,near dem",
    "Democrat, weak"        = "Not str democrat",
    "Democrat, strong"      = "Strong democrat"
  ))

fct_lump automatically grous the smaller categories into "Other"
, n = <>) toset how many groups are desired, excluding Other.


-=-=-=-=-=-=-=-=-=-=-=
"Think about what you want to do and show, not just what you can do with the standard charting icons..." -Fundamental Statistics Concepts in Presenting Data



