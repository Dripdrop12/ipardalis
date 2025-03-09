require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "bear",
  birth = "2023-12-27",
  sex = "male",
  tags = c("bear", "ghost", "tsara", "arti", "manjaka"),
  filial = "F3-CG15",
  primary_img = "img/ambilobe/bear/bear4",
  sire = list(
    name = "ghost",
    loc = ""
  ),
  dam = list(
    name = "tsara",
    loc = ""
  )
)
