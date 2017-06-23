#Inputs from .bphl file, ###  [mprior1 and mprior2 are input]
#Inputs from .bphl file, ###  [mprior3 is input]
#Inputs from .bphl file, ###  [mprior3 is input]
graphHist <- function(NumberOfObservations ,meanOfPriorForMPM, varianceOfPrior,UpperBoundOfPriorPopSD,UpperBoundOfPriorPulseSD,filename)
{
    
	png(filename, height=430, width=400)
    par(mfrow=c(3,1))

	meanmassq <-qnorm(c(0.005,0.995),meanOfPriorForMPM, sqrt(varianceOfPrior))
    meanmass<-seq(meanmassq[1],meanmassq[2],by=(meanmassq[2]-meanmassq[1])/500)
	dmeanmass<-dnorm(meanmass,meanOfPriorForMPM, sqrt(varianceOfPrior))
    plot(meanmass,dmeanmass,type="l",xlab="Mean LogMass",ylab="Dist'n Function",main="Prior on Pop. Mean LogMass")
    
	MeanMassSD <-seq(0,UpperBoundOfPriorPopSD,UpperBoundOfPriorPopSD/149)
    dMeanMassSD<-rep(1/UpperBoundOfPriorPopSD,150)
    plot(MeanMassSD,dMeanMassSD,type="l",xlab="Mean LogMass SD",ylab="Dist'n Function",main="Prior on Pop. Mean logMass SD (subj.-to-subj.)" )

	MassSD <-seq(0,UpperBoundOfPriorPulseSD,UpperBoundOfPriorPulseSD/149)
    dMassSD<-rep(1/UpperBoundOfPriorPulseSD,150)
    plot(MassSD,dMassSD,type="l",xlab="LogMass SD",ylab="Dist'n Function",main="Prior on logMass SD (within subj.)" )
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForMPM <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
UpperBoundOfPriorPopSD <-  as.double(args[4])
UpperBoundOfPriorPulseSD <- as.double(args[5])
filename <- args[6]
graphHist(NumberOfObservations, meanOfPriorForMPM, varianceOfPrior,UpperBoundOfPriorPopSD,UpperBoundOfPriorPulseSD,filename)

