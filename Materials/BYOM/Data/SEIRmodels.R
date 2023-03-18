library(deSolve)

DetSEIR.dyn<-function(N, E0, I0, B, g, m, f_time){
  
  SEIR.dyn <- function(t,var,par) {
    S <- var[1]
    E <- var[2]
    I <- var[3]
    R <- var[4]
    
    beta <- par[1]
    N<-par[2]
    g<-par[3]
    m<-par[4]
    
    dS<--beta*S*I/N
    dE<- beta*S*I/N - (g*E)
    dI<- (g*E) - m*I
    dR<- m*I
    return(list(c(dS,dE,dI,dR)))
  }
  
  SEIR.par<-c(B,N,g,m)
  SEIR.init<-c(N-I0-E0,E0,I0,0)
  SEIR.t<-seq(0,f_time,0.1)
  
  return(lsoda(SEIR.init,SEIR.t,SEIR.dyn,SEIR.par))
}

require('SimInf')

create.StocSEIR <-function(N, E0, I0, beta, g, m, f_time,reps=1){
  
  initial_state <- data.frame(S=rep(N-I0,reps),E=rep(E0,reps),I=rep(I0,reps),R=rep(0,reps))
  compartments  <- c("S","E","I","R")
  transitions   <- c("S -> beta*S*I/(S+E+I+R) -> E","E -> g*E -> I","I -> m*I -> R")
  tspan         <- seq(from = 1, to =f_time, by = 1)
  return(mparse(transitions = transitions, compartments = compartments, 
                gdata = c(beta=beta,g=g,m=m), u0 = initial_state, tspan = tspan))
}


# Takes SimInf object (out) as argument and integer (node)
# Returns line list of dates of cases for specified node

line_list <- function (out, node)
{
  df <- trajectory(out)
  mat_dat <- acast(df,time~node,value.var='R')
  line_list<-unlist(sapply(2:dim(mat_dat)[1],function(i){rep(i,diff(mat_dat[,node])[i-1])}))
  line_list <- as.Date(chron(line_list,origin=c(month=2,day=18,year=2019)))
  return(line_list)
}

