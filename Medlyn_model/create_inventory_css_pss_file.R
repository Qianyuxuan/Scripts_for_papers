rm(list = ls())
library(plyr)
library(stringi)
data_sherman<-read.table("/Users/qianyu/Downloads/sherman/sherman.txt", header = TRUE, sep = "", dec = ".")
data_sherman<-data_sherman[data_sherman$dbh3>0,] #dbh is within [0,500] according to FatesInventoryInitMod.F90
data_sherman<-data_sherman[data_sherman$dbh3<500,]
data_shermansp<-read.table("/Users/qianyu/Downloads/sherman/shermanSP.txt", header = TRUE, sep = "", dec = ".")
# data_merge<- join(data_sherman,data_shermansp,by="spcode")
# species_uniq<-unique(data_merge$species)
x_range<-(data_sherman$x>140)&(data_sherman$x<240)#x coordinate for patch 1, 20 years, 10000m^2
y_range<-(data_sherman$y>340)&(data_sherman$x<440)#y coordinate for patch 1, 20 years, 10000m^2
ncohorts=length(data_sherman$tag)
patch<-c(rep(NA,ncohorts))
patch[x_range&y_range]<-c("6ef18978") #identifier for patch 1, 20 years, 10000m^2
patch[!(x_range&y_range)]<-c("6ef0cea8") #identifier for patch 2, 200-year-old forest, 49600m^2
n1<-sum(x_range&y_range) #number of cohorts within patch 1
n2<-sum(!(x_range&y_range)) #number of cohorts within patch 2
cohort<-c(rep(NA,ncohorts))
cohort[x_range&y_range]<-stri_rand_strings(n1, 8, pattern = "[a-z0-9]")
cohort[!(x_range&y_range)]<-stri_rand_strings(n2, 8, pattern = "[a-z0-9]")
year.out=1999
pft=1
npatches=2
nplant<-c(rep(NA,ncohorts))
nplant[x_range&y_range]<-1/10000
nplant[!(x_range&y_range)]<-1/49600


pssfile   = file.path("/Users/qianyu/Downloads/slz_cens_1999.pss")
cssfile   = file.path("/Users/qianyu/Downloads/slz_cens_1999.css")

outcohorts  = data.frame( time   = sprintf("%4.4i"  , rep(year.out,times=ncohorts))
                          , patch  = sprintf("0x%s", patch   )
                          , cohort = sprintf("0x%s", cohort    )
                          , dbh    = sprintf("%9.3f"  , data_sherman$dbh3    )
                          , hite   = sprintf("%9.3f"  , rep(0  ,times=ncohorts) )
                          , pft    = sprintf("%5i"    , pft    )
                          , nplant  = sprintf("%15.8f" , nplant      )
                          , bdead  = sprintf("%9.3f"  , rep(0  ,times=ncohorts) )
                          , alive = sprintf("%9.3f"  , rep(0  ,times=ncohorts) )
                          , Avgrg    = sprintf("%10.4f" , rep(0  ,times=ncohorts) )
)#end data.frame
dummy   = write.table( x         = outcohorts
                       , file      = cssfile
                       , append    = FALSE
                       , quote     = FALSE
                       , sep       = " "
                       , row.names = FALSE
                       , col.names = TRUE
)#end write.table

outpatches = list( time  = sprintf("%4.4i"  ,rep(year.out     ,times=npatches))
                   , patch = sprintf("0x%s"                   ,unique(patch))
                   , trk   = sprintf("%5i"    ,rep(2            ,times=npatches))
                   , age   = sprintf("%6.1f"  , c(200,20))
                   , area  = sprintf("%9.7f"  ,c(4.96/5.96,1/5.96))
                   , water = sprintf("%5i"    ,rep(0            ,times=npatches))
                   , fsc   = sprintf("%10.5f" ,rep(0            ,times=npatches))
                   , stsc  = sprintf("%10.5f" ,rep(0            ,times=npatches))
                   , stsl  = sprintf("%10.5f" ,rep(0            ,times=npatches))
                   , ssc   = sprintf("%10.5f" ,rep(0            ,times=npatches))
                   , psc   = sprintf("%10.5f" ,rep(0            ,times=npatches))
                   , msn   = sprintf("%10.5f" ,rep(0            ,times=npatches))
                   , fsn   = sprintf("%10.5f" ,rep(0            ,times=npatches))
)#end data.frame
#---------------------------------------------------------------------------------------#


#----- Write the patch file. -----------------------------------------------------------#
dummy   = write.table( x         = outpatches
                       , file      = pssfile
                       , append    = FALSE
                       , quote     = FALSE
                       , sep       = " "
                       , row.names = FALSE
                       , col.names = TRUE
)#end write.table