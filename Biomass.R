Task
#Find the total biomass per plot, and present the results in a figure.

library(readxl)
library(tidyverse)
library(purrr)

#Import data
#biomass <- list.files(path = "Data/biomass2015.xls") %>% 
#  map_dfr(~read_excel(sheet = .x, delim = ","))
#(read_excel(path = "Data/biomass2015.xls"))  %>% 
 #    map_dfr(read_excel(path = "Data/biomass2015.xls", + sheet = .x)) #alle ark VIRKER IKKE

biomassL <- read_excel("Data/biomass2015.xls",  sheet = "Site L") # Only first sheet
biomassM <- read_excel("Data/biomass2015.xls",  sheet = "Site M")
biomassA <- read_excel("Data/biomass2015.xls",  sheet = "Site A")
biomassH <- read_excel("Data/biomass2015.xls",  sheet = "Site H")

biomass <- rbind(biomassA, biomassH, biomassL, biomassM)

biomass %>%                                  
  select(site, plot, production) #Select forteller hvilke kolonner som skal med

#Grupper
biomass %>%                                  
  select(site, plot, production) %>% #Select forteller hvilke kolonner som skal med
  group_by(site, plot) %>% # Grupperer de forskjellige plottene
  mutate(sum_biomass = sum(production, na.rm = TRUE)) #summerer biomasse

#fjern duplikater
biomass %>%                                  
  select(site, plot, species, production) %>% #Select forteller hvilke kolonner som skal med
  group_by(site, plot) %>% # Grupperer de forskjellige plottene
  mutate(sum_biomass = sum(production, na.rm = TRUE)) %>%  #summerer biomasse
  distinct(plot, biomass = sum_biomass, )# Tar bort radene som har duplikater i kolonnen plot

#Assign
SiteL <- biomass %>%                                  
  select(site, plot, species, production) %>% 
  group_by(site, plot) %>% 
  mutate(sum_biomass = sum(production, na.rm = TRUE)) %>%  
  distinct(plot, biomass = sum_biomass, )

#Plotting
library(ggplot2)

Site_L_plot <- ggplot(SiteL, aes(x = plot, y = biomass)) + geom_point()
Site_L_plot


