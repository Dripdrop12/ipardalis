require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "Sugar",
  birth = "2023-06-01",
  sex = "female",
  tags = c("mara", "zandrin", "nugget", "sammy"),
  filial = "F4-CG15",
  sire = list(
    name = "Zandrin",
    loc = ""
  ),
  dam = list(
    name = "Mara",
    loc = ""
  )
)
