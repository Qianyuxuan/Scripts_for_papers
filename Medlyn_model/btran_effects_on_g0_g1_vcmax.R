rm(list = ls())
library(ncdf4)
library(lubridate)
library(RColorBrewer)
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_Feb.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_mar.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_apr.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_may.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_Feb.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_Mar.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_Apr.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/g1_SLZ_May.RData')

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/btran/CLM5-FATES_1606257563_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #medlyn,g1=2.17, default
mcdate<-ncvar_get(ncidslz,'mcdate')
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
btran<-ncvar_get(ncidslz,'BTRAN')
nc_close( ncidslz)
ph_med_default<-ph[1,]/crownarea[1,]/12*10^6
stoma_med_default<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/btran/CLM5-FATES_1606261372_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #medlyn,g1=2.17, ex1
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_med_ex1<-ph[1,]/crownarea[1,]/12*10^6
stoma_med_ex1<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/btran/CLM5-FATES_1606275898_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #medlyn,g1=2.17, ex2
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_med_ex2<-ph[1,]/crownarea[1,]/12*10^6
stoma_med_ex2<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/btran/CLM5-FATES_1606276825_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #medlyn,g1=2.17, ex3
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_med_ex3<-ph[1,]/crownarea[1,]/12*10^6
stoma_med_ex3<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/btran/CLM5-FATES_1606280338_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #medlyn,g1=2.17, ex4
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_med_ex4<-ph[1,]/crownarea[1,]/12*10^6
stoma_med_ex4<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/btran/CLM5-FATES_1606259533_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #BB,g1=6.64, default
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
mcdate<-ncvar_get(ncidslz,'mcdate')
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_bb_default<-ph[1,]/crownarea[1,]/12*10^6
stoma_bb_default<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/btran/CLM5-FATES_1606260554_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #BB,g1=6.64, ex1
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_bb_ex1<-ph[1,]/crownarea[1,]/12*10^6
stoma_bb_ex1<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/btran/CLM5-FATES_1606273862_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #BB,g1=6.64, ex2
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_bb_ex2<-ph[1,]/crownarea[1,]/12*10^6
stoma_bb_ex2<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/btran/CLM5-FATES_1606279364_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #BB,g1=6.64, ex3
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_bb_ex3<-ph[1,]/crownarea[1,]/12*10^6
stoma_bb_ex3<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/btran/CLM5-FATES_1606280028_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #BB,g1=6.64, ex4
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_bb_ex4<-ph[1,]/crownarea[1,]/12*10^6
stoma_bb_ex4<-stomatal_cond[1,]/crownarea[1,]/10^6

ph_medapr_default<-ph_med_default[(mcdate>20160419)&(mcdate<=20160424)]
ph_medapr_ex1<-ph_med_ex1[(mcdate>20160419)&(mcdate<=20160424)]
ph_medapr_ex2<-ph_med_ex2[(mcdate>20160419)&(mcdate<=20160424)]
ph_medapr_ex3<-ph_med_ex3[(mcdate>20160419)&(mcdate<=20160424)]
ph_medapr_ex4<-ph_med_ex4[(mcdate>20160419)&(mcdate<=20160424)]
stoma_medapr_default<-stoma_med_default[(mcdate>20160419)&(mcdate<=20160424)]
stoma_medapr_ex1<-stoma_med_ex1[(mcdate>20160419)&(mcdate<=20160424)]
stoma_medapr_ex2<-stoma_med_ex2[(mcdate>20160419)&(mcdate<=20160424)]
stoma_medapr_ex3<-stoma_med_ex3[(mcdate>20160419)&(mcdate<=20160424)]
stoma_medapr_ex4<-stoma_med_ex4[(mcdate>20160419)&(mcdate<=20160424)]

ph_bbapr_default<-ph_bb_default[(mcdate>20160419)&(mcdate<=20160424)]
ph_bbapr_ex1<-ph_bb_ex1[(mcdate>20160419)&(mcdate<=20160424)]
ph_bbapr_ex2<-ph_bb_ex2[(mcdate>20160419)&(mcdate<=20160424)]
ph_bbapr_ex3<-ph_bb_ex3[(mcdate>20160419)&(mcdate<=20160424)]
ph_bbapr_ex4<-ph_bb_ex4[(mcdate>20160419)&(mcdate<=20160424)]
stoma_bbapr_default<-stoma_bb_default[(mcdate>20160419)&(mcdate<=20160424)]
stoma_bbapr_ex1<-stoma_bb_ex1[(mcdate>20160419)&(mcdate<=20160424)]
stoma_bbapr_ex2<-stoma_bb_ex2[(mcdate>20160419)&(mcdate<=20160424)]
stoma_bbapr_ex3<-stoma_bb_ex3[(mcdate>20160419)&(mcdate<=20160424)]
stoma_bbapr_ex4<-stoma_bb_ex4[(mcdate>20160419)&(mcdate<=20160424)]


dateyear<-ymd("2016-01-01") + c(0:8760) * hours(1)#UTC
dateapr<-dateyear[dateyear>=force_tz(as.POSIXct("2016-04-20",format="%Y-%m-%d"),tzone="UTC") & dateyear<=force_tz(as.POSIXct("2016-04-24",format="%Y-%m-%d"),tzone="UTC")]
dateaprest<-with_tz(dateapr,tzone="EST")
hourslzaprest<-force_tz(hourslzapr,tzone="EST")

nf <- layout( matrix(c(1,2,3,4), nrow=4))
par(mar=c(0, 5, 2, 2))
plot(dateaprest[1:82],ph_medapr_default[1:82],cex=1.5,axes=FALSE, col="#56B4E9",xlab="",ylab="",ylim=c(-1,24),xlim=c(dateaprest[1],dateaprest[82]),xaxs="i", yaxs="i",type="l",lwd=2,main="April 2016")
lines(dateaprest[1:82],ph_medapr_ex1[1:82],cex=1.5,lwd=2,col="#E69F00")
lines(dateaprest[1:82],ph_medapr_ex2[1:82],lty="dashed",cex=1.5,lwd=2,col="#CC79A7")
lines(dateaprest[1:82],ph_medapr_ex3[1:82],lty="dashed",cex=1.5,lwd=2,col="#661100")
lines(dateaprest[1:82],ph_medapr_ex4[1:82],lty="dashed",cex=1.5,lwd=2,col="#009E73")
arrows(hourslzaprest, phslzaprhourmean-phslzaprhourci, hourslzaprest, phslzaprhourmean+phslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,phslzaprhourmean,pch=21,col="black",bg="gray")
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),labels = FALSE,format="%m/%d",cex.axis=1.2)
arrows(hourslzaprest, phslzaprhourmean-phslzaprhourci, hourslzaprest, phslzaprhourmean+phslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,phslzaprhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,25,by=10), cex.axis=1.2)
legend(as.POSIXct("2016-04-22 14:30:00",format="%Y-%m-%d %H:%M:%S"), 25, legend=c("Default", "Exp 1","Exp 2","Exp 3","Exp 4","Observations"),col=c("#56B4E9", "#E69F00","#CC79A7","#661100","#009E73","black"),pch=c(NA,NA,NA,NA,NA,21),lty=c(1,1,2,2,2,1),lwd=c(2,2,2,2,2),pt.bg=c(NA,NA,NA,NA,NA,"gray"),cex=1,bty="n")
text(as.POSIXct("2016-04-20 8:30:00",format="%Y-%m-%d %H:%M:%S"),20,cex=1.5,"MED model")
text(as.POSIXct("2016-04-19 21:30:00",format="%Y-%m-%d %H:%M:%S"),20,cex=1.5,"a",font=2)
mtext(expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,cex=1,line=2.5)
box()

par(mar=c(0, 5, 0, 2))
plot(dateaprest[1:82],stoma_medapr_default[1:82],cex=1.5,axes=FALSE, col="#56B4E9",xlab="",ylab="",ylim=c(-0.005,0.35),xlim=c(dateaprest[1],dateaprest[82]),xaxs="i", lwd=2,yaxs="i",type="l",main="")
lines(dateaprest[1:82],stoma_medapr_ex1[1:82],cex=1.5,lwd=2,col="#E69F00")
lines(dateaprest[1:82],stoma_medapr_ex2[1:82],lty="dashed",cex=1.5,lwd=2,col="#CC79A7")
lines(dateaprest[1:82],stoma_medapr_ex3[1:82],lty="dashed",cex=1.5,lwd=2,col="#661100")
lines(dateaprest[1:82],stoma_medapr_ex4[1:82],lty="dashed",cex=1.5,lwd=2,col="#009E73")
arrows(hourslzaprest, stomslzaprhourmean-stomslzaprhourci, hourslzaprest, stomslzaprhourmean+stomslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,stomslzaprhourmean,pch=21,col="black",bg="gray")
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),labels = FALSE,format="%m/%d",cex.axis=1.2)
arrows(hourslzaprest, phslzaprhourmean-phslzaprhourci, hourslzaprest, phslzaprhourmean+phslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,phslzaprhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,0.35,by=0.2), cex.axis=1.2)
text(as.POSIXct("2016-04-20 8:30:00",format="%Y-%m-%d %H:%M:%S"),0.3,cex=1.5,"MED model")
text(as.POSIXct("2016-04-19 21:30:00",format="%Y-%m-%d %H:%M:%S"),0.3,cex=1.5,"b",font=2)
mtext(expression(paste("g"[sw], " (mol ", m^-2," ",s^-1,")")),side=2,cex=1,line=2.5)
box()

par(mar=c(0, 5, 0, 2))
plot(dateaprest[1:82],ph_bbapr_default[1:82],cex=1.5,axes=FALSE, col="#56B4E9",xlab="",ylab="",ylim=c(-1,24),xlim=c(dateaprest[1],dateaprest[82]),xaxs="i", yaxs="i",type="l",lwd=2,main=" ")
lines(dateaprest[1:82],ph_bbapr_ex1[1:82],cex=1.5,lwd=2,col="#E69F00")
lines(dateaprest[1:82],ph_bbapr_ex2[1:82],cex=1.5,lty="dashed",lwd=2,col="#CC79A7")
lines(dateaprest[1:82],ph_bbapr_ex3[1:82],cex=1.5,lty="dashed",lwd=2,col="#661100")
lines(dateaprest[1:82],ph_bbapr_ex4[1:82],cex=1.5,lty="dashed",lwd=2,col="#009E73")
#lines(dateaprest[1:82],ph_bbapr_ex5[1:82],cex=1.5,lwd=2,col="yellow")
arrows(hourslzaprest, phslzaprhourmean-phslzaprhourci, hourslzaprest, phslzaprhourmean+phslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,phslzaprhourmean,pch=21,col="black",bg="gray")
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),labels = FALSE,format="%m/%d",cex.axis=1.2)
arrows(hourslzaprest, phslzaprhourmean-phslzaprhourci, hourslzaprest, phslzaprhourmean+phslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,phslzaprhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,25,by=10), cex.axis=1.2)
text(as.POSIXct("2016-04-20 8:30:00",format="%Y-%m-%d %H:%M:%S"),18,cex=1.5,"BWB model")
text(as.POSIXct("2016-04-19 21:30:00",format="%Y-%m-%d %H:%M:%S"),18,cex=1.5,"c",font=2)
mtext(expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,cex=1,line=2.5)
box()

par(mar=c(4, 5, 0, 2))
plot(dateaprest[1:82],stoma_bbapr_default[1:82],cex=1.5,axes=FALSE, col="#56B4E9",xlab="",ylab="",ylim=c(-0.005,0.35),xlim=c(dateaprest[1],dateaprest[82]),xaxs="i", lwd=2,yaxs="i",type="l",main="")
lines(dateaprest[1:82],stoma_bbapr_ex1[1:82],cex=1.5,lwd=2,col="#E69F00")
lines(dateaprest[1:82],stoma_bbapr_ex2[1:82],cex=1.5,lty="dashed",lwd=2,col="#CC79A7")
lines(dateaprest[1:82],stoma_bbapr_ex3[1:82],cex=1.5,lty="dashed",lwd=2,col="#661100")
lines(dateaprest[1:82],stoma_bbapr_ex4[1:82],cex=1.5,lwd=2,lty="dashed",col="#009E73")
arrows(hourslzaprest, stomslzaprhourmean-stomslzaprhourci, hourslzaprest, stomslzaprhourmean+stomslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,stomslzaprhourmean,pch=21,col="black",bg="gray")
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),format="%m/%d",cex.axis=1.2)
arrows(hourslzaprest, phslzaprhourmean-phslzaprhourci, hourslzaprest, phslzaprhourmean+phslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,phslzaprhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,0.35,by=0.2), cex.axis=1.2)
text(as.POSIXct("2016-04-20 8:30:00",format="%Y-%m-%d %H:%M:%S"),0.25,cex=1.5,"BWB model")
text(as.POSIXct("2016-04-19 21:30:00",format="%Y-%m-%d %H:%M:%S"),0.25,cex=1.5,"d",font=2)
mtext(expression(paste("g"[sw], " (mol ", m^-2," ",s^-1,")")),side=2,cex=1,line=2.5)
mtext("Date",side=1,cex=1,line=2.5)
box()


#plot beta across the four campaigns
datemj<-dateyear[dateyear>=force_tz(as.POSIXct("2016-02-15",format="%Y-%m-%d"),tzone="UTC") & dateyear<force_tz(as.POSIXct("2016-05-31",format="%Y-%m-%d"),tzone="UTC")]
datemjslz<-with_tz(datemj,tzone="EST")


plot(datemjslz,btran[(mcdate>=20160215)&(mcdate<=20160530)],cex=1.5, axes=FALSE, col="blue",xlab="",ylab="", type="l",ylim=c(0.5,1.1),lwd=2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-02-15",format="%Y-%m-%d"), max(datemjslz), by="5 day"),format="%m/%d",cex.axis=1.2)
polygon(c(hourslzfeb,rev(hourslzfeb)),c(0.4,0.4,0.4,0.4,0.4,0.4,1.2,1.2,1.2,1.2,1.2,1.2),col="gray",border="gray")
polygon(c(hourslzmar,rev(hourslzmar)),c(0.4,0.4,0.4,0.4,0.4,0.4,1.2,1.2,1.2,1.2,1.2,1.2),col="gray",border="gray")
polygon(c(hourslzapr,rev(hourslzapr)),c(0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,1.2,1.2,1.2,1.2,1.2,1.2,1.2,1.2),col="gray",border="gray")
polygon(c(hourslzmay,rev(hourslzmay)),c(0.4,0.4,0.4,0.4,0.4,1.2,1.2,1.2,1.2,1.2),col="gray",border="gray")
legend(as.POSIXct("2016-04-22 8:00:00",format="%Y-%m-%d %H:%M:%S"), 0.75, legend=c("Soil water stress \nfactor", "\n2016 campaign \ndates"),col=c("blue", "gray"),lty=c(1,1),pch=c(NA,NA),lwd=c(2,2),cex=0.8,bty="n")
axis(2,at=seq(0,1,by=0.1), cex.axis=1.2)
mtext("Soil water stress factor",side=2,cex=1.5,line=2.5)
mtext("Date",side=1,cex=1.5,line=2.5)
box()


#####esitimate how much model underestimates
inds<-which(dateaprest %in% hourslzaprest)
underrateph_med_ex4<-(ph_medapr_ex4[inds]-phslzaprhourmean)/phslzaprhourmean*100
underrateph_med_def<-(ph_medapr_default[inds]-phslzaprhourmean)/phslzaprhourmean*100
underrategs_med_ex4<-(stoma_medapr_ex4[inds]-stomslzaprhourmean)/stomslzaprhourmean*100
underrategs_med_def<-(stoma_medapr_default[inds]-stomslzaprhourmean)/stomslzaprhourmean*100

underrateph_bb_ex4<-(ph_bbapr_ex4[inds]-phslzaprhourmean)/phslzaprhourmean*100
underrateph_bb_def<-(ph_bbapr_default[inds]-phslzaprhourmean)/phslzaprhourmean*100
underrategs_bb_ex4<-(stoma_bbapr_ex4[inds]-stomslzaprhourmean)/stomslzaprhourmean*100
underrategs_bb_def<-(stoma_bbapr_default[inds]-stomslzaprhourmean)/stomslzaprhourmean*100

