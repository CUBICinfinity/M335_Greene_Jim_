 Notes
 
 library(tidyquant) (cran)
 library(quantmod)
 
 https://github.com/business-science/tidyquant
 
 viginettes are the documents
 
 
tq_get("NFLX", get = "stock.prices")

sp_500 <- tq_index("SP500") %>%
  tq_get(get = "stock.prices")

tq_transmutate_fun_options()