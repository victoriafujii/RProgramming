library("dplyr")

complete <- function(directory, id=1:332){
  fileslist <- list.files(directory)
  datafinal <- data.frame(matrix(ncol=4, nrow=0))
  colnames(datafinal) <- c("Date", "sulfate", "nitrate", "ID")
  
  for(i in 1:length(id)){
    path <- paste(directory, fileslist[id[i]], sep = "")
    data <- read.csv(path)
    datafinal <- rbind(datafinal, data)
  }
  df<-datafinal[complete.cases(datafinal), ]
  df <- df %>% group_by(ID) %>% summarise(number = n())
  
}

files_folder <- "/home/victoria/Documentos/R/RProgramming/RProgramming/files_spec/"
df <- complete(files_folder,1:10)
