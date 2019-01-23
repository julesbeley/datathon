library(tidyverse)
education <- read.csv("C:/Users/JulesBeley/Downloads/Education.csv", sep = ";", stringsAsFactors = FALSE)
education <- education[-c(1:2),]
names(education) <- c("code", "communename", "lycées", "pop", "maternelle", "élementaire", "college")
education$lycées <- as.numeric(as.character(education$lycées))
education$pop <- as.numeric(as.character(education$pop))
education$maternelle <- as.numeric(as.character(education$maternelle))
education$élementaire <- as.numeric(as.character(education$élementaire))
education$college <- as.numeric(as.character(education$college))
education %>% 
  arrange(`pop`) -> education
