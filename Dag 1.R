setwd("C:/Users/bjorgbs/R arbeid/Biostat")

library(devtools) #Brukes for ? intallere biostats


#devtools::install_github("biostats-r/biostats.apps") #Installere 

#load(biostats.app)
#library(biostats.apps)
#publication_bias_app()

devtools::install_github("biostats-r/biostats.tutorials") #Installere tutorials

library(biostats.tutorials)

learnr::run_tutorial("naming-objects", package = "biostats.tutorials") #åpner tutorials i følgende rekkefølge
 
  ##naming-objects
  ##function-packages
  ##importing-data
  ##using-dplyr
  ##Dates-and-times
  ##text-manipulation

#package lintr # Tells you where your code's ugly


learnr::run_tutorial("function-packages", package = "biostats.tutorials")

