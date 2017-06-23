
graphHist <- function(NumberOfObservations ,meanOfPriorForMPW, varianceOfPrior,filename)
{
	png(filename, height=366, width=481)
	graph_of_prior_mean_pulse_width <-rnorm(NumberOfObservations,meanOfPriorForMPW, sqrt(meanOfPriorForMPW))
	hist(graph_of_prior_mean_pulse_width,main = "Histogram Of Prior Mean Pulse Width" )
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForMPW <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
filename <- args[4]
graphHist(NumberOfObservations, meanOfPriorForMPW, varianceOfPrior,filename)

