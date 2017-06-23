#Inputs from .bphl file, MeanOfPriorForHL=MeanOfHalflifePrior, varianceOfPrior=varianceOfPriorForMeanHalflife)

graphHist <- function(NumberOfObservations,meanOfPriorForHL, varianceOfPrior,UpperBoundOfPrior,filename)
{
    png(filename, height=366, width=481)
    par(mfrow=c(2,1))
    
	halflifeq <-qnorm(c(0.005,0.995),meanOfPriorForHL, sqrt(varianceOfPrior))
    halflife<-seq(halflifeq[1],halflifeq[2],by=(halflifeq[2]-halflifeq[1])/500)
	dhalflife<-dnorm(halflife,meanOfPriorForHL, sqrt(varianceOfPrior))
    plot(halflife,dhalflife,type="l",xlab="Halflife",ylab="Dist'n Function",main="Prior on Pop. Mean Halflife")
    
    halflifeSD <-seq(0,UpperBoundOfPrior,UpperBoundOfPrior/149)
    dhalflifeSD<-rep(1/UpperBoundOfPrior,150)
    plot(halflifeSD,dhalflifeSD,type="l",xlab="Halflife SD",ylab="Dist'n Function",main="Prior on Pop. Baseline SD" )
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForHL <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
UpperBoundOfPrior <-  as.double(args[4])
filename <- args[5]
graphHist(NumberOfObservations, meanOfPriorForHL, varianceOfPrior,UpperBoundOfPrior,filename)

