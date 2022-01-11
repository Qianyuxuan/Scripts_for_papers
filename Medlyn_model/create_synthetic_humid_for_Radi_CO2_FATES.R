#create clmforc.GSWP3.c2011.0.5x0.5.TPQWL.2013-01.nc for Radi and CO2 scenarios where VPD=1KD, T=25 degree
rm(list = ls())
library(ncdf4)
ncid_old <- nc_open('/Volumes/data/Model_Data/cesm_input_datasets/single_point_synthetic_met/PA-SLZ/Solar/datmdata/atm_forcing.datm7.GSWP3.0.5d.v1.c170516/TPHWL/clmforc.GSWP3.c2011.0.5x0.5.TPQWL.2013-01.nc' , write=TRUE )
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
tairnew<-c(rep(NA,248))
######calculate qbot at standard situation (VPD=1Kpa,tair=25℃)
a0 =  6.11213476
a1 =  0.444007856
a2 =  0.143064234e-01
a3 =  0.264461437e-03
a4 =  0.305903558e-05
a5 =  0.196237241e-07
a6 =  0.892344772e-10
a7 = -0.373208410e-12
a8 =  0.209339997e-15
td = 25
es_mb  = a0 + td*(a1 + td*(a2 + td*(a3 + td*(a4 + td*(a5 + td*(a6 + td*(a7 + td*a8))))))) #mb
es_pa = es_mb*100 #pa
VPD<-1000    #pa
RH<-1-VPD/es_pa             #VPD's unit is Pa
evair<-RH*es_pa
p_pa<-101325    #pa
qair <- (0.622 * evair) / (p_pa - (0.378 * evair))

for (i in 1:248){
  psrfnew[i]<-mean(psrf,na.rm=TRUE)
  windnew[i]<-mean(wind,na.rm=TRUE)
  fldsnew[i]<-mean(flds,na.rm=TRUE)
  qbotnew[i]<-qair
  tairnew[i]<-25+273.15
}
xdim <- ncdim_def( 'lon', 'degreesE', 1 )
ydim <- ncdim_def( 'lat', 'degreesN', 1 )
tdim <- ncdim_def( 'time', 'Hour since 2013-01-01', time )
var_psrf <- ncvar_def( 'PSRF', 'Pa', longname="surface pressure at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
var_wind <- ncvar_def( 'WIND', 'm/s', longname="wind at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
var_flds <- ncvar_def( 'FLDS', 'W/m**2', longname="incident longwave radiation",list(xdim,ydim,tdim), 1.0E36)
var_qbot <- ncvar_def( 'QBOT', 'kg/kg', longname="specific humidity at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
var_tair <- ncvar_def( 'TBOT', 'K', longname="temperature at the lowest atm level",list(xdim,ydim,tdim), 1.0E36)
ncid_old<-ncvar_add( ncid_old, var_psrf )	# NOTE this returns a modified netcdf file handle 
ncid_old<-ncvar_add( ncid_old, var_wind )
ncid_old<-ncvar_add( ncid_old, var_flds)
ncid_old<-ncvar_add( ncid_old, var_tair )	# NOTE this returns a modified netcdf file handle 
ncid_old<-ncvar_add( ncid_old, var_qbot )	# NOTE this returns a modified netcdf file handle 
ncvar_put(ncid_old,var_psrf,psrfnew)
ncvar_put(ncid_old,var_wind,windnew)
ncvar_put(ncid_old,var_flds,fldsnew)
ncvar_put(ncid_old,var_tair,tairnew)
ncvar_put(ncid_old,var_qbot,qbotnew)
nc_close(ncid_old)


