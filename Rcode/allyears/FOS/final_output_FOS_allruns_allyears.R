library(openxlsx)
library(ggplot2)
library(patchwork)
library(tidyverse)

# FINAL OUTPUT FOR ALL RUNS FOR ALL YEARS
r1050 <- readRDS("Rcode/allyears/FOS/Run-b10n50/Output/final_output_allyears_fos_r1050.RDS")
r10100 <- readRDS("Rcode/allyears/FOS/Run-b10n100/Output/final_output_allyears_fos_r10100.RDS")
r10150 <- readRDS("Rcode/allyears/FOS/Run-b10n150/Output/final_output_allyears_fos_r10150.RDS")
r10200 <- readRDS("Rcode/allyears/FOS/Run-b10n200/Output/final_output_allyears_fos_r10200.RDS")
r10250 <- readRDS("Rcode/allyears/FOS/Run-b10n250/Output/final_output_allyears_fos_r10250.RDS")

final <- rbind(r1050,r10100,r10150,r10200,r10250)

final.sort.metric <- final[order(final$Metric),]


l<-list("Output"=final, "Metric_sort"=final.sort.metric)
write.xlsx(l, "Rcode/allyears/FOS/final_model_output_allruns_fos_allyears.xlsx")


# age frequency #######
af1050 <- readRDS("Rcode/allyears/FOS/Run-b10n50/Output/af_metrics_long_fos_r1050.rds") # change to where you want to save output file
af10100 <- readRDS("Rcode/allyears/FOS/Run-b10n100/Output/af_metrics_long_fos_r10100.rds") # change to where you want to save output file
af10150 <- readRDS("Rcode/allyears/FOS/Run-b10n150/Output/af_metrics_long_fos_r10150.rds") # change to where you want to save output file
af10200 <- readRDS("Rcode/allyears/FOS/Run-b10n200/Output/af_metrics_long_fos_r10200.rds") # change to where you want to save output file
af10250 <- readRDS("Rcode/allyears/FOS/Run-b10n250/Output/af_metrics_long_fos_r10250.rds") # change to where you want to save output file

af.all <- rbind(af1050,af10100,af10150,af10200,af10250)
saveRDS(af.all, "Rcode/allyears/FOS/af_all_fos_allyears.RDS")


# age length keys #########
alk1050 <- readRDS("Rcode/allyears/FOS/Run-b10n50/Output/alk_data_all_r1050.rds")
alk10100 <- readRDS("Rcode/allyears/FOS/Run-b10n100/Output/alk_data_all_r10100.rds")
alk10150 <- readRDS("Rcode/allyears/FOS/Run-b10n150/Output/alk_data_all_r10150.rds")
alk10200 <- readRDS("Rcode/allyears/FOS/Run-b10n200/Output/alk_data_all_r10200.rds")
alk10250 <- readRDS("Rcode/allyears/FOS/Run-b10n250/Output/alk_data_all_r10250.rds")

alk.data.all <- rbind(alk1050,alk10100,alk10150,alk10200,alk10250)

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

saveRDS(alk.data.all, "Rcode/allyears/FOS/alk.data.all.fos.rds")

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
ALK_metrics_bin_age$Type <- "FOS"
saveRDS(ALK_metrics_bin_age, "Rcode/allyears/FOS/alk_metrics_bin_age_fos.rds")
