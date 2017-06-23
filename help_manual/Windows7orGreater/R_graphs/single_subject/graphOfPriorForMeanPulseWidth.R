####Inputs from .bphl file  meanOfPriorForMPW= MeanOfPriorForMeanPulseWidth (priormu2), varianceOfPrior = varianceOfPriorForMeanPulseWidth (priorvar2)

graphHist <- function(NumberOfObservations ,meanOfPriorForMPW, varianceOfPrior, UpperBoundOfPrior,filename)
{



	png(filename, height=366, width=481)
    par(mfrow=c(2,1))
    
	meanwidthq <-qnorm(c(0.005,0.995),meanOfPriorForMPW, sqrt(varianceOfPrior))
    meanwidth<-seq(meanwidthq[1],meanwidthq[2],by=(meanwidthq[2]-meanwidthq[1])/500)
	dmeanwidth<-dnorm(meanwidth,meanOfPriorForMPW, sqrt(varianceOfPrior))
    plot(meanwidth,dmeanwidth,type="l",xlab="Mean LogWidth",ylab="Dist'n Function",main="Prior on Mean Logwidth")
    
	#png("MeanWidthSD.png", height=260, width=292)
	MeanwidthSD <-seq(0,UpperBoundOfPrior,UpperBoundOfPrior / (150 - 1))
    dMeanwidthSD<-rep(1/UpperBoundOfPrior,150)
        plot(MeanwidthSD,dMeanwidthSD,type="l",xlab="LogWidth SD",ylab="Dist'n Function",main="Prior on logWidth SD (within subj.)" )

}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForMPW <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
UpperBoundOfPrior <-  as.double(args[4])
filename <-  args[5]
graphHist(NumberOfObservations, meanOfPriorForMPW, varianceOfPrior,UpperBoundOfPrior,filename)

