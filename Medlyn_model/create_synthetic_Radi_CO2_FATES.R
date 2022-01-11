####create Radiation, preci and CO2 files for Radi and CO2 scenarios 
rm(list = ls())
library(ncdf4)
#####create clmforc.GSWP3.c2011.0.5x0.5.Prec.2013-01.nc with constant preci
ncid_old <- nc_open('Y:/Model_Data/cesm_input_datasets/single_point/PA-SLZ/datmdata/atm_forcing.datm7.GSWP3.0.5d.v1.c170516/Average_forcing/clmforc.GSWP3.c2011.0.5x0.5.Prec.2013-01.nc' , write=TRUE )
preci<-ncvar_get(ncid_old, "PRECTmms")
time<-ncvar_get(ncid_old,varid='time')
lon<-ncvar_get(ncid_old,varid='lon')
lat<-ncvar_get(ncid_old,varid='lat')
ncid_old <- ncvar_rename( ncid_old, "PRECTmms", "PRECTmmsold" )
precinew<-c(rep(NA,248))
for (i in 1:248){
  precinew[i]<-mean(preci,na.rm=TRUE)
}
xdim <- ncdim_def( 'lon', 'degreesE', lon)
ydim <- ncdim_def( 'lat', 'degreesN', lat )
tdim <- ncdim_def( 'time', 'days since 2013-01-01', time )
var_preci <- ncvar_def( 'PRECTmms', 'mms', longname="PRECTmms total precipitation",list(xdim,ydim,tdim), 1.0E36)
ncid_old<-ncvar_add( ncid_old, var_preci )	# NOTE this returns a modified netcdf file handle 
ncvar_put(ncid_old,var_preci,precinew)
nc_close(ncid_old)
##############get solar ramp from 0 to 1200 W/m**2 30 days 241 numbers
solar30d<-seq(from = 0, to = 1200, by = 5)
ncid_old <- nc_open('/Volumes/data/Model_Data/cesm_input_datasets/single_point_synthetic_met/PA-SLZ/Solar/datmdata/atm_forcing.datm7.GSWP3.0.5d.v1.c170516/Solar/clmforc.GSWP3.c2011.0.5x0.5.Solr.2013-01.nc' , write=TRUE )
solar<-ncvar_get(ncid_old, "FSDS")
time<-ncvar_get(ncid_old,varid='time')
lon<-ncvar_get(ncid_old,varid='lon')
lat<-ncvar_get(ncid_old,varid='lat')
ncid_old <- ncvar_rename( ncid_old, "FSDS", "FSDSold" )
solar[1:241]<-solar30d
xdim <- ncdim_def( 'lon', 'degreesE', 1 )
ydim <- ncdim_def( 'lat', 'degreesN', 1 )
tdim <- ncdim_def( 'time', 'days since 2013-01-01', time )
var_solar <- ncvar_def( 'FSDS', 'W/m**2', longname="total incident solar radiation",list(xdim,ydim,tdim), 1.0E36)
ncid_old<-ncvar_add( ncid_old, var_solar )	# NOTE this returns a modified netcdf file handle 
ncvar_put(ncid_old,var_solar,solar)
nc_close(ncid_old)

################################fix short wave radiation
ncid_old <- nc_open('/Volumes/data/Model_Data/cesm_input_datasets/single_point_synthetic_met/PA-SLZ/QBOT/datmdata/atm_forcing.datm7.GSWP3.0.5d.v1.c170516/Solar/clmforc.GSWP3.c2011.0.5x0.5.Solr.2013-01.nc' , write=TRUE )
FSDS<-ncvar_get(ncid_old, "FSDS")
time<-ncvar_get(ncid_old,varid='time')
lon<-ncvar_get(ncid_old,varid='lon')
lat<-ncvar_get(ncid_old,varid='lat')
ncid_old <- ncvar_rename( ncid_old, "FSDS", "FSDSold" )
FSDSnew<-c(rep(NA,248))
for (i in 1:248){
  FSDSnew[i]<-714.3
}
xdim <- ncdim_def( 'lon', 'degreesE', 1 )
ydim <- ncdim_def( 'lat', 'degreesN', 1 )
tdim <- ncdim_def( 'time', 'days since 2013-01-01', time )
var_FSDS <- ncvar_def( 'FSDS', 'W/m**2', longname="total incident solar radiation",list(xdim,ydim,tdim), 1.0E36)
ncid_old<-ncvar_add( ncid_old, var_FSDS )	# NOTE this returns a modified netcdf file handle 
ncvar_put(ncid_old,var_FSDS,FSDSnew)
nc_close(ncid_old)
##############
####create CO2 data
ncidm <- nc_open('/Users/qianyu/Downloads/fates_medlyn/CLM5-FATES_1585534964_PA-SLZ.clm2.h0.2013-01-01-00000.nc')
time<-ncvar_get(ncidm,'time')
nc_close(ncidm)
co2<-c(rep(NA,8760))
xdim <- ncdim_def( 'lon', 'degrees_east', 280.25 ,longname='Longitude of grid cell center')
ydim <- ncdim_def( 'lat', 'degrees_north', 9.25,longname='Latitude of grid cell center')
tdim <- ncdim_def( 'time', 'days since 2013-01-01', time )
co2[1:720]<-seq(101,1000,1.25)
co2[721:8760]<-1000
var_co2 <- ncvar_def( 'CO2', 'ppmv', longname="CO2 concentration",list(xdim,ydim,tdim), 1.0E36)
ncnew <- nc_create( "/Users/qianyu/Downloads/fco2_PA-slz_sensitivity2013_8760new.nc", var_co2 )
ncvar_put( ncnew, var_co2,co2)
nc_close(ncnew)


