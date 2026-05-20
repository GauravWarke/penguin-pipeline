library(targets)
library(tarchetypes)
library(dplyr)
library(palmerpenguins)

tar_option_set(packages = c("dplyr", "broom", "palmerpenguins"))

list(
  tar_target(raw_data, penguins),
  
  tar_target(clean_data, raw_data |> 
               filter(!is.na(body_mass_g)) |> 
               mutate(species = as.factor(species)))
)

tar_target(adelie_data, filter(clean_data, species == "Adelie"))
tar_target(chinstrap_data, filter(clean_data, species == "Chinstrap"))
tar_target(gentoo_data, filter(clean_data, species == "Gentoo"))
tar_target(adelie_model, lm(body_mass_g ~ bill_length_mm, data = adelie_data))
