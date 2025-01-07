require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "lamba",
  birth = "2023-08-03",
  sex = "female",
  tags = c("lamba", "zozoro", "artilly", "arti", "gold-rush"),
  filial = "F4-CG14",
  sire = list(
    name = "zozoro",
    loc = ""
  ),
  dam = list(
    name = "artilly",
    loc = ""
  )
)
