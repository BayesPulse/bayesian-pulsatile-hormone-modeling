####Inputs from .bphl file  meanOfPriorForMPM= MeanOfPriorForMeanPulseMass (priormu1), varianceOfPrior = varianceOfPriorForMeanPulseMass (priorvar1)

graphHist <- function(NumberOfObservations ,meanOfPriorForMPM, varianceOfPrior,filename)
{
	png(filename, height=366, width=481)
	meanmassq <-qnorm(c(0.005,0.995),meanOfPriorForMPM, sqrt(varianceOfPrior))
    meanmass<-seq(meanmassq[1],meanmassq[2],by=(meanmassq[2]-meanmassq[1])/500)
	dmeanmass<-dnorm(meanmass,meanOfPriorForMPM, sqrt(varianceOfPrior))
    plot(meanmass,dmeanmass,type="l",xlab="Mean LogMass",ylab="Dist'n Function",main="Prior on Mean LogMass")
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForMPM <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
filename <- args[4]
graphHist(NumberOfObservations, meanOfPriorForMPM, varianceOfPrior,filename)

