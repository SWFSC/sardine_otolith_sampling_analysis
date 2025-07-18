library(openxlsx)
library(ggplot2)
library(patchwork)
library(tidyverse)

# FOS ############
# FINAL OUTPUT FOR 10 mm RUNS FOR 20004
r1010_04 <- readRDS("PSardine/Manuscript/200404/FOS/Run-b10n10/Output/final_output_200404_fos_1010.RDS"); r1010_04$year <- "2004"
r1020_04 <- readRDS("PSardine/Manuscript/200404/FOS/Run-b10n20/Output/final_output_200404_fos_1020.RDS"); r1020_04$year <- "2004"
r1030_04 <- readRDS("PSardine/Manuscript/200404/FOS/Run-b10n30/Output/final_output_200404_fos_1030.RDS"); r1030_04$year <- "2004"
r1040_04 <- readRDS("PSardine/Manuscript/200404/FOS/Run-b10n40/Output/final_output_200404_fos_1040.RDS"); r1040_04$year <- "2004"
r1050_04 <- readRDS("PSardine/Manuscript/200404/FOS/Run-b10n50/Output/final_output_200404_fos_1050.RDS"); r1050_04$year <- "2004"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200504
r1010_05 <- readRDS("PSardine/Manuscript/200504/FOS/Run-b10n10/Output/final_output_200504_fos_1010.RDS"); r1010_05$year <- "2005"
r1020_05 <- readRDS("PSardine/Manuscript/200504/FOS/Run-b10n20/Output/final_output_200504_fos_1020.RDS"); r1020_05$year <- "2005"
r1030_05 <- readRDS("PSardine/Manuscript/200504/FOS/Run-b10n30/Output/final_output_200504_fos_1030.RDS"); r1030_05$year <- "2005"
r1040_05 <- readRDS("PSardine/Manuscript/200504/FOS/Run-b10n40/Output/final_output_200504_fos_1040.RDS"); r1040_05$year <- "2005"
r1050_05 <- readRDS("PSardine/Manuscript/200504/FOS/Run-b10n50/Output/final_output_200504_fos_1050.RDS"); r1050_05$year <- "2005"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200704
r1010_07 <- readRDS("PSardine/Manuscript/200704/FOS/Run-b10n10/Output/final_output_200704_fos_1010.RDS"); r1010_07$year <- "2007"
r1020_07 <- readRDS("PSardine/Manuscript/200704/FOS/Run-b10n20/Output/final_output_200704_fos_1020.RDS"); r1020_07$year <- "2007"
r1030_07 <- readRDS("PSardine/Manuscript/200704/FOS/Run-b10n30/Output/final_output_200704_fos_1030.RDS"); r1030_07$year <- "2007"
r1040_07 <- readRDS("PSardine/Manuscript/200704/FOS/Run-b10n40/Output/final_output_200704_fos_1040.RDS"); r1040_07$year <- "2007"
r1050_07 <- readRDS("PSardine/Manuscript/200704/FOS/Run-b10n50/Output/final_output_200704_fos_1050.RDS"); r1050_07$year <- "2007"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200807
r1010_08 <- readRDS("PSardine/Manuscript/200807/FOS/Run-b10n10/Output/final_output_200807_fos_1010.RDS"); r1010_08$year <- "2008"
r1020_08 <- readRDS("PSardine/Manuscript/200807/FOS/Run-b10n20/Output/final_output_200807_fos_1020.RDS"); r1020_08$year <- "2008"
r1030_08 <- readRDS("PSardine/Manuscript/200807/FOS/Run-b10n30/Output/final_output_200807_fos_1030.RDS"); r1030_08$year <- "2008"
r1040_08 <- readRDS("PSardine/Manuscript/200807/FOS/Run-b10n40/Output/final_output_200807_fos_1040.RDS"); r1040_08$year <- "2008"
r1050_08 <- readRDS("PSardine/Manuscript/200807/FOS/Run-b10n50/Output/final_output_200807_fos_1050.RDS"); r1050_08$year <- "2008"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200904
r1010_09 <- readRDS("PSardine/Manuscript/200904/FOS/Run-b10n10/Output/final_output_200904_fos_1010.RDS"); r1010_09$year <- "2009"
r1020_09 <- readRDS("PSardine/Manuscript/200904/FOS/Run-b10n20/Output/final_output_200904_fos_1020.RDS"); r1020_09$year <- "2009"
r1030_09 <- readRDS("PSardine/Manuscript/200904/FOS/Run-b10n30/Output/final_output_200904_fos_1030.RDS"); r1030_09$year <- "2009"
r1040_09 <- readRDS("PSardine/Manuscript/200904/FOS/Run-b10n40/Output/final_output_200904_fos_1040.RDS"); r1040_09$year <- "2009"
r1050_09 <- readRDS("PSardine/Manuscript/200904/FOS/Run-b10n50/Output/final_output_200904_fos_1050.RDS"); r1050_09$year <- "2009"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201104
r1010_11 <- readRDS("PSardine/Manuscript/201104/FOS/Run-b10n10/Output/final_output_201104_fos_1010.RDS"); r1010_11$year <- "2011"
r1020_11 <- readRDS("PSardine/Manuscript/201104/FOS/Run-b10n20/Output/final_output_201104_fos_1020.RDS"); r1020_11$year <- "2011"
r1030_11 <- readRDS("PSardine/Manuscript/201104/FOS/Run-b10n30/Output/final_output_201104_fos_1030.RDS"); r1030_11$year <- "2011"
r1040_11 <- readRDS("PSardine/Manuscript/201104/FOS/Run-b10n40/Output/final_output_201104_fos_1040.RDS"); r1040_11$year <- "2011"
r1050_11 <- readRDS("PSardine/Manuscript/201104/FOS/Run-b10n50/Output/final_output_201104_fos_1050.RDS"); r1050_11$year <- "2011"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201207
r1010_12 <- readRDS("PSardine/Manuscript/201207/FOS/Run-b10n10/Output/final_output_201207_fos_1010.RDS"); r1010_12$year <- "2012"
r1020_12 <- readRDS("PSardine/Manuscript/201207/FOS/Run-b10n20/Output/final_output_201207_fos_1020.RDS"); r1020_12$year <- "2012"
r1030_12 <- readRDS("PSardine/Manuscript/201207/FOS/Run-b10n30/Output/final_output_201207_fos_1030.RDS"); r1030_12$year <- "2012"
r1040_12 <- readRDS("PSardine/Manuscript/201207/FOS/Run-b10n40/Output/final_output_201207_fos_1040.RDS"); r1040_12$year <- "2012"
r1050_12 <- readRDS("PSardine/Manuscript/201207/FOS/Run-b10n50/Output/final_output_201207_fos_1050.RDS"); r1050_12$year <- "2012"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201307
r1010_13 <- readRDS("PSardine/Manuscript/201307/FOS/Run-b10n10/Output/final_output_201307_fos_1010.RDS"); r1010_13$year <- "2013"
r1020_13 <- readRDS("PSardine/Manuscript/201307/FOS/Run-b10n20/Output/final_output_201307_fos_1020.RDS"); r1020_13$year <- "2013"
r1030_13 <- readRDS("PSardine/Manuscript/201307/FOS/Run-b10n30/Output/final_output_201307_fos_1030.RDS"); r1030_13$year <- "2013"
r1040_13 <- readRDS("PSardine/Manuscript/201307/FOS/Run-b10n40/Output/final_output_201307_fos_1040.RDS"); r1040_13$year <- "2013"
r1050_13 <- readRDS("PSardine/Manuscript/201307/FOS/Run-b10n50/Output/final_output_201307_fos_1050.RDS"); r1050_13$year <- "2013"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201707
r1010_17 <- readRDS("PSardine/Manuscript/201707/FOS/Run-b10n10/Output/final_output_201707_fos_1010.RDS"); r1010_17$year <- "2017"
r1020_17 <- readRDS("PSardine/Manuscript/201707/FOS/Run-b10n20/Output/final_output_201707_fos_1020.RDS"); r1020_17$year <- "2017"
r1030_17 <- readRDS("PSardine/Manuscript/201707/FOS/Run-b10n30/Output/final_output_201707_fos_1030.RDS"); r1030_17$year <- "2017"
r1040_17 <- readRDS("PSardine/Manuscript/201707/FOS/Run-b10n40/Output/final_output_201707_fos_1040.RDS"); r1040_17$year <- "2017"
r1050_17 <- readRDS("PSardine/Manuscript/201707/FOS/Run-b10n50/Output/final_output_201707_fos_1050.RDS"); r1050_17$year <- "2017"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201807
r1010_18 <- readRDS("PSardine/Manuscript/201807/FOS/Run-b10n10/Output/final_output_201807_fos_1010.RDS"); r1010_18$year <- "2018"
r1020_18 <- readRDS("PSardine/Manuscript/201807/FOS/Run-b10n20/Output/final_output_201807_fos_1020.RDS"); r1020_18$year <- "2018"
r1030_18 <- readRDS("PSardine/Manuscript/201807/FOS/Run-b10n30/Output/final_output_201807_fos_1030.RDS"); r1030_18$year <- "2018"
r1040_18 <- readRDS("PSardine/Manuscript/201807/FOS/Run-b10n40/Output/final_output_201807_fos_1040.RDS"); r1040_18$year <- "2018"
r1050_18 <- readRDS("PSardine/Manuscript/201807/FOS/Run-b10n50/Output/final_output_201807_fos_1050.RDS"); r1050_18$year <- "2018"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201907
r1010_19 <- readRDS("PSardine/Manuscript/201907/FOS/Run-b10n10/Output/final_output_201907_fos_1010.RDS"); r1010_19$year <- "2019"
r1020_19 <- readRDS("PSardine/Manuscript/201907/FOS/Run-b10n20/Output/final_output_201907_fos_1020.RDS"); r1020_19$year <- "2019"
r1030_19 <- readRDS("PSardine/Manuscript/201907/FOS/Run-b10n30/Output/final_output_201907_fos_1030.RDS"); r1030_19$year <- "2019"
r1040_19 <- readRDS("PSardine/Manuscript/201907/FOS/Run-b10n40/Output/final_output_201907_fos_1040.RDS"); r1040_19$year <- "2019"
r1050_19 <- readRDS("PSardine/Manuscript/201907/FOS/Run-b10n50/Output/final_output_201907_fos_1050.RDS"); r1050_19$year <- "2019"

# FINAL OUTPUT FOR 10 mm RUNS FOR 202107
r1010_21 <- readRDS("PSardine/Manuscript/202107/FOS/Run-b10n10/Output/final_output_202107_fos_1010.RDS"); r1010_21$year <- "2021"
r1020_21 <- readRDS("PSardine/Manuscript/202107/FOS/Run-b10n20/Output/final_output_202107_fos_1020.RDS"); r1020_21$year <- "2021"
r1030_21 <- readRDS("PSardine/Manuscript/202107/FOS/Run-b10n30/Output/final_output_202107_fos_1030.RDS"); r1030_21$year <- "2021"
r1040_21 <- readRDS("PSardine/Manuscript/202107/FOS/Run-b10n40/Output/final_output_202107_fos_1040.RDS"); r1040_21$year <- "2021"
r1050_21 <- readRDS("PSardine/Manuscript/202107/FOS/Run-b10n50/Output/final_output_202107_fos_1050.RDS"); r1050_21$year <- "2021"

final.fos <- rbind(r1010_04,r1020_04,r1030_04,r1040_04,r1050_04,
               r1010_05,r1020_05,r1030_05,r1040_05,r1050_05,
               r1010_07,r1020_07,r1030_07,r1040_07,r1050_07,
               r1010_08,r1020_08,r1030_08,r1040_08,r1050_08,
               r1010_09,r1020_09,r1030_09,r1040_09,r1050_09,
               r1010_11,r1020_11,r1030_11,r1040_11,r1050_11,
               r1010_12,r1020_12,r1030_12,r1040_12,r1050_12, 
               r1010_13,r1020_13,r1030_13,r1040_13,r1050_13, 
               r1010_17,r1020_17,r1030_17,r1040_17,r1050_17, 
               r1010_18,r1020_18,r1030_18,r1040_18,r1050_18,
               r1010_19,r1020_19,r1030_19,r1040_19,r1050_19, 
               r1010_21,r1020_21,r1030_21,r1040_21,r1050_21) %>%
  mutate(Type="FOS")

final.sort.metric.fos <- final.fos[order(final.fos$Metric),]


#2004
af1010_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_04$year <- "2004"  
af1020_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_04$year <- "2004"   
af1030_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_04$year <- "2004"   
af1040_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_04$year <- "2004"   
af1050_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_04$year <- "2004"   

#2005
af1010_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_05$year <- "2005" 
af1020_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_05$year <- "2005" 
af1030_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_05$year <- "2005"  
af1040_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_05$year <- "2005"  
af1050_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_05$year <- "2005"  

#2007
af1010_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_07$year <- "2007" 
af1020_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_07$year <- "2007" 
af1030_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_07$year <- "2007"  
af1040_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_07$year <- "2007"  
af1050_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_07$year <- "2007"  

#2008
af1010_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_08$year <- "2008" 
af1020_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_08$year <- "2008" 
af1030_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_08$year <- "2008"  
af1040_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_08$year <- "2008"  
af1050_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_08$year <- "2008"  

#2009
af1010_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_09$year <- "2009" 
af1020_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_09$year <- "2009" 
af1030_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_09$year <- "2009"  
af1040_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_09$year <- "2009"  
af1050_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_09$year <- "2009"  

#2011
af1010_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_11$year <- "2011" 
af1020_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_11$year <- "2011" 
af1030_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_11$year <- "2011"  
af1040_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_11$year <- "2011"  
af1050_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_11$year <- "2011"  

#2012
af1010_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_12$year <- "2012"  
af1020_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_12$year <- "2012"   
af1030_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_12$year <- "2012"   
af1040_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_12$year <- "2012"   
af1050_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_12$year <- "2012"   

#2013
af1010_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_13$year <- "2013"  
af1020_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_13$year <- "2013"   
af1030_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_13$year <- "2013"   
af1040_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_13$year <- "2013"   
af1050_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_13$year <- "2013"   

#2017
af1010_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_17$year <- "2017"  
af1020_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_17$year <- "2017"   
af1030_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_17$year <- "2017"   
af1040_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_17$year <- "2017"   
af1050_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_17$year <- "2017"   

#2018
af1010_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_18$year <- "2018"  
af1020_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_18$year <- "2018"   
af1030_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_18$year <- "2018"   
af1040_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_18$year <- "2018"   
af1050_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_18$year <- "2018"   

#2019
af1010_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_19$year <- "2019"  
af1020_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_19$year <- "2019"   
af1030_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_19$year <- "2019"   
af1040_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_19$year <- "2019"   
af1050_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_19$year <- "2019"   

#2021
af1010_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n10/Output/af_metrics_long_fos_1010.rds"); af1010_21$year <- "2021"  
af1020_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n20/Output/af_metrics_long_fos_1020.rds"); af1020_21$year <- "2021"   
af1030_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n30/Output/af_metrics_long_fos_1030.rds"); af1030_21$year <- "2021"   
af1040_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n40/Output/af_metrics_long_fos_1040.rds"); af1040_21$year <- "2021"   
af1050_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n50/Output/af_metrics_long_fos_1050.rds"); af1050_21$year <- "2021"   


af.all.fos <- rbind(af1010_04,af1020_04,af1030_04,af1040_04,af1050_04,
                af1010_05,af1020_05,af1030_05,af1040_05,af1050_05,
                af1010_07,af1020_07,af1030_07,af1040_07,af1050_07,
                af1010_08,af1020_08,af1030_08,af1040_08,af1050_08,
                af1010_09,af1020_09,af1030_09,af1040_09,af1050_09,
                af1010_11,af1020_11,af1030_11,af1040_11,af1050_11,
                af1010_12,af1020_12,af1030_12,af1040_12,af1050_12,
                af1010_13,af1020_13,af1030_13,af1040_13,af1050_13,
                af1010_17,af1020_17,af1030_17,af1040_17,af1050_17,
                af1010_18,af1020_18,af1030_18,af1040_18,af1050_18,
                af1010_19,af1020_19,af1030_19,af1040_19,af1050_19,
                af1010_21,af1020_21,af1030_21,af1040_21,af1050_21)%>%
  mutate(Type="FOS")

# age length key ##
# 200404
alk1010_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_04$year <- "2004"
alk1020_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_04$year <- "2004"
alk1030_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_04$year <- "2004"
alk1040_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_04$year <- "2004"
alk1050_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_04$year <- "2004"

# 200504
alk1010_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_05$year <- "2005"
alk1020_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_05$year <- "2005"
alk1030_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_05$year <- "2005"
alk1040_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_05$year <- "2005"
alk1050_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_05$year <- "2005"

# 200704
alk1010_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_07$year <- "2007"
alk1020_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_07$year <- "2007"
alk1030_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_07$year <- "2007"
alk1040_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_07$year <- "2007"
alk1050_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_07$year <- "2007"

# 200807
alk1010_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_08$year <- "2008"
alk1020_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_08$year <- "2008"
alk1030_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_08$year <- "2008"
alk1040_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_08$year <- "2008"
alk1050_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_08$year <- "2008"

# 200904
alk1010_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_09$year <- "2009"
alk1020_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_09$year <- "2009"
alk1030_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_09$year <- "2009"
alk1040_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_09$year <- "2009"
alk1050_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_09$year <- "2009"

# 201104
alk1010_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_11$year <- "2011"
alk1020_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_11$year <- "2011"
alk1030_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_11$year <- "2011"
alk1040_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_11$year <- "2011"
alk1050_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_11$year <- "2011"

# 201207
alk1010_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_12$year <- "2012"
alk1020_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_12$year <- "2012"
alk1030_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_12$year <- "2012"
alk1040_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_12$year <- "2012"
alk1050_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_12$year <- "2012"

# 201307
alk1010_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_13$year <- "2013"
alk1020_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_13$year <- "2013"
alk1030_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_13$year <- "2013"
alk1040_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_13$year <- "2013"
alk1050_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_13$year <- "2013"

# 201707
alk1010_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_17$year <- "2017"
alk1020_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_17$year <- "2017"
alk1030_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_17$year <- "2017"
alk1040_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_17$year <- "2017"
alk1050_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_17$year <- "2017"

# 201807
alk1010_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_18$year <- "2018"
alk1020_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_18$year <- "2018"
alk1030_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_18$year <- "2018"
alk1040_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_18$year <- "2018"
alk1050_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_18$year <- "2018"

# 201907
alk1010_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_19$year <- "2019"
alk1020_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_19$year <- "2019"
alk1030_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_19$year <- "2019"
alk1040_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_19$year <- "2019"
alk1050_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_19$year <- "2019"

# 2021
alk1010_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n10/Output/alk_data_all_r1010.rds"); alk1010_21$year <- "2021"
alk1020_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n20/Output/alk_data_all_r1020.rds"); alk1020_21$year <- "2021"
alk1030_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n30/Output/alk_data_all_r1030.rds"); alk1030_21$year <- "2021"
alk1040_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n40/Output/alk_data_all_r1040.rds"); alk1040_21$year <- "2021"
alk1050_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n50/Output/alk_data_all_r1050.rds"); alk1050_21$year <- "2021"

alk.data.fos.all <- rbind(alk1010_04,alk1020_04,alk1030_04,alk1040_04,alk1050_04,
                      alk1010_05,alk1020_05,alk1030_05,alk1040_05,alk1050_05,
                      alk1010_07,alk1020_07,alk1030_07,alk1040_07,alk1050_07,
                      alk1010_08,alk1020_08,alk1030_08,alk1040_08,alk1050_08,
                      alk1010_09,alk1020_09,alk1030_09,alk1040_09,alk1050_09,
                      alk1010_11,alk1020_11,alk1030_11,alk1040_11,alk1050_11,
                      alk1010_12,alk1020_12,alk1030_12,alk1040_12,alk1050_12,
                      alk1010_13,alk1020_13,alk1030_13,alk1040_13,alk1050_13,
                      alk1010_17,alk1020_17,alk1030_17,alk1040_17,alk1050_17,
                      alk1010_18,alk1020_18,alk1030_18,alk1040_18,alk1050_18,
                      alk1010_19,alk1020_19,alk1030_19,alk1040_19,alk1050_19,
                      alk1010_21,alk1020_21,alk1030_21,alk1040_21,alk1050_21)%>%
  mutate(Type="FOS")

alk.data.fos.all$age <- as.numeric(as.character(alk.data.fos.all$age))
alk.data.fos.all$MAPD_new <- alk.data.fos.all$MAPD_model
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==0 & alk.data.fos.all$bin>180,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==1 & alk.data.fos.all$bin<90|alk.data.fos.all$bin>270,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==2 & alk.data.fos.all$bin<110|alk.data.fos.all$bin>280,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==3 & alk.data.fos.all$bin<140|alk.data.fos.all$bin>280,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==4 & alk.data.fos.all$bin<150|alk.data.fos.all$bin>290,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==5 & alk.data.fos.all$bin<190,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==6 & alk.data.fos.all$bin<190,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==7 & alk.data.fos.all$bin<200,0,alk.data.fos.all$MAPD_new)
alk.data.fos.all$MAPD_new <- ifelse(alk.data.fos.all$age==8 & alk.data.fos.all$bin<220,0,alk.data.fos.all$MAPD_new)


# subset data # #
# 200404
sub.data1010_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_04$year <- "2004";sub.data1010_04$run <- "10-10"
sub.data1020_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_04$year <- "2004";sub.data1020_04$run <- "10-20"
sub.data1030_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_04$year <- "2004";sub.data1030_04$run <- "10-30"
sub.data1040_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_04$year <- "2004";sub.data1040_04$run <- "10-40"
sub.data1050_04 <- readRDS("Psardine/Manuscript/200404/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_04$year <- "2004";sub.data1050_04$run <- "10-50"


# 200504
sub.data1010_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_05$year <- "2005"; sub.data1010_05$run <- "10-10"
sub.data1020_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_05$year <- "2005"; sub.data1020_05$run <- "10-20"
sub.data1030_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_05$year <- "2005"; sub.data1030_05$run <- "10-30"
sub.data1040_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_05$year <- "2005"; sub.data1040_05$run <- "10-40"
sub.data1050_05 <- readRDS("Psardine/Manuscript/200504/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_05$year <- "2005"; sub.data1050_05$run <- "10-50"

# 200704
sub.data1010_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_07$year <- "2007"; sub.data1010_07$run <- "10-10"
sub.data1020_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_07$year <- "2007"; sub.data1020_07$run <- "10-20"
sub.data1030_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_07$year <- "2007"; sub.data1030_07$run <- "10-30"
sub.data1040_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_07$year <- "2007"; sub.data1040_07$run <- "10-40"
sub.data1050_07 <- readRDS("Psardine/Manuscript/200704/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_07$year <- "2007"; sub.data1050_07$run <- "10-50"

# 200807
sub.data1010_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_08$year <- "2008"; sub.data1010_08$run <- "10-10"
sub.data1020_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_08$year <- "2008"; sub.data1020_08$run <- "10-20"
sub.data1030_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_08$year <- "2008"; sub.data1030_08$run <- "10-30"
sub.data1040_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_08$year <- "2008"; sub.data1040_08$run <- "10-40"
sub.data1050_08 <- readRDS("Psardine/Manuscript/200807/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_08$year <- "2008"; sub.data1050_08$run <- "10-50"

# 200904
sub.data1010_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_09$year <- "2009"; sub.data1010_09$run <- "10-10"
sub.data1020_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_09$year <- "2009"; sub.data1020_09$run <- "10-20"
sub.data1030_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_09$year <- "2009"; sub.data1030_09$run <- "10-30"
sub.data1040_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_09$year <- "2009"; sub.data1040_09$run <- "10-40"
sub.data1050_09 <- readRDS("Psardine/Manuscript/200904/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_09$year <- "2009"; sub.data1050_09$run <- "10-50"

# 201104
sub.data1010_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_11$year <- "2011"; sub.data1010_11$run <- "10-10"
sub.data1020_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_11$year <- "2011"; sub.data1020_11$run <- "10-20"
sub.data1030_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_11$year <- "2011"; sub.data1030_11$run <- "10-30"
sub.data1040_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_11$year <- "2011"; sub.data1040_11$run <- "10-40"
sub.data1050_11 <- readRDS("Psardine/Manuscript/201104/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_11$year <- "2011"; sub.data1050_11$run <- "10-50"

# 201207
sub.data1010_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_12$year <- "2012"; sub.data1010_12$run <- "10-10"
sub.data1020_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_12$year <- "2012"; sub.data1020_12$run <- "10-20"
sub.data1030_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_12$year <- "2012"; sub.data1030_12$run <- "10-30"
sub.data1040_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_12$year <- "2012"; sub.data1040_12$run <- "10-40"
sub.data1050_12 <- readRDS("Psardine/Manuscript/201207/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_12$year <- "2012"; sub.data1050_12$run <- "10-50"

# 201307
sub.data1010_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_13$year <- "2013"; sub.data1010_13$run <- "10-10"
sub.data1020_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_13$year <- "2013"; sub.data1020_13$run <- "10-20"
sub.data1030_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_13$year <- "2013"; sub.data1030_13$run <- "10-30"
sub.data1040_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_13$year <- "2013"; sub.data1040_13$run <- "10-40"
sub.data1050_13 <- readRDS("Psardine/Manuscript/201307/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_13$year <- "2013"; sub.data1050_13$run <- "10-50"

# 201707
sub.data1010_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_17$year <- "2017"; sub.data1010_17$run <- "10-10"
sub.data1020_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_17$year <- "2017"; sub.data1020_17$run <- "10-20"
sub.data1030_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_17$year <- "2017"; sub.data1030_17$run <- "10-30"
sub.data1040_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_17$year <- "2017"; sub.data1040_17$run <- "10-40"
sub.data1050_17 <- readRDS("Psardine/Manuscript/201707/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_17$year <- "2017"; sub.data1050_17$run <- "10-50"

# 201807
sub.data1010_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_18$year <- "2018"; sub.data1010_18$run <- "10-10"
sub.data1020_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_18$year <- "2018"; sub.data1020_18$run <- "10-20"
sub.data1030_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_18$year <- "2018"; sub.data1030_18$run <- "10-30"
sub.data1040_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_18$year <- "2018"; sub.data1040_18$run <- "10-40"
sub.data1050_18 <- readRDS("Psardine/Manuscript/201807/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_18$year <- "2018"; sub.data1050_18$run <- "10-50"

# 201907
sub.data1010_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_19$year <- "2019"; sub.data1010_19$run <- "10-10"
sub.data1020_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_19$year <- "2019"; sub.data1020_19$run <- "10-20"
sub.data1030_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_19$year <- "2019"; sub.data1030_19$run <- "10-30"
sub.data1040_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_19$year <- "2019"; sub.data1040_19$run <- "10-40"
sub.data1050_19 <- readRDS("Psardine/Manuscript/201907/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_19$year <- "2019"; sub.data1050_19$run <- "10-50"

# 2021
sub.data1010_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n10/Output/subset_data_r1010.rds"); sub.data1010_21$year <- "2021"; sub.data1010_21$run <- "10-10"
sub.data1020_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n20/Output/subset_data_r1020.rds"); sub.data1020_21$year <- "2021"; sub.data1020_21$run <- "10-20"
sub.data1030_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n30/Output/subset_data_r1030.rds"); sub.data1030_21$year <- "2021"; sub.data1030_21$run <- "10-30"
sub.data1040_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n40/Output/subset_data_r1040.rds"); sub.data1040_21$year <- "2021"; sub.data1040_21$run <- "10-40"
sub.data1050_21 <- readRDS("Psardine/Manuscript/202107/FOS/Run-b10n50/Output/subset_data_r1050.rds"); sub.data1050_21$year <- "2021"; sub.data1050_21$run <- "10-50"


sub.data.fos.all <- rbind(sub.data1010_04,sub.data1020_04,sub.data1030_04,sub.data1040_04,sub.data1050_04,
                      sub.data1010_05,sub.data1020_05,sub.data1030_05,sub.data1040_05,sub.data1050_05,
                      sub.data1010_07,sub.data1020_07,sub.data1030_07,sub.data1040_07,sub.data1050_07,
                      sub.data1010_08,sub.data1020_08,sub.data1030_08,sub.data1040_08,sub.data1050_08,
                      sub.data1010_09,sub.data1020_09,sub.data1030_09,sub.data1040_09,sub.data1050_09,
                      sub.data1010_11,sub.data1020_11,sub.data1030_11,sub.data1040_11,sub.data1050_11,
                      sub.data1010_12,sub.data1020_12,sub.data1030_12,sub.data1040_12,sub.data1050_12,
                      sub.data1010_13,sub.data1020_13,sub.data1030_13,sub.data1040_13,sub.data1050_13,
                      sub.data1010_17,sub.data1020_17,sub.data1030_17,sub.data1040_17,sub.data1050_17,
                      sub.data1010_18,sub.data1020_18,sub.data1030_18,sub.data1040_18,sub.data1050_18,
                      sub.data1010_19,sub.data1020_19,sub.data1030_19,sub.data1040_19,sub.data1050_19,
                      sub.data1010_21,sub.data1020_21,sub.data1030_21,sub.data1040_21,sub.data1050_21) %>%
  mutate(Type="FOS")

sub.data.fos <- sub.data.fos.all %>% filter(rep==1)
saveRDS(sub.data.fos, "PSardine/Manuscript/year_comparisons/sub.data.fos.RDS")

# POSs ###########
# FINAL OUTPUT FOR 10 mm RUNS FOR 20004
p30_04 <-readRDS("Psardine/Manuscript/200404/POS/30percent/Output/final_output_200404_pos_30.rds"); p30_04$year <- "2004"
p50_04 <-readRDS("Psardine/Manuscript/200404/POS/50percent/Output/final_output_200404_pos_50.rds"); p50_04$year <- "2004"
p70_04 <-readRDS("Psardine/Manuscript/200404/POS/70percent/Output/final_output_200404_pos_70.rds"); p70_04$year <- "2004"
p90_04 <-readRDS("Psardine/Manuscript/200404/POS/90percent/Output/final_output_200404_pos_90.rds"); p90_04$year <- "2004"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200504
p10_05 <-readRDS("Psardine/Manuscript/200504/POS/10percent/Output/final_output_200504_pos_10.rds"); p10_05$year <- "2005" 
p30_05 <-readRDS("Psardine/Manuscript/200504/POS/30percent/Output/final_output_200504_pos_30.rds"); p30_05$year <- "2005"
p50_05 <-readRDS("Psardine/Manuscript/200504/POS/50percent/Output/final_output_200504_pos_50.rds"); p50_05$year <- "2005"
p70_05 <-readRDS("Psardine/Manuscript/200504/POS/70percent/Output/final_output_200504_pos_70.rds"); p70_05$year <- "2005"
p90_05 <-readRDS("Psardine/Manuscript/200504/POS/90percent/Output/final_output_200504_pos_90.rds"); p90_05$year <- "2005"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200704
p10_07 <-readRDS("Psardine/Manuscript/200704/POS/10percent/Output/final_output_200704_pos_10.rds"); p10_07$year <- "2007" 
p30_07 <-readRDS("Psardine/Manuscript/200704/POS/30percent/Output/final_output_200704_pos_30.rds"); p30_07$year <- "2007"
p50_07 <-readRDS("Psardine/Manuscript/200704/POS/50percent/Output/final_output_200704_pos_50.rds"); p50_07$year <- "2007"
p70_07 <-readRDS("Psardine/Manuscript/200704/POS/70percent/Output/final_output_200704_pos_70.rds"); p70_07$year <- "2007"
p90_07 <-readRDS("Psardine/Manuscript/200704/POS/90percent/Output/final_output_200704_pos_90.rds"); p90_07$year <- "2007"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200807
p10_08 <-readRDS("Psardine/Manuscript/200807/POS/10percent/Output/final_output_200807_pos_10.rds"); p10_08$year <- "2008" 
p30_08 <-readRDS("Psardine/Manuscript/200807/POS/30percent/Output/final_output_200807_pos_30.rds"); p30_08$year <- "2008"
p50_08 <-readRDS("Psardine/Manuscript/200807/POS/50percent/Output/final_output_200807_pos_50.rds"); p50_08$year <- "2008"
p70_08 <-readRDS("Psardine/Manuscript/200807/POS/70percent/Output/final_output_200807_pos_70.rds"); p70_08$year <- "2008"
p90_08 <-readRDS("Psardine/Manuscript/200807/POS/90percent/Output/final_output_200807_pos_90.rds"); p90_08$year <- "2008"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200904
p10_09 <-readRDS("Psardine/Manuscript/200904/POS/10percent/Output/final_output_200904_pos_10.rds"); p10_09$year <- "2009" 
p30_09 <-readRDS("Psardine/Manuscript/200904/POS/30percent/Output/final_output_200904_pos_30.rds"); p30_09$year <- "2009"
p50_09 <-readRDS("Psardine/Manuscript/200904/POS/50percent/Output/final_output_200904_pos_50.rds"); p50_09$year <- "2009"
p70_09 <-readRDS("Psardine/Manuscript/200904/POS/70percent/Output/final_output_200904_pos_70.rds"); p70_09$year <- "2009"
p90_09 <-readRDS("Psardine/Manuscript/200904/POS/90percent/Output/final_output_200904_pos_90.rds"); p90_09$year <- "2009"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201104
p10_11 <-readRDS("Psardine/Manuscript/201104/POS/10percent/Output/final_output_201104_pos_10.rds"); p10_11$year <- "2011" 
p30_11 <-readRDS("Psardine/Manuscript/201104/POS/30percent/Output/final_output_201104_pos_30.rds"); p30_11$year <- "2011"
p50_11 <-readRDS("Psardine/Manuscript/201104/POS/50percent/Output/final_output_201104_pos_50.rds"); p50_11$year <- "2011"
p70_11 <-readRDS("Psardine/Manuscript/201104/POS/70percent/Output/final_output_201104_pos_70.rds"); p70_11$year <- "2011"
p90_11 <-readRDS("Psardine/Manuscript/201104/POS/90percent/Output/final_output_201104_pos_90.rds"); p90_11$year <- "2011"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201207
p10_12 <-readRDS("Psardine/Manuscript/201207/POS/10percent/Output/final_output_201207_pos_10.rds"); p10_12$year <- "2012"
p30_12 <-readRDS("Psardine/Manuscript/201207/POS/30percent/Output/final_output_201207_pos_30.rds"); p30_12$year <- "2012"
p50_12 <-readRDS("Psardine/Manuscript/201207/POS/50percent/Output/final_output_201207_pos_50.rds"); p50_12$year <- "2012"
p70_12 <-readRDS("Psardine/Manuscript/201207/POS/70percent/Output/final_output_201207_pos_70.rds"); p70_12$year <- "2012"
p90_12 <-readRDS("Psardine/Manuscript/201207/POS/90percent/Output/final_output_201207_pos_90.rds"); p90_12$year <- "2012"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201307
p10_13 <-readRDS("Psardine/Manuscript/201307/POS/10percent/Output/final_output_201307_pos_10.rds"); p10_13$year <- "2013"
p30_13 <-readRDS("Psardine/Manuscript/201307/POS/30percent/Output/final_output_201307_pos_30.rds"); p30_13$year <- "2013"
p50_13 <-readRDS("Psardine/Manuscript/201307/POS/50percent/Output/final_output_201307_pos_50.rds"); p50_13$year <- "2013"
p70_13 <-readRDS("Psardine/Manuscript/201307/POS/70percent/Output/final_output_201307_pos_70.rds"); p70_13$year <- "2013"
p90_13 <-readRDS("Psardine/Manuscript/201307/POS/90percent/Output/final_output_201307_pos_90.rds"); p90_13$year <- "2013"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201707
p10_17 <-readRDS("Psardine/Manuscript/201707/POS/10percent/Output/final_output_201707_pos_10.rds"); p10_17$year <- "2017"
p30_17 <-readRDS("Psardine/Manuscript/201707/POS/30percent/Output/final_output_201707_pos_30.rds"); p30_17$year <- "2017"
p50_17 <-readRDS("Psardine/Manuscript/201707/POS/50percent/Output/final_output_201707_pos_50.rds"); p50_17$year <- "2017"
p70_17 <-readRDS("Psardine/Manuscript/201707/POS/70percent/Output/final_output_201707_pos_70.rds"); p70_17$year <- "2017"
p90_17 <-readRDS("Psardine/Manuscript/201707/POS/90percent/Output/final_output_201707_pos_90.rds"); p90_17$year <- "2017"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201807
#p10_18 <-readRDS("Psardine/Manuscript/201807/POS/10percent/Output/final_output_201807_pos_10.rds"); p10_18$year <- "2018"
p30_18 <-readRDS("Psardine/Manuscript/201807/POS/30percent/Output/final_output_201807_pos_30.rds"); p30_18$year <- "2018"
p50_18 <-readRDS("Psardine/Manuscript/201807/POS/50percent/Output/final_output_201807_pos_50.rds"); p50_18$year <- "2018"
p70_18 <-readRDS("Psardine/Manuscript/201807/POS/70percent/Output/final_output_201807_pos_70.rds"); p70_18$year <- "2018"
p90_18 <-readRDS("Psardine/Manuscript/201807/POS/90percent/Output/final_output_201807_pos_90.rds"); p90_18$year <- "2018"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201907
p10_19 <-readRDS("Psardine/Manuscript/201907/POS/10percent/Output/final_output_201907_pos_10.rds"); p10_19$year <- "2019"
p30_19 <-readRDS("Psardine/Manuscript/201907/POS/30percent/Output/final_output_201907_pos_30.rds"); p30_19$year <- "2019"
p50_19 <-readRDS("Psardine/Manuscript/201907/POS/50percent/Output/final_output_201907_pos_50.rds"); p50_19$year <- "2019"
p70_19 <-readRDS("Psardine/Manuscript/201907/POS/70percent/Output/final_output_201907_pos_70.rds"); p70_19$year <- "2019"
p90_19 <-readRDS("Psardine/Manuscript/201907/POS/90percent/Output/final_output_201907_pos_90.rds"); p90_19$year <- "2019"

# FINAL OUTPUT FOR 10 mm RUNS FOR 202107
#p10_21 <-readRDS("Psardine/Manuscript/202107/POS/10percent/Output/final_output_202107_pos_10.rds"); p10_21$year <- "2021"
p30_21 <-readRDS("Psardine/Manuscript/202107/POS/30percent/Output/final_output_202107_pos_30.rds"); p30_21$year <- "2021"
p50_21 <-readRDS("Psardine/Manuscript/202107/POS/50percent/Output/final_output_202107_pos_50.rds"); p50_21$year <- "2021"
p70_21 <-readRDS("Psardine/Manuscript/202107/POS/70percent/Output/final_output_202107_pos_70.rds"); p70_21$year <- "2021"
p90_21 <-readRDS("Psardine/Manuscript/202107/POS/90percent/Output/final_output_202107_pos_90.rds"); p90_21$year <- "2021"

final.pos <- rbind(p30_04,p50_04,p70_04,p90_04,
               p10_05,p30_05,p50_05,p70_05,p90_05,
               p10_07,p30_07,p50_07,p70_07,p90_07,
               p10_08,p30_08,p50_08,p70_08,p90_08,
               p10_09,p30_09,p50_09,p70_09,p90_09,
               p10_11,p30_11,p50_11,p70_11,p90_11,
               p10_12,p30_12,p50_12,p70_12,p90_12,
               p10_13,p30_13,p50_13,p70_13,p90_13,
               p10_17,p30_17,p50_17,p70_17,p90_17,
               p30_18,p50_18,p70_18,p90_18,
               p10_19,p30_19,p50_19,p70_19,p90_19,
               p30_21,p50_21,p70_21,p90_21) %>%
  mutate(Type="POSs")

final.sort.metric.pos <- final.pos[order(final.pos$Metric),]

# age frequency #
#2004
af30_04 <- readRDS("Psardine/Manuscript/200404/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_04$year <- "2004"
af50_04 <- readRDS("Psardine/Manuscript/200404/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_04$year <- "2004"
af70_04 <- readRDS("Psardine/Manuscript/200404/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_04$year <- "2004"
af90_04 <- readRDS("Psardine/Manuscript/200404/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_04$year <- "2004"

#2005
af10_05 <- readRDS("Psardine/Manuscript/200504/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_05$year <- "2005" 
af30_05 <- readRDS("Psardine/Manuscript/200504/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_05$year <- "2005" 
af50_05 <- readRDS("Psardine/Manuscript/200504/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_05$year <- "2005" 
af70_05 <- readRDS("Psardine/Manuscript/200504/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_05$year <- "2005" 
af90_05 <- readRDS("Psardine/Manuscript/200504/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_05$year <- "2005" 

#2007
af10_07 <- readRDS("Psardine/Manuscript/200704/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_07$year <- "2007" 
af30_07 <- readRDS("Psardine/Manuscript/200704/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_07$year <- "2007" 
af50_07 <- readRDS("Psardine/Manuscript/200704/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_07$year <- "2007" 
af70_07 <- readRDS("Psardine/Manuscript/200704/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_07$year <- "2007" 
af90_07 <- readRDS("Psardine/Manuscript/200704/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_07$year <- "2007" 

#2008
af10_08 <- readRDS("Psardine/Manuscript/200807/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_08$year <- "2008"
af30_08 <- readRDS("Psardine/Manuscript/200807/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_08$year <- "2008"
af50_08 <- readRDS("Psardine/Manuscript/200807/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_08$year <- "2008"
af70_08 <- readRDS("Psardine/Manuscript/200807/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_08$year <- "2008"
af90_08 <- readRDS("Psardine/Manuscript/200807/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_08$year <- "2008"

#2009
af10_09 <- readRDS("Psardine/Manuscript/200904/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_09$year <- "2009" 
af30_09 <- readRDS("Psardine/Manuscript/200904/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_09$year <- "2009" 
af50_09 <- readRDS("Psardine/Manuscript/200904/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_09$year <- "2009" 
af70_09 <- readRDS("Psardine/Manuscript/200904/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_09$year <- "2009" 
af90_09 <- readRDS("Psardine/Manuscript/200904/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_09$year <- "2009" 

#2011
af10_11 <- readRDS("Psardine/Manuscript/201104/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_11$year <- "2011" 
af30_11 <- readRDS("Psardine/Manuscript/201104/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_11$year <- "2011" 
af50_11 <- readRDS("Psardine/Manuscript/201104/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_11$year <- "2011" 
af70_11 <- readRDS("Psardine/Manuscript/201104/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_11$year <- "2011" 
af90_11 <- readRDS("Psardine/Manuscript/201104/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_11$year <- "2011" 

#2012
af10_12 <- readRDS("Psardine/Manuscript/201207/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_12$year <- "2012"
af30_12 <- readRDS("Psardine/Manuscript/201207/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_12$year <- "2012"
af50_12 <- readRDS("Psardine/Manuscript/201207/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_12$year <- "2012"
af70_12 <- readRDS("Psardine/Manuscript/201207/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_12$year <- "2012"
af90_12 <- readRDS("Psardine/Manuscript/201207/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_12$year <- "2012"

#2013
af10_13 <- readRDS("Psardine/Manuscript/201307/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_13$year <- "2013"
af30_13 <- readRDS("Psardine/Manuscript/201307/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_13$year <- "2013"
af50_13 <- readRDS("Psardine/Manuscript/201307/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_13$year <- "2013"
af70_13 <- readRDS("Psardine/Manuscript/201307/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_13$year <- "2013"
af90_13 <- readRDS("Psardine/Manuscript/201307/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_13$year <- "2013"

#2017
af10_17 <- readRDS("Psardine/Manuscript/201707/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_17$year <- "2017"
af30_17 <- readRDS("Psardine/Manuscript/201707/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_17$year <- "2017"
af50_17 <- readRDS("Psardine/Manuscript/201707/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_17$year <- "2017"
af70_17 <- readRDS("Psardine/Manuscript/201707/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_17$year <- "2017"
af90_17 <- readRDS("Psardine/Manuscript/201707/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_17$year <- "2017"

#2018
#af10_18 <- readRDS("Psardine/Manuscript/201807/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_18$year <- "2018"
af30_18 <- readRDS("Psardine/Manuscript/201807/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_18$year <- "2018"
af50_18 <- readRDS("Psardine/Manuscript/201807/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_18$year <- "2018"
af70_18 <- readRDS("Psardine/Manuscript/201807/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_18$year <- "2018"
af90_18 <- readRDS("Psardine/Manuscript/201807/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_18$year <- "2018"

#2019
af10_19 <- readRDS("Psardine/Manuscript/201907/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_19$year <- "2019"
af30_19 <- readRDS("Psardine/Manuscript/201907/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_19$year <- "2019"
af50_19 <- readRDS("Psardine/Manuscript/201907/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_19$year <- "2019"
af70_19 <- readRDS("Psardine/Manuscript/201907/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_19$year <- "2019"
af90_19 <- readRDS("Psardine/Manuscript/201907/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_19$year <- "2019"

#2021
#af10_21 <- readRDS("Psardine/Manuscript/202107/POS/10percent/Output/af_metrics_long_pos_10.rds"); af10_21$year <- "2021"
af30_21 <- readRDS("Psardine/Manuscript/202107/POS/30percent/Output/af_metrics_long_pos_30.rds"); af30_21$year <- "2021"
af50_21 <- readRDS("Psardine/Manuscript/202107/POS/50percent/Output/af_metrics_long_pos_50.rds"); af50_21$year <- "2021"
af70_21 <- readRDS("Psardine/Manuscript/202107/POS/70percent/Output/af_metrics_long_pos_70.rds"); af70_21$year <- "2021"
af90_21 <- readRDS("Psardine/Manuscript/202107/POS/90percent/Output/af_metrics_long_pos_90.rds"); af90_21$year <- "2021"


af.all.pos <- rbind(af30_04,af50_04,af70_04,af90_04,
                af10_05,af30_05,af50_05,af70_05,af90_05,
                af10_07,af30_07,af50_07,af70_07,af90_07,
                af10_08,af30_08,af50_08,af70_08,af90_08,
                af10_09,af30_09,af50_09,af70_09,af90_09,
                af10_11,af30_11,af50_11,af70_11,af90_11,
                af10_12,af30_12,af50_12,af70_12,af90_12,
                af10_13,af30_13,af50_13,af70_13,af90_13,
                af10_17,af30_17,af50_17,af70_17,af90_17,
                af30_18,af50_18,af70_18,af90_18,
                af10_19,af30_19,af50_19,af70_19,af90_19,
                af30_21,af50_21,af70_21,af90_21) %>%
  mutate(Type="POSs")

# age length key 
#2004
alk30_04 <- readRDS("Psardine/Manuscript/200404/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_04$year <- "2004"
alk50_04 <- readRDS("Psardine/Manuscript/200404/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_04$year <- "2004"
alk70_04 <- readRDS("Psardine/Manuscript/200404/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_04$year <- "2004"
alk90_04 <- readRDS("Psardine/Manuscript/200404/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_04$year <- "2004"

#2005
alk10_05 <- readRDS("Psardine/Manuscript/200504/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_05$year <- "2005"
alk30_05 <- readRDS("Psardine/Manuscript/200504/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_05$year <- "2005"
alk50_05 <- readRDS("Psardine/Manuscript/200504/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_05$year <- "2005"
alk70_05 <- readRDS("Psardine/Manuscript/200504/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_05$year <- "2005"
alk90_05 <- readRDS("Psardine/Manuscript/200504/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_05$year <- "2005"

#2007
alk10_07 <- readRDS("Psardine/Manuscript/200704/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_07$year <- "2007"
alk30_07 <- readRDS("Psardine/Manuscript/200704/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_07$year <- "2007"
alk50_07 <- readRDS("Psardine/Manuscript/200704/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_07$year <- "2007"
alk70_07 <- readRDS("Psardine/Manuscript/200704/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_07$year <- "2007"
alk90_07 <- readRDS("Psardine/Manuscript/200704/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_07$year <- "2007"

#2008
alk10_08 <- readRDS("Psardine/Manuscript/200807/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_08$year <- "2008"
alk30_08 <- readRDS("Psardine/Manuscript/200807/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_08$year <- "2008"
alk50_08 <- readRDS("Psardine/Manuscript/200807/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_08$year <- "2008"
alk70_08 <- readRDS("Psardine/Manuscript/200807/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_08$year <- "2008"
alk90_08 <- readRDS("Psardine/Manuscript/200807/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_08$year <- "2008"

#2009
alk10_09 <- readRDS("Psardine/Manuscript/200904/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_09$year <- "2009"
alk30_09 <- readRDS("Psardine/Manuscript/200904/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_09$year <- "2009"
alk50_09 <- readRDS("Psardine/Manuscript/200904/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_09$year <- "2009"
alk70_09 <- readRDS("Psardine/Manuscript/200904/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_09$year <- "2009"
alk90_09 <- readRDS("Psardine/Manuscript/200904/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_09$year <- "2009"

#2011
alk10_11 <- readRDS("Psardine/Manuscript/201104/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_11$year <- "2011"
alk30_11 <- readRDS("Psardine/Manuscript/201104/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_11$year <- "2011"
alk50_11 <- readRDS("Psardine/Manuscript/201104/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_11$year <- "2011"
alk70_11 <- readRDS("Psardine/Manuscript/201104/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_11$year <- "2011"
alk90_11 <- readRDS("Psardine/Manuscript/201104/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_11$year <- "2011"

#2012
alk10_12 <- readRDS("Psardine/Manuscript/201207/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_12$year <- "2012"
alk30_12 <- readRDS("Psardine/Manuscript/201207/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_12$year <- "2012"
alk50_12 <- readRDS("Psardine/Manuscript/201207/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_12$year <- "2012"
alk70_12 <- readRDS("Psardine/Manuscript/201207/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_12$year <- "2012"
alk90_12 <- readRDS("Psardine/Manuscript/201207/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_12$year <- "2012"

#2013
alk10_13 <- readRDS("Psardine/Manuscript/201307/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_13$year <- "2013"
alk30_13 <- readRDS("Psardine/Manuscript/201307/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_13$year <- "2013"
alk50_13 <- readRDS("Psardine/Manuscript/201307/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_13$year <- "2013"
alk70_13 <- readRDS("Psardine/Manuscript/201307/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_13$year <- "2013"
alk90_13 <- readRDS("Psardine/Manuscript/201307/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_13$year <- "2013"

#2017
alk10_17 <- readRDS("Psardine/Manuscript/201707/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_17$year <- "2017"
alk30_17 <- readRDS("Psardine/Manuscript/201707/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_17$year <- "2017"
alk50_17 <- readRDS("Psardine/Manuscript/201707/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_17$year <- "2017"
alk70_17 <- readRDS("Psardine/Manuscript/201707/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_17$year <- "2017"
alk90_17 <- readRDS("Psardine/Manuscript/201707/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_17$year <- "2017"

#2018
#alk10_18 <- readRDS("Psardine/Manuscript/201807/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_18$year <- "2018"
alk30_18 <- readRDS("Psardine/Manuscript/201807/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_18$year <- "2018"
alk50_18 <- readRDS("Psardine/Manuscript/201807/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_18$year <- "2018"
alk70_18 <- readRDS("Psardine/Manuscript/201807/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_18$year <- "2018"
alk90_18 <- readRDS("Psardine/Manuscript/201807/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_18$year <- "2018"

#2019
alk10_19 <- readRDS("Psardine/Manuscript/201907/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_19$year <- "2019"
alk30_19 <- readRDS("Psardine/Manuscript/201907/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_19$year <- "2019"
alk50_19 <- readRDS("Psardine/Manuscript/201907/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_19$year <- "2019"
alk70_19 <- readRDS("Psardine/Manuscript/201907/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_19$year <- "2019"
alk90_19 <- readRDS("Psardine/Manuscript/201907/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_19$year <- "2019"

#2021
#alk10_21 <- readRDS("Psardine/Manuscript/202107/POS/10percent/Output/alk_data_all_pos_10.rds"); alk10_21$year <- "2021"
alk30_21 <- readRDS("Psardine/Manuscript/202107/POS/30percent/Output/alk_data_all_pos_30.rds"); alk30_21$year <- "2021"
alk50_21 <- readRDS("Psardine/Manuscript/202107/POS/50percent/Output/alk_data_all_pos_50.rds"); alk50_21$year <- "2021"
alk70_21 <- readRDS("Psardine/Manuscript/202107/POS/70percent/Output/alk_data_all_pos_70.rds"); alk70_21$year <- "2021"
alk90_21 <- readRDS("Psardine/Manuscript/202107/POS/90percent/Output/alk_data_all_pos_90.rds"); alk90_21$year <- "2021"

alk.data.pos.all <- rbind(alk30_04,alk50_04,alk70_04,alk90_04,
                      alk10_05,alk30_05,alk50_05,alk70_05,alk90_05,
                      alk10_07,alk30_07,alk50_07,alk70_07,alk90_07,
                      alk10_08,alk30_08,alk50_08,alk70_08,alk90_08,
                      alk10_09,alk30_09,alk50_09,alk70_09,alk90_09,
                      alk10_11,alk30_11,alk50_11,alk70_11,alk90_11,
                      alk10_12,alk30_12,alk50_12,alk70_12,alk90_12,
                      alk10_13,alk30_13,alk50_13,alk70_13,alk90_13,
                      alk10_17,alk30_17,alk50_17,alk70_17,alk90_17,
                      alk30_18,alk50_18,alk70_18,alk90_18,
                      alk10_19,alk30_19,alk50_19,alk70_19,alk90_19,
                      alk30_21,alk50_21,alk70_21,alk90_21) %>%
  mutate(Type="POSs")

alk.data.pos.all$MAPD_new <- alk.data.pos.all$MAPD_model
alk.data.pos.all$age <- as.numeric(alk.data.pos.all$age)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==0 & alk.data.pos.all$bin>180,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==1 & alk.data.pos.all$bin<90|alk.data.pos.all$bin>270,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==2 & alk.data.pos.all$bin<110|alk.data.pos.all$bin>280,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==3 & alk.data.pos.all$bin<140|alk.data.pos.all$bin>280,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==4 & alk.data.pos.all$bin<150|alk.data.pos.all$bin>290,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==5 & alk.data.pos.all$bin<190,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==6 & alk.data.pos.all$bin<190,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==7 & alk.data.pos.all$bin<200,0,alk.data.pos.all$MAPD_new)
alk.data.pos.all$MAPD_new <- ifelse(alk.data.pos.all$age==8 & alk.data.pos.all$bin<220,0,alk.data.pos.all$MAPD_new)

# subset data
#2004
sub.data30_04 <- readRDS("Psardine/Manuscript/200404/POS/30percent/Output/subset_data_30.rds"); sub.data30_04$year <- "2004"; sub.data30_04$run <- "30%"
sub.data50_04 <- readRDS("Psardine/Manuscript/200404/POS/50percent/Output/subset_data_50.rds"); sub.data50_04$year <- "2004"; sub.data50_04$run <- "50%"
sub.data70_04 <- readRDS("Psardine/Manuscript/200404/POS/70percent/Output/subset_data_70.rds"); sub.data70_04$year <- "2004"; sub.data70_04$run <- "70%"
sub.data90_04 <- readRDS("Psardine/Manuscript/200404/POS/90percent/Output/subset_data_90.rds"); sub.data90_04$year <- "2004"; sub.data90_04$run <- "90%"

#2005
sub.data10_05 <- readRDS("Psardine/Manuscript/200504/POS/10percent/Output/subset_data_10.rds"); sub.data10_05$year <- "2005"; sub.data10_05$run <- "10%"
sub.data30_05 <- readRDS("Psardine/Manuscript/200504/POS/30percent/Output/subset_data_30.rds"); sub.data30_05$year <- "2005"; sub.data30_05$run <- "30%"
sub.data50_05 <- readRDS("Psardine/Manuscript/200504/POS/50percent/Output/subset_data_50.rds"); sub.data50_05$year <- "2005"; sub.data50_05$run <- "50%"
sub.data70_05 <- readRDS("Psardine/Manuscript/200504/POS/70percent/Output/subset_data_70.rds"); sub.data70_05$year <- "2005"; sub.data70_05$run <- "70%"
sub.data90_05 <- readRDS("Psardine/Manuscript/200504/POS/90percent/Output/subset_data_90.rds"); sub.data90_05$year <- "2005"; sub.data90_05$run <- "90%"

#2007
sub.data10_07 <- readRDS("Psardine/Manuscript/200704/POS/10percent/Output/subset_data_10.rds"); sub.data10_07$year <- "2007"; sub.data10_07$run <- "10%"
sub.data30_07 <- readRDS("Psardine/Manuscript/200704/POS/30percent/Output/subset_data_30.rds"); sub.data30_07$year <- "2007"; sub.data30_07$run <- "30%"
sub.data50_07 <- readRDS("Psardine/Manuscript/200704/POS/50percent/Output/subset_data_50.rds"); sub.data50_07$year <- "2007"; sub.data50_07$run <- "50%"
sub.data70_07 <- readRDS("Psardine/Manuscript/200704/POS/70percent/Output/subset_data_70.rds"); sub.data70_07$year <- "2007"; sub.data70_07$run <- "70%"
sub.data90_07 <- readRDS("Psardine/Manuscript/200704/POS/90percent/Output/subset_data_90.rds"); sub.data90_07$year <- "2007"; sub.data90_07$run <- "90%"

#2008
sub.data10_08 <- readRDS("Psardine/Manuscript/200807/POS/10percent/Output/subset_data_10.rds"); sub.data10_08$year <- "2008"; sub.data10_08$run <- "10%"
sub.data30_08 <- readRDS("Psardine/Manuscript/200807/POS/30percent/Output/subset_data_30.rds"); sub.data30_08$year <- "2008"; sub.data30_08$run <- "30%"
sub.data50_08 <- readRDS("Psardine/Manuscript/200807/POS/50percent/Output/subset_data_50.rds"); sub.data50_08$year <- "2008"; sub.data50_08$run <- "50%"
sub.data70_08 <- readRDS("Psardine/Manuscript/200807/POS/70percent/Output/subset_data_70.rds"); sub.data70_08$year <- "2008"; sub.data70_08$run <- "70%"
sub.data90_08 <- readRDS("Psardine/Manuscript/200807/POS/90percent/Output/subset_data_90.rds"); sub.data90_08$year <- "2008"; sub.data90_08$run <- "90%"

#2009
sub.data10_09 <- readRDS("Psardine/Manuscript/200904/POS/10percent/Output/subset_data_10.rds"); sub.data10_09$year <- "2009"; sub.data10_09$run <- "10%"
sub.data30_09 <- readRDS("Psardine/Manuscript/200904/POS/30percent/Output/subset_data_30.rds"); sub.data30_09$year <- "2009"; sub.data30_09$run <- "30%"
sub.data50_09 <- readRDS("Psardine/Manuscript/200904/POS/50percent/Output/subset_data_50.rds"); sub.data50_09$year <- "2009"; sub.data50_09$run <- "50%"
sub.data70_09 <- readRDS("Psardine/Manuscript/200904/POS/70percent/Output/subset_data_70.rds"); sub.data70_09$year <- "2009"; sub.data70_09$run <- "70%"
sub.data90_09 <- readRDS("Psardine/Manuscript/200904/POS/90percent/Output/subset_data_90.rds"); sub.data90_09$year <- "2009"; sub.data90_09$run <- "90%"

#2011
sub.data10_11 <- readRDS("Psardine/Manuscript/201104/POS/10percent/Output/subset_data_10.rds"); sub.data10_11$year <- "2011"; sub.data10_11$run <- "10%"
sub.data30_11 <- readRDS("Psardine/Manuscript/201104/POS/30percent/Output/subset_data_30.rds"); sub.data30_11$year <- "2011"; sub.data30_11$run <- "30%"
sub.data50_11 <- readRDS("Psardine/Manuscript/201104/POS/50percent/Output/subset_data_50.rds"); sub.data50_11$year <- "2011"; sub.data50_11$run <- "50%"
sub.data70_11 <- readRDS("Psardine/Manuscript/201104/POS/70percent/Output/subset_data_70.rds"); sub.data70_11$year <- "2011"; sub.data70_11$run <- "70%"
sub.data90_11 <- readRDS("Psardine/Manuscript/201104/POS/90percent/Output/subset_data_90.rds"); sub.data90_11$year <- "2011"; sub.data90_11$run <- "90%"

#2012
sub.data10_12 <- readRDS("Psardine/Manuscript/201207/POS/10percent/Output/subset_data_10.rds"); sub.data10_12$year <- "2012"; sub.data10_12$run <- "10%"
sub.data30_12 <- readRDS("Psardine/Manuscript/201207/POS/30percent/Output/subset_data_30.rds"); sub.data30_12$year <- "2012"; sub.data30_12$run <- "30%"
sub.data50_12 <- readRDS("Psardine/Manuscript/201207/POS/50percent/Output/subset_data_50.rds"); sub.data50_12$year <- "2012"; sub.data50_12$run <- "50%"
sub.data70_12 <- readRDS("Psardine/Manuscript/201207/POS/70percent/Output/subset_data_70.rds"); sub.data70_12$year <- "2012"; sub.data70_12$run <- "70%"
sub.data90_12 <- readRDS("Psardine/Manuscript/201207/POS/90percent/Output/subset_data_90.rds"); sub.data90_12$year <- "2012"; sub.data90_12$run <- "90%"

#2013
sub.data10_13 <- readRDS("Psardine/Manuscript/201307/POS/10percent/Output/subset_data_10.rds"); sub.data10_13$year <- "2013"; sub.data10_13$run <- "10%"
sub.data30_13 <- readRDS("Psardine/Manuscript/201307/POS/30percent/Output/subset_data_30.rds"); sub.data30_13$year <- "2013"; sub.data30_13$run <- "30%"
sub.data50_13 <- readRDS("Psardine/Manuscript/201307/POS/50percent/Output/subset_data_50.rds"); sub.data50_13$year <- "2013"; sub.data50_13$run <- "50%"
sub.data70_13 <- readRDS("Psardine/Manuscript/201307/POS/70percent/Output/subset_data_70.rds"); sub.data70_13$year <- "2013"; sub.data70_13$run <- "70%"
sub.data90_13 <- readRDS("Psardine/Manuscript/201307/POS/90percent/Output/subset_data_90.rds"); sub.data90_13$year <- "2013"; sub.data90_13$run <- "90%"

#2017
sub.data10_17 <- readRDS("Psardine/Manuscript/201707/POS/10percent/Output/subset_data_10.rds"); sub.data10_17$year <- "2017"; sub.data10_17$run <- "10%"
sub.data30_17 <- readRDS("Psardine/Manuscript/201707/POS/30percent/Output/subset_data_30.rds"); sub.data30_17$year <- "2017"; sub.data30_17$run <- "30%"
sub.data50_17 <- readRDS("Psardine/Manuscript/201707/POS/50percent/Output/subset_data_50.rds"); sub.data50_17$year <- "2017"; sub.data50_17$run <- "50%"
sub.data70_17 <- readRDS("Psardine/Manuscript/201707/POS/70percent/Output/subset_data_70.rds"); sub.data70_17$year <- "2017"; sub.data70_17$run <- "70%"
sub.data90_17 <- readRDS("Psardine/Manuscript/201707/POS/90percent/Output/subset_data_90.rds"); sub.data90_17$year <- "2017"; sub.data90_17$run <- "90%"

#2018
#sub.data10_18 <- readRDS("Psardine/Manuscript/201807/POS/10percent/Output/subset_data_10.rds"); sub.data10_18$year <- "2018"
sub.data30_18 <- readRDS("Psardine/Manuscript/201807/POS/30percent/Output/subset_data_30.rds"); sub.data30_18$year <- "2018"; sub.data30_18$run <- "30%"
sub.data50_18 <- readRDS("Psardine/Manuscript/201807/POS/50percent/Output/subset_data_50.rds"); sub.data50_18$year <- "2018"; sub.data50_18$run <- "50%"
sub.data70_18 <- readRDS("Psardine/Manuscript/201807/POS/70percent/Output/subset_data_70.rds"); sub.data70_18$year <- "2018"; sub.data70_18$run <- "70%"
sub.data90_18 <- readRDS("Psardine/Manuscript/201807/POS/90percent/Output/subset_data_90.rds"); sub.data90_18$year <- "2018"; sub.data90_18$run <- "90%"

#2019
sub.data10_19 <- readRDS("Psardine/Manuscript/201907/POS/10percent/Output/subset_data_10.rds"); sub.data10_19$year <- "2019"; sub.data10_19$run <- "10%"
sub.data30_19 <- readRDS("Psardine/Manuscript/201907/POS/30percent/Output/subset_data_30.rds"); sub.data30_19$year <- "2019"; sub.data30_19$run <- "30%"
sub.data50_19 <- readRDS("Psardine/Manuscript/201907/POS/50percent/Output/subset_data_50.rds"); sub.data50_19$year <- "2019"; sub.data50_19$run <- "50%"
sub.data70_19 <- readRDS("Psardine/Manuscript/201907/POS/70percent/Output/subset_data_70.rds"); sub.data70_19$year <- "2019"; sub.data70_19$run <- "70%"
sub.data90_19 <- readRDS("Psardine/Manuscript/201907/POS/90percent/Output/subset_data_90.rds"); sub.data90_19$year <- "2019"; sub.data90_19$run <- "90%"

#2021
#sub.data10_21 <- readRDS("Psardine/Manuscript/202107/POS/10percent/Output/subset_data_10.rds"); sub.data10_21$year <- "2021"; sub.data10_21$run <- "10%"
sub.data30_21 <- readRDS("Psardine/Manuscript/202107/POS/30percent/Output/subset_data_30.rds"); sub.data30_21$year <- "2021"; sub.data30_21$run <- "30%"
sub.data50_21 <- readRDS("Psardine/Manuscript/202107/POS/50percent/Output/subset_data_50.rds"); sub.data50_21$year <- "2021"; sub.data50_21$run <- "50%"
sub.data70_21 <- readRDS("Psardine/Manuscript/202107/POS/70percent/Output/subset_data_70.rds"); sub.data70_21$year <- "2021"; sub.data70_21$run <- "70%"
sub.data90_21 <- readRDS("Psardine/Manuscript/202107/POS/90percent/Output/subset_data_90.rds"); sub.data90_21$year <- "2021"; sub.data90_21$run <- "90%"

sub.data.pos.all <- bind_rows(sub.data30_04,sub.data50_04,sub.data70_04,sub.data90_04,
                      sub.data10_05,sub.data30_05,sub.data50_05,sub.data70_05,sub.data90_05,
                      sub.data10_07,sub.data30_07,sub.data50_07,sub.data70_07,sub.data90_07,
                      sub.data10_08,sub.data30_08,sub.data50_08,sub.data70_08,sub.data90_08,
                      sub.data10_09,sub.data30_09,sub.data50_09,sub.data70_09,sub.data90_09,
                      sub.data10_11,sub.data30_11,sub.data50_11,sub.data70_11,sub.data90_11,
                      sub.data10_12,sub.data30_12,sub.data50_12,sub.data70_12,sub.data90_12,
                      sub.data10_13,sub.data30_13,sub.data50_13,sub.data70_13,sub.data90_13,
                      sub.data10_17,sub.data30_17,sub.data50_17,sub.data70_17,sub.data90_17,
                      sub.data30_18,sub.data50_18,sub.data70_18,sub.data90_18,
                      sub.data10_19,sub.data30_19,sub.data50_19,sub.data70_19,sub.data90_19,
                      sub.data30_21,sub.data50_21,sub.data70_21,sub.data90_21) %>%
  mutate(Type="POSs")

sub.data.pos <- sub.data.pos.all %>% filter(rep==1)

saveRDS(sub.data.pos, "PSardine/Manuscript/year_comparisons/sub.data.pos.RDS")




# Hybrid ######
# FINAL OUTPUT FOR 10 mm RUNS FOR 200404
p3010_04 <-readRDS("Psardine/Manuscript/200404/Hybrid/Run-3010/Output/final_output_200404_hy_r3010.rds"); p3010_04$year <- "2004"
p3030_04 <-readRDS("Psardine/Manuscript/200404/Hybrid/Run-3030/Output/final_output_200404_hy_r3030.rds"); p3030_04$year <- "2004"
p3050_04 <-readRDS("Psardine/Manuscript/200404/Hybrid/Run-3050/Output/final_output_200404_hy_r3050.rds"); p3050_04$year <- "2004"
p4030_04 <-readRDS("Psardine/Manuscript/200404/Hybrid/Run-4030/Output/final_output_200404_hy_r4030.rds"); p4030_04$year <- "2004"
p4050_04 <-readRDS("Psardine/Manuscript/200404/Hybrid/Run-4050/Output/final_output_200404_hy_r4050.rds"); p4050_04$year <- "2004"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200504
p3010_05 <-readRDS("Psardine/Manuscript/200504/Hybrid/Run-3010/Output/final_output_200504_hy_r3010.rds"); p3010_05$year <- "2005"
p3030_05 <-readRDS("Psardine/Manuscript/200504/Hybrid/Run-3030/Output/final_output_200504_hy_r3030.rds"); p3030_05$year <- "2005"
p3050_05 <-readRDS("Psardine/Manuscript/200504/Hybrid/Run-3050/Output/final_output_200504_hy_r3050.rds"); p3050_05$year <- "2005"
p4030_05 <-readRDS("Psardine/Manuscript/200504/Hybrid/Run-4030/Output/final_output_200504_hy_r4030.rds"); p4030_05$year <- "2005"
p4050_05 <-readRDS("Psardine/Manuscript/200504/Hybrid/Run-4050/Output/final_output_200504_hy_r4050.rds"); p4050_05$year <- "2005"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200704
p3010_07 <-readRDS("Psardine/Manuscript/200704/Hybrid/Run-3010/Output/final_output_200704_hy_r3010.rds"); p3010_07$year <- "2007"
p3030_07 <-readRDS("Psardine/Manuscript/200704/Hybrid/Run-3030/Output/final_output_200704_hy_r3030.rds"); p3030_07$year <- "2007"
p3050_07 <-readRDS("Psardine/Manuscript/200704/Hybrid/Run-3050/Output/final_output_200704_hy_r3050.rds"); p3050_07$year <- "2007"
p4030_07 <-readRDS("Psardine/Manuscript/200704/Hybrid/Run-4030/Output/final_output_200704_hy_r4030.rds"); p4030_07$year <- "2007"
p4050_07 <-readRDS("Psardine/Manuscript/200704/Hybrid/Run-4050/Output/final_output_200704_hy_r4050.rds"); p4050_07$year <- "2007"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200807
p3010_08 <-readRDS("Psardine/Manuscript/200807/Hybrid/Run-3010/Output/final_output_200807_hy_r3010.rds"); p3010_08$year <- "2008"
p3030_08 <-readRDS("Psardine/Manuscript/200807/Hybrid/Run-3030/Output/final_output_200807_hy_r3030.rds"); p3030_08$year <- "2008"
p3050_08 <-readRDS("Psardine/Manuscript/200807/Hybrid/Run-3050/Output/final_output_200807_hy_r3050.rds"); p3050_08$year <- "2008"
p4030_08 <-readRDS("Psardine/Manuscript/200807/Hybrid/Run-4030/Output/final_output_200807_hy_r4030.rds"); p4030_08$year <- "2008"
p4050_08 <-readRDS("Psardine/Manuscript/200807/Hybrid/Run-4050/Output/final_output_200807_hy_r4050.rds"); p4050_08$year <- "2008"

# FINAL OUTPUT FOR 10 mm RUNS FOR 200904
p3010_09 <-readRDS("Psardine/Manuscript/200904/Hybrid/Run-3010/Output/final_output_200904_hy_r3010.rds"); p3010_09$year <- "2009"
p3030_09 <-readRDS("Psardine/Manuscript/200904/Hybrid/Run-3030/Output/final_output_200904_hy_r3030.rds"); p3030_09$year <- "2009"
p3050_09 <-readRDS("Psardine/Manuscript/200904/Hybrid/Run-3050/Output/final_output_200904_hy_r3050.rds"); p3050_09$year <- "2009"
p4030_09 <-readRDS("Psardine/Manuscript/200904/Hybrid/Run-4030/Output/final_output_200904_hy_r4030.rds"); p4030_09$year <- "2009"
p4050_09 <-readRDS("Psardine/Manuscript/200904/Hybrid/Run-4050/Output/final_output_200904_hy_r4050.rds"); p4050_09$year <- "2009"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201104
p3010_11 <-readRDS("Psardine/Manuscript/201104/Hybrid/Run-3010/Output/final_output_201104_hy_r3010.rds"); p3010_11$year <- "2011"
p3030_11 <-readRDS("Psardine/Manuscript/201104/Hybrid/Run-3030/Output/final_output_201104_hy_r3030.rds"); p3030_11$year <- "2011"
p3050_11 <-readRDS("Psardine/Manuscript/201104/Hybrid/Run-3050/Output/final_output_201104_hy_r3050.rds"); p3050_11$year <- "2011"
p4030_11 <-readRDS("Psardine/Manuscript/201104/Hybrid/Run-4030/Output/final_output_201104_hy_r4030.rds"); p4030_11$year <- "2011"
p4050_11 <-readRDS("Psardine/Manuscript/201104/Hybrid/Run-4050/Output/final_output_201104_hy_r4050.rds"); p4050_11$year <- "2011"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201207
p3010_12 <-readRDS("Psardine/Manuscript/201207/Hybrid/Run-3010/Output/final_output_201207_hy_r3010.rds"); p3010_12$year <- "2012"
p3030_12 <-readRDS("Psardine/Manuscript/201207/Hybrid/Run-3030/Output/final_output_201207_hy_r3030.rds"); p3030_12$year <- "2012"
p3050_12 <-readRDS("Psardine/Manuscript/201207/Hybrid/Run-3050/Output/final_output_201207_hy_r3050.rds"); p3050_12$year <- "2012"
p4030_12 <-readRDS("Psardine/Manuscript/201207/Hybrid/Run-4030/Output/final_output_201207_hy_r4030.rds"); p4030_12$year <- "2012"
p4050_12 <-readRDS("Psardine/Manuscript/201207/Hybrid/Run-4050/Output/final_output_201207_hy_r4050.rds"); p4050_12$year <- "2012"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201307
p3010_13 <-readRDS("Psardine/Manuscript/201307/Hybrid/Run-3010/Output/final_output_201307_hy_r3010.rds"); p3010_13$year <- "2013"
p3030_13 <-readRDS("Psardine/Manuscript/201307/Hybrid/Run-3030/Output/final_output_201307_hy_r3030.rds"); p3030_13$year <- "2013"
p3050_13 <-readRDS("Psardine/Manuscript/201307/Hybrid/Run-3050/Output/final_output_201307_hy_r3050.rds"); p3050_13$year <- "2013"
p4030_13 <-readRDS("Psardine/Manuscript/201307/Hybrid/Run-4030/Output/final_output_201307_hy_r4030.rds"); p4030_13$year <- "2013"
p4050_13 <-readRDS("Psardine/Manuscript/201307/Hybrid/Run-4050/Output/final_output_201307_hy_r4050.rds"); p4050_13$year <- "2013"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201707
p3010_17 <-readRDS("Psardine/Manuscript/201707/Hybrid/Run-3010/Output/final_output_201707_hy_r3010.rds"); p3010_17$year <- "2017"
p3030_17 <-readRDS("Psardine/Manuscript/201707/Hybrid/Run-3030/Output/final_output_201707_hy_r3030.rds"); p3030_17$year <- "2017"
p3050_17 <-readRDS("Psardine/Manuscript/201707/Hybrid/Run-3050/Output/final_output_201707_hy_r3050.rds"); p3050_17$year <- "2017"
p4030_17 <-readRDS("Psardine/Manuscript/201707/Hybrid/Run-4030/Output/final_output_201707_hy_r4030.rds"); p4030_17$year <- "2017"
p4050_17 <-readRDS("Psardine/Manuscript/201707/Hybrid/Run-4050/Output/final_output_201707_hy_r4050.rds"); p4050_17$year <- "2017"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201807
p3010_18 <-readRDS("Psardine/Manuscript/201807/Hybrid/Run-3010/Output/final_output_201807_hy_r3010.rds"); p3010_18$year <- "2018"
p3030_18 <-readRDS("Psardine/Manuscript/201807/Hybrid/Run-3030/Output/final_output_201807_hy_r3030.rds"); p3030_18$year <- "2018"
p3050_18 <-readRDS("Psardine/Manuscript/201807/Hybrid/Run-3050/Output/final_output_201807_hy_r3050.rds"); p3050_18$year <- "2018"
p4030_18 <-readRDS("Psardine/Manuscript/201807/Hybrid/Run-4030/Output/final_output_201807_hy_r4030.rds"); p4030_18$year <- "2018"
p4050_18 <-readRDS("Psardine/Manuscript/201807/Hybrid/Run-4050/Output/final_output_201807_hy_r4050.rds"); p4050_18$year <- "2018"

# FINAL OUTPUT FOR 10 mm RUNS FOR 201907
p3010_19 <-readRDS("Psardine/Manuscript/201907/Hybrid/Run-3010/Output/final_output_201907_hy_r3010.rds"); p3010_19$year <- "2019"
p3030_19 <-readRDS("Psardine/Manuscript/201907/Hybrid/Run-3030/Output/final_output_201907_hy_r3030.rds"); p3030_19$year <- "2019"
p3050_19 <-readRDS("Psardine/Manuscript/201907/Hybrid/Run-3050/Output/final_output_201907_hy_r3050.rds"); p3050_19$year <- "2019"
p4030_19 <-readRDS("Psardine/Manuscript/201907/Hybrid/Run-4030/Output/final_output_201907_hy_r4030.rds"); p4030_19$year <- "2019"
p4050_19 <-readRDS("Psardine/Manuscript/201907/Hybrid/Run-4050/Output/final_output_201907_hy_r4050.rds"); p4050_19$year <- "2019"

# FINAL OUTPUT FOR 10 mm RUNS FOR 202107
p3010_21 <-readRDS("Psardine/Manuscript/202107/Hybrid/Run-3010/Output/final_output_202107_hy_r3010.rds"); p3010_21$year <- "2021"
p3030_21 <-readRDS("Psardine/Manuscript/202107/Hybrid/Run-3030/Output/final_output_202107_hy_r3030.rds"); p3030_21$year <- "2021"
p3050_21 <-readRDS("Psardine/Manuscript/202107/Hybrid/Run-3050/Output/final_output_202107_hy_r3050.rds"); p3050_21$year <- "2021"
p4030_21 <-readRDS("Psardine/Manuscript/202107/Hybrid/Run-4030/Output/final_output_202107_hy_r4030.rds"); p4030_21$year <- "2021"
p4050_21 <-readRDS("Psardine/Manuscript/202107/Hybrid/Run-4050/Output/final_output_202107_hy_r4050.rds"); p4050_21$year <- "2021"

final.hy <- rbind(p3010_04,p3030_04,p3050_04,p4030_04,p4050_04,
               p3010_05,p3030_05,p3050_05,p4030_05,p4050_05,
               p3010_07,p3030_07,p3050_07,p4030_07,p4050_07,
               p3010_08,p3030_08,p3050_08,p4030_08,p4050_08,
               p3010_09,p3030_09,p3050_09,p4030_09,p4050_09,
               p3010_11,p3030_11,p3050_11,p4030_11,p4050_11,
               p3010_12,p3030_12,p3050_12,p4030_12,p4050_12,
               p3010_13,p3030_13,p3050_13,p4030_13,p4050_13,
               p3010_17,p3030_17,p3050_17,p4030_17,p4050_17,
               p3010_18,p3030_18,p3050_18,p4030_18,p4050_18,
               p3010_19,p3030_19,p3050_19,p4030_19,p4050_19,
               p3010_21,p3030_21,p3050_21,p4030_21,p4050_21) %>% 
  mutate(Type="Hybrid")

final.sort.metric.hy <- final.hy[order(final.hy$Metric),]

# age frequency 
#2004
af3010_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_04$year <- "2004"
af3030_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_04$year <- "2004"
af3050_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_04$year <- "2004"
af4030_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_04$year <- "2004"
af4050_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_04$year <- "2004"

#2005
af3010_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_05$year <- "2005"
af3030_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_05$year <- "2005"
af3050_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_05$year <- "2005"
af4030_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_05$year <- "2005"
af4050_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_05$year <- "2005"

#2007
af3010_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_07$year <- "2007"
af3030_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_07$year <- "2007"
af3050_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_07$year <- "2007"
af4030_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_07$year <- "2007"
af4050_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_07$year <- "2007"

#2008
af3010_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_08$year <- "2008"
af3030_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_08$year <- "2008"
af3050_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_08$year <- "2008"
af4030_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_08$year <- "2008"
af4050_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_08$year <- "2008"

#2009
af3010_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_09$year <- "2009" 
af3030_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_09$year <- "2009" 
af3050_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_09$year <- "2009" 
af4030_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_09$year <- "2009" 
af4050_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_09$year <- "2009" 

#2011
af3010_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_11$year <- "2011" 
af3030_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_11$year <- "2011" 
af3050_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_11$year <- "2011" 
af4030_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_11$year <- "2011" 
af4050_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_11$year <- "2011" 

#2012
af3010_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_12$year <- "2012"
af3030_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_12$year <- "2012"
af3050_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_12$year <- "2012"
af4030_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_12$year <- "2012"
af4050_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_12$year <- "2012"

#2013
af3010_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_13$year <- "2013"
af3030_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_13$year <- "2013"
af3050_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_13$year <- "2013"
af4030_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_13$year <- "2013"
af4050_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_13$year <- "2013"

#2017
af3010_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_17$year <- "2017"
af3030_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_17$year <- "2017"
af3050_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_17$year <- "2017"
af4030_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_17$year <- "2017"
af4050_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_17$year <- "2017"

#2018
af3010_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_18$year <- "2018"
af3030_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_18$year <- "2018"
af3050_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_18$year <- "2018"
af4030_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_18$year <- "2018"
af4050_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_18$year <- "2018"

#2019
af3010_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_19$year <- "2019"
af3030_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_19$year <- "2019"
af3050_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_19$year <- "2019"
af4030_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_19$year <- "2019"
af4050_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_19$year <- "2019"

#2021
af3010_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3010/Output/af_metrics_long_hy_r3010.rds"); af3010_21$year <- "2021"
af3030_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3030/Output/af_metrics_long_hy_r3030.rds"); af3030_21$year <- "2021"
af3050_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3050/Output/af_metrics_long_hy_r3050.rds"); af3050_21$year <- "2021"
af4030_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-4030/Output/af_metrics_long_hy_r4030.rds"); af4030_21$year <- "2021"
af4050_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-4050/Output/af_metrics_long_hy_r4050.rds"); af4050_21$year <- "2021"


af.all.hy <- rbind(af3010_04,af3030_04,af3050_04,af4030_04,af4050_04,
                af3010_05,af3030_05,af3050_05,af4030_05,af4050_05,
                af3010_07,af3030_07,af3050_07,af4030_07,af4050_07,
                af3010_08,af3030_08,af3050_08,af4030_08,af4050_08,
                af3010_09,af3030_09,af3050_09,af4030_09,af4050_09,
                af3010_11,af3030_11,af3050_11,af4030_11,af4050_11,
                af3010_12,af3030_12,af3050_12,af4030_12,af4050_12,
                af3010_13,af3030_13,af3050_13,af4030_13,af4050_13,
                af3010_17,af3030_17,af3050_17,af4030_17,af4050_17,
                af3010_18,af3030_18,af3050_18,af4030_18,af4050_18,
                af3010_19,af3030_19,af3050_19,af4030_19,af4050_19,
                af3010_21,af3030_21,af3050_21,af4030_21,af4050_21) %>%
  mutate(Type="Hybrid")

# age length key ###
# 2004
alk3010_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_04$year <- "2004"
alk3030_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_04$year <- "2004"
alk3050_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_04$year <- "2004"
alk4030_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_04$year <- "2004"
alk4050_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_04$year <- "2004"

# 2005
alk3010_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_05$year <- "2005"
alk3030_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_05$year <- "2005"
alk3050_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_05$year <- "2005"
alk4030_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_05$year <- "2005"
alk4050_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_05$year <- "2005"

# 2007
alk3010_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_07$year <- "2007"
alk3030_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_07$year <- "2007"
alk3050_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_07$year <- "2007"
alk4030_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_07$year <- "2007"
alk4050_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_07$year <- "2007"

# 2008
alk3010_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_08$year <- "2008"
alk3030_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_08$year <- "2008"
alk3050_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_08$year <- "2008"
alk4030_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_08$year <- "2008"
alk4050_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_08$year <- "2008"

# 2009
alk3010_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_09$year <- "2009"
alk3030_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_09$year <- "2009"
alk3050_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_09$year <- "2009"
alk4030_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_09$year <- "2009"
alk4050_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_09$year <- "2009"

# 2011
alk3010_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_11$year <- "2011"
alk3030_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_11$year <- "2011"
alk3050_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_11$year <- "2011"
alk4030_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_11$year <- "2011"
alk4050_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_11$year <- "2011"

# 2012
alk3010_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_12$year <- "2012"
alk3030_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_12$year <- "2012"
alk3050_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_12$year <- "2012"
alk4030_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_12$year <- "2012"
alk4050_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_12$year <- "2012"

# 2013
alk3010_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_13$year <- "2013"
alk3030_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_13$year <- "2013"
alk3050_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_13$year <- "2013"
alk4030_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_13$year <- "2013"
alk4050_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_13$year <- "2013"

# 2017
alk3010_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_17$year <- "2017"
alk3030_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_17$year <- "2017"
alk3050_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_17$year <- "2017"
alk4030_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_17$year <- "2017"
alk4050_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_17$year <- "2017"

# 2018
alk3010_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_18$year <- "2018"
alk3030_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_18$year <- "2018"
alk3050_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_18$year <- "2018"
alk4030_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_18$year <- "2018"
alk4050_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_18$year <- "2018"

# 2019
alk3010_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_19$year <- "2019"
alk3030_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_19$year <- "2019"
alk3050_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_19$year <- "2019"
alk4030_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_19$year <- "2019"
alk4050_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_19$year <- "2019"

# 2021
alk3010_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3010/Output/alk_data_all_r3010.rds"); alk3010_21$year <- "2021"
alk3030_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3030/Output/alk_data_all_r3030.rds"); alk3030_21$year <- "2021"
alk3050_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3050/Output/alk_data_all_r3050.rds"); alk3050_21$year <- "2021"
alk4030_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-4030/Output/alk_data_all_r4030.rds"); alk4030_21$year <- "2021"
alk4050_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-4050/Output/alk_data_all_r4050.rds"); alk4050_21$year <- "2021"

alk.data.hy.all <- rbind(alk3010_04,alk3030_04,alk3050_04,alk4030_04,alk4050_04,
                      alk3010_05,alk3030_05,alk3050_05,alk4030_05,alk4050_05,
                      alk3010_07,alk3030_07,alk3050_07,alk4030_07,alk4050_07,
                      alk3010_08,alk3030_08,alk3050_08,alk4030_08,alk4050_08,
                      alk3010_09,alk3030_09,alk3050_09,alk4030_09,alk4050_09,
                      alk3010_11,alk3030_11,alk3050_11,alk4030_11,alk4050_11,
                      alk3010_12,alk3030_12,alk3050_12,alk4030_12,alk4050_12,
                      alk3010_13,alk3030_13,alk3050_13,alk4030_13,alk4050_13,
                      alk3010_17,alk3030_17,alk3050_17,alk4030_17,alk4050_17,
                      alk3010_18,alk3030_18,alk3050_18,alk4030_18,alk4050_18,
                      alk3010_19,alk3030_19,alk3050_19,alk4030_19,alk4050_19,
                      alk3010_21,alk3030_21,alk3050_21,alk4030_21,alk4050_21) %>%
  mutate(Type="Hybrid")

alk.data.hy.all$MAPD_new <- alk.data.hy.all$MAPD_model
alk.data.hy.all$age <- as.numeric(alk.data.hy.all$age)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==0 & alk.data.hy.all$bin>180,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==1 & alk.data.hy.all$bin<90|alk.data.hy.all$bin>270,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==2 & alk.data.hy.all$bin<110|alk.data.hy.all$bin>280,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==3 & alk.data.hy.all$bin<140|alk.data.hy.all$bin>280,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==4 & alk.data.hy.all$bin<150|alk.data.hy.all$bin>290,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==5 & alk.data.hy.all$bin<190,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==6 & alk.data.hy.all$bin<190,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==7 & alk.data.hy.all$bin<200,0,alk.data.hy.all$MAPD_new)
alk.data.hy.all$MAPD_new <- ifelse(alk.data.hy.all$age==8 & alk.data.hy.all$bin<220,0,alk.data.hy.all$MAPD_new)

# subset data ###
# 2004
sub.data3010_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_04$year <- "2004"; sub.data3010_04$run <- "30-10"
sub.data3030_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_04$year <- "2004"; sub.data3030_04$run <- "30-30"
sub.data3050_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_04$year <- "2004"; sub.data3050_04$run <- "30-50"
sub.data4030_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_04$year <- "2004"; sub.data4030_04$run <- "40-30"
sub.data4050_04 <- readRDS("Psardine/Manuscript/200404/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_04$year <- "2004"; sub.data4050_04$run <- "40-50"

# 2005
sub.data3010_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_05$year <- "2005"; sub.data3010_05$run <- "30-10"
sub.data3030_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_05$year <- "2005"; sub.data3030_05$run <- "30-30"
sub.data3050_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_05$year <- "2005"; sub.data3050_05$run <- "30-50"
sub.data4030_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_05$year <- "2005"; sub.data4030_05$run <- "40-30"
sub.data4050_05 <- readRDS("Psardine/Manuscript/200504/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_05$year <- "2005"; sub.data4050_05$run <- "40-50"

# 2007
sub.data3010_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_07$year <- "2007"; sub.data3010_07$run <- "30-10"
sub.data3030_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_07$year <- "2007"; sub.data3030_07$run <- "30-30"
sub.data3050_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_07$year <- "2007"; sub.data3050_07$run <- "30-50"
sub.data4030_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_07$year <- "2007"; sub.data4030_07$run <- "40-30"
sub.data4050_07 <- readRDS("Psardine/Manuscript/200704/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_07$year <- "2007"; sub.data4050_07$run <- "40-50"

# 2008
sub.data3010_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_08$year <- "2008"; sub.data3010_08$run <- "30-10"
sub.data3030_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_08$year <- "2008"; sub.data3030_08$run <- "30-30"
sub.data3050_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_08$year <- "2008"; sub.data3050_08$run <- "30-50"
sub.data4030_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_08$year <- "2008"; sub.data4030_08$run <- "40-30"
sub.data4050_08 <- readRDS("Psardine/Manuscript/200807/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_08$year <- "2008"; sub.data4050_08$run <- "40-50"

# 2009
sub.data3010_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_09$year <- "2009"; sub.data3010_09$run <- "30-10"
sub.data3030_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_09$year <- "2009"; sub.data3030_09$run <- "30-30"
sub.data3050_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_09$year <- "2009"; sub.data3050_09$run <- "30-50"
sub.data4030_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_09$year <- "2009"; sub.data4030_09$run <- "40-30"
sub.data4050_09 <- readRDS("Psardine/Manuscript/200904/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_09$year <- "2009"; sub.data4050_09$run <- "40-50"

# 2011
sub.data3010_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_11$year <- "2011"; sub.data3010_11$run <- "30-10"
sub.data3030_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_11$year <- "2011"; sub.data3030_11$run <- "30-30"
sub.data3050_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_11$year <- "2011"; sub.data3050_11$run <- "30-50"
sub.data4030_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_11$year <- "2011"; sub.data4030_11$run <- "40-30"
sub.data4050_11 <- readRDS("Psardine/Manuscript/201104/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_11$year <- "2011"; sub.data4050_11$run <- "40-50"

# 2012
sub.data3010_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_12$year <- "2012"; sub.data3010_12$run <- "30-10"
sub.data3030_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_12$year <- "2012"; sub.data3030_12$run <- "30-30"
sub.data3050_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_12$year <- "2012"; sub.data3050_12$run <- "30-50"
sub.data4030_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_12$year <- "2012"; sub.data4030_12$run <- "40-30"
sub.data4050_12 <- readRDS("Psardine/Manuscript/201207/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_12$year <- "2012"; sub.data4050_12$run <- "40-50"

# 2013
sub.data3010_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_13$year <- "2013"; sub.data3010_13$run <- "30-10"
sub.data3030_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_13$year <- "2013"; sub.data3030_13$run <- "30-30"
sub.data3050_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_13$year <- "2013"; sub.data3050_13$run <- "30-50"
sub.data4030_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_13$year <- "2013"; sub.data4030_13$run <- "40-30"
sub.data4050_13 <- readRDS("Psardine/Manuscript/201307/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_13$year <- "2013"; sub.data4050_13$run <- "40-50"

# 2017
sub.data3010_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_17$year <- "2017"; sub.data3010_17$run <- "30-10"
sub.data3030_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_17$year <- "2017"; sub.data3030_17$run <- "30-30"
sub.data3050_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_17$year <- "2017"; sub.data3050_17$run <- "30-50"
sub.data4030_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_17$year <- "2017"; sub.data4030_17$run <- "40-30"
sub.data4050_17 <- readRDS("Psardine/Manuscript/201707/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_17$year <- "2017"; sub.data4050_17$run <- "40-50"

# 2018
sub.data3010_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_18$year <- "2018"; sub.data3010_18$run <- "30-10"
sub.data3030_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_18$year <- "2018"; sub.data3030_18$run <- "30-30"
sub.data3050_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_18$year <- "2018"; sub.data3050_18$run <- "30-50"
sub.data4030_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_18$year <- "2018"; sub.data4030_18$run <- "40-30"
sub.data4050_18 <- readRDS("Psardine/Manuscript/201807/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_18$year <- "2018"; sub.data4050_18$run <- "40-50"

# 2019
sub.data3010_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_19$year <- "2019"; sub.data3010_19$run <- "30-10"
sub.data3030_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_19$year <- "2019"; sub.data3030_19$run <- "30-30"
sub.data3050_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_19$year <- "2019"; sub.data3050_19$run <- "30-50"
sub.data4030_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_19$year <- "2019"; sub.data4030_19$run <- "40-30"
sub.data4050_19 <- readRDS("Psardine/Manuscript/201907/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_19$year <- "2019"; sub.data4050_19$run <- "40-50"

# 2021
sub.data3010_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3010/Output/subset_data_r3010.rds"); sub.data3010_21$year <- "2021"; sub.data3010_21$run <- "30-10"
sub.data3030_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3030/Output/subset_data_r3030.rds"); sub.data3030_21$year <- "2021"; sub.data3030_21$run <- "30-30"
sub.data3050_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-3050/Output/subset_data_r3050.rds"); sub.data3050_21$year <- "2021"; sub.data3050_21$run <- "30-50"
sub.data4030_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-4030/Output/subset_data_r4030.rds"); sub.data4030_21$year <- "2021"; sub.data4030_21$run <- "40-30"
sub.data4050_21 <- readRDS("Psardine/Manuscript/202107/Hybrid/Run-4050/Output/subset_data_r4050.rds"); sub.data4050_21$year <- "2021"; sub.data4050_21$run <- "40-50"

sub.data.hy.all <- rbind(sub.data3010_04,sub.data3030_04,sub.data3050_04,sub.data4030_04,sub.data4050_04,
                      sub.data3010_05,sub.data3030_05,sub.data3050_05,sub.data4030_05,sub.data4050_05,
                      sub.data3010_07,sub.data3030_07,sub.data3050_07,sub.data4030_07,sub.data4050_07,
                      sub.data3010_08,sub.data3030_08,sub.data3050_08,sub.data4030_08,sub.data4050_08,
                      sub.data3010_09,sub.data3030_09,sub.data3050_09,sub.data4030_09,sub.data4050_09,
                      sub.data3010_11,sub.data3030_11,sub.data3050_11,sub.data4030_11,sub.data4050_11,
                      sub.data3010_12,sub.data3030_12,sub.data3050_12,sub.data4030_12,sub.data4050_12,
                      sub.data3010_13,sub.data3030_13,sub.data3050_13,sub.data4030_13,sub.data4050_13,
                      sub.data3010_17,sub.data3030_17,sub.data3050_17,sub.data4030_17,sub.data4050_17,
                      sub.data3010_18,sub.data3030_18,sub.data3050_18,sub.data4030_18,sub.data4050_18,
                      sub.data3010_19,sub.data3030_19,sub.data3050_19,sub.data4030_19,sub.data4050_19,
                      sub.data3010_21,sub.data3030_21,sub.data3050_21,sub.data4030_21,sub.data4050_21)%>%
  mutate(Type="Hybrid")

sub.data.hy <- sub.data.hy.all %>% filter(rep==1)

saveRDS(sub.data.hy, "PSardine/Manuscript/year_comparisons/sub.data.hy.RDS")

### combing all together #########
final <- rbind(final.sort.metric.fos,final.sort.metric.pos,final.sort.metric.hy)
saveRDS(final, "PSardine/Manuscript/year_comparisons/final.sort.metric.RDS")

af.all <- rbind(af.all.fos,af.all.pos,af.all.hy)
saveRDS(af.all, "PSardine/Manuscript/year_comparisons/af.all.RDS")

alk.data.all <- rbind(alk.data.fos.all,alk.data.pos.all,alk.data.hy.all)
saveRDS(alk.data.all, "PSardine/Manuscript/year_comparisons/alk.data.all.RDS")

sub.data.all <- bind_rows(sub.data.fos,sub.data.pos,sub.data.hy) %>%
  mutate(run.label=case_match(run,"10-10"~"10","10-20"~"20","10-30"~"30","10-40"~"40","10-50"~"50",
                              "30-10"~"30+10%","30-30"~"30+30%","30-50"~"30+50%","40-30"~"40+30%","40-50"~"40+50%",.default=run)) %>%
  mutate(run.label=factor(run.label,levels=c("10","20","30","40","50","10%","30%","50%","70%","90%","30+10%","30+30%","30+50%","40+30%","40+50%")),
          Type=factor(Type, levels = c("FOS","POSs","Hybrid")))  

saveRDS(sub.data.all, "PSardine/Manuscript/year_comparisons/sub.data.all.yr.RDS")


