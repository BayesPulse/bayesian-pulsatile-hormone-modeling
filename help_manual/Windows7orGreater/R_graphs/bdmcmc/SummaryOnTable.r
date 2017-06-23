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
   	data <- read.table(commonFile,col.names= c("pulses","base","mpmass", "mpwidth", "hl", "C0","evar", "RE1","RE2","RE3"),fill=T)
	pdata<-read.table(parmFile,col.names=c("iter","npulses","pnumb","ploc","pmass","pwidth","eta"),fill=T)

    path <- paste(graphSummaryLocation , "/summary.out",sep ='')

     allall<-NULL

     pdata<-pdata[pdata$iter>=burnin,] 
  
    	mean<-round(mean(data$pulses[burnin:length(data[,1])]),2)
    	var<-round(var(data$pulses[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$pulses[burnin:length(data[,1])],c(0.05,0.95)),2)
	     allall<-cbind("Npulses",mean,var,t(quant)) 
         

    	mean<-round(mean(data$base[burnin:length(data[,1])]),2)
    	var<-round(var(data$base[burnin:length(data[,1])]),3)
    	quant<-round(quantile(data$base[burnin:length(data[,1])],c(0.05,0.95)),2)
        alltemp<-cbind("Baseline",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
        
    	mean<-round(mean(data$mpmass[burnin:length(data[,1])]),2)
    	var<-round(var(data$mpmass[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$mpmass[burnin:length(data[,1])],c(0.05,0.95)),2)
        alltemp<-cbind("MPulseMass",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
        
    	mean<-round(mean(data$mpwidth[burnin:length(data[,1])]),2)
    	var<-round(var(data$mpwidth[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$mpwidth[burnin:length(data[,1])],c(0.05,0.95)),2)
    alltemp<-cbind("MPulseWidth",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
        
     	mean<-round(mean(data$hl[burnin:length(data[,1])]),2)
    	var<-round(var(data$hl[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$hl[burnin:length(data[,1])],c(0.05,0.95)),2)
    alltemp<-cbind("HL",mean,var,t(quant))
        allall<-rbind(allall,alltemp)
        
  
    	mean<-round(mean(data$evar[burnin:length(data[,1])]),4)
    	var<-round(var(data$evar[burnin:length(data[,1])]),8)
    	quant<-round(quantile(data$evar[burnin:length(data[,1])],c(0.05,0.95)),4)
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

