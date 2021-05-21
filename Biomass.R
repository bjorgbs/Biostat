Task
#Find the total biomass per plot, and present the results in a figure.

library(readxl)
library(tidyverse)

#Import data
biomass2015 <- read_excel("Data/biomass2015.xls", + sheet = "Site L") # Only first sheet
biomass <- read_excel("Data/biomass2015.xls", + sheet = ".x") #alle ark VIRKER IKKE


#select plot and production, the relevant columns
biomass2015 %>%                                  
  select(plot, production) #Select forteller hvilke kolonner som skal med

#Grupper
biomass2015 %>%                                  
  select(plot, species, production) %>% #Select forteller hvilke kolonner som skal med
  group_by(plot) %>% # Grupperer de forskjellige plottene
  mutate(sum_biomass = sum(production, na.rm = TRUE)) #summerer biomasse

#fjern duplikater
biomass2015 %>%                                  
  select(plot, species, production) %>% #Select forteller hvilke kolonner som skal med
  group_by(plot) %>% # Grupperer de forskjellige plottene
  mutate(sum_biomass = sum(production, na.rm = TRUE)) %>%  #summerer biomasse
  distinct(plot, keep = sum_biomass)# Tar bort radene som har duplikater i kolonnen plot

#Assign
SiteL <- biomass2015 %>%                                  
  select(plot, species, production) %>% 
  group_by(plot) %>% 
  mutate(sum_biomass = sum(production, na.rm = TRUE)) %>%  
  distinct(plot, biomass = sum_biomass)


#Plotting
library(ggplot2)

Site_L_plot <- ggplot(SiteL, aes(x = plot, y = biomass)) + geom_point()
Site_L_plot
