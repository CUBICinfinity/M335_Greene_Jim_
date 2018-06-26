# CREATING A BETTER DATA TABLE

library(DT)


datatable(head(iris), class = 'cell-border stripe', colnames = c('ID' = 1), filter = "top", extensions="Responsive", options = list(lengthMenu = c(5,3,10,20)))
#, rownames = FALSE
# c('cell-border stripe', 'compact')