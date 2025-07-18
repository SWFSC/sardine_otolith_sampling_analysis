### Final figures for Schwartzkopf et al. 
library(openxlsx)
library(tidyverse)
library(mgcv)
library(patchwork)
library(viridis)

### set up data ######
bin=10

sardine <- read.xlsx("Data/Psardine_Data.xlsx")
pop <- sardine %>%
  mutate(len_obs=standardLength_mm,#rename length to len_obs, I've just made a new column
         age_f=as.factor(age))# MAKE A FACTOR

## ASSIGN LENGTH BINS
bins<-seq(from=min(pop$len_obs),to=max(pop$len_obs)+bin,
          by=bin)
pop$bin<-cut(pop$len_obs,
             breaks=bins,
             labels=bins[-length(bins)],
             right=FALSE,
             include.lowest = TRUE)
pop$bin<- factor(pop$bin, levels=bins[-length(bins)]) # need bin factor for most everything 
pop$bin_num <- as.numeric(as.character(pop$bin))
length(unique(pop$bin_num))
table(pop$bin)

# TABLE 1 #######
bin_count <- pop %>%
  group_by(cruise) %>%
  summarise(samp_size=length(unique(id)),
            bin_count=length(unique(bin_num)))

# year specific ages
sardine.aged <- pop %>% 
  filter(cruise %in% c(200404,200504,200704,200807,200904,201104,201207,201307,201707,201807,201907,202107))%>%
  mutate(year=substr(cruise,1,4))

# TABLE 2 #######
# sample size data 
sub.data.all <- readRDS("Rcode/allyears/sub.data.allyears.rds")

sub.data.sample.size <- sub.data.all %>% 
  group_by(Type,run.label) %>%
  summarise(sample_size=length(age))

sub.data.all.yr<-readRDS("Rcode/year_comparisons/sub.data.all.yr.rds")

sub.data.sample.size.yr <- sub.data.all.yr %>% 
  group_by(year,Type,run.label) %>%
  summarise(sample_size=length(age))


### Figure 1 #######
sl.plot <- ggplot(pop, aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20))+
  scale_y_continuous(breaks=seq(0,1500,250))+
  labs(x="Standard length (mm)", y="Frequency")+
  #geom_hline(yintercept=30)+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))
sl.plot

R = length(unique(pop$age)) # number of age categories

pop$age.ordinal <- pop$age+1 # gam model needs non 0 numbers so add 1

pop$f.age.ordinal <- as.factor(pop$age.ordinal)

# TRUE VALUES: POPULATION LEVEL
model <- gam(age.ordinal ~ s(standardLength_mm) , data = pop , family= ocat(R= R)) #

prob.matrix <- predict(model , newdata = data.frame(standardLength_mm = seq(min(pop$bin_num),max(pop$bin_num), by=10)), type = "response")

af_model<-as.data.frame(c(prop.table(t(prob.matrix) %*% table(pop$bin)))); colnames(af_model)<-"Freq_true_model"
af_model <- af_model %>% 
  mutate(age=as.factor(seq(min(pop$age),max(pop$age),1))) %>%
  relocate(age)

age.plot <- ggplot(af_model,aes(x=age,y=Freq_true_model))+
  geom_bar(stat="identity",color="black",fill="black")+
  scale_y_continuous(breaks=seq(0.05,0.3,0.05), limits=c(0,0.31))+
  labs(x="Age (years)", y="Proportion")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))
age.plot

sl.plot+age.plot + plot_annotation(tag_levels="a",tag_suffix=")") &
  theme(plot.tag = element_text(family = 'serif'))

xlabels <- sort(unique(bins))
xlabels[seq(2, length(xlabels), 2)] <- NA


age.len <- ggplot(pop,aes(x=bin, y=age))+
  geom_jitter()+
  scale_y_continuous(breaks=seq(0,8,1))+
  #scale_x_continuous(breaks=seq(30,290,20))+
  labs(y="Age (years)", x="Standard length (mm)")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))
age.len

pdf(file="Figures/Fig1.pdf",height=8,width=10)
(sl.plot+age.plot) / age.len + plot_annotation(tag_levels="a",tag_suffix=")") &
  theme(plot.tag = element_text(family = 'serif'))
dev.off()

# Figure 2 ########
fos <- read.xlsx("Rcode/allyears/FOS/final_model_output_allruns_fos_allyears.xlsx", sheet="Metric_sort");fos$Type <- "FOS"
pos <- read.xlsx("Rcode/allyears/POS/final_model_output_allruns_pos_allyears.xlsx");pos$Type <- "POSs"
hy <- read.xlsx("Rcode/allyears/Hybrid/final_model_output_allruns_hy_allyears.xlsx", sheet="Metric_sort");hy$Type <- "Hybrid"

final <- bind_rows(fos,pos,hy)
final <- final %>%
  mutate(run.label=case_match(Run,"10-50"~"50","10-100"~"100","10-150"~"150","10-200"~"200","10-250"~"250",
                              "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=Run),
         run.label = factor(run.label, levels=c("50","100","150","200","250","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%")),
          Type =factor(Type, levels = c("FOS","POSs","Hybrid")))  

af <- subset(final, Metric=="Age frequency")
af <- left_join(af,sub.data.sample.size)

af.all.fos <- readRDS("Rcode/allyears/FOS/af_all_fos_allyears.RDS");af.all.fos$Type <- "FOS"
af.all.pos <- readRDS("Rcode/allyears/POS/af_all_pos_allyears.RDS"); af.all.pos$Type <- "POSs" 
af.all.hy <- readRDS("Rcode/allyears/Hybrid/af_all_hy_allyears.RDS"); af.all.hy$Type <- "Hybrid"

af.all <- bind_rows(af.all.fos,af.all.pos,af.all.hy)
af.all <- af.all %>%
  mutate(run.label=case_match(run,"10-50"~"50","10-100"~"100","10-150"~"150","10-200"~"200","10-250"~"250",
                              "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=run),
         run.label = factor(run.label, levels=c("50","100","150","200","250","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%")),
         Type = factor(Type,levels=c("FOS","POSs","Hybrid")))
af.all <- left_join(af.all, sub.data.sample.size)

mapd.by.run.af <- af.all %>%
  group_by(Type,run.label) %>%
  summarise(mapd_model=round(mean(MAPD_alk_model, na.rm=T),1),
            var_apd = var(MAPD_alk_model,na.rm=T),
            sd_apd = sd(MAPD_alk_model,na.rm=T),
            lo.qt = quantile(MAPD_alk_model,c(0.25), na.rm=TRUE),
            hi.qt = quantile(MAPD_alk_model,c(0.75), na.rm=TRUE),
            sample_size=unique(sample_size)) %>%
  mutate(mapd_label = paste("MAPD = ", mapd_model),
         lab.ss = paste("n = ", sample_size))

count.by.run.af <- af %>%
  group_by(Type,run.label, sample_size) %>%
  summarise(#mean_percent5_model=round(mean(percent_under_5_model),1),
    mean_percent10_model=round(mean(percent_under_10_model),1))%>%
  mutate(#lab.model5 = paste("x\u0305 = ", mean_percent5_model),
    lab.model10 = paste("x\u0305 = ", mean_percent10_model),
    lab.ss = paste("n = ", sample_size))
    
af.metric10.run.plot.fos <- ggplot()+
  geom_point(data=subset(af,Type=="FOS"), mapping=aes(x=age,y=percent_under_10_model))+
  scale_color_manual(values=c("black","red"))+
  labs(y="Percent APD under 10% (Reliability)",x="Age (years)",color="Type")+
  scale_y_continuous(limits=c(0,100), breaks=seq(0,100,20))+
  geom_hline(yintercept=80,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(mapd.by.run.af,Type=="FOS"),aes(x = 2, y = 15, label = lab.ss),size=2.5)+
  geom_text(data=subset(mapd.by.run.af,Type=="FOS"),aes(x = 2, y = 5, label = mapd_label),size=2.5)
af.metric10.run.plot.fos

af.metric10.run.plot.pos <- ggplot()+
  geom_point(data=subset(af,Type=="POSs"), mapping=aes(x=age,y=percent_under_10_model))+
  scale_color_manual(values=c("black","red"))+
  labs(y="Percent instances under 10% (Reliability)",x="Age (years)",color="Type")+
  scale_y_continuous(limits=c(0,100), breaks=seq(0,100,20))+
  geom_hline(yintercept=80,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_blank(),#element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(mapd.by.run.af,Type=="POSs"),aes(x = 2, y = 15, label = lab.ss),size=2.5)+
  geom_text(data=subset(mapd.by.run.af,Type=="POSs"),aes(x = 2, y = 5, label = mapd_label),size=2.5)  
af.metric10.run.plot.pos

af.metric10.run.plot.hy <- ggplot()+
  geom_point(data=subset(af,Type=="Hybrid"), mapping=aes(x=age,y=percent_under_10_model))+
  scale_color_manual(values=c("black","red"))+
  labs(y="Percent instances under 10% (Reliability)",x="Age (years)",color="Type")+
  scale_y_continuous(limits=c(0,100), breaks=seq(0,100,20))+
  geom_hline(yintercept=80,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_blank(),#element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(mapd.by.run.af,Type=="Hybrid"),aes(x = 2, y = 15, label = lab.ss),size=2.5)+
  geom_text(data=subset(mapd.by.run.af,Type=="Hybrid"),aes(x = 2, y = 5, label = mapd_label),size=2.5)  
af.metric10.run.plot.hy

pdf(file="Figures/Fig2.pdf",width=9,height=8)
af.metric10.run.plot.fos + af.metric10.run.plot.pos + af.metric10.run.plot.hy + plot_layout(guides="collect") & theme(legend.position = "bottom")
dev.off()

## Data set up for Figure 3 & 4 #########
alk.fos <- readRDS("Rcode/allyears/FOS/alk_metrics_bin_age_fos.rds"); alk.fos$Type <- "FOS"
alk.pos <- readRDS("Rcode/allyears/POS/alk_metrics_bin_age_pos.rds"); alk.pos$Type <- "POSs"
alk.hy <- readRDS("Rcode/allyears/Hybrid/alk_metrics_bin_age_hy.rds"); alk.hy$Type <- "Hybrid"

alk <- rbind(alk.fos,alk.pos,alk.hy)
alk <- alk %>%
  mutate(run.label=case_match(run,"10-50"~"50","10-100"~"100","10-150"~"150","10-200"~"200","10-250"~"250",
                              "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=run),
         run.label = factor(run.label, levels=c(levels=c("50","100","150","200","250","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%"))))
         
alk.data.all.fos <- readRDS("Rcode/allyears/FOS/alk.data.all.fos.rds"); alk.data.all.fos$Type <- "FOS"
alk.data.all.pos <- readRDS("Rcode/allyears/POS/alk.data.all.pos.rds"); alk.data.all.pos$Type <- "POSs"
alk.data.all.hy <- readRDS("Rcode/allyears/Hybrid/alk.data.all.hy.rds"); alk.data.all.hy$Type <- "Hybrid"

alk.data.all <- rbind(alk.data.all.fos,alk.data.all.pos,alk.data.all.hy )
alk.data.all <- alk.data.all %>%
  mutate(run.label=case_match(run,"10-50"~"50","10-100"~"100","10-150"~"150","10-200"~"200","10-250"~"250",
                              "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=run),
         run.label = factor(run.label, levels=c(levels=c("50","100","150","200","250","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%"))))
alk.data.all <- left_join(alk.data.all, sub.data.sample.size)

mapd.by.run.alk <- alk.data.all %>%
  group_by(Type,run.label) %>%
  summarise(mapd_model=round(mean(MAPD_model_new, na.rm=T),1),
            var_apd = var(MAPD_model_new,na.rm=T),
            sd_apd = sd(MAPD_model_new,na.rm=T),
            lo.qt = quantile(MAPD_model_new,c(0.25), na.rm=TRUE),
            hi.qt = quantile(MAPD_model_new,c(0.75), na.rm=TRUE),
            sample_size=unique(sample_size)) %>%
  mutate(mapd_label = paste("MAPD = ", mapd_model),
         lab.ss = paste("n = ", sample_size))

count.by.run.alk.new <- alk %>%
  group_by(run,Type) %>%
  summarise(#mean_percent5_model=round(mean(percent_under_5_model),1),
    mean_percent10_model_new=round(mean(percent_under_10_model_new),1))%>%
  mutate(#lab.model5 = paste("x\u0305 = ", mean_percent5_model),
    lab.model10 = paste("x\u0305 = ", mean_percent10_model_new))

mapd.by.run.af$Metric <- "Age composition" # This is made in Figure 3
mapd.by.run.alk$Metric <- "Proportion age-at-length"
mapd.by.run.af.alk <- rbind(mapd.by.run.af,mapd.by.run.alk)
mapd.by.run.af.alk$Type <- factor(mapd.by.run.af.alk$Type, levels = c("FOS","POSs","Hybrid"))  

# Figure 3 #######
pdf(file="Figures/Fig3.pdf",width=7,height=4)
ggplot(mapd.by.run.af.alk,aes(y=mapd_model,x=sample_size, color=Type,shape=Type))+
  geom_point()+
  geom_hline(yintercept = 10, lty=2)+
  geom_errorbar(aes(x=sample_size,ymin=lo.qt,ymax=hi.qt),width=0.1)+
  scale_color_manual(values=c("#999933","#661100","#88ccEE"))+
  labs(x="Otolith sample size",y="Absolute percent deviation (%)", color="Strategy",shape="Strategy")+
  scale_y_continuous(breaks=c(1,5,10,15,20,25))+
  scale_x_continuous(limits=c(0,9000),breaks=c(0,1000,3000,5000,7000,9000))+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"),
        legend.position = "bottom")+
  facet_wrap(~Metric)
dev.off()

### Figure 4 #######

alk.metric.run.plot10.fos.new <- ggplot()+
  geom_point(data=subset(alk,Type=="FOS"), mapping=aes(x=bin,y=percent_under_10_model_new, color=age))+
  scale_color_viridis_d(option="D",direction=-1)+
  labs(y="Percent APD under 10% (Reliability)",x="Standard length (mm)",color="Age")+
  scale_y_continuous(limits=c(0,100), breaks=seq(0,100,20))+
  scale_x_continuous(limits=c(30,290),breaks=seq(30,300,20))+
  geom_hline(yintercept=80,lty=2)+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        strip.text = element_text(size=14),
        axis.title.y = element_text(size=14,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=14,margin=margin(t=10,r=0,b=0,l=0)),
        axis.text.x = element_text(size=12,angle=45,hjust=1),
        axis.text.y = element_text(size=12),
        plot.title = element_text(hjust=0.5),
        legend.position = "bottom")+
  guides(color=guide_legend(nrow =1))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(mapd.by.run.alk,Type=="FOS"),aes(x = 48, y = 20, label = lab.ss),size=2.5)+
  geom_text(data=subset(mapd.by.run.alk,Type=="FOS"),aes(x = 48, y = 10, label = mapd_label),size=2.5)
alk.metric.run.plot10.fos.new

alk.metric.run.plot10.pos.new <- ggplot()+
  geom_point(data=subset(alk,Type=="POSs"), mapping=aes(x=bin,y=percent_under_10_model_new, color=age))+
  scale_color_viridis_d(option="D",direction=-1)+
  labs(y="Percent APD under 10% (Reliability)",x="Standard length (mm)",color="Age")+
  scale_y_continuous(limits=c(0,100), breaks=seq(0,100,20))+
  scale_x_continuous(limits=c(30,290),breaks=seq(30,300,20))+
  geom_hline(yintercept=80,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        strip.text = element_text(size=14),
        axis.title.y = element_blank(),#element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.text.y = element_text(size=12),
        axis.title.x = element_text(size=14,margin=margin(t=10,r=0,b=0,l=0)),
        axis.text.x = element_text(size=12,angle=45,hjust=1),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"))+
  guides(color=guide_legend(nrow =1))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(mapd.by.run.alk,Type=="POSs"),aes(x = 48, y = 20, label = lab.ss),size=2.5)+
  geom_text(data=subset(mapd.by.run.alk,Type=="POSs"),aes(x = 48, y = 10, label = mapd_label),size=2.5)
alk.metric.run.plot10.pos.new

alk.metric.run.plot10.hy.new <- ggplot()+
  geom_point(data=subset(alk,Type=="Hybrid"), mapping=aes(x=bin,y=percent_under_10_model_new, color=age))+
  scale_color_viridis_d(option="D",direction=-1)+
  labs(y="Percent APD under 10% (Reliability)",x="Standard length (mm)",color="Age")+
  scale_y_continuous(limits=c(0,100), breaks=seq(0,100,20))+
  scale_x_continuous(limits=c(30,290),breaks=seq(30,300,20))+
  geom_hline(yintercept=80,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        strip.text = element_text(size=14),
        axis.title.y = element_blank(),#element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.text.y = element_text(size=12),
        axis.title.x = element_text(size=14,margin=margin(t=10,r=0,b=0,l=0)),
        axis.text.x = element_text(size=12,angle=45,hjust=1),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"))+
  guides(color=guide_legend(nrow =1))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(mapd.by.run.alk,Type=="Hybrid"),aes(x = 48, y = 20, label = lab.ss),size=2.5)+
  geom_text(data=subset(mapd.by.run.alk,Type=="Hybrid"),aes(x = 48, y = 10, label = mapd_label),size=2.5)
alk.metric.run.plot10.hy.new

pdf(file="Figures/Fig4.pdf",width=12,height=10)
alk.metric.run.plot10.fos.new+alk.metric.run.plot10.pos.new + alk.metric.run.plot10.hy.new + 
        plot_layout(guides = "collect") & 
          theme(legend.position = "bottom", legend.text = element_text(size=12), 
                legend.title = element_text(size=14),legend.key.width = unit(20, "point"))&
  guides(colour = guide_legend(override.aes = list(size=3), nrow=1))
dev.off()


# ## Data set up for Figures 5-8 #######
final.yr <- readRDS("Rcode/year_comparisons/final.sort.metric.RDS")

final.yr <- final.yr %>%
    mutate(run.label=case_match(Run,"10-10"~"10","10-20"~"20","10-30"~"30","10-40"~"40","10-50"~"50",
                                "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=Run))
final.yr$Run <- factor(final.yr$run.label, levels=c("10","20","30","40","50","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%"))
final.yr$Type <- factor(final.yr$Type, levels = c("FOS","POSs","Hybrid"))  
  
bin_count.yr <- sardine.aged %>%
    filter(!is.na(age)) %>%
    mutate(uniq= 1:n())%>%
    group_by(year) %>%
    summarise(samp_size=length(unique(uniq)),
              bin_count=length(unique(bin_num)))
  
final.yr <- left_join(final.yr,bin_count.yr)
  
col.pal <- rep(c("#DDCC77","#a1dab4","#41b6c4","#2c7fb8","#253494"),3)
  
# age freq
af.yr <- subset(final.yr, Metric=="Age frequency")

af.all.yr <- readRDS("Rcode/year_comparisons/af.all.RDS")
   
  
af.all.yr$af_percent <- af.all.yr$Freq_true_model*100
af.all.yr$Type <- factor(af.all.yr$Type, levels = c("FOS","POSs","Hybrid"))  
af.all.yr <- af.all.yr %>%
    mutate(run.label=case_match(run,"10-10"~"10","10-20"~"20","10-30"~"30","10-40"~"40","10-50"~"50",
                                "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=run))
  
af.true.yr <- subset(af.all.yr, rep==1 & run.label %in% c("50","50%","30+10%"))

count.by.run.af.yr <- af.yr %>%
    group_by(year,Type,Run) %>%
    summarise(mean_percent5_model=round(mean(percent_under_5_model),1),
              mean_percent10_model=round(mean(percent_under_10_model),1),
              bin_count=unique(bin_count),
              samp_size=unique(samp_size))%>%
    mutate(lab.model5 = paste("x\u0305 = ", mean_percent5_model),
           lab.model10 = paste("x\u0305 = ", mean_percent10_model))
  
af.full.yr <- left_join(af.yr,count.by.run.af.yr)
  
af.full.yr <- left_join(af.full.yr,sub.data.sample.size.yr)
  
af.full.yr <- af.full.yr %>% 
    mutate(run.label=case_match(Run,"10"~"10/10%/30+10%","20"~"20/30%/30+30%","30"~"30/50%/30+50%","40"~"40/70%/40+30%","50"~"50/90%/40+50%",
                                "10%"~"10/10%/30+10%","30%"~"20/30%/30+30%","50%"~"30/50%/30+50%","70%"~"40/70%/40+30%","90%"~"50/90%/40+50%",
                                "30+10%"~"10/10%/30+10%","30+30%"~"20/30%/30+30%","30+50%"~"30/50%/30+50%","40+30%"~"40/70%/40+30%","40+50%"~"50/90%/40+50%",.default=Run),
           Run=factor(Run,levels=c("10","20","30","40","50","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%")),
           Type=factor(Type,levels = c("FOS","POSs","Hybrid")),
           samp_size_percent=round((sample_size/samp_size)*100,0))
  

mean.af.yr <- af.yr %>%
    group_by(year,Run) %>%
    summarise(mean_perc10 = mean(percent_under_10_model)) %>%
    mutate(Metric="Age composition")

# alk 
alk.yr <- subset(final.yr, Metric=="Age length key")
  
mean.alk.yr <- alk.yr %>%
    group_by(year,Run) %>%
    summarise(mean_perc10 = mean(percent_under_10_model)) %>%
    mutate(Metric="Proportion age-at-length")
  
mean.af.alk.yr <- rbind(mean.af.yr,mean.alk.yr)

alk.data.yr.fph <- readRDS("Rcode/year_comparisons/alk.data.all.RDS")

alk.data.yr.fph <- alk.data.yr.fph %>%
  mutate(run.label=case_match(run,"10-10"~"10","10-20"~"20","10-30"~"30","10-40"~"40","10-50"~"50",
                              "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=run),
          Type=factor(Type, levels = c("FOS","POSs","Hybrid")))
alk.data.yr.fph <- left_join(alk.data.yr.fph, sub.data.sample.size.yr)

### Figure 5 ######
pdf(file="Figures/Fig5.pdf",width=7.4,height=11)
ggplot()+
  geom_histogram(data=af.true.yr, aes(x=age,y=af_percent),stat="identity",fill="grey88")+
  geom_point(data=af.full.yr, mapping=aes(x=age,y=percent_under_10_model,color=run.label, shape=run.label))+
  scale_color_manual(values=col.pal)+
   scale_shape_manual(values=c(16, 17, 15,8,7))+
    labs(y="Percent APD under 10% (Reliability)",x="Age (years)",color="Scenario",shape="Scenario")+
    geom_hline(yintercept=80,lty=2)+
    theme_bw()+
    theme(strip.background = element_rect(fill="white"),
          panel.grid=element_blank(),
          axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
          axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
          plot.title = element_text(hjust=0.5),
          legend.position = "bottom",
          legend.margin = margin(0, 0, 0, 0),
          legend.key.spacing.x = unit(5, "pt"),
          legend.title = element_text(margin=margin(0,0,0,-3)))+
    facet_grid(year~Type)
dev.off()

# Figure 6 #### 
pdf(file="Figures/Fig6.pdf",width=11,height=8)
  ggplot(mean.af.alk.yr, aes(x=Run,y=mean_perc10, color=Metric,shape=Metric))+
    geom_point()+
    labs(y="Percent APD under 10% (Reliability)",x="Scenario")+
    scale_color_manual(values=c("black","darkgrey"))+
    geom_hline(yintercept=80,lty=2)+
    theme_bw()+
    theme(strip.background = element_rect(fill="white"),
          panel.grid=element_blank(),
          axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
          axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
          plot.title = element_text(hjust=0.5),
          axis.text.x = element_text(angle=45,hjust=1),
          legend.position = "bottom")+
    facet_wrap(~year,ncol=3)
dev.off()  

# Figures 7 and 8 ####
af.all.yr.ss <- left_join(af.all.yr,sub.data.sample.size.yr)

mapd.by.run.af.yr <- af.all.yr.ss %>%
  group_by(Type,run.label,year) %>%
  summarise(mapd_model=round(mean(MAPD_alk_model, na.rm=T),1),
            var_apd = var(MAPD_alk_model,na.rm=T),
            sd_apd = sd(MAPD_alk_model,na.rm=T),
            lo.qt = quantile(MAPD_alk_model,c(0.25), na.rm=TRUE),
            hi.qt = quantile(MAPD_alk_model,c(0.75), na.rm=TRUE),
            sample_size=unique(sample_size)) %>%
  mutate(lab.model10 = paste("MAPD = ", mapd_model),
         lab.ss = paste("n = ", sample_size),
         Metric = "Age composition",
         Type = factor(Type, levels = c("FOS","POSs","Hybrid")))

alk.all.yr.ss <- left_join(alk.data.yr.fph,sub.data.sample.size.yr)

mapd.by.run.alk.yr <- alk.all.yr.ss %>%
  group_by(Type,run.label,year) %>%
  summarise(mapd_model=round(mean(MAPD_new, na.rm=T),1),
            var_apd = var(MAPD_new,na.rm=T),
            sd_apd = sd(MAPD_new,na.rm=T),
            lo.qt = quantile(MAPD_new,c(0.25), na.rm=TRUE),
            hi.qt = quantile(MAPD_new,c(0.75), na.rm=TRUE),
            sample_size=unique(sample_size)) %>%
  mutate(lab.model10 = paste("MAPD = ", mapd_model),
         lab.ss = paste("n = ", sample_size),
         Metric = "Proportion age at length",
         Type = factor(Type, levels = c("FOS","POSs","Hybrid")))

pdf(file="Figures/Fig7.pdf",width=6,height=8)
ggplot(mapd.by.run.af.yr,aes(y=mapd_model,x=sample_size, color=Type,shape=Type))+
  geom_point()+
  geom_errorbar(aes(x=sample_size,ymin=lo.qt,ymax=hi.qt),width=0.1)+
  scale_color_manual(values=c("#999933","#661100","#88ccEE"))+
  labs(x="Otolith sample size",y="Absolute percent deviation (%)", color="Strategy",shape="Strategy")+
  scale_x_continuous(limits=c(0,900),breaks=seq(0,900,100))+
  geom_hline(yintercept=10,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"),
        legend.position = "bottom")+
  facet_wrap(~year, scales="free_y",ncol=2)
dev.off()

pdf(file="Figures/Fig8.pdf",width=6,height=8)
ggplot(mapd.by.run.alk.yr,aes(y=mapd_model,x=sample_size, color=Type,shape=Type))+
  geom_point()+
  geom_errorbar(aes(x=sample_size,ymin=lo.qt,ymax=hi.qt),width=0.1)+
  scale_color_manual(values=c("#999933","#661100","#88ccEE"))+
  labs(x="Otolith sample size",y="Absolute percent deviation (%)", color="Strategy",shape="Strategy")+
  scale_x_continuous(limits=c(0,900),breaks=seq(0,900,100))+
  geom_hline(yintercept=10,lty=2)+
  theme_bw()+
  theme(panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5),
        strip.background = element_rect(fill="white"),
        legend.position = "bottom")+
  facet_wrap(~year, scales="free_y",ncol=2)
dev.off()

### supplementary material #####
# S1
sub.data.all <- readRDS("Rcode/allyears/sub.data.allyears.rds")

sub.data.sample.size <- sub.data.all %>% 
  group_by(Type,run.label) %>%
  summarise(sample_size=length(age))%>%
  mutate(lab.ss = paste("n = ", sample_size))

# fos 
sub.count.fos <- ggplot(data=subset(sub.data.all,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20))+
  scale_y_continuous(limits=c(0,255),breaks=seq(0,250,50))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size,Type=="FOS"),aes(x = 50, y = 235, label = lab.ss),size=2.5)
sub.count.fos 

#pos2
sub.count.pos <- ggplot(data=subset(sub.data.all,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20))+
  scale_y_continuous(limits=c(0,1500), breaks=seq(0,1500,500))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size,Type=="POSs"),aes(x = 50, y = 1355, label = lab.ss),size=2.5)
sub.count.pos

#hybrid
sub.count.hy <- ggplot(data=subset(sub.data.all,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size,Type=="Hybrid"),aes(x = 50, y = 700, label = lab.ss),size=2.5)
sub.count.hy

sub.count.fos+sub.count.pos+sub.count.hy
ggsave("Figures/FigS1.jpeg",width=12,height=8,dpi=600)

# S2
# count of SL by bin for each year
ggplot(sardine.aged, aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_wrap(~year,scales="free_y",ncol=2)

ggsave("Figures/FigS2.jpeg",width=8,height=11, dpi=300)

# S3
y04 <- subset(sardine.aged,year==2004 & bin_num==240)
table(y04$bin_num, y04$age)
length(unique(y04$age))

yr.bin.age <- sardine.aged %>%
  group_by(year,bin_num)%>%
  summarise(age.count=length(unique(age)))
  
ggplot(sardine.aged,aes(x=bin_num, y=age))+
  geom_jitter()+
  scale_y_continuous(breaks=seq(0,8,1))+
  scale_x_continuous(breaks=seq(80,290,10))+
  labs(y="Age (years)", x="Standard length (mm)")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        axis.text.x = element_text(angle=45,hjust=1),
        plot.title = element_text(hjust=0.5))+
  facet_wrap(~year,ncol=3)

ggsave("Figures/FigS3.jpeg",height=8,width=12)
ggsave("Figures/FigS3.eps",height=8,width=12,dpi=1200, device=cairo_ps())

# S4 

sub.data.all.yr<-readRDS("Rcode/year_comparisons/sub.data.all.yr.rds")%>%
  select(uniq,year,run,run.label,Type,bin_num)%>%
  add_row(uniq="test",year="2004",run="10%",run.label="10%",Type="POSs",bin_num=NA)%>%
  add_row(uniq="test",year="2018",run="10%",run.label="10%",Type="POSs",bin_num=NA)%>%
  add_row(uniq="test",year="2021",run="10%",run.label="10%",Type="POSs",bin_num=NA)

sub.data.sample.size.yr <- sub.data.all.yr %>% 
  group_by(year,Type,run.label) %>%
  summarise(sample_size=length(na.omit(bin_num)))%>%
  mutate(lab.ss = paste("n = ", sample_size))

# 200404
sub.data.all.yr2004 <- subset(sub.data.all.yr, year==2004)
bin_count2004 <- sub.data.all.yr2004 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2004 <- subset(sub.data.sample.size.yr, year==2004)

# fos 
sub.count.fos2004 <- ggplot(data=subset(sub.data.all.yr2004,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2004,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2004 <- ggplot(data=subset(sub.data.all.yr2004,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2004,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2004,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2004,Type=="POSs"& year==2004),aes(x = 50, y = max(subset(bin_count2004,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2004 <- ggplot(data=subset(sub.data.all.yr2004,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2004,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2004,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2004,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2004,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2004<-sub.count.fos2004+sub.count.pos2004+sub.count.hy2004+ plot_annotation(title="2004") & theme(plot.title = element_text(hjust=0.5))
plot2004
ggsave(plot=plot2004,"Figures/FigS4_2004.jpeg",width=12,height=8,dpi=600)


# 200504
sub.data.all.yr2005 <- subset(sub.data.all.yr, year==2005)
bin_count2005 <- sub.data.all.yr2005 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2005 <- subset(sub.data.sample.size.yr, year==2005)

# fos 
sub.count.fos2005 <- ggplot(data=subset(sub.data.all.yr2005,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2005,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2005 <- ggplot(data=subset(sub.data.all.yr2005,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2005,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2005,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2005,Type=="POSs"& year==2005),aes(x = 50, y = max(subset(bin_count2005,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2005 <- ggplot(data=subset(sub.data.all.yr2005,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2005,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2005,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2005,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2005,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2005<-sub.count.fos2005+sub.count.pos2005+sub.count.hy2005+ plot_annotation(title="2005") & theme(plot.title = element_text(hjust=0.5))
plot2005
ggsave(plot=plot2005,"Figures/FigS4_2005.jpeg",width=12,height=8,dpi=600)


# 200704
sub.data.all.yr2007 <- subset(sub.data.all.yr, year==2007)
bin_count2007 <- sub.data.all.yr2007 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2007 <- subset(sub.data.sample.size.yr, year==2007)

# fos 
sub.count.fos2007 <- ggplot(data=subset(sub.data.all.yr2007,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2007,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2007 <- ggplot(data=subset(sub.data.all.yr2007,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2007,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2007,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2007,Type=="POSs"& year==2007),aes(x = 50, y = max(subset(bin_count2007,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2007 <- ggplot(data=subset(sub.data.all.yr2007,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2007,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2007,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2007,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2007,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2007<-sub.count.fos2007+sub.count.pos2007+sub.count.hy2007+ plot_annotation(title="2007") & theme(plot.title = element_text(hjust=0.5))
plot2007
ggsave(plot=plot2007,"Figures/FigS4_2007.jpeg",width=12,height=8,dpi=600)


# 200807
sub.data.all.yr2008 <- subset(sub.data.all.yr, year==2008)
bin_count2008 <- sub.data.all.yr2008 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2008 <- subset(sub.data.sample.size.yr, year==2008)

# fos 
sub.count.fos2008 <- ggplot(data=subset(sub.data.all.yr2008,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2008,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2008 <- ggplot(data=subset(sub.data.all.yr2008,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2008,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2008,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2008,Type=="POSs"& year==2008),aes(x = 50, y = max(subset(bin_count2008,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2008 <- ggplot(data=subset(sub.data.all.yr2008,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2008,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2008,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2008,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2008,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2008<-sub.count.fos2008+sub.count.pos2008+sub.count.hy2008+ plot_annotation(title="2008") & theme(plot.title = element_text(hjust=0.5))
plot2008
ggsave(plot=plot2008,"Figures/FigS4_2008.jpeg",width=12,height=8,dpi=600)


# 200904
sub.data.all.yr2009 <- subset(sub.data.all.yr, year==2009)
bin_count2009 <- sub.data.all.yr2009 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2009 <- subset(sub.data.sample.size.yr, year==2009)

# fos 
sub.count.fos2009 <- ggplot(data=subset(sub.data.all.yr2009,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2009,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2009 <- ggplot(data=subset(sub.data.all.yr2009,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2009,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2009,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2009,Type=="POSs"& year==2009),aes(x = 50, y = max(subset(bin_count2009,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2009 <- ggplot(data=subset(sub.data.all.yr2009,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2009,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2009,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2009,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2009,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2009<-sub.count.fos2009+sub.count.pos2009+sub.count.hy2009+ plot_annotation(title="2009") & theme(plot.title = element_text(hjust=0.5))
plot2009
ggsave(plot=plot2009,"Figures/FigS4_2009.jpeg",width=12,height=8,dpi=600)

# 201104
sub.data.all.yr2011 <- subset(sub.data.all.yr, year==2011)
bin_count2011 <- sub.data.all.yr2011 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2011 <- subset(sub.data.sample.size.yr, year==2011)

# fos 
sub.count.fos2011 <- ggplot(data=subset(sub.data.all.yr2011,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2011,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2011 <- ggplot(data=subset(sub.data.all.yr2011,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2011,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2011,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2011,Type=="POSs"& year==2011),aes(x = 50, y = max(subset(bin_count2011,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2011 <- ggplot(data=subset(sub.data.all.yr2011,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2011,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2011,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2011,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2011,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2011<-sub.count.fos2011+sub.count.pos2011+sub.count.hy2011+ plot_annotation(title="2011") & theme(plot.title = element_text(hjust=0.5))
plot2011
ggsave(plot=plot2011,"Figures/FigS4_2011.jpeg",width=12,height=8,dpi=600)


# 201207
sub.data.all.yr2012 <- subset(sub.data.all.yr, year==2012)
bin_count2012 <- sub.data.all.yr2012 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2012 <- subset(sub.data.sample.size.yr, year==2012)

# fos 
sub.count.fos2012 <- ggplot(data=subset(sub.data.all.yr2012,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2012,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2012 <- ggplot(data=subset(sub.data.all.yr2012,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2012,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2012,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2012,Type=="POSs"& year==2012),aes(x = 50, y = max(subset(bin_count2012,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2012 <- ggplot(data=subset(sub.data.all.yr2012,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2012,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2012,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2012,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2012,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2012<-sub.count.fos2012+sub.count.pos2012+sub.count.hy2012+ plot_annotation(title="2012") & theme(plot.title = element_text(hjust=0.5))
plot2012
ggsave(plot=plot2012,"Figures/FigS4_2012.jpeg",width=12,height=8,dpi=600)


# 201307
sub.data.all.yr2013 <- subset(sub.data.all.yr, year==2013)
bin_count2013 <- sub.data.all.yr2013 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2013 <- subset(sub.data.sample.size.yr, year==2013)

# fos 
sub.count.fos2013 <- ggplot(data=subset(sub.data.all.yr2013,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2013,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2013 <- ggplot(data=subset(sub.data.all.yr2013,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2013,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2013,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2013,Type=="POSs"& year==2013),aes(x = 50, y = max(subset(bin_count2013,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2013 <- ggplot(data=subset(sub.data.all.yr2013,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2013,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2013,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2013,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2013,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2013<-sub.count.fos2013+sub.count.pos2013+sub.count.hy2013+ plot_annotation(title="2013") & theme(plot.title = element_text(hjust=0.5))
plot2013
ggsave(plot=plot2013,"Figures/FigS4_2013.jpeg",width=12,height=8,dpi=600)



# 201707
sub.data.all.yr2017 <- subset(sub.data.all.yr, year==2017)
bin_count2017 <- sub.data.all.yr2017 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2017 <- subset(sub.data.sample.size.yr, year==2017)

# fos 
sub.count.fos2017 <- ggplot(data=subset(sub.data.all.yr2017,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2017,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2017 <- ggplot(data=subset(sub.data.all.yr2017,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2017,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2017,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2017,Type=="POSs"& year==2017),aes(x = 50, y = max(subset(bin_count2017,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2017 <- ggplot(data=subset(sub.data.all.yr2017,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2017,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2017,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2017,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2017,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2017<-sub.count.fos2017+sub.count.pos2017+sub.count.hy2017+ plot_annotation(title="2017") & theme(plot.title = element_text(hjust=0.5))
plot2017
ggsave(plot=plot2017,"Figures/FigS4_2017.jpeg",width=12,height=8,dpi=600)


# 201807
sub.data.all.yr2018 <- subset(sub.data.all.yr, year==2018)
bin_count2018 <- sub.data.all.yr2018 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2018 <- subset(sub.data.sample.size.yr, year==2018)

# fos 
sub.count.fos2018 <- ggplot(data=subset(sub.data.all.yr2018,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2018,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2018 <- ggplot(data=subset(sub.data.all.yr2018,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2018,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2018,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2018,Type=="POSs"& year==2018),aes(x = 50, y = max(subset(bin_count2018,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2018 <- ggplot(data=subset(sub.data.all.yr2018,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2018,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2018,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2018,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2018,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2018<-sub.count.fos2018+sub.count.pos2018+sub.count.hy2018 + plot_annotation(title="2018") & theme(plot.title = element_text(hjust=0.5))
plot2018
ggsave(plot=plot2018,"Figures/FigS4_2018.jpeg",width=12,height=8,dpi=600)


# 201907
sub.data.all.yr2019 <- subset(sub.data.all.yr, year==2019)
bin_count2019 <- sub.data.all.yr2019 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2019 <- subset(sub.data.sample.size.yr, year==2019)

# fos 
sub.count.fos2019 <- ggplot(data=subset(sub.data.all.yr2019,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2019,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2019 <- ggplot(data=subset(sub.data.all.yr2019,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2019,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2019,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2019,Type=="POSs"& year==2019),aes(x = 50, y = max(subset(bin_count2019,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2019 <- ggplot(data=subset(sub.data.all.yr2019,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2019,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2019,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2019,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2019,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2019<-sub.count.fos2019+sub.count.pos2019+sub.count.hy2019 + plot_annotation(title="2019") & theme(plot.title = element_text(hjust=0.5))
plot2019
ggsave(plot=plot2019,"Figures/FigS4_2019.jpeg",width=12,height=8,dpi=600)


# 202107
sub.data.all.yr2021 <- subset(sub.data.all.yr, year==2021)
bin_count2021 <- sub.data.all.yr2021 %>%
  group_by(Type,run.label,bin_num) %>%
  summarise(samp_size=length(unique(uniq)),
            bin_count=length(unique(bin_num)))
sub.data.sample.size.yr2021 <- subset(sub.data.sample.size.yr, year==2021)

# fos 
sub.count.fos2021 <- ggplot(data=subset(sub.data.all.yr2021,Type=="FOS"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,55),breaks=seq(0,50,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_text(size=12,margin=margin(t=0,r=10,b=0,l=0)),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2021,Type=="FOS"),aes(x = 50, y = 50, label = lab.ss),size=2.5)

#pos
sub.count.pos2021 <- ggplot(data=subset(sub.data.all.yr2021,Type=="POSs"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2021,Type=="POSs")$samp_size)+10), breaks=seq(0,max(subset(bin_count2021,Type=="POSs")$samp_size)+20,20))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2021,Type=="POSs"& year==2021),aes(x = 50, y = max(subset(bin_count2021,Type=="POSs")$samp_size), label = lab.ss),size=2.5)

#hybrid
sub.count.hy2021 <- ggplot(data=subset(sub.data.all.yr2021,Type=="Hybrid"), aes(x=bin_num))+
  geom_bar(stat="count",color="black",fill="black",width=8.2,just=0)+
  scale_x_continuous(breaks=seq(30,300,20),limits=c(30,300))+
  scale_y_continuous(limits=c(0,max(subset(bin_count2021,Type=="Hybrid")$samp_size)+10), breaks=seq(0,max(subset(bin_count2021,Type=="Hybrid")$samp_size)+10,10))+
  labs(x="Standard length (mm)", y="Frequency")+
  theme_bw()+
  theme(strip.background = element_rect(fill="white"),
        panel.grid=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12,margin=margin(t=10,r=0,b=0,l=0)),
        plot.title = element_text(hjust=0.5))+
  facet_grid(run.label~Type)+
  geom_text(data=subset(sub.data.sample.size.yr2021,Type=="Hybrid"),aes(x = 50, y = max(subset(bin_count2021,Type=="Hybrid")$samp_size), label = lab.ss),size=2.5)

plot2021<-sub.count.fos2021+sub.count.pos2021+sub.count.hy2021 + plot_annotation(title="2021") & theme(plot.title = element_text(hjust=0.5))
plot2021
ggsave(plot=plot2021,"Figures/FigS4_2021.jpeg",width=12,height=8,dpi=600)

