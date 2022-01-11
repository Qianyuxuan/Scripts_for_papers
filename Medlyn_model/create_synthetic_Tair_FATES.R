#to study the gs response to temperature with constant VPD for Medlyn model or constant RH for Ball-Berry model
rm(list = ls())
library(ncdf4)
ncid_old <- nc_open('/Volumes/data/Model_Data/cesm_input_datasets/single_point_synthetic_met/PA-SLZ/TPHWL_BB/datmdata/atm_forcing.datm7.GSWP3.0.5d.v1.c170516/TPHWL/clmforc.GSWP3.c2011.0.5x0.5.TPQWL.2013-01.nc' , write=TRUE )
psrf<-ncvar_get(ncid_old, "PSRF")
wind<-ncvar_get(ncid_old, "WIND")
qbot<-ncvar_get(ncid_old, "QBOT")
flds<-ncvar_get(ncid_old, "FLDS")
tair<-ncvar_get(ncid_old, "TBOT")
time<-ncvar_get(ncid_old,varid='time')
lon<-ncvar_get(ncid_old,varid='lon')
lat<-ncvar_get(ncid_old,varid='lat')
ncid_old <- ncvar_rename( ncid_old, "PSRF", "PSRFold" )
ncid_old <- ncvar_rename( ncid_old, "WIND", "WINDold" )
ncid_old <- ncvar_rename( ncid_old, "QBOT", "QBOTold" )
ncid_old <- ncvar_rename( ncid_old, "FLDS", "FLDSold" )
ncid_old <- ncvar_rename( ncid_old, "TBOT", "TBOTold" )
psrfnew<-c(rep(NA,248))
windnew<-c(rep(NA,248))
qbotnew<-c(rep(NA,248))
fldsnew<-c(rep(NA,248))
for (i in 1:248){
  psrfnew[i]<-mean(psrf,na.rm=TRUE)
  windnew[i]<-mean(wind,na.rm=TRUE)
  fldsnew[i]<-mean(flds,na.rm=TRUE)
}
xdim <- ncdim_def( 'lon', 'degreesE', 1 )
ydim <- ncdim_def( 'lat', 'degreesN', 1 )
tdim <- ncdim_def( 'time', 'Hour since 2013-01-01', time )
var_psrf <- ncvar_def( 'PSRF', 'Pa', longname="surface pressure at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
var_wind <- ncvar_def( 'WIND', 'm/s', longname="wind at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
var_flds <- ncvar_def( 'FLDS', 'W/m**2', longname="incident longwave radiation",list(xdim,ydim,tdim), 1.0E36)
ncid_old<-ncvar_add( ncid_old, var_psrf )	# NOTE this returns a modified netcdf file handle 
ncid_old<-ncvar_add( ncid_old, var_wind )
ncid_old<-ncvar_add( ncid_old, var_flds)
ncvar_put(ncid_old,var_psrf,psrfnew)
ncvar_put(ncid_old,var_wind,windnew)
ncvar_put(ncid_old,var_flds,fldsnew)


a0 =  6.11213476
a1 =  0.444007856
a2 =  0.143064234e-01
a3 =  0.264461437e-03
a4 =  0.305903558e-05
a5 =  0.196237241e-07
a6 =  0.892344772e-10
a7 = -0.373208410e-12
a8 =  0.209339997e-15

td<-seq(from = 5, to = 50, by = 0.1875)
td_k<-td+273.15
es_mb  = a0 + td*(a1 + td*(a2 + td*(a3 + td*(a4 + td*(a5 + td*(a6 + td*(a7 + td*a8))))))) #saturated vapor pressure, mb
es_pa = es_mb*100 #pa
p_pa<-101325
tair[1:229]<-td_k[13:241]

###VPD was fixed for Mendly model
VPD<-1000    #pa
RH<-1-VPD/es_pa             #VPD's unit is Pa
evair<-RH*es_pa
qair <- (0.622 * evair) / (p_pa - (0.378 * evair))
qbot[1:229]<-qair[13:241]

#es_Pecon=(6.112*exp((17.67*td)/(td+243.5)))*100

var_tair <- ncvar_def( 'TBOT', 'K', longname="temperature at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
var_qbot <- ncvar_def( 'QBOT', 'kg/kg', longname="specific humidity at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
ncid_old<-ncvar_add( ncid_old, var_tair )	# NOTE this returns a modified netcdf file handle 
ncid_old<-ncvar_add( ncid_old, var_qbot )	# NOTE this returns a modified netcdf file handle 
ncvar_put(ncid_old,var_tair,tair)
ncvar_put(ncid_old,var_qbot,qbot)
nc_close(ncid_old)

plot(tair-273.15,evair[13:241]/1000,type="l",lwd=2,col="red",xlab="Temperature (\u00B0C)",ylab="Saturated vapor pressure or vapor pressure in the air (kPa)")
lines(tair-273.15,es_pa[13:241]/1000,lwd=2,col="black")
legend(25,2.5,legend=c("Vapor pressure in the air","Saturated vapor pressure"), col=c("red","black"), lty=c(1,1), cex=c(1.5,1.5),lwd=c(2,2),bty="n")

##########RH was kept as 0.8 for Ball-Berry model
RH_BB=0.8
evair_BB<-RH_BB*es_pa
qair_BB <- (0.622 * evair_BB) / (p_pa - (0.378 * evair_BB))
qbot[1:229]<-qair_BB[13:241]
var_tair <- ncvar_def( 'TBOT', 'K', longname="temperature at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
var_qbot <- ncvar_def( 'QBOT', 'kg/kg', longname="specific humidity at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
ncid_old<-ncvar_add( ncid_old, var_tair )	# NOTE this returns a modified netcdf file handle 
ncid_old<-ncvar_add( ncid_old, var_qbot )	# NOTE this returns a modified netcdf file handle 
ncvar_put(ncid_old,var_tair,tair)
ncvar_put(ncid_old,var_qbot,qbot)
nc_close(ncid_old)