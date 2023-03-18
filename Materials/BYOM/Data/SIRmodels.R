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

require('SimInf')

create.StocSIR <-function(N, I0, beta, m, f_time,reps=1){
  
  initial_state <- data.frame(S=rep(N-I0,reps),I=rep(I0,reps),R=rep(0,reps))
  compartments  <- c("S","I","R")
  transitions   <- c("S -> beta*S*I/(S+I+R) -> I","I -> m*I -> R")
  tspan         <- seq(from = 1, to =f_time, by = 1)
  return(mparse(transitions = transitions, compartments = compartments, 
                gdata = c(beta=beta,m=m), u0 = initial_state, tspan = tspan))
}
