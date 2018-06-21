 DYGRAPHS NOTES

http://rstudio.github.io/dygraphs/index.html 
 
 dygraph(lungDeaths) %>%
  dySeries("mdeaths", label = "Male") %>%
  dySeries("fdeaths", label = "Female") %>%
  dyOptions(stackedGraph = TRUE) %>%
  dyRangeSelector(height = 20)
  
dyOptions()

the coding is similar to ggplot, but follows the traditional plot() setup.

several good uses: Upper/lower , candelstick , strawbroom

the rownames have to be the time variable

ALSO REALLY GOOD https://github.com/business-science/timetk
makes good predictions automatically

