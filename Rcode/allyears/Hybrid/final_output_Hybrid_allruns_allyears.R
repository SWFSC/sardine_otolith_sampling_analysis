library(openxlsx)
library(ggplot2)
library(patchwork)
library(tidyverse)

# FINAL OUTPUT FOR ALL RUNS FOR ALL YEARS
r3010 <- readRDS("Rcode/allyears/Hybrid/Run-3010/Output/final_output_allyears_hy_r3010.RDS")
r3030 <- readRDS("Rcode/allyears/Hybrid/Run-3030/Output/final_output_allyears_hy_r3030.RDS")
r3050 <- readRDS("Rcode/allyears/Hybrid/Run-3050/Output/final_output_allyears_hy_r3050.RDS")
r4030 <- readRDS("Rcode/allyears/Hybrid/Run-4030/Output/final_output_allyears_hy_r4030.RDS")
r4050 <- readRDS("Rcode/allyears/Hybrid/Run-4050/Output/final_output_allyears_hy_r4050.RDS")

final <- rbind(r3010,r3030,r3050,r4030,r4050)

final.sort.metric <- final[order(final$Metric),]


l<-list("Output"=final, "Metric_sort"=final.sort.metric)
write.xlsx(l, "Rcode/allyears/Hybrid/final_model_output_allruns_hy_allyears.xlsx")


# age frequency ###
af3010 <- readRDS("Rcode/allyears/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds") # change to where you want to save output file
af3030 <- readRDS("Rcode/allyears/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds") # change to where you want to save output file
af3050 <- readRDS("Rcode/allyears/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds") # change to where you want to save output file
af4030 <- readRDS("Rcode/allyears/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds") # change to where you want to save output file
af4050 <- readRDS("Rcode/allyears/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds") # change to where you want to save output file

af.all <- rbind(af3010,af3030,af3050,af4030,af4050)
saveRDS(af.all,"Rcode/allyears/Hybrid/af_all_hy_allyears.RDS")

# age length keys ###
alk3010 <- readRDS("Rcode/allyears/Hybrid/Run-3010/Output/alk_data_all_r3010.rds")
alk3030 <- readRDS("Rcode/allyears/Hybrid/Run-3030/Output/alk_data_all_r3030.rds")
alk3050 <- readRDS("Rcode/allyears/Hybrid/Run-3050/Output/alk_data_all_r3050.rds")
alk4030 <- readRDS("Rcode/allyears/Hybrid/Run-4030/Output/alk_data_all_r4030.rds")
alk4050 <- readRDS("Rcode/allyears/Hybrid/Run-4050/Output/alk_data_all_r4050.rds")

alk.data.all <- rbind(alk3010,alk3030,alk3050,alk4030,alk4050)

alk.data.all$MAPD_model_new <- alk.data.all$MAPD_model
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==0 & alk.data.all$bin>180,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==1 & alk.data.all$bin<90|alk.data.all$bin>270,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==2 & alk.data.all$bin<110|alk.data.all$bin>280,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==3 & alk.data.all$bin<140|alk.data.all$bin>280,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==4 & alk.data.all$bin<150|alk.data.all$bin>290,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==5 & alk.data.all$bin<190,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==6 & alk.data.all$bin<190,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==7 & alk.data.all$bin<200,0,alk.data.all$MAPD_model_new)
alk.data.all$MAPD_model_new <- ifelse(alk.data.all$age==8 & alk.data.all$bin<220,0,alk.data.all$MAPD_model_new)

saveRDS(alk.data.all, "Rcode/allyears/Hybrid/alk.data.all.hy.rds")

nsims=1000
ALK_metrics_bin_age <- alk.data.all %>%
  group_by(bin,age,run) %>%
  summarize(Metric=unique(metric),
            mean_APD_model = as.numeric(NA),
            mean_MAPD_model = round(mean(MAPD_model,na.rm=TRUE),2),
            count_under_5_model = sum(MAPD_model<5,na.rm=TRUE),
            percent_under_5_model = (count_under_5_model/nsims)*100,
            count_under_10_model = sum(MAPD_model<10,na.rm=TRUE),
            percent_under_10_model = (count_under_10_model/nsims)*100,
            count_under_10_model_new = sum(MAPD_model_new<10,na.rm=TRUE),
            percent_under_10_model_new = (count_under_10_model_new/nsims)*100)
ALK_metrics_bin_age
ALK_metrics_bin_age$Type <- "Hybrid"
saveRDS(ALK_metrics_bin_age, "Rcode/allyears/Hybrid/alk_metrics_bin_age_hy.rds")


