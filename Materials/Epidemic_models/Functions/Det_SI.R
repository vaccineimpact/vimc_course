#SI Deterministic Model
#this script adds an SI model curve to an existing plot window

library(deSolve)

DetSI.dyn<-function(N, I0, B, f_time){

  SI.dyn <- function(t,var,par) {
    S <- var[1]
    I <- var[2]
    
    beta <- par[1]
    N<-par[2]
    
    dS<--beta*S*I/N
    dI<-beta*S*I/N
    
    return(list(c(dS,dI)))
  }
  
  SI.par<-c(B,N)
  SI.init<-c(N-I0,I0)
  SI.t<-seq(0,f_time,0.1)
  
  return(lsoda(SI.init,SI.t,SI.dyn,SI.par))
}


