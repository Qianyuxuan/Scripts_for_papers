# new post-process script compared with Sensitivity_medlyn_model_fates.R

rm(list = ls())
library(ncdf4)
#medlyn
#ncidm <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/test/CLM5-FATES_1603309912_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #Tair 1019 g1=2.39
#ncidm2 <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/new/CLM5-FATES_1603310164_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #Tair 1019 g1=4.1

#ncidm <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/test/CLM5-FATES_1603247512_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #SOLAR 1019 g1=2.39
#ncidm2 <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/new/CLM5-FATES_1603247939_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #SOLAR 1019 g1=4.1

#ncidm <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/test/CLM5-FATES_1603318306_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #CO2 1019 g1=2.39
#ncidm2 <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/new/CLM5-FATES_1603316477_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #CO2 1019 g1=4.1

ncidm <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/test/CLM5-FATES_1603246954_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #QBOT 1019 g1=2.39
ncidm2 <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_medlyn/sensitivity0815/new/CLM5-FATES_1603246627_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #QBOT 1019 g1=4.1



#ball-berry

#ncidb <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sensitivity0815/new/CLM5-FATES_1603822812_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #Solar 1019
ncidb <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sensitivity0815/new/CLM5-FATES_1603823377_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #QBOT1019
#ncidb <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sensitivity0815/new/CLM5-FATES_1605756696_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #Tair1019
#ncidb <- nc_open('/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/results/medlyn_project/fates_bb/sensitivity0815/new/CLM5-FATES_1604332369_PA-SLZ.clm2.h0.2012-12-31-00000.nc') #CO21019

a0 =  6.11213476
a1 =  0.444007856
a2 =  0.143064234e-01
a3 =  0.264461437e-03
a4 =  0.305903558e-05
a5 =  0.196237241e-07
a6 =  0.892344772e-10
a7 = -0.373208410e-12
a8 =  0.209339997e-15

rhm<-ncvar_get(ncidm,'RH') 
gppm<-ncvar_get(ncidm,'GPP')*1000000/12 #change the unit to umol/m^2/s
gsmo<-ncvar_get(ncidm,'STOMATAL_COND_CNLF')
gsmeanm<-ncvar_get(ncidm,'C_STOMATA')/10^6 #change original unit umol/m^2/s to  mol/m^2/s
phmo<-ncvar_get(ncidm,'NET_C_UPTAKE_CNLF')
qbotm<-ncvar_get(ncidm,'QBOT')
tempm<-ncvar_get(ncidm,'TBOT') #unit:K
tvegm<-ncvar_get(ncidm,'TV')
qtm<-ncvar_get(ncidm,'QVEGT')#vegetation transpiration unit: mm/s
qem<-ncvar_get(ncidm,'QVEGE')#vegetation evaporation unit: mm/s
rdm<-ncvar_get(ncidm,'FSDS')#unit: W/m^2
rainm<-ncvar_get(ncidm,'RAIN')#unit: mm/s
nplantm<-ncvar_get(ncidm,'NPLANT_SCPF') #plants/ha
#nplantmpft<-ncvar_get(ncidm,'NPLANT_SCPF') #plants/ha
pco2m<-ncvar_get(ncidm,'PCO2')/101325*10^6  #change the unit from Pa to ppm
date<-ncvar_get(ncidm,'mdcur')
crownaream<-ncvar_get(ncidm,'CROWNAREA_CNLF')
nc_close( ncidm )
etm<-qtm+qem
phm<-phmo[1,]/crownaream[1,]/12*10^6  #change the unit to umol/m^2/s
gsm<-gsmo[1,]/crownaream[1,]/10^6     #change the unit to mol/m^2/s
tdm<-tempm-273.15
es_mb  = a0 + tdm*(a1 + tdm*(a2 + tdm*(a3 + tdm*(a4 + tdm*(a5 + tdm*(a6 + tdm*(a7 + tdm*a8))))))) 
Dam<-((100 - rhm)/100) * es_mb*100 # unit is Pa

rhm2<-ncvar_get(ncidm2,'RH') 
gppm2<-ncvar_get(ncidm2,'GPP')*1000000/12 #change the unit to umol/m^2/s
gsmo2<-ncvar_get(ncidm2,'STOMATAL_COND_CNLF')  
phmo2<-ncvar_get(ncidm2,'NET_C_UPTAKE_CNLF')
qbotm2<-ncvar_get(ncidm2,'QBOT')
tempm2<-ncvar_get(ncidm2,'TBOT') #unit:K 
qtm2<-ncvar_get(ncidm2,'QVEGT')#vegetation transpiration unit: mm/s
qem2<-ncvar_get(ncidm2,'QVEGE')#vegetation evaporation unit: mm/s
rdm2<-ncvar_get(ncidm2,'FSDS')#unit: W/m^2
rainm2<-ncvar_get(ncidm2,'RAIN')#unit: mm/s
nplantm2<-ncvar_get(ncidm2,'NPLANT_SCPF') #plants/ha
#nplantmpft<-ncvar_get(ncidm,'NPLANT_SCPF') #plants/ha
pco2m2<-ncvar_get(ncidm2,'PCO2')/101325*10^6  #change the unit from Pa to ppm
crownaream2<-ncvar_get(ncidm2,'CROWNAREA_CNLF')
nc_close( ncidm2 )
etm2<-qtm2+qem2
phm2<-phmo2[1,]/crownaream2[1,]/12*10^6    #change the unit to umol/m^2/s
gsm2<-gsmo2[1,]/crownaream2[1,]/10^6        #change the unit to mol/m^2/s
tdm2<-tempm2-273.15
es_mb2 = a0 + tdm2*(a1 + tdm2*(a2 + tdm2*(a3 + tdm2*(a4 + tdm2*(a5 + tdm2*(a6 + tdm2*(a7 + tdm2*a8))))))) 
Dam2<-((100 - rhm2)/100) * es_mb2*100

rhb<-ncvar_get(ncidb,'RH') 
gppb<-ncvar_get(ncidb,'GPP')*1000000/12 #change the unit to umol/m^2/s
gsbo<-ncvar_get(ncidb,'STOMATAL_COND_CNLF')  #change the unit to mol/m^2/s
gsmeanb<-ncvar_get(ncidb,'C_STOMATA')/10^6 #change original unit umol/m^2/s to  mol/m^2/s
phbo<-ncvar_get(ncidb,'NET_C_UPTAKE_CNLF')
qbotb<-ncvar_get(ncidb,'QBOT')
tempb<-ncvar_get(ncidb,'TBOT') #unit:K
qtb<-ncvar_get(ncidb,'QVEGT')#unit: mm/s
qeb<-ncvar_get(ncidb,'QVEGE')#unit: mm/s
rdb<-ncvar_get(ncidb,'FSDS')#unit: W/m^2
rainb<-ncvar_get(ncidb,'RAIN')#unit: mm/s
nplantb<-ncvar_get(ncidb,'NPLANT_SCPF') #plants/ha
#nplantbpft<-ncvar_get(ncidb,'NPLANT_SCPF') #plants/ha
pco2b<-ncvar_get(ncidb,'PCO2')/101325*1000000  #change the unit from Pa to ppm
#fldsb<-ncvar_get(ncidb,'FLDS')
date<-ncvar_get(ncidb,'mdcur')
crownareab<-ncvar_get(ncidb,'CROWNAREA_CNLF')
nc_close( ncidb )
etb<-qtb+qeb
phb<-phbo[1,]/crownareab[1,]/12*10^6    #change the unit to umol/m^2/s
gsb<-gsbo[1,]/crownareab[1,]/10^6        #change the unit to mol/m^2/s
tdb<-tempb-273.15
esb_mb  = a0 + tdb*(a1 + tdb*(a2 + tdb*(a3 + tdb*(a4 + tdb*(a5 + tdb*(a6 + tdb*(a7 + tdb*a8))))))) 
Dab<-((100 - rhb)/100) * esb_mb*100 # unit is Pa

plot(1:720,gsm[1:720],xlab="Hour since 2013-01-01",ylab="Stomatal conductance (mol/m^2/s)")
plot(1:720,phm[1:720],xlab="Hour since 2013-01-01",ylab="Stomatal conductance (mol/m^2/s)")
plot(1:720,gsb[1:720],xlab="Hour since 2013-01-01",ylab="Stomatal conductance (mol/m^2/s)")

plot(1:720,gppm[1:720],xlab="Hour since 2013-01-01",ylab="GPP (umol/m^2/s)")
plot(1:720,gppb[1:720],xlab="Hour since 2013-01-01",ylab="GPP (umol/m^2/s)")

plot(4:720,tempm[4:720]-273.15,xlab="Hour since 2013-01-01",ylab="Temperature (\u00B0C)",type="l",col="blue")
plot(1:720,rainm[1:720],xlab="Hour since 2013-01-01",ylab="Precipitation (mm/s)",type="l",col="blue")
plot(1:720,rdm[1:720],xlab="Hour since 2013-01-01",ylab="Incident solar radiation (W/m^2)",type="l",col="blue")
plot(1:720,rdb[1:720],xlab="Hour since 2013-01-01",ylab="Incident solar radiation (W/m^2)",type="l",col="blue")
plot(1:720,rhm[1:720],xlab="Hour since 2013-01-01",ylab="Relative humidity",type="l",col="blue")
plot(1:720,pco2m[1:720],xlab="Hour since 2013-01-01",ylab="CO2 concentration",type="l",col="blue")
plot(1:720,nplantm[4,1:720],xlab="Hour since 2013-01-01",ylab="number of plants per hectare in each size x age class",type="l",col="blue")

plot(tempm[2:600]-273,rhm[2:600],xlab="Temperature (\u00B0C)",ylab="VPD (Pa)")
plot(rdm[1:720],gsm[1:720],xlab="Incident solar radiation (W/m^2)",ylab="Stomatal conductance (mol/m^2/s)")

plot(1:720,qbotm[1:720])
plot(1:720,qbotb[1:720])

plot(1:720,Dam[1:720])

plot(Dam[1:720],gsm[1:720])
plot(tempm[1:720],rhm[1:720])
plot(tempm[1:720],rhb[1:720])
plot(tempm[1:720],Dam[1:720])
plot(tempb[1:720],Dab[1:720])
plot(tempm[1:720],rainm[1:720])
plot(tempm[1:720],rdm[1:720])

############gs response to VPD######
damdur<-Dam[32:730]
rdmdur<-rdm[32:730]
tempmdur<-tempm[32:730]
tvegmdur<-tvegm[32:730]
pco2mdur<-pco2m[32:730]
rhmdur<-rhm[32:730]
gsmdur<-gsm[32:730]
phmdur<-phm[32:730]
gppmdur<-gppm[32:730]
etmdur<-etm[32:730]
nplantmsize<-nplantm[10,32:730]
damsp<-c(rep(NA,21))  #only damdur[1:270] are used when dam decases linearly,after hour 270, VPD is kept as 0
gsmsp<-c(rep(NA,21))
phmsp<-c(rep(NA,21))
gppmsp<-c(rep(NA,21))
etmsp<-c(rep(NA,21))
pco2msp<-c(rep(NA,21))
tempmsp<-c(rep(NA,21))
tvegmsp<-c(rep(NA,21))
rdmsp<-c(rep(NA,21))
rhmsp<-c(rep(NA,21))
nplantmsizesp<-c(rep(NA,21))
for (i in 1:21){
  damsp[i]<-damdur[12+(i-1)*24]      
  gsmsp[i]<-gsmdur[12+(i-1)*24]
  tempmsp[i]<-tempmdur[12+(i-1)*24]
  tvegmsp[i]<-tvegmdur[12+(i-1)*24]
  phmsp[i]<-phmdur[12+(i-1)*24]
  pco2msp[i]<-pco2mdur[12+(i-1)*24]
  rhmsp[i]<-rhmdur[12+(i-1)*24]
  gppmsp[i]<-gppmdur[12+(i-1)*24]
  etmsp[i]<-etmdur[12+(i-1)*24]
  nplantmsizesp[i]<-nplantmsize[12+(i-1)*24]
  rdmsp[i]<-rdmdur[12+(i-1)*24]          #PAR is about 1500 μmol m-2s-1 PPFD
}

damdur2<-Dam2[32:730]
tempmdur2<-tempm2[32:730]
pco2mdur2<-pco2m2[32:730]
rdmdur2<-rdm2[32:730]
gsmdur2<-gsm2[32:730]
phmdur2<-phm2[32:730]
gppmdur2<-gppm2[32:730]
etmdur2<-etm2[32:730]
nplantmsize2<-nplantm2[10,32:730]
damsp2<-c(rep(NA,21))  #only damdur[1:270] are used when dam decases linearly,after hour 270, VPD is kept as 0
gsmsp2<-c(rep(NA,21))
pco2msp2<-c(rep(NA,21))
tempmsp2<-c(rep(NA,21))
phmsp2<-c(rep(NA,21))
gppmsp2<-c(rep(NA,21))
etmsp2<-c(rep(NA,21))
rdmsp2<-c(rep(NA,21))
nplantmsizesp2<-c(rep(NA,21))
for (i in 1:21){
  damsp2[i]<-damdur2[12+(i-1)*24]      
  gsmsp2[i]<-gsmdur2[12+(i-1)*24]
  tempmsp2[i]<-tempmdur2[12+(i-1)*24]
  pco2msp2[i]<-pco2mdur2[12+(i-1)*24]
  phmsp2[i]<-phmdur2[12+(i-1)*24]
  gppmsp2[i]<-gppmdur2[12+(i-1)*24]
  etmsp2[i]<-etmdur2[12+(i-1)*24]
  nplantmsizesp2[i]<-nplantmsize2[12+(i-1)*24]
  rdmsp2[i]<-rdmdur2[12+(i-1)*24]          #PAR is about 1500 μmol m-2s-1 PPFD
}

dabdur<-Dab[32:730]
rdbdur<-rdb[32:730]
tempbdur<-tempb[32:730]
pco2bdur<-pco2b[32:730]
gsbdur<-gsb[32:730]
phbdur<-phb[32:730]
gppbdur<-gppb[32:730]
etbdur<-etb[32:730]
nplantbsize<-nplantb[10,32:730]
dabsp<-c(rep(NA,21))
rdbsp<-c(rep(NA,21))
tempbsp<-c(rep(NA,21))
pco2bsp<-c(rep(NA,21))
gsbsp<-c(rep(NA,21))
phbsp<-c(rep(NA,21))
gppbsp<-c(rep(NA,21))
etbsp<-c(rep(NA,21))
nplantbsizesp<-c(rep(NA,21))
for (i in 1:21){
  dabsp[i]<-dabdur[12+(i-1)*24]
  rdbsp[i]<-rdbdur[12+(i-1)*24]
  tempbsp[i]<-tempbdur[12+(i-1)*24]
  pco2bsp[i]<-pco2bdur[12+(i-1)*24]
  gsbsp[i]<-gsbdur[12+(i-1)*24]
  phbsp[i]<-phbdur[12+(i-1)*24]
  gppbsp[i]<-gppbdur[12+(i-1)*24]
  etbsp[i]<-etbdur[12+(i-1)*24]
  nplantbsizesp[i]<-nplantbsize[12+(i-1)*24]
}

plot(1:21,pco2bsp,type="l",col="red",xlab="Hour during sensitivity run",ylab="CO2 concentration (ppmv)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:21,rdmsp2*2.1,type="l",col="red",xlab="Hour during sensitivity run",ylab="Radiation(μmol/m\U00B2/s PPFD)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2,ylim=c(0,1550))
plot(1:21,dabsp,type="l",col="red",xlab="Hour during sensitivity run",ylab="VPD (kPa)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:21,tempbsp-273.15,type="l",col="red",xlab="Hour during sensitivity run",ylab="Temperature (\u00B0C)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(damsp,tvegmsp-273.15,xlab="Vapor Pressure Deficit (Pa)",ylab="Leaf Temperature (\u00B0C)",type="l",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2,col="red",main="VPD")

plot(dabsp,gsbsp,xlab=" Vapor Pressure Deficit (Pa)",ylab="gs (mol/m\U00B2/s)",type="b",xlim=c(0,3000),ylim=c(0,0.4), pch=19,col="blue",main="Stomatal response to VPD",cex.lab=1.5,cex.main=2,cex.axis=1.5)
lines(damsp,gsmsp,pch=19, type="b",lty=2,col='red')
lines(damsp2,gsmsp2,pch=19, type="b",lty=2,col='green')
text(140, 0.065,cex=2,"c",font=2)

plot(dabsp,phbsp,xlab=" Vapor Pressure Deficit (Pa)",ylab="Anet (\U003BCmol/m\U00B2/s)",type="b",xlim=c(0,3000),ylim=c(0,10), pch=19,col="blue",main="Net Carbon Uptake response to VPD",cex.lab=1.5,cex.main=2,cex.axis=1.5)
lines(damsp,phmsp,pch=19, type="b",lty=2,col='red')
lines(damsp2,phmsp2,pch=19, type="b",lty=2,col='green')
text(140, 0.065,cex=2,"c",font=2)

plot(damsp,etmsp,xlab=" Vapor Pressure Deficit (Pa)",ylab="ET (mm/s)",type="b", pch=19,col="blue",ylim=c(0,0.0004),main="Evapotranspiration response to VPD")
lines(dabsp,etbsp,pch=19, type="b",lty=2,col='red')
legend(1250, 0.00035,legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1)

plot(damsp,gppmsp,xlab=" Vapor Pressure Deficit (Pa)",ylab="GPP (umol/m^2/s)",type="b", pch=19,col="blue",main="GPP response to VPD",ylim=c(1,19.5))
lines(dabsp,gppbsp,pch=19, type="b",lty=2,col='red')
legend(1250, 19, legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1)

plot(damsp,nplantmsizesp,xlab=" Vapor Pressure Deficit (Pa)",ylab="Number of plants per hectare (plants/ha)",type="b", pch=19,col="blue",ylim=c(1,20),main="Number of plants response to VPD")
lines(dabsp,nplantbsizesp,pch=19, type="b",lty=2,col='red')
legend(1250, 18, legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1)

save(tvegmsp,dabsp,gsbsp,damsp,gsmsp,phbsp,phmsp,phmsp2,damsp2,gsmsp2,gppbsp,gppmsp,gppmsp2,etbsp,etmsp,etmsp2,nplantbsizesp,nplantmsizesp,nplantmsizesp2,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_Humd.RData')

###############gs response to temperature###############

tempmdur<-tempm[32:685]
tvegmdur<-tvegm[32:685]
pco2mdur<-pco2m[32:685]
gppmdur<-gppm[32:685]
gsmdur<-gsm[32:685]
gsmeanmdur<-gsmeanm[32:685]
phmdur<-phm[32:685]
rdmdur<-rdm[32:685]
etmdur<-etm[32:685]
damdur<-Dam[32:685]
nplantmsize<-nplantm[10,32:685]
tempmsp<-c(rep(NA,28))
tvegmsp<-c(rep(NA,28))
gsmsp<-c(rep(NA,28))
phmsp<-c(rep(NA,28))
gppmsp<-c(rep(NA,28))
etmsp<-c(rep(NA,28))
pco2msp<-c(rep(NA,28))
damsp<-c(rep(NA,28))
nplantmsizesp<-c(rep(NA,28))
rdmsp<-c(rep(NA,28))
gsmeanmsp<-c(rep(NA,28))
for (i in 1:28){
  tempmsp[i]<-tempmdur[12+(i-1)*24]  #PAR is about 1500 μmol m-2s-1 PPFD
  tvegmsp[i]<-tvegmdur[12+(i-1)*24]
  gsmsp[i]<-gsmdur[12+(i-1)*24]
  gsmeanmsp[i]<-gsmeanmdur[12+(i-1)*24]
  phmsp[i]<-phmdur[12+(i-1)*24]        #PAR is about 1690 umol for smoother plot for ph for Ball-berry
  gppmsp[i]<-gppmdur[12+(i-1)*24]
  nplantmsizesp[i]<-nplantmsize[12+(i-1)*24]
  rdmsp[i]<-rdmdur[12+(i-1)*24]
  etmsp[i]<-etmdur[12+(i-1)*24]
  damsp[i]<-damdur[12+(i-1)*24]
  pco2msp[i]<-pco2mdur[12+(i-1)*24]
}

tempmdur2<-tempm2[32:685]
damdur2<-Dam2[32:685]
pco2mdur2<-pco2m2[32:685]
gppmdur2<-gppm2[32:685]
gsmdur2<-gsm2[32:685]
phmdur2<-phm2[32:685]
rdmdur2<-rdm2[32:685]
etmdur2<-etm2[32:685]
damdur2<-Dam2[32:685]
nplantmsize2<-nplantm2[10,32:685]
tempmsp2<-c(rep(NA,28))
pco2msp2<-c(rep(NA,28))
damsp2<-c(rep(NA,28))
gsmsp2<-c(rep(NA,28))
phmsp2<-c(rep(NA,28))
gppmsp2<-c(rep(NA,28))
etmsp2<-c(rep(NA,28))
nplantmsizesp2<-c(rep(NA,28))
rdmsp2<-c(rep(NA,28))
for (i in 1:28){
  tempmsp2[i]<-tempmdur2[12+(i-1)*24]  #PAR is about 1500 μmol m-2s-1 PPFD
  gsmsp2[i]<-gsmdur2[12+(i-1)*24]
  phmsp2[i]<-phmdur2[12+(i-1)*24]
  gppmsp2[i]<-gppmdur2[12+(i-1)*24]
  nplantmsizesp2[i]<-nplantmsize2[12+(i-1)*24]
  rdmsp2[i]<-rdmdur2[12+(i-1)*24]
  etmsp2[i]<-etmdur2[12+(i-1)*24]
  pco2msp2[i]<-pco2mdur2[12+(i-1)*24]
  damsp2[i]<-damdur2[12+(i-1)*24]
}

tempbdur<-tempb[32:685]
rdbdur<-rdb[32:685]
pco2bdur<-pco2b[32:685]
dabdur<-Dab[32:685]
gppbdur<-gppb[32:685]
gsbdur<-gsb[32:685]
gsmeanbdur<-gsmeanb[32:685]
phbdur<-phb[32:685]
nplantbsize<-nplantb[10,32:685]
etbdur<-etb[32:685]
tempbsp<-c(rep(NA,28))
pco2bsp<-c(rep(NA,28))
gsbsp<-c(rep(NA,28))
phbsp<-c(rep(NA,28))
etbsp<-c(rep(NA,28))
gppbsp<-c(rep(NA,28))
dabsp<-c(rep(NA,28))
rdbsp<-c(rep(NA,28))
nplantbsizesp<-c(rep(NA,28))
gsmeanbsp<-c(rep(NA,28))
for (i in 1:28){
  tempbsp[i]<-tempbdur[12+(i-1)*24]    
  gsbsp[i]<-gsbdur[12+(i-1)*24]
  gsmeanbsp[i]<-gsmeanbdur[12+(i-1)*24]
  phbsp[i]<-phbdur[12+(i-1)*24]
  gppbsp[i]<-gppbdur[12+(i-1)*24]
  nplantbsizesp[i]<-nplantbsize[12+(i-1)*24]
  etbsp[i]<-etbdur[12+(i-1)*24]
  dabsp[i]<-dabdur[12+(i-1)*24]
  pco2bsp[i]<-pco2bdur[12+(i-1)*24]
  rdbsp[i]<-rdbdur[12+(i-1)*24]
}

plot(1:28,pco2bsp,type="l",col="red",xlab="Hour during sensitivity run",ylab="CO2 concentration (ppmv)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:28,rdbsp*2.1,type="l",col="red",xlab="Hour during sensitivity run",ylab="Radiation(μmol/m\U00B2/s PPFD)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2,ylim=c(0,1700))
plot(1:28,dabsp,type="l",col="red",xlab="Hour during sensitivity run",ylab="VPD (Pa)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2,ylim=c(0,3000))
plot(1:28,tempbsp-273.15,type="l",col="red",xlab="Hour during sensitivity run",ylab="Temperature (\u00B0C)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)

plot(tempmsp-273.15,tvegmsp-273.15,type="l",col="red",xlab="Air Temperature (\u00B0C)",ylab="Leaf Temperature (\u00B0C)",main="Tair",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
lines(seq(0,50,by=10), seq(0,50,by=10),type = "l", lwd=2,col="black",lty = 2)
text(45,42,"1:1 line",cex=1.5,font=2)

plot(tempbsp-273.15,gsbsp,xlab=" Temperature (\u00B0C)",ylab="gs (mol/m\U00B2/s)",type="b", pch=19,col="blue",ylim=c(0,0.4),main="Stomatal response to temperature",cex.lab=1.5,cex.main=2,cex.axis=1.5)
lines(tempmsp-273.15,gsmsp,pch=19, type="b",lty=2,col='red') 
lines(tempmsp2-273.15,gsmsp2,pch=19, type="b",lty=2,col='green') 
text(9,0.09,cex=2,"d",font=2)

plot(tempbsp-273.15,phbsp,xlab=" Temperature (\u00B0C)",ylab="Anet (\U003BCmol/m\U00B2/s)",type="b", pch=19,col="blue",ylim=c(0,10),main="Net Carbon Uptake response to temperature",cex.lab=1.5,cex.main=2,cex.axis=1.5)
lines(tempmsp-273.15,phmsp,pch=19, type="b",lty=2,col='red') 
lines(tempmsp2-273.15,phmsp2,pch=19, type="b",lty=2,col='green') 
text(9,0.09,cex=2,"d",font=2)

plot(tempmsp-273.15,etmsp,xlab=" Temperature (\u00B0C)",ylab="ET (mm/s)",type="b", pch=19,col="blue",ylim=c(0,0.0002),main="Evapotranspiration response to temperature",cex.lab=1.2,cex.main=1.5)
lines(tempbsp-273.15,etbsp,pch=19, type="b",lty=2,col='red')
legend(290, 0.00018,legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1.2,bty="n")
text(9,0.00018,cex=1.5,"d",font=2)

plot(tempmsp,gppmsp,xlab=" Temperature (K)",ylab="GPP (umol/m^2/s)",type="b", pch=19,col="blue",main="GPP response to temperature",ylim=c(0,32))
lines(tempbsp,gppbsp,pch=19, type="b",lty=2,col='red')
legend(290, 21, legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1.5,bty="n")

plot(tempmsp-273.15,nplantmsizesp,xlab=" Temperature (K)",ylab="Number of plants per hectare (plants/ha)",type="b", pch=19,col="blue",ylim=c(0,20),main="Number of plants response to temperature")
lines(tempbsp-273.15,nplantbsizesp,pch=19, type="b",lty=2,col='red')
legend(290, 38, legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1)

save(tvegmsp,tempbsp,gsbsp,tempmsp,gsmsp,phbsp,phmsp,phmsp2,tempmsp2,gsmsp2,gppbsp,gppmsp,gppmsp2,etbsp,etmsp,etmsp2,nplantbsizesp,nplantmsizesp,nplantmsizesp2,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_Tair.RData')
####################gs response to radiation######
rdmdur<-rdm[32:730]
pco2mdur<-pco2m[32:730]
tempdur<-tempm[32:730]
tvegmdur<-tvegm[32:730]
rhmdur<-rhm[32:730]
damdur<-Dam[32:730]
gsmdur<-gsm[32:730]
phmdur<-phm[32:730]
gppmdur<-gppm[32:730]
etmdur<-etm[32:730]
nplantmsize<-nplantm[10,32:730]
rdmsp<-c(rep(NA,30))
gsmsp<-c(rep(NA,30))
phmsp<-c(rep(NA,30))
gppmsp<-c(rep(NA,30))
tempmsp<-c(rep(NA,30))
tvegmsp<-c(rep(NA,30))
damsp<-c(rep(NA,30))
etmsp<-c(rep(NA,30))
rhmsp<-c(rep(NA,30))
pco2msp<-c(rep(NA,30))
nplantmsizesp<-c(rep(NA,30))
for (i in 1:30){
  rdmsp[i]<-rdmdur[11+(i-1)*24]
  rhmsp[i]<-rhmdur[11+(i-1)*24]
  gsmsp[i]<-gsmdur[11+(i-1)*24]
  tempmsp[i]<-tempdur[11+(i-1)*24]
  tvegmsp[i]<-tvegmdur[11+(i-1)*24]
  damsp[i]<-damdur[11+(i-1)*24]
  phmsp[i]<-phmdur[11+(i-1)*24]
  gppmsp[i]<-gppmdur[11+(i-1)*24]
  etmsp[i]<-etmdur[11+(i-1)*24]
  pco2msp[i]<-pco2mdur[11+(i-1)*24]
  nplantmsizesp[i]<-nplantmsize[11+(i-1)*24]
}

rdmdur2<-rdm2[32:730]
tempdur2<-tempm2[32:730]
pco2mdur2<-pco2m2[32:730]
gsmdur2<-gsm2[32:730]
damdur2<-Dam2[32:730]
phmdur2<-phm2[32:730]
gppmdur2<-gppm2[32:730]
etmdur2<-etm2[32:730]
nplantmsize2<-nplantm2[10,32:730]
rdmsp2<-c(rep(NA,30))
gsmsp2<-c(rep(NA,30))
tempmsp2<-c(rep(NA,30))
phmsp2<-c(rep(NA,30))
pco2msp2<-c(rep(NA,30))
damsp2<-c(rep(NA,30))
gppmsp2<-c(rep(NA,30))
etmsp2<-c(rep(NA,30))
nplantmsizesp2<-c(rep(NA,30))
for (i in 1:30){
  rdmsp2[i]<-rdmdur2[11+(i-1)*24]
  tempmsp2[i]<-tempdur2[11+(i-1)*24]
  damsp2[i]<-damdur2[11+(i-1)*24]
  gsmsp2[i]<-gsmdur2[11+(i-1)*24]
  phmsp2[i]<-phmdur2[11+(i-1)*24]
  gppmsp2[i]<-gppmdur2[11+(i-1)*24]
  etmsp2[i]<-etmdur2[11+(i-1)*24]
  pco2msp2[i]<-pco2mdur2[11+(i-1)*24]
  nplantmsizesp2[i]<-nplantmsize2[11+(i-1)*24]
}

rdbdur<-rdb[32:730]
tempbdur<-tempb[32:730]
pco2bdur<-pco2b[32:730]
gsbdur<-gsb[32:730]
dabdur<-Dab[32:730]
phbdur<-phb[32:730]
gppbdur<-gppb[32:730]
etbdur<-etb[32:730]
nplantbsize<-nplantb[10,32:730]
rdbsp<-c(rep(NA,30))
tempbsp<-c(rep(NA,30))
gsbsp<-c(rep(NA,30))
phbsp<-c(rep(NA,30))
gppbsp<-c(rep(NA,30))
dabsp<-c(rep(NA,30))
etbsp<-c(rep(NA,30))
pco2bsp<-c(rep(NA,30))
nplantbsizesp<-c(rep(NA,30))
for (i in 1:30){
  rdbsp[i]<-rdbdur[11+(i-1)*24]
  tempbsp[i]<-tempbdur[11+(i-1)*24]
  dabsp[i]<-dabdur[11+(i-1)*24]
  gsbsp[i]<-gsbdur[11+(i-1)*24]
  phbsp[i]<-phbdur[11+(i-1)*24]
  gppbsp[i]<-gppbdur[11+(i-1)*24]
  etbsp[i]<-etbdur[11+(i-1)*24]
  pco2bsp[i]<-pco2bdur[11+(i-1)*24]
  nplantbsizesp[i]<-nplantbsize[11+(i-1)*24]
}

plot(1:30,pco2bsp,type="l",col="red",xlab="Hour during sensitivity run",ylab="CO2 concentration (ppmv)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:30,rdbsp*2.1,type="l",col="red",xlab="Hour during sensitivity run",ylab="Radiation(μmol/m\U00B2/s PPFD)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:30,dabsp,type="l",col="red",xlab="Hour during sensitivity run",ylab="VPD (kPa)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:30,tempbsp-273.15,type="l",col="red",xlab="Hour during sensitivity run",ylab="Temperature (\u00B0C)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(rdmsp*2.1,tvegmsp-273.15,type="l",col="red",xlab="Incident solar radiation (μmol/m\U00B2/s PPFD)",ylab="Leaf Temperature (\u00B0C)",main="Radi",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)

plot(rdbsp*2.1,gsbsp,xlab="Incident solar radiation (μmol/m\U00B2/s PPFD)",ylab="gs (mol/m\U00B2/s)",type="b", pch=19,col="blue",ylim=c(0,0.4),main="Stomatal response to radiation",cex.lab=1.5,cex.axis=1.5,cex.main=2)
lines(rdmsp*2.1,gsmsp,pch=19, type="b",lty=2,col='red')  
lines(rdmsp2*2.1,gsmsp2,pch=19, type="b",lty=2,col='green')  
legend(1700, 0.4, legend=c("Ball-Berry","Medlyn_equiv","Medlyn_default"), col=c("blue", "red","green"),pch=c(16,16,16), lty=c(2,2,2), cex=1.5,lwd=2.5,bty="n")
text(70, 0.4,cex=2,"a",font=2)

plot(rdbsp*2.1,phbsp,xlab="Incident solar radiation (μmol/m\U00B2/s PPFD)",ylab="Anet (\U003BCmol/m\U00B2/s)",type="b", pch=19,col="blue",ylim=c(0,15),main="net carbon uptake response to radiation",cex.lab=1.5,cex.axis=1.5,cex.main=2)
lines(rdmsp*2.1,phmsp,pch=19, type="b",lty=2,col='red')  
lines(rdmsp2*2.1,phmsp2,pch=19, type="b",lty=2,col='green')  
legend(1500, 0.15, legend=c("Ball-Berry","Medlyn_equiv","Medlyn_default"), col=c("blue", "red","green"),pch=c(16,16,16), lty=c(2,2,2), cex=1.5,lwd=2.5,bty="n")
text(70, 0.14,cex=2,"a",font=2)

plot(rdbsp[1:27]*2.1,gppbsp[1:27],xlab="Incident solar radiation (μmol m-2s-1 PPFD)",ylab="GPP (umol/m^2/s)",type="b", pch=19,col="blue",ylim=c(0,60),main="GPP response to radiation")
lines(rdmsp[1:27]*2.1,gppmsp[1:27],pch=19, type="b",lty=2,col='red')
lines(rdmsp2[1:27]*2.1,gppmsp2[1:27],pch=19, type="b",lty=2,col='green')
legend(900*2.1, 50, legend=c("Ball-Berry","Medlyn_equiv","Medlyn_default"), col=c("blue", "red","green"), pch=c(16,16,16), lty=c(2,2,2), cex=1.5,lwd=2.5,bty="n")

plot(rdbsp[1:27]*2.1,etbsp[1:27],xlab="Incident solar radiation (μmol m-2s-1 PPFD)",ylab="ET (mm/s)",type="b", pch=19,col="blue",ylim=c(0,0.0002),main="Evapotranspiration response to radiation")  
lines(rdmsp[1:27]*2.1,etmsp[1:27],pch=19, type="b",lty=2,col='red')
lines(rdmsp2[1:27]*2.1,etmsp2[1:27],pch=19, type="b",lty=2,col='green')
legend(900*2.1, 0.00018, legend=c("Ball-Berry","Medlyn_equiv","Medlyn_default"), col=c("blue", "red","green"), lty=1:2, cex=1)

plot(rdbsp*2.1,nplantbsizesp,xlab="Incident solar radiation (μmol m-2s-1 PPFD)",ylab="Number of plants per hectare (plants/ha)",type="b", pch=19,col="blue",ylim=c(1,20),main="Number of plants response to radiation")
lines(rdmsp*2.1,nplantmsizesp,pch=19, type="b",lty=2,col='red')
lines(rdmsp2*2.1,nplantmsizesp2,pch=19, type="b",lty=2,col='green')
legend(900*2.1, 38, legend=c("Ball-Berry","Medlyn_equiv","Medlyn_default"), col=c("blue", "red","green"), lty=1:2, cex=1)

save(tvegmsp,rdbsp,gsbsp,rdmsp,gsmsp,phbsp,phmsp,phmsp2,rdmsp2,gsmsp2,gppbsp,gppmsp,gppmsp2,etbsp,etmsp,etmsp2,nplantbsizesp,nplantmsizesp,nplantmsizesp2,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_Radi.RData')
######################gs response to CO2############
pco2mdur<-pco2m[32:730]
tempmdur<-tempm[32:730]
tvegmdur<-tvegm[32:730]
rdmdur<-rdm[32:730]
gsmdur<-gsm[32:730]
phmdur<-phm[32:730]
gppmdur<-gppm[32:730]
etmdur<-etm[32:730]
damdur<-Dam[32:730]
nplantmsize<-nplantm[10,32:730]
pco2msp<-c(rep(NA,30))
gsmsp<-c(rep(NA,30))
phmsp<-c(rep(NA,30))
gppmsp<-c(rep(NA,30))
etmsp<-c(rep(NA,30))
rdmsp<-c(rep(NA,30))
tempmsp<-c(rep(NA,30))
tvegmsp<-c(rep(NA,30))
damsp<-c(rep(NA,30))
nplantmsizesp<-c(rep(NA,30))
for (i in 1:30){
  pco2msp[i]<-pco2mdur[12+(i-1)*24] 
  gsmsp[i]<-gsmdur[12+(i-1)*24]
  phmsp[i]<-phmdur[12+(i-1)*24]
  gppmsp[i]<-gppmdur[12+(i-1)*24]
  etmsp[i]<-etmdur[12+(i-1)*24]
  rdmsp[i]<-rdmdur[12+(i-1)*24]           #PAR is about 1500 μmol m-2s-1 PPFD
  nplantmsizesp[i]<-nplantmsize[12+(i-1)*24]
  damsp[i]<-damdur[12+(i-1)*24]
  tempmsp[i]<-tempmdur[12+(i-1)*24]
  tvegmsp[i]<-tvegmdur[12+(i-1)*24]
}

pco2mdur2<-pco2m2[32:730]
tempmdur2<-tempm2[32:730]
rdmdur2<-rdm2[32:730]
gsmdur2<-gsm2[32:730]
phmdur2<-phm2[32:730]
gppmdur2<-gppm2[32:730]
etmdur2<-etm2[32:730]
damdur2<-Dam2[32:730]
nplantmsize2<-nplantm2[10,32:730]
pco2msp2<-c(rep(NA,30))
gsmsp2<-c(rep(NA,30))
phmsp2<-c(rep(NA,30))
gppmsp2<-c(rep(NA,30))
etmsp2<-c(rep(NA,30))
rdmsp2<-c(rep(NA,30))
damsp2<-c(rep(NA,30))
tempmsp2<-c(rep(NA,30))
nplantmsizesp2<-c(rep(NA,30))
for (i in 1:30){
  pco2msp2[i]<-pco2mdur2[12+(i-1)*24]
  tempmsp2[i]<-tempmdur[12+(i-1)*24]
  damsp2[i]<-damdur2[12+(i-1)*24]
  gsmsp2[i]<-gsmdur2[12+(i-1)*24]
  phmsp2[i]<-phmdur2[12+(i-1)*24]
  gppmsp2[i]<-gppmdur2[12+(i-1)*24]
  etmsp2[i]<-etmdur2[12+(i-1)*24]
  rdmsp2[i]<-rdmdur2[12+(i-1)*24]           #PAR is about 1500 μmol m-2s-1 PPFD
  nplantmsizesp2[i]<-nplantmsize2[12+(i-1)*24]
}

pco2bdur<-pco2b[32:730]
tempbdur<-tempb[32:730]
rdbdur<-rdb[32:730]
dabdur<-Dab[32:730]
gsbdur<-gsb[32:730]
phbdur<-phb[32:730]
gppbdur<-gppb[32:730]
etbdur<-etb[32:730]
nplantbsize<-nplantb[10,32:730]
pco2bsp<-c(rep(NA,30))
tempbsp<-c(rep(NA,30))
dabsp<-c(rep(NA,30))
gsbsp<-c(rep(NA,30))
phbsp<-c(rep(NA,30))
gppbsp<-c(rep(NA,30))
etbsp<-c(rep(NA,30))
rdbsp<-c(rep(NA,30))
nplantbsizesp<-c(rep(NA,30))
for (i in 1:30){
  pco2bsp[i]<-pco2bdur[12+(i-1)*24]
  tempbsp[i]<-tempbdur[12+(i-1)*24]
  dabsp[i]<-dabdur[12+(i-1)*24]
  rdbsp[i]<-rdbdur[12+(i-1)*24]
  gsbsp[i]<-gsbdur[12+(i-1)*24]
  phbsp[i]<-phbdur[12+(i-1)*24]
  gppbsp[i]<-gppbdur[12+(i-1)*24]
  etbsp[i]<-etbdur[12+(i-1)*24]
  nplantbsizesp[i]<-nplantbsize[12+(i-1)*24]
}

plot(1:30,pco2msp2,type="l",col="red",xlab="Hour during sensitivity run",ylab="CO2 concentration (ppmv)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:30,rdmsp2*2.1,type="l",col="red",xlab="Hour during sensitivity run",ylab="Radiation(μmol/m\U00B2/s PPFD)",ylim=c(0,1560),cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:30,damsp2,type="l",col="red",xlab="Hour during sensitivity run",ylab="VPD (kPa)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(1:30,tempmsp2-273.15,type="l",col="red",xlab="Hour during sensitivity run",ylab="Temperature (\u00B0C)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2)
plot(pco2msp,tvegmsp-273.15,type="l",col="red",xlab="Incident solar radiation (μmol/m\U00B2/s PPFD)",ylab="Leaf Temperature (\u00B0C)",cex.lab=1.5,cex.main=2,cex.axis=1.5,lwd=2,ylim=c(27,29),main="CO2")

plot(pco2bsp,gsbsp,xlab="CO2 concentration (ppmv)",ylab="gs (mol/m\U00B2/s)",type="b", pch=19,col="blue",ylim=c(0,0.2),main=paste("Stomatal response to CO2"),cex.lab=1.5,cex.main=2,cex.axis=1.5)
lines(pco2msp,gsmsp,pch=19, type="b",lty=2,col='red')
lines(pco2msp2,gsmsp2,pch=19, type="b",lty=2,col='green')
text(150, 0.075,cex=2,"b",font=2)

plot(pco2bsp,phbsp,xlab="CO2 concentration (ppmv)",ylab="Anet (\U003BCmol/m\U00B2/s)",type="b", pch=19,col="blue",ylim=c(0,10),main=paste("Anet response to CO2"),cex.lab=1.5,cex.main=2,cex.axis=1.5)
lines(pco2msp,phmsp,pch=19, type="b",lty=2,col='red')
lines(pco2msp2,phmsp2,pch=19, type="b",lty=2,col='green')
text(150, 9,cex=2,"b",font=2)

plot(pco2msp,gppmsp,xlab="CO2 concentration (ppmv)",ylab="GPP (umol/m^2/s)",type="b", pch=19,col="blue",ylim=c(0,60),main="GPP response to CO2")
lines(pco2bsp,gppbsp,pch=19, type="b",lty=2,col='red')
legend(750, 50, legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1)

plot(pco2msp,etmsp,xlab="CO2 concentration (ppmv)",ylab="ET (mm/s)",type="b", pch=19,col="blue",ylim=c(0,0.0002),main="Evapotranspiration response to CO2")
lines(pco2bsp,etbsp,pch=19, type="b",lty=2,col='red')
legend(750, 0.00018, legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1)

plot(pco2msp,nplantmsizesp,xlab="CO2 concentration (ppmv)",ylab="Number of plants per hectare (plants/ha)",type="b", pch=19,col="blue",ylim=c(0,20),main="Number of plants response to CO2")
lines(pco2bsp,nplantbsizesp,pch=19, type="b",lty=2,col='red')
legend(750, 38, legend=c("Medlyn", "Ball-Berry"), col=c("blue", "red"), lty=1:2, cex=1)

save(tvegmsp,pco2bsp,gsbsp,pco2msp,gsmsp,phbsp,phmsp,phmsp2,pco2msp2,gsmsp2,gppbsp,gppmsp,gppmsp2,etbsp,etmsp,etmsp2,nplantbsizesp,nplantmsizesp,nplantmsizesp2,file='/Users/qianyu/Documents/OneDrive - Brookhaven National Laboratory/NGEE-Tropics/codes/files/plot_CO2.RData')
