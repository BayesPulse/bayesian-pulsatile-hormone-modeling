#Inputs from .bphl file, MeanOfPriorForBase=MeanOfBaselinePrior, varianceOfPrior=varianceOfPriorForMeanBaseline--called priorvarb)

graphHist <- function(NumberOfObservations,meanOfPriorForBase, varianceOfPrior,filename)
{
	png(filename, height=366, width=481)
	baselineq <-qnorm(c(0.005,0.995),meanOfPriorForBase, sqrt(varianceOfPrior))
    baseline<-seq(baselineq[1],baselineq[2],by=(baselineq[2]-baselineq[1])/500)
	dbaseline<-dnorm(baseline,meanOfPriorForBase, sqrt(varianceOfPrior))
    plot(baseline,dbaseline,type="l",xlab="Baseline",ylab="Dist'n Function",main="Prior on Mean of Baseline")
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForBase <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
filename <-  args[4]
graphHist(NumberOfObservations, meanOfPriorForBase, varianceOfPrior,filename)

