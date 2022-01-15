rm(list = ls())
library("lubridate")
dataphstoma<-read.csv(file="/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/2016ENSO_Panama_DiurnalGasEx_20170411000529/2016ENSO_Panama_DiurnalGasEx_modified.csv",header=TRUE,sep=",")
ph<-dataphstoma$Photo
stom<-dataphstoma$Cond
location<-dataphstoma$Location
date<-dataphstoma$YYYYMMDD
hoursec<-dataphstoma$HHMMSS
time<-dataphstoma$TimePoint
tair<-dataphstoma$Tair
par<-dataphstoma$PARi
vpda<-dataphstoma$VpdA
rh<-dataphstoma$RH_S
co2<-dataphstoma$CO2S
g1<-(stom*co2/(1.6*ph)-1)*sqrt(vpda)


phslz<-ph[location=='PA-SLZ']
stomslz<-stom[location=='PA-SLZ']
dateslz<-date[location=='PA-SLZ']
timeslz<-time[location=='PA-SLZ']
tairslz<-tair[location=='PA-SLZ']
parslz<-par[location=='PA-SLZ']
vpdaslz<-vpda[location=='PA-SLZ']
rhslz<-rh[location=='PA-SLZ']
co2slz<-co2[location=='PA-SLZ']
g1slz<-g1[location=='PA-SLZ']
#####Feb
phslzfeb<-phslz[dateslz=='20160217']
stomslzfeb<-stomslz[dateslz=='20160217']
timeslzfeb<-timeslz[dateslz=='20160217']
tairslzfeb<-tairslz[dateslz=='20160217']
parslzfeb<-parslz[dateslz=='20160217']
vpdaslzfeb<-vpdaslz[dateslz=='20160217']
rhslzfeb<-rhslz[dateslz=='20160217']
co2slzfeb<-co2slz[dateslz=='20160217']
g1slzfeb<-g1slz[dateslz=='20160217']

timelength<-length(unique(timeslzfeb))
phslzfebhourmean<-c(rep(NA,timelength))
phslzfebhourstd<-c(rep(NA,timelength))
phslzfebhourse<-c(rep(NA,timelength))
stomslzfebhourmean<-c(rep(NA,timelength))
stomslzfebhourstd<-c(rep(NA,timelength))
stomslzfebhourse<-c(rep(NA,timelength))
phslzfebhourci<-c(rep(NA,timelength))
stomslzfebhourci<-c(rep(NA,timelength))
tairslzfebtp<-c(rep(NA,timelength))
tairslzfebtpsd<-c(rep(NA,timelength))
tairslzfebtpcv<-c(rep(NA,timelength))
parslzfebtp<-c(rep(NA,timelength))
vpdaslzfebtp<-c(rep(NA,timelength))
rhslzfebtp<-c(rep(NA,timelength))
co2slzfebtp<-c(rep(NA,timelength))
g1slzfebtp<-c(rep(NA,timelength))

 for (i in unique(timeslzfeb)){         #iterate along time points
   phslzfebhourmean[i]<-mean(phslzfeb[timeslzfeb==i])
   phslzfebhourstd[i]<-sd(phslzfeb[timeslzfeb==i])
   phslzfebhourse[i]<-phslzfebhourstd[i]/sqrt(length(timeslzfeb[timeslzfeb==i]))
   ciMult<-qt(c(.025, .975), df=length(timeslzfeb[timeslzfeb==i])-1)
   phslzfebhourci[i]<-phslzfebhourse[i]*ciMult[2]
   stomslzfebhourmean[i]<-mean(stomslzfeb[timeslzfeb==i])
   stomslzfebhourstd[i]<-sd(stomslzfeb[timeslzfeb==i])
   stomslzfebhourse[i]<-stomslzfebhourstd[i]/sqrt(length(timeslzfeb[timeslzfeb==i]))
   stomslzfebhourci[i]<-stomslzfebhourse[i]*ciMult[2]
   tairslzfebtp[i]<-mean(tairslzfeb[timeslzfeb==i]) #will averging Tair cause problems?
   tairslzfebtpsd[i]<-sd(tairslzfeb[timeslzfeb==i])
   tairslzfebtpcv[i]<-tairslzfebtpsd[i]/tairslzfebtp[i]
   parslzfebtp[i]<-mean(parslzfeb[timeslzfeb==i])
   vpdaslzfebtp[i]<-mean(vpdaslzfeb[timeslzfeb==i])
   rhslzfebtp[i]<-mean(rhslzfeb[timeslzfeb==i])
   co2slzfebtp[i]<-mean(co2slzfeb[timeslzfeb==i])
   g1slzfebtp[i]<-mean(g1slzfeb[timeslzfeb==i])
 }
hourslzfeb<-as.POSIXct(c("2016-02-17 8:00","2016-02-17 10:00","2016-02-17 12:00","2016-02-17 15:00","2016-02-17 17:00","2016-02-17 18:00"))
#hourslzfeb<-c(8,10,12,15,17,18)
save(hourslzfeb,phslzfebhourmean,phslzfebhourci,stomslzfebhourmean,stomslzfebhourci,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_Feb.RData')

save(hourslzfeb,tairslzfebtp,parslzfebtp,vpdaslzfebtp,rhslzfebtp,co2slzfebtp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_Feb.RData')

save(hourslzfeb,g1slzfebtp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_Feb.RData')
##########March

phslzmar<-phslz[dateslz=='20160310']
stomslzmar<-stomslz[dateslz=='20160310']
timeslzmar<-timeslz[dateslz=='20160310']
tairslzmar<-tairslz[dateslz=='20160310']
parslzmar<-parslz[dateslz=='20160310']
vpdaslzmar<-vpdaslz[dateslz=='20160310']
rhslzmar<-rhslz[dateslz=='20160310']
co2slzmar<-co2slz[dateslz=='20160310']
g1slzmar<-g1slz[dateslz=='20160310']

timelength<-length(unique(timeslzmar))
phslzmarhourmean<-c(rep(NA,timelength))
phslzmarhourstd<-c(rep(NA,timelength))
phslzmarhourse<-c(rep(NA,timelength))
stomslzmarhourmean<-c(rep(NA,timelength))
stomslzmarhourstd<-c(rep(NA,timelength))
stomslzmarhourse<-c(rep(NA,timelength))
phslzmarhourci<-c(rep(NA,timelength))
stomslzmarhourci<-c(rep(NA,timelength))
tairslzmartp<-c(rep(NA,timelength))
parslzmartp<-c(rep(NA,timelength))
vpdaslzmartp<-c(rep(NA,timelength))
rhslzmartp<-c(rep(NA,timelength))
co2slzmartp<-c(rep(NA,timelength))
g1slzmartp<-c(rep(NA,timelength))

for (i in unique(timeslzmar)){         #iterate along time points
  phslzmarhourmean[i]<-mean(phslzmar[timeslzmar==i])
  phslzmarhourstd[i]<-sd(phslzmar[timeslzmar==i])
  phslzmarhourse[i]<-phslzmarhourstd[i]/sqrt(length(timeslzmar[timeslzmar==i]))
  ciMult<-qt(c(.025, .975), df=length(timeslzmar[timeslzmar==i])-1)
  phslzmarhourci[i]<-phslzmarhourse[i]*ciMult[2]
  stomslzmarhourmean[i]<-mean(stomslzmar[timeslzmar==i])
  stomslzmarhourstd[i]<-sd(stomslzmar[timeslzmar==i])
  stomslzmarhourse[i]<-stomslzmarhourstd[i]/sqrt(length(timeslzmar[timeslzmar==i]))
  stomslzmarhourci[i]<-stomslzmarhourse[i]*ciMult[2]
  tairslzmartp[i]<-mean(tairslzmar[timeslzmar==i])
  parslzmartp[i]<-mean(parslzmar[timeslzmar==i])
  vpdaslzmartp[i]<-mean(vpdaslzmar[timeslzmar==i])
  rhslzmartp[i]<-mean(rhslzmar[timeslzmar==i])
  co2slzmartp[i]<-mean(co2slzmar[timeslzmar==i])
  g1slzmartp[i]<-mean(g1slzmar[timeslzmar==i])
}

#hourslzmar<-c(8,10,13,15,17,18)
hourslzmar<-as.POSIXct(c("2016-03-10 8:00","2016-03-10 10:00","2016-03-10 13:00","2016-03-10 15:00","2016-03-10 17:00","2016-03-10 18:00"))
save(hourslzmar,phslzmarhourmean,phslzmarhourci,stomslzmarhourmean,stomslzmarhourci,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_mar.RData')

save(hourslzmar,tairslzmartp,parslzmartp,vpdaslzmartp,rhslzmartp,co2slzmartp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_Mar.RData')

save(hourslzmar,g1slzmartp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_Mar.RData')
#############Apr

phslzapr<-phslz[dateslz=='20160421']
stomslzapr<-stomslz[dateslz=='20160421']
timeslzapr<-timeslz[dateslz=='20160421']
tairslzapr<-tairslz[dateslz=='20160421']
parslzapr<-parslz[dateslz=='20160421']
vpdaslzapr<-vpdaslz[dateslz=='20160421']
rhslzapr<-rhslz[dateslz=='20160421']
co2slzapr<-co2slz[dateslz=='20160421']
g1slzapr<-g1slz[dateslz=='20160421']

timelength<-length(unique(timeslzapr))
phslzaprhourmean<-c(rep(NA,timelength))
phslzaprhourstd<-c(rep(NA,timelength))
phslzaprhourse<-c(rep(NA,timelength))
stomslzaprhourmean<-c(rep(NA,timelength))
stomslzaprhourstd<-c(rep(NA,timelength))
stomslzaprhourse<-c(rep(NA,timelength))
phslzaprhourci<-c(rep(NA,timelength))
stomslzaprhourci<-c(rep(NA,timelength))
tairslzaprtp<-c(rep(NA,timelength))
parslzaprtp<-c(rep(NA,timelength))
vpdaslzaprtp<-c(rep(NA,timelength))
rhslzaprtp<-c(rep(NA,timelength))
co2slzaprtp<-c(rep(NA,timelength))
g1slzaprtp<-c(rep(NA,timelength))

for (i in unique(timeslzapr)){
  phslzaprhourmean[i]<-mean(phslzapr[timeslzapr==i])
  phslzaprhourstd[i]<-sd(phslzapr[timeslzapr==i])
  phslzaprhourse[i]<-phslzaprhourstd[i]/sqrt(length(timeslzapr[timeslzapr==i]))
  ciMult<-qt(c(.025, .975), df=length(timeslzapr[timeslzapr==i])-1)
  phslzaprhourci[i]<-phslzaprhourse[i]*ciMult[2]
  stomslzaprhourmean[i]<-mean(stomslzapr[timeslzapr==i])
  stomslzaprhourstd[i]<-sd(stomslzapr[timeslzapr==i])
  stomslzaprhourse[i]<-stomslzaprhourstd[i]/sqrt(length(timeslzapr[timeslzapr==i]))
  stomslzaprhourci[i]<-stomslzaprhourse[i]*ciMult[2]
  tairslzaprtp[i]<-mean(tairslzapr[timeslzapr==i])
  parslzaprtp[i]<-mean(parslzapr[timeslzapr==i])
  vpdaslzaprtp[i]<-mean(vpdaslzapr[timeslzapr==i])
  rhslzaprtp[i]<-mean(rhslzapr[timeslzapr==i])
  co2slzaprtp[i]<-mean(co2slzapr[timeslzapr==i])
  g1slzaprtp[i]<-mean(g1slzapr[timeslzapr==i])
}
#hourslzapr<-c(7,8,10,12,13,14,16,17)
hourslzapr<-as.POSIXct(c("2016-04-21 8:00","2016-04-21 9:00","2016-04-21 11:00","2016-04-21 13:00","2016-04-21 14:00","2016-04-21 15:00","2016-04-21 17:00","2016-04-21 18:00"))
save(hourslzapr,phslzaprhourmean,phslzaprhourci,stomslzaprhourmean,stomslzaprhourci,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_apr.RData')

save(hourslzapr,tairslzaprtp,parslzaprtp,vpdaslzaprtp,rhslzaprtp,co2slzaprtp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_Apr.RData')

save(hourslzapr,g1slzaprtp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_Apr.RData')

##May

phslzmay<-phslz[dateslz=='20160524']
stomslzmay<-stomslz[dateslz=='20160524']
timeslzmay<-timeslz[dateslz=='20160524']
tairslzmay<-tairslz[dateslz=='20160524']
parslzmay<-parslz[dateslz=='20160524']
vpdaslzmay<-vpdaslz[dateslz=='20160524']
rhslzmay<-rhslz[dateslz=='20160524']
co2slzmay<-co2slz[dateslz=='20160524']
g1slzmay<-g1slz[dateslz=='20160524']

timelength<-length(unique(timeslzmay))
phslzmayhourmean<-c(rep(NA,timelength))
phslzmayhourstd<-c(rep(NA,timelength))
phslzmayhourse<-c(rep(NA,timelength))
stomslzmayhourmean<-c(rep(NA,timelength))
stomslzmayhourstd<-c(rep(NA,timelength))
stomslzmayhourse<-c(rep(NA,timelength))
stomslzmayhourci<-c(rep(NA,timelength))
phslzmayhourci<-c(rep(NA,timelength))
tairslzmaytp<-c(rep(NA,timelength))
parslzmaytp<-c(rep(NA,timelength))
vpdaslzmaytp<-c(rep(NA,timelength))
rhslzmaytp<-c(rep(NA,timelength))
co2slzmaytp<-c(rep(NA,timelength))
g1slzmaytp<-c(rep(NA,timelength))

for (i in unique(timeslzmay)){
  phslzmayhourmean[i]<-mean(phslzmay[timeslzmay==i])
  phslzmayhourstd[i]<-sd(phslzmay[timeslzmay==i])
  phslzmayhourse[i]<-phslzmayhourstd[i]/sqrt(length(timeslzmay[timeslzmay==i]))
  ciMult<-qt(c(.025, .975), df=length(timeslzmay[timeslzmay==i])-1)
  phslzmayhourci[i]<-phslzmayhourse[i]*ciMult[2]
  stomslzmayhourmean[i]<-mean(stomslzmay[timeslzmay==i])
  stomslzmayhourstd[i]<-sd(stomslzmay[timeslzmay==i])
  stomslzmayhourse[i]<-stomslzmayhourstd[i]/sqrt(length(timeslzmay[timeslzmay==i]))
  stomslzmayhourci[i]<-stomslzmayhourse[i]*ciMult[2]
  tairslzmaytp[i]<-mean(tairslzmay[timeslzmay==i])
  parslzmaytp[i]<-mean(parslzmay[timeslzmay==i])
  vpdaslzmaytp[i]<-mean(vpdaslzmay[timeslzmay==i])
  rhslzmaytp[i]<-mean(rhslzmay[timeslzmay==i])
  co2slzmaytp[i]<-mean(co2slzmay[timeslzmay==i])
  g1slzmaytp[i]<-mean(g1slzmay[timeslzmay==i])
}
#hourslzmay<-c(7,9,11,14,16)
hourslzmay<-as.POSIXct(c("2016-05-24 8:00","2016-05-24 10:00","2016-05-24 12:00","2016-05-24 15:00","2016-05-24 17:00"))
save(hourslzmay,phslzmayhourmean,phslzmayhourci,stomslzmayhourmean,stomslzmayhourci,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_may.RData')

save(hourslzmay,tairslzmaytp,parslzmaytp,vpdaslzmaytp,rhslzmaytp, co2slzmaytp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_May.RData')

save(hourslzmay,g1slzmaytp,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_May.RData')