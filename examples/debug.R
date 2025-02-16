library(bkcde)
library(progress)
progress.bar <- TRUE
set.seed(42)
n <- scan("n.dat")
M <- scan("M.dat")
theta <- 110
phi <- 50
if(progress.bar) pbb <- progress_bar$new(format = "  Monte Carlo Simulation [:bar] :percent eta: :eta",
                                         clear = TRUE,
                                         force = TRUE,
                                         width = 60,
                                         total = M)
par(mfrow=c(2,2),cex=.75)
for(m in 1:M) {
  if(!progress.bar) cat("\r",m," of ",M," replications",sep="")
  x <- sort(runif(n,0,1))
  y <- rbeta(n,1+x,2-x)
  dgp.mean <- (1+x)/(1+2)
  f.ml <- bkcde(x=x, y=y,degree.min=1,degree.max=1,proper=TRUE)
  plot(unique(f.ml$x.eval),f.ml$g)
  lines(x,dgp.mean)
  plot(unique(f.ml$x.eval),f.ml$g,type="l")
  #f.ml <- bkcde(x=x, y=y,y.ub=Inf,y.lb=-Inf,x.ub=Inf,x.lb=-Inf)
  dgp <-dbeta(f.ml$y.eval,1+f.ml$x.eval,2-f.ml$x.eval)
  zlim <- range(f.ml$f,dgp,0,2)
  plot(f.ml,zlim=zlim,theta=theta,phi=phi,main=paste("CV degree = ", f.ml$degree,", sf.y = ", formatC(f.ml$h.sf[1],format="f",digits=2), ", sf.x = ", formatC(f.ml$h.sf[2],format="f",digits=2)))
  persp(unique(f.ml$x.eval), theta=theta,phi=phi,unique(f.ml$y.eval), matrix(dgp,f.ml$n.grid,f.ml$n.grid), main="DGP",
        ticktype="detailed", xlab="x", ylab="y", zlab="f(y|x)",zlim=zlim)
  if(progress.bar) pbb$tick()  
}

