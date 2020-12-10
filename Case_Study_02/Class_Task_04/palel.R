# Use filter(), arrange(), select(), mutate(), group_by(), 
# and summarise(). With library(tidyverse) tackle the following challenges.

# Arrange the iris data by Sepal.Length and display the first six rows.

iris %>%
arrange(Sepal.Length) %>%
  head(6)

#Select the Species and Petal.Width columns and put them into a new data 
#set called testdat.

testdat <-
  select(iris, Species, Petal.Width)

#Create a new table that has the mean for each variable by Species.

new <- iris %>%
  group_by(Species) %>%
  summarise(avg_Sepal.Length=mean(Sepal.Length),
            avg_Sepal.Width=mean(Sepal.Width),
            avg_Petal.Length=mean(Petal.Length),
            avg_Petal.Width=mean(Petal.Width))

#Read about the summarise_all() and get a new table with the means and 
#standard deviations for each Species.

final <- iris %>%
  group_by(Species) %>%
  summarise_all(funs(mean,sd))


