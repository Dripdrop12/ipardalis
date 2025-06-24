require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "tana",
  birth = "2023-10-09",
  sex = "female",
  tags = c("tana", "jimanga", "capella", "kintana", "manga"),
  filial = "F4-CG15",
  primary_img = "img/ambilobe/tana/tana2",
  sire = list(
    name = "jimanga",
    loc = ""
  ),
  dam = list(
    name = "kintana",
    loc = ""
  )
)
