#######################################################################
#
#  SIMULATE RANDOM SAMPLE AND AGE LENGTH KEY (ALK) FOR A FISH POPULATION 
#  THE SCRIPT BELOW GENERATES THE REFERENCE POPUALTION AND SAMPLES
#  THE POPULATION USING THREE DIFFERENT OTOLITH SAMPLING SCENARIOS
#
#######################################################################
# 201707
# change the bins for runs here
source("Functions/AgeSampleSize_Functions_ALK_years.R")
run <- "10-20" # change based on run
savefile <- "Rcode/201707/FOS/Run-b10n20/Output/final_output_201707_fos_1020.xlsx" # change to where you want to save output file
saverds <- "Rcode/201707/FOS/Run-b10n20/Output/final_output_201707_fos_1020.rds" # change to where you want to save output file
saverds.af <- "Rcode/201707/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds" # change to where you want to save output file
saverds.mla.ind.model <- "Rcode/201707/FOS/Run-b10n20/Output/mla_ind_model_metrics_long_fos_r1020.rds" # change to where you want to save output file
saverds.mla.ind.pop <- "Rcode/201707/FOS/Run-b10n20/Output/mla_ind_pop_metrics_long_fos_r1020.rds" # change to where you want to save output file
saverds.alk <- "Rcode/201707/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"
saverds.alk.matrix.model <- "Rcode/201707/FOS/Run-b10n20/Output/alk.matrix_model_fos_r1020.rds"
saverds.subset.data <- "Rcode/201707/FOS/Run-b10n20/Output/subset_data_r1020.rds" # change to where you want to save output file

bin=10
bin_n=20
cr=201707 

library(openxlsx)
library(FSA) ## NEEDED IN FUNCTION
library(pbapply) ## for progress bar
library(tidyverse)
library(ggplot2)
library(mgcv)
library(patchwork)

# aged samples
pop <- read.xlsx("Data/Psardine_Data.xlsx")

nsims=1000 ## HOW MANY STOCHASTIC REPLICATES
## THIS FUNCTION RUNS THE SAMPLE SIMULATION FOR 
## THE SPECIFICIED NUMBER OF REPLICATES
## IT IS NOT A PARTICULARLY FAST FUNCTION SO START WITH A 
## FEW SIMS BEFORE SET UP TO RUN 1000S
sims<-pblapply(c(1:nsims) ,function(x)
{
  tmp<-sim_sample(bin=bin,        # bin size in mm        
                  bin_n=bin_n,    # how many fish per bin if FOS
                  sample_type="FOS",
                  supp=NULL
  )      
  tmp[[1]]$rep<-x # age freq
  tmp[[2]]$rep<-x # alk_model
  tmp[[3]]$rep<-x # alk_pop
  tmp[[4]]$rep<-x # alk_data
  tmp[[5]]$rep<-x # alk_matrix
  tmp[[6]]$rep<-x # subset data
  return(tmp)
})


## AGE FREQUENCY ######
af<-lapply(sims,function(x) x[[1]] )  
af<-do.call("rbind",af)
af$MAD_alk_model<- abs(af$Freq_true_model-af$Freq_alk_model)
af$MAPD_alk_model<- abs((af$Freq_true_model-af$Freq_alk_model)/af$Freq_true_model)*100
af$metric <- "Age frequency"
saveRDS(af,saverds.af)

ggplot()+
  geom_boxplot(data=af, aes(x=age,y=Freq_alk_model),fill="white",color="black")+ # subsample data
  stat_summary(data=af,mapping=aes(x=age,y=Freq_alk_model,color="ALK model"),fun="mean", geom="crossbar", width=0.2, show.legend = TRUE)+
  stat_summary(data=af,mapping=aes(x=age,y=Freq_true_model,color="Reference model"),fun="mean", geom="crossbar", width=0.2, show.legend = TRUE)+
  scale_color_manual(values=c("black","blue","red","cyan"), name="Dataset")+
  labs(y="Frequency", x="Age (years)")+
  theme_bw()+
  theme(panel.grid=element_blank(),
        legend.position = "bottom",
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"))


### SUMMARY
AgeFreq_metrics <- af %>%
  group_by(age) %>%
  summarize(bin=as.numeric(NA),
            Metric=unique(metric),
            mean_APD_model = as.numeric(NA),
            mean_MAPD_model = round(mean(MAPD_alk_model,na.rm=TRUE),2),
            count_under_5_model = sum(MAPD_alk_model<5,na.rm=TRUE),
            percent_under_5_model = (count_under_5_model/nsims)*100,
            count_under_10_model = sum(MAPD_alk_model<10,na.rm=TRUE),
            percent_under_10_model = (count_under_10_model/nsims)*100)%>%
  relocate(bin)
AgeFreq_metrics

ggplot()+
  geom_point(data=AgeFreq_metrics, mapping=aes(x=age,y=percent_under_10_model,color="Model"))+
  scale_color_manual(values=c("black","red","blue"))+
  labs(y="Percent instances under 10%",x="Age (years)",color="Type")+
  geom_hline(yintercept=90)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))


# individual mla #####
mla.ind.model <- lapply(sims,function(x) x[[2]])
mla.ind.model<-do.call("rbind",mla.ind.model) 
mla.ind.model$run <- run
saveRDS(mla.ind.model,saverds.mla.ind.model)

# full population 
individualALK_pop <- lapply(sims,function(x) x[[3]])
individualALK_pop<-do.call("rbind",individualALK_pop) 
saveRDS(individualALK_pop,saverds.mla.ind.pop)

# AGE LENGTH KEY #########
ALK_data_all <- lapply(sims,function(x) x[[4]] )  
ALK_data_all<-do.call("rbind",ALK_data_all)    
ALK_data_all$MAPD_model<- abs((ALK_data_all$Freq_true_model-ALK_data_all$Freq_sub_model)/ALK_data_all$Freq_true_model)*100
ALK_data_all$metric <- "Age length key"
ALK_data_all$run <- run
saveRDS(ALK_data_all,saverds.alk)

ALK_metrics_bin_age <- ALK_data_all %>%
  group_by(bin,age) %>%
  summarize(Metric=unique(metric),
            mean_APD_model = as.numeric(NA),
            mean_MAPD_model = round(mean(MAPD_model,na.rm=TRUE),2),
            count_under_5_model = sum(MAPD_model<5,na.rm=TRUE),
            percent_under_5_model = (count_under_5_model/nsims)*100,
            count_under_10_model = sum(MAPD_model<10,na.rm=TRUE),
            percent_under_10_model = (count_under_10_model/nsims)*100)
ALK_metrics_bin_age

ggplot(ALK_metrics_bin_age, aes(x=bin,y=percent_under_10_model))+
  geom_point()+
  labs(y="Percent instances under 5%",x="Bin (SL mm)",title=paste("ALK",run))+
  scale_x_continuous(breaks=seq(30,300,20))+
  geom_hline(yintercept=90,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_wrap(~age,ncol=2)

alk.true.model <- ggplot(subset(ALK_data_all,rep==1), aes(x=bin,y=age,fill=Freq_true_model))+
  geom_tile()+
  scale_x_continuous(expand = c(0,0),breaks=seq(30,300,20))+
  scale_y_discrete(expand = c(0,0))+
  scale_fill_viridis_c(option="H", limits=c(0,1),breaks=seq(0,1,0.25))+
  labs(x="Standard length (mm)", y="Age (years)",title="Reference")+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        legend.title = element_blank())+
  guides(fill = guide_colourbar(barwidth = 0.5, barheight = 15))  
alk.true.model

alk.sub.model <- ggplot(subset(ALK_data_all,rep==1), aes(x=bin,y=age,fill=Freq_sub_model))+
  geom_tile()+
  scale_x_continuous(expand = c(0,0),breaks=seq(30,300,20))+
  scale_y_discrete(expand = c(0,0))+
  scale_fill_viridis_c(option="H", limits=c(0,1),breaks=seq(0,1,0.25))+
  labs(x="Standard length (mm)", y="Age (years)",title="ALK")+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        legend.title = element_blank())+
  guides(fill = guide_colourbar(barwidth = 0.5, barheight = 15))  
alk.sub.model

alk.true.model + alk.sub.model + plot_annotation(title="Model")

ALK_matrix_model <- lapply(sims,function(x) x[[5]] )  
ALK_matrix_model<-do.call("bind_rows",ALK_matrix_model)    
saveRDS(ALK_matrix_model,saverds.alk.matrix.model)

# subset data ######
subset_data <- lapply(sims,function(x) x[[6]] )  
subset_data<-do.call("bind_rows",subset_data)    
saveRDS(subset_data,saverds.subset.data)

# final output ########
final_output <- bind_rows(AgeFreq_metrics,ALK_metrics_bin_age)
final_output$Run <- run

saveRDS(final_output,saverds)
write.xlsx(final_output,savefile)