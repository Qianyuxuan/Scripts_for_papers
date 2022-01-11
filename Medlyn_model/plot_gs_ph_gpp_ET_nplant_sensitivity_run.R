rm(list = ls())
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_Radi.RData')
gs_bb_rad<-gsbsp
gs_med_rad<-gsmsp
gs_med_rad2<-gsmsp2
ph_bb_rad<-phbsp
ph_med_rad<-phmsp
ph_med_rad2<-phmsp2
gpp_bb_rad<-gppbsp
gpp_med_rad<-gppmsp
gpp_med_rad2<-gppmsp2
et_bb_rad<-etbsp
et_med_rad<-etmsp
et_med_rad2<-etmsp2
nplant_bb_rad<-nplantbsizesp
nplant_med_rad<-nplantmsizesp
nplant_med_rad2<-nplantmsizesp2
tveg_rad<-tvegmsp-273.15
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_Tair.RData')
gs_bb_tair<-gsbsp
gs_med_tair<-gsmsp
gs_med_tair2<-gsmsp2
ph_bb_tair<-phbsp
ph_med_tair<-phmsp
ph_med_tair2<-phmsp2
gpp_bb_tair<-gppbsp
gpp_med_tair<-gppmsp
gpp_med_tair2<-gppmsp2
et_bb_tair<-etbsp
et_med_tair<-etmsp
et_med_tair2<-etmsp2
nplant_bb_tair<-nplantbsizesp
nplant_med_tair<-nplantmsizesp
nplant_med_tair2<-nplantmsizesp2
tveg_tair<-tvegmsp-273.15
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_Humd.RData')
gs_bb_hum<-gsbsp
gs_med_hum<-gsmsp
gs_med_hum2<-gsmsp2
ph_bb_hum<-phbsp
ph_med_hum<-phmsp
ph_med_hum2<-phmsp2
gpp_bb_hum<-gppbsp
gpp_med_hum<-gppmsp
gpp_med_hum2<-gppmsp2
et_bb_hum<-etbsp
et_med_hum<-etmsp
et_med_hum2<-etmsp2
nplant_bb_hum<-nplantbsizesp
nplant_med_hum<-nplantmsizesp
nplant_med_hum2<-nplantmsizesp2
tveg_hum<-tvegmsp-273.15
load('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_CO2.RData')
gs_bb_CO2<-gsbsp
gs_med_CO2<-gsmsp
gs_med_CO22<-gsmsp2
ph_bb_CO2<-phbsp
ph_med_CO2<-phmsp
ph_med_CO22<-phmsp2
gpp_bb_CO2<-gppbsp
gpp_med_CO2<-gppmsp
gpp_med_CO22<-gppmsp2
et_bb_CO2<-etbsp
et_med_CO2<-etmsp
et_med_CO22<-etmsp2
nplant_bb_CO2<-nplantbsizesp
nplant_med_CO2<-nplantmsizesp
nplant_med_CO22<-nplantmsizesp2
tveg_CO2<-tvegmsp-273.15
#######gs#################
par(mfrow=c(2,2))
par(mar=c(4, 5, 2, 2))
plot(rdbsp[1:25]*2.1,gs_bb_rad[1:25],xlab=expression(paste("PAR (",mu,"mol ",m^-2," ",s^-1,")")),ylab=expression(paste("g"[sw], " (mol ",m^-2," ",s^-1,")")),type="l", lwd=2,col="blue",ylim=c(0,0.4),xlim=c(0,2000),cex.lab=1.5,cex.axis=1.5,cex.main=1.5)
lines(rdmsp[1:25]*2.1,gs_med_rad[1:25],lty=1,lwd=2,col='red')  
lines(rdmsp2[1:25]*2.1,gs_med_rad2[1:25], lty=1,lwd=2,col='black')  
legend(900, 0.43, legend=c("BWB","MED-B","MED-default"), col=c("blue", "red","black"), lty=c(1,1,1),cex=1.5,lwd=3,bty="n")
text(90, 0.37,cex=2,"a",font=2)

par(mar=c(4, 5, 2, 2))
plot(pco2bsp,gs_bb_CO2,xlab=expression("Atmospheric CO"[2]* " concentration (ppm)"),ylab=expression(paste("g"[sw], " (mol ",m^-2," ",s^-1,")")),type="l", lwd=2,col="blue",ylim=c(0,0.4),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(pco2msp,gs_med_CO2, lty=1,lwd=2,col='red')
lines(pco2msp2,gs_med_CO22,lty=1,lwd=2,col='black')
text(150, 0.37,cex=2,"b",font=2)

par(mar=c(4, 5, 4, 2))
plot(dabsp[5:21],gs_bb_hum[5:21],xlab=" VPD (Pa)",ylab=expression(paste("g"[sw], " (mol ",m^-2," ",s^-1,")")),type="l",lwd=2,xlim=c(0,2500),ylim=c(0,0.4), col="blue",cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(damsp[5:21],gs_med_hum[5:21],lty=1,lwd=2,col='red')
lines(damsp2[5:21],gs_med_hum2[5:21],lty=1,lwd=2,col='black')
text(60, 0.37,cex=2,"c",font=2)

par(mar=c(4, 5, 4, 2))
plot(tempbsp-273.15,gs_bb_tair,xlab=" Tair (\u00B0C)",ylab=expression(paste("g"[sw], " (mol ",m^-2," ",s^-1,")")),type="l",lwd=2,col="blue",ylim=c(0,0.4),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(tempmsp-273.15,gs_med_tair, lty=1,lwd=2,col='red') 
lines(tempmsp2-273.15,gs_med_tair2,lty=1,lwd=2,col='black') 
text(9,0.37,cex=2,"d",font=2)

#########ph####################
par(mfrow=c(2,2))
par(mar=c(4, 5, 2, 2))
plot(rdbsp[1:25]*2.1,ph_bb_rad[1:25],xlab=expression(paste("PAR (",mu,"mol ",m^-2," ",s^-1,")")),ylab=expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),type="l",lwd=2, col="blue",xlim=c(0,2000),ylim=c(0,20),cex.lab=1.5,cex.axis=1.5,cex.main=1.5)
lines(rdmsp[1:25]*2.1,ph_med_rad[1:25],lty=1,lwd=2,col='red')  
lines(rdmsp2[1:25]*2.1,ph_med_rad2[1:25],lty=1,lwd=2,col='black')  
legend(900, 21, legend=c("BWB","MED-B","MED-default"), col=c("blue", "red","black"),lty=c(1,1,1), cex=1.5,lwd=3,bty="n")
text(70, 19,cex=2,"a",font=2)

par(mar=c(4, 5, 2, 2))
plot(pco2bsp,ph_bb_CO2,xlab=expression("Atmospheric CO"[2]* " concentration (ppm)"),ylab=expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),type="l", col="blue",ylim=c(0,20),lwd=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(pco2msp,ph_med_CO2,lty=1,lwd=2,col='red')
lines(pco2msp2,ph_med_CO22,lty=1,lwd=2,col='black')
text(150, 19,cex=2,"b",font=2)

par(mar=c(4, 5, 2, 2))
plot(dabsp[5:21],ph_bb_hum[5:21],xlab=" VPD (Pa)",ylab=expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),type="l",xlim=c(0,2500),ylim=c(0,20), col="blue",lwd=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(damsp[5:21],ph_med_hum[5:21],lty=1,lwd=2,col='red')
lines(damsp2[5:21],ph_med_hum2[5:21],lty=1,lwd=2,col='black')
text(140, 19,cex=2,"c",font=2)

par(mar=c(4, 5, 2, 2))
plot(tempbsp-273.15,ph_bb_tair,xlab=" Tair (\u00B0C)",ylab=expression(paste("A"[net], " (",mu,"mol ",m^-2," ",s^-1,")")),col="blue",ylim=c(0,20),type="l",lwd=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(tempmsp-273.15,ph_med_tair,lty=1,lwd=2,col='red') 
lines(tempmsp2-273.15,ph_med_tair2,lty=1,lwd=2,col='black') 
text(9,19,cex=2,"d",font=2)
##################ET###########
par(mfrow=c(2,2))
par(mar=c(4, 5, 2, 2))
plot(rdbsp[1:25]*2.1,et_bb_rad[1:25]*3600,xlab=expression(paste("PAR (",mu,"mol ",m^-2," ",s^-1,")")),ylab=expression(paste("ET (mm ",h^-1,")")),type="l",lwd=2,col="blue",ylim=c(0,1),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)  
lines(rdmsp[1:25]*2.1,et_med_rad[1:25]*3600,lty=1,lwd=2,col='red')
lines(rdmsp2[1:25]*2.1,et_med_rad2[1:25]*3600,lty=1,lwd=2,col='black')
legend(900, 1, legend=c("BWB","MED-B","MED-default"), col=c("blue", "red","black"), lty=c(1,1,1), cex=1.5,lwd=3,bty="n")
text(90,0.9,cex=2,"a",font=2)

par(mar=c(4, 5, 2, 2))
plot(pco2bsp,et_bb_CO2*3600,xlab=expression("Atmospheric CO"[2]*" concentration (ppm)"),ylab=expression(paste("ET (mm ",h^-1,")")),type="l",lwd=2,col="blue",ylim=c(0,1),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(pco2msp,et_med_CO2*3600,lty=1,lwd=2,col='red')
lines(pco2msp2,et_med_CO22*3600,lty=1,lwd=2,col='black')
text(150,0.9,cex=2,"b",font=2)

par(mar=c(4, 5, 2, 2))
plot(dabsp[5:21],et_bb_hum[5:21]*3600,xlab=" VPD (Pa)",ylab=expression(paste("ET (mm ",h^-1,")")),type="l", lwd=2,col="blue",ylim=c(0,1),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(damsp[5:21],et_med_hum[5:21]*3600,lty=1,lwd=2,col='red')
lines(damsp2[5:21],et_med_hum2[5:21]*3600,lty=1,lwd=2,col='black')
text(140,0.9,cex=2,"c",font=2)

par(mar=c(4, 5, 2, 2))
plot(tempbsp-273.15,et_bb_tair*3600,xlab=" Tair (\u00B0C)",ylab=expression(paste("ET (mm ",h^-1,")")),type="l",col="blue",ylim=c(0,1),lwd=2, cex.lab=1.5, cex.main=1.5, cex.axis=1.5)
lines(tempmsp-273.15,et_med_tair*3600,lwd=2,lty=1,col='red')
lines(tempmsp2-273.15,et_med_tair2*3600,lwd=2,lty=1,col='black')
text(9,0.9,cex=2,"d",font=2)
###############GPP########
par(mfrow=c(2,2))
par(mar=c(4, 5, 2, 2))
plot(rdbsp[1:25]*2.1,gpp_bb_rad[1:25],xlab=expression(paste("PAR (",mu,"mol ",m^-2," ",s^-1,")")),ylab=expression(paste("GPP (",mu,"mol ",m^-2," ",s^-1,")")),type="l", lwd=2,col="blue",ylim=c(0,50),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(rdmsp[1:25]*2.1,gpp_med_rad[1:25],lty=1,lwd=2,col='red')
lines(rdmsp2[1:25]*2.1,gpp_med_rad2[1:25],lty=1,lwd=2,col='black')
legend(900, 51, legend=c("BWB","MED-B","MED-default"), col=c("blue", "red","black"), lty=c(1,1,1), cex=1.5,lwd=3,bty="n")
text(90,46,cex=2,"a",font=2)

par(mar=c(4, 5, 2, 2))
plot(pco2bsp,gpp_bb_CO2,xlab=expression("Atmospheric CO"[2]* " concentration (ppm)"),ylab=expression(paste("GPP (",mu,"mol ",m^-2," ",s^-1,")")),type="l", col="blue",ylim=c(0,50),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(pco2msp,gpp_med_CO2,lty=1,lwd=2,col='red')
lines(pco2msp2,gpp_med_CO22,lty=1,lwd=2,col='black')
text(130,46,cex=2,"b",font=2)

par(mar=c(4, 5, 2, 2))
plot(dabsp[5:21],gpp_bb_hum[5:21],xlab=" VPD (Pa)",ylab=expression(paste("GPP (",mu,"mol ",m^-2," ",s^-1,")")),type="l", lwd=2,col="blue",ylim=c(1,50),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(damsp[5:21],gpp_med_hum[5:21],lty=1,lwd=2,col='red')
lines(damsp2[5:21],gpp_med_hum2[5:21],lty=1,lwd=2,col='black')
text(50, 46,cex=2,"c",font=2)

par(mar=c(4, 5, 2, 2))
plot(tempbsp-273.15,gpp_bb_tair,xlab=" Tair (\u00B0C)",ylab=expression(paste("GPP (",mu,"mol ",m^-2," ",s^-1,")")),type="l", col="blue",lwd=2,ylim=c(0,50),cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
lines(tempmsp-273.15,gpp_med_tair,lty=1,lwd=2,col='red')
lines(tempmsp2-273.15,gpp_med_tair2,lty=1,lwd=2,col='black')
text(9,46,cex=2,"d",font=2)
################NPLANT########
par(mfrow=c(2,2))
par(mar=c(4, 5, 2, 2))
plot(rdbsp[1:25]*2.1,nplant_bb_rad[1:25],xlab=expression(paste("PAR (",mu,"mol ",m^-2," ",s^-1,")")),ylab="nplant (plants/ha)",type="l", col="blue",ylim=c(0,20),cex.lab=1.5,lwd=2,cex.main=1.5,cex.axis=1.5)
lines(rdmsp[1:25]*2.1,nplant_med_rad[1:25],lty=1,lwd=2,col='red')
lines(rdmsp2[1:25]*2.1,nplant_med_rad2[1:25],lty=1,lwd=2,col='black')
legend(900, 21, legend=c("BWB","MED-B","MED-default"), col=c("blue", "red","black"), lty=c(1,1,1), cex=1.5,lwd=3,bty="n")
text(90,18,cex=2,"a",font=2)

par(mar=c(4, 5, 2, 2))
plot(pco2bsp,nplant_bb_CO2,xlab=expression("Atmospheric CO"[2]* " concentration (ppm)"),ylab="nplant (plants/ha)",type="l", col="blue",ylim=c(0,20),cex.lab=1.5,lwd=2,cex.main=1.5,cex.axis=1.5)
lines(pco2msp,nplant_med_CO2,lty=1,lwd=2,col='red')
lines(pco2msp2,nplant_med_CO22,lty=1,lwd=2,col='black')
text(130,18,cex=2,"b",font=2)

par(mar=c(4, 5, 2, 2))
plot(dabsp[5:21],nplant_bb_hum[5:21],xlab=" VPD (Pa)",ylab="nplant (plants/ha)",type="l", col="blue",ylim=c(0,20),cex.lab=1.5,lwd=2,cex.main=1.5,cex.axis=1.5)
lines(damsp[5:21],nplant_med_hum[5:21],lty=1,lwd=2,col='red')
lines(damsp2[5:21],nplant_med_hum2[5:21],lty=1,lwd=2,col='black')
text(50, 18,cex=2,"c",font=2)

par(mar=c(4, 5, 2, 2))
plot(tempbsp-273.15,nplant_bb_tair,xlab=" Tair (\u00B0C)",ylab="nplant (plants/ha)",type="l", col="blue",ylim=c(0,20),cex.lab=1.5,lwd=2,cex.main=1.5,cex.axis=1.5)
lines(tempmsp-273.15,nplant_med_tair,lty=1,lwd=2,col='red')
lines(tempmsp2-273.15,nplant_med_tair2,lty=1,lwd=2,col='black')
text(9,18,cex=2,"d",font=2)

###############Tveg########
par(mfrow=c(2,2))
par(mar=c(4, 5, 2, 2))
plot(rdbsp[1:25]*2.1,tveg_rad[1:25],xlab=expression(paste("PAR (",mu,"mol ",m^-2," ",s^-1,")")),ylab="Leaf temperature (\u00B0C)",type="l",lwd=2, col="black",xlim=c(0,2000),ylim=c(20,30),cex.lab=1.5,cex.axis=1.5,cex.main=1.5)
text(70, 29,cex=2,"a",font=2)

par(mar=c(4, 5, 2, 2))
plot(pco2bsp,tveg_CO2,xlab=expression("Atmospheric CO"[2]* " concentration (ppm)"),ylab="Leaf temperature (\u00B0C)",type="l", col="black",ylim=c(20,30),lwd=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
text(150, 29,cex=2,"b",font=2)

par(mar=c(4, 5, 2, 2))
plot(dabsp[5:21],tveg_hum[5:21],xlab=" VPD (Pa)",ylab="Leaf temperature (\u00B0C)",type="l",xlim=c(0,2500),ylim=c(20,30), col="black",lwd=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
text(140, 29,cex=2,"c",font=2)

par(mar=c(4, 5, 2, 2))
plot(tempbsp-273.15,tveg_tair,xlab=" Air temperature (\u00B0C)",ylab="Leaf temperature (\u00B0C)",col="black",ylim=c(10,60),type="l",lwd=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
text(9,56,cex=2,"d",font=2)

