### Well, this looks OK though with large x get a bias in the tails...

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
  y <- rnorm(n,x,sd=sqrt(1/12))
  dgp.mean <- x
  #f <- bkcde(h=c(.5*sd(y)*n^{-1/6},10),degree=1,x=x, y=y,degree.min=1,degree.max=1,proper=TRUE)#,y.lb=-Inf,y.ub=Inf,x.lb=-Inf,x.ub=Inf)
  #f <- bkcde(h=c(.20*sd(y)*n^{-1/6},1*sd(x)*n^{-1/6}),degree=1,x=x, y=y,degree.max=5,degree.min=0,proper=TRUE)#,y.lb=-Inf,y.ub=Inf)#,x.lb=-Inf,x.ub=Inf)
  f <- bkcde(h=c(.20*sd(y)*n^{-1/6},1000*sd(x)*n^{-1/6}),degree=1,x=x, y=y,degree.max=1,degree.min=1,proper=TRUE,y.trim=-0.25,x.trim=-0.25)
  ylim <- range(f$g,dgp.mean)
  plot(unique(f$x.eval),f$g,ylim=ylim)
  lines(x,dgp.mean)
  plot(unique(f$x.eval),f$g,type="l")
  #f <- bkcde(x=x, y=y,y.ub=Inf,y.lb=-Inf,x.ub=Inf,x.lb=-Inf)
  dgp <-dnorm(f$y.eval,f$x.eval,sd=sqrt(1/12))
  zlim <- range(f$f,dgp,0,2)
  plot(f,zlim=zlim,theta=theta,phi=phi,main=paste("CV degree = ", f$degree,", sf.y = ", formatC(f$h.sf[1],format="f",digits=2), ", sf.x = ", formatC(f$h.sf[2],format="f",digits=2)))
  persp(unique(f$x.eval), theta=theta,phi=phi,unique(f$y.eval), matrix(dgp,f$n.grid,f$n.grid), main="DGP",
        ticktype="detailed", xlab="x", ylab="y", zlab="f(y|x)",zlim=zlim)
  if(progress.bar) pbb$tick()  
}

