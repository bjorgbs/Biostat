
setwd("C:/Users/bjorgbs/R arbeid/Biostat")

#Task
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



######## GIT / GITHUB ########

#GitHub is a code hosting platform for version control and collaboration. It lets you and others work together on projects from anywhere.


## install if needed (do this exactly once):
#install.packages("usethis")

library(usethis)
use_git_config(user.name = "bjorgbs",user.email = "bjorgbs@hi.no")

#create_github_token()


gitcreds::gitcreds_set()
#Error in throw(new_error("gitcreds_nogit_error")) : 
 # Could not find system git


