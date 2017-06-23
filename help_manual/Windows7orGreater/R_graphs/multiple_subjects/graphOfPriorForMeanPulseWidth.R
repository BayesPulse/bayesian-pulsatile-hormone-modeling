#Inputs from .bphl file, ###  [wprior1 and wprior2 are input]
graphHist <- function(NumberOfObservations ,meanOfPriorForMPW, varianceOfPrior,UpperBoundOfPriorPopSD,UpperBoundOfPriorWidthSD,filename)
{

    png(filename, height=390, width=481)
    par(mfrow=c(3,1))
	meanwidthq <-qnorm(c(0.005,0.995),meanOfPriorForMPW, sqrt(varianceOfPrior))
    meanwidth<-seq(meanwidthq[1],meanwidthq[2],by=(meanwidthq[2]-meanwidthq[1])/500)
	dmeanwidth<-dnorm(meanwidth,meanOfPriorForMPW, sqrt(varianceOfPrior))
    plot(meanwidth,dmeanwidth,type="l",xlab="Mean LogWidth",ylab="Dist'n Function",main="Prior on Pop. Mean LogWidth")
    
    
    
	MeanWidthSD <-seq(0,UpperBoundOfPriorPopSD,UpperBoundOfPriorPopSD/149)
    dMeanWidthSD<-rep(1/UpperBoundOfPriorPopSD,150)
    plot(MeanWidthSD,dMeanWidthSD,type="l",xlab="Mean LogWidth SD",ylab="Dist'n Function",main="Prior on Pop. Mean logWidth SD (subj.-to-subj.)" )
    

	WidthSD <-seq(0,UpperBoundOfPriorWidthSD,UpperBoundOfPriorWidthSD/149)
    dWidthSD<-rep(1/UpperBoundOfPriorWidthSD,150)
    plot(WidthSD,dWidthSD,type="l",xlab="LogWidth SD",ylab="Dist'n Function",main="Prior on logWidth SD (within subj.)" )
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForMPW <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
UpperBoundOfPriorPopSD <-  as.double(args[4])
UpperBoundOfPriorWidthSD <-  as.double(args[5])
filename <-  args[6]
graphHist(NumberOfObservations, meanOfPriorForMPW, varianceOfPrior,UpperBoundOfPriorPopSD,UpperBoundOfPriorWidthSD,filename)
