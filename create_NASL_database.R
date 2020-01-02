library(dplyr)
library(NASL)
library(readxl)
library(tidyr)

#July 1/2 2019
df1 <- read_excel("H:/0_HarrisLab/1_CURRENT PROJECT FOLDERS/CBL PAX River/0_raw_data/HARRIS_CBLPAX_070319_FINAL.xlsx", 
                       skip = 23)
df1<-df1 %>% 
  mutate(depth=substr(`Sample ID`, start = 1, stop = 2),
         station=substr(`Sample ID`, start = 4, stop = 7))

#July 30/31 2019
df2 <- read_excel("H:/0_HarrisLab/1_CURRENT PROJECT FOLDERS/CBL PAX River/0_raw_data/HARRIS_CBLPAX_080519_FINAL.xlsx",
                  skip = 23)
df2<-df2 %>% 
  mutate(depth=substr(`Sample ID`, start = 1, stop = 2),
         station=substr(`Sample ID`, start = 4, stop = 7)) %>% 
  mutate(Comments=as.character(Comments))

#September 25/26 2018
df3 <- read_excel("H:/0_HarrisLab/1_CURRENT PROJECT FOLDERS/CBL PAX River/0_raw_data/HARRIS_PAXCRUISE_100118.xlsx",
                  skip = 23)
df3<-df3 %>% 
  mutate(depth=substr(`Sample ID`, start = 5, stop = 6),
         station=paste0("PAX",substr(`Sample ID`, start = 8, stop = 8)))%>% 
  mutate(Comments=as.character(Comments))

#August 1 2018
df4 <-read_excel("H:/0_HarrisLab/1_CURRENT PROJECT FOLDERS/CBL PAX River/0_raw_data/CBLPAX_080118.xlsx",
                 skip = 23)
df4<-df4 %>% 
  mutate(depth=substr(`Sample ID`, start = 3, stop = 4),
         station=substr(`Sample ID`, start = 6, stop = 9))

#April 2018
df5<-read_excel("H:/0_HarrisLab/1_CURRENT PROJECT FOLDERS/CBL PAX River/0_raw_data/HARRIS_CBLPAX_042518.xlsx",
                skip = 23)
df5<-df5 %>% 
  mutate(depth=substr(`Sample ID`, start = 1, stop = 2),
         station=paste0("PAX",substr(`Sample ID`, start = 8, stop = 8)))

#####Join data#####
df<- bind_rows(df1, df2) %>% 
  bind_rows(., df3) %>% 
  bind_rows(., df4) %>% 
  bind_rows(., df5)

#####After Join Wrangling#####
df<-df %>% 
  drop_na(Result)

df<-mg_umol(df)

