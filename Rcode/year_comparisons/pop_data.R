library(openxlsx)
library(ggplot2)
library(patchwork)
library(tidyverse)

pop <- read.xlsx("PSardine/Data/ps.age.u.xlsx", sheet="ageplus")
pop <- pop[!is.na(pop$standardLength_mm),]

bins<-seq(from=min(pop$standardLength_mm),to=max(pop$standardLength_mm)+10,
          by=10)
pop$bin<-cut(pop$standardLength_mm,
             breaks=bins,
             labels=bins[-length(bins)],
             right=TRUE,
             include.lowest = TRUE)
pop$bin<- factor(pop$bin, levels=bins[-length(bins)]) # need bin factor for most everything 
pop$bin_num <- as.numeric(as.character(pop$bin))

sardine.aged.yr <- subset(pop, cruise %in% c(200404,200904,201807,202107)) #bring data in here, then call it in other file
sardine.aged.yr <- sardine.aged.yr %>% select(cruise,ship,haul,collection,species,specimenNumber,otolithNumber,individual_ID,standardLength_mm,sex,weightg,age,uniq,bin)

ggplot(sardine.aged.yr, aes(x=bin))+
  geom_bar()+
  facet_wrap(~cruise)
table(sardine.aged.yr$cruise)
table(sardine.aged.yr$bin, sardine.aged.yr$cruise)

s21 <- subset(sardine.aged.yr, cruise==202107)
length(unique(s21$bin))

# looking at histograms based on sampling design
alk.full<- sardine.aged.yr[order(sardine.aged.yr$bin),]
rand_seq_for <- function(x) sample.int(length(x)) # create random sequence of numbers for length of group
alk.full$num <- ave(1:nrow(alk.full), alk.full$bin, FUN=rand_seq_for) # within each bin, randomly assign numbers

#10-10
sub.1010<-subset(alk.full,num<=10);sub.1010$run <- "10-10" # subset dataset by choosing the random number assigned up to the size of number of bin, so if # per bin = 10, will take the fish assigned numbers 1-10
#10-10
sub.1020<-subset(alk.full,num<=20);sub.1020$run <- "10-20" # subset dataset by choosing the random number assigned up to the size of number of bin, so if # per bin = 10, will take the fish assigned numbers 1-10
#10-10
sub.1030<-subset(alk.full,num<=30);sub.1030$run <- "10-30" # subset dataset by choosing the random number assigned up to the size of number of bin, so if # per bin = 10, will take the fish assigned numbers 1-10
#10-10
sub.1040<-subset(alk.full,num<=40);sub.1040$run <- "10-40" # subset dataset by choosing the random number assigned up to the size of number of bin, so if # per bin = 10, will take the fish assigned numbers 1-10
#10-50
sub.1050<-subset(alk.full,num<=50);sub.1050$run <- "10-50" # subset dataset by choosing the random number assigned up to the size of number of bin, so if # per bin = 10, will take the fish assigned numbers 1-10

fos <- rbind(sub.1010,sub.1020,sub.1030,sub.1040,sub.1050)

ggplot(subset(fos,cruise==200404), aes(x=bin))+
  geom_bar()+
  labs(title="2004")+
  facet_wrap(~run)
