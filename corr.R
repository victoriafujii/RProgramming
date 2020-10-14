library("dplyr")

corr <- function(directory, threshold=0){
  fileslist <- list.files(directory)
  datafinal <- data.frame(matrix(ncol=4, nrow=0))
  colnames(datafinal) <- c("Date", "sulfate", "nitrate", "ID")
  
  for(i in 1:length(fileslist)){
    path <- paste(directory, fileslist[i], sep = "")
    data <- read.csv(path)
    datafinal <- rbind(datafinal, data)
  }
  
  df<-datafinal[complete.cases(datafinal), ]
  complete_cases <- df %>% group_by(ID) %>% summarise(number = n())
  df2 <- merge(df,complete_cases, by="ID")
  df3 <- filter(df2, number>=threshold)
  df4 <- df3 %>% group_by(ID) %>% summarise(correlation = cor(sulfate, nitrate))
  
  if(length(df4)==0){
    return(c(0))
  }
  else{
    return(df4)
  }
}

directory <- "/home/victoria/Documentos/R/RProgramming/RProgramming/files_spec/"
df <- corr(directory,5000)
