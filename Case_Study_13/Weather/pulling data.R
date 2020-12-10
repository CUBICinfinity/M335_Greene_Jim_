##################
# Key = d02b450fd2964e42
# Get weatherdata from wundergound
# library(rwunderground)
##################

# Set API Key
rwunderground::set_api_key("d02b450fd2964e42")

rwunderground::set_api_key("493dee0bd9cb9415")

# Set location to local Rexburg Station
# You can find the stations at https://www.wunderground.com/wundermap
set_location(PWS_id = "KIDREXBU13")

# get weather data for last 500 days, 06-18-17
library(lubridate)
now() - ddays(500)
last.500<- history_range(set_location(PWS_id = "KIDREXBU13"), "20170101", "20180515")