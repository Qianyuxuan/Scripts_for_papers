rm(list = ls())
a0 =  6.11213476
a1 =  0.444007856
a2 =  0.143064234e-01
a3 =  0.264461437e-03
a4 =  0.305903558e-05
a5 =  0.196237241e-07
a6 =  0.892344772e-10
a7 = -0.373208410e-12
a8 =  0.209339997e-15
td=25
rh=0.8
es_mb  = a0 + td*(a1 + td*(a2 + td*(a3 + td*(a4 + td*(a5 + td*(a6 + td*(a7 + td*a8)))))))
es_pa = es_mb*100/1000 #kpa
evair<-rh*es_pa #kpa
ds_s=sqrt(es_pa-evair)

g1m = 4.1 #kpa*0.5
g1b=1.6*(1+g1m/ds_s)/rh

g1b=8  #unitless
g1m=(g1b*rh/1.6-1)*ds_s