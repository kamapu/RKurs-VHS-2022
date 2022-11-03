# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(blogdown)
library(zip)
library("git2r")

# Produce data set
Files <- list.files("../../vhs-bonn/bonn-2022-r-intro/data/", full.names = TRUE)
Files[!grepl(".log", Files, fixed = TRUE)]
unlink("static/documents/KursDateien.zip")
zip("static/documents/KursDateien.zip", Files, mode = "cherry-pick")

# Build the page
build_site(build_rmd = TRUE)
## serve_site()
## stop_server()

# Commit changes
Files <- list.files(recursive = TRUE, full.names = TRUE)
add(path = Files)
commit(message = "Commit from git2r")
## push() # TODO: Wise way to add credentials


#### ############################### ###########################################


site_repo <- "../../github/RKurs-VHS-2022"

# Render downloads
wd <- "downloads"
Files <- list.files(wd, ".Rmd", full.names = TRUE)

for(i in Files)
  render(i)

# Move to the course page
Files <- list.files(wd, ".pdf", full.names = TRUE)

for(i in Files)
  file.copy(i, file.path(site_repo, "static/documents/"),
      overwrite = TRUE)

# Render Folien
wd <- "Folien"
Files <- list.files(wd, ".Rmd", full.names = TRUE)

for(i in Files)
  render(i)

# Move to the course page
Files <- list.files(wd, ".pdf", full.names = TRUE)

for(i in Files)
  file.copy(i, file.path(site_repo, "static/documents/"),
      overwrite = TRUE)

# Build page
current_wd <- getwd()
setwd(site_repo)

build_site()

# TODO: We need to use .Rprofile from the package

# Commit
Files <- list.files(recursive = TRUE, full.names = TRUE)
add(path = Files)
commit(message = "Commit from git2r")
push() # TODO: Wise way to add credentials

setwd(current_wd)
