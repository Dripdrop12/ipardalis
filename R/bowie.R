require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "Bowie",
  birth = "2024-05-29",
  sex = "male",
  tags = c("bowie", "alamo", "blue bonnet", "titan", "remi"),
  filial = "F1-CG6",
  primary_img = "img/ambanja/bowie/bowie11",
  sire = list(
    name = "alamo",
    loc = "readysrainforest.md"
  ),
  dam = list(
    name = "blue bonnet",
    loc = "readysrainforest.md"
  )
)
