###########################################################
#Creates trace plots for the population level parameters
#Creates trace plots for individual level parameters as selected by the user

#Creates summary tables of population level parameters
#Creates summary tables of individual level parameters as selected by the user

#Creates fitted value plots as requested by the user

#Creates observed data plots as requested by the user
##################################################################

 generateSummaryFile <- function(burnin,subjFile,graphSummaryLocation){
 

    ##Read in MCMC output files for population level parameters####
	data <- read.table(subjFile,col.names= c("iter","npulse","mpmass","mpwidth","base","hl"),fill=T)

    path <- paste(graphSummaryLocation , "/IndSummary.out",sep ='')

     allall<-NULL

    	mean<-round(mean(data$npulse[burnin:length(data[,1])]),2)
    	var<-round(var(data$npulse[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$npulse[burnin:length(data[,1])],c(0.05,0.95)),2)
	     allall<-cbind("Number of pulses",mean,var,t(quant)) 
  
    	mean<-round(mean(data$mpmass[burnin:length(data[,1])]),2)
    	var<-round(var(data$mpmass[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$mpmass[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Mean Pulse Mass",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
                          
     	mean<-round(mean(data$mpwidth[burnin:length(data[,1])]),2)
    	var<-round(var(data$mpwidth[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$mpwidth[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Mean Pulse Width",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
 
    	mean<-round(mean(data$base[burnin:length(data[,1])]),2)
    	var<-round(var(data$base[burnin:length(data[,1])]),3)
    	quant<-round(quantile(data$base[burnin:length(data[,1])],c(0.05,0.95)),2)
        alltemp<-cbind("Baseline",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
               
     	mean<-round(mean(data$hl[burnin:length(data[,1])]),2)
    	var<-round(var(data$hl[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$hl[burnin:length(data[,1])],c(0.05,0.95)),2)
        alltemp<-cbind("HL",mean,var,t(quant))
        allall<-rbind(allall,alltemp)
        
        allall<-as.data.frame(allall)
        measurenames=c("Parameter","mean","var","5%","95%")

        names(allall)<-measurenames

        write.table(allall,file = path ,quote=F,row.names=F,col.names=T,sep="\t")
}


args <- commandArgs(TRUE)
burnin <- as.double(args[1])
subjFile <- args[2]
graphLocation <- args[3]
generateSummaryFile(burnin,subjFile,graphLocation)
