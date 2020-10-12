library("dplyr")

pollutantmean <- function(directory,pollutant, id = 1:332){
  
  fileslist <- list.files(directory)
  datafinal <- data.frame(matrix(ncol=4, nrow=0))
  colnames(datafinal) <- c("Date", "sulfate", "nitrate", "ID")
  
  for(i in 1:length(id)){
    path <- paste(directory, fileslist[id[i]], sep = "")
    data <- read.csv(path)
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

files_folder <- "/home/victoria/Documentos/R/RProgramming/RProgramming/files_spec/"
pollutant_mean <- pollutantmean(files_folder,"sulfate", c(1,2,3))

