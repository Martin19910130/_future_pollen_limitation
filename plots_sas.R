#####################################################
##                                                 ##
##        Plots for the pollination paper          ##
##                                                 ##
#####################################################
rm(list = ls())
gc()

library(ggplot2)
library(dplyr)
library(xlsx)

## color palatte
myPalette <- c("#0072B2", "#D55E00")

## load data
dia_lsmeans <- read.xlsx("C://Users/ma22buky/Documents/PhD/Pollination_experiment/Results/SAS_results/ls_means_plot.xlsx",
                         sheetIndex = 1)
sca_lsmeans <- read.xlsx("C://Users/ma22buky/Documents/PhD/Pollination_experiment/Results/SAS_results/ls_means_plot.xlsx",
                         sheetIndex = 2)

sca_lsmeans$Season <- factor(sca_lsmeans$Season, levels = c("summer", "fall"))
dia_lsmeans$Season <- factor(dia_lsmeans$Season, levels = c("summer", "fall"))

dia_cl_pl <- ggplot(dia_lsmeans %>% subset(., !is.na(.$climate)), 
       aes(x = climate, y = estimate, color = pollination, shape = pollination)) + 
  geom_point(position = position_dodge(0.5)) + theme_bw() +
  geom_errorbar(aes(ymin = estimate - Standard.error, ymax = estimate + Standard.error), 
                position = position_dodge(0.5), width = .25) + xlab("") +
  ylab("Viable seeds per capsule") + scale_color_manual(values = myPalette) + 
  labs(title = expression(italic(paste("D. carthusianorum")))) + ylim(10,40)

sca_sea <- ggplot(sca_lsmeans, aes(x = Season, y = estimate)) + geom_point() + theme_bw() + 
  geom_errorbar(aes(ymin = estimate - Standard.error, ymax = estimate + Standard.error), width = 0.25) + 
  ylim(10, 40) + xlab("") + ylab("Viable seeds per head") + 
  labs(title = expression(italic(paste("S. ochroleuca")))) + 
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  geom_text(x = 0.65, y = 40, label = "b.)", size = 5)
  
dia_sea <- ggplot(dia_lsmeans %>% subset(., !is.na(.$Season)), aes(x = Season, y = estimate)) + geom_point() + theme_bw() + 
  geom_errorbar(aes(ymin = estimate - Standard.error, ymax = estimate + Standard.error), width = 0.25) + 
  ylim(10, 40) + xlab("") + ylab("Viable seeds per capsule") + 
  labs(title = expression(italic(paste("D. carthusianorum")))) + 
  geom_text(x = 0.65, y = 40, label = "a.)", size = 5)

dia_sca_sea <- ggpubr::ggarrange(dia_sea, sca_sea)

dia_sca_sea

ggsave(dia_cl_pl, 
       filename = "C://Users/ma22buky/Documents/PhD/Pollination_experiment/Results/SAS_results/dia_pl_cl.jpeg")
ggsave(dia_sca_sea, 
       filename = "C://Users/ma22buky/Documents/PhD/Pollination_experiment/Results/SAS_results/dia_sca_sea.jpeg")

## appendix figures
sca_lsmeans_bagged <- read.xlsx("C://Users/ma22buky/Documents/PhD/Pollination_experiment/Results/SAS_results/ls_means_plot.xlsx",
                                sheetIndex = 3)
dia_lsmeans_bagged <- read.xlsx("C://Users/ma22buky/Documents/PhD/Pollination_experiment/Results/SAS_results/ls_means_plot.xlsx",
                                sheetIndex = 4)

sca_bag_pl <- ggplot(sca_lsmeans_bagged %>% subset(., !is.na(.$pollination)), 
       aes(x = pollination, y = estimate)) + geom_point() + theme_bw() + 
  geom_errorbar(aes(ymin = estimate - standard.error, ymax = estimate + standard.error), width = 0.25) + 
  ylim(0,40) + labs(title = expression(italic(paste("S. ochroleuca"))),
                    y = "Viable seeds per seed head", x = "") + 
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())+
  geom_text(x = 0.65, y = 40, label = "b.)", size = 5)

dia_bag_pl <- ggplot(dia_lsmeans_bagged %>% subset(., !is.na(.$pollination)), 
       aes(x = pollination, y = estimate)) + geom_point() + theme_bw() + 
  geom_errorbar(aes(ymin = estimate - standard.error, ymax = estimate + standard.error), width = 0.25) + 
  ylim(0,40) + labs(title = expression(italic(paste("D. carthusianorum"))),
                    y = "Viable seeds per seed capsule", x = "") + 
  geom_text(x = 0.65, y = 40, label = "a.)", size = 5)

dia_sca_bagged_pl <- ggpubr::ggarrange(dia_bag_pl, sca_bag_pl)

ggsave(dia_sca_bagged_pl, 
       filename = "C://Users/ma22buky/Documents/PhD/Pollination_experiment/Results/SAS_results/dia_sca_bagged.jpeg")
