
graphHist <- function(NumberOfObservations ,meanOfPriorForMPM, varianceOfPrior,filename)
{
	png(filename,  height=366, width=481)
	graph_of_prior_mean_pulse_mass <-rnorm(NumberOfObservations,meanOfPriorForMPM, sqrt(meanOfPriorForMPM))
	hist(graph_of_prior_mean_pulse_mass,main = "Hist Of Prior Mean Mass" )
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForMPM <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
filename <- args[4]
graphHist(NumberOfObservations, meanOfPriorForMPM, varianceOfPrior ,filename)