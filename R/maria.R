require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "Maria",
  birth = "2024-05-29",
  sex = "female",
  tags = c("maria", "alamo", "blue bonnet", "titan", "remi"),
  filial = "F1-CG6",
  primary_img = "img/ambanja/maria/maria3",
  sire = list(
    name = "alamo",
    loc = "readysrainforest.md"
  ),
  dam = list(
    name = "blue bonnet",
    loc = "readysrainforest.md"
  )
)
