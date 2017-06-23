###########################################################
#Creates trace plots for the population level parameters
#Creates trace plots for individual level parameters as selected by the user

#Creates summary tables of population level parameters
#Creates summary tables of individual level parameters as selected by the user

#Creates fitted value plots as requested by the user

#Creates observed data plots as requested by the user
##################################################################



####CODE FOR MAKING OUTPUT TABLES#####

####CODE FOR MAKING OUTPUT TABLES#####

 generatePopSummaryFile <- function(burnin,commonFile,graphSummaryLocation){
     ##Read in MCMC output files for population level parameters####
	data <- read.table(commonFile,col.names= c("iter","mpmass","mpwidth","popsigmaa","popsigmaw","sigmaa","sigmaw","base",  "hl", "popsigmab","popsigmahl", "evar"),fill=T)

    path <- paste(graphSummaryLocation , "/PopSummary.out",sep ='')

     allall<-NULL

  
    	mean<-round(mean(data$mpmass[burnin:length(data[,1])]),2)
    	var<-round(var(data$mpmass[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$mpmass[burnin:length(data[,1])],c(0.05,0.95)),2)
	     allall<-cbind("Pop. Mean Pulse Mass",mean,var,t(quant)) 
                 
        mean<-round(mean(data$popsigmaa[burnin:length(data[,1])]),2)
    	var<-round(var(data$popsigmaa[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$popsigmaa[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Pop. Pulse Mass SD",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
                 
                 
        mean<-round(mean(data$sigmaa[burnin:length(data[,1])]),2)
    	var<-round(var(data$sigmaa[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$sigmaa[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Ind. Pulse Mass SD",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
        
     	mean<-round(mean(data$mpwidth[burnin:length(data[,1])]),2)
    	var<-round(var(data$mpwidth[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$mpwidth[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Pop. Mean Pulse Width",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
 
         mean<-round(mean(data$popsigmaw[burnin:length(data[,1])]),2)
    	var<-round(var(data$popsigmaw[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$popsigmaw[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Pop. Pulse Width SD",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
                 
                 
        mean<-round(mean(data$sigmaw[burnin:length(data[,1])]),2)
    	var<-round(var(data$sigmaw[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$sigmaw[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Ind. Pulse Width SD",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
        
    	mean<-round(mean(data$base[burnin:length(data[,1])]),2)
    	var<-round(var(data$base[burnin:length(data[,1])]),3)
    	quant<-round(quantile(data$base[burnin:length(data[,1])],c(0.05,0.95)),2)
        alltemp<-cbind("Baseline",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
        
        mean<-round(mean(data$popsigmab[burnin:length(data[,1])]),2)
    	var<-round(var(data$popsigmab[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$popsigmab[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Pop. Baseline SD",mean,var,t(quant)) 
        allall<-rbind(allall,alltemp)
        
     	mean<-round(mean(data$hl[burnin:length(data[,1])]),2)
    	var<-round(var(data$hl[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$hl[burnin:length(data[,1])],c(0.05,0.95)),2)
    alltemp<-cbind("HL",mean,var,t(quant))
        allall<-rbind(allall,alltemp)
        
        mean<-round(mean(data$popsigmahl[burnin:length(data[,1])]),2)
    	var<-round(var(data$popsigmahl[burnin:length(data[,1])]),2)
    	quant<-round(quantile(data$popsigmahl[burnin:length(data[,1])],c(0.05,0.95)),2)
	     alltemp<-cbind("Pop. HalflifeSD",mean,var,t(quant)) 
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
graphLocation <- args[3]
generatePopSummaryFile(burnin,commonFile,graphLocation)

