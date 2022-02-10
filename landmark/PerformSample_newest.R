###Please change the input and output path and the suffix of input image.
imgpath = "your directory/landmark/input folder"
outpath = "your directory/landmark/output folder"
workpath = "your directory/landmark"
imgsuffix <- ".JPG"
Sys.time()
###readLand <- function(filepath)
setwd(workpath)
source("getLandmarks.R")
imgfiles <- list.files(imgpath,pattern=imgsuffix)
idlist <- c()
for(i in 1:length(imgfiles)){
    imgname <- strsplit(imgfiles[i],split=imgsuffix)[[1]][1]
    idlist <- c(idlist,imgname)
}
write.table(idlist,file=paste(outpath,"/fileIDlist.txt",sep=""),row.names=F,quote=F)
setwd(workpath)
finalresult <- c()
for(img in imgfiles){
    system(paste("cd ",workpath,sep=""))
	imgNam <- strsplit(img,split=imgsuffix)[[1]][1]
	tmp2 <- paste("./demo5 ",imgpath,"/",img,sep="")
	system(tmp2)
	Sys.sleep(5)
	come1 <- paste(workpath,"/output-num_chg1.png",sep="")
	go1 <- paste(outpath,"/",imgNam,"_point.png",sep="")
	file.copy(come1,go1)
	come2 <- paste(workpath,"/output-num_chg2.png",sep="")
	go2 <- paste(outpath,"/",imgNam,"_num.png",sep="")
	file.copy(come2,go2)
	come3 <- paste(workpath,"/landmarks.txt",sep="")
	go3 <- paste(outpath,"/",imgNam,"_landmarks.txt",sep="")
    file.copy(come3,go3)
    come4 <- paste(workpath,"/output-raw.png",sep="")
    go4 <- paste(outpath,"/",imgNam,"_eng5raw.png",sep="")
    file.copy(come4,go4)
    finalresult <- rbind(finalresult,readLand(go3))
}
write.table(finalresult,file=paste(outpath,"/All_Sample_ladnmarks.txt",sep=""),row.names=F,quote=F)
Sys.time()