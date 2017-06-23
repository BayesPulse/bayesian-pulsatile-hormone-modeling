#Inputs from .bphl file, MeanOfPriorForHL=MeanOfHalflifePrior, varianceOfPrior=varianceOfPriorForMeanHalflife---called priorvarh)

graphHist <- function(NumberOfObservations,meanOfPriorForHL, varianceOfPrior,filename)
{
	png(filename, height=366, width=481)
	halflifeq <-qnorm(c(0.005,0.995),meanOfPriorForHL, sqrt(varianceOfPrior))
    halflife<-seq(halflifeq[1],halflifeq[2],by=(halflifeq[2]-halflifeq[1])/500)
	dhalflife<-dnorm(halflife,meanOfPriorForHL, sqrt(varianceOfPrior))
    plot(halflife,dhalflife,type="l",xlab="Halflife",ylab="Dist'n Function",main="Prior on Halflife")
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForHL <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
filename <-  args[4]
graphHist(NumberOfObservations, meanOfPriorForHL, varianceOfPrior,filename)
