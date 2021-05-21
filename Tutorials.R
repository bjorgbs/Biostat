setwd("C:/Users/bjorgbs/R arbeid/Biostat")

####### Functions and Packages #######

library(biostats.tutorials)
learnr::run_tutorial("function-packages", package = "biostats.tutorials")


library(tidyverse)
rnorm(n = 10, mean = 5, sd = 1)
?rnorm



##Hentet fra help-section

library(graphics)

dnorm(0) == 1/sqrt(2*pi)
dnorm(1) == exp(-1/2)/sqrt(2*pi)
dnorm(1) == 1/sqrt(2*pi*exp(1))

## Using "log = TRUE" for an extended range :
par(mfrow = c(2,1))
plot(function(x) dnorm(x, log = TRUE), -60, 50,
     main = "log { Normal density }")
curve(log(dnorm(x)), add = TRUE, col = "red", lwd = 2)
mtext("dnorm(x, log=TRUE)", adj = 0)
mtext("log(dnorm(x))", col = "red", adj = 1)

plot(function(x) pnorm(x, log.p = TRUE), -50, 10,
     main = "log { Normal Cumulative }")
curve(log(pnorm(x)), add = TRUE, col = "red", lwd = 2)
mtext("pnorm(x, log=TRUE)", adj = 0)
mtext("log(pnorm(x))", col = "red", adj = 1)

## if you want the so-called 'error function'
erf <- function(x) 2 * pnorm(x * sqrt(2)) - 1
## (see Abramowitz and Stegun 29.2.29)
## and the so-called 'complementary error function'
erfc <- function(x) 2 * pnorm(x * sqrt(2), lower = FALSE)
## and the inverses
erfinv <- function (x) qnorm((1 + x)/2)/sqrt(2)
erfcinv <- function (x) qnorm(x/2, lower = FALSE)/sqrt(2)

### SLutt help section

5 < 3

c("a", "z") %in% c("a", "b", "c")

7 %% 4 
#3 is the reamainder

7 %/% 4
#1 after integer division

? '%/%'  #Help. add '' 

#Not all R packages are available on CRAN. Some packages in development are only available on github.com. Packages on github can be installed with the remotes #package.

#install.packages("remotes")
##ggvegan for ploting ordinations is only on github
#remotes::install_github("gavinsimpson/ggvegan")


library(conflicted) #varsler deg hvis samme fuksjon finnes i flere aktive pakker. 

citation("lme4") #Forteller deg hvordan lme4 skal siteres!!
citation("conflicted")
#To cite package ‘conflicted’ in publications use:
  
#  Hadley Wickham (2019). conflicted: An Alternative Conflict Resolution Strategy. R package version 1.0.4.
#https://CRAN.R-project.org/package=conflicted

#A BibTeX entry for LaTeX users is

#@Manual{,
#  title = {conflicted: An Alternative Conflict Resolution Strategy},
#  author = {Hadley Wickham},
#  year = {2019},
#  note = {R package version 1.0.4},
#  url = {https://CRAN.R-project.org/package=conflicted},
#}


####### using-dplyr ########
library(biostats.tutorials)
learnr::run_tutorial("using-dplyr", package = "biostats.tutorials")

library(tidyverse) #dplyr er en del av tidyverse
library("tidylog") # finner problemer i koden
library(palmerpenguins) #inneholder et dataset å redigere

data("penguins", package = "palmerpenguins") #load data
penguins #se på data

#select species, bill_length_mm & bill_depth_mm
penguins %>%                                  #penguins er dataen, %<% er en pipe
  select(species, bill_length_mm, bill_depth_mm) #Select forteller hvilke kolonner som skal med

penguins[, c("species", "bill_length_mm", "bill_depth_mm")] # Denne koden gjør akkurat det samme

#select bill_length_mm & bill_depth_mm" 
penguins %>% select(starts_with("bill")) #Velder ut kolonner som strater med "bill", kan også bruke slutter med


penguins %>% select(where(is.numeric)) # No brackets on the function #Velger ut kolonner som er numeriske

penguins %>% rename(Species = species) # Endrer kolonnenavn fra species til Species (Kan også gjøres SAMTIDIG som man velger ut kolonner.)

penguins %>% relocate(island) #Flytter kolonnen island først 

penguins %>% 
  mutate(body_mass_kg = body_mass_g / 1000)# Lager en ny kolonne som heter body mass_kg, deler g på 1000

###Redigere rader
penguins %>% filter(bill_length_mm > 40) # Velger ut individer med lengde over 40 mm

#Tilsvarende 
penguins[penguins$bill_length_mm > 40, ]

#==equal to (Bruk med forsiktighet pga avrunding evt. erstatt med "near")
#!= not equal to
#< less than
#<= less than or equal to
#> greater than
#>= greater than or equal to
#is.na() for filtering by missing values.
#between() for filtering values with a range
#%in% is used when you want to test if a value is in a vector

#Filtere på flere valg
penguins %>% 
  filter(bill_length_mm > 40, bill_depth_mm > 18) #, gir X OG Y

penguins %>% 
  filter(bill_length_mm > 40 | bill_depth_mm > 18) # | gir X ELLER Y

penguins %>% slice(3:7)# Beholder rad 3 til 7, kan også bruke - for å ta bort rader

penguins %>% distinct() #Tar bort duplikater
penguins %>% distinct(island)# Tar bort radene som har duplikater i kolonnen island. TAr bort de andre kolonenne med mindre man bruker . keep_all = TRUE

penguins %>% slice_sample(n = 10) #Veelger 10 random rader

####### "Jobb" med datasettet#####
penguins %>% summarise(                                    # Summerer og kalkulerer flipper_length_mm
  flipper_len_mean = mean(flipper_length_mm, na.rm = TRUE), #mean() 
  flipper_len_sd = sd(flipper_length_mm, na.rm = TRUE)      # Ny kolonne _sd regner ut sd for flipper_length_mm
)

penguins %>%
  summarise(across(c(bill_length_mm, bill_depth_mm), .fns = mean, na.rm = TRUE)) #Summerer opp flere kolonner samtidig. c()forteller kolonnene, .fns forteller hvilken funksjon evt funksjoner. Da brukes fns = list(sd = sd, mean = mean)

penguins %>% 
  group_by(species) %>% # Grupperer og analyserer de forskjellige artene
  summarise(mean_flipper_length = mean(flipper_length_mm)) #Bestemmer hvilke analyser som skal utføres

penguins %>% arrange(bill_length_mm, bill_depth_mm)#Sorterer etter gitte kolonner
