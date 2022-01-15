rm(list = ls())
datavcmax<-read.csv(file="/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/2016_Panama_ACi_20170817190331/2016ENSO_Panama_Fitted_Vcmax_Jmax.csv",header=TRUE,sep=",")
site<-datavcmax$Site
vcmax<-datavcmax$Vcmax
tleaf<-datavcmax$Mean.Tleaf
date<-datavcmax$YYYYMMDD
vcmax_slz_2016<-vcmax[site=='SanLorenzo'] # Vcmax at measuremnet temp
tleaf_slz_2016<-tleaf[site=='SanLorenzo']+273.15 #converting the unit of temp to K
vcmax_slz_apr<-vcmax[date=='20160421'|date=='20160422']
tleafapr<-tleaf[date=='20160421'|date=='20160422']+273.15

f.modified.arrhenius.inv<-function(P,Ha,Hd,s,Tleaf,TRef=298.15,R=8.314){
  PRef=P/(1+exp((s*TRef-Hd)/(R*TRef)))/exp(Ha/(R*TRef)*(1-TRef/Tleaf))*(1+exp((s*Tleaf-Hd)/(R*Tleaf)))
  return(PRef)
}

vcmaxref<-f.modified.arrhenius.inv(P=vcmax_slz_2016,Ha=65330,Hd=149250,s=485,Tleaf=tleaf_slz_2016)
vcmax_aprref<-f.modified.arrhenius.inv(P=vcmax_slz_apr,Ha=65330,Hd=149250,s=485,Tleaf=tleafapr)

hist(vcmaxref)
hist(vcmax_aprref)
mean(vcmaxref)
mean(vcmax_aprref)
sd(vcmaxref)
se<-sd(vcmaxref)/sqrt(length(vcmaxref))
ciMult<-qt(c(.025, .975), df=length(vcmaxref)-1)
ci<-se*ciMult[2]
