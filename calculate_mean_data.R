rm(list = ls())
gc()

## Create mean data from original dia data 
library(xlsx)

## read data
dia_dat <- read.xlsx("C://Users/ma22buky/Documents/01_PhD/01_Pollination_experiment/publish_data/dia_dat_original.xlsx", sheetIndex = 1)
sca_dat <- read.xlsx("C://Users/ma22buky/Documents/01_PhD/01_Pollination_experiment/publish_data/sca_dat_original.xlsx", sheetIndex = 1)

## get data for figshare
dia_dat_mean <- aggregate(dia_dat$viable, 
                               by = list(dia_dat$plot, dia_dat$individual, 
                                         dia_dat$treatment, dia_dat$season,
                                         dia_dat$climate), FUN = mean, na.rm = T) %>%
  rename(plot = Group.1, individual = Group.2, pollination_treatment = Group.3, season = Group.4, 
         climate = Group.5, viable_seeds = x)

dia_dat_mean$size <- aggregate(dia_dat$size, 
                                    by = list(dia_dat$plot, dia_dat$individual, 
                                              dia_dat$treatment, dia_dat$season,
                                              dia_dat$climate), FUN = mean, na.rm = T)$x

sca_dat_mean <- aggregate(sca_dat$viable, 
                               by = list(sca_dat$plot, sca_dat$individual, 
                                         sca_dat$treatment, sca_dat$season,
                                         sca_dat$climate), FUN = mean, na.rm = T) %>%
  rename(plot = Group.1, individual = Group.2, pollination_treatment = Group.3, season = Group.4, 
         climate = Group.5, viable_seeds = x) 
sca_dat_mean$size <- aggregate(sca_dat$viable, 
                                    by = list(sca_dat$plot, sca_dat$individual, 
                                              sca_dat$treatment, sca_dat$season,
                                              sca_dat$climate), FUN = mean, na.rm = T)$x
