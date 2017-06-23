#Inputs from .bphl file, MeanOfPriorForBase=MeanOfBaselinePrior, varianceOfPrior=varianceOfPriorForMeanBaseline)

graphHist <- function(NumberOfObservations,meanOfPriorForBase, varianceOfPrior,UpperBoundOfPrior,filename)
{
	png(filename, height=366, width=481)
    par(mfrow=c(2,1))
    
	baselineq <-qnorm(c(0.005,0.995),meanOfPriorForBase, sqrt(varianceOfPrior))
    baseline<-seq(baselineq[1],baselineq[2],by=(baselineq[2]-baselineq[1])/500)
	dbaseline<-dnorm(baseline,meanOfPriorForBase, sqrt(varianceOfPrior))
    plot(baseline,dbaseline,type="l",xlab="Baseline",ylab="Dist'n Function",main="Prior on Pop. Mean Baseline")
    
    
    baselineSD <-seq(0,UpperBoundOfPrior,UpperBoundOfPrior / (150 - 1))
    dbaselineSD<-rep(1/UpperBoundOfPrior,150)
    plot(baselineSD,dbaselineSD,type="l",xlab="Baseline SD",ylab="Dist'n Function",main="Prior on Pop. Baseline SD" )
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForBase <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
UpperBoundOfPrior <- as.double(args[4])
filename  <- args[5]
graphHist(NumberOfObservations, meanOfPriorForBase, varianceOfPrior,UpperBoundOfPrior,filename)

