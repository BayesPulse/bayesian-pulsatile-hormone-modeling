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


generateSummaryFile <- function(burnin,commonFile,parmFile,graphSummaryLocation){
	

	data <- read.table(commonFile,col.names= c("pulses","base","mpmass", "mpwidth", "hl", "evar", "massVar","widthVar"),fill=T)
	pdata<-read.table(parmFile,col.names=c("iter","npulses","pnumb","ploc","pmass","pwidth"),fill=T)

    path <- paste(graphSummaryLocation , "/summary.out",sep ='')

	pdata<-pdata[pdata$iter>=burnin,] 
    allall<-NULL
        

    	mean<-mean(data$pulses[burnin:length(data[,1])])
    	var<-var(data$pulses[burnin:length(data[,1])])
    	quant<-quantile(data$pulses[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
	    allall<-cbind("Npulses",mean,var,t(quant))

    	mean<-mean(data$base[burnin:length(data[,1])])
    	var<-var(data$base[burnin:length(data[,1])])
    	quant<-quantile(data$base[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
        alltemp<-cbind("Baseline",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)

    	mean<-mean(data$mpmass[burnin:length(data[,1])])
    	var<-var(data$mpmass[burnin:length(data[,1])])
    	quant<-quantile(data$mpmass[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
        alltemp<-cbind("MPulseMass",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)

    	mean<-mean(data$mpwidth[burnin:length(data[,1])])
    	var<-var(data$mpwidth[burnin:length(data[,1])])
    	quant<-quantile(data$mpwidth[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
        alltemp<-cbind("MPulseWidth",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)

    	mean<-mean(data$hl[burnin:length(data[,1])])
    	var<-var(data$hl[burnin:length(data[,1])])
    	quant<-quantile(data$hl[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
        alltemp<-cbind("HL",mean,var,t(quant))
        allall<-rbind(allall,alltemp)
        

    	mean<-mean(data$evar[burnin:length(data[,1])])
    	var<-var(data$evar[burnin:length(data[,1])])
    	quant<-quantile(data$evar[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
        alltemp<-cbind("ModelError",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)

        allall<-as.data.frame(allall)
        measurenames=c("Parameter","mean","var","5%","95%")

        names(allall)<-measurenames

        write.table(allall,file = path ,quote=F,row.names=F,col.names=T,sep="\t")
}



args <- commandArgs(TRUE)
burnin <- as.double(args[1])
commonFile <- args[2]
parmFile <- args[3]
graphLocation <- args[4]
generateSummaryFile(burnin,commonFile,parmFile,graphLocation)
