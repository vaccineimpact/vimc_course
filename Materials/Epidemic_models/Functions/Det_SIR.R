#SIR Deterministic Model
library(deSolve)

DetSIR.dyn<-function(N, I0, B, M, f_time){

  SI.dyn <- function(t,var,par) {
    S <- var[1]
    I <- var[2]
    R <- var[3]
    
    beta <- par[1]
    N<-par[2]
    mu<-par[3]
    
    dS<--beta*S*I/N
    dI<-beta*S*I/N - mu*I
    dR<-mu*I
    return(list(c(dS,dI,dR)))
  }
  
  SI.par<-c(B,N,M)
  SI.init<-c(N-I0,I0,0)
  SI.t<-seq(0,f_time,0.1)
  
  return(lsoda(SI.init,SI.t,SI.dyn,SI.par))
}

det.sol<-DetSIR.dyn(500, 1, 1,0.25, 30)

det.t<-det.sol[,1]
det.I<-det.sol[,3]

points(det.t,det.I,type='l',lwd=3)
