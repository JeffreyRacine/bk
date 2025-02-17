library(bkcde)
library(progress)
progress.bar <- TRUE
## set.seed(42)
n <- scan("n.dat")
M <- scan("M.dat")
theta <- 170
phi <- 60
if(progress.bar) pbb <- progress_bar$new(format = "  Monte Carlo Simulation [:bar] :percent eta: :eta",
                                         clear = TRUE,
                                         force = TRUE,
                                         width = 60,
                                         total = M)
for(m in 1:M) {
  if(!progress.bar) cat("\r",m," of ",M," replications",sep="")
  x <- sort(runif(n,0,1))
  y <- rnorm(n,x,sd=sqrt(1/12))
  dgp.mean <- x
  #f <- bkcde(h=c(.5*sd(y)*n^{-1/6},10*sd(x)*n^{-1/6}),degree=1,y.erf=.5,integrate.erf=1,n.integrate=1000,x.erf=0,x=x, y=y,degree.min=0,degree.max=3,proper=TRUE,x.lb=-Inf,x.ub=Inf,y.lb=-Inf,y.ub=Inf)
  f <- bkcde(h=c(.5*sd(y)*n^{-1/6},1000*sd(x)*n^{-1/6}),degree=2,x=x, y=y,proper=TRUE,degree.min=1,degree.max=1,y.lb=-Inf,y.ub=Inf,y.erf=.5)
  ylim <- range(f$g,dgp.mean)
  par(mfrow=c(2,2),cex=.75)
  dgp <-dnorm(f$y.eval,f$x.eval,sd=sqrt(1/12))
  zlim <- range(f$f,dgp,0,2)
  plot(f,zlim=zlim,theta=theta,phi=phi,main=paste("CV degree = ", f$degree,", sf.y = ", formatC(f$h.sf[1],format="f",digits=2), ", sf.x = ", formatC(f$h.sf[2],format="f",digits=2)))
  persp(unique(f$x.eval), theta=theta,phi=phi,unique(f$y.eval), matrix(dgp,f$n.grid,f$n.grid), main=paste("DGP, n = ",n,sep=""),
        ticktype="detailed", xlab="x", ylab="y", zlab="f(y|x)",zlim=zlim)
  plot(unique(f$x.eval),unique(f$g),ylim=ylim,xlab="x",ylab="g(x)",main=paste("Conditional mean g(x) vs x, n = ",n,sep=""),type="l")
  lines(x,dgp.mean,col=2)
  legend("topleft",legend=c("g(x)","DGP"),lty=1,col=c(1,2),bty="n")
  if(progress.bar) pbb$tick()  
}

