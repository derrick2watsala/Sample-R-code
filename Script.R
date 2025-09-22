##Sample R code - Derrick Watsala

#Loading Libraries
library(tidyverse)
library(usethis)
library(gitcreds)

#Loading sample Penguins Data set
data("longley")
view(longley)
dim(longley)
nrow(longley)
ncol(longley)
str(longley)
