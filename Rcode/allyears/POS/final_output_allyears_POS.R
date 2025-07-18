library(openxlsx)
library(ggplot2)
library(patchwork)
library(tidyverse)

# FINAL OUTPUT FOR ALL RUNS FOR ALL YEARS
p10 <- readRDS("Rcode/allyears/POS/10percent/Output/final_output_allyears_pos_10.rds") 
p30 <- readRDS("Rcode/allyears/POS/30percent/Output/final_output_allyears_pos_30.rds") 
p50 <- readRDS("Rcode/allyears/POS/50percent/Output/final_output_allyears_pos_50.rds") 
p70 <- readRDS("Rcode/allyears/POS/70percent/Output/final_output_allyears_pos_70.rds") 
p90 <- readRDS("Rcode/allyears/POS/90percent/Output/final_output_allyears_pos_90.rds") 

final <- rbind(p10,p30,p50,p70,p90)

write.xlsx(final, "Rcode/allyears/POS/final_model_output_allruns_pos_allyears.xlsx")

# age frequency
af10 <- readRDS("Rcode/allyears/POS/10percent/Output/af_metrics_long_pos_10.rds") 
af30 <- readRDS("Rcode/allyears/POS/30percent/Output/af_metrics_long_pos_30.rds") 
af50 <- readRDS("Rcode/allyears/POS/50percent/Output/af_metrics_long_pos_50.rds") 
af70 <- readRDS("Rcode/allyears/POS/70percent/Output/af_metrics_long_pos_70.rds") 
af90 <- readRDS("Rcode/allyears/POS/90percent/Output/af_metrics_long_pos_90.rds") 

af.all <- rbind(af10,af30,af50,af70,af90)
saveRDS(af.all, "Rcode/allyears/POS/af_all_pos_allyears.RDS")


# mean length at age ###
mla30 <- readRDS("Rcode/allyears/POS/30percent/Output/mla_metrics_long_pos_30.rds") # change to where you want to save output file
mla50 <- readRDS("Rcode/allyears/POS/50percent/Output/mla_metrics_long_pos_50.rds") # change to where you want to save output file
mla70 <- readRDS("Rcode/allyears/POS/70percent/Output/mla_metrics_long_pos_70.rds") # change to where you want to save output file
mla90 <- readRDS("Rcode/allyears/POS/90percent/Output/mla_metrics_long_pos_90.rds") # change to where you want to save output file

# age length key
alk10 <- readRDS("Rcode/allyears/POS/10percent/Output/alk_data_all_pos_10.rds")
alk30 <- readRDS("Rcode/allyears/POS/30percent/Output/alk_data_all_pos_30.rds")
alk50 <- readRDS("Rcode/allyears/POS/50percent/Output/alk_data_all_pos_50.rds")
alk70 <- readRDS("Rcode/allyears/POS/70percent/Output/alk_data_all_pos_70.rds")
alk90 <- readRDS("Rcode/allyears/POS/90percent/Output/alk_data_all_pos_90.rds")

alk.data.all <- bind_rows(alk10,alk30,alk50,alk70,alk90)


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

saveRDS(alk.data.all,"Rcode/allyears/POS/alk.data.all.pos.rds")

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
ALK_metrics_bin_age$Type <- "POS"
saveRDS(ALK_metrics_bin_age, "Rcode/allyears/POS/alk_metrics_bin_age_pos.rds")


