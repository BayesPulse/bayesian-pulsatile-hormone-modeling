###########################################################
###Program: simsummary.r
###Created by: Ken Horton and Nichole Carlson
###Created on: 3/3/11
###
###Purpose: To perform all the parameter checking and 
###         create the bias, false pos/neg calculations for
###         summarizing a set of models fitted using BDMCMC
###########################################################

####PART 1########
#This section of code creates a large pdf of plots for the common parameters. For 25 datasets, it creates a time series and histogram for
#each parameter within that dataset.


graph <- function(burnin,outputrate,commonFile,parmFile,mconFile,dataFile,fileName){
	

	data <- read.table(commonFile,col.names= c("pulses","base","mpmass", "mpwidth", "hl", "evar", "massVar","widthVar"),fill=T)
	pdata<-read.table(parmFile,col.names=c("iter","npulses","pnumb","ploc","pmass","pwidth"),fill=T)


	pdata<-pdata[pdata$iter>=burnin,] 

        
    	pdf(file = graphLocation)
    
    	par(mfrow=c(2,2))
    
     
    	ts.plot(data$pulses[burnin:length(data[,1])],main="# of Pulses ",xlab="iteration",ylab="Number of Pulses")
    	hist(data$pulses[burnin:length(data[,1])],main="Histogram of # of Pulses",xlab="Number of Pulses")


    	mean<-mean(data$pulses[burnin:length(data[,1])])
    	var<-var(data$pulses[burnin:length(data[,1])])
    	quant<-quantile(data$pulses[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
	
    	ts.plot(data$base[burnin:length(data[,1])],main="Baseline ",xlab="iteration",ylab="Baseline (Conc. Units)")
    	hist(data$base[burnin:length(data[,1])],main="Histogram of Baseline",xlab="Baseline")

        mean<-mean(data$base[burnin:length(data[,1])])
    	var<-var(data$base[burnin:length(data[,1])])
    	quant<-quantile(data$base[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	ts.plot(data$mpmass[burnin:length(data[,1])],main= "Mean Pulse Mass ",xlab="iteration",ylab="Mean Pulse Mass")
    	hist(data$mpmass[burnin:length(data[,1])],main="Histogram of Mean Pulse Mass",xlab="Mean Pulse Mass")


    	mean<-mean(data$mpmass[burnin:length(data[,1])])
    	var<-var(data$mpmass[burnin:length(data[,1])])
    	quant<-quantile(data$mpmass[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
	
    	ts.plot(data$mpwidth[burnin:length(data[,1])],main="Mean Pulse Width ",xlab="iteration",ylab="Mean Pulse Width")   
    	hist(data$mpwidth[burnin:length(data[,1])],main="Histogram of Mean Pulse Width",xlab="Mean Pulse Width")
        

        mean<-mean(data$mpwidth[burnin:length(data[,1])])
    	var<-var(data$mpwidth[burnin:length(data[,1])])
    	quant<-quantile(data$mpwidth[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	ts.plot(data$hl[burnin:length(data[,1])],main="Halflife ",xlab="iteration",ylab="Halflife (min)")
    	hist(data$hl[burnin:length(data[,1])],main="Histogram of Halflife",xlab="Halflife (min)")
	
    	mean<-mean(data$hl[burnin:length(data[,1])])
    	var<-var(data$hl[burnin:length(data[,1])])
    	quant<-quantile(data$hl[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	ts.plot(data$evar[burnin:length(data[,1])],main="Error Variance ",xlab="iteration",ylab="Error Var (log Conc.)")
    	hist(data$evar[burnin:length(data[,1])],main="Histogram of Error Variance",xlab="Error Var (log conc.)")


    	mean<-mean(data$evar[burnin:length(data[,1])])
    	var<-var(data$evar[burnin:length(data[,1])])
    	quant<-quantile(data$evar[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	hist(pdata$ploc,breaks=seq(-100,1600,by=5),main="Pulse Locations",xlab="Time (min)")
        
        
        
    
}    


args <- commandArgs(TRUE)
burnin <- as.double(args[1])
commonFile <- args[2]
parmFile <- args[3]
mconFile <- args[4]
dataFile <- args[5]
graphLocation <- args[6]
graph(burnin,commonFile,parmFile,mconFile,dataFile,graphLocation)
