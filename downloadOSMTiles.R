###R Code to download OSM tiles for specified bounding box and zoom levels###
deg2x<-function(lat_deg, lon_deg, zoom){
  lat_rad <- lat_deg * pi /180
  n <- 2.0 ^ zoom
  xtile <- floor((lon_deg + 180.0) / 360.0 * n)
  ytile = floor((1.0 - log(tan(lat_rad) + (1 / cos(lat_rad))) / pi) / 2.0 * n)
  return(xtile)
  
}
deg2y<-function(lat_deg, lon_deg, zoom){
  lat_rad <- lat_deg * pi /180
  n <- 2.0 ^ zoom
  xtile <- floor((lon_deg + 180.0) / 360.0 * n)
  ytile = floor((1.0 - log(tan(lat_rad) + (1 / cos(lat_rad))) / pi) / 2.0 * n)
  return(ytile)
  
}
downloadOSMTiles<-function(outputdir,zoomlow=NA,zoomhigh=NA,maxlat=NA,minlat=NA,maxlon=NA,minlon=NA){
  if(is.na(zoomlow)||is.na(zoomhigh)||!is.numeric(zoomhigh)||!is.numeric(zoomlow)){
   cat("Please enter valid integers for the zoom range") 
   return
  }
  if((maxlat>=85)||(minlat<=-85)||(maxlon>175)||(minlon<=-175)){
    cat("Please specify bounding box values within the following range: \n Latitude : -85 < 85 \n Longitude -175 < 175")
  }
  else{
  if(is.numeric(zoomlow)&&is.numeric(zoomhigh)){
  zoomrange = c(zoomlow:zoomhigh)
  rangelength = zoomhigh-zoomlow
  }
  #check lat long values to make sure they are in possible ranges
#create sub-directories for each specified zoom level
  dir.create(path=paste("~/",outputdir,sep=""),showWarnings=F)
  for(i in 1:length(zoomrange)){
  
  dir.create(path=(paste("~/",outputdir,"/",as.character(zoomrange[i]),sep="")),showWarnings=F)
  }
  if(!is.na(maxlat)&&!is.na(minlat)&&!is.na(maxlon)&&!is.na(minlon)){
  #for each zoom level, calculate ranges for x and y
  xranges = list()
  yranges = list()
for(i in 1:length(zoomrange)){
xvals =c()
    xvals=c(xvals,deg2x(maxlat,maxlon,zoomrange[i]))
xvals=c(xvals,deg2x(maxlat,minlon,zoomrange[i]))
xvals=c(xvals,deg2x(minlat,minlon,zoomrange[i]))
xvals=c(xvals,deg2x(minlat,maxlon,zoomrange[i]))
  yvals=c()
  yvals=c(yvals,deg2y(maxlat,maxlon,zoomrange[i]))
yvals=c(yvals,deg2y(maxlat,minlon,zoomrange[i]))
yvals=c(yvals,deg2y(minlat,minlon,zoomrange[i]))
yvals=c(yvals,deg2y(minlat,maxlon,zoomrange[i]))
xranges[[i]]=c(min(xvals):max(xvals))
yranges[[i]]=c(min(yvals):max(yvals))
}
#create sub-directories

for(j in 1:length(xranges)){
for(k in 1:length(xranges[[j]])){
  dir.create(paste("~/",outputdir,"/",as.character(zoomrange[j]),"/",xranges[[j]][k],sep=""),showWarnings=F)
}
}
#form download URLs
downloadpaths = c()
for(j in 1:length(zoomrange)){
  for(k in 1:length(xranges[[j]])){
    for(l in 1:length(yranges[[j]])){
    downloadpaths=c(downloadpaths,paste("http://a.tile.openstreetmap.org/",as.character(zoomrange[j]),"/",xranges[[j]][k],"/",yranges[[j]][l],".png",sep=""))
  }
  }
}
#form desination URLs
filepaths = c()
for(i in 1:length(downloadpaths)){
  filepaths[i]=substr(downloadpaths[i],32,nchar(downloadpaths[i]))
}
#download files
for(i in 1:length(filepaths)){
  download.file(url=downloadpaths[i],destfile=paste("~/",outputdir,filepaths[i],sep=""),quiet=TRUE)
}
}
else{
  cat("Please supply bounding box values!")
}
}
}