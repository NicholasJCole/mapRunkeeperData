############# map runkeeper data ##############

library(ggmap)
library(plotKML)

# get all gpx files within a folder, make sure workding directory is set to correct file
files = dir(pattern = "\\.gpx")

# loop through all files and add to data frame
# this may take a while, depending on how many files there are
for (n in 1:length(files)) {
  route <- readGPX(files[n])
  locations <- route$tracks
  lat <- locations[[1]][[1]][2]
  lon <- locations[[1]][[1]][1]
  coords <- data.frame(lon,lat)
  # if first gpx file then create data frame
  if (n==1) {
    all_coords <- coords
  } else {
    all_coords <- merge(coords, all_coords, all.x = TRUE, all.y = TRUE)
  }
}

# make google map, centered on knox street, deciding where to center takes trial and error
map <- qmap('3201 Knox St, Dallas, TX 75205', zoom = 12)

# plot map and gps points
# can adjust size and alpha, size determines size of points and alpha determines transparency of points
map + geom_point(aes(x=lon, y=lat), data = all_coords, col = "red", size = 2, alpha = 1/80)
