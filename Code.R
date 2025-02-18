# import data
# frequecy distribution
library(dplyr)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)
library(car)
library(multcomp)
library(compute.es)
library(pastecs)
library(reshape)
library(WRS2)

#####Import Data#######

library(haven)
library(rio)
library(foreign)
head(import("LLCP2018.XPT", format = "xpt"))
library(SASxport)
lookup.xport("LLCP2018.XPT")
#read_xpt("LLCP2018.XPT")
df<-data.frame(read_xpt("LLCP2018.XPT"))
summary(df)
head(df)
str(df)

#Convert to csv
#write.csv(df,"MyData.csv", row.names = TRUE)

mydata<-read.csv('MyData.csv')

##########################
### data organization ####
##########################

# BMI page 21
new_data<-data.frame(BMI_standard = mydata$X_BMI5)
new_data$BMI_CAT<-mydata$X_BMI5CAT
new_data$BMI_standard<- (new_data$BMI_standard/100)

#States: page 2/156
new_data$State<-mydata$X_STATE

#Gender: Male or Female
# 1== male, 2=female
new_data$Gender<-mydata$SEX1

# Age page 18 in the 35pages file
new_data$Age<-mydata$X_AGEG5YR

# Income section 8 page 23/35
new_data$Income <-mydata$X_INCOMG

#States: page 2/156
new_data$State<-mydata$X_STATE


# Urban vs Rural page 118/156
new_data$urban<- mydata$X_URBSTAT

# smoking section 9 X_SMOKER3 page 24 /35
new_data$Smoking <- mydata$X_SMOKER3

# Heavy drinkers (adult men having more than 14 drinks per week and adult women having more than 7 drinks per week)
# 1-- no
# 2 -- yes
new_data$Heavy_drinker <- mydata$X_RFDRHV6

# diabetes
# page 27/156

new_data$Diabetes <- mydata$DIABETE3
## make new variable and combine 1 and 4

# cancer diagnosis
# other types of cancer page 25/156
new_data$Other_Cancer <- mydata$CHCOCNCR

# Heart attack: page 22/156
new_data$Heart_Attack <- mydata$CVDINFR4

#Pregnancy : page: 37/156
new_data$Pregnant <- mydata$PREGNANT
new_data$Pregnant[which(is.na(new_data$Pregnant))] <- 2

#Deleting rows with missing info and non-essential data
new_data<-new_data[!(new_data$Age=="14"),]
new_data<-new_data[!(new_data$Income=="9"),]
new_data<-new_data[!(new_data$urban=="9"),]
new_data<-new_data[!(new_data$Smoking=="9"),]
new_data<-new_data[!(new_data$Heavy_drinker=="9"),]
new_data<-new_data[!(new_data$Diabetes=="9" |new_data$Diabetes=="7"|new_data$Diabetes=="2"),]
new_data$Diabetes<-replace(new_data$Diabetes,new_data$Diabetes>3,1)
new_data<-new_data[!(new_data$Other_Cancer=="9" | new_data$Other_Cancer=="7"),]
new_data<-new_data[!(new_data$Heart_Attack=="9" | new_data$Heart_Attack=="7"),]
new_data<-new_data[!(new_data$Gender=="9" |new_data$Gender=="7"),]
new_data<-new_data[!(new_data$Pregnant=="1"),]
new_data$Pregnant<-NULL

# Delete rows with missing BMI values
final_data <- filter(new_data, !is.na(BMI_standard))

#########################
### Factorial ANOVA #####
#########################
# factors of interest: gender, age, urban, income

# recode/reweight data and create levels

final_data$Gender<-factor(final_data$Gender, labels = c("male", "female"))
final_data$Age<-factor(final_data$Age, labels = c("18-24", "25-29", "30-34","35-39","40-44","45-49",
                                                  "50-54", "55-59","60-64","65-69","70-74","75-79","80+"))
final_data$urban<-factor(final_data$urban, labels = c("urban","rural"))
final_data$Income<-factor(final_data$Income, labels = c("<$15K","$15K-$25K","$25k-$35K","$35K-$50K",">$50K"))



# assumption test: Homogeneity
# Because we have a large sample size, we are going to use Hartley's Fmax index
# If Levene's test is significant (i.e., the p-value is less than .05) then we can say that the variances are significantly different
leveneTest(final_data$BMI_standard, final_data$Gender, centre=mean)
leveneTest(final_data$BMI_standard, final_data$Age)
leveneTest(final_data$BMI_standard, final_data$urban)
leveneTest(final_data$BMI_standard, final_data$Income)

leveneTest(final_data$BMI_standard, interaction(final_data$Gender, final_data$Age, final_data$Income, final_data$urban))
#Fligner-Killeen’s test: a non-parametric test which is very robust against departures from normality.
## no factor of interest follow homogeneity


# Anova Analysis
anova2<-lm(BMI_standard~Age*Gender*urban*Income, final_data)
final_model<-Anova(anova2, type=3)

aggregate(BMI_standard~Gender, final_data, FUN=mean)


# visualization

library(sciplot)
library(lsr)

bargraph.CI(x.factor=final_data$Gender, response = final_data$BMI_standard,
            ylim = c(28, 29),
            col="aliceblue",
            ci.fun=ciMean, 
            xlab = "Gender", ylab="BMI" )

bargraph.CI(x.factor=final_data$Income, response = final_data$BMI_standard,
            ylim = c(27, 30),
            col="aliceblue",
            ci.fun=ciMean, 
            xlab = "Gender", ylab="BMI" )

bargraph.CI(x.factor=final_data$Gender, response = final_data$BMI_standard, 
            group=final_data$Income,
            col=c("darkslategray1","antiquewhite", "cornsilk1", "aquamarine", "ivory1"),
            ylim = c(27, 31),
            ci.fun=ciMean, xlab = "Gender", ylab="BMI" )



lineplot.CI(x.factor=final_data$Gender, response = final_data$BMI_standard,ci.fun=ciMean, xlab = "Gender", ylab="BMI" )
lineplot.CI(x.factor=final_data$Age, response = final_data$BMI_standard, group=final_data$Gender,ci.fun=ciMean, xlab = "Age", ylab="BMI" )
lineplot.CI(x.factor=final_data$Age, response = final_data$BMI_standard, group=final_data$Gender,ci.fun=ciMean, xlab = "Age", ylab="BMI" )
lineplot.CI(x.factor=final_data$Age, response = final_data$BMI_standard, group=final_data$urban,ci.fun=ciMean, xlab = "Age", ylab="BMI" )
lineplot.CI(x.factor=final_data$Age, response = final_data$BMI_standard, group=final_data$Income,ci.fun=ciMean, xlab = "Age", ylab="BMI" )
lineplot.CI(x.factor=final_data$Gender, response = final_data$BMI_standard, group=final_data$Income,ci.fun=ciMean, xlab = "Gender", ylab="BMI" )



# post hoc

menonly <- filter(final_data, Gender == "male")
pairwise.t.test(menonly$BMI_standard, menonly$Age, p.adjust.method = "bonferroni")
pairwise.t.test(menonly$BMI_standard, menonly$Income, p.adjust.method = "bonferroni")

womenonly <- filter(final_data, Gender == "female")
pairwise.t.test(womenonly$BMI_standard, womenonly$Age, p.adjust.method = "bonferroni")
pairwise.t.test(womenonly$BMI_standard, womenonly$Income, p.adjust.method = "bonferroni")


pairwise.t.test(final_data$BMI_standard, final_data$Gender, p.adjust.method = "bonferroni")
pairwise.t.test(final_data$BMI_standard, final_data$urban, p.adjust.method = "bonferroni")




# power analyis： effect size'

library(lsr)
etaSquared(anova2, type = 3)

# omega 
omega_factorial<-function(n, a, b, SSa, SSb, SSab, SSr)
{
  MSa<-SSa/(a-l)
  MSb<-SSb/(b-l)
  MSab<-SSab/((a-l)*(b-l))
  MSr<-SSr/(a*b*(n-l))
  varA<-((a-l)*(MSa-MSr))/(n*a*b)
  varB<-((b-l)*(MSb-MSr))/(n*a*b)
  varAB<-((a-l)*(b-l)*(MSab-MSr))/(n*a*b)
  varTotal<-varA + varB + varAB + MSr
  prtnt(paste("Omega-Squared A: ", varA/varTotal))
  print(paste("Omega-Squared B: ", varB/varTotal))
  print(paste("Omega-Squared AB: ", varAB/varTotal))
}


# BMI_standard~Age*Gender
by(final_data$BMI_standard, list(final_data$Age, final_data$Gender), stat.desc)
aggregate(BMI_standard~Gender*Age, final_data, FUN=mean)
aggregate(BMI_standard~Gender*Age, final_data, FUN=sd)
aggregate(BMI_standard~Gender*Age, final_data, FUN=length)

mes(29.69, 29.25, 6.131151, 7.474711, 10968, 11653)

# BMI_standard~Age*Income
aggregate(BMI_standard~Gender*Income, final_data, FUN=mean)
aggregate(BMI_standard~Gender*Income, final_data, FUN=sd)
aggregate(BMI_standard~Gender*Income, final_data, FUN=length)   
mes(30.057, 29.189, 8.29, 7.49, 17159, 28662)
mes(29.189,  28.757, 7.49, 7.00, 28662 ,18271)
mes(28.613,  27.435, 6.74, 6.19, 22852 ,77203)
mes(28.409,   28.619, 5.937, 5.808, 14526 ,21083)


# mes(mean.males, mean.females, sdmales, sdfemales, nmales, nfemales)


###### LOGISTIC Regression ########


# Recode binary DV data
final_data$Heart_Attack<-replace(final_data$Heart_Attack,final_data$Heart_Attack==2,0)

final_data$Other_Cancer<-replace(final_data$Other_Cancer,final_data$Other_Cancer==2,0)

final_data$Diabetes<-replace(final_data$Diabetes,final_data$Diabetes==3,0)


# Recode for IV
# never smoked : 4-->0
# former smmoker: 3-->2
# smoker: 1&2 --> 1
final_data$Smoking<-replace(final_data$Smoking,final_data$Smoking==4,0)
final_data$Smoking<-replace(final_data$Smoking,final_data$Smoking==2,1)
final_data$Smoking<-replace(final_data$Smoking,final_data$Smoking==3,2)

final_data$Smoking<-factor(final_data$Smoking, labels = c("non-smoker", "former smoker", "smoker"))
final_data$Heavy_drinker<-replace(final_data$Heavy_drinker,final_data$Heavy_drinker==1,0)
final_data$Heavy_drinker<-replace(final_data$Heavy_drinker,final_data$Heavy_drinker==2,1)
final_data$Heavy_drinker<-factor(final_data$Heavy_drinker, labels = c("non-heaving drinker", "heavy drinker"))


### Analysis
library(mlogit)

#### R^2

logisticPseudoR2s <- function(LogModel) {
  dev <- LogModel$deviance
  nullDev <- LogModel$null.deviance
  modelN <- length(LogModel$fitted.values)
  Rl <- 1 - dev/nullDev
  Rcs <- 1- exp ( -(nullDev - dev) / modelN)
  Rn <- Rcs / ( 1 - ( exp (-(nullDev / modelN))))
  cat("Pseudo R^2 for logistic regression\n")
  cat("Hosmer and Lemeshow R^2 ", round(Rl,3), "\n")
  cat("Cox and Snell R^2       ", round(Rcs, 3), "\n")
  cat("Nagelkerke R^2          ", round(Rn,3), "\n")
}

##LRMs

#For Diabetes
D_model<-glm(Diabetes~Heavy_drinker+Smoking, data=final_data, family= binomial())
summary(D_model)

BMI_D_model<-glm(Diabetes~Heavy_drinker+Smoking+BMI_CAT, data=final_data, family= binomial())
summary(BMI_D_model)
chistat_BMI_D <- D_model$deviance - BMI_D_model$deviance
chistat_BMI_D
chidf <- D_model$df.residual - BMI_D_model$df.residual
chisq.prob_BMI_D <- 1 - pchisq(chistat_BMI_D, chidf)
chisq.prob_BMI_D

logisticPseudoR2s(D_model)
logisticPseudoR2s(BMI_D_model)

anova(D_model,BMI_D_model)

#For Heart Attack
HA_model<-glm(Heart_Attack~Heavy_drinker+Smoking, data=final_data, family= binomial())
summary(HA_model)

BMI_HA_model<-glm(Heart_Attack~Heavy_drinker+Smoking+BMI_CAT, data=final_data, family= binomial())
summary(BMI_HA_model)
chistat_BMI_HA<-HA_model$deviance-BMI_HA_model$deviance
chistat_BMI_HA
chidf <- HA_model$df.residual - HA_model$df.residual
chisq.prob_BMI_HA<- 1 - pchisq(chistat_BMI_HA, chidf)
chisq.prob_BMI_HA

logisticPseudoR2s(HA_model)
logisticPseudoR2s(BMI_HA_model)

anova(HA_model,BMI_HA_model)

#For Cancer
C_model<-glm(Other_Cancer~Heavy_drinker+Smoking, data=final_data, family= binomial())
summary(C_model)

BMI_C_model<-glm(Other_Cancer~Heavy_drinker+Smoking+BMI_CAT, data=final_data, family= binomial())
summary(BMI_C_model)
chistat_BMI_C<-C_model$deviance-BMI_C_model$deviance
chistat_BMI_C
chidf <- C_model$df.residual - BMI_C_model$df.residual
chisq.prob_BMI_C <- 1 - pchisq(chistat_BMI_C, chidf)
chisq.prob_BMI_C

logisticPseudoR2s(C_model)
logisticPseudoR2s(BMI_C_model)

anova(C_model,BMI_C_model)


### Check for normality ####
#Histogram
plot(hist(final_data$BMI_standard,breaks = 50), cex = 1, col = c("yellow"), hang = -1,
     xlab="BMI Values",
     main = "Histogram of BMI Values")
A<-final_data$BMI_standard
plot(ecdf(A))
curve(pnorm(x,mean(A), sd(A)), col="red", add=TRUE)


library(moments)
summary(final_data$BMI_standard)
skewness(final_data$BMI_standard)
table(final_data$BMI_CAT)

nrow(final_data[final_data$BMI_standard>40, ])
Data_40<-final_data
Data_40 <- filter(Data_40, !(Data_40$BMI_standard)>40)
plot(hist(Data_40$BMI_standard), cex = 1, col = c("cyan"),hang = -1,
     xlab="BMI Values",
     main = "Histogramof BMI Values less than 40")
skewness(Data_40$BMI_standard)

hist(final_data$BMI_standard)
skewness(final_data$BMI_standard)
mean(final_data$BMI_standard)
sd(final_data$BMI_standard)


####For Clustering Analysis#####
library(plyr)
count(final_data$State)

R1 <- ddply(final_data, .(State), function(x) mean(x$BMI_standard))
R1

data_cluster<-data.frame(State=count(final_data$State)$x)
data_cluster$No_Respondents<-count(final_data$State)$freq
data_cluster$Mean_BMI<-R1$V1

data_cluster
str(data_cluster)
data_cluster$State<-as.character(data_cluster$State)
str(data_cluster)

data_cluster_new <- data_cluster[-1]
row.names(data_cluster_new) <- data_cluster$State
data_cluster_new

data_cluster_s<-scale(data_cluster_new)
data_cluster_km<-kmeans(data_cluster_s, centers = 4, nstart = 50) 
library(factoextra)
fviz_cluster(data_cluster_km, data_cluster_s, main = "K-means Clustering, with k = 4",
             ggtheme = theme_light())
data_cluster_km$cluster
data_cluster_new$Cluster<-data_cluster_km$cluster
data_cluster_new
data_cluster_new<-data_cluster_new[order(data_cluster_new$Cluster),]
data_cluster_new
R2 <- ddply(data_cluster_new, .(Cluster), function(x) mean(x$Mean_BMI))
R2
R3 <- ddply(data_cluster_new, .(Cluster), function(x) sd(x$Mean_BMI))
R3
R4 <- ddply(data_cluster_new, .(Cluster), function(x) mean(x$No_Respondents))
R4
R5 <- ddply(data_cluster_new, .(Cluster), function(x) sd(x$No_Respondents))
R5

