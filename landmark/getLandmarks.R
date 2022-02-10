readLand <- function(filepath){
	coordata <- read.csv(filepath,header = F,stringsAsFactors = F)
    coorx <- c()
    coory <- c()
    for(i in 1:nrow(coordata)){
        tmpx <- strsplit(coordata[i,1],split="[[]")[[1]][2]
        coorx <- c(coorx,tmpx)
        tmpy <- strsplit(coordata[i,2],split = "[]]")[[1]][1]
        coory <- c(coory,tmpy)
    }
    newdata <- as.data.frame(cbind(coorx,coory))
    newdata$coorx <- as.numeric(as.character(newdata$coorx))
    newdata$coory <- as.numeric(as.character(newdata$coory))
    return(newdata)
}





