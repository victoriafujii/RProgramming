library("dplyr")

pollutantmean <- function(directory,pollutant, id = 1:332){
  
  fileslist <- list.files(directory)
  datafinal <- data.frame(matrix(ncol=4, nrow=0))
  colnames(datafinal) <- c("Date", "sulfate", "nitrate", "ID")
  
  for(i in 1:length(id)){
    data <- read.csv(fileslist[id[i]])
    datafinal <- rbind(datafinal, data)
  }
  
  if(pollutant == "sulfate"){
    colpollutant <- datafinal$sulfate
  } else{
    colpollutant <- datafinal$nitrate
  }
  
  colpollutant_cleaned <- colpollutant[!is.na(colpollutant)]
  meanvalue <- mean(colpollutant_cleaned)
  
  return(meanvalue)
}


pollutant_mean <- pollutantmean(getwd(),"sulfate", c(1,2,3))



