#####FUNCTION	
sim_sample<-function(bin=bin,  # bin size in mm
                     bin_n=bin_n, # number from each bin
                     sample_type, # sample type, where FOS = fixed otolith sampling and POS = proportional otolith sampling
                     supp) # supplemental sampling TRUE and FALSE 
{ 
  pop$len_obs <- pop$standardLength_mm #rename length to len_obs, I've just made a new column
  pop$age_f<- as.factor(pop$age)# MAKE A FACTOR
  
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
  
  pop.yr <- pop %>% filter(cruise == cr)
  pop.yr.bin.sort <- sort(unique(pop.yr$bin_num))
  pop.yr$bin <- factor(pop.yr$bin, levels=pop.yr.bin.sort)
  
  pop.yr$age.ordinal <- pop.yr$age+1 # gam model needs non 0 numbers so add 1
  
  R = max(pop.yr$age.ordinal) # number of age categories
  
  pop.yr$f.age.ordinal <- as.factor(pop.yr$age.ordinal)
  
  # TRUE VALUES: POPULATION LEVEL
  model <- gam(age.ordinal ~ s(standardLength_mm) , data = pop.yr , family= ocat(R= R)) #
  
  prob.matrix <- predict(model , newdata = data.frame(standardLength_mm = pop.yr.bin.sort), type = "response")
  
  colnames(prob.matrix)<-seq(0,max(pop.yr$age),1)
  
  row.names(prob.matrix)<-pop.yr.bin.sort
  
  prob.matrix.df <- as.data.frame(prob.matrix)
  
  prob.matrix.df$bin <- as.numeric(rownames(prob.matrix))
  
  alk.long <- prob.matrix.df %>%
    pivot_longer(!bin, names_to="age",values_to="Freq_true_model")
  
  # creating and age length key based on full data set
  ## CALCULATE TRUE AGE FREQUENCY
  ## OF THE POPULATION
  af_model<-as.data.frame(c(prop.table(t(prob.matrix) %*% table(pop.yr$bin)))); colnames(af_model)<-"Freq_true_model"
  af_model <- af_model %>% 
    mutate(age=as.factor(seq(0,max(pop.yr$age),1))) %>%
    relocate(age)
  
  # THIS CHUNK IS FOR FIXED SAMPLING ###
  if(sample_type=="FOS"){
    ## AGE LENGTH KEY 
    alk.full<- pop.yr[order(pop.yr$bin),]
    rand_seq_for <- function(x) sample.int(length(x)) # create random sequence of numbers for length of group
    alk.full$num <- ave(1:nrow(alk.full), alk.full$bin, FUN=rand_seq_for) # within each bin, randomly assign numbers
    alk<-subset(alk.full,num<=bin_n) # subset dataset by choosing the random number assigned up to the size of number of bin, so if # per bin = 10, will take the fish assigned numbers 1-10
    alk.noage <- alk
    alk.aged <- alk
    pop.yr.noage <- pop.yr[!(pop.yr$uniq %in% alk$uniq),]
    
    # age length key based on subset dataset
    model.sub <- gam(age.ordinal ~ s(standardLength_mm) , data = alk , family= ocat(R= R)) #
    
    prob.matrix.sub <- predict(model.sub , newdata = data.frame(standardLength_mm = pop.yr.bin.sort), type = "response")
    
    colnames(prob.matrix.sub)<-seq(0,max(pop.yr$age),1)
    row.names(prob.matrix.sub)<-pop.yr.bin.sort
    
    prob.matrix.sub.df <- as.data.frame(prob.matrix.sub)
    
    prob.matrix.sub.df$bin <- as.numeric(rownames(prob.matrix.sub.df))
    
    alk.sub.long <- prob.matrix.sub.df %>%
      pivot_longer(!bin, names_to="age",values_to="Freq_sub_model")
    
    list_alk = list(alk.long,alk.sub.long)
    alk.long.data <- list_alk %>% reduce(left_join, by=c("bin","age"))
    
    ## ESTIMATES #everything that is pulling from pop.yr pop.yr 
    ### AGE FREQUENCY
    alk_af_model<-as.data.frame(c(prop.table(t(prob.matrix.sub) %*% table(pop.yr$bin)))); colnames(alk_af_model)<-c("Freq_alk_model")
    alk_af_model <- alk_af_model %>% 
      mutate(age=as.factor(seq(0,(nrow(alk_af_model)-1),1))) %>%
      relocate(age)
    
    alk_af_model_sub<-as.data.frame(c(prop.table(t(prob.matrix.sub) %*% table(alk$bin)))); colnames(alk_af_model_sub)<-c("Freq_alk_model_sub")
    alk_af_model_sub <- alk_af_model_sub %>% 
      mutate(age=as.factor(seq(0,(nrow(alk_af_model_sub)-1),1))) %>%
      relocate(age)
    
     list_af = list(af_model,alk_af_model,alk_af_model_sub)
    af <- list_af %>% reduce(left_join, by="age")
    
    ### CALCULATE MEAN LENGTH AT AGE FROM BETTOLI AND MIRANDA
    alk_in_mla_model <- alkIndivAge(prob.matrix.sub,age~len_obs,alk.noage)

    
    # creating full dataset by predicting ages for non aged fish (fish not in alk dataset), and then combining alk dataset
    pop_in_mla_model_alk <- alkIndivAge(prob.matrix.sub,age~len_obs,pop.yr.noage)
    
    alk.aged <- alk.aged[ , -which(names(alk.aged) %in% c("num"))] #delete a column to can rbind
    
    pop_in_mla_model <- rbind(pop_in_mla_model_alk,alk.aged)
    
    ## CALCULATE UP MAD, APD, MAPD
    ageFrequency<-af; ageFrequency$run = run
  }
  
  # THIS CHUNK IS FOR PROPORTIONAL SAMPLING ###
  if(sample_type=="POS"){
    pop.yr.pos <- pop.yr %>%
      group_by(bin) %>%
      mutate(prop=n()) %>%
      group_by() %>%
      mutate(n=sum(n())) %>%
      mutate(propL=prop/n)
    
    pop.yr.pos <- mutate(pop.yr.pos, bin_num = as.numeric(as.character(bin)))
    
    basic_POS_props <- unique(pop.yr.pos[c("bin","prop","propL")])		#sum(basic_POS_props$prop1)
    basic_POS_props <- basic_POS_props[order(basic_POS_props$bin),]		#str(basic_POS_samps)
    basic_POS_samps <- mutate(basic_POS_props, binL_num = as.numeric(as.character(bin)),
                              basic_POS_n = round((samp_size*propL),0))
    basic_POS_samps$supp_POS_n <- ifelse(basic_POS_samps$basic_POS_n==0 & basic_POS_samps$prop > 0, 1, basic_POS_samps$basic_POS_n)
    
    alk.pos.full<- pop.yr.pos[order(pop.yr.pos$bin),]
    rand_seq_for <- function(x) sample.int(length(x)) # create random sequence of numbers for length of group
    alk.pos.full$num <- ave(1:nrow(alk.pos.full), alk.pos.full$bin, FUN=rand_seq_for) # within each bin, randomly assign numbers
    alk.pos.full <- left_join(alk.pos.full,basic_POS_samps)
    len.n <- xtabs(~bin,data=pop.yr)
    
    if(supp==TRUE){
      alk<-subset(alk.pos.full,num<=supp_POS_n)
      alk.noage <- alk
      alk.aged <- alk
      pop.yr.noage <- pop.yr[!(pop.yr$uniq %in% alk$uniq),]

      model.sub <- gam(age.ordinal ~ s(standardLength_mm) , data = alk , family= ocat(R= R)) #
      
      prob.matrix.sub <- predict(model.sub , newdata = data.frame(standardLength_mm = pop.yr.bin.sort), type = "response")
      
      colnames(prob.matrix.sub)<-seq(0,max(pop.yr$age),1)
      row.names(prob.matrix.sub)<-pop.yr.bin.sort
      
      prob.matrix.sub.df <- as.data.frame(prob.matrix.sub)
      
      prob.matrix.sub.df$bin <- as.numeric(rownames(prob.matrix.sub.df))
      
      alk.sub.long <- prob.matrix.sub.df %>%
        pivot_longer(!bin, names_to="age",values_to="Freq_sub_model")
      
      list_alk = list(alk.long,alk.sub.long)
      alk.long.data <- list_alk %>% reduce(left_join, by=c("bin","age"))
      
      ## ESTIMATES #everything that is pulling from pop.yr pop.yr 
      ### AGE FREQUENCY
      alk_af_model<-as.data.frame(c(prop.table(t(prob.matrix.sub) %*% table(pop.yr$bin)))); colnames(alk_af_model)<-c("Freq_alk_model")
      alk_af_model <- alk_af_model %>% 
        mutate(age=as.factor(seq(0,(nrow(alk_af_model)-1),1))) %>%
        relocate(age)
      
      alk_af_model_sub<-as.data.frame(c(prop.table(t(prob.matrix.sub) %*% table(alk$bin)))); colnames(alk_af_model_sub)<-c("Freq_alk_model_sub")
      alk_af_model_sub <- alk_af_model_sub %>% 
        mutate(age=as.factor(seq(0,(nrow(alk_af_model_sub)-1),1))) %>%
        relocate(age)
  
      list_af = list(af_model,alk_af_model,alk_af_model_sub)
      af <- list_af %>% reduce(left_join, by="age")
      
       ### CALCULATE MEAN LENGTH AT AGE FROM BETTOLI AND MIRANDA
      alk_in_mla_model <- alkIndivAge(prob.matrix.sub,age~len_obs,alk.noage)

      # creating full dataset by predicting ages for non aged fish (fish not in alk dataset), and then combining alk dataset
      pop_in_mla_model_alk <- alkIndivAge(prob.matrix.sub,age~len_obs,pop.yr.noage)
      
      alk.aged <- alk.aged[ , -which(names(alk.aged) %in% c("num"))] #delete a column to can rbind
      
      pop_in_mla_model <- bind_rows(pop_in_mla_model_alk,alk.aged)
      
      ## CALCULATE UP MAD, APD, MAPD
      ageFrequency<-af; ageFrequency$run = run
    } # for supp true
  } # for POS
  if(sample_type=="Hybrid"){
    pop.yr.pos <- pop.yr %>%
      group_by(bin) %>%
      mutate(prop=n()) %>%
      group_by() %>%
      mutate(n=sum(n())) %>%
      mutate(propL=prop/n)
    
    pop.yr.pos <- mutate(pop.yr.pos, bin_num = as.numeric(as.character(bin)))
    
    basic_POS_props <- unique(pop.yr.pos[c("bin","prop")])		
    basic_POS_props <- basic_POS_props[order(basic_POS_props$bin),]		
    basic_POS_samps <- basic_POS_props %>%
      mutate(bin_num = as.numeric(as.character(bin)),
             hybrid_n = case_when(prop<=bin_n~prop, .default=bin_n+(round((prop-bin_n)*percent,0))))
    
    alk.hy.full<- pop.yr.pos[order(pop.yr.pos$bin),]
    rand_seq_for <- function(x) sample.int(length(x)) # create random sequence of numbers for length of group
    alk.hy.full$num <- ave(1:nrow(alk.hy.full), alk.hy.full$bin, FUN=rand_seq_for) # within each bin, randomly assign numbers
    alk.hy.full <- left_join(alk.hy.full,basic_POS_samps)
    
    alk<-subset(alk.hy.full,num<=hybrid_n)
    alk.noage <- alk
    alk.aged <- alk
    pop.yr.noage <- pop.yr[!(pop.yr$uniq %in% alk$uniq),]

    model.sub <- gam(age.ordinal ~ s(standardLength_mm) , data = alk , family= ocat(R= R)) #
    
    prob.matrix.sub <- predict(model.sub , newdata = data.frame(standardLength_mm = pop.yr.bin.sort), type = "response")
    
    colnames(prob.matrix.sub)<-seq(0,max(pop.yr$age),1)
    row.names(prob.matrix.sub)<-pop.yr.bin.sort
    
    prob.matrix.sub.df <- as.data.frame(prob.matrix.sub)
    
    prob.matrix.sub.df$bin <- as.numeric(rownames(prob.matrix.sub.df))
    
    alk.sub.long <- prob.matrix.sub.df %>%
      pivot_longer(!bin, names_to="age",values_to="Freq_sub_model")
    
    list_alk = list(alk.long,alk.sub.long)
    alk.long.data <- list_alk %>% reduce(full_join, by=c("bin","age"))
    
    ## ESTIMATES #everything that is pulling from pop.yr pop.yr 
    ### AGE FREQUENCY
    alk_af_model<-as.data.frame(c(prop.table(t(prob.matrix.sub) %*% table(pop.yr$bin)))); colnames(alk_af_model)<-c("Freq_alk_model")
    alk_af_model <- alk_af_model %>% 
      mutate(age=as.factor(seq(0,(nrow(alk_af_model)-1),1))) %>%
      relocate(age)
    
    alk_af_model_sub<-as.data.frame(c(prop.table(t(prob.matrix.sub) %*% table(alk$bin)))); colnames(alk_af_model_sub)<-c("Freq_alk_model_sub")
    alk_af_model_sub <- alk_af_model_sub %>% 
      mutate(age=as.factor(seq(0,(nrow(alk_af_model_sub)-1),1))) %>%
      relocate(age)
    
    list_af = list(af_model,alk_af_model,alk_af_model_sub)
    af <- list_af %>% reduce(left_join, by="age")
    
    ### CALCULATE MEAN LENGTH AT AGE FROM BETTOLI AND MIRANDA
    alk_in_mla_model <- alkIndivAge(prob.matrix.sub,age~len_obs,alk.noage)
    
    # creating full dataset by predicting ages for non aged fish (fish not in alk dataset), and then combining alk dataset
    pop_in_mla_model_alk <- alkIndivAge(prob.matrix.sub,age~len_obs,pop.yr.noage)
    
    alk.aged <- alk.aged[ , -which(names(alk.aged) %in% c("num"))] #delete a column to can rbind
    
    pop_in_mla_model <- bind_rows(pop_in_mla_model_alk,alk.aged)
    
    ## CALCULATE UP MAD, APD, MAPD
    ageFrequency<-af; ageFrequency$run = run
  }
  return(list(ageFrequency=ageFrequency, #1
              individualALK_model=alk_in_mla_model,#2
              individualALK_pop=pop_in_mla_model,#3
              ALK_data=alk.long.data, #4
              ALK_matrix_model=prob.matrix.sub.df,#5
              subset_data=alk))#6
}

