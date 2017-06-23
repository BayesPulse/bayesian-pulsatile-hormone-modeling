graphHist <- function(NumberOfObservations,meanOfPriorForHalfLife, varianceOfPrior,filename)
{
	png(filename, height=366, width=481)
	HalfLife <-rnorm(NumberOfObservations,meanOfPriorForHalfLife, sqrt(varianceOfPrior))
	hist(HalfLife)
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForHalfLife <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
filename <- args[4]
graphHist(NumberOfObservations, meanOfPriorForHalfLife, varianceOfPrior,filename)


