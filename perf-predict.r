#Load Library and Set Path
library(rethinking)
Sys.setlocale(locale='Chinese') #Makes the histograms show
setwd("C:/Users/brad.davis/Desktop/Dakota/PerforationStan")

#load processed data
source('sim.data.r')

fit_predict <- stan(file="perf-predict.stan",   
                    data=stan_data,
                    iter=100, chains=1)

print(fit_predict, pars = c('rho','alpha','sigma'))

source('post.data.r')

y2 <- extract(fit_predict)$y2[1,]
y_pred <- (y2*(y_max-y_min))+y_min

plot(v$vel____[1:295],v$obj_fn[1:295])
points(v$vel____[296:311],y_pred,col='black',pch=16, cex=1)

plot(v$vel____[296:311],v$obj_fn[296:311])
points(v$vel____[296:311],y_pred,col='black',pch=16, cex=1)
