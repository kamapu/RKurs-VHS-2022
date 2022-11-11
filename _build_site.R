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

# Downloads
Files <- c("installieren.pdf", "Referenzen.pdf")
file.copy(from = file.path("../../vhs-bonn/bonn-2022-r-intro/downloads/",
        Files), to = "static/documents", overwrite = TRUE)

# Build the page
build_site(build_rmd = TRUE)
## serve_site()
## stop_server()

# Commit changes
Files <- list.files(recursive = TRUE, full.names = TRUE)
add(path = Files)
commit(message = "Commit from git2r")
## push() # TODO: Wise way to add credentials
