# downloadOSMTiles
An R Script that lets a user download OpenStreetMap tiles to their device. I decided to create this because I could not find anything suitable to use with a Mac and R.
#Usage
`downloadOSMTiles(outputdir,minzoom,maxzoom,maxlat,minlat,maxlon,minlon)`
##Parameters
* **outputdir:** Specify a destination folder to download the tile directory. If the directory doesn't exist, the function creates it. Paths start at the ~/ directory.
* **minzoom:** The minimum zoom level to download tiles. Please bear in mind that OpenStreetMap will not let you download tiles at zoom levels above 16, because they are not ready rendered. See [this link](http://wiki.openstreetmap.org/wiki/Tile_usage_policy) for more information about this. Please also note that for large zoom levels, there may be many tiles, and therefore the downloads could take a long time.
* **maxzoom:** The highest desired zoom level.
* **maxlat,minlat,maxlon,minlon:** WGS84 coordinates (i.e., latitude and longitude decimals) that specify a bounding box for desired tiles. If this bounding box is very large, the downloads will take a very long time for high zoom levels.
##Example usage
`downloadOSMTiles("Desktop/Liverpool",zoomlow = 13,zoomhigh=14,maxlat=53.5,minlat=53.3,maxlon=-2.8,minlon=-3.1)`
The above example takes about 100 seconds to complete the download of street level OSM tiles for a bounding box that approximates the area surrounding Liverpool, UK.

