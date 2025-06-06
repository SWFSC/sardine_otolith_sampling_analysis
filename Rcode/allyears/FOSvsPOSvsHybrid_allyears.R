library(openxlsx)
library(ggplot2)
library(patchwork)
library(tidyverse)


# subset data #########
# FOS 
sub.data1050 <- readRDS("Rcode/allyears/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050$Type <- "FOS";sub.data1050$Run <- "10-50"
sub.data10100 <- readRDS("Rcode/allyears/FOS/Run-b10n100/Output/subset_data_r10100.rds"); sub.data10100$Type <- "FOS";sub.data10100$Run <- "10-100"
sub.data10150 <- readRDS("Rcode/allyears/FOS/Run-b10n150/Output/subset_data_r10150.rds"); sub.data10150$Type <- "FOS";sub.data10150$Run <- "10-150"
sub.data10200 <- readRDS("Rcode/allyears/FOS/Run-b10n200/Output/subset_data_r10200.rds"); sub.data10200$Type <- "FOS";sub.data10200$Run <- "10-200"
sub.data10250 <- readRDS("Rcode/allyears/FOS/Run-b10n250/Output/subset_data_r10250.rds"); sub.data10250$Type <- "FOS";sub.data10250$Run <- "10-250"

#POS
sub.data10 <- readRDS("Rcode/allyears/POS/10percent/Output/subset_data_10.rds"); sub.data10$Type <- "POSs"; sub.data10$Run <- "10%"
sub.data30 <- readRDS("Rcode/allyears/POS/30percent/Output/subset_data_30.rds"); sub.data30$Type <- "POSs"; sub.data30$Run <- "30%"
sub.data50 <- readRDS("Rcode/allyears/POS/50percent/Output/subset_data_50.rds"); sub.data50$Type <- "POSs"; sub.data50$Run <- "50%"
sub.data70 <- readRDS("Rcode/allyears/POS/70percent/Output/subset_data_70.rds"); sub.data70$Type <- "POSs"; sub.data70$Run <- "70%"
sub.data90 <- readRDS("Rcode/allyears/POS/90percent/Output/subset_data_90.rds"); sub.data90$Type <- "POSs"; sub.data90$Run <- "90%"

#Hybrid 
sub.data3010 <- readRDS("Rcode/allyears/Hybrid/Run-3010/Output/subset_data_hy_r3010.rds"); sub.data3010$Type <- "Hybrid"; sub.data3010$Run <- "30-10"
sub.data3030 <- readRDS("Rcode/allyears/Hybrid/Run-3030/Output/subset_data_hy_r3030.rds"); sub.data3030$Type <- "Hybrid"; sub.data3030$Run <- "30-30"
sub.data3050 <- readRDS("Rcode/allyears/Hybrid/Run-3050/Output/subset_data_hy_r3050.rds"); sub.data3050$Type <- "Hybrid"; sub.data3050$Run <- "30-50"
sub.data4030 <- readRDS("Rcode/allyears/Hybrid/Run-4030/Output/subset_data_hy_r4030.rds"); sub.data4030$Type <- "Hybrid"; sub.data4030$Run <- "40-30"
sub.data4050 <- readRDS("Rcode/allyears/Hybrid/Run-4050/Output/subset_data_hy_r4050.rds"); sub.data4050$Type <- "Hybrid"; sub.data4050$Run <- "40-50"

sub.data.all <- bind_rows(sub.data1050,sub.data10100,sub.data10150,sub.data10200,sub.data10250,
                          sub.data10,sub.data30,sub.data50,sub.data70,sub.data90,
                          sub.data3010,sub.data3030,sub.data3050,sub.data4030,sub.data4050)

sub.data.all <- sub.data.all %>%
  filter(rep==1) %>%
  mutate(run.label=case_match(Run,"10-50"~"50","10-100"~"100","10-150"~"150","10-200"~"200","10-250"~"250",
                              "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=Run))
sub.data.all$run.label <- factor(sub.data.all$run.label, levels=c("50","100","150","200","250","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%"))
sub.data.all$Type <- factor(sub.data.all$Type, levels = c("FOS","POSs","Hybrid"))  

saveRDS(sub.data.all, "Data/sub.data.allyears.rds")

sub.data.sample.size <- sub.data.all %>% 
  group_by(Type,run.label) %>%
  summarise(length(age))
