#Sample R Code------------------------
#Derrick Watsala

#1.Packages-----------------------------
install.packages("tidyverse")
library(tidyverse)
install.packages("usethis")
library(usethis)
install.packages("gitcreds")
library(gitcreds)
install.packages("survey")
library(survey)
install.packages("skimr")
library(skimr)
install.packages("palmerpenguins")
library(palmerpenguins)
install.packages("gtsummary")
library(gtsummary)
install.packages("DataExplorer")
library(DataExplorer)
install.packages("ggthemes")
library(ggthemes)
install.packages("scales")
library(scales)

#2.Load DaDataExplorer#Load Dataset--------------------------------------
data("penguins")

sample_data1 <- penguins
rm(sample_data)
rm(penguins)
rm(penguins_raw)

#3.Explore dataset----------------------------------
skim(sample_data1)
glimpse(sample_data1)
View(sample_data1)

#4.Data Wrangling----------------------------------
sample_data1 |>
  summarise(mean_bill_length = mean(bill_length_mm))

#5.Remove Na's from bill_length_mm and its average
sample_data1 |>
  drop_na(bill_length_mm) |>
  summarise(mean_bill_lenth = mean(bill_length_mm))

#6.Selecting specific varibles
sample_data1 |> 
  drop_na(sex) |> 
  select(island:sex) -> island_sex
  
#6.Creating a new variable using Mutate
sample_data1 |> 
  mutate(continent = "Antarctica") -> continent

#7.Use of summarize()-------------------------------
sample_data1 |> 
  drop_na(bill_length_mm, sex) |> 
  group_by(island, sex) |> 
  summarise(M_bill_length = mean(bill_length_mm), M_bill_deepth = mean(bill_depth_mm)) -> Mean_bill_deep_length

#8.Create a new data frame--------------------------
sample_data1 |> 
  drop_na(island, sex, body_mass_g) |> 
  group_by(island,sex) |> 
    summarise(Mean_weight = mean(body_mass_g)) -> Weight_computed

#8a. How many species are in each island
sample_data1 |> 
  select(island, species) |> 
  count(island, species) -> species_per_island

#8b. Compute the mean bill length of all species per island
sample_data1 |> 
  drop_na(bill_length_mm) |> 
  select(island, bill_length_mm) |> 
  group_by(island) |> 
  summarise(mean = mean(bill_length_mm)) -> Species_bill_length_island

#8c. Create a new data frame of mean with one decimal point
Species_bill_length_island |> 
  mutate(mean_one_decimal = number(mean, accuracy = 0.1)) -> species_bill_length_isalns_decimal

#9.Some Data Visualizations-------------------------
##9a.Barplot
species_bill_length_isalns_decimal |> 
  ggplot(aes(x = island,
                     y = mean,
                     fill = island,
                     label = mean_one_decimal)) + 
  geom_col(position = "dodge") + 
  geom_text(vjust = 2.0, color = "white") +
  theme_gray() + 
  labs(x = "Island",
       y = "Mean Bill Length",
       fill = NULL,
       caption = "Average Bill Length per Island",
       title = "Bill Length Computed") +
  scale_fill_viridis_d(option = "D") -> plot1

#9b.Barplot species per Island
species_per_island |> 
  ggplot(aes(x = n,
             y = island,
             fill = species)) +
  geom_col(position = "dodge") + 
  scale_fill_viridis_d() +
  labs(x = "Number of Penguins",
       y = "Island",
       fill = "Species",
       title = "Penguins Species Per Island") -> plot2

##9c.Scatter plot------------------------------------
sample_data1 |> 
ggplot(aes(x = bill_length_mm,
                     y = body_mass_g,
                     colour = bill_length_mm)) +
  geom_point() +
  scale_color_viridis_c(option = "E") +
  theme_classic() +
  labs(title = "Body mass Vs Bill Length", 
       x = "Bill Length",
       Y = "Body Mass",
       color = NULL) -> plot3
