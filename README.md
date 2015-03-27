# downloadOSMTiles
An R Script that lets a user download OpenStreetMap tiles to their device. I decided to create this because I use a Mac and R a lot, and there did not appear to be a similar facility that I could use easily.
#Usage
`downloadOSMTiles(outputdir,minzoom,maxzoom,maxlat,minlat,maxlon,minlon)`
##Parameters
* **outputdir:** Specify a destination folder to download the tile directory. If the directory doesn't exist, the function creates it. Paths start at the ~/ directory.
* **minzoom:** The minimum zoom level to download tiles. Please bear in mind that OpenStreetMap will not let you download tiles at zoom levels above 16, because they are not ready rendered. See [this post](http://wiki.openstreetmap.org/wiki/Tile_usage_policy). Please also note that for large zoom levels, there may be many tiles, and therefore the downloads could take a long time.
* **maxzoom:** The highest desired zoom level.
* **maxlat,minlat,maxlon,minlon:** WGS84 coordinates (i.e., latitude and longitude decimals) that specify a bounding box for desired tiles. If this bounding box is very large, the downloads will take a very long time for high zoom levels.


