rm(list = ls())
library(ncdf4)
library(ggplot2)
library(reshape2)
library(lubridate)

#site measurements
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_Feb.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_mar.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_apr.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/ph_stoma_SLZ_may.RData')


load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_Feb.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_Mar.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_Apr.RData')
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/PA_SLZ/tair_par_vpd_SLZ_May.RData')

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/CLM5-FATES_medlyn_g1_1.14.nc')
mcdate<-ncvar_get(ncidslz,'mcdate')
co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6  #change the unit from Pa to ppm
tair<-ncvar_get(ncidslz,"TBOT")
rh<-ncvar_get(ncidslz,"RH")
fsds<-ncvar_get(ncidslz,"FSDS")*2.1 #change units from W/m2 to umol/m2/s
nc_close( ncidslz)

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp0730/btran/CLM5-FATES_1597273476_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #medlyn,g1=2.85, vcmax=63, with btran in g1
#co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6  #change the unit from Pa to ppm
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_med_btran<-ph[1,]/crownarea[1,]/12*10^6
stoma_med_btran<-stomatal_cond[1,]/crownarea[1,]/10^6

ncidslz<- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp0730/btran/CLM5-FATES_1597286690_PA-SLZ_site.clm2.h0.2015-12-30-00000.nc') #ball-berry,g1=8.26,vcmax=63, with btran in g1
#co2<-ncvar_get(ncidslz,'PCO2')/101325*10^6  #change the unit from Pa to ppm
ph<-ncvar_get(ncidslz,'NET_C_UPTAKE_CNLF')
crownarea<-ncvar_get(ncidslz,'CROWNAREA_CNLF')
stomatal_cond<-ncvar_get(ncidslz,'STOMATAL_COND_CNLF')
nc_close( ncidslz)
ph_bb_btran<-ph[1,]/crownarea[1,]/12*10^6
stoma_bb_btran<-stomatal_cond[1,]/crownarea[1,]/10^6


tair<-tair-273.15
a0 =  6.11213476
a1 =  0.444007856
a2 =  0.143064234e-01
a3 =  0.264461437e-03
a4 =  0.305903558e-05
a5 =  0.196237241e-07
a6 =  0.892344772e-10
a7 = -0.373208410e-12
a8 =  0.209339997e-15
es_fates  = (a0 + tair*(a1 + tair*(a2 + tair*(a3 + tair*(a4 + tair*(a5 + tair*(a6 + tair*(a7 + tair*a8))))))))*100/1000 #KPa
#es_licor=0.61365*exp(17.502*tair/(240.97+tair)) # saturated vapor pressure in licor, Kpa
evair<-rh/100*es_fates
vpd<-es_fates-evair


datamedlynph<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/output2/CLM5-FATES_SLZ_ph_ensb.RData')
ph_med<-phen/12*10^6    #change unit from gC/m2/s to umol/m2/s
datamedlynstoma<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/output2/CLM5-FATES_SLZ_stoma_ensb.RData')
stoma_med<-stomaen/10^6   #change unit from umol/m2/s to mol/m2/s
datamedlyngpp<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/output2/CLM5-FATES_SLZ_gpp_ensb.RData')
gpp_med<-gppen
datamedlynet<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sitecomp1123/output2/CLM5-FATES_SLZ_evatransp_ensb.RData')
et_med<-evatranspen

databbph<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/output2/CLM5-FATES_SLZ_ph_ensb.RData')
ph_bb<-phen/12*10^6
databbstoma<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/output2/CLM5-FATES_SLZ_stoma_ensb.RData')
stoma_bb<-stomaen/10^6   #change unit from umol/m2/s to mol/m2/s
databallberrygpp<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/output2/CLM5-FATES_SLZ_gpp_ensb.RData')
gpp_bb<-gppen
databblynet<-load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sitecomp1123/output2/CLM5-FATES_SLZ_evatransp_ensb.RData')
et_bb<-evatranspen
dateyear<-ymd("2016-01-01") + c(0:8760) * hours(1)#UTC

###Feb
tairfeb<-tair[(mcdate>20160215)&(mcdate<20160220)]
rhfeb<-rh[(mcdate>20160215)&(mcdate<20160220)]
fsdsfeb<-fsds[(mcdate>20160215)&(mcdate<20160220)]
vpdfeb<-vpd[(mcdate>20160215)&(mcdate<20160220)]
co2feb<-co2[(mcdate>20160215)&(mcdate<20160220)]

ph_medfeb<-ph_med[(mcdate>20160215)&(mcdate<=20160219),]
ph_medfeb_btran<-ph_med_btran[(mcdate>20160215)&(mcdate<=20160219)]
ph_bbfeb<-ph_bb[(mcdate>20160215)&(mcdate<=20160219),]
ph_bbfeb_btran<-ph_bb_btran[(mcdate>20160215)&(mcdate<=20160219)]

mcdatefeb<-mcdate[(mcdate>20160215)&(mcdate<=20160219)]
stoma_medfeb<-stoma_med[(mcdate>20160215)&(mcdate<=20160219),]
stoma_medfeb_btran<-stoma_med_btran[(mcdate>20160215)&(mcdate<=20160219)]
stoma_bbfeb<-stoma_bb[(mcdate>20160215)&(mcdate<=20160219),]
stoma_bbfeb_btran<-stoma_bb_btran[(mcdate>20160215)&(mcdate<=20160219)]
gpp_medfeb<-gpp_med[(mcdate>20160215)&(mcdate<=20160219),]
gpp_bbfeb<-gpp_bb[(mcdate>20160215)&(mcdate<=20160219),]
et_medfeb<-et_med[(mcdate>20160215)&(mcdate<=20160219),]
et_bbfeb<-et_bb[(mcdate>20160215)&(mcdate<=20160219),]

ph_medfebmean<-rowMeans(ph_medfeb)
ph_bbfebmean<-rowMeans(ph_bbfeb)

ph_medfebmax<-apply(ph_medfeb,1,max)
ph_bbfebmax<-apply(ph_bbfeb,1,max)

ph_medfebmin<-apply(ph_medfeb,1,min)
ph_bbfebmin<-apply(ph_bbfeb,1,min)

stoma_medfebmean<-rowMeans(stoma_medfeb)
stoma_bbfebmean<-rowMeans(stoma_bbfeb)

stoma_medfebmax<-apply(stoma_medfeb,1,max)
stoma_bbfebmax<-apply(stoma_bbfeb,1,max)

stoma_medfebmin<-apply(stoma_medfeb,1,min)
stoma_bbfebmin<-apply(stoma_bbfeb,1,min)

gpp_medfebmean<-rowMeans(gpp_medfeb)
gpp_bbfebmean<-rowMeans(gpp_bbfeb)

gpp_medfebmax<-apply(gpp_medfeb,1,max)
gpp_bbfebmax<-apply(gpp_bbfeb,1,max)

gpp_medfebmin<-apply(gpp_medfeb,1,min)
gpp_bbfebmin<-apply(gpp_bbfeb,1,min)

et_medfebmean<-rowMeans(et_medfeb)
et_bbfebmean<-rowMeans(et_bbfeb)

et_medfebmax<-apply(et_medfeb,1,max)
et_bbfebmax<-apply(et_bbfeb,1,max)

et_medfebmin<-apply(et_medfeb,1,min)
et_bbfebmin<-apply(et_bbfeb,1,min)


#Feb
datefeb<-dateyear[dateyear>=force_tz(as.POSIXct("2016-02-16",format="%Y-%m-%d"),tzone="UTC") & dateyear<force_tz(as.POSIXct("2016-02-20",format="%Y-%m-%d"),tzone="UTC")]
datefebest<-with_tz(datefeb,tzone="EST")
hourslzfebest<-force_tz(hourslzfeb,tzone="EST")

par(mfrow=c(3,1))
#Feb met
par(mar=c(0, 13, 2, 10))
plot(datefebest[1:82],tairfeb[1:82],ylim=c(23,32),axes=FALSE,type="l",main="February 2016",cex.main=1.5,xlab="", ylab="",xaxs="i", yaxs="i")
points(hourslzfebest,tairslzfebtp,pch=16,col="black")
axis(2, ylim=c(20,30),col="black",cex.axis=1.2)
mtext("Tair (\u00B0C)",side=2,line=2.5)
box()
legend(as.POSIXct("2016-02-18 6:00:00",format="%Y-%m-%d %H:%M:%S"), 32, legend=c("FATES forcing", "LICOR forcing"),lty=c(1,0),col=c("black","black"),pch=c(NA,16),lwd=c(2,0),cex=1.2,pt.cex=1.2,bty="n")
text(as.POSIXct("2016-02-15 23:00:00",format="%Y-%m-%d %H:%M:%S"),31,cex=2,"a",font=2)

par(new=TRUE)
plot(datefebest[1:82],fsdsfeb[1:82],ylim=c(-100,2000),col="#ea4335",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzfebest,parslzfebtp,pch=16,col="#ea4335")
mtext(expression(paste("PAR (", mu, "mol ",m^-2," ",s^-1,")")),side=4,col="#ea4335",line=4)
axis(4, ylim=c(0,7000), col="#ea4335",col.axis="#ea4335",las=1,cex.axis=1.2)

par(new=TRUE)
plot(datefebest[1:82],vpdfeb[1:82],ylim=c(-0.05,1.2),col="#4285f3",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzfebest,vpdaslzfebtp,pch=16,col="#4285f3")
mtext("VPD (kPa)",side=2,col="#4285f3",line=7)
axis(2, col="#4285f3",col.axis="#4285f3",line=4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-02-16",format="%Y-%m-%d"), max(datefebest), by="day"),labels = FALSE,format="")

par(new=TRUE)
plot(datefebest[1:82],rhfeb[1:82]/100,ylim=c(-0.05,1.2),col="goldenrod3",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzfebest,rhslzfebtp/100,pch=16,col="goldenrod3")
mtext("RH",side=2,col="goldenrod3",line=11)
axis(2, col="goldenrod3",col.axis="goldenrod3",line=8.4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-02-16",format="%Y-%m-%d"), max(datefebest), by="day"),labels = FALSE,format="")

par(new=TRUE)
plot(datefebest[1:82],co2feb[1:82],ylim=c(200,460),col="#34a853",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzfebest,co2slzfebtp,pch=16,col="#34a853")
axis(4,  col="#34a853",col.axis="#34a853",las=1,cex.axis=1.2,line=5)
mtext(expression(paste("CO"[2], " (ppm)")),side=4,col="#34a853",line=8.5)

#Feb photo
par(mar=c(0, 13, 0, 10)) # B, L, T, R
plot(datefebest[1:82],ph_medfebmean[1:82],cex=0.00001,axes=FALSE, col="white",xlab="Date",ylab="",ylim=c(-1,24),xlim=c(datefebest[1],datefebest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
polygon(c(datefebest[1:82] ,rev(datefebest[1:82])),c(ph_medfebmin[1:82], rev(ph_medfebmax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(datefebest[1],datefebest[82]))
lines(datefebest[1:82],ph_medfebmean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(datefebest[1],datefebest[82]))
lines(datefebest[1:82],ph_bbfebmean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(datefebest[1],datefebest[82]))
polygon(c(datefebest[1:82] ,rev(datefebest[1:82])),c(ph_bbfebmin[1:82], rev(ph_bbfebmax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
arrows(hourslzfebest, phslzfebhourmean-phslzfebhourci, hourslzfebest, phslzfebhourmean+phslzfebhourci, length=0.05, angle=90, code=3)
points(hourslzfebest,phslzfebhourmean,pch=21,col="black",bg="gray")
legend(as.POSIXct("2016-02-18 6:00:00",format="%Y-%m-%d %H:%M:%S"), 23, legend=c("MED", "BWB","MED_mean", "BWB_mean","Observations"),lty=c(0,0,1,1,1),lwd=c(0,0,2,2,2),col=c(rgb(0.2,0.4,1,alpha=0.5), rgb(1,0.4,0,alpha=0.5),rgb(0.2,0.4,1), rgb(1,0.2,0),"black"),pch=c(15,15,NA,NA,21),pt.bg=c(NA,NA,NA,NA,"gray"),cex=1.2,pt.cex=1.2,bty="n")
axis.POSIXct(1, at=seq(as.POSIXct("2016-02-16",format="%Y-%m-%d"), max(datefebest), by="day"),labels = FALSE,format="")
axis(2, cex.axis=1.2)
box()
text(as.POSIXct("2016-02-15 23:00:00",format="%Y-%m-%d %H:%M:%S"),20,cex=2,"b",font=2)

#Feb stoma
par(mar=c(3, 13, 0, 10)) 
plot(datefebest[1:82],stoma_medfebmean[1:82],cex=0.00001, axes=FALSE,col="white",xlab="Date",ylab="",ylim=c(-0.05,0.5),xlim=c(datefebest[1],datefebest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("g"[sw], " (mol ",m^-2," ", s^-1,")")),side=2,line=2.5)
polygon(c(datefebest[1:82] ,rev(datefebest[1:82])),c(stoma_medfebmin[1:82], rev(stoma_medfebmax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(datefebest[1],datefebest[82]))
lines(datefebest[1:82],stoma_medfebmean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(datefebest[1],datefebest[82]))
lines(datefebest[1:82],stoma_bbfebmean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(datefebest[1],datefebest[82]))
polygon(c(datefebest[1:82] ,rev(datefebest[1:82])),c(stoma_bbfebmin[1:82], rev(stoma_bbfebmax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
axis.POSIXct(1, at=seq(as.POSIXct("2016-02-16",format="%Y-%m-%d"), max(datefebest), by="day"),format="%m/%d",cex.axis=1.2)
arrows(hourslzfebest, stomslzfebhourmean-stomslzfebhourci, hourslzfebest, stomslzfebhourmean+stomslzfebhourci, length=0.05, angle=90, code=3)
points(hourslzfebest,stomslzfebhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,0.6,by=0.2), cex.axis=1.2)
mtext("Date",side=1,line=2)
box()
text(as.POSIXct("2016-02-15 23:00:00",format="%Y-%m-%d %H:%M:%S"),0.4,cex=2,"c",font=2)

#plot average comparison
par(mfrow=c(2,1))
par(mar=c(0, 5, 2, 2))
inds<-which(datefebest %in% hourslzfebest)
plot(hourslzfebest,ph_medfebmean[inds]-phslzfebhourmean,cex=0.00001,axes=FALSE, col=rgb(0.2,0.4,1),xlab="Date",ylab="",ylim=c(-6,1),xaxs="i", yaxs="i",type="l",main="Deviation of model results from the observations") #axes=FALSE suppresses both x and y axes. xaxt="n" and yaxt="n" suppress the x and y axis respectively
lines(hourslzfebest,ph_bbfebmean[inds]-phslzfebhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-4,1,by=2), cex.axis=1.2)
axis.POSIXct(1, at=(seq(min(hourslzfebest), max(hourslzfebest), by="2 hours")),format="%H:%M",labels = FALSE,cex.axis=1.2)
legend(as.POSIXct("2016-02-17 14:00:00",format="%Y-%m-%d %H:%M:%S"), -4.5, legend=c("Medlyn", "Ball-Berry"),lty=c(1,1),col=c(rgb(0.2,0.4,1),rgb(1,0.2,0)),cex=1,bty="n")
mtext(expression(paste("A"[net], "( \U003BCmol",m^-2," ",s^-1,")")),side=2,cex=1.2,line=2.5)
box()
text(as.POSIXct("2016-02-17 07:30:00",format="%Y-%m-%d %H:%M:%S"),0.5,cex=2,"d",font=2)

par(mar=c(3, 5, 0, 2)) 
plot(hourslzfebest,stoma_medfebmean[inds]-stomslzfebhourmean,cex=0.00001,axes=FALSE,  col=rgb(0.2,0.4,1),xlab="Date",xaxt = "n",ylab="",ylim=c(-0.3,0.15),xaxs="i", yaxs="i",type="l")
lines(hourslzfebest,stoma_bbfebmean[inds]-stomslzfebhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-0.3,0.15,by=0.1), cex.axis=1.2, labels=formatC(seq(-0.3,0.15,by=0.1),format="f",digits = 1))
axis.POSIXct(1, at=(seq(min(hourslzfebest), max(hourslzfebest), by="2 hours")),format="%H:%M",cex.axis=1.2)
mtext("gs (mol/m\U00B2/s)",side=2,cex=1.2,line=2.5)
mtext("Time in a day",cex=1.2,side=1,line=2)
box()
text(as.POSIXct("2016-02-17 07:30:00",format="%Y-%m-%d %H:%M:%S"),0.09,cex=2,"e",font=2)

#R plot
stoma_medfebmeanmp<-stoma_medfebmean[inds]         #measurement points
stoma_bbfebmeanmp<-stoma_bbfebmean[inds]         #measurement points
ph_medfebmeanmp<-ph_medfebmean[inds]         #measurement points
ph_bbfebmeanmp<-ph_bbfebmean[inds]         #measurement points
plot(stoma_medfebmean[inds],stomslzfebhourmean,pch=16,col="blue")
points(stoma_bbfebmean[inds],stomslzfebhourmean,pch=16,col="red")
abline(lm(stomslzfebhourmean~stoma_medfebmean[inds]), col="black")
abline(lm(stomslzfebhourmean~stoma_bbfebmean[inds]), col="red")

#########March#####
tairmar<-tair[(mcdate>20160308)&(mcdate<=20160313)]
rhmar<-rh[(mcdate>20160308)&(mcdate<=20160313)]
fsdsmar<-fsds[(mcdate>20160308)&(mcdate<=20160313)]
vpdmar<-vpd[(mcdate>20160308)&(mcdate<=20160313)]
co2mar<-co2[(mcdate>20160308)&(mcdate<=20160313)]

ph_medmar<-ph_med[(mcdate>20160308)&(mcdate<=20160313),]
ph_medmar_btran<-ph_med_btran[(mcdate>20160308)&(mcdate<=20160313)]
ph_bbmar<-ph_bb[(mcdate>20160308)&(mcdate<=20160313),]
ph_bbmar_btran<-ph_bb_btran[(mcdate>20160308)&(mcdate<=20160313)]
stoma_medmar<-stoma_med[(mcdate>20160308)&(mcdate<=20160313),]
stoma_medmar_btran<-stoma_med_btran[(mcdate>20160308)&(mcdate<=20160313)]
stoma_bbmar<-stoma_bb[(mcdate>20160308)&(mcdate<=20160313),]
stoma_bbmar_btran<-stoma_bb_btran[(mcdate>20160308)&(mcdate<=20160313)]
gpp_medmar<-gpp_med[(mcdate>20160308)&(mcdate<=20160313),]
gpp_bbmar<-gpp_bb[(mcdate>20160308)&(mcdate<=20160313),]
et_medmar<-et_med[(mcdate>20160308)&(mcdate<=20160313),]
et_bbmar<-et_bb[(mcdate>20160308)&(mcdate<=20160313),]

ph_medmarmean<-rowMeans(ph_medmar)
ph_bbmarmean<-rowMeans(ph_bbmar)

ph_medmarmax<-apply(ph_medmar,1,max)
ph_bbmarmax<-apply(ph_bbmar,1,max)

ph_medmarmin<-apply(ph_medmar,1,min)
ph_bbmarmin<-apply(ph_bbmar,1,min)

stoma_medmarmean<-rowMeans(stoma_medmar)
stoma_bbmarmean<-rowMeans(stoma_bbmar)

stoma_medmarmax<-apply(stoma_medmar,1,max)
stoma_bbmarmax<-apply(stoma_bbmar,1,max)

stoma_medmarmin<-apply(stoma_medmar,1,min)
stoma_bbmarmin<-apply(stoma_bbmar,1,min)

gpp_medmarmean<-rowMeans(gpp_medmar)
gpp_bbmarmean<-rowMeans(gpp_bbmar)

gpp_medmarmax<-apply(gpp_medmar,1,max)
gpp_bbmarmax<-apply(gpp_bbmar,1,max)

gpp_medmarmin<-apply(gpp_medmar,1,min)
gpp_bbmarmin<-apply(gpp_bbmar,1,min)

et_medmarmean<-rowMeans(et_medmar)
et_bbmarmean<-rowMeans(et_bbmar)

et_medmarmax<-apply(et_medmar,1,max)
et_bbmarmax<-apply(et_bbmar,1,max)

et_medmarmin<-apply(et_medmar,1,min)
et_bbmarmin<-apply(et_bbmar,1,min)

datemar<-dateyear[dateyear>=force_tz(as.POSIXct("2016-03-09",format="%Y-%m-%d"),tzone="UTC") & dateyear<=force_tz(as.POSIXct("2016-03-13",format="%Y-%m-%d"),tzone="UTC")]
datemarest<-with_tz(datemar,tzone="EST")
hourslzmarest<-force_tz(hourslzmar,tzone="EST")

#mar met
par(mfrow=c(3,1))
par(mar=c(0, 13, 2, 10))
plot(datemarest[1:82],tairmar[1:82],ylim=c(23,37),axes=FALSE,type="l",main="March 2016",cex.main=1.5,xlab="", ylab="",xaxs="i", yaxs="i")
points(hourslzmarest,tairslzmartp,pch=16,col="black")
axis(2, ylim=c(20,30),col="black",cex.axis=1.2)
mtext("Tair (\u00B0C)",side=2,line=2.5)
box()
legend(as.POSIXct("2016-03-11 05:00:00",format="%Y-%m-%d %H:%M:%S"), 37, legend=c("FATES forcing", "LICOR forcing"),lty=c(1,0),col=c("black","black"),pch=c(NA,16),lwd=c(2,0),cex=1.2,pt.cex=1.2,bty="n")

par(new=TRUE)
plot(datemarest[1:82],fsdsmar[1:82],ylim=c(-100,3000),col="#ea4335",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmarest,parslzmartp,pch=16,col="#ea4335")
mtext(expression(paste("PAR (\U003BCmol ",m^-2," ",s^-1,")")),side=4,col="#ea4335",line=4)
axis(4, ylim=c(0,7000), at=seq(0,2500,by=800),col="#ea4335",col.axis="#ea4335",las=1,cex.axis=1.2)

par(new=TRUE)
plot(datemarest[1:82],vpdmar[1:82],ylim=c(-0.05,1.5),col="#4285f4",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmarest,vpdaslzmartp,pch=16,col="#4285f4")
mtext("VPD (kPa)",side=2,col="#4285f4",line=7)
axis(2, at=seq(0,1.4,by=0.3), col="#4285f4",col.axis="#4285f4",line=4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-03-09",format="%Y-%m-%d"), max(datemarest), by="day"),labels = FALSE,format="")
text(as.POSIXct("2016-03-08 23:00:00",format="%Y-%m-%d %H:%M:%S"),1.3,cex=2,"a",font=2)

par(new=TRUE)
plot(datemarest[1:82],rhmar[1:82]/100,ylim=c(-0.05,1.2),col="goldenrod3",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmarest,rhslzmartp/100,pch=16,col="goldenrod3")
mtext("RH",side=2,col="goldenrod3",line=11)
axis(2, col="goldenrod3",col.axis="goldenrod3",line=8.4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-02-16",format="%Y-%m-%d"), max(datemarest), by="day"),labels = FALSE,format="")

par(new=TRUE)
plot(datemarest[1:82],co2mar[1:82],ylim=c(200,460),col="#34a853",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmarest,co2slzmartp,pch=16,col="#34a853")
axis(4, col="#34a853",col.axis="#34a853",line=5,las=1,cex.axis=1.2)
mtext(expression(paste("CO"[2], " (ppm)")),side=4,col="#34a853",line=8.5)
axis.POSIXct(1, at=seq(as.POSIXct("2016-03-09",format="%Y-%m-%d"), max(datemarest), by="day"),labels = FALSE,format="")

#mar photo
par(mar=c(0, 13, 0, 10)) # B, L, T, R
plot(datemarest[1:82],ph_medmarmean[1:82],cex=0.00001,axes=FALSE, col="white",xlab="Date",ylab="",ylim=c(-1,24),xlim=c(datemarest[1],datemarest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
polygon(c(datemarest[1:82] ,rev(datemarest[1:82])),c(ph_medmarmin[1:82], rev(ph_medmarmax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(datemarest[1],datemarest[82]))
lines(datemarest[1:82],ph_medmarmean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(datemarest[1],datemarest[82]))
lines(datemarest[1:82],ph_bbmarmean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(datemarest[1],datemarest[82]))
polygon(c(datemarest[1:82] ,rev(datemarest[1:82])),c(ph_bbmarmin[1:82], rev(ph_bbmarmax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
arrows(hourslzmarest, phslzmarhourmean-phslzmarhourci, hourslzmarest, phslzmarhourmean+phslzmarhourci, length=0.05, angle=90, code=3)
points(hourslzmarest,phslzmarhourmean,pch=21,col="black",bg="gray")
legend(as.POSIXct("2016-03-11 05:00:00",format="%Y-%m-%d %H:%M:%S"), 23, legend=c("MED", "BWB","MED_mean", "BWB_mean","Observations"),lty=c(0,0,1,1,1),col=c(rgb(0.2,0.4,1,alpha=0.5), rgb(1,0.4,0,alpha=0.5),rgb(0.2,0.4,1), rgb(1,0.2,0),"black"),pch=c(15,15,NA,NA,21),lwd=c(0,0,2,2,2),pt.bg=c(NA,NA,NA,NA,"gray"),cex=1.2,pt.cex=1.2,bty="n")
axis.POSIXct(1, at=seq(as.POSIXct("2016-03-09",format="%Y-%m-%d"), max(datemarest), by="day"),labels = FALSE,format="")
axis(2, cex.axis=1.2)
box()
text(as.POSIXct("2016-03-08 23:00:00",format="%Y-%m-%d %H:%M:%S"),21,cex=2,"b",font=2)

#mar stoma
par(mar=c(3, 13, 0, 10)) 
plot(datemarest[1:82],stoma_medmarmean[1:82],cex=0.00001, axes=FALSE,col="white",xlab="Date",ylab="",ylim=c(-0.05,0.5),xlim=c(datemarest[1],datemarest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("g"[sw], " (mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
polygon(c(datemarest[1:82] ,rev(datemarest[1:82])),c(stoma_medmarmin[1:82], rev(stoma_medmarmax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(datemarest[1],datemarest[82]))
lines(datemarest[1:82],stoma_medmarmean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(datemarest[1],datemarest[82]))
lines(datemarest[1:82],stoma_bbmarmean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(datemarest[1],datemarest[82]))
polygon(c(datemarest[1:82] ,rev(datemarest[1:82])),c(stoma_bbmarmin[1:82], rev(stoma_bbmarmax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
axis.POSIXct(1, at=seq(as.POSIXct("2016-03-09",format="%Y-%m-%d"), max(datemarest), by="day"),format="%m/%d",cex.axis=1.2)
arrows(hourslzmarest, stomslzmarhourmean-stomslzmarhourci, hourslzmarest, stomslzmarhourmean+stomslzmarhourci, length=0.05, angle=90, code=3)
points(hourslzmarest,stomslzmarhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,0.6,by=0.2), cex.axis=1.2)
mtext("Date",side=1,line=2)
box()
text(as.POSIXct("2016-03-08 23:00:00",format="%Y-%m-%d %H:%M:%S"),0.42,cex=2,"c",font=2)

#plot average comparison
par(mfrow=c(2,1))
par(mar=c(0, 5, 2, 2))
inds<-which(datemarest %in% hourslzmarest)
plot(hourslzmarest,ph_medmarmean[inds]-phslzmarhourmean,cex=0.00001,axes=FALSE, col=rgb(0.2,0.4,1),xlab="Date",ylab="",ylim=c(-6,2),xaxs="i", yaxs="i",type="l",main="Deviation of model results from the observations") #axes=FALSE suppresses both x and y axes. xaxt="n" and yaxt="n" suppress the x and y axis respectively
lines(hourslzmarest,ph_bbmarmean[inds]-phslzmarhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-4,1,by=2), cex.axis=1.2)
axis.POSIXct(1, at=(seq(min(hourslzmarest), max(hourslzmarest), by="2 hours")),format="%H:%M",labels = FALSE,cex.axis=1.2)
legend(as.POSIXct("2016-03-10 14:00:00",format="%Y-%m-%d %H:%M:%S"), -4, legend=c("Medlyn", "Ball-Berry"),lty=c(1,1),col=c(rgb(0.2,0.4,1),rgb(1,0.2,0)),cex=1,bty="n")
mtext(expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,cex=1.2,line=2.5)
box()
text(as.POSIXct("2016-03-10 07:30:00",format="%Y-%m-%d %H:%M:%S"),1,cex=2,"d",font=2)


par(mar=c(3, 5, 0, 2)) 
plot(hourslzmarest,stoma_medmarmean[inds]-stomslzmarhourmean,cex=0.00001,axes=FALSE,  col=rgb(0.2,0.4,1),xlab="Date",xaxt = "n",ylab="",ylim=c(-0.2,0.2),xaxs="i", yaxs="i",type="l")
lines(hourslzmarest,stoma_bbmarmean[inds]-stomslzmarhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-0.2,0.2,by=0.1), cex.axis=1.2)
axis.POSIXct(1, at=(seq(min(hourslzmarest), max(hourslzmarest), by="2 hours")),format="%H:%M",cex.axis=1.2)
mtext("gs (mol/m\U00B2/s)",side=2,cex=1.2,line=2.5)
mtext("Time in a day",side=1,cex=1.2,line=2)
box()
text(as.POSIXct("2016-03-10 07:30:00",format="%Y-%m-%d %H:%M:%S"),0.15,cex=2,"e",font=2)

#R plot
stoma_medmarmeanmp<-stoma_medmarmean[inds]         #measurement points
stoma_bbmarmeanmp<-stoma_bbmarmean[inds]         #measurement points
ph_medmarmeanmp<-ph_medmarmean[inds]         #measurement points
ph_bbmarmeanmp<-ph_bbmarmean[inds]         #measurement points
plot(stoma_medmarmean[inds],stomslzmarhourmean,pch=16,col="blue")
points(stoma_bbmarmean[inds],stomslzmarhourmean,pch=16,col="red")
abline(lm(stomslzmarhourmean~stoma_medmarmean[inds]), col="black")
abline(lm(stomslzmarhourmean~stoma_bbmarmean[inds]), col="red")

######April#
tairapr<-tair[(mcdate>20160419)&(mcdate<=20160424)]
rhapr<-rh[(mcdate>20160419)&(mcdate<=20160424)]
fsdsapr<-fsds[(mcdate>20160419)&(mcdate<=20160424)]
vpdapr<-vpd[(mcdate>20160419)&(mcdate<=20160424)]
co2apr<-co2[(mcdate>20160419)&(mcdate<=20160424)]

ph_medapr<-ph_med[(mcdate>20160419)&(mcdate<=20160424),]
ph_medapr_btran<-ph_med_btran[(mcdate>20160419)&(mcdate<=20160424)]
ph_bbapr<-ph_bb[(mcdate>20160419)&(mcdate<=20160424),]
ph_bbapr_btran<-ph_bb_btran[(mcdate>20160419)&(mcdate<=20160424)]
stoma_medapr<-stoma_med[(mcdate>20160419)&(mcdate<=20160424),]
stoma_medapr_btran<-stoma_med_btran[(mcdate>20160419)&(mcdate<=20160424)]
stoma_bbapr<-stoma_bb[(mcdate>20160419)&(mcdate<=20160424),]
stoma_bbapr_btran<-stoma_bb_btran[(mcdate>20160419)&(mcdate<=20160424)]
gpp_medapr<-gpp_med[(mcdate>20160419)&(mcdate<=20160424),]
gpp_bbapr<-gpp_bb[(mcdate>20160419)&(mcdate<=20160424),]
et_medapr<-et_med[(mcdate>20160419)&(mcdate<=20160424),]
et_bbapr<-et_bb[(mcdate>20160419)&(mcdate<=20160424),]


ph_medaprmean<-rowMeans(ph_medapr)
ph_bbaprmean<-rowMeans(ph_bbapr)

ph_medaprmax<-apply(ph_medapr,1,max)
ph_bbaprmax<-apply(ph_bbapr,1,max)

ph_medaprmin<-apply(ph_medapr,1,min)
ph_bbaprmin<-apply(ph_bbapr,1,min)

stoma_medaprmean<-rowMeans(stoma_medapr)
stoma_bbaprmean<-rowMeans(stoma_bbapr)

stoma_medaprmax<-apply(stoma_medapr,1,max)
stoma_bbaprmax<-apply(stoma_bbapr,1,max)

stoma_medaprmin<-apply(stoma_medapr,1,min)
stoma_bbaprmin<-apply(stoma_bbapr,1,min)

gpp_medaprmean<-rowMeans(gpp_medapr)
gpp_bbaprmean<-rowMeans(gpp_bbapr)

gpp_medaprmax<-apply(gpp_medapr,1,max)
gpp_bbaprmax<-apply(gpp_bbapr,1,max)

gpp_medaprmin<-apply(gpp_medapr,1,min)
gpp_bbaprmin<-apply(gpp_bbapr,1,min)

et_medaprmean<-rowMeans(et_medapr)
et_bbaprmean<-rowMeans(et_bbapr)

et_medaprmax<-apply(et_medapr,1,max)
et_bbaprmax<-apply(et_bbapr,1,max)

et_medaprmin<-apply(et_medapr,1,min)
et_bbaprmin<-apply(et_bbapr,1,min)


dateapr<-dateyear[dateyear>=force_tz(as.POSIXct("2016-04-20",format="%Y-%m-%d"),tzone="UTC") & dateyear<=force_tz(as.POSIXct("2016-04-24",format="%Y-%m-%d"),tzone="UTC")]
dateaprest<-with_tz(dateapr,tzone="EST")
hourslzaprest<-force_tz(hourslzapr,tzone="EST")

#apr met
par(mfrow=c(3,1))
par(mar=c(0, 13, 2, 10))
plot(dateaprest[1:82],tairapr[1:82],ylim=c(23,36),axes=FALSE,type="l",main="April 2016",cex.main=1.5,xlab="", ylab="",xaxs="i", yaxs="i")
points(hourslzaprest,tairslzaprtp,pch=16,col="black")
axis(2, ylim=c(20,30),col="black",cex.axis=1.2)
mtext("Tair (\u00B0C)",side=2,line=2.5)
box()
legend(as.POSIXct("2016-04-22 07:30:00",format="%Y-%m-%d %H:%M:%S"), 36, legend=c("FATES forcing", "LICOR forcing"),lty=c(1,0),col=c("black","black"),pch=c(NA,16),lwd=c(2,0),cex=1.2,pt.cex=1.2,bty="n")
text(as.POSIXct("2016-04-19 23:30:00",format="%Y-%m-%d %H:%M:%S"),35,cex=2,"a",font=2)

par(new=TRUE)
plot(dateaprest[1:82],fsdsapr[1:82],ylim=c(-100,3000),col="#ea4335",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzaprest,parslzaprtp,pch=16,col="#ea4335")
mtext(expression(paste("PAR (", mu, "mol ",m^-2," ",s^-1,")")),side=4,col="#ea4335",line=4)
axis(4, ylim=c(0,7000), at=seq(0,2500,by=800),col="#ea4335",col.axis="#ea4335",las=1,cex.axis=1.2)

par(new=TRUE)
plot(dateaprest[1:82],vpdapr[1:82],ylim=c(-0.05,1.5),col="#4285f4",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzaprest,vpdaslzaprtp,pch=16,col="#4285f4")
mtext("VPD (kPa)",side=2,col="#4285f4",line=7)
axis(2, at=seq(0,1.2,by=0.3),col="#4285f4",col.axis="#4285f4",line=4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),labels = FALSE,format="")


par(new=TRUE)
plot(dateaprest[1:82],rhapr[1:82]/100,ylim=c(-0.05,1.2),col="goldenrod3",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzaprest,rhslzaprtp/100,pch=16,col="goldenrod3")
mtext("RH",side=2,col="goldenrod3",line=11)
axis(2, col="goldenrod3",col.axis="goldenrod3",line=8.4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),labels = FALSE,format="")

par(new=TRUE)
plot(dateaprest[1:82],co2apr[1:82],ylim=c(200,450),col="#34a853",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzaprest,co2slzaprtp,pch=16,col="#34a853")
mtext(expression(paste("CO"[2], " (ppm)")),side=4,col="#34a853",line=8.5)
axis(4, col="#34a853",col.axis="#34a853",line=5,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),labels = FALSE,format="")

#apr photo
par(mar=c(0, 13, 0, 10)) # B, L, T, R
plot(dateaprest[1:82],ph_medaprmean[1:82],cex=0.00001,axes=FALSE, col="white",xlab="Date",ylab="",ylim=c(-1,24),xlim=c(dateaprest[1],dateaprest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
polygon(c(dateaprest[1:82] ,rev(dateaprest[1:82])),c(ph_medaprmin[1:82], rev(ph_medaprmax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(dateaprest[1],dateaprest[82]))
lines(dateaprest[1:82],ph_medaprmean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(dateaprest[1],dateaprest[82]))
lines(dateaprest[1:82],ph_bbaprmean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(dateaprest[1],dateaprest[82]))
polygon(c(dateaprest[1:82] ,rev(dateaprest[1:82])),c(ph_bbaprmin[1:82], rev(ph_bbaprmax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
arrows(hourslzaprest, phslzaprhourmean-phslzaprhourci, hourslzaprest, phslzaprhourmean+phslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,phslzaprhourmean,pch=21,col="black",bg="gray")
legend(as.POSIXct("2016-04-22 07:30:00",format="%Y-%m-%d %H:%M:%S"), 23, legend=c("MED", "BWB","MED_mean", "BWB_mean","Observations"),lty=c(0,0,1,1,1),lwd=c(0,0,2,2,2),col=c(rgb(0.2,0.4,1,alpha=0.5), rgb(1,0.4,0,alpha=0.5),rgb(0.2,0.4,1), rgb(1,0.2,0),"black"),pch=c(15,15,NA,NA,21),pt.bg=c(NA,NA,NA,NA,"gray"),cex=1.2,pt.cex=1.2,bty="n")
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),labels = FALSE,format="")
axis(2, cex.axis=1.2)
box()
text(as.POSIXct("2016-04-19 23:30:00",format="%Y-%m-%d %H:%M:%S"),21,cex=2,"b",font=2)

#apr stoma
par(mar=c(3, 13, 0, 10)) 
plot(dateaprest[1:82],stoma_medaprmean[1:82],cex=0.00001, axes=FALSE,col="white",xlab="Date",ylab="",ylim=c(-0.05,0.5),xlim=c(dateaprest[1],dateaprest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("g"[sw], " (mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
polygon(c(dateaprest[1:82] ,rev(dateaprest[1:82])),c(stoma_medaprmin[1:82], rev(stoma_medaprmax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(dateaprest[1],dateaprest[82]))
lines(dateaprest[1:82],stoma_medaprmean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(dateaprest[1],dateaprest[82]))
lines(dateaprest[1:82],stoma_bbaprmean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(dateaprest[1],dateaprest[82]))
polygon(c(dateaprest[1:82] ,rev(dateaprest[1:82])),c(stoma_bbaprmin[1:82], rev(stoma_bbaprmax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
axis.POSIXct(1, at=seq(as.POSIXct("2016-04-20",format="%Y-%m-%d"), max(dateaprest), by="day"),format="%m/%d",cex.axis=1.2)
arrows(hourslzaprest, stomslzaprhourmean-stomslzaprhourci, hourslzaprest, stomslzaprhourmean+stomslzaprhourci, length=0.05, angle=90, code=3)
points(hourslzaprest,stomslzaprhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,0.5,by=0.2), cex.axis=1.2)
mtext("Date",side=1,line=2)
box()
text(as.POSIXct("2016-04-19 23:30:00",format="%Y-%m-%d %H:%M:%S"),0.41,cex=2,"c",font=2)

#plot average comparison
par(mfrow=c(2,1))
par(mar=c(0, 5, 2, 2))
inds<-which(dateaprest %in% hourslzaprest)
plot(hourslzaprest,ph_medaprmean[inds]-phslzaprhourmean,cex=0.00001,axes=FALSE, col=rgb(0.2,0.4,1),xlab="Date",ylab="",ylim=c(-10,2),xaxs="i", yaxs="i",type="l",main="Deviation of model results from the observations") #axes=FALSE suppresses both x and y axes. xaxt="n" and yaxt="n" suppress the x and y axis respectively
lines(hourslzaprest,ph_bbaprmean[inds]-phslzaprhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-8,1,by=2), cex.axis=1.2)
axis.POSIXct(1, at=(seq(min(hourslzaprest), max(hourslzaprest), by="2 hours")),format="%H:%M",labels = FALSE,cex.axis=1.2)
legend(as.POSIXct("2016-04-21 15:00:00",format="%Y-%m-%d %H:%M:%S"), -7, legend=c("Medlyn", "Ball-Berry"),lty=c(1,1),col=c(rgb(0.2,0.4,1),rgb(1,0.2,0)),cex=1,bty="n")
mtext("Anet (\U003BCmol/m\U00B2/s)",side=2,cex=1.2,line=2.5)
box()
text(as.POSIXct("2016-04-21 08:30:00",format="%Y-%m-%d %H:%M:%S"),0.65,cex=2,"d",font=2)

par(mar=c(3, 5, 0, 2)) 
plot(hourslzaprest,stoma_medaprmean[inds]-stomslzaprhourmean,cex=0.00001,axes=FALSE,  col=rgb(0.2,0.4,1),xlab="Date",xaxt = "n",ylab="",ylim=c(-0.2,0.15),xaxs="i", yaxs="i",type="l")
lines(hourslzaprest,stoma_bbaprmean[inds]-stomslzaprhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-0.2,0.15, by=0.1), cex.axis=1.2)
axis.POSIXct(1, at=(seq(min(hourslzaprest), max(hourslzaprest), by="2 hours")),format="%H:%M",cex.axis=1.2)
mtext("gs (mol/m\U00B2/s)",side=2,cex=1.2,line=2.5)
mtext("Time in a day",side=1,cex=1.2,line=2)
box()
text(as.POSIXct("2016-04-21 08:30:00",format="%Y-%m-%d %H:%M:%S"),0.1,cex=2,"e",font=2)

#R plot
stoma_medaprmeanmp<-stoma_medaprmean[inds]         #measurement points
stoma_bbaprmeanmp<-stoma_bbaprmean[inds]         #measurement points
ph_medaprmeanmp<-ph_medaprmean[inds]         #measurement points
ph_bbaprmeanmp<-ph_bbaprmean[inds]         #measurement points
plot(stoma_medaprmean[inds],stomslzaprhourmean,pch=16,col="blue")
points(stoma_bbaprmean[inds],stomslzaprhourmean,pch=16,col="red")
abline(lm(stomslzaprhourmean~stoma_medaprmean[inds]), col="black")
abline(lm(stomslzaprhourmean~stoma_bbaprmean[inds]), col="red")

##############May
tairmay<-tair[(mcdate>20160522)&(mcdate<=20160527)]
rhmay<-rh[(mcdate>20160522)&(mcdate<=20160527)]
fsdsmay<-fsds[(mcdate>20160522)&(mcdate<=20160527)]
vpdmay<-vpd[(mcdate>20160522)&(mcdate<=20160527)]
co2may<-co2[(mcdate>20160522)&(mcdate<=20160527)]

ph_medmay<-ph_med[(mcdate>20160522)&(mcdate<=20160527),]
ph_medmay_btran<-ph_med_btran[(mcdate>20160522)&(mcdate<=20160527)]
ph_bbmay<-ph_bb[(mcdate>20160522)&(mcdate<=20160527),]
ph_bbmay_btran<-ph_bb_btran[(mcdate>20160522)&(mcdate<=20160527)]
stoma_medmay<-stoma_med[(mcdate>20160522)&(mcdate<=20160527),]
stoma_medmay_btran<-stoma_med_btran[(mcdate>20160522)&(mcdate<=20160527)]
stoma_bbmay<-stoma_bb[(mcdate>20160522)&(mcdate<=20160527),]
stoma_bbmay_btran<-stoma_bb_btran[(mcdate>20160522)&(mcdate<=20160527)]
gpp_medmay<-gpp_med[(mcdate>20160522)&(mcdate<=20160527),]
gpp_bbmay<-gpp_bb[(mcdate>20160522)&(mcdate<=20160527),]
et_medmay<-et_med[(mcdate>20160522)&(mcdate<=20160527),]
et_bbmay<-et_bb[(mcdate>20160522)&(mcdate<=20160527),]

ph_medmaymean<-rowMeans(ph_medmay)
ph_bbmaymean<-rowMeans(ph_bbmay)
ph_medmaymax<-apply(ph_medmay,1,max)
ph_bbmaymax<-apply(ph_bbmay,1,max)
ph_medmaymin<-apply(ph_medmay,1,min)
ph_bbmaymin<-apply(ph_bbmay,1,min)


stoma_medmaymean<-rowMeans(stoma_medmay)
stoma_bbmaymean<-rowMeans(stoma_bbmay)
stoma_medmaymax<-apply(stoma_medmay,1,max)
stoma_bbmaymax<-apply(stoma_bbmay,1,max)
stoma_medmaymin<-apply(stoma_medmay,1,min)
stoma_bbmaymin<-apply(stoma_bbmay,1,min)

gpp_medmaymean<-rowMeans(gpp_medmay)
gpp_bbmaymean<-rowMeans(gpp_bbmay)
gpp_medmaymax<-apply(gpp_medmay,1,max)
gpp_bbmaymax<-apply(gpp_bbmay,1,max)
gpp_medmaymin<-apply(gpp_medmay,1,min)
gpp_bbmaymin<-apply(gpp_bbmay,1,min)

et_medmaymean<-rowMeans(et_medmay)
et_bbmaymean<-rowMeans(et_bbmay)
et_medmaymax<-apply(et_medmay,1,max)
et_bbmaymax<-apply(et_bbmay,1,max)
et_medmaymin<-apply(et_medmay,1,min)
et_bbmaymin<-apply(et_bbmay,1,min)

datemay<-dateyear[dateyear>=force_tz(as.POSIXct("2016-05-23",format="%Y-%m-%d"),tzone="UTC") & dateyear<=force_tz(as.POSIXct("2016-05-27",format="%Y-%m-%d"),tzone="UTC")]
datemayest<-with_tz(datemay,tzone="EST")
hourslzmayest<-force_tz(hourslzmay,tzone="EST")

#may met
par(mfrow=c(3,1))
par(mar=c(0, 13, 2, 10))
plot(datemayest[1:82],tairmay[1:82],ylim=c(23,37),axes=FALSE,type="l",main="May 2016",cex.main=1.5,xlab="", ylab="",xaxs="i", yaxs="i")
points(hourslzmayest,tairslzmaytp,pch=16,col="black")
axis(2, ylim=c(20,30),col="black",cex.axis=1.2)
mtext("Tair (\u00B0C)",side=2,line=2.5)
box()
legend(as.POSIXct("2016-05-25 07:00:00",format="%Y-%m-%d %H:%M:%S"), 37, legend=c("FATES forcing", "LICOR forcing"),lty=c(1,0),col=c("black","black"),pch=c(NA,16),lwd=c(2,0),cex=1.2,pt.cex=1.2,bty="n")

par(new=TRUE)
plot(datemayest[1:82],fsdsmay[1:82],ylim=c(-100,3000),col="#ea4335",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmayest,parslzmaytp,pch=16,col="#ea4335")
mtext(expression(paste("PAR (", mu, "mol ",m^-2," ",s^-1,")")),side=4,col="#ea4335",line=4)
axis(4, ylim=c(0,7000), at=seq(0,2500,by=800),col="#ea4335",col.axis="#ea4335",las=1,cex.axis=1.2)

par(new=TRUE)
plot(datemayest[1:82],vpdmay[1:82],ylim=c(-0.05,0.9),col="#4285f3",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmayest,vpdaslzmaytp,pch=16,col="#4285f3")
mtext("VPD (kPa)",side=2,col="#4285f3",line=7)
axis(2,at=seq(0,1, by=0.3), col="#4285f3",col.axis="#4285f3",line=4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-05-23",format="%Y-%m-%d"), max(datemayest), by="day"),labels = FALSE,format="")
text(as.POSIXct("2016-05-22 23:00:00",format="%Y-%m-%d %H:%M:%S"),0.8,cex=2,"a",font=2)

par(new=TRUE)
plot(datemayest[1:82],rhmay[1:82]/100,ylim=c(-0.05,1.5),col="goldenrod3",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmayest,rhslzmaytp/100,pch=16,col="goldenrod3")
mtext("RH",side=2,col="goldenrod3",line=11)
axis(2, col="goldenrod3",col.axis="goldenrod3",line=8.4,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-05-23",format="%Y-%m-%d"), max(datemayest), by="day"),labels = FALSE,format="")

par(new=TRUE)
plot(datemayest[1:82],co2may[1:82],ylim=c(200,460),col="#009E73",type="l",xlab="", ylab="",xaxs="i", yaxs="i",axes=FALSE)
points(hourslzmayest,co2slzmaytp,pch=16,col="#009E73")
mtext(expression(paste("CO"[2], " (ppm)")),side=4,col="#009E73",line=8.5)
axis(4, col="#009E73",col.axis="#009E73",line=5,las=1,cex.axis=1.2)
axis.POSIXct(1, at=seq(as.POSIXct("2016-05-23",format="%Y-%m-%d"), max(datemayest), by="day"),labels = FALSE,format="")
#may photo
par(mar=c(0, 13, 0, 10)) # B, L, T, R
plot(datemayest[1:82],ph_medmaymean[1:82],cex=0.00001,axes=FALSE, col="white",xlab="Date",ylab="",ylim=c(-1,24),xlim=c(datemayest[1],datemayest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
polygon(c(datemayest[1:82] ,rev(datemayest[1:82])),c(ph_medmaymin[1:82], rev(ph_medmaymax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(datemayest[1],datemayest[82]))
lines(datemayest[1:82],ph_medmaymean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(datemayest[1],datemayest[82]))
lines(datemayest[1:82],ph_bbmaymean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(datemayest[1],datemayest[82]))
polygon(c(datemayest[1:82] ,rev(datemayest[1:82])),c(ph_bbmaymin[1:82], rev(ph_bbmaymax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
arrows(hourslzmayest, phslzmayhourmean-phslzmayhourci, hourslzmayest, phslzmayhourmean+phslzmayhourci, length=0.05, angle=90, code=3)
points(hourslzmayest,phslzmayhourmean,pch=21,col="black",bg="gray")
legend(as.POSIXct("2016-05-25 07:00:00",format="%Y-%m-%d %H:%M:%S"), 23, legend=c("MED", "BWB","MED_mean", "BWB_mean","Observations"),lty=c(0,0,1,1,1),col=c(rgb(0.2,0.4,1,alpha=0.5), rgb(1,0.4,0,alpha=0.5),rgb(0.2,0.4,1), rgb(1,0.2,0),"black"),lwd=c(0,0,2,2,2),pch=c(15,15,NA,NA,21),pt.bg=c(NA,NA,NA,NA,"gray"),cex=1.2,pt.cex=1.2,bty="n")
axis.POSIXct(1, at=seq(as.POSIXct("2016-05-23",format="%Y-%m-%d"), max(datemayest), by="day"),labels = FALSE,format="")
axis(2, cex.axis=1.2)
box()
text(as.POSIXct("2016-05-22 23:00:00",format="%Y-%m-%d %H:%M:%S"),20,cex=2,"b",font=2)

#may stoma
par(mar=c(3, 13, 0, 10)) 
plot(datemayest[1:82],stoma_medmaymean[1:82],cex=0.00001, axes=FALSE,col="white",xlab="Date",ylab="",ylim=c(-0.05,0.5),xlim=c(datemayest[1],datemayest[82]),xaxs="i", yaxs="i")
mtext(expression(paste("g"[sw], " (mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
polygon(c(datemayest[1:82] ,rev(datemayest[1:82])),c(stoma_medmaymin[1:82], rev(stoma_medmaymax[1:82])),col= rgb(0.2,0.4,1,alpha=0.5),border=NA,xlim=c(datemayest[1],datemayest[82]))
lines(datemayest[1:82],stoma_medmaymean[1:82],lwd=1.5, lty=1, col=rgb(0.2,0.4,1),xlim=c(datemayest[1],datemayest[82]))
lines(datemayest[1:82],stoma_bbmaymean[1:82],lwd=1.5, lty=1, col=rgb(1,0.2,0),xlim=c(datemayest[1],datemayest[82]))
polygon(c(datemayest[1:82] ,rev(datemayest[1:82])),c(stoma_bbmaymin[1:82], rev(stoma_bbmaymax[1:82])),col= rgb(1,0.4,0,alpha=0.5),border=NA)
axis.POSIXct(1, at=seq(as.POSIXct("2016-05-23",format="%Y-%m-%d"), max(datemayest), by="day"),format="%m/%d",cex.axis=1.2)
arrows(hourslzmayest, stomslzmayhourmean-stomslzmayhourci, hourslzmayest, stomslzmayhourmean+stomslzmayhourci, length=0.05, angle=90, code=3)
points(hourslzmayest,stomslzmayhourmean,pch=21,col="black",bg="gray")
axis(2,at=seq(0,0.6,by=0.2), cex.axis=1.2)
mtext("Date",side=1,line=2)
box()
text(as.POSIXct("2016-05-22 23:00:00",format="%Y-%m-%d %H:%M:%S"),0.4,cex=2,"c",font=2)

#plot average comparison
par(mfrow=c(2,1))
par(mar=c(0, 5, 2, 2))
inds<-which(datemayest %in% hourslzmayest)
plot(hourslzmayest,ph_medmaymean[inds]-phslzmayhourmean,cex=0.00001,axes=FALSE, col=rgb(0.2,0.4,1),xlab="Date",ylab="",ylim=c(-7,3),xaxs="i", yaxs="i",type="l",main="Deviation of model results from the observations") #axes=FALSE suppresses both x and y axes. xaxt="n" and yaxt="n" suppress the x and y axis respectively
lines(hourslzmayest,ph_bbmaymean[inds]-phslzmayhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-6,2,by=2), cex.axis=1.2)
axis.POSIXct(1, at=(seq(min(hourslzmayest), max(hourslzmayest), by="2 hours")),format="%H:%M",labels = FALSE,cex.axis=1.2)
legend(as.POSIXct("2016-05-24 14:30:00",format="%Y-%m-%d %H:%M:%S"), -4.5, legend=c("Medlyn", "Ball-Berry"),lty=c(1,1),col=c(rgb(0.2,0.4,1),rgb(1,0.2,0)),cex=1,bty="n")
mtext("Anet (\U003BCmol/m\U00B2/s)",side=2,cex=1.2,line=2.5)
box()
text(as.POSIXct("2016-05-24 08:30:00",format="%Y-%m-%d %H:%M:%S"),2,cex=2,"d",font=2)

par(mar=c(3, 5, 0, 2)) 
plot(hourslzmayest,stoma_medmaymean[inds]-stomslzmayhourmean,cex=0.00001,axes=FALSE,  col=rgb(0.2,0.4,1),xlab="Date",xaxt = "n",ylab="",ylim=c(-0.22,0.3),xaxs="i", yaxs="i",type="l")
lines(hourslzmayest,stoma_bbmaymean[inds]-stomslzmayhourmean,lwd=1.5, lty=1, col=rgb(1,0.2,0))
abline(h=0, col="dimgray",lty=2)
axis(2,at=seq(-0.2,0.2,by=0.2), cex.axis=1.2)
axis.POSIXct(1, at=(seq(min(hourslzmayest), max(hourslzmayest), by="2 hours")),format="%H:%M",cex.axis=1.2)
mtext("gs (mol/m\U00B2/s)",side=2,cex=1.2,line=2.5)
mtext("Time in a day",side=1,cex=1.2,line=2)
box()
text(as.POSIXct("2016-05-24 08:30:00",format="%Y-%m-%d %H:%M:%S"),0.25,cex=2,"e",font=2)

#R plot
stoma_medmaymeanmp<-stoma_medmaymean[inds]         #measurement points
stoma_bbmaymeanmp<-stoma_bbmaymean[inds]         #measurement points
ph_medmaymeanmp<-ph_medmaymean[inds]         #measurement points
ph_bbmaymeanmp<-ph_bbmaymean[inds]         #measurement points
plot(stoma_medmaymean[inds],stomslzmayhourmean,pch=16,col="blue")
points(stoma_bbmaymean[inds],stomslzmayhourmean,pch=16,col="red")
abline(lm(stomslzmayhourmean~stoma_medmaymean[inds]), col="black")
abline(lm(stomslzmayhourmean~stoma_bbmaymean[inds]), col="red")
lines(seq(-0.1,0.3,by=0.1), seq(-0.1,0.3,by=0.1),type = "l", lwd=2,col="red",lty = 1)

#R plot for all ph&stom results

stoma_medallmean<-c(stoma_medfebmeanmp,stoma_medmarmeanmp,stoma_medaprmeanmp,stoma_medmaymeanmp)
stoma_bballmean<-c(stoma_bbfebmeanmp,stoma_bbmarmeanmp,stoma_bbaprmeanmp,stoma_bbmaymeanmp)
stomslzallhourmean<-c(stomslzfebhourmean,stomslzmarhourmean,stomslzaprhourmean,stomslzmayhourmean)
 
ph_medallmean<-c(ph_medfebmeanmp,ph_medmarmeanmp,ph_medaprmeanmp,ph_medmaymeanmp)
ph_bballmean<-c(ph_bbfebmeanmp,ph_bbmarmeanmp,ph_bbaprmeanmp,ph_bbmaymeanmp)
phslzallhourmean<-c(phslzfebhourmean,phslzmarhourmean,phslzaprhourmean,phslzmayhourmean)

par(mfrow=c(2,1))
par(mar=c(3, 6, 1, 2))
plot(ph_medallmean,phslzallhourmean,pch=16,col="red",ylim=c(-0.1,15),xlim=c(3,12),xlab="",ylab="")
points(ph_bballmean,phslzallhourmean,pch=16,col="blue")
abline(lm(phslzallhourmean~ph_medallmean), col="red")
abline(lm(phslzallhourmean~ph_bballmean), col="blue")
lines(seq(-0.1,15,by=0.1), seq(-0.1,15,by=0.1),type = "l", lwd=2,col="black",lty = 2)
text(11.5,10.5,"1:1 line",col="black")
regres_med<-summary(lm(phslzallhourmean~ph_medallmean))
regres_bb<-summary(lm(phslzallhourmean~ph_bballmean))
r2_med=regres_med$adj.r.squared
r2_bb=regres_bb$adj.r.squared
pva_med<-regres_med$coefficients[2,4]
pva_bb<-regres_bb$coefficients[2,4]
RMSE = function(m, o){
  sqrt(mean((m - o)^2))
}                #NO RMSE function in R
rmse_ph_med<-RMSE(phslzallhourmean,ph_medallmean)
rmse_ph_bb<-RMSE(phslzallhourmean,ph_bballmean)
rp_med = vector('expression',3)
rp_med[1] = substitute(expression(italic(R)^2 == r2_med_va), 
                       list(r2_med_va = format(r2_med,dig=3)))[2]
rp_med[2] = substitute(expression(italic(p) == pva_med_va), 
                       list(pva_med_va = format(pva_med, digits = 2)))[2]
rp_med[3] = paste("RMSE =", format(rmse_ph_med, digits = 3)) 
                       
rp_bb = vector('expression',3)
rp_bb[1] = substitute(expression(italic(R)^2 == r2_bb_va), 
                      list(r2_bb_va = format(r2_bb,dig=3)))[2]
rp_bb[2] = substitute(expression(italic(p) == pva_bb_va), 
                      list(pva_bb_va = format(pva_bb, digits = 2)))[2]
rp_bb[3] = paste("RMSE =", format(rmse_ph_bb, digits = 3))

legend(9,9, legend = rp_med, text.col="red",bty = 'n')
legend(3,11, legend = rp_bb, text.col="blue",bty = 'n')
text(3,14,"a",col="black",cex=1.5,font=2)
legend(3.5,14.5,legend=c("MED","BWB"),pch=c(16,16),col=c("red","blue"))
mtext(expression(paste("Modeled A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=1,line=2.3)
mtext(expression(paste("Observed A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),side=2,line=2.5)



par(mar=c(3.2, 6, 1, 2))
plot(stoma_medallmean,stomslzallhourmean,pch=16,col="red",ylim=c(0,0.4),xlim=c(0,0.3),xlab="",ylab="")
points(stoma_bballmean,stomslzallhourmean,pch=16,col="blue")
abline(lm(stomslzallhourmean~stoma_medallmean), col="red")
abline(lm(stomslzallhourmean~stoma_bballmean), col="blue")
lines(seq(0,0.4,by=0.1), seq(0,0.4,by=0.1),type = "l", lwd=2,col="black",lty = 2)
text(0.29,0.27,"1:1 line",col="black")
regres_med<-summary(lm(stomslzallhourmean~stoma_medallmean))
regres_bb<-summary(lm(stomslzallhourmean~stoma_bballmean))
r2_med=regres_med$adj.r.squared
r2_bb=regres_bb$adj.r.squared
pva_med<-regres_med$coefficients[2,4]
pva_bb<-regres_bb$coefficients[2,4]
rmse_stom_med<-RMSE(stomslzallhourmean,stoma_medallmean)
rmse_stom_bb<-RMSE(stomslzallhourmean,stoma_bballmean)
rp_med = vector('expression',3)
rp_med[1] = substitute(expression(italic(R)^2 == r2_med_va), 
                       list(r2_med_va = format(r2_med,dig=3)))[2]
rp_med[2] = substitute(expression(italic(p) == pva_med_va), 
                       list(pva_med_va = format(pva_med, digits = 2)))[2]
rp_med[3] = paste("RMSE =", format(rmse_stom_med, digits = 2)) 
rp_bb = vector('expression',3)
rp_bb[1] = substitute(expression(italic(R)^2 == r2_bb_va), 
                      list(r2_bb_va = format(r2_bb,dig=3)))[2]
rp_bb[2] = substitute(expression(italic(p) == pva_bb_va), 
                      list(pva_bb_va = format(pva_bb, digits = 2)))[2]
rp_bb[3] = paste("RMSE =", format(rmse_stom_bb, digits = 2)) 
legend(0.23,0.22, legend = rp_med, text.col="red",bty = 'n')
legend(0.01,0.3, legend = rp_bb, text.col="blue",bty = 'n')
mtext(expression(paste("Modeled g"[sw], " (mol ",m^-2," ",s^-1,")")),side=1,line=2.3)
mtext(expression(paste("Observed g"[sw], " (mol ",m^-2," ",s^-1,")")),side=2,line=2.5)
text(0,0.38,"b",col="black",cex=1.5,font=2)

#reference
#https://stackoverflow.com/questions/48571943/how-can-i-add-legends-for-geoms-when-using-multiple-datasets
#https://lukemiller.org/index.php/2012/10/adding-p-values-and-r-squared-values-to-a-plot-using-expression/