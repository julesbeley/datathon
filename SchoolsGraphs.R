library(tidyverse)
install.packages("rio")
library(rio)
edu <- import(.)
library(readr)
read_csv("data/Education.csv")
table(edu)
head(edu)
View(edu)
edu <- edu[-1,]
head(edu)
names(edu)<- c("Libellé","Population légale 2016","Lycée 2017","École maternelle 2017","École élémentaire 2017",
"Collège 2017")
headers<- c("Dep","Pop","Ly","Mat","Ele","Col")
head(edu)
edu %>% setNames(headers) %>% 
group_by(Ly)
##
  names(edu) <- headers
names(edu)
summary(edu)
glimpse(edu)

edu <- edu[,-1]
edu <- edu[-1,]

view(edu)
##sorting

#Subset
##population
edu$Pop <- as.numeric(edu$Pop)
edu <- edu %>% 
  arrange(`Pop`)
view(edu)

##convert to numerical
edu$Ly <- as.numeric(as.character(edu$Ly))
edu$Pop <- as.numeric(as.character(edu$Pop))
edu$Mat <- as.numeric(as.character(edu$Mat))
edu$Ele <- as.numeric(as.character(edu$Ele))
edu$Col <- as.numeric(as.character(edu$Col))
edu %>% 
  arrange(`Pop`) -> edu

## graphing pop
edu %>% setNames(headers) %>%
  ggplot(aes(x= Dep, y = Pop, fill = Pop)) +
  geom_col()

## ratios----
##graphing Lycée
edu %>% setNames(headers) %>%  
ggplot(aes(x= Dep, y = Ly, fill = Ly/Pop)) +
  geom_col()

##graphing College
edu %>% setNames(headers) %>%  
  ggplot(aes(x= Dep, y = Col/Pop, fill = Col/Pop)) +
  geom_col()

##graphing elementary
edu %>% setNames(headers) %>%  
  ggplot(aes(x= Dep, y = Ele/Pop, fill = Ele/Pop)) +
  geom_col()

##graphing maternelle
edu %>% setNames(headers) %>%  
  ggplot(aes(x= Dep, y = Mat/Pop, fill = Mat/Pop)) +
  geom_col()


##population density
x=reorder   ##command on R lookup

edu %>%
  mutate(ratio = Ele/Pop) %>%
  View()


##regions
read_csv("data/RegEdu.csv")
REdu <- REdu[-1,]
head(REdu)
names(REdu)<- c("Libellé","Population légale 2016","Lycée 2017","École maternelle 2017","École élémentaire 2017",
               "Collège 2017")
headers1<- c("Reg","Pop1","Ly1","Mat1","Ele1","Col1")
head(REdu)
REdu %>% setNames(headers1)
names(REdu) <- headers1
REdu <- REdu[,-1]
REdu <- REdu[-1,]

##convert to numerical
REdu$Ly1 <- as.numeric(as.character(REdu$Ly1))
REdu$Pop1 <- as.numeric(as.character(REdu$Pop1))
REdu$Mat1 <- as.numeric(as.character(REdu$Mat1))
REdu$Ele1 <- as.numeric(as.character(REdu$Ele1))
REdu$Col1 <- as.numeric(as.character(REdu$Col1))
REdu %>% 
  arrange(`Pop1`) -> REdu

##graph pop regions
REdu %>% setNames(headers1) %>%
  ggplot(aes(x= reorder(Reg, -Pop1), y = Pop1, fill = Reg)) +
geom_col()+ expand_limits(x = 15) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_blank())+
  ggtitle("Population per region") + xlab("Regions") + ylab("Population") + guides(fill=FALSE) + scale_y_continuous(labels = scales::comma)

REdu<- REdu[-18,]

## ratios----regions
##graphing Lycée
REdu %>% setNames(headers1) %>% 
  ggplot(aes(x= reorder(Reg, -Ly1/Pop1), y = Ly1/Pop1, fill = Reg)) +
  geom_col()+ expand_limits(x = 15) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_blank())+
  ggtitle("Ratio of high-school:population per region") + xlab("Regions") + ylab("Ratio") + guides(fill=FALSE) + scale_y_continuous(labels = scales::comma)

##graphing College
REdu %>% setNames(headers1) %>%  
  ggplot(aes(x= reorder(Reg, -Col1/Pop1), y = Col1/Pop1, fill = Reg)) +
  geom_col()+ expand_limits(x = 15) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_blank())+
  ggtitle("Ratio of middle school:population per region") + xlab("Regions") + ylab("Ratio") + guides(fill=FALSE) + scale_y_continuous(labels = scales::comma)

##graphing elementary
REdu %>% setNames(headers1) %>%  
  ggplot(aes(x= reorder(Reg, -Ele1/Pop1), y = Ele1/Pop1, fill = Reg)) +geom_col() + expand_limits(x = 15) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_blank())+
  ggtitle("Ratio of elementary school:population per region") + xlab("Regions") + ylab("Ratio") + guides(fill=FALSE) + scale_y_continuous(labels = scales::comma) 

##graphing maternelle
REdu %>% setNames(headers1) %>%  
ggplot(aes(x= reorder(Reg, -Mat1/Pop1), y = Mat1/Pop1,fill =Reg)) +
  geom_col() + expand_limits(x = 15) +  theme(axis.text.x=element_text(angle=90,hjust=1)) + theme(axis.text.y=element_blank())+
  ggtitle("Ratio of pre-school:population per region") + xlab("Regions") + ylab("Ratio") + guides(fill=FALSE) + scale_y_continuous(labels = scales::comma)

