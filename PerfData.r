#Load Library and Set Path
library(rethinking)
Sys.setlocale(locale='Chinese') #Makes the histograms show
setwd("C:/Users/brad.davis/Desktop/Dakota/PerforationStan")

#Load Experimental Data as e
e <- read.table("expdata.dat",header=TRUE,sep="")

#Load Perforation Simulations Data as v, Penetration Simulations Data as d
v <- read.table("epicdata.dat",header=TRUE,sep="")

#Mean/SD and min/max of data
a_mean<-mean(v$A______)
b_mean<-mean(v$B______)
n_mean<-mean(v$n______)
c_mean<-mean(v$c______)
s_mean<-mean(v$s______)
d_mean<-mean(v$d______)
pc_mean<-mean(v$pc_____)
uc_mean<-mean(v$uc_____)
k1_mean<-mean(v$k1_____)
k2_mean<-mean(v$k2_____)
k3_mean<-mean(v$k3_____)
ul_mean<-mean(v$ul_____)
pl_mean<-mean(v$pl_____)

y_max<-max(v$obj_fn)
y_min<-min(v$obj_fn)
v_max<-max(v$vel____)
v_min<-min(v$vel____)
theta_max<-max(v$theta__)
theta_min<-min(v$theta__)

a_sd<-sd(v$A______)
b_sd<-sd(v$B______)
n_sd<-sd(v$n______)
c_sd<-sd(v$c______)
s_sd<-sd(v$s______)
d_sd<-sd(v$d______)
pc_sd<-sd(v$pc_____)
uc_sd<-sd(v$uc_____)
k1_sd<-sd(v$k1_____)
k2_sd<-sd(v$k2_____)
k3_sd<-sd(v$k3_____)
ul_sd<-sd(v$ul_____)
pl_sd<-sd(v$pl_____)

#Standardize Training Parameters and put into a data frame
vel<-(v$vel____-v_min)/(v_max-v_min) #strike velocities are centered then standardized by the range to a 0-1 scale
theta<-(v$theta__-theta_min)/(theta_max-theta_min) #theta is centered then standardized by the range
a<-(v$A______-a_mean)/a_sd
b<-(v$B______-b_mean)/b_sd
n<-(v$n______-n_mean)/n_sd
c<-(v$c______-c_mean)/c_sd
s<-(v$s______-s_mean)/s_sd
d<-(v$d______-d_mean)/d_sd
pc<-(v$pc_____-pc_mean)/pc_sd
uc<-(v$uc_____-uc_mean)/uc_sd
k1<-(v$k1_____-k1_mean)/k1_sd
k2<-(v$k2_____-k2_mean)/k2_sd
k3<-(v$k3_____-k3_mean)/k3_sd
pl<-(v$pl_____-pl_mean)/pl_sd
ul<-(v$ul_____-ul_mean)/ul_sd
y<-(v$obj_fn-y_min)/(y_max-y_min)

#Training Data Set
x <- cbind(vel,theta,a,b,n,c,s,d,pc,uc,k1,k2,k3,pl,ul)
x1<-x[1:295,]
y1<-y[1:295]
x2<-x[296:311,]
y2<-y[296:311]

#matrix dimensions
N1<-nrow(x1)
D1<-ncol(x1)
N2<-nrow(x2)
D2<-ncol(x2)

#Consolidate data into dataframe
stan_data <- list(N1=N1,D1=D1,N2=N2,D2=D2,x1=x1,y1=y1,x2=x2,y2=y2)
post_data <- list(a_mean=a_mean,b_mean=b_mean,n_mean=n_mean,c_mean=c_mean,s_mean=s_mean,d_mean=d_mean,pc_mean=pc_mean,uc_mean=uc_mean,k1_mean=k1_mean,k2_mean=k2_mean,k3_mean=k3_mean,ul_mean=ul_mean,pl_mean=pl_mean,y_max=y_max,y_min=y_min,v_max=v_max,v_min=v_min,theta_max=theta_max,theta_min=theta_min,a_sd=a_sd,b_sd=b_sd,n_sd=n_sd,c_sd=c_sd,s_sd=s_sd,d_sd=d_sd,pc_sd=pc_sd,uc_sd=uc_sd,k1_sd=k1_sd,k2_sd=k2_sd,k3_sd=k3_sd,ul_sd=ul_sd,pl_sd=pl_sd)

#Create Dump Files
dump('stan_data',file="sim.data.r")
dump('post_data',file='post.data.r')

source('sim.data.r')
