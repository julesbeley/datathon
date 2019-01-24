##Lib----

library(tidyverse)
library(readxl)



##Loading and Cleaning Data-----

edu2 <-read_delim("./data/educ-dept.csv", delim = ";", locale = locale(encoding = "utf-8"))
edu2<- edu2[-c(1:2),]
names(edu2) <- c("code", "Depname", "Pop", "Den","Ratio", "Kinder" , "Elementry", "College", "High")
edu2$Pop <- as.numeric(as.character(edu2$Pop))
edu2$Den <- as.numeric(as.character(edu2$Den))
edu2$Ratio <- as.numeric(as.character(edu2$Ratio))
edu2$Kinder <- as.numeric(as.character(edu2$Kinder))
edu2$Elementry <- as.numeric(as.character(edu2$Elementry))
edu2$College <- as.numeric(as.character(edu2$College))
edu2$High <- as.numeric(as.character(edu2$High))


TCRD_052 <- read_excel("data/TCRD_052.xls")
##Categorizing data-----
edu3 <- edu2 %>% 
  mutate(Catg =
           (if_else((Den < 50), 1, 
                    if_else((Den >= 50 & Den < 75),2,
                            if_else((Den >= 75 & Den < 100),3,
                                    if_else((Den >= 100 & Den < 200),4,
                                            if_else((Den >= 200 & Den < 500),5,
                                                    if_else((Den >= 500 & Den < 1000),6,7))))))))
edu4 <- edu3[-c(101),]

##Graphing schools per individuals-----

edu4%>% group_by(Catg) %>% 
  summarise(meanKinder=mean(Kinder*1000/Pop)) %>% 
  ggplot(aes(x= Catg, y = meanKinder, fill = meanKinder)) +
  geom_col()+ expand_limits(x = 7) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_text())+
  ggtitle("Kindergardens per 1000 individulas per category") + xlab("Category of Urbanization") + ylab("Ratio") + guides(fill=FALSE)

edu4%>% group_by(Catg) %>% 
  summarise(meanElementry=mean(Elementry*1000/Pop)) %>% 
  ggplot(aes(x= Catg, y = meanElementry, fill = meanElementry)) +
  geom_col()+ expand_limits(x = 7) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_text())+
  ggtitle("Elementry schools per 1000 individulas per category") + xlab("Category of Urbanization") + ylab("Ratio") + guides(fill=FALSE)

edu4%>% group_by(Catg) %>% 
  summarise(meanCollege=mean(College*1000/Pop)) %>% 
  ggplot(aes(x= Catg, y = meanCollege, fill = meanCollege)) +
  geom_col()+ expand_limits(x = 7) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_text())+
  ggtitle("Colleges per 1000 individulas per category") + xlab("Category of Urbanization") + ylab("Ratio") + guides(fill=FALSE)

edu4%>% group_by(Catg) %>% 
  summarise(meanHigh=mean(High*1000/Pop)) %>% 
  ggplot(aes(x= Catg, y = meanHigh, fill = meanHigh)) +
  geom_col()+ expand_limits(x = 7) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_text())+
  ggtitle("High schools per 1000 individulas per category") + xlab("Category of Urbanization") + ylab("Ratio") + guides(fill=FALSE)


##Merging two Datasets-----
Merged <- merge(edu4,TCRD_052,by="code")

##Graphing Public servants density in Categories
Merged%>% group_by(Catg) %>% 
  summarise(meanTPF100P=mean(TPubFoncper100P)) %>% 
  ggplot(aes(x= Catg, y = meanTPF100P, fill = meanTPF100P)) +
  geom_col()+ expand_limits(x = 7) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_text())+
  ggtitle("Public Servants per 100 individuals per category") + xlab("Category of Urbanization") + ylab("Ratio") + guides(fill=FALSE)

